Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C43C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421C6208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F4YoIiBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421C6208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeH0O5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:57:31 -0400
Received: from mail-he1eur01on0047.outbound.protection.outlook.com ([104.47.0.47]:51613
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726994AbeH0O5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZMbrbTCJrsmTfLND9qkbaNvCURQg0xkYrepOv0UU4E=;
 b=F4YoIiBp2sGiu5U6M4ckfyzOtdcE/z1j3ejsFOS7ydgGw3CCr6Oeht3oQ0epnMnp2+LqgDSSoIQgDXFO1kMrtEeVh+5/bpdCdkVyany8jmwqn0OMSeDENNISmSFLLGuBNHH/DRj+NcpDAobomNN5uRXJ6LwCIsalGR4ptjc451M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 DB7PR04MB4297.eurprd04.prod.outlook.com (2603:10a6:5:28::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Mon, 27 Aug 2018 11:11:05 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Marek Vasut <marex@denx.de>, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Stefan Agner <stefan@agner.ch>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Robert Chiras <robert.chiras@nxp.com>,
        Marco Franchi <marco.franchi@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND 1/5] drm/mxsfb: Move axi clk enable/disable to crtc enable/disable
Date:   Mon, 27 Aug 2018 14:10:37 +0300
Message-Id: <58ec6338ada7fd46af99675dc1268d31d2a15464.1535367027.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535367027.git.leonard.crestez@nxp.com>
References: <cover.1535367027.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR0802CA0012.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::22) To DB7PR04MB4297.eurprd04.prod.outlook.com
 (2603:10a6:5:28::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0db51431-4cd3-48d4-3668-08d60c0dc92e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4297;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;3:eBpJq82PL8aUmSOi1VsoXBqqByiB7lcctbL4ntHf7eriR+na7c9Mr0RZjg6QRgAPtLD940G3YwzyDrO063qkLSX6IbxLW5IrkMA/i2YfZ4kbP1oDKQrcbCllaz5dIqld/MCrSqA96Ddhr/HY+50xBk53qHFqeaBehDkjK3fUcEYS5gRvDzFF6afe46+9DfaQgvesGATnviCP0TrlOSE6fbM/Kqu4xr5oErRGDLnFn72Am83APU21LrYxYuTITYBI;25:AlgsR9chPeXZW3Z/eOfjEdEJxGO9AuV6phCoX5lFctmKETIU3qQ5r3WFZXy8lK661Hgvfh8WSJ1QBu07Zy7j36pU+kgX5U7subEy0E2h3q16oRe16E7KXLsLGLpMYQbJLAhtg9vRmiKGWLnk60ps87V/EkwEtJ0W+68LmTHNMsb/Owix6JPLoXOEMzfX6g14l2MFqYemBXIefucT3c5NnE0IFSCbyyGuxiz8/xzjZM3wYQ3oaXxmLB8+1bV8E00d7x023GnGnpaC3zIWjI40XgYN6Zw3pftMSgCtObnx4t08ZnHbcyBZtunTi6O5bHWzNhiQxJK+73pmnEIewJiN2g==;31:yp1pMMoD7maSdemWi1yuiVQq/dRCuxes5vCjJG6HUY95C8ehfqMDIYb7y1Ul73nYlt90aU11AYKhZjLW98fqANwXUAErpou3Q9mqlSRFUM9iIwUQhJyY2tBb8wMYh7SqOMpd/iUCWEV1Q7BrfL/O4Ebrbo5VcbbtkNQXI7/zBK+/w2rzDof/hgKATD6kWnRv9VEaH1Ml3SB/VcTP0foijgk1HIX8Yp5SRa5+QzPJtpk=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4297:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;20:Z/MkPdrEth05110iWQmH5TrFokPXzxmayUev2b/uy3+5b3G2k9jkQI51C1XEVjWxlQbDFzpfoyU2Qy9yuf9i4AnoSAEFWGUSjVpX77Ar7w7iayhQi32fXmRUtXCf5b+nRwM/fCCITn89pwzHIIlg4Bx8h4IQMivHtf2ZxhtVg0q3YARFasENJYFfcanYbScHFSxallsze8zOhmogiVJ4r0NDv3noouutpXx0FQj+L4xX2o9XUCassxeZvdp+9Nqi8jcSMwwSglWTOWxnxQSXW4f1k9+S0cr9527SnKG3WWk6TPfbGmlGdko2UQ2w8G+IRZU4GGNt0FqMMVaKIbAKzecJoXoX2lZUgWtJRlcom8WH4QH6LctX1+O1aQxen861ig3n6PMD8XyFkZBoAYzXYtQ3gKdXkYCL4+iFGMSXYrWAfoB1wpghXFLWLIhZJ+PPXNCmTxBF8yy9HaUrfARF88djgtA2OEdLTzx1Fhd3cOMeo8ltxuXhDq8GrKEmQBEf;4:7tYFhCJem04DcIyScV+GVoR0a6SDH1K+ATf24EFmGzxRRLyVp47VMiJukFAvi1+ZRUjGniA386l8F5lJrmbugNsuiA7/9NLQHe2omleoJMGol5EMn+AI1otMHvLbn9YOZvkobb1cI6PRL2t2THzotvabJUS6Nn/Y/9ALvQR3ph2l4iDPbeuIg9OZc9Oc1lkSOnfGr6KRb7765gsmJqx+21Ce0nMiYHE0dP5MyoDmoaJWI5hHGlto+p32pjkOeBsbsVRtr+M1UzUYJQh84CzVULqD/ehr07lud/sHOYz/KCur9UyJifdf4fyhYr2RDTY+
X-Microsoft-Antispam-PRVS: <DB7PR04MB4297DA1AE30CB8C9F17FCB9DEE0B0@DB7PR04MB4297.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB7PR04MB4297;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4297;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(4326008)(305945005)(478600001)(6666003)(2906002)(36756003)(446003)(476003)(2616005)(956004)(81166006)(8676002)(81156014)(14444005)(44832011)(7736002)(486006)(11346002)(3846002)(6116002)(47776003)(6486002)(66066001)(97736004)(86362001)(54906003)(5660300001)(53936002)(6512007)(16586007)(110136005)(316002)(50466002)(48376002)(50226002)(118296001)(105586002)(8936002)(106356001)(51416003)(186003)(26005)(52116002)(16526019)(6506007)(386003)(68736007)(25786009)(76176011)(69590400005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4297;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4297;23:KkB6YByZJxXF+5WyJ7fVQtKc7zQNi7C8SqP4f/EH1?=
 =?us-ascii?Q?TxJCBHS455uukEDiq4bJHjBTFjgE1arD7d5xv37ahHQ0m7VbtKgu/DKNaQ9w?=
 =?us-ascii?Q?xKbvHvPqD9nBMgN2GTf16KjwjI4yctJwc/SybcsM1l6fQKEL09kpk9DmXQml?=
 =?us-ascii?Q?HK9BiO58t2EXjj7OMQwwzNA6V8l8XHoKHijSzlK2EECN01cR6WNPpvvvdxNn?=
 =?us-ascii?Q?3/Axqb0+QPeAcGrF85J50Kn8ApTNlxoL/gUA6eNA4GswmSax6C7A15rqrfTQ?=
 =?us-ascii?Q?CR+kXubfYti92R906ANvLu5T7seNAYAnfRjAVEpieikjXbyo01+hqAOemI2x?=
 =?us-ascii?Q?VNXzMxZOmWijnj0LVeCw7inFePUSfjLw6vFCilMrkb9Nrbv+uPJDWQpn2TYP?=
 =?us-ascii?Q?wMk36XiFQvYjw4lwP7agStOMYdQ8imtohTVAxW/JF5LKfolQkTpbZ8A49O3P?=
 =?us-ascii?Q?7PzNKmo0qb3lUm6LFCuiPCDMqjXDi0L6G3tXt6F4MhZ1SXWTU+8mB4bIQA8r?=
 =?us-ascii?Q?s/nh2MubVRBJG8sSLFsFUGDYXI1QHF/YEydD/6LME67jNPBGKo7lvztgBGHy?=
 =?us-ascii?Q?FMGaCmV1ZvSiAdgVaEWwl4m0qJXrMZDyggRLpdL2cBBt78Y8fYC5LQ+xLgn3?=
 =?us-ascii?Q?Yj3mQh2Lr0x5RoNkwxvaY87znoKMFUg/avqlLJD6E6JZ/CGfDTCDVEZE6GKD?=
 =?us-ascii?Q?6rXEKLWDjxJ7egr3Wc/pBOqJTnsNxwWlcxYGSNZOavFVdFGHdIZvv+DJ7Wjn?=
 =?us-ascii?Q?avyTH6K/kxBa/WtXH/0oKRVUW3MRnnRcsreXkBbsqVm67rZ+jJEzOCnXl/sS?=
 =?us-ascii?Q?6wd4BN4ov6LELnTDlcJMdl406GlnaOQ42gEbk5jKmI50TnwjZ0K7ef9ts2x1?=
 =?us-ascii?Q?Hzfr6wYLrV9j7DHweFSqhPqp5G/SRJXnMEcNOUf14r5taa2r1AfQveXTEaSA?=
 =?us-ascii?Q?9owu/BPOHrafL9vEmhmMJFk8zrEOmp702Z54m1xvQaeVfBQAW7dBwUwK0ekL?=
 =?us-ascii?Q?5gtSlaWk5xpLVdZir/Z07rFH5OLZi513Z547yPpv4S6A6Qk962XH7kmU9aBz?=
 =?us-ascii?Q?c7VGOvff3ljmzKpwFwhrh8YqoDwM5FrlMtsTOUWzYR5/rovn1Ln8mOwlCK9Q?=
 =?us-ascii?Q?P8y1L6dFCeVZzk8EAKT8S6/yaoqGdT06hxTu+1vBJsDG6e2btbSBGnMgXffQ?=
 =?us-ascii?Q?5UBeKfVG2gTO39yr4o9+I/vtjT8ZEhdhuoYQD/cPOQW4HT63SXZocx7sccH8?=
 =?us-ascii?Q?2J6nNCMytqYXlI1RV2Z2aNaVImO4lXjJqEinv95A44R4E8cHj8jsfnButYUj?=
 =?us-ascii?Q?cYug2F7nTlizZ8fjDUPDhI=3D?=
X-Microsoft-Antispam-Message-Info: Np5Yd4CJv04GgOuYo0iNDHGzmkVMD5BjbsXJ051pgbgvh0x5nQnoyyYHKprSPJsvUIvZNV+eULDrROhn7WZKgA8oQWMGVDaieYpb/qKimwRDCvlUGgU9VSY1cHc3w2HwEbTkI3voPc5An4T7vQaY4KYfjN4UBii/o1MZiytVubyQ/I6BAVFWiS7hteAHd0+IXGywyZwLMM3OhsYFR7C9ULAgScLmv0GaJiFaXB0+j5JF4IMiTSoIJ4CzPo5m6DR9FeDyF9hqcLFLN+rNxssjSLBAThnonBH44Lza4GbVGHGjYTQAoRy8Dl2j6Kuu0fPnXgjlVYaIcgOTj2jo6WKT1AT43Wm++qIJX3pnGDv/vgM=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;6:Jxlu4NcmzCtNxvNhLMefty2w8tECzALAArLn+f3T7dwVpeOBEC/TwmS7uU7Tdgixf4tint4GyyzYyMj6Uz4oprtMH+ZaaHmUy+mHPoI2a9ApMbXFmyumle57YUalhmtGfDzx8nfSo6gYPB6D3dfgX6kwlEvtUZz7aUM1c7U3f095j6g9dLI9oU+wRDUBFMa/LxPhpjAAjWZGOF1W2B4i3cXaPYWf8hVuC8TMKISX0g0X7vtlxQWVOH3o0yYZAdQIkxpYMu1FzJZF6tzcyNIWRR0z/T9mM/ZjQmh9M4J32UCDlcFCKkZtpoE89/YEWnkKIRjlB8mlX2TOzAb5cjTnBcZyY1RSA/fg4FRsV11H1c1azdBO5THtCFAdZqH9VAIJL5XMXs4xwOrUH/37b6FOv3b7VAt6Sj1VJF4k+9ddvD15Per/szgTv/M1/5qncdZjaEM6sGQNZqTZgIDhy+u/0A==;5:LILE6nQyPe9+zq6+TGm8lcKabGYct8iJxam/Ht1P/fUzV6xfYTLpl8dPC2LqyiKKLjAlEO+wKzNpTZpYbD2vbl3yh36iZ7t3veawgxYWZzaWUHUQm78OGHEeWbZikU4ytwTPmX2lZrnjMmn+i7GbhgA1Ami5y4qPCnRc9r4DI34=;7:LQ8pbYCP8njZb9yqv+Fq5+rlgaL224jmpgXVGxUFCHkjzGfV6CinMiVVwhjGZOS0V6doyiSC+AFpj7oa3oWklkdJbDTx+v476E/zM1gOAukHUm8orImGnx1SydPFVBucsnN4S+fzMM6aERYJhg589CzjkBT///Zesn1RTG8te1DCRfkI/IyrFa8OzPU7x4iFz8EuuWRyAjiOn0sdcRlch/nYsf4ceNLI2Yd/x5hum6SyUDmUvh0kF4p5hnmdtGqJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 11:11:05.0988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db51431-4cd3-48d4-3668-08d60c0dc92e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4297
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main axi clk is disabled at the end of mxsfb_crtc_mode_set_nofb and
immediately reenabled in mxsfb_enable_controller.

Avoid this by moving the handling of axi clk one level up to
mxsfb_crtc_enable. Do the same for mxsfb_crtc_disable for symmetry.

This shouldn't have any functional effect.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index 0abe77675b76..e4fcbb65b969 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -127,11 +127,10 @@ static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
 	u32 reg;
 
 	if (mxsfb->clk_disp_axi)
 		clk_prepare_enable(mxsfb->clk_disp_axi);
 	clk_prepare_enable(mxsfb->clk);
-	mxsfb_enable_axi_clk(mxsfb);
 
 	/* If it was disabled, re-enable the mode again */
 	writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
 
 	/* Enable the SYNC signals first, then the DMA engine */
@@ -157,12 +156,10 @@ static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
 
 	reg = readl(mxsfb->base + LCDC_VDCTRL4);
 	reg &= ~VDCTRL4_SYNC_SIGNALS_ON;
 	writel(reg, mxsfb->base + LCDC_VDCTRL4);
 
-	mxsfb_disable_axi_clk(mxsfb);
-
 	clk_disable_unprepare(mxsfb->clk);
 	if (mxsfb->clk_disp_axi)
 		clk_disable_unprepare(mxsfb->clk_disp_axi);
 }
 
@@ -206,11 +203,10 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 	/*
 	 * It seems, you can't re-program the controller if it is still
 	 * running. This may lead to shifted pictures (FIFO issue?), so
 	 * first stop the controller and drain its FIFOs.
 	 */
-	mxsfb_enable_axi_clk(mxsfb);
 
 	/* Mandatory eLCDIF reset as per the Reference Manual */
 	err = mxsfb_reset_block(mxsfb->base);
 	if (err)
 		return;
@@ -267,23 +263,23 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 	       SET_VERT_WAIT_CNT(m->crtc_vtotal - m->crtc_vsync_start),
 	       mxsfb->base + LCDC_VDCTRL3);
 
 	writel(SET_DOTCLK_H_VALID_DATA_CNT(m->hdisplay),
 	       mxsfb->base + LCDC_VDCTRL4);
-
-	mxsfb_disable_axi_clk(mxsfb);
 }
 
 void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 {
+	mxsfb_enable_axi_clk(mxsfb);
 	mxsfb_crtc_mode_set_nofb(mxsfb);
 	mxsfb_enable_controller(mxsfb);
 }
 
 void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
 {
 	mxsfb_disable_controller(mxsfb);
+	mxsfb_disable_axi_clk(mxsfb);
 }
 
 void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 			       struct drm_plane_state *state)
 {
-- 
2.17.1

