Return-Path: <mbrugger@localhost>
X-Google-Smtp-Source: AIpwx49B4eNxMYEl92grQe4dDfVjq5Uj7nozcHVn6dp7Wv/2OG97kNZa6H2axeRmS97GwOJLDHWM
ARC-Seal: i=1; a=rsa-sha256; t=1524497541; cv=none;
        d=google.com; s=arc-20160816;
        b=OtSyafBA9DmbrGkxUyI8+R67sjetCA9WEr6qnKIiMrArJesv28+d5VNKnpBmkCLIwO
         zNq900JirEkie9sgCxEoTgr7rntKvkmxE5oVrhyr97o4c1LoN/Po25vDmKEuT45j6QRm
         bD2MUX6dV7cwMEVeU/b197ZxmAr1ddoCo4JtK+JI+iw7EdPopOKRLbtxjVNT2USmshpT
         zfWpRCG9HzLrsTAMADNrf9jqeI6U4W3jkuNy7llSGG6PWWzCBdAun+HDb2sIjQbPHV7X
         7AEOe3ChpgBNKExsBxjjecqrfvEyU8XesLwMYmJsLXHAGAOHDmjYqqLqZ+eXdSc2yGPB
         U5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u2+dTo0j6O2n4ttsaTMG92FTemeV5HcBZiUjVmuj/bw=;
        b=Vc71oytSu7SJtitkiZqs/Yi7J0kGuKgksfTxO6sYG8H/dP7dyiAeuUxEbgqnaZ986Z
         LIZ6fUaKs2EdvucJWWKutuy/08g8KVtQTFHyDl9+Vbn1e5yC65V3daFItsoAhffoIDv/
         h8yTnnO0UZswKcNarXQeF1gM3hsSWshS6YVUnrZD9fVLNU2FPEAVUE0O7ibgyBVlUmD1
         WKINgovVh1heFswYuxsqTxhx15L+7okCUXco0C6fqY3qCj46rRRDWB90uduVMTTx3Hkp
         Gm4oKgASABVuU/kFYi8DJyRaJKLxVXnnAiQUwOFxgqt+kVjxlhz6mOSrgVL/O/XrZJ5k
         USpw==
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
Subject: [v2 02/10] drm/mediatek: Use regmap for register access
Date: Mon, 23 Apr 2018 17:32:01 +0200
Message-Id: <7e20139c8dcc9fe80aa9e401c7bd84a3b9464ff2.1524497268.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598551534731305941?=
X-GMAIL-MSGID: =?utf-8?q?1598551534731305941?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The mmsys memory space is shared between the drm and the
clk driver. Use regmap to access it.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  4 ++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c  | 38 +++++++++++++--------------------
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h  |  4 ++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 13 ++++-------
 drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  2 +-
 5 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 658b8dd45b83..4c65873b4867 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -33,7 +33,7 @@
  * @enabled: records whether crtc_enable succeeded
  * @planes: array of 4 drm_plane structures, one for each overlay plane
  * @pending_planes: whether any plane has pending changes to be applied
- * @config_regs: memory mapped mmsys configuration register space
+ * @config_regs: regmap mapped mmsys configuration register space
  * @mutex: handle to one of the ten disp_mutex streams
  * @ddp_comp_nr: number of components in ddp_comp
  * @ddp_comp: array of pointers the mtk_ddp_comp structures used by this crtc
@@ -48,7 +48,7 @@ struct mtk_drm_crtc {
 	struct drm_plane		planes[OVL_LAYER_NR];
 	bool				pending_planes;
 
-	void __iomem			*config_regs;
+	struct regmap			*config_regs;
 	struct mtk_disp_mutex		*mutex;
 	unsigned int			ddp_comp_nr;
 	struct mtk_ddp_comp		**ddp_comp;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 8130f3dab661..bafc5c77c4fb 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -185,53 +185,45 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	return value;
 }
 
-static void mtk_ddp_sout_sel(void __iomem *config_regs,
+static void mtk_ddp_sout_sel(struct regmap *config_regs,
 			     enum mtk_ddp_comp_id cur,
 			     enum mtk_ddp_comp_id next)
 {
 	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0)
-		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
-			       config_regs + DISP_REG_CONFIG_OUT_SEL);
+		regmap_write(config_regs, DISP_REG_CONFIG_OUT_SEL,
+				BLS_TO_DSI_RDMA1_TO_DPI1);
 }
 
