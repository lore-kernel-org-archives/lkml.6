Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8A9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A064A20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fx6spAfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A064A20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeGQLU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:20:57 -0400
Received: from mail-eopbgr30063.outbound.protection.outlook.com ([40.107.3.63]:5088
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729717AbeGQLU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2twIyIymUTnu8/xFmQwZFEpn0DEblFnqWmfwGqmmK0=;
 b=Fx6spAfBjUMk7gHtl3at6u4OLJYw3hTEuALH7q7qJgB5buM97TrfrVxIzsDKWYuNoF+PNaV/5t+TetX1K+3jGsGQLkbgpsv7UfUV4Qxwoxb1etxB4TZtuZhBu3YdvWq6lEeUcA1n176wZUBGwmoFAgKWeHjdh2hssagX63Lw9rs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4303.eurprd04.prod.outlook.com (2603:10a6:803:3f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Tue, 17 Jul 2018 10:48:52 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Date:   Tue, 17 Jul 2018 13:48:31 +0300
Message-Id: <f873c5592e9907beba905ce68358d5ae2f63a4d7.1531824173.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::36) To VI1PR04MB4303.eurprd04.prod.outlook.com
 (2603:10a6:803:3f::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ddf3674-116d-436b-4ebb-08d5ebd2e37e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4303;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;3:mAPymEfMFoAFFBqAbyRUi8apfyy255SzyFzkfgRvds0fxG21FBUEwlxdRtvGzqhzpFcdAuFgVzAhLtzr/r8hQTrB6Dv2Ib7QoPYt+FHM/5nrkVxDYaOAzJ3gs/UTohSHURmzh+Z91LzaiMCj2LUKPhqor7dBo+3fJ8QuMhwECWTEIsVet0T+9TyjcZCor1f1xHLKms/2htP2beUrW/pfqW08OlP7pZyPLJQhUeoVVC3IbrhsrvqPHH8KK1U3iOkC;25:7oTRoLxTsy4KekokKkpNm0uY581VbnN7q8WD1aA4HqxI4isAybJ3fZsCX+jt7yQmVhUK4cEEktTQc++aRdOb3tQEIiCr8JZ346SYyxYjYdVrinvJyZ+u3bL9gKmwt9tdcXZjKZvut3brffeSpqsv/+IKq2BaAUQlvMq64sgk0NekwzelvCsU68dBMj+zNoVSJmb7f4pq+M8Two6JX1dV+p4S2vY7vhSsSIQNuvbtq3Akpau4PL1BWuvPUxj4D2lGRFk5gIRY9eUVsjAGIt0CxHGIMPDWHyl7Ot6ffcTZr1ekkxjP520B1tKVO8QJjvw8qyT184jYaeFe9YHpDudrUw==;31:KMUj9+7v2ZddlVVNC5bo7ATzDVqkFznzmwOYuPMqgzl86g5UY8DodxRG4EbsjPBINkxd1aIPXOyvpN2uVEPZkOdeh7F3t+VLGFmJ64dapb+dOUEz6jwVW8uYtWH3odB2CHE8n3iZfxtg5fwwymXc/gxnwIosamL0EHMGwfjeMpN6h3OT6XYMKSjtU7M74+H618qocEeV4x6toOc5lYnnMgsFOGAeNoHURsBaZh/jnDU=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4303:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;20:7cUQTyCTho5nTlyLhf/HH6gYBhQHYUTOfhHtMrxdW2P0HuM9iNUyKIFoCCWgkMugjvt8ICKxvBQasnqx3hrnU+4fc1B7FZgF/0kegFOnENAbBJ699jOwlxNjtHq2N4OXtH9Ga7rFLPMxXRAGFbai8TuwC5nJn+6BLaYxc3sxYLnrm0IENbpC1jJXUz+UVjuIC8zYJQ2TBE2YseLtnQfBXxrczbVvvSlxzKQcMrvqQob8LWB4tiSHtdQDMncIlFmWh1WPygXwYd/TzM4zNPkRUibJcQ1UZTNRI+eYXcS9RpBC48C5YDtDvoy1hvaRufNUSFvCWbXSneWj80HN+9C7qx5dc7vEIOY9j3SFNAg0AxZEZelea+UaksBKU7QgU+zy7Qj1pZA1VteajkIv1maTGbLnBWkeToiDzJDldpuMfVPaIGWGxNIyrQlKLDqzGvMzQzq5ZQAtRtP5zlYYZaSSZD7ZfIPpN3QMYwk9f4wfr88SsO2T4O+vi3ozNEYSerE1;4:PAN3JhBCT0ibdyOJo6dCrqZsRhBreusU3a5qPRNylObMrgKKbJpNSx5wiTR0x1Xq1/ldcN2AV5jHY2gKuJGwEgadGV8uUzVaoUYRkBB7w4Nu+l/qFGpHtXA2CdLAAi51bzgyNmbbMfhs26KaiZ4/xuy92Z9MhyOmQAuCswBfBYJjoeVRQpH14elvXQF5rKJi/vTxODzOn+r3q6v1Qz9u7wGCxw0+JxBO5oDWEn9nGs6e4cOm2m4RhMbO9lh8vTfXK7nMIex8ZV5ZeiYW8mvXuff3RufBUj45B1SEZx/9uJtLRX3QGBDH6XyTHskSoNl6
X-Microsoft-Antispam-PRVS: <VI1PR04MB4303EE716AF4476EED3BCC2FEE5C0@VI1PR04MB4303.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4303;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4303;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6069001)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(51416003)(305945005)(476003)(8936002)(44832011)(956004)(110136005)(14444005)(47776003)(16586007)(486006)(7736002)(54906003)(6666003)(2616005)(52116002)(81156014)(5660300001)(8676002)(386003)(6506007)(316002)(81166006)(68736007)(118296001)(66066001)(50226002)(97736004)(6512007)(2906002)(26005)(105586002)(25786009)(4326008)(48376002)(6486002)(50466002)(53936002)(966005)(186003)(86362001)(6306002)(3846002)(6116002)(106356001)(478600001)(36756003)(16526019)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4303;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4303;23:s6fTyfD1dZee5wmshjwuoTP/QKokLx9SF0t/54Y7g?=
 =?us-ascii?Q?9Xnkyzw38Lj7bsIpkKoJg//KNy+bTYo4k+p9oH61E/kXK3Tyx1FZgInhlCfp?=
 =?us-ascii?Q?/wjCAPfT+oLdHGSzTRGPlQwfL8fMOkcfV/vtZob8PLIyU9oNoscJMGwUvHvt?=
 =?us-ascii?Q?hM+6X9BHUIaZWuIH08RFMoTlDbZKMF9YWGRFT1NK2NLM5kHKmf+ajveoT75H?=
 =?us-ascii?Q?ztL66wwnwymOQZNXrH7OPkpXxTQDIBg4DelTtikBjAdiIhkvlhvgiWiFMP+Y?=
 =?us-ascii?Q?2HEj7TP1WoiKJ2JLpLE8uWkP8v9C5dnihqKPLEhcCgaCUUx0+VL+IkYpK0zI?=
 =?us-ascii?Q?16m4fV5Enb3x9PH/m5ByEGR4S7LYrtlkx+FjY/61a8YLhgN0/exODVXFfEK8?=
 =?us-ascii?Q?T5jEtNSK7Oz5w7mt4aGsprJv/NqO1c0kKDuId6mybA5ZO+lJ6V576FdJqeFr?=
 =?us-ascii?Q?KI8va9j1xEI2QDwdiiljEXm2xQlk9jmc2bsiieWtJ7AnJVnb5kKsWo8WfzlN?=
 =?us-ascii?Q?GwKEcBmLwOVRDVmPMbsneajit11Ijgubtn+El9+I6B42t79ad0KtOeF7Ow1J?=
 =?us-ascii?Q?TCUqhvippIjS/4lb9Lnbb5xUksH0Y4aOC2y/bQTrBowyfY1Op3VNkOyNZmBl?=
 =?us-ascii?Q?z5xCuz+YI53WfUnlw9UimyFcemcAzL8wyUDnYu4B/j5SfMTRD5zerkmaOqX6?=
 =?us-ascii?Q?t0LiluP6p4eSK7h6b0j6knZSixk7YBSIAynS8/c3MwiDdYj2TRJDo2aW7YdT?=
 =?us-ascii?Q?CpLVbdwrgG7eVZCzw9PY8Myxhfm1065ifoQbbcfxvImCnmwQ8Q4bf9oZ8xHp?=
 =?us-ascii?Q?6TyivmoDDUOITeWp0nZYrF8lPhHDd1HtUTFh8XdRRpNxAN2OLedPW2Y936A5?=
 =?us-ascii?Q?JaGBVcDXQiAANoebdgcmtFK/3nTMhm0NtDEiYZxCxbIJQhbqDAsRW5dFMLwT?=
 =?us-ascii?Q?/CEzNhW1yfgj60rd4UAkwUiQcHAQc4m9Yu4YkT+13gtQneSPaF6IRguju5kr?=
 =?us-ascii?Q?0gGHXEj2Rcph81MnbHI/PBkZ58fKkzGVTvk6RIGOgw3oBR2m0Zp0e1EGLJcK?=
 =?us-ascii?Q?z5MFedJsSDgpA2ePiuI3+3U9SYM7V9Y76uj3O2z4KWcc0cstm0T2NRMpqGKE?=
 =?us-ascii?Q?E+wIeyxrcC8o6/tO7lKowqn939jflXZsuCvo51CI7aJXmmxcb+GWy9clALbr?=
 =?us-ascii?Q?/bhU90ah0gWt1qjSNYhwz9AW52wFBaGW2JBWn9AidpMH7bJJ1p5gmxTLmwbq?=
 =?us-ascii?Q?ICxW7VFXuSk18Ecc2A9ZdaBitK9tVtX86DY1qWV6LF9PLGwU44uatG1shXCM?=
 =?us-ascii?Q?kadAmY82oS/rNz8C4NiiY3alhzH8DT6igk0ZcjUYL5nHoIH4WzTE/pE1MPjH?=
 =?us-ascii?Q?QAHGg=3D=3D?=
X-Microsoft-Antispam-Message-Info: iBGyY+HceC2VxOmbYOu6QnvWff60lKjodqQN5IoRz8pAJmB0AIYrP+a3CXhffo9uhaSjVAUEMoUQsiymX0o6iqhTq6uUIW3plu8NY/RzVnJFwwJ19dqCwrxOIt7TBozTcNbO6ujPp5VfILSUj1uJj0wNc+MSJxrn6QsSVRrk4NWFpi0YU5yBFP4TpDCpUFVp/29NxJkKmmQe/8LQ7wxG8ogyg+LDs+7Sufo68TquIOOmcMkof2sMYycHtZ+2Y993fwlSllkxYHibz9EjagbaCCB68XNBZeXU6XtHbBLl+ovDEBbBsZeSHIS8cPDyEld2yli+zcXk2GL2bBVDMuxGFpeCX/TcP8tu0xMWcj6xv1U=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;6:/n7tHc6x58F/6jvxdTc9ys8m4pOVTp+pNlJbhLfQ8RG0vX+vL+2zIpfRz+mlKHyTS/getUAGuol86hcPodUF6wFnvQPNa6xzNjVNy3LwDMFPSy//a03ZyMAimOXQXCUw+vfhE6698vXh1k7ADAdEuMiEPfDDxNykn2QD4BrVNIQF3+ZQdTrNGr3x0ro06RWEWeD9Rmxt1OMPPZYb4gXf5B8/HG90ihMnzyJrISj7l6tn6/jtkMVZ1w1WRaAiWrMNrCmDz4XpPc29f3QMmmZRafdT/3CQx6qHcpPcoSowl3DWTIVyMUy7fEF4mFh6JN/Y8+nWBsanZxBHhKaNSIK6YDvuCvDFussjJ+aiZPQ5Qiy7LDJobOQfDjdUyWHeGw3jIme56GKydB7YPk+gMbIiUu5rqKHg8zLNJ6XWGWSIxX9n5I+eAwfaUS+3kEyD2lj1OFOe2bnhnxlJmWmDTLvARA==;5:agIxj6otr4Djl69dC1Z0LF6PTwVRrzq3MRfcSHsmz+kER6iTpJ+Y7sbbYNqlGJkPlYKaAeBsT8zFGftBngZHg6lUA551bouUCl43zb/26bxwgQMKYRR+4LX98n0mw2PZ/0rCvsK+5HkncWaomUo5fQxIq310pMc9LIaCOaeAxl0=;24:GKbjlHNkZHetHK4ZEwWDL6ECy1AYBVh/wqKT01U8ddj0iSvvDe8S2DVPrsqF6+vUztLowx8i7qn3595eJZgjhyLeMBGkicIPhQUWEr5iUU0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;7:uVQNMBU0QIH/lk5b7qjOqkv6hFw0uGdPFmyioyLV/KqQyCOkKiE2sI9s8Wwcz4p1o1xcu0mCGOaJG5RyH6t1jQDDsXm4n1bjYZSI/SQ1NcxMVOlEFkC7hsQGmy0n8QyOIE+tW6xjwdn4xWF10Sx3ucPN5/Oj/NM8zQYl1hUvXG7pY7W+vPDUNdFO4x+i0LkyHXPQCyjsX4OE1NPIe6/nMmxbMBIH7JwU2dgxP3Dv5XdwwBhdH1DVeu8RYTZ6yMLw
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 10:48:52.6408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddf3674-116d-436b-4ebb-08d5ebd2e37e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4303
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding lcdif nodes to a power domain currently does work, it results in
black/corrupted screens or hangs. While the driver does enable runtime
pm it does not deal correctly with the block being unpowered.

Ensure power is on when required by adding pm_runtime_get/put_sync to
mxsfb_pipe_enable/disable.

Since power is lost on suspend implement PM_SLEEP_OPS using
drm_mode_config_helper_suspend/resume.

The mxsfb_plane_atomic_update function can get called before
mxsfb_pipe_enable while the block is not yet powered. When this happens
the write to LCDIF_NEXT_BUF is lost causing corrupt display on unblank
until a refresh.

Fix this by not writing gem->paddr if the block is not enabled and
instead delaying the write until the next mxsfb_crtc_mode_set_nofb call.
At that point also update cur_buf to avoid an initial corrupt frame
after resume.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---

The purpose of this patch is to prepare for enabling power gating on
DISPLAY power domains.

Changes since v1:
* Drop mxsfb_runtime_suspend/mxsfb_runtime_resume, calling
pm_runtime_get/put in pipe enable/disable is enough.
* Use drm_mode_config_helper_suspend/resume instead of attempting to
track state manually.
* Don't touch NEXT_BUF if atomic_update called with crtc disabled
* Also update CUR_BUF on enable, this avoids initial corrupt frames.

Previous discussion: https://lkml.org/lkml/2018/7/17/329
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 51 +++++++++++++++++++++++-------
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 25 +++++++++++++++
 drivers/gpu/drm/mxsfb/mxsfb_drv.h  |  2 ++
 3 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index 0abe77675b76..10153da77c40 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -194,15 +194,31 @@ static int mxsfb_reset_block(void __iomem *reset_addr)
 		return ret;
 
 	return clear_poll_bit(reset_addr, MODULE_CLKGATE);
 }
 
