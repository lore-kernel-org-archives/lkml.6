Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCB9ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CCD2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rUQXIwHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CCD2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeIQTLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:11:25 -0400
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:57044
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbeIQTLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x29FxP6cx8gNBjbFoOrq6u20hsJpDEHgdSSA4sSCqBc=;
 b=rUQXIwHO8Sjt9C5hXAI1YGBiyqXeEue8+DpUFpxqxk0nEHfl629JC6UWgfbVigvbkt0ond+lnwLoBCR16aEZ+nYi+96gh/gIspYp/y+xwV5AtMGO7adaUZHjItC4/U84xdRw05HCwKhaarzD/H8pTfZOVgzcq0pv2PiM4RQ7G58=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 17 Sep 2018 13:43:00 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
Cc:     Stefan Agner <stefan@agner.ch>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Robert Chiras <robert.chiras@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [RESEND 2/5] drm/mxsfb: Fix initial corrupt frame when activating display
Date:   Mon, 17 Sep 2018 16:42:12 +0300
Message-Id: <7cdac9c064cc2b8a3d237934f186da98cefe6cb3.1537191359.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537191359.git.leonard.crestez@nxp.com>
References: <cover.1537191359.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::17)
 To AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7d68a23-614f-40ea-5133-08d61ca37cdc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:P0w6+Hbqn8Egi3B1+D8SdtjSPvh0lld4/5jnmouExS9xr4iB2noVgjh1IFSceEf66S5Kv4LIPb29kMUMCeauiBjp1ezWKUAlzEUXFGwSN2F+XZ0cDpk/IfsKrcxbCYQWwlRSp7zxd20siAHt6/QIvHvwdnR0Wp7/xxk/VJcG26kbmpWjQ6ffY/ZrDe4LnSlwUCB/wXpWf26vTsZEs540mOpC/Bmirx3M2tmEM80G4SsDHWTZrnuCfioFaaxwcHY0;25:U2BOVg2HhmqLoSdGB5DHUVKhPYfGgMTpNDRgD48HFm0Lb1c9P8F7zaTzNvFYx3KdU6O1tQl0wH/FKRTXp5y7R7WNlqM5j5h4StGbLOCrb+/+4a7pDvHxEGKZrBsweDoAQ142WB5kV3D07Sf0O+Gx9oFHZeXZ9Hg3XHI9qvg7ZFXm+RvOtbmhwdlH0RGNgzsti8x5xLL0pGOawtFXwC1VmsbqM6eKCwIM/2FR/0vFy7xZ4eY2aEi4UxNhpqsoLdI8++4h4VAqw+w4RfZFQzE27HVAO4PJoEvgLc+y+WTveptj45jZb1YeTfJCNTjOnt+HBo+LwBWMKMPoqA4LqbBnpw==;31:aaykwBGV+fiiVqJ81/UYdJ/foELBa7lbeSkOJwhi8pBE/91C94zqjk+VG836jMuErNim+JCffGCfwRlMEsOdBfn//TQeL2mIzHu/O8pO98AghhpIcI9B9pqgNlVN6uY2awsmSKBECBGsXF5S8N4MuvzKQf01lvV1qeu7Jmsxxq1L1jcyPGms/qA7i4F+kzT4GlxFOIqRjta3Qf0c/DmWoXA/wdkS3NnfYi7Lk6TWeTc=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:4yTlJ1aujlTlodLN05AaBV7D3cdGwWu2o6qRMoH2DypUt1tgKJFLfmhFlr9qkEFLLOnL+F5cswB/s/7zzDW78E0BEYt4SmdYLpsfaM1RTEZx6yMDiq/yCWAGVZDREEPnr8/Fx1Bwxy6cOKcctuecAygOgWfHb1FQFOpvhQYQgbC3dDcmMCkK+QrzW1z+8BKLfOBFFTPgg4nkMhr77SsFOjnevbkvRQxEwf2PLfusNF5jTJJohhjEP97Df16Kpq6gakYqQWaG0/PChbuVJm6zKzYgdm27WQOqM+ME2dRQSFyg4B+17Qu2s42ijEaWYWzc87G1hYULo5jMWSMLmfFh4dF3+NqMRSMYZsDIZWTXv4eEQqUVuO0lT0GHU6w0JIiyT7tGb2mKXfujcBqXX9npKUHrRkH1wCnnvgXI1p2lGGKhZB/Ime588IJQ81hRGw2gWKo8CaAWFrjDNs309nUJMNIKcCoMz+NHJBzfGj6nAK7S1cvjbmsOpJPCq2lf43XV;4:eMSIhwv1Bq/j/3fhIVAr3Bxv05k99L878VI5xky5hWewdsvioJTZ8QfNeSTZD6XaHxY0XXZuQc4zTllW3Hvt2fb7tEaCVty+rcwDsGivY2fIc7qMe5QSITgwTJSEe2/Y+cmirBPEMvymQo0ZcyafjkANL+3PwezX6u/AnT01iaSg5mEo1T7X7bO06iZ2JpPlEpsAI1bInXpW7c6wpY2jpLHJQFrkjXOy8Gxpi1qTbswSP3Ab1crjIMzGvIzlcdPKQyevR/zmAbea8quSA8pmwl0CAvg0BlYWeKsRJN/LAgvj4Dgdzoww0fj9pbwjzKXY
