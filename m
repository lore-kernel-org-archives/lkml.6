Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AH8x225aCohp1DDTaVu2QMJ+lCg5ArufQOloNtlS/TIJ6WHdwtjLjXrNDS+/cx+wt/LEJ83Se4zm
ARC-Seal: i=1; a=rsa-sha256; t=1518552797; cv=none;
        d=google.com; s=arc-20160816;
        b=SnZq5+NGyWi+OU0+YYoLf8KxmcmwKnKSsV2yZDmvN4eyM6Dl3A7XSEPfko62r8YFv+
         O/QXmbV1+Yi0UVByIPvhJbye7QZ773A+bXhxhZRJp0AcqjvgKyHkPcr+0pNm8E8XIciJ
         SYbNEoKH0syz0KmDJt2xjHEBN6hsals/bOcMnik/3NulZlSnR+hnlxvrsHNCDHIw+xfZ
         JBLLCobNthuCFoB/qIF55unMPs7qtSLkOLkUYA1yaJMhawQEaBy7fcxIcjoDn7k9/izL
         kAltd3LT+9cxtNm1bCZ4xhL05E0P5vbDQKfN6u3sbxwYsjuaqDVRN5gkPwrDi+eAckl1
         Qsew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=gaaouNcL8lZ4dbcoH8PAtdW/Izu/xVl6MiIZypv7BFs=;
        b=g8fLDgVjj5naqtlL+5paeo4DOd06v4E7piK/XWTqMIKbkBWGlNp8jU4ePwoscySelS
         iHj7tnDjWd29UxQLLaj4+1kXhT0Jn5khgGV9ojgl19yZ8Dm2ZHUXbURiMcGoizCsSeJJ
         qz2hxdHyf1Jqblj4wl/PL/vEBDsqO7nlgiboP67e2YMWhevTZ8311EulaL/ow3uBpOHg
         TKm5rmfx7/IwyiA4K6tJk9dHGFREfocOE5Ffgm6U+WMT0tEoBtHGZGI/e1/eT9ALmon7
         Mg3/PNKYssz/zlYdzq7P5/vNZfN6WHT3Saq6Yxy/n4MV7HIUYaWCSyMun2RSDBh0PgH3
         o88g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v1 4/4] platform/x86: mlx-platform: Add physical bus number auto detection