+static dma_addr_t mxsfb_get_fb_paddr(struct mxsfb_drm_private *mxsfb)
+{
+	struct drm_framebuffer *fb = mxsfb->pipe.plane.state->fb;
+	struct drm_gem_cma_object *gem;
+
+	if (!fb)
+		return 0;
+
+	gem = drm_fb_cma_get_gem_obj(fb, 0);
+	if (!gem)
+		return 0;
+
+	return gem->paddr;
+}
+
 static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 {
 	struct drm_display_mode *m = &mxsfb->pipe.crtc.state->adjusted_mode;
 	const u32 bus_flags = mxsfb->connector.display_info.bus_flags;
 	u32 vdctrl0, vsync_pulse_len, hsync_pulse_len;
+	dma_addr_t paddr;
 	int err;
 
 	/*
 	 * It seems, you can't re-program the controller if it is still
 	 * running. This may lead to shifted pictures (FIFO issue?), so
@@ -268,35 +284,47 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 	       mxsfb->base + LCDC_VDCTRL3);
 
 	writel(SET_DOTCLK_H_VALID_DATA_CNT(m->hdisplay),
 	       mxsfb->base + LCDC_VDCTRL4);
 
+	/* Update cur_buf as well to avoid an initial corrupt frame */
+	paddr = mxsfb_get_fb_paddr(mxsfb);
+	if (paddr) {
+		writel(paddr, mxsfb->base + mxsfb->devdata->cur_buf);
+		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
+	}
 	mxsfb_disable_axi_clk(mxsfb);
 }
 
 void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 {
+	if (mxsfb->enabled)
+		return;
+
 	mxsfb_crtc_mode_set_nofb(mxsfb);
 	mxsfb_enable_controller(mxsfb);
+
+	mxsfb->enabled = true;
 }
 
 void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
 {
+	if (!mxsfb->enabled)
+		return;
+
 	mxsfb_disable_controller(mxsfb);
+
+	mxsfb->enabled = false;
 }
 
 void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 			       struct drm_plane_state *state)
 {
 	struct drm_simple_display_pipe *pipe = &mxsfb->pipe;
 	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_framebuffer *fb = pipe->plane.state->fb;
 	struct drm_pending_vblank_event *event;
-	struct drm_gem_cma_object *gem;
-
-	if (!crtc)
-		return;
+	dma_addr_t paddr;
 
 	spin_lock_irq(&crtc->dev->event_lock);
 	event = crtc->state->event;
 	if (event) {
 		crtc->state->event = NULL;
@@ -307,14 +335,15 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 			drm_crtc_send_vblank_event(crtc, event);
 		}
 	}
 	spin_unlock_irq(&crtc->dev->event_lock);
 