-void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
+void mtk_ddp_add_comp_to_path(struct regmap *config_regs,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next)
 {
-	unsigned int addr, value, reg;
+	unsigned int addr, value;
 
 	value = mtk_ddp_mout_en(cur, next, &addr);
-	if (value) {
-		reg = readl_relaxed(config_regs + addr) | value;
-		writel_relaxed(reg, config_regs + addr);
-	}
+	if (value)
+		regmap_update_bits(config_regs, addr, value, value);
 
 	mtk_ddp_sout_sel(config_regs, cur, next);
 
 	value = mtk_ddp_sel_in(cur, next, &addr);
-	if (value) {
-		reg = readl_relaxed(config_regs + addr) | value;
-		writel_relaxed(reg, config_regs + addr);
-	}
+	if (value)
+		regmap_update_bits(config_regs, addr, value, value);
 }
 
-void mtk_ddp_remove_comp_from_path(void __iomem *config_regs,
+void mtk_ddp_remove_comp_from_path(struct regmap *config_regs,
 				   enum mtk_ddp_comp_id cur,
 				   enum mtk_ddp_comp_id next)
 {
-	unsigned int addr, value, reg;
+	unsigned int addr, value;
 
 	value = mtk_ddp_mout_en(cur, next, &addr);
-	if (value) {
-		reg = readl_relaxed(config_regs + addr) & ~value;
-		writel_relaxed(reg, config_regs + addr);
-	}
+	if (value)
+		regmap_update_bits(config_regs, addr, value, 0);
 
 	value = mtk_ddp_sel_in(cur, next, &addr);
-	if (value) {
-		reg = readl_relaxed(config_regs + addr) & ~value;
-		writel_relaxed(reg, config_regs + addr);
-	}
+	if (value)
+		regmap_update_bits(config_regs, addr, value, 0);
 }
 
 struct mtk_disp_mutex *mtk_disp_mutex_get(struct device *dev, unsigned int id)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
index f9a799168077..32e12f33b76a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
@@ -20,10 +20,10 @@ struct regmap;
 struct device;
 struct mtk_disp_mutex;
 
-void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
+void mtk_ddp_add_comp_to_path(struct regmap *config_regs,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next);
-void mtk_ddp_remove_comp_from_path(void __iomem *config_regs,
+void mtk_ddp_remove_comp_from_path(struct regmap *config_regs,
 				   enum mtk_ddp_comp_id cur,
 				   enum mtk_ddp_comp_id next);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index a2ca90fc403c..a48e28adad09 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -21,6 +21,7 @@
 #include <drm/drm_of.h>
 #include <linux/component.h>
 #include <linux/iommu.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
@@ -385,7 +386,6 @@ static int mtk_drm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_drm_private *private;
-	struct resource *mem;
 	struct device_node *node;
 	struct component_match *match = NULL;
 	int ret;
@@ -399,14 +399,9 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	INIT_WORK(&private->commit.work, mtk_atomic_work);
 	private->data = of_device_get_match_data(dev);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	private->config_regs = devm_ioremap_resource(dev, mem);
-	if (IS_ERR(private->config_regs)) {
-		ret = PTR_ERR(private->config_regs);
-		dev_err(dev, "Failed to ioremap mmsys-config resource: %d\n",
-			ret);
-		return ret;
-	}
+	private->config_regs = syscon_node_to_regmap(dev->of_node);
+	if (IS_ERR(private->config_regs))
+		return PTR_ERR(private->config_regs);
 
 	/* Iterate over sibling DISP function blocks */
 	for_each_child_of_node(dev->of_node->parent, node) {
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index c3378c452c0a..c6fa0ad458e8 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -44,7 +44,7 @@ struct mtk_drm_private {
 
 	struct device_node *mutex_node;
 	struct device *mutex_dev;
-	void __iomem *config_regs;
+	struct regmap *config_regs;
 	struct device_node *comp_node[DDP_COMPONENT_ID_MAX];
 	struct mtk_ddp_comp *ddp_comp[DDP_COMPONENT_ID_MAX];
 	const struct mtk_mmsys_driver_data *data;
-- 
2.16.3
