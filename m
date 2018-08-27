Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6752CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09689208D6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d0m+TiTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09689208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeH0O5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:57:35 -0400
Received: from mail-he1eur01on0047.outbound.protection.outlook.com ([104.47.0.47]:51613
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726994AbeH0O5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x29FxP6cx8gNBjbFoOrq6u20hsJpDEHgdSSA4sSCqBc=;
 b=d0m+TiTJaOiziPwLue0z2/PMsQQulUwEE4kLAdiX9FXNwaPGJPMbwIUAotwy7VCnLyTduRyx25tgkXeh6GX3Gg9cy69h4bij7PHu8vP/sbRLe2cOIK0sJFuwFTVIao5fL6PBQO1X1RDJ4IwStt6OLcATwXr+sJTpAjQ0TdKFhFQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 DB7PR04MB4297.eurprd04.prod.outlook.com (2603:10a6:5:28::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Mon, 27 Aug 2018 11:11:07 +0000
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
Subject: [RESEND 2/5] drm/mxsfb: Fix initial corrupt frame when activating display
Date:   Mon, 27 Aug 2018 14:10:38 +0300
Message-Id: <7ce983379410b6c29a16c9f394b382ec16c16ba9.1535367027.git.leonard.crestez@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 188589d1-dc43-457e-de99-08d60c0dca8d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4297;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;3:Tm7rFa3LMN9cZMlQ6Ui0AQJgQHUAqV1PBHsTAp55ajvXksNoq6PDBvdWQTIwWG/6KORG7KRwYeIxw3ZbInzBaEP5WdytxVEV/fbe+eya3ogNcSTJjiyeCXvB2bONP4JEvLo5apwWGoD8TltJcY1uAompgVJTOxlw9SK8M45rZNDYuiUqCZ4pg0vMTjyKZF4CK9MotYIjQm4PAGp4ObqCmpE1NbX7pbq01gekJnCnHUi+swmEWhYTbkxQhSs6n9c/;25:yjE7kVu8IkiRSqkpjaitqEYXhcgIwkAGslomYzaQyd1U18Vxj/EJAht9IqOHqRgfP2XBERaAREhImIu3hsJyCeiS/SFsttO0nYMcdpu1OZcofrcpnUCzCl+K80WQ7g8q6Mf5VOjx2V4WvgDPtYj+MtBpjUUAfWGUoGO5+GJpDA6pey+i+M9dpXlUX1BblMh5TpVXmTYtk/cYkvEIe19CCf9joteVXTo0z4yrXFlZogiY27CyOKdveLSu/SJHQQO3oLdLPwxYkdSGjCaDNi6TfRIthP+6FkTznBIaQo9HFhd6DoBI3uXVp6ykRbtHsEbiR12cUbkic9DTBCcBFgqnbw==;31:C5fJTy4WO8TOswXYztBSviOtyO7UL+dsypDS6gzp93lwX17nDAiDMgR8puJ7iCgnLcoEuzb9j5XUAcfg2/JxiF/bH2/GQj7snpvOE271mxbWJivmTamrxizilwuf2s4OPjPwbbtHiNogo/8YysN8CKz1TMEsJAlrH5ylKvgTEKY1U2g810HzH5SSSWvJEDuMfP0WsUTPYm2iy+Z2rSXOo8Tz4i+SkMliAiqCP14owvQ=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4297:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;20:mXdd5J0qPyg692OCa6xllCYRYKsg8K9Vc4vMsnrhTxotwCy0Pdm6Ll5apfcuOWQW4T1cGB5JmI8UPzZItN5FMeXWPKZEnmIWzFQ7S0MA/lkG6g3VKVs6OtwSWEkz1T5Owzx3iVg2e+RUk1o+eaNBlARzpOZbvgaHJFusY/KqKUxZdpN8g+6dJlW4nG52ldRhniLMSvyitcq62eMdL8s67j43B+zFuX9IS01xK1SnYnDRglwLrBqmOcYYx4itc+LXHZALtz5mywiwAmdqClgRGzPnu9+KeSqAilIg+8zgma0CN8W+eoaQOu+fCAvmu2na8yaVd/RS19HlXCc6l/Y5K9DJEqTCrfpWWIQxhCqhIVIusrj3Zt3Vqio2jt8kw9N5D1SBWRnNHJdtFSg0Vbx7d01DlImqEknU2gT9KPjYUx18Y9eAdlirrWWEo3QGaWA6OgG8FODqT2O2SIK4v9/IC+Ftw966XjCU8Xvs9GIsVh7tBPditVsDG68/FnV+bmLu;4:2hA2RCPTx7hFj4JtAZxR5b2e3Z69dJoyf6YxWSdiKzEtFYCAjeISQDA49uljrKUOaJdScN6dPxM9bYeAkYnzgbn2Ou3QM7bYe5Zn3NoGDb+oubYdZawBV9a8lkUQR4NdF6E891SR5ZmUQCIKQ4+etbLkJK6tXlU6mnAiRXvmSBfQJwfqxdgPfxj+G4Xi9bfgkxbAFACjMCLY8nMTrRH9dwrh2sG8vV17sa/jn06OhXjkvpYxmyVOC6OEmAS3+JYErugQ4whrVT+jsSudsM2WT8cOKu3UJc2T42E43hb4igkFVtQQGs7tClrGKP26ksVr
X-Microsoft-Antispam-PRVS: <DB7PR04MB4297FEE5A0B48EEEFC0A6956EE0B0@DB7PR04MB4297.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB7PR04MB4297;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4297;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(4326008)(305945005)(478600001)(6666003)(2906002)(36756003)(446003)(476003)(2616005)(956004)(81166006)(8676002)(81156014)(14444005)(44832011)(7736002)(486006)(11346002)(3846002)(6116002)(47776003)(6486002)(66066001)(97736004)(575784001)(86362001)(54906003)(5660300001)(53936002)(6512007)(16586007)(110136005)(316002)(50466002)(48376002)(50226002)(118296001)(105586002)(8936002)(106356001)(51416003)(186003)(26005)(52116002)(16526019)(6506007)(386003)(68736007)(25786009)(76176011)(69590400005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4297;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4297;23:lbip7Y7Vc4wwmIWNxHZ/r+NpU/Nqct1DutwwZHhvD?=
 =?us-ascii?Q?rky9DWXgHo/leA474kyYnOojrYyOrWhz9O7L1AlxqcT4dv/q8SRv7mCMHhW0?=
 =?us-ascii?Q?Ur3I5xeQs06ZgTmuPiPcEC2UkQ9wbTUWaR+LIbMx7BpdP8aW6gLOodaEOYTW?=
 =?us-ascii?Q?W9FgwsFLxsc3/ieusEv7a3RMK7x2bOO94jIZVQ/PLou+AS5bvUA713GLbIk1?=
 =?us-ascii?Q?579zClgbY39fk+T+P/YDGn8TVcrmJ9Sd3cQUcPlt572ZxA8uuch1yfLDX+ff?=
 =?us-ascii?Q?aDKVcFUAN7q6r7yu3EGL4SPiQxoMcW5yzEp/QNTOeoc9qvJT8Trad8RrOxnv?=
 =?us-ascii?Q?URsp8KXs6XCKU1/fuezcFIODG/eEAQaxL4aqNwyHKStG00bTenrRikq1qOxk?=
 =?us-ascii?Q?I1JpjcwbOzWbCbDDVJ/q6ttsTCzjJ3NKkJrWratxkccM/UmqZdcajI2sw/sz?=
 =?us-ascii?Q?QZ4IO/wHAGake/bdWKWeyObzcu4u3ZmqhuC5rpOdNlWXjw6jo5emW1WJ4BLO?=
 =?us-ascii?Q?EHpq4HDTSJ1C+EY0IpputNFYZWyqU2I8HDMgcpjX5pp0sQIjpvX1XTG7iUMY?=
 =?us-ascii?Q?7ORtloFgdoCTo6meZ89rq/h35Oi+vuDNaAVIYasqArcx1GpVid9sqnRF7Htw?=
 =?us-ascii?Q?ZwFDrjTiU6KGblqHrCqnqS9eSUa7qa8ZzR+mstmTlmirkDKtjJzJtuzyNaVK?=
 =?us-ascii?Q?mbBRHtx3qPaHL2djV7q3NI2RY1YD5QAv7vVDd2sgBDXrwhgj/qOCqYptx3gV?=
 =?us-ascii?Q?PfW+PUCqeWEMie+T/SPLRL+WYjeN2igGtcr6QyonSzN68rI8FShyArcinpik?=
 =?us-ascii?Q?sQ+0MPXUTwfmzFUeFEpNLFbBLczSCsbWCT/fLvVpA4LsazUK4AMOnmnvNBKe?=
 =?us-ascii?Q?8rb65QT/z0gAdwasRNv/kM4h3+6m4TCsEGuEjEIon0Oybx6hF5wWl2T+H8Be?=
 =?us-ascii?Q?3i1kqpx4b+JTAgShSpKqsQmtF2stqv5Ss6wBGXGq5h7gwlVMGbvHekbmT493?=
 =?us-ascii?Q?BAWW1A9EwUsboqDfSeSiPZKZpYzpkDHQjAPbqhcT5ij5PJ0kUdrZMRKMa62J?=
 =?us-ascii?Q?NzO00bbq5bsmEwp+mslDt8JlH/sGGlI5KmBcJ8sKEgLQzhxNX1KTAYyuJ7Bg?=
 =?us-ascii?Q?9D+BAnNIcA/oH4TDNC8WLk8f4VBdWu9zHBDn9R1BqUYTuYlVkUunbmjGfWty?=
 =?us-ascii?Q?VlWS4G7dk1lMTiH7HiV+Qiq6PnfuzM+kFPoiRR2aHFs8a3Gck+0r+Nym5a6T?=
 =?us-ascii?Q?WJChINHJGLxTg+m/YxtwRSr2Akm61JQfCmVOeWsNqLoHkJRSNyxBTE7fTM0V?=
 =?us-ascii?Q?7p3V0hLnb3ruEYBgJHArDWFGrVTeWmLgn4aANfRSbkE?=
X-Microsoft-Antispam-Message-Info: 3MSelg47k65LjVubmRqt72Vj4G8TGYCRxfcPQUGClcMMAv8LSVTZyiBlMX8hOwGpgd37CgSAtIJdCSrSvZcUCoDKyydqoeCDOx7e1hdAlsucim+UHXvgBWVTqPCLODh7mLjI3CFWwI9g3ppnto2N3TIkF/7Z+smpoE2XHpwjhKM6SVyJsVgSZqGbVhgIwN3Eh4z2vzIoxS1Lte9+PmS86nLIu1NQgZdF33jUhbv4JP6EqLFx2a6pv0HogjS5ycHMMypDq9pB+8i43kejmR8bFpau9yh8HOvRN6FwCDs0gkj0TO2qMk+QKP/J6k/PDnInyBd8aJpfl6BQlgSumBiL/1I2kTCmESDaDatu4Y6TiUI=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;6:ZxC0eLleb83NTNxdwkprHLFS5N0w4QfuorHQt8UPExdXa709By2PIJi7aneZeW7lqfHJUu/QDjNMGt98miFOkzz1Ik7IdzbZ4FR3lEWZkSmuRTOMKst6iM49MiR3Qm4+sjRJuxN1mCp0UP0GuoTNwAkwwFZe5qIuATS0pvxGaGxXgWmldLBLYrKuz58zrLE2G7XobpkM/YOv1zQ9QfSHjsxuN643lR4AzvmlBvAHc38rnFjjq8CG8iCVVu3QJIhzoVD2ec6H3YHKcvSdPXECiwEGFrqpGPsQP6425eqKMIu/cjOZcgZ+lNIBCUmhXeW0SlbxCrFuFKIybHXxWLKJEWQEQwMmuEp7i8mLkCyFJgKZb2oKpQzjXYJpMEmA1I0KQCz/Vgd1y7OSb7Xtc8v84+oz1DdPaTIGdosm+fBqn+1WScVyEHQyR1zapEvz201/sC0OCIWNaPhNZQ05klNerg==;5:nHNDBeFrb0If6/q+4A69eYyO+S9OrGPWjHCX33GCCHet/9a4B++ODXuFPLhplYiQOrhSY2vN7zDQzU8JZ2j/0nqjmcPI7NzQCa5bPDn27+Xcn0p84XokhEchIUBgQ3SjQ4GQCUqraK07Y384gU6KaNeyQ4T2wgmYr8MGZXXDd5o=;7:/l5w+P52KtAG6sH17K+tJAVeymUlpIAvTDN5sIk15mH5nfWkZ/7nhDs3AkVCSkhCVFovuhP+WvjmkoE1vK8FqFAMhHNnpdKVMVaGa8NUF/HLQX45HE25cSzVHKhfI0Adio5UcSBRbP+F29XUaZhAsKSyrQ8Z8FQXz374XO20cPaTIFkSN3Zi3vvZnTMe+YqGWnZMxUU/g3Qq0fVIbxTLGSEK6C6n4mLITqtuv7hIeZbjtGBy+uItdwOmR2LOW/Z8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 11:11:07.3824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 188589d1-dc43-457e-de99-08d60c0dca8d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4297
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
Reviewed-by: Stefan Agner <stefan@agner.ch>
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