-	if (!fb)
+	if (!mxsfb->enabled)
 		return;
 
-	gem = drm_fb_cma_get_gem_obj(fb, 0);
-
-	mxsfb_enable_axi_clk(mxsfb);
-	writel(gem->paddr, mxsfb->base + mxsfb->devdata->next_buf);
-	mxsfb_disable_axi_clk(mxsfb);
+	paddr = mxsfb_get_fb_paddr(mxsfb);
+	if (paddr) {
+		mxsfb_enable_axi_clk(mxsfb);
+		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
+		mxsfb_disable_axi_clk(mxsfb);
+	}
 }
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index dd1dd58e4956..a5269fccbed9 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -101,23 +101,27 @@ static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
 static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
 			      struct drm_crtc_state *crtc_state,
 			      struct drm_plane_state *plane_state)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
+	struct drm_device *drm = pipe->plane.dev;
 
+	pm_runtime_get_sync(drm->dev);
 	drm_panel_prepare(mxsfb->panel);
 	mxsfb_crtc_enable(mxsfb);
 	drm_panel_enable(mxsfb->panel);
 }
 
 static void mxsfb_pipe_disable(struct drm_simple_display_pipe *pipe)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
+	struct drm_device *drm = pipe->plane.dev;
 
 	drm_panel_disable(mxsfb->panel);
 	mxsfb_crtc_disable(mxsfb);
 	drm_panel_unprepare(mxsfb->panel);