Date: Tue, 13 Feb 2018 22:09:36 +0000
Message-Id: <1518559776-188942-5-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
References: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318018131981276?=
X-GMAIL-MSGID: =?utf-8?q?1592318018131981276?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add physical bus number auto detection mechanism in order to avoid a
possible collision with I2C physical bus allocation. The mlx-platform
driver activates i2c-mlxcpld driver with no bus number specification. It
based on an assumption that on all Mellanox systems physical bus number is
supposed to be number one. On some X86 systems other I2C drivers, which
even are not used for Mellanox systems, could come up before i2c-mlxcpld,
for example i2c_i801, i2c_ismt, i2c-kempld. And in such case a pre-defined
I2C bus number one, could be busy. In order to avoid such situation,
with no having special kernel config file disabling unwanted modules or
with no putting anything to a blacklist, the logic for I2C available bus
number auto detection is added. To ensure it, mlx-platform driver verifies
which adapter number is free prior activation of i2c-mlxcpld driver. In
case numbered adapter one is busy, it shifts to the available number. This
shift is passed to i2c-mlxcpld driver, the mux base numbers are
incremented by the this shift value and passed to i2c-mux-reg driver, and
also this value is passed to mlxreg-hotplug driver.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 12 ++++---
 drivers/platform/x86/mlx-platform.c        | 53 ++++++++++++++++++++++++++++--
 include/linux/platform_data/mlxreg.h       |  2 ++
 3 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index c1e1c4f..ea9e7f4 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -96,6 +96,8 @@ struct mlxreg_hotplug_priv_data {
 static int mlxreg_hotplug_device_create(struct mlxreg_hotplug_priv_data *priv,
 					struct mlxreg_core_data *data)
 {
+	struct mlxreg_core_hotplug_platform_data *pdata;
+
 	/*
 	 * Return if adapter number is negative. It could be in case hotplug
 	 * event is not associated with hotplug device.
@@ -103,10 +105,12 @@ static int mlxreg_hotplug_device_create(struct mlxreg_hotplug_priv_data *priv,
 	if (data->hpdev.nr < 0)
 		return 0;
 
-	data->hpdev.adapter = i2c_get_adapter(data->hpdev.nr);
+	pdata = dev_get_platdata(&priv->pdev->dev);
+	data->hpdev.adapter = i2c_get_adapter(data->hpdev.nr +
+					      pdata->shift_nr);
 	if (!data->hpdev.adapter) {
 		dev_err(priv->dev, "Failed to get adapter for bus %d\n",
-			data->hpdev.nr);
+			data->hpdev.nr + pdata->shift_nr);
 		return -EFAULT;
 	}
 
@@ -114,8 +118,8 @@ static int mlxreg_hotplug_device_create(struct mlxreg_hotplug_priv_data *priv,
 					    data->hpdev.brdinfo);
 	if (!data->hpdev.client) {
 		dev_err(priv->dev, "Failed to create client %s at bus %d at addr 0x%02x\n",
-			data->hpdev.brdinfo->type, data->hpdev.nr,
-			data->hpdev.brdinfo->addr);
+			data->hpdev.brdinfo->type, data->hpdev.nr +
+			pdata->shift_nr, data->hpdev.brdinfo->addr);
 
 		i2c_put_adapter(data->hpdev.adapter);
 		data->hpdev.adapter = NULL;
diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 67f3c6d..7a0bd24 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -85,6 +85,12 @@
 #define MLXPLAT_CPLD_FAN_MASK		GENMASK(3, 0)
 #define MLXPLAT_CPLD_FAN_NG_MASK	GENMASK(5, 0)
 
+/* Default I2C parent bus number */
+#define MLXPLAT_CPLD_PHYS_ADAPTER_DEF_NR	1
+
+/* Maximum number of possible physical buses equipped on system */
+#define MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM	16
+
 /* Number of channels in group */
 #define MLXPLAT_CPLD_GRP_CHNL_NUM		8
 
@@ -843,10 +849,48 @@ static const struct dmi_system_id mlxplat_dmi_table[] __initconst = {
 
 MODULE_DEVICE_TABLE(dmi, mlxplat_dmi_table);
 
+static int mlxplat_mlxcpld_verify_bus_topology(int *nr)
+{
+	struct i2c_adapter *search_adap;
+	int shift, i;
+
+	/* Scan adapters from expected id to verify it is free. */
+	*nr = MLXPLAT_CPLD_PHYS_ADAPTER_DEF_NR;
+	for (i = MLXPLAT_CPLD_PHYS_ADAPTER_DEF_NR; i <
+	     MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM; i++) {
+		search_adap = i2c_get_adapter(i);
+		if (search_adap) {
+			i2c_put_adapter(search_adap);
+			continue;
+		}
+
+		/* Return if expected parent adapter is free. */
+		if (i == MLXPLAT_CPLD_PHYS_ADAPTER_DEF_NR)
+			return 0;
+		break;
+	}
+
+	/* Return with error if free id for adapter is not found. */
+	if (i == MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM)
+		return -ENODEV;
+
+	/* Shift adapter ids, since expected parent adapter is not free. */
+	*nr = i;
+	for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
+		shift = *nr - mlxplat_mux_data[i].parent;
+		mlxplat_mux_data[i].parent = *nr;
+		mlxplat_mux_data[i].base_nr += shift;
+		if (shift > 0)
+			mlxplat_hotplug->shift_nr = shift;
+	}
+
+	return 0;
+}
+
 static int __init mlxplat_init(void)
 {
 	struct mlxplat_priv *priv;
-	int i, err;
+	int i, nr, err;
 
 	if (!dmi_check_system(mlxplat_dmi_table))
 		return -ENODEV;
@@ -866,7 +910,12 @@ static int __init mlxplat_init(void)
 	}
 	platform_set_drvdata(mlxplat_dev, priv);
 
-	priv->pdev_i2c = platform_device_register_simple("i2c_mlxcpld", -1,
+	err = mlxplat_mlxcpld_verify_bus_topology(&nr);
+	if (nr < 0)
+		goto fail_alloc;
+
+	nr = (nr == MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM) ? -1 : nr;
+	priv->pdev_i2c = platform_device_register_simple("i2c_mlxcpld", nr,
 							 NULL, 0);
 	if (IS_ERR(priv->pdev_i2c)) {
 		err = PTR_ERR(priv->pdev_i2c);
diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
index 2629109..2744cff 100644
--- a/include/linux/platform_data/mlxreg.h
+++ b/include/linux/platform_data/mlxreg.h
@@ -130,6 +130,7 @@ struct mlxreg_core_platform_data {
  * @cell_low: location of low aggregation interrupt register;
  * @mask_low: low aggregation interrupt common mask;
  * @deferred_nr: I2C adapter number must be exist prior probing execution;
+ * @shift_nr: I2C adapter numbers must be incremented by this value;
  */
 struct mlxreg_core_hotplug_platform_data {
 	struct mlxreg_core_item *items;
@@ -141,6 +142,7 @@ struct mlxreg_core_hotplug_platform_data {
 	u32 cell_low;
 	u32 mask_low;
 	int deferred_nr;
+	int shift_nr;
 };
 
 #endif /* __LINUX_PLATFORM_DATA_MLXREG_H */
-- 
2.1.4