X-Microsoft-Antispam-PRVS: <AM0PR04MB42907D1C56C7142CBF15D38AEE1E0@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(6506007)(81166006)(81156014)(8936002)(14444005)(50226002)(478600001)(16526019)(186003)(106356001)(3846002)(6116002)(105586002)(97736004)(47776003)(26005)(68736007)(50466002)(48376002)(66066001)(6512007)(2906002)(5660300001)(118296001)(11346002)(446003)(386003)(110136005)(4326008)(7736002)(6666003)(476003)(956004)(2616005)(54906003)(51416003)(16586007)(575784001)(86362001)(305945005)(6486002)(44832011)(25786009)(53936002)(36756003)(8676002)(52116002)(486006)(69590400006)(76176011)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:02/P157LasJd3CT4sM44GXNMk67N4S7R9eGJRdXgk?=
 =?us-ascii?Q?5ZE+C24tJZ+IZ7QzQxBx+atqH/KpZa3RrkZ0sEKZr3FsYFRLhvksJFGp73C7?=
 =?us-ascii?Q?8BkC/uib/fvM7q4jLQSAwRXOAnl8le8kf8yJkPyAw0nDl8jesLJYoays5ENz?=
 =?us-ascii?Q?MlYH/wOxZzgtRJRkO/YDzfajq8LaF0jRLIsS22NE/F8ZipcplQhg2JU5LYTP?=
 =?us-ascii?Q?QxkEU4mHQKQa+X9qmengJzLPQuFyXkYdF4hdSpanof1HgUpZ2JD7EM41jeyI?=
 =?us-ascii?Q?mX3KB/GKM4x+WwLCpEcbM1gj1j/A4TQKgAnZ4Okf3d3ssLMPIew25kkNcCDF?=
 =?us-ascii?Q?TlAmVZm5gMzTG91wnL7yFhucrlAGO4N9gywKGfm0qzkliFHjW/hbTj0mKGoz?=
 =?us-ascii?Q?Xp0mmOWdTrT4AcTHgqjm0XDPXhA50eR97JNzPXBZ9iw3l/l53qh2jrteGrJc?=
 =?us-ascii?Q?HVbbbPc6YpZt7P2yJpoIm4mCFoF88La1GaF8iNBMEtQankzU9AjRJkKhvr/h?=
 =?us-ascii?Q?AH7GMMBl4eKPoRo4qdZHlVHBwj3zjMr0/QAx3cI86EqKqWr9Eba+I/TtEXJV?=
 =?us-ascii?Q?ehzHLfs4oFA5PObZI+/0S8PTaSdbyyKMn7eMvp/3LZy8VUCZlTga+HlOX4lx?=
 =?us-ascii?Q?aIwEWQwyq18s5kfNqDBl5TKuQLPRWqMwf/plK+yLgSBxRnp3Ew0BtjiswIuc?=
 =?us-ascii?Q?8NF4xl/QDJUuaTQrwO+M1fXbofLVsNtLQcVVo37tFiewkrjOSSn7GApIVn3V?=
 =?us-ascii?Q?5xOmtxRqvIzfpxse7S+J7h0rdMmgl/9dSB0AJvE0xl5zL+Rs4JECwMbr+MML?=
 =?us-ascii?Q?FouHTEVx1nFefo1B41dvgTQ6TSV+XipTUfAI8kgSKH1HGXe71FNebeJjOM7Q?=
 =?us-ascii?Q?KMJDKEMnjS22rvnvwenrt9pKejGF44/127E5wI378j20b4uQBkNL4Djj6Sbg?=
 =?us-ascii?Q?iY7JyslJ03agXkHtbO7K3st5YW+omKNfkCcMclEDTplEUQZCQoARJOJLV3c9?=
 =?us-ascii?Q?qn8/xOOvZZyU1F37ESikVql1uwNHVYweunEMUUQ/Q0a0+fSgPlfO7CZFl4Iz?=
 =?us-ascii?Q?K7LnD86b9pGd+u40iEtSMoNcxjN1Xp2SIb2PqMkBCRSy9veX8fWX/WG2wyHm?=
 =?us-ascii?Q?llof6aC9oeb4wcokBVpsnBHyfS+DKqr+D2HwuhoUlJJQqyT7RX7UMTa7pxQH?=
 =?us-ascii?Q?bosk5nBGB9DzqTCxCitHyFhxNUmzzllmNBruCbWUrmlZJS3HsCch+/Cc+mJN?=
 =?us-ascii?Q?2r3/kJEIyqI36IOSc2de/f0qkSyFWmFljez13kvwILQJf5PRe07G3hVFi+El?=
 =?us-ascii?Q?bAqEsiihS/7nHLULzvjJv9b6pa7z/D2xU3dUmbz4TPb?=
