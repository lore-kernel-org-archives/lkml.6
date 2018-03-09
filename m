Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607029; cv=none;
        d=google.com; s=arc-20160816;
        b=hFY/uX6VVG5IDrTG5mZZ/2ZjJuxlC//KlgIItJxO2BsEmFlbbAqOSUyTz7xpV9hcBR
         mhQKNpAJ8xC+WO2j8KDGoGqGWXWKybmH5yFAEfdykX7Fjv54Hx0RQ5xQkcSTKJkWFcin
         o56VQ1TIPVvpLBo+krkgCpv2ZUOQQ/qVSTQF3sPXUgO2wDcv+aVGdH61sXrPxtc70P1L
         Y53Sxy384mPViDXPxiSFW5HLbAg3rkcdC44Ns/Do7asUDbfpo3loeR5Fv8MGbbzovD2X
         iq9/tz7ozxI2E1cpET/YpwWirs1Trp4EqevkxuxWmGdBDAw691fOETVK/p4yq4Rf9cjp
         DyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=RT33r5HhOvcPJ59VnfxCyDIOhWrlyqcWmOJNk3eMS/4=;
        b=1CxssXRjKtWGFskz+3mC0Koe7EuMSuWMr1mkKDXoxBI0ib2IcX+vn3SanZUczpGdVE
         a9WubUcbKt34Uk/u2UiQlXwam4xx2ogqA2DiO+vH2g7xcliy3X/pcXm7Q+P0/KjJ53GU
         O28eg4oxW68zBteROpWmEpsCgb0lBxzAtIitqtdzXhx6T0owI626nP0Otvjs+uegjgrP
         JCs06wLDvTS3cMtTOiRlz08Y6ewWcM2uYV+T48iEaUoiw6e+fHTSIJWTTtH4flBMzTvb
         9abEobAxIE/abrgr2qAGn6SF5Z7vcOt+hkj36QyNXM/ZIkO1daviPQjmHAxTbM1MB5fw
         FhOA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YEu3kEpg;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YEu3kEpg;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELs5L475cgKxe12ntovScHWD4bMZ6RlX7XDuRxlbRC+H9dokXkpg4f28OuwR45JMo4XDNpfStA==
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Carlo Caione <carlo@caione.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	cphealy@gmail.com,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/25] nvmem: Introduce devm_nvmem_(un)register()
Date: Fri,  9 Mar 2018 14:46:57 +0000
Message-Id: <20180309144719.29904-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472036874432337?=
X-GMAIL-MSGID: =?utf-8?q?1594472036874432337?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Introduce devm_nvmem_register()/devm_nvmem_unregister() to make
.remove() unnecessary in trivial drivers.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: cphealy@gmail.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 59 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvmem-provider.h | 17 ++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 99e04cfcc723..b05aa8e81303 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -549,6 +549,65 @@ int nvmem_unregister(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_unregister);
 
+static void devm_nvmem_release(struct device *dev, void *res)
+{
+	WARN_ON(nvmem_unregister(*(struct nvmem_device **)res));
+}
+
+/**
+ * devm_nvmem_register() - Register a managed nvmem device for given
+ * nvmem_config.
+ * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
+ *
+ * @config: nvmem device configuration with which nvmem device is created.
+ *
+ * Return: Will be an ERR_PTR() on error or a valid pointer to nvmem_device
+ * on success.
+ */
+struct nvmem_device *devm_nvmem_register(struct device *dev,
+					 const struct nvmem_config *config)
+{
+	struct nvmem_device **ptr, *nvmem;
+
+	ptr = devres_alloc(devm_nvmem_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	nvmem = nvmem_register(config);
+
+	if (!IS_ERR(nvmem)) {
+		*ptr = nvmem;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return nvmem;
+}
+EXPORT_SYMBOL_GPL(devm_nvmem_register);
+
+static int devm_nvmem_match(struct device *dev, void *res, void *data)
+{
+	struct nvmem_device **r = res;
+
+	return *r == data;
+}
+
+/**
+ * devm_nvmem_unregister() - Unregister previously registered managed nvmem
+ * device.
+ *
+ * @nvmem: Pointer to previously registered nvmem device.
+ *
+ * Return: Will be an negative on error or a zero on success.
+ */
+int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
+{
+	return devres_release(dev, devm_nvmem_release, devm_nvmem_match, nvmem);
+}
+EXPORT_SYMBOL(devm_nvmem_unregister);
+
+
 static struct nvmem_device *__nvmem_device_get(struct device_node *np,
 					       struct nvmem_cell **cellp,
 					       const char *cell_id)
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index b00567a07496..f89598bc4e1c 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -72,6 +72,11 @@ struct nvmem_config {
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
 int nvmem_unregister(struct nvmem_device *nvmem);
 
+struct nvmem_device *devm_nvmem_register(struct device *dev,
+					 const struct nvmem_config *cfg);
+
+int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
+
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -84,5 +89,17 @@ static inline int nvmem_unregister(struct nvmem_device *nvmem)
 	return -ENOSYS;
 }
 
+static inline struct nvmem_device *
+devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
+{
+	return nvmem_register(c);
+}
+
+static inline int
+devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
+{
+	return nvmem_unregister(nvmem);
+}
+
 #endif /* CONFIG_NVMEM */
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.15.1
