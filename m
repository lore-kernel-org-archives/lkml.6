Return-Path: <mbrugger@localhost>
X-Google-Smtp-Source: AIpwx4/vKfyaraxRP1lWHm2U9ztvr4ikzzfOpceWgXNRi+4O7cDiz58yCFUb2xH1Qst+EVdoMGti
ARC-Seal: i=1; a=rsa-sha256; t=1524497543; cv=none;
        d=google.com; s=arc-20160816;
        b=CrRol9cBjKaapCcSc1VqEV5ICMhxqpY+UnRsqFB30RI5I+6jjdNx6mNnXpegR/51oY
         ihwH3hZtYNhMd/Gzf2TOg/e7Sr5//FOd+EcnIvd7VkvEQaciqwWs8xC+GXH0tuoBiWsl
         JSmpyLxm6p8Q4kPFwDL8aS1ehkH3ogzA7OQlLTi/93TWKBzhK7/VUnoFGeB+XmZgYbsN
         BuT1t7Pzli50YuTPTsI6Wp0B9obV091GpbmoOZxap18AmtqCmjHAJ2/9NlMPXXghJZvP
         4iU3vY3nOAUKTEB6/vdBE2vFu/B3CkETqOXoyZuq4pPKKUrs6TKREV1Viuzr2QqQCHZE
         zCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=isOVlKoXZ5DCaWsJOcTkjVtk9ns3b9ktnFZJIAc8aBU=;
        b=I0z1htCD4KjKe8R0amojOYP6WWAWItgI9ewa0YP60tzfenPiHFdRbuUFB1suqMXDeJ
         Zy0wpXSWwhNFr3n7ZwINsIMyfCoL3LTNbWDE6Dt3eKbjzxc3USQ/BuZKnbOZ6o2KgyA2
         qbR1CTBWvs+AtGg0QNIZanDgDKkV8I1vFGWumU3VFosb6u8wfnQdshZTtWzNZGf/ORZz
         v8aCMqAOTJiyD6i+zZFocqNGTBJv6iXJqR2HTj9uUSCc0swiaULQA/JFelt7YoRH6ZUG
         QJwcrVw0EbEUoX0/hFJPkAbgcOxnTbC2ZfSatwUSLlRYdU8MHLBnprODu5wjfCwEdri4
         xXew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
From: Matthias Brugger <mbrugger@suse.com>
To: ulrich.hecht+renesas@gmail.com,
	laurent.pinchart@ideasonboard.com,
	ck.hu@mediatek.com,
	p.zabel@pengutronix.de,
	airlied@linux.ie,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	mturquette@baylibre.com,
	sboyd@codeaurora.org,
	lee.jones@linaro.org
Cc: davem@davemloft.net,
	gregkh@linuxfoundation.org,
	mchehab@kernel.org,
	rdunlap@infradead.org,
	pi-cheng.chen@linaro.org,
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v2 07/10] drm/mediatek: Add mfd support for mt8173
Date: Mon, 23 Apr 2018 17:32:06 +0200
Message-Id: <ae6e77bc3f5c29ce53e248162a42f4eb4e42a417.1524497268.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598551535345691146?=
X-GMAIL-MSGID: =?utf-8?q?1598551535345691146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use the MFD device for SoC mt8173. Probing via devicetree
is no longer needed for any SoC, so delete it.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 88ee35907744..3cc433ebfa8f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -399,20 +399,12 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	INIT_WORK(&private->commit.work, mtk_atomic_work);
 	private->data = of_device_get_match_data(dev);
 
-	/* Check if called from mfd */
-	if (!dev->of_node) {
-		mmsys_node = pdev->dev.parent->of_node;
-		private->data = (struct mtk_mmsys_driver_data *)
-				platform_get_device_id(pdev)->driver_data;
-		private->config_regs =
-			syscon_node_to_regmap(mmsys_node);
-		parent_node = mmsys_node->parent;
-	} else {
-		private->config_regs = syscon_node_to_regmap(dev->of_node);
-		if (IS_ERR(private->config_regs))
-			return PTR_ERR(private->config_regs);
-		parent_node = dev->of_node->parent;
-	}
+	mmsys_node = pdev->dev.parent->of_node;
+	private->data = (struct mtk_mmsys_driver_data *)
+			platform_get_device_id(pdev)->driver_data;
+	private->config_regs =
+		syscon_node_to_regmap(mmsys_node);
+	parent_node = mmsys_node->parent;
 
 	/* Iterate over sibling DISP function blocks */
 	for_each_child_of_node(parent_node, node) {
@@ -555,14 +547,9 @@ static int mtk_drm_sys_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
 			 mtk_drm_sys_resume);
 
-static const struct of_device_id mtk_drm_of_ids[] = {
-	{ .compatible = "mediatek,mt8173-mmsys",
-	  .data = &mt8173_mmsys_driver_data},
-	{ }
-};
-
 static const struct platform_device_id mtk_drm_ids[] = {
 	{ "drm-mt2701-mm", (kernel_ulong_t)&mt2701_mmsys_driver_data },
+	{ "drm-mt8173-mm", (kernel_ulong_t)&mt8173_mmsys_driver_data },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(platform, mtk_drm_ids);
@@ -572,7 +559,6 @@ static struct platform_driver mtk_drm_platform_driver = {
 	.remove	= mtk_drm_remove,
 	.driver	= {
 		.name	= "mediatek-drm",
-		.of_match_table = mtk_drm_of_ids,
 		.pm     = &mtk_drm_pm_ops,
 	},
 	.id_table = mtk_drm_ids,
-- 
2.16.3