+	pm_runtime_put_sync(drm->dev);
 }
 
 static void mxsfb_pipe_update(struct drm_simple_display_pipe *pipe,
 			      struct drm_plane_state *plane_state)
 {
@@ -412,17 +416,38 @@ static int mxsfb_remove(struct platform_device *pdev)
 	drm_dev_unref(drm);
 
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int mxsfb_suspend(struct device *dev)
+{
+       struct drm_device *drm = dev_get_drvdata(dev);
+
+       return drm_mode_config_helper_suspend(drm);
+}
+
+static int mxsfb_resume(struct device *dev)
+{
+       struct drm_device *drm = dev_get_drvdata(dev);
+
+       return drm_mode_config_helper_resume(drm);
+}
+#endif
+
+static const struct dev_pm_ops mxsfb_pm_ops = {
+       SET_SYSTEM_SLEEP_PM_OPS(mxsfb_suspend, mxsfb_resume)
+};
+
 static struct platform_driver mxsfb_platform_driver = {
 	.probe		= mxsfb_probe,
 	.remove		= mxsfb_remove,
 	.id_table	= mxsfb_devtype,
 	.driver	= {
 		.name		= "mxsfb-drm",
 		.of_match_table	= mxsfb_dt_ids,
+		.pm		= &mxsfb_pm_ops,
 	},
 };
 
 module_platform_driver(mxsfb_platform_driver);
 
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
index 5d0883fc805b..e539d4b05c48 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -36,10 +36,12 @@ struct mxsfb_drm_private {
 
 	struct drm_simple_display_pipe	pipe;
 	struct drm_connector		connector;
 	struct drm_panel		*panel;
 	struct drm_fbdev_cma		*fbdev;
+
+	bool enabled;
 };
 
 int mxsfb_setup_crtc(struct drm_device *dev);
 int mxsfb_create_output(struct drm_device *dev);
 
-- 
2.17.1

