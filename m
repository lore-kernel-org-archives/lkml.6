Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6041C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A0621A12
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qnaUldlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A0621A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeHHS37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:29:59 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:40736
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728030AbeHHS36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9XEnLC/Umi1kHz33tSiL4jPibt+8X2GBY6DUK7+Dz4=;
 b=qnaUldlPoqw/XL9e+9A+cEeC6GMy6UDPP2U0b5xvLCKDiGDivSSpLZU98wOCx8tQXDrtTlLXiruO6GMzYG/UGCnx3jlv04SmlW+bdLwBu4J1kM3FR8AS7XjLVFGN9vO4WN0h53NZ4fY6z5V+4QScGqsDboC2lLn4s7miZcIVwzM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (2603:10a6:803:3f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 16:09:30 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Chiras <robert.chiras@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] drm/mxsfb: Fix initial corrupt frame when activating display
Date:   Wed,  8 Aug 2018 19:08:59 +0300
Message-Id: <056bd70ef7bf4d66d636cf7869a489e8c743aaf3.1533743954.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533743954.git.leonard.crestez@nxp.com>
References: <cover.1533743954.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR02CA0004.eurprd02.prod.outlook.com
 (2603:10a6:6:15::17) To VI1PR04MB4301.eurprd04.prod.outlook.com
 (2603:10a6:803:3f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 737d53ab-a6a2-4911-dfa7-08d5fd49533c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;3:GHqLgIRLZ8yM3HjRDgsGd4mCn2bKIXzTunpZSKp0nxWoY8mm2uYuQFrIgBL85cE2HzLkd+GXT+Tnu6YmCx1dL9WR4MCrhtW/uK1OEaf7UTDUlfN0Cw5KnkEmPXPkSRtz63yuhUPRPBGXb+/U/WvpRUZp9SNDrmaSV+WjFP8HEbCMqCnCl2S7n3P5/qqnCpwIVuCUwiY5dIrhE8MHpPMwzPUGJ0QVeIbzk/LW/oNWoi/U1Xf0ALmw3NqvSmSrZyk9;25:OTyoWBFmP1CDP0TAA1+p/ZpWNMU8xpbbREptaGE+6mg3LgJBwq+nM0xpengoXw/qLBVVUD+ruf9YrhKVjQ/8s4CLeDAewEhvvPAIVcjr3wYpv8+OR8NX3bSvrxeVdZP0CPDu3lx+XG1T/b0ODHeTRLfbkxen/WcPhYpV4pnSyOgY7jYkq8VdjLC6Y+XGahWT5wKJywmnacdLa5oInU6v0vSKHbcfmMnoC8tkhCBEelmCwNSAqnaQEVrVV/8FLCVZP6f0UDlp5gGxP/gFJowMwr87c5DXiiHaoN+uuT/iKb96fNAIjD69fL9j2Yr7UBnmPAR/5SxWIO4N4x9CeZAN9A==;31:dvo+VJUPR+QI7fO/7dwkWZZMHXS90X6/Rq4d2YilJ26zFfH9gsBEAyxUgvW5fBSr/bnmOMLi5zQfWkF0ZkcEqvNGi3wCLdadFx+OzPuLiC+rFMQQYqHI8P0pO5U4CyKXNMNbC6ZsQLAbzEuwBaTGAww5mjika0kbfXPBfWEEiRwsYzd/B+K0Y3SFtb6N0fX4sAq1hjTV9gy1fiILe8qJ3t18GOJKHtu1oS/nkB8Fhyw=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4301:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;20:aFRtHWO4IhsRiz7qZQ3p+69mnAt8AI8I3BRz2RKcYdQxV706+FCkDkvRgKzI12Pv0i5JjfF/MkuF+Geb/jJdwWwrdZu7ekRdiFb+vhEZdhPwMfVMzF5SFWlYDzlRY+RFi22K9UCFWyrU8dZB41Bp9pgsUuIfI9vOZpdDcbed0JS+SRcmCQCc5Nd5Lbn2T3XddWX503GEO8Q93l92W7WKAQ5SslMK5JNUMzhwcKfmF92jnzpqyB5cedDro0FT8Rqq1QJYSw2++kRR1myVlsEQRNUI/qaVAQAieUuYJG6v/8bpjyKmSjGPYoepDIXWCtxvNmOeE2MT6XsU1qwAEVu1tX2a2N8K4TEMQvi2zS62LYCL++8CZw+9nA+YQLr+w7ep7LBfGDq56hNVzHU5Fb09xZUeTHxH1F9yiE2zSVZibF1WZ14KeLrA9tighYaQz1R+9YcupwxayWnr7GYNbDndI/eQahSLlBT1VOW5836mayZcdvQEvdDdjNh8t0kx/Duj;4:SwqgO+yDCqeFaCHZSf1/A2g3lyMUCXXBuADD+soF34jupon+cFhMdTBBWbLe6T7G+mL2wItSQr7uUZ6uY8M3AGCWsZIbkqR2VVpGxZsYiI68u4+Z9D5KW/8IUQguNUrIIFSR8U9mAj+1DUQq9ZeJWse75mKzqvAOoIVfyCnckzgRuOphTtBUA0Eu0FMn19FCz51N2BpRycCCI4ym2FPYCvIjikVrUpCmKMXMh4YbBhGWk3ycWPpjcZ4ty0LFLZU2Sm+pWLU41WVneX/9u4kv5W2o+tXwNdab+Nx1JDoe6iojC7MjQkhRhzZYICF+e/pK
X-Microsoft-Antispam-PRVS: <VI1PR04MB43015D53D51DAEC7F86E073AEE260@VI1PR04MB4301.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4301;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4301;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39850400004)(376002)(396003)(346002)(366004)(136003)(199004)(189003)(66066001)(7736002)(76176011)(47776003)(6512007)(81166006)(68736007)(81156014)(25786009)(8676002)(6666003)(110136005)(54906003)(36756003)(14444005)(305945005)(106356001)(105586002)(53936002)(50466002)(6486002)(97736004)(48376002)(86362001)(4326008)(575784001)(3846002)(5660300001)(26005)(486006)(16526019)(186003)(316002)(2906002)(16586007)(6116002)(6506007)(44832011)(478600001)(8936002)(956004)(11346002)(2616005)(50226002)(386003)(446003)(476003)(51416003)(52116002)(118296001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4301;23:mcnipxJWYD0RphA7Pvbm6dbRq7oxUInNFfz9lif91?=
 =?us-ascii?Q?FZU54zospCZDeYA89PVRT+yQD1FizEM361qLqZdbPo8xjV77eUhUnpDYD6XJ?=
 =?us-ascii?Q?H+C/UmLgp6Y7FB8FMc+9cx6UXUI0rjp8A7PnDRnFXRkwoHB/IxOjM7fiomAe?=
 =?us-ascii?Q?LwaE/3zR/v3jOHUnxCa2UvMAfhnROVaVfHR978n7hRGeAXXSO/iand6p9oZj?=
 =?us-ascii?Q?+Ced6FlOZXaX7PAkujawJVgzzs2ZejcM6CvYng0EBY1iFi79s9NYpB2DCM/T?=
 =?us-ascii?Q?ghMwujPh54Sk7/F2CpCMarFwTqlyw2TLeLITPQ1MUVpYlyATmohpX72AI4O8?=
 =?us-ascii?Q?Pbu50QryY+WWHNMZQ1aqkB/zYnTmhV44W40LDGQs71aE53hufPB63hwtZgpV?=
 =?us-ascii?Q?Dtni2GtqtvPor8gpv3DPbpf3kqP+BANi/xAAqznL1cNGULDD1frYi7Ee06LE?=
 =?us-ascii?Q?009VP3aevnAmLf59M3qvx5vm49NVO7QHcpnNhmj1KREq4SOXMQs7PFRq5QY7?=
 =?us-ascii?Q?DFQ+fKquFgwq7r5o3NSqTcVurCO5v3sJZM4/WyH2kVGzPwLhBg1PqPE0MCJA?=
 =?us-ascii?Q?DrxQoKsWGB4KX/gF/haWEPW4rHRu0Z8hN9qiovxzVEem7C0Achq40LOKQdk1?=
 =?us-ascii?Q?VbsHd8Q/PickDS/eQkiXbacN/8gU4FyqhZ+rUH8gP+AO+ebh1BLTBWq2z6lI?=
 =?us-ascii?Q?SFAoWLBRPwhNfbskssN/e/7KrO6v1/p3Lo0EW6CMHkRJFWf0mam/ve+f6Tnu?=
 =?us-ascii?Q?bfBp800poLaa279aMvWGnplihFFvCq+aQEPhJCQZux69kqUBF688Y1K21t6M?=
 =?us-ascii?Q?WjyyePcqntE/h/b1yCc3cCxrPpoEtNmQmACpMkkMYDMKjDLWQE3GUKBpZnum?=
 =?us-ascii?Q?1IDFbXppd+2znwDNqDBy4V0qwdGUMCC//Q+mosWUopyr3GDy/DYRKHZQQ7/k?=
 =?us-ascii?Q?GOGMLyQiaxbVnYKctrTMDpFeWhiXAp86Oor5zJIf5g3yD3gDtd98RybwkJHY?=
 =?us-ascii?Q?Bn8kZqc5YYPLe5hk8n3wM9T2FRxi8mif03eljTc70ZmgUqn1Ok96uJ/RoL3Z?=
 =?us-ascii?Q?OIA6X7uGAs/poeNUjXx3az8KLRcRO1uUf2/t6f6arEBSSztQPwaar7nyyFtj?=
 =?us-ascii?Q?/OVLP7ax6KAJq5fYTy/nB4hXp86/kaofYKuacnwdHnZuMkVLsYexeQ/PbVJ+?=
 =?us-ascii?Q?Q9OXW+aAWw18YcXEvOGZIAEJdUGw4+X9xdBwImCMuYgPnbYFkK7BlktuU+EN?=
 =?us-ascii?Q?cY1ftAbt8L0emL8O3IoYhOk3NTZgxhv4UXzSThSMCaE817IWZcZ+qEPN3dAA?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: IOQnQxa5roFKWxUq9s8v132H9u5lOkSRd3mwd5e/TFEl+5w5Bitz4o5ef25O5DLHkgJSJapFhVJsb3JhnWB805v//e2crXo3xYNl8cUfyRFElcVOW+opd0uAy1ggK1pyMm2m1s1mOtMmKH05BWxp8pKzPjOJyOX+PJYv2QtXRk2/YONjY2gwgVxkjkhQUamedoHnu9lBIEliMAZmL/u8fr0ZSglrV4EEMbZYWD5teGvbWjH32F0D3VT1SrrjepwY/V4ZAbWY6ZiD68uHbPj+MWGn6b9zWSHpEiLNald47c2wdkCe15W2Jvf22IWsBXjhonils9+iUc1DxPnKOAvz9bKX/cxZwRtVWg6YgYRNHl8=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;6:uoDQhwEd8koZP4XyOKk0J/48lgbXLNyTXL+Q/hPSJ6bFw3SgTypdyp1g5u9f6ol1qRSSAHx6MJp8+FuNWa27CeLjrb3k+cnz/lC/CUGsNGmFTlLYWS3t7bUPQTFH/S3c245Qr0v4jnLo+yIuFm/fa6cfymPxrNP6xyaDtQ8QYkgozpdJ3yjQu7xVXtjNwdiRb6yZH/29aGVqGXXrmmYimb6FrVC7aMVjS7m8DtP7GGhX3qR5R1H/MAYloF27Z38DACubuEP98DnZANQsILMBnjczBw3FWb3sBA6v3dZug3AMKK54fpRyuf96GV4BkCudkRwtstiwV15w+I5L7dgSC0IyN1wJXAbmyThxxuPGQniSMQPIJRFeSf1dKvFBXZ2blwv5WbdpwBU7D2lmWmHpxqj3FuDaRz/sdX61I6vahBA2H5eENKj33J+eedzxx7lC7ww2ce2r/2QGPheI3+CP6w==;5:XWGcNnaLRaldHfzmST9EC3HelZ/zUAr3kaW3UoJztt5S/8mO5EeCkLP5NOHQkBEC839coUBeiDW87oUou6LbVbpe0DWdQSnaLinz3j8BJW9VfvfyFHL5wt0CfJvyZCsCuLbvbkGJYaDy3dapxtw6DtZKmYxulvZE4auWQbS52vA=;7:iaPmnkpKQOzzssjS5aS+AQyI1vbWAemz17gZ83i2AbXyWKZFn+QRjrltR25ep9pqDBBcZwcNhVaZip6Wmf2sqqkfiEdpocW+97jaMRfKH+Jj7llufZy9bf01jfwl+k5OWjLWYedC70f6EowfWJAGBC3ENWQLHSAX1oEVu8Cilti3fC39zHwmOeHnLPNATOcyHBWJA3HxxJlpT3nXk6i99lHS24s+K6ysAl3da3WklbxhrpnM7fDlywoNbvtAnsnF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 16:09:30.0606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 737d53ab-a6a2-4911-dfa7-08d5fd49533c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LCDIF will repeatedly display data from CUR_BUF and set CUR_BUF to
NEXT_BUF when done. Since we are only ever writing to NEXT_BUF the
display will show an initial corrupt frame.

Fix by writing the FB paddr to both CUR_BUF and NEXT_BUF when
activating the CRTC.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 45 +++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index e4fcbb65b969..24b1f0c1432e 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -191,10 +191,25 @@ static int mxsfb_reset_block(void __iomem *reset_addr)
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
@@ -267,12 +282,22 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 	       mxsfb->base + LCDC_VDCTRL4);
 }
 
 void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 {
+	dma_addr_t paddr;
+
 	mxsfb_enable_axi_clk(mxsfb);
 	mxsfb_crtc_mode_set_nofb(mxsfb);
+
+	/* Write cur_buf as well to avoid an initial corrupt frame */
+	paddr = mxsfb_get_fb_paddr(mxsfb);
+	if (paddr) {
+		writel(paddr, mxsfb->base + mxsfb->devdata->cur_buf);
+		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
+	}
+
 	mxsfb_enable_controller(mxsfb);
 }
 
 void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
 {
@@ -283,16 +308,12 @@ void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
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
@@ -303,14 +324,12 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 			drm_crtc_send_vblank_event(crtc, event);
 		}
 	}
 	spin_unlock_irq(&crtc->dev->event_lock);
 
-	if (!fb)
-		return;
-
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
-- 
2.17.1

