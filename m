Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AB8JxZrS5Lg8lEA3XCtcKYPCPtYGN8vVn9ECdP9BBeS14dLQVvs0iJ905eQKg1/O/hLcFP6+8g9L
ARC-Seal: i=1; a=rsa-sha256; t=1524821079; cv=none;
        d=google.com; s=arc-20160816;
        b=HU9Rdmue85JEgIaQQkqxmz5iRi3NCyo3mvRTsvgEFMGkfuXWDqacg0Ra/wbK01LtdR
         F+Lfjd/q/radw5nQ+IlCpg8JqhN4byr6htRqSrUP9Hrc4WChOdywG9I3q/DJthnPLeQU
         DXzjsmhm1xnVQyJD3hNp2LGitybZqrciGKkRxqn8D3rgUupcoCi2Ku03AOaEKODkRpkF
         /wm4sruL/1vFpfkqgFyS41C53UKs0uuzvRUzBzmNgtI91K3El3BUIg2H0yuKtuu+uLr3
         ZuJHCa5xWvYZOddYDkApm73VkYvBw3+hPf20RNnQSb9KTOzs6Y4BZ8FLIAvdX8sMGt9/
         +G7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=vtut0kIz7f8MYFQW2zrvgmOldCfS/Z399mstkUP+LEc=;
        b=0NdWJExZAweqUG1LRIXBzDta1syLDOnrfHsaGc6Gf3FZ7LOixq1NbmAH/V0TjDLjbY
         kTTzXjQJAHE6GPWF41kqIgeBtpXEaVG1k2W60Vi8UXN31Eg4qHOL3h4uNOWIq44YV1kC
         OHmpMg4oeGYS7D7O8va+tihDG3OTd8DlaMYHFreGUXg1kWCc98Oam/N/zesL/OTN4QqL
         Oe0f6FwmYX2h6LnXtzknrghEly443F1DQyknaPBW39jEJYGKYU7wE9Xeg2a9uEJ+uWhk
         xv0cHCECnh0pDOGh4pSeAU5SLXuJNfIzj/BUT9gY0LQ5iIlDV520jOh8vFHHEU2du14V
         bbxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBE02187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=matthias.bgg@kernel.org
From: matthias.bgg@kernel.org
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
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v3 04/10] drm/mediatek: mt2701: switch to mfd probing.
Date: Fri, 27 Apr 2018 11:23:56 +0200
Message-Id: <b50d32fb140dcf25ac467f0b5e7a84353c8d31d3.1524820923.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598890788706777550?=
X-GMAIL-MSGID: =?utf-8?q?1598890788706777550?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Brugger <mbrugger@suse.com>

With the mtk-mmsys MFD device in place, we switch the probing for
mt2701 from device-tree to mfd.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index a48e28adad09..88ee35907744 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -386,7 +386,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_drm_private *private;
-	struct device_node *node;
+	struct device_node *node, *parent_node, *mmsys_node;
 	struct component_match *match = NULL;
 	int ret;
 	int i;
@@ -399,12 +399,23 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	INIT_WORK(&private->commit.work, mtk_atomic_work);
 	private->data = of_device_get_match_data(dev);
 
-	private->config_regs = syscon_node_to_regmap(dev->of_node);
-	if (IS_ERR(private->config_regs))
-		return PTR_ERR(private->config_regs);
+	/* Check if called from mfd */
+	if (!dev->of_node) {
+		mmsys_node = pdev->dev.parent->of_node;
+		private->data = (struct mtk_mmsys_driver_data *)
+				platform_get_device_id(pdev)->driver_data;
+		private->config_regs =
+			syscon_node_to_regmap(mmsys_node);
+		parent_node = mmsys_node->parent;
+	} else {
+		private->config_regs = syscon_node_to_regmap(dev->of_node);
+		if (IS_ERR(private->config_regs))
+			return PTR_ERR(private->config_regs);
+		parent_node = dev->of_node->parent;
+	}
 
 	/* Iterate over sibling DISP function blocks */
-	for_each_child_of_node(dev->of_node->parent, node) {
+	for_each_child_of_node(parent_node, node) {
 		const struct of_device_id *of_id;
 		enum mtk_ddp_comp_type comp_type;
 		int comp_id;
@@ -545,13 +556,17 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
 			 mtk_drm_sys_resume);
 
 static const struct of_device_id mtk_drm_of_ids[] = {
-	{ .compatible = "mediatek,mt2701-mmsys",
-	  .data = &mt2701_mmsys_driver_data},
 	{ .compatible = "mediatek,mt8173-mmsys",
 	  .data = &mt8173_mmsys_driver_data},
 	{ }
 };
 
+static const struct platform_device_id mtk_drm_ids[] = {
+	{ "drm-mt2701-mm", (kernel_ulong_t)&mt2701_mmsys_driver_data },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, mtk_drm_ids);
+
 static struct platform_driver mtk_drm_platform_driver = {
 	.probe	= mtk_drm_probe,
 	.remove	= mtk_drm_remove,
@@ -560,6 +575,7 @@ static struct platform_driver mtk_drm_platform_driver = {
 		.of_match_table = mtk_drm_of_ids,
 		.pm     = &mtk_drm_pm_ops,
 	},
+	.id_table = mtk_drm_ids,
 };
 
 static struct platform_driver * const mtk_drm_drivers[] = {
-- 
2.16.3
