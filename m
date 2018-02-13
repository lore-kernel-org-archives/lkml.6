Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AH8x225cnhZke5VTFmvmMzdGDRjlaO+oKQB3yOK2M0V6/IoZZf4mgPxsmzv3uygCWjMRIkO2QzH4
ARC-Seal: i=1; a=rsa-sha256; t=1518552796; cv=none;
        d=google.com; s=arc-20160816;
        b=dxBtWRUowH8geXkCVIOA3LnC0aL9V3vKUCv0cszLY9JB7f2/OZjnK+I3kShA7Psn6t
         tOVsBnejYa8pNsGEKSDHPT28XCXaN8dbSpFK1hLUgy1xM/s4BfdJ62JOYuQLbmqiGR9F
         bJEspwhS2CmTAAg3XLbSqM2/bN/DNEhAHQNjQ+KyyCLHj1kA6xrrMsRVbnULDCgWMWK9
         QoHi+vdTdok2gR5XCpFVlKMUQRsRxcKEn4t24wTJDhmvwmGShxBqlTXzDTekITD14T9t
         MjrgZWpYdFowMfSTmITNfEK+ttvd8VgPLYsX+MCAxDDYRnHPSCYw/qO/IPboQNLk/Ki1
         M3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3lILEdOyDcuwCjUj5fnmv0VUfx2dmdIeRRww4t05//8=;
        b=WIBYoVN5HL6hok+N43O3jF65DwnGCSCFjlXsoUqNzbadgA/LQmtP4fvueS8Q4qM6Ml
         kT2YqLJ8xBDF9ABwzsPtKSgDuijpAhXWvb0Vet6GPYU8e7GlGUVLF4XiwRcB4gH3RME7
         KqhNmJAbEAuTb+Gwv32o3f38sJ7QpulX91QmvgIiH1Q5BjDosZIcHaCAiTH58Bl+dMPO
         FQtP+goY1xTrJolYukprQFsvHXtLZsD5faP0UMH6mF13/qhkOsYSufn2H9cQDwZ4LXvR
         8UKJrz48TPfUMTsqdKSAaTif15e8wEJ+yki5o4eoNScQlo6BmwbTUlqiZ75n9vqIM6mY
         O+8g==
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
Subject: [PATCH v1 2/4] platform/x86: mlx-platform: Add differed bus functionality
Date: Tue, 13 Feb 2018 22:09:34 +0000
Message-Id: <1518559776-188942-3-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
References: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318017732489878?=
X-GMAIL-MSGID: =?utf-8?q?1592318017732489878?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add deferred bus functionality in order to enforce probing flow execution
order. Driver mlx-platform activates platform driver i2c-mux-reg, which
creates busses infrastructure, after that it activates mlxreg-hotplug
driver, which uses these busses, for connecting devices. The possible
miss-ordering can happened, for example in case the probing routine of
mlxreg-hotplug is already started execution, while i2c-mux-reg probing
routine is not completed yet. In such situation the first one could
attempt to connect device to adapter number, which is not created yet.
And as a result this connection will fail. In order to ensure the order of
probing execution on mlxreg-hotplug probe routine will be deferred until
all the busses is not created by  probe routine of i2c-mux-reg.
In order to ensure the flow order, mlx-platform driver passes the highest
bus number to the mlxreg-hotplug platform data, which in their turn could
wait in the deferred state, until all the necessary buses topology is not
exist.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/mellanox/mlxreg-hotplug.c |  7 +++++++
 drivers/platform/x86/mlx-platform.c        | 10 ++++++++++
 include/linux/platform_data/mlxreg.h       |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index 313cf8a..fe4910b 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -550,6 +550,7 @@ static int mlxreg_hotplug_probe(struct platform_device *pdev)
 {
 	struct mlxreg_core_hotplug_platform_data *pdata;
 	struct mlxreg_hotplug_priv_data *priv;
+	struct i2c_adapter *deferred_adap;
 	int err;
 
 	pdata = dev_get_platdata(&pdev->dev);
@@ -558,6 +559,12 @@ static int mlxreg_hotplug_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	/* Defer probing if the necessary adapter is not configured yet. */
+	deferred_adap = i2c_get_adapter(pdata->deferred_nr);
+	if (!deferred_adap)
+		return -EPROBE_DEFER;
+	i2c_put_adapter(deferred_adap);
+
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 71b452a..67f3c6d 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -697,6 +697,8 @@ static int __init mlxplat_dmi_default_matched(const struct dmi_system_id *dmi)
 				ARRAY_SIZE(mlxplat_default_channels[i]);
 	}
 	mlxplat_hotplug = &mlxplat_mlxcpld_default_data;
+	mlxplat_hotplug->deferred_nr =
+		mlxplat_default_channels[i - 1][MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
 
 	return 1;
 };
@@ -711,6 +713,8 @@ static int __init mlxplat_dmi_msn21xx_matched(const struct dmi_system_id *dmi)
 				ARRAY_SIZE(mlxplat_msn21xx_channels);
 	}
 	mlxplat_hotplug = &mlxplat_mlxcpld_msn21xx_data;
+	mlxplat_hotplug->deferred_nr =
+		mlxplat_msn21xx_channels[MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
 
 	return 1;
 };
@@ -725,6 +729,8 @@ static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
 				ARRAY_SIZE(mlxplat_msn21xx_channels);
 	}
 	mlxplat_hotplug = &mlxplat_mlxcpld_msn274x_data;
+	mlxplat_hotplug->deferred_nr =
+		mlxplat_msn21xx_channels[MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
 
 	return 1;
 };
@@ -739,6 +745,8 @@ static int __init mlxplat_dmi_msn201x_matched(const struct dmi_system_id *dmi)
 				ARRAY_SIZE(mlxplat_msn21xx_channels);
 	}
 	mlxplat_hotplug = &mlxplat_mlxcpld_msn201x_data;
+	mlxplat_hotplug->deferred_nr =
+		mlxplat_default_channels[i - 1][MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
 
 	return 1;
 };
@@ -753,6 +761,8 @@ static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
 				ARRAY_SIZE(mlxplat_msn21xx_channels);
 	}
 	mlxplat_hotplug = &mlxplat_mlxcpld_default_ng_data;
+	mlxplat_hotplug->deferred_nr =
+		mlxplat_msn21xx_channels[MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
 
 	return 1;
 };
diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
index fcdc707..2629109 100644
--- a/include/linux/platform_data/mlxreg.h
+++ b/include/linux/platform_data/mlxreg.h
@@ -129,6 +129,7 @@ struct mlxreg_core_platform_data {
  * @mask: top aggregation interrupt common mask;
  * @cell_low: location of low aggregation interrupt register;
  * @mask_low: low aggregation interrupt common mask;
+ * @deferred_nr: I2C adapter number must be exist prior probing execution;
  */
 struct mlxreg_core_hotplug_platform_data {
 	struct mlxreg_core_item *items;
@@ -139,6 +140,7 @@ struct mlxreg_core_hotplug_platform_data {
 	u32 mask;
 	u32 cell_low;
 	u32 mask_low;
+	int deferred_nr;
 };
 
 #endif /* __LINUX_PLATFORM_DATA_MLXREG_H */
-- 
2.1.4