X-Microsoft-Antispam-Message-Info: KZGsA4ysR0nE7AWuo1kPVQBW1YomKZUYdyVDAnnNsoNFSxzIpp28g0LV7AYLn1B16PL+sdaJxx7VmMDQSsyBHlEGpnXd25rX09dCina/7aWGJcnT+27D1WMZ964DC/gw/1mYAGVjKDD/9tZI0MiA6Ni7SqkC2Rkz4Fc29fe6uLmcF7FQehgeD0Vf92UUPPlsvtUqyEfHnmie6e/Yc7EVhte/U9FTN6NgniMGsVxkZIviEOWl8OLW3Pm9mw7HXis1Do0zbIyfg15ONZiFeWy5agUADI6JuzLVWgzfxGxxFCKL366yDJ+nLX54otX28j0VK1a5I5PUEuBY8Xpms6EA5Zx0m1R/d4P8MwuUz3F/rwU=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:zqRgvyKICnMuboQrOstK0k/57/k4o9j2tmCH7YL69Lj6yCnl0D4qV8VfsA0foWFA/IsBFhS2IXY9L0VF2r9jA1EMCOcgTYvlfO5U67dGBrpTOcrbdUbq+xHZ4+E21iJ6MtV8ui0YnmEOaoinEtUYQjg4avhGgV7syoGU20FbN96KaK4z8FHTlm9vbi1L8MaObdqK11A3iR/w7eYS55MD57mjDOkeSuK2wcqIOaVJTHjcKks7VoW1GjzyRqbAG5Xt3/hEAX79pzynugKyrFfQ1RA4qfm5jicBfBozgjSgQFDOwSmA0MJTd0xz7ID/Emp0FiiynRXn54kmJP5BKHxO1E2plgo1lqiq2JaIhZXcKb1j/6SHJgpYamPSCA2ohXz5jr7l9WwvbTPe/H+rlh4Ue4+7ivIgSSZWMCdUmtGcYRzukNiOmRMKPNnpgXkTJHJuvw2s6HaW6o6XqCIG1DyA5g==;5:Br10QKg9nVy9kfDiXA0ud6UDjXoJmpbBuB7JG11pnAQKfMEoI2IqY44XlbkvTUhHQ7rivXf+oWdBWfAwaG8fXoJ2qSzC9ggiED4kpyr2t/L8stUekZ5Az7QomaNN+X+IEjaPFDn+nE1iZ5agO15fiFXt8nTfSmMgLxnitzGcF1U=;7:iWlbIZlr3+6KbcrplzcWeZRKp6beeZ54YbKbx/9oQY/BLvXNN7h5qAF6IejjDl25KF/uOhLBMGq0IwdzM7z51qHPbhNp+WMjUhbQKlivqElpyoBTH7yML4fJ9QZ5oDTElkkrzunIRH/lw0LIe332UQxSPOIp7vNU7oSv1ADKV4a1g8eQbgcQnp6JhxxR66y2XMh6RTT+kmsgBnDgYpgofMk68EJlScaIMFFCAxXLs9IEM35zta7nxzZiVI/pF3yS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 13:43:00.5054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d68a23-614f-40ea-5133-08d61ca37cdc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
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

