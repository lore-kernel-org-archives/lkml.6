Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526036970; cv=none;
        d=google.com; s=arc-20160816;
        b=uF7oyOxZLp8ofG1UUv/+tAcSS5zRdEQ23HhCDRr3hfwbNlAQXQW4/Fy4rvijiemLG5
         0OhFACTZnIviHg515HSlNgdsWwWgq8NgOe7SNrRWgL7S6iCs+aKX9u78xiQrcWzWuq08
         XO/j/+DA556UEz7V0GpSMVpqWnSHlhdbQJGZAAFAXbvU2UkcbBxOdvz9MrC/aqbPNxxT
         6AI+QyV5sAni5yUGqTsRwa+GAnLWT9dYI2QWXlpCIdjqc1ZPDGcaTqzDdeM8692kOcNl
         dZyUjBac46nEm2EjbsVMMISe4W77AEpX/rp+42qg5bRRT8emM0jCAM2KQBEvMLCNlZUa
         LjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=SzJUKBPNwe/3NehlMvPVKfMBKPVrmxN/Paoe95Wq8jY=;
        b=jeBdHnaM0m4Gm+Sv8vcyQg6bOUlPJe7v3wP2hILCurVt+Dk21ImYBnB8N7NJtirC/I
         twJVCBBsh3udm9ujfjDcAfYEHmLdSjfeEiJQuG7nQbBUew+Uyi/StvlFRUOTPlXsGdRW
         UWKcKi0oy4TwBrZ93PajiL7J1a1EYMUIRlBZxSVDGB+iNuDOSLuc5IHaWyYTAzSdngVM
         8OUibpn8g/E2UnqmKc+tX2QCC2IXux/GYVAvkH/GCDOhzW4ZjSe+nLnyDaWvIaAFR9FE
         HLSItLN8k9sMrLB2TGTAyySUz/8LVAYVRO6aGE1mBs/nynG2t3+yk4uaWY8/v/iqjy6p
         4qmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=KrXt64vA;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=KrXt64vA;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqVINMK7bPnqzaii2xuhw5qOkNFaAHP8lk2EoK9I7u7e+8ZZn1erNLJLHQ87dQ9sBL4qopn6A==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 1/8] drivers: nvmem: Export nvmem_add_cells()
Date: Fri, 11 May 2018 12:06:56 +0100
Message-Id: <20180511110703.4924-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
References: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600165742365001027?=
X-GMAIL-MSGID: =?utf-8?q?1600165742365001027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrew Lunn <andrew@lunn.ch>

Not all platforms use device tree. It is useful to be able to add
cells to a NVMEM device from code. Export nvmem_add_cells() so making
this possible.

This required changing the parameters a bit, so that just the cells
and the number of cells are passed, not the whole nvmem config
structure.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 24 +++++++++++++++++-------
 include/linux/nvmem-provider.h | 11 +++++++++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b05aa8e81303..b1c95ef78544 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -353,18 +353,27 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
 	return 0;
 }
 
-static int nvmem_add_cells(struct nvmem_device *nvmem,
-			   const struct nvmem_config *cfg)
+/**
+ * nvmem_add_cells() - Add cell information to an nvmem device
+ *
+ * @nvmem: nvmem device to add cells to.
+ * @info: nvmem cell info to add to the device
+ * @ncells: number of cells in info
+ *
+ * Return: 0 or negative error code on failure.
+ */
+int nvmem_add_cells(struct nvmem_device *nvmem,
+		    const struct nvmem_cell_info *info,
+		    int ncells)
 {
 	struct nvmem_cell **cells;
-	const struct nvmem_cell_info *info = cfg->cells;
 	int i, rval;
 
-	cells = kcalloc(cfg->ncells, sizeof(*cells), GFP_KERNEL);
+	cells = kcalloc(ncells, sizeof(*cells), GFP_KERNEL);
 	if (!cells)
 		return -ENOMEM;
 
-	for (i = 0; i < cfg->ncells; i++) {
+	for (i = 0; i < ncells; i++) {
 		cells[i] = kzalloc(sizeof(**cells), GFP_KERNEL);
 		if (!cells[i]) {
 			rval = -ENOMEM;
@@ -380,7 +389,7 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 		nvmem_cell_add(cells[i]);
 	}
 
-	nvmem->ncells = cfg->ncells;
+	nvmem->ncells = ncells;
 	/* remove tmp array */
 	kfree(cells);
 
@@ -393,6 +402,7 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 
 	return rval;
 }
+EXPORT_SYMBOL_GPL(nvmem_add_cells);
 
 /*
  * nvmem_setup_compat() - Create an additional binary entry in
@@ -509,7 +519,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	}
 
 	if (config->cells)
-		nvmem_add_cells(nvmem, config);
+		nvmem_add_cells(nvmem, config->cells, config->ncells);
 
 	return nvmem;
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index f89598bc4e1c..24def6ad09bb 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -77,6 +77,9 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
 
 int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
 
+int nvmem_add_cells(struct nvmem_device *nvmem,
+		    const struct nvmem_cell_info *info,
+		    int ncells);
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -99,6 +102,14 @@ static inline int
 devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 {
 	return nvmem_unregister(nvmem);
+
+}
+
+static inline int nvmem_add_cells(struct nvmem_device *nvmem,
+				  const struct nvmem_cell_info *info,
+				  int ncells)
+{
+	return -ENOSYS;
 }
 
 #endif /* CONFIG_NVMEM */
-- 
2.16.2
