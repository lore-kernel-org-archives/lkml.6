Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E1AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BBB217DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b9yGtpFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BBB217DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeHUW4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 18:56:46 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:19905
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726627AbeHUW4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 18:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pumFnIca1E+WP9IR2FYCq52ilKHC2cAkp6z1qstwpjU=;
 b=b9yGtpFMl/IPC/NmnexRmeQRjRt/GiZcJU+XTDZtlYhjkQajK80dNZupipQ6k+S1T4srlcKFUkxYngu+4VT/Us/bn/u/rBSEU4EcWUvOsBgMxank3ZWW2ASTFCh1XuiZ2pHT4CQ4aXfgMCj9Y1x7qbDm3AKmIKBHY1Y1fUtTyg4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Tue, 21 Aug 2018 19:35:09 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Liu Ying <victor.liu@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [RFC] clk: imx6: Mark imx_clk_mux as glitchy by default
Date:   Tue, 21 Aug 2018 22:34:48 +0300
Message-Id: <e56c6f0acfe7afb885d2cb67e1e069f7edd0d2d7.1534879459.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0901CA0108.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::34) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c2f96d4-f174-4394-43f2-08d6079d3529
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:HZu6bpRCh9L+O6J69NZ9EZLObu/FzhylPcUoR39lNpA1xJRHk+J5yz3eoW5DIWHW5SajOuSgOKLTTwZFS90lMBUrsrhLY/l68OuqArbOjmK7jVZ/hxK8t4zcUGHUQCTGV0LgkECXvooSTZkKZtP7jU2/uCcDZMbHOGYPrrBlgWBgrE3khpILjmPk52l8kWk/y7I9JGe0s0UF9iKsu9YHWSQ/5QO64vtS3SghNi+IXGUah5OJpcE2Gemaj/AyahDw;25:wAYbGMkGjADBqc4zMQxmj0vp2XmNCAxPrf85OUnGXaNWTVS+oJxoQOBc8FfNRQIN+yDKKeljkQgR7QWMZlOU0X26jNB0xWpSRBdl0AvhZWtlBaCAf/Z7rdvH5AvNDLWaInYfyb9XeQ8W9s3jTvPiSs8KoydviAvgTbzeQ9k644ub6oTvaK8u/JVAkTb0WKMbGhtnlKyDQYZCpiuubJiZ8Juq3SamEM8xwfvTlXlP19DhiDOj3uOjMFhwts9YNcAY0/AmGOY/Htttvg1T0i67Ee20hrajq4mKClqFxqhTPda4l9vnHNwUJnK8blD7cJ1Gm0UrFsy2Su+3lHa1CUWw7g==;31:nnv1/lhQJhAKTicucNMtjCE0d+2tp+vcXwqsHjtI2s4I+09XuHCOsarmGN/KSJkdhMzAh1W3Op/rSoBIKWwsXjwN76aaBaJtGzPRDZT2awFai4tO/xXXLPe5wiIT9Og0+kLs7hfvkAIAtgQz/D4I26wlYsAXqKVIQGbKOAjht16oEEzm5PhZnmqOb7C8R2M6bFPZEPrLJdnrDZc6cKWUIhNorhDS4/6Gi7qmBSMGIf0=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:lleOM6hT4C5lqMbwvQtxnwIH3m7tA0rSxIrctoQfz11eo4Nb5TRsoyecl0/qR33eoaIt33wKGPHuq7oBI05mCg+w8ouyltdMl3a19lRVHg5RRPA++VkAdC4GeOfslBW7DWd1mDzJ2nGWY/9609eU/0VnYHSWkEnPLUpk3fiL7MNy1Kgd3r8BMgSLLKgd5PxBnROo3NmcE4a6o5h0FmA/xWrhgdM+S9iL0g8Yhrk2dQfuw2WZq11eeT0e0Z3bhk/NIPkLb5/yKyeMqpuF8i7JV4/a69XOZPz8PC1e3xE6vFkYNdqIFwXlPLeF1XwuA8hUiDyQRkcvlYc48ItBOT2tEcAFw5yKeo+hp+UGc851JGgZuPOVFd3a8K2GIlAKEJ7ZqTYBt8/rN+yI4np26T5iXuED1qy3grdmpLwelbaxip7wYY7f4zwLT5TZcR+Vc5SEaLXcpICx+cFXn1aVgu5p12k7NXx+O+D9lo5NjncXutFzlJO8wDL3WnxHdzmApgf4;4:675xvslCA1ePmNvMB9LFcsoZvg1OMnYGXqZ617DTPIHUhPfgha1GRunVRKMVybfF+/RHuuqawjFUzvg5tnQn24FMvN0GDIgxyQ7l2tq/TTWaxrZ81QHZC6bmF2tGDvzUW87S6RA2iC+sMO3u61c7br8nGucyNWycFAX2J3zWA3hzaaBczwFCUmrM3oOgXWOdWH1ViPQk3ootvsXQfwwsvoMm117YNVyvXfDhkPGeOGTNVvC0NwzBadI1mUGatqWSxWNWut5bSh1k6oEhKs8O9eYjtYAlj79gwlAMwygfRw0in9fJXB6mp2KH1VtO6uBP9W7OCV5XxpE4dTN9w2HfWIsoiiAUGo7ladEqafAVRSk=
X-Microsoft-Antispam-PRVS: <AM0PR04MB42903508030C5E6EDE1FF341EE310@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(48376002)(476003)(386003)(4326008)(478600001)(50466002)(36756003)(106356001)(6506007)(25786009)(97736004)(6666003)(3846002)(6512007)(956004)(6486002)(186003)(16526019)(7416002)(51416003)(6116002)(105586002)(53936002)(6636002)(2616005)(486006)(5660300001)(66066001)(110136005)(575784001)(86362001)(54906003)(8676002)(81166006)(50226002)(47776003)(44832011)(7736002)(2906002)(14444005)(305945005)(8936002)(52116002)(316002)(118296001)(81156014)(16586007)(68736007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:UnxRMtxUyK4pgiM47g7VzEnT2eVwDoRYLsrgN+VLn?=
 =?us-ascii?Q?oovV+EHyEPc7vZrdzbEmvB+RwsLZ0tFmCrHT0fdQaPf7Jmfca3CphluUiNP3?=
 =?us-ascii?Q?AX8ssDCZT0/vJCQvYeSyJJ188ovCyE/vl5W7Jrz3xz9LLmCX7m7pxiBhMg3r?=
 =?us-ascii?Q?JnUBAvrara43rQwTpFnj5v876fBbU4U1DuKAKiaKZdC6pXocTxWRUaeuRI4E?=
 =?us-ascii?Q?t8/yatHdZ259RNeIZC5lusktFh8CrJRK0qisiTafq3tHkW47aXFYaWz5/we5?=
 =?us-ascii?Q?8wp8sjt63YUBmLXP9kxBT/qgY90R3rtO+lVumDmTTlYyUM+asM0YHzEh/l6b?=
 =?us-ascii?Q?zld0zGF8uJFZTcSmbKWxnNHeRgIZln0pMd5KsEaWM8uYCYQBwbaTx6/oTC4v?=
 =?us-ascii?Q?6eq3Gm18u51QOdOEzUxAygQjwxJek2CGQ4GCwS/V5zddR/bNj5pHP6Ue+Qzi?=
 =?us-ascii?Q?C2JzBiO7AWj9a8cNzfnjw0Ilm9ZDnhwldriNSrKuQMttOxOqu4NO2OdJPc5k?=
 =?us-ascii?Q?wkr0nuA8PYXRRFGCDZ0plErT+ERvEvzX6ure1mZHqB6P75rnTSiak2aU9ZHC?=
 =?us-ascii?Q?dEG0ttd16BOHVd90BI4yO8NLNzUntHSDPOTy36A5vlmOsstbvAJGLkdBsjPz?=
 =?us-ascii?Q?MeQBqlaLIYuXAfxL2N54uHi3IDHZqPWtjne7kCGm/7fF1aCyj7iEhd2V+qdC?=
 =?us-ascii?Q?0rSb4/kXTRQ3KeHlYBkG7zfvjZ4ED/nZtjKE3j6ARtdRiJpI2hIucUcpfSup?=
 =?us-ascii?Q?SbEUSnonP8prRiw7aDo1VpGv+Ph9TzB6LH59CD5iGr5R9Rp6E7nMg+thpONb?=
 =?us-ascii?Q?8h+5fgrjpOZcyEBiMCLeevXeJqwQEPCGJt5txVs9DKE+QNGgWwwIGJ7xWCcU?=
 =?us-ascii?Q?RQ3B+/sAy0MFDu3EwKep1Ajt67Si/Ld7BOGx+S6b1MIzPvNlByt4hfwo/HpV?=
 =?us-ascii?Q?HJzv8NgCuuB3GWIoEKKV6aYJ+Ex7QfLyVkggh6URslroDEa294RirsxcJ52e?=
 =?us-ascii?Q?95GD6n7HqL0TviuA/vH109eOJax1HYqXyV7IQxiGg7DcRGstZKYaxdUImFPb?=
 =?us-ascii?Q?hRrK5Msxsy3PTTEQ3LnhHytiGI4yUufdR2+zC7hciyanPTJ4moh9+kTEtEA8?=
 =?us-ascii?Q?JGmDUvQyduHASMI9GLuQuYtQGSAQesXJKMgabRrm1vJN5RF4dJU7bkaDu+Wl?=
 =?us-ascii?Q?u0kVuWSzcYfcBdRxB+e1/asYffoxLNv+vAoHCVjEua139/cq4BS4fr5h4uc8?=
 =?us-ascii?Q?IUiGJHPt/hcpwhVeNLQddOmuC6JArvS0FINVpI7?=
X-Microsoft-Antispam-Message-Info: oLbgoJM0Mdw0H821gbGjmHohWnJ8+D8slMZRtdOqsMOJIE/x5OPt60jwUztvaGxG3RpIAW9hkWea0C9zlDgemRkmGFXQnkPxeeIqUK89s0DVB7LUF3gYd996YmpnEK7ElThJXaZNUYJB5+F1TmetMJzIQooYcatESz+zXfa9r3YlNeBzbPDPEyf2GFUrX7K+x9MOSHdHOekoy9Fw5JTgncZyPQJGCE2Eah/eoCdtun1QRtpMWfRzzZ/dR2juCPy4fOpUgciA07GtSgVMF1B7WGOdctM6ot6gRusIRUhsHBUrJHVNy/9hnjvK5sHUCVhOS6P/bC9z/J6Y5juxqYdHuGGCldDpSRglFV9TJvwR53I=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:RWQ+aJct+PdWrQTwAV4JAaVCvrwxUHYhNxgzkOqaIzyvaPofEUs0xN0G7EQ2ca0Zt6/BxEF1P50E/SM1GrbpDaUhPUZL/a2/CKq6N4Nlb9SarKEQfpx8+Y8J26KoQXI7fvoVWVQ3BXluuQNW1vxrndvATWpVD/pQUwCYp7fImWrhegMOgcEwbK/lqXLioEll14a8jZraVNn9+uvWgJm7oXL/S8jGK6JlBrz+7wS1Jb1wNUTC4bNsEhUcpEJiker/8+wHinh+WeDyoMLGEgdxTEJTwD/2LkeDba4dV5eYUO64oCx8e04xcg7s0D3x7UalKX4pm4/+gJiQ0Ckf6qV/HUYaEL9sh+RMGh5RgxRPZBy7cows3buyeSpH2H60rvBpbpH/r4AcOHvoQCuPiLVyXfLDXCBKwOJsEfP2HVgEaARKMryqL+rIJrWl0G9Y3mFN7UYCxpNYiqWr9vg1XosYnw==;5:qlcnOF49XVo4b5GRj4HQ/0giojfq5q13fibEf3DfxzRxEyAJDGiEJuYTy0iyGWvIkpBhFSkwI5L13mCdhqUdpw7C4bUkR0dpV/uh7eGWblFL3qn53R1n43H5yjADYRhJFFuU/qXksbDGVZviq0Fx4PgT/CQa5K6FiQ9OAEQnkGg=;7:4gv8EMD/avPzkYvyuiYx67C1wkB6W9Xkw35naqW1LzjEZ8SfsHMD1iNhZ3UD7uth/7PDBhkG2Ot2eCRQP6ExI6lHV/4GWZ33vlioXPwSSnJBwiwLBXhFfxRu/fGinwVAwY/IjsiVt/EVvfIMx/P3QFXuA9umHM7Juu8lEcSptbVPdyx6lxixDcH9cLUJ5rz9yTCLTzyGRuxjJt7e+QUyN8bFf3fiqSrfxBSJS6q37898suvHP3huLu6bohgbnO6v
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 19:35:09.2973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2f96d4-f174-4394-43f2-08d6079d3529
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With some exceptions clk muxes on imx6 are "glitchy": If the output
is not gated before reparenting then high-frequency pulses can occur and
cause unpredictable behavior. Only a very small subset of muxes are
listed as "glitchless" in the reference manual.

Adapt to this by adding the CLK_SET_PARENT_GATE flag by default to
imx_clk_mux. Add imx_clk_mux_glitchless for the muxes listed as
glitchless and which don't already have have custom behavior.

The CLK_SET_PARENT_GATE flags enables a small check inside the clk core
which make clk_set_parent return -EBUSY if the clock is active. Ensuring
outputs are gated prior to calling set_parent is up to the clk
consumers.

The effect of this patch is that drivers which perform unsafe operations
which mostly work will receive errors instead, possibly breaking
functionality.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---

Unfortunately one of the misbehaving drivers is ldb for LVDS display and
it seems to be a real issue: ldb enable/disable does reparenting on an
active clk used by IPU.

The imx_ldb_encoder_disable function will try to change the parent of
clk_sel to what it was before enabling but at this point the crtc
(inside ipu) is still active. With this patch it gets -EBUSY instead.

This happens because the DRM core disables encoders before crtc (and
backwards on enable). This assumption is reasonable, having an "encoder"
feed a clk back into the "crtc" is odd and needs special handling by the
driver.

Perhaps ipu_di_enable/disable should be handled in atomic_commit_tail
instead of at the crtc level?

More concretely on 6qp-sdb blanking the display happens like this:
 * imx_ldb_encoder_disable switches ipu1_di0_sel to ipu1_di0_pre from ldb_di1_podf
 * reparenting to ipu1_di0_pre enables it and its parents up to pll5
 * possibly glitchy muxing
 * ipu_di_disable disables ipu1_di0 (and parents, up to pll5)

---
 drivers/clk/imx/clk-imx6q.c   |  4 ++--
 drivers/clk/imx/clk-imx6sl.c  |  2 +-
 drivers/clk/imx/clk-imx6sll.c |  2 +-
 drivers/clk/imx/clk-imx6sx.c  |  2 +-
 drivers/clk/imx/clk-imx6ul.c  |  2 +-
 drivers/clk/imx/clk.h         | 16 ++++++++++++----
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 8c7c2fcb8d94..0434d943b1bc 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -547,16 +547,16 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 
 	/*                                              name                reg       shift width parent_names     num_parents */
 	clk[IMX6QDL_CLK_STEP]             = imx_clk_mux("step",	            base + 0xc,  8,  1, step_sels,	   ARRAY_SIZE(step_sels));
-	clk[IMX6QDL_CLK_PLL1_SW]          = imx_clk_mux("pll1_sw",	    base + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
+	clk[IMX6QDL_CLK_PLL1_SW]          = imx_clk_mux_glitchless("pll1_sw",           base + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
 	clk[IMX6QDL_CLK_PERIPH_PRE]       = imx_clk_mux("periph_pre",       base + 0x18, 18, 2, periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
 	clk[IMX6QDL_CLK_PERIPH2_PRE]      = imx_clk_mux("periph2_pre",      base + 0x18, 21, 2, periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
 	clk[IMX6QDL_CLK_PERIPH_CLK2_SEL]  = imx_clk_mux("periph_clk2_sel",  base + 0x18, 12, 2, periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
 	clk[IMX6QDL_CLK_PERIPH2_CLK2_SEL] = imx_clk_mux("periph2_clk2_sel", base + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
-	clk[IMX6QDL_CLK_AXI_SEL]          = imx_clk_mux("axi_sel",          base + 0x14, 6,  2, axi_sels,          ARRAY_SIZE(axi_sels));
+	clk[IMX6QDL_CLK_AXI_SEL]          = imx_clk_mux_glitchless("axi_sel",           base + 0x14, 6,  2, axi_sels,          ARRAY_SIZE(axi_sels));
 	clk[IMX6QDL_CLK_ESAI_SEL]         = imx_clk_mux("esai_sel",         base + 0x20, 19, 2, audio_sels,        ARRAY_SIZE(audio_sels));
 	clk[IMX6QDL_CLK_ASRC_SEL]         = imx_clk_mux("asrc_sel",         base + 0x30, 7,  2, audio_sels,        ARRAY_SIZE(audio_sels));
 	clk[IMX6QDL_CLK_SPDIF_SEL]        = imx_clk_mux("spdif_sel",        base + 0x30, 20, 2, audio_sels,        ARRAY_SIZE(audio_sels));
 	if (clk_on_imx6q()) {
 		clk[IMX6QDL_CLK_GPU2D_AXI]        = imx_clk_mux("gpu2d_axi",        base + 0x18, 0,  1, gpu_axi_sels,      ARRAY_SIZE(gpu_axi_sels));
diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index eb6bcbf345a3..0d1aaaafd6f4 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -289,11 +289,11 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	WARN_ON(!base);
 	ccm_base = base;
 
 	/*                                              name                reg       shift width parent_names     num_parents */
 	clks[IMX6SL_CLK_STEP]             = imx_clk_mux("step",             base + 0xc,  8,  1, step_sels,         ARRAY_SIZE(step_sels));
-	clks[IMX6SL_CLK_PLL1_SW]          = imx_clk_mux("pll1_sw",          base + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
+	clks[IMX6SL_CLK_PLL1_SW]          = imx_clk_mux_glitchless("pll1_sw",           base + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
 	clks[IMX6SL_CLK_OCRAM_ALT_SEL]    = imx_clk_mux("ocram_alt_sel",    base + 0x14, 7,  1, ocram_alt_sels,    ARRAY_SIZE(ocram_alt_sels));
 	clks[IMX6SL_CLK_OCRAM_SEL]        = imx_clk_mux("ocram_sel",        base + 0x14, 6,  1, ocram_sels,        ARRAY_SIZE(ocram_sels));
 	clks[IMX6SL_CLK_PRE_PERIPH2_SEL]  = imx_clk_mux("pre_periph2_sel",  base + 0x18, 21, 2, pre_periph_sels,   ARRAY_SIZE(pre_periph_sels));
 	clks[IMX6SL_CLK_PRE_PERIPH_SEL]   = imx_clk_mux("pre_periph_sel",   base + 0x18, 18, 2, pre_periph_sels,   ARRAY_SIZE(pre_periph_sels));
 	clks[IMX6SL_CLK_PERIPH2_CLK2_SEL] = imx_clk_mux("periph2_clk2_sel", base + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 52379ee49aec..83bea3b1a416 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -182,11 +182,11 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 	np = ccm_node;
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 
 	clks[IMX6SLL_CLK_STEP] 	 	  = imx_clk_mux("step", base + 0x0c, 8, 1, step_sels, ARRAY_SIZE(step_sels));
-	clks[IMX6SLL_CLK_PLL1_SW] 	  = imx_clk_mux_flags("pll1_sw",   base + 0x0c, 2,  1, pll1_sw_sels, ARRAY_SIZE(pll1_sw_sels), 0);
+	clks[IMX6SLL_CLK_PLL1_SW] 	  = imx_clk_mux_glitchless("pll1_sw",           base + 0x0c, 2,  1, pll1_sw_sels, ARRAY_SIZE(pll1_sw_sels));
 	clks[IMX6SLL_CLK_AXI_ALT_SEL]	  = imx_clk_mux("axi_alt_sel",	   base + 0x14, 7,  1, axi_alt_sels, ARRAY_SIZE(axi_alt_sels));
 	clks[IMX6SLL_CLK_AXI_SEL] 	  = imx_clk_mux_flags("axi_sel",   base + 0x14, 6,  1, axi_sels, ARRAY_SIZE(axi_sels), 0);
 	clks[IMX6SLL_CLK_PERIPH_PRE]	  = imx_clk_mux("periph_pre",      base + 0x18, 18, 2, periph_pre_sels, ARRAY_SIZE(periph_pre_sels));
 	clks[IMX6SLL_CLK_PERIPH2_PRE]	  = imx_clk_mux("periph2_pre",     base + 0x18, 21, 2, periph2_pre_sels, ARRAY_SIZE(periph2_pre_sels));
 	clks[IMX6SLL_CLK_PERIPH_CLK2_SEL]  = imx_clk_mux("periph_clk2_sel",  base + 0x18, 12, 2, periph_clk2_sels, ARRAY_SIZE(periph_clk2_sels));
diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index d9f2890ffe62..c8f2d5aa8a74 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -265,11 +265,11 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 
 	/*                                                name                reg           shift   width   parent_names       num_parents */
 	clks[IMX6SX_CLK_STEP]               = imx_clk_mux("step",             base + 0xc,   8,      1,      step_sels,         ARRAY_SIZE(step_sels));
-	clks[IMX6SX_CLK_PLL1_SW]            = imx_clk_mux("pll1_sw",          base + 0xc,   2,      1,      pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
+	clks[IMX6SX_CLK_PLL1_SW]            = imx_clk_mux_glitchless("pll1_sw",             base + 0xc,   2,      1,      pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
 	clks[IMX6SX_CLK_OCRAM_SEL]          = imx_clk_mux("ocram_sel",        base + 0x14,  6,      2,      ocram_sels,        ARRAY_SIZE(ocram_sels));
 	clks[IMX6SX_CLK_PERIPH_PRE]         = imx_clk_mux("periph_pre",       base + 0x18,  18,     2,      periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
 	clks[IMX6SX_CLK_PERIPH2_PRE]        = imx_clk_mux("periph2_pre",      base + 0x18,  21,     2,      periph2_pre_sels,   ARRAY_SIZE(periph2_pre_sels));
 	clks[IMX6SX_CLK_PERIPH_CLK2_SEL]    = imx_clk_mux("periph_clk2_sel",  base + 0x18,  12,     2,      periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
 	clks[IMX6SX_CLK_PERIPH2_CLK2_SEL]   = imx_clk_mux("periph2_clk2_sel", base + 0x18,  20,     1,      periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 361b43f9742e..085c35dfd262 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -234,11 +234,11 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 
 	clks[IMX6UL_CA7_SECONDARY_SEL]	  = imx_clk_mux("ca7_secondary_sel", base + 0xc, 3, 1, ca7_secondary_sels, ARRAY_SIZE(ca7_secondary_sels));
 	clks[IMX6UL_CLK_STEP]		  = imx_clk_mux("step", base + 0x0c, 8, 1, step_sels, ARRAY_SIZE(step_sels));
-	clks[IMX6UL_CLK_PLL1_SW]	  = imx_clk_mux_flags("pll1_sw",   base + 0x0c, 2,  1, pll1_sw_sels, ARRAY_SIZE(pll1_sw_sels), 0);
+	clks[IMX6UL_CLK_PLL1_SW]	  = imx_clk_mux_glitchless("pll1_sw",   base + 0x0c, 2,  1, pll1_sw_sels, ARRAY_SIZE(pll1_sw_sels));
 	clks[IMX6UL_CLK_AXI_ALT_SEL]	  = imx_clk_mux("axi_alt_sel",		base + 0x14, 7,  1, axi_alt_sels, ARRAY_SIZE(axi_alt_sels));
 	clks[IMX6UL_CLK_AXI_SEL]	  = imx_clk_mux_flags("axi_sel",	base + 0x14, 6,  1, axi_sels, ARRAY_SIZE(axi_sels), 0);
 	clks[IMX6UL_CLK_PERIPH_PRE]	  = imx_clk_mux("periph_pre",       base + 0x18, 18, 2, periph_pre_sels, ARRAY_SIZE(periph_pre_sels));
 	clks[IMX6UL_CLK_PERIPH2_PRE]	  = imx_clk_mux("periph2_pre",      base + 0x18, 21, 2, periph2_pre_sels, ARRAY_SIZE(periph2_pre_sels));
 	clks[IMX6UL_CLK_PERIPH_CLK2_SEL]  = imx_clk_mux("periph_clk2_sel",  base + 0x18, 12, 2, periph_clk2_sels, ARRAY_SIZE(periph_clk2_sels));
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 8076ec040f37..a28268e81824 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -193,12 +193,12 @@ static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parents, int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			CLK_SET_RATE_NO_REPARENT, reg, shift,
-			width, 0, &imx_ccm_lock);
+			CLK_SET_RATE_NO_REPARENT | CLK_SET_PARENT_GATE,
+			reg, shift, width, 0, &imx_ccm_lock);
 }
 
 static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parents, int num_parents)
 {
@@ -210,12 +210,20 @@ static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
 static inline struct clk *imx_clk_mux_flags(const char *name,
 		void __iomem *reg, u8 shift, u8 width, const char **parents,
 		int num_parents, unsigned long flags)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
-			&imx_ccm_lock);
+			flags | CLK_SET_RATE_NO_REPARENT | CLK_SET_PARENT_GATE,
+			reg, shift, width, 0, &imx_ccm_lock);
+}
+
+static inline struct clk *imx_clk_mux_glitchless(const char *name, void __iomem *reg,
+		u8 shift, u8 width, const char **parents, int num_parents)
+{
+	return clk_register_mux(NULL, name, parents, num_parents,
+			CLK_SET_RATE_NO_REPARENT,
+			reg, shift, width, 0, &imx_ccm_lock);
 }
 
 struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
-- 
2.17.1

