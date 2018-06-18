Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C368C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19C3208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19C3208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968010AbeFRIwJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:52:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54352 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966711AbeFRIwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:52:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 689C7207C2; Mon, 18 Jun 2018 10:52:05 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3211E20012;
        Mon, 18 Jun 2018 10:52:05 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: ds1685: remove sysfs access to control registers
Date:   Mon, 18 Jun 2018 10:52:02 +0200
Message-Id: <20180618085202.25422-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618085202.25422-1-alexandre.belloni@bootlin.com>
References: <20180618085202.25422-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to the control registers is mostly not needed and can cause runtime
issues (like missed interrupts). Remove this debugging interface.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/Kconfig      |  12 --
 drivers/rtc/rtc-ds1685.c | 369 ---------------------------------------
 2 files changed, 381 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 7e647e8d0ef3..9320f56986f4 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1016,18 +1016,6 @@ config RTC_DRV_DS17885
 
 endchoice
 
-config RTC_DS1685_SYSFS_REGS
-	bool "SysFS access to RTC register bits"
-	depends on RTC_DRV_DS1685_FAMILY && SYSFS
-	help
-	  Enable this to provide access to the RTC control register bits
-	  in /sys.  Some of the bits are read-write, others are read-only.
-
-	  Keep in mind that reading Control C's bits automatically clears
-	  all pending IRQ flags - this can cause lost interrupts.
-
-	  If you know that you need access to these bits, choose Y, Else N.
-
 config RTC_DRV_DS1742
 	tristate "Maxim/Dallas DS1742/1743"
 	depends on HAS_IOMEM
diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 28dbe2ba52c8..2bad1f50414f 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1127,341 +1127,6 @@ ds1685_rtc_sysfs_misc_grp = {
 	.attrs = ds1685_rtc_sysfs_misc_attrs,
 };
 
-#ifdef CONFIG_RTC_DS1685_SYSFS_REGS
-/**
- * struct ds1685_rtc_ctrl_regs.
- * @name: char pointer for the bit name.
- * @reg: control register the bit is in.
- * @bit: the bit's offset in the register.
- */
-struct ds1685_rtc_ctrl_regs {
-	const char *name;
-	const u8 reg;
-	const u8 bit;
-};
-
-/*
- * Ctrl register bit lookup table.
- */
-static const struct ds1685_rtc_ctrl_regs
-ds1685_ctrl_regs_table[] = {
-	{ "uip",  RTC_CTRL_A,      RTC_CTRL_A_UIP   },
-	{ "dv2",  RTC_CTRL_A,      RTC_CTRL_A_DV2   },
-	{ "dv1",  RTC_CTRL_A,      RTC_CTRL_A_DV1   },
-	{ "dv0",  RTC_CTRL_A,      RTC_CTRL_A_DV0   },
-	{ "rs3",  RTC_CTRL_A,      RTC_CTRL_A_RS3   },
-	{ "rs2",  RTC_CTRL_A,      RTC_CTRL_A_RS2   },
-	{ "rs1",  RTC_CTRL_A,      RTC_CTRL_A_RS1   },
-	{ "rs0",  RTC_CTRL_A,      RTC_CTRL_A_RS0   },
-	{ "set",  RTC_CTRL_B,      RTC_CTRL_B_SET   },
-	{ "pie",  RTC_CTRL_B,      RTC_CTRL_B_PIE   },
-	{ "aie",  RTC_CTRL_B,      RTC_CTRL_B_AIE   },
-	{ "uie",  RTC_CTRL_B,      RTC_CTRL_B_UIE   },
-	{ "sqwe", RTC_CTRL_B,      RTC_CTRL_B_SQWE  },
-	{ "dm",   RTC_CTRL_B,      RTC_CTRL_B_DM    },
-	{ "2412", RTC_CTRL_B,      RTC_CTRL_B_2412  },
-	{ "dse",  RTC_CTRL_B,      RTC_CTRL_B_DSE   },
-	{ "irqf", RTC_CTRL_C,      RTC_CTRL_C_IRQF  },
-	{ "pf",   RTC_CTRL_C,      RTC_CTRL_C_PF    },
-	{ "af",   RTC_CTRL_C,      RTC_CTRL_C_AF    },
-	{ "uf",   RTC_CTRL_C,      RTC_CTRL_C_UF    },
-	{ "vrt",  RTC_CTRL_D,      RTC_CTRL_D_VRT   },
-	{ "vrt2", RTC_EXT_CTRL_4A, RTC_CTRL_4A_VRT2 },
-	{ "incr", RTC_EXT_CTRL_4A, RTC_CTRL_4A_INCR },
-	{ "pab",  RTC_EXT_CTRL_4A, RTC_CTRL_4A_PAB  },
-	{ "rf",   RTC_EXT_CTRL_4A, RTC_CTRL_4A_RF   },
-	{ "wf",   RTC_EXT_CTRL_4A, RTC_CTRL_4A_WF   },
-	{ "kf",   RTC_EXT_CTRL_4A, RTC_CTRL_4A_KF   },
-#if !defined(CONFIG_RTC_DRV_DS1685) && !defined(CONFIG_RTC_DRV_DS1689)
-	{ "bme",  RTC_EXT_CTRL_4A, RTC_CTRL_4A_BME  },
-#endif
-	{ "abe",  RTC_EXT_CTRL_4B, RTC_CTRL_4B_ABE  },
-	{ "e32k", RTC_EXT_CTRL_4B, RTC_CTRL_4B_E32K },
-	{ "cs",   RTC_EXT_CTRL_4B, RTC_CTRL_4B_CS   },
-	{ "rce",  RTC_EXT_CTRL_4B, RTC_CTRL_4B_RCE  },
-	{ "prs",  RTC_EXT_CTRL_4B, RTC_CTRL_4B_PRS  },
-	{ "rie",  RTC_EXT_CTRL_4B, RTC_CTRL_4B_RIE  },
-	{ "wie",  RTC_EXT_CTRL_4B, RTC_CTRL_4B_WIE  },
-	{ "kse",  RTC_EXT_CTRL_4B, RTC_CTRL_4B_KSE  },
-	{ NULL,   0,               0                },
-};
-
-/**
- * ds1685_rtc_sysfs_ctrl_regs_lookup - ctrl register bit lookup function.
- * @name: ctrl register bit to look up in ds1685_ctrl_regs_table.
- */
-static const struct ds1685_rtc_ctrl_regs*
-ds1685_rtc_sysfs_ctrl_regs_lookup(const char *name)
-{
-	const struct ds1685_rtc_ctrl_regs *p = ds1685_ctrl_regs_table;
-
-	for (; p->name != NULL; ++p)
-		if (strcmp(p->name, name) == 0)
-			return p;
-
-	return NULL;
-}
-
-/**
- * ds1685_rtc_sysfs_ctrl_regs_show - reads a ctrl register bit via sysfs.
- * @dev: pointer to device structure.
- * @attr: pointer to device_attribute structure.
- * @buf: pointer to char array to hold the output.
- */
-static ssize_t
-ds1685_rtc_sysfs_ctrl_regs_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	u8 tmp;
-	struct ds1685_priv *rtc = dev_get_drvdata(dev);
-	const struct ds1685_rtc_ctrl_regs *reg_info =
-		ds1685_rtc_sysfs_ctrl_regs_lookup(attr->attr.name);
-
-	/* Make sure we actually matched something. */
-	if (!reg_info)
-		return -EINVAL;
-
-	/* No spinlock during a read -- mutex is already held. */
-	ds1685_rtc_switch_to_bank1(rtc);
-	tmp = rtc->read(rtc, reg_info->reg) & reg_info->bit;
-	ds1685_rtc_switch_to_bank0(rtc);
-
-	return sprintf(buf, "%d\n", (tmp ? 1 : 0));
-}
-
-/**
- * ds1685_rtc_sysfs_ctrl_regs_store - writes a ctrl register bit via sysfs.
- * @dev: pointer to device structure.
- * @attr: pointer to device_attribute structure.
- * @buf: pointer to char array to hold the output.
- * @count: number of bytes written.
- */
-static ssize_t
-ds1685_rtc_sysfs_ctrl_regs_store(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t count)
-{
-	struct ds1685_priv *rtc = dev_get_drvdata(dev);
-	u8 reg = 0, bit = 0, tmp;
-	unsigned long flags;
-	long int val = 0;
-	const struct ds1685_rtc_ctrl_regs *reg_info =
-		ds1685_rtc_sysfs_ctrl_regs_lookup(attr->attr.name);
-
-	/* We only accept numbers. */
-	if (kstrtol(buf, 10, &val) < 0)
-		return -EINVAL;
-
-	/* bits are binary, 0 or 1 only. */
-	if ((val != 0) && (val != 1))
-		return -ERANGE;
-
-	/* Make sure we actually matched something. */
-	if (!reg_info)
-		return -EINVAL;
-
-	reg = reg_info->reg;
-	bit = reg_info->bit;
-
-	/* Safe to spinlock during a write. */
-	ds1685_rtc_begin_ctrl_access(rtc, &flags);
-	tmp = rtc->read(rtc, reg);
-	rtc->write(rtc, reg, (val ? (tmp | bit) : (tmp & ~(bit))));
-	ds1685_rtc_end_ctrl_access(rtc, flags);
-
-	return count;
-}
-
-/**
- * DS1685_RTC_SYSFS_CTRL_REG_RO - device_attribute for read-only register bit.
- * @bit: bit to read.
- */
-#define DS1685_RTC_SYSFS_CTRL_REG_RO(bit)				\
-	static DEVICE_ATTR(bit, S_IRUGO,				\
-	ds1685_rtc_sysfs_ctrl_regs_show, NULL)
-
-/**
- * DS1685_RTC_SYSFS_CTRL_REG_RW - device_attribute for read-write register bit.
- * @bit: bit to read or write.
- */
-#define DS1685_RTC_SYSFS_CTRL_REG_RW(bit)				\
-	static DEVICE_ATTR(bit, S_IRUGO | S_IWUSR,			\
-	ds1685_rtc_sysfs_ctrl_regs_show,				\
-	ds1685_rtc_sysfs_ctrl_regs_store)
-
-/*
- * Control Register A bits.
- */
-DS1685_RTC_SYSFS_CTRL_REG_RO(uip);
-DS1685_RTC_SYSFS_CTRL_REG_RW(dv2);
-DS1685_RTC_SYSFS_CTRL_REG_RW(dv1);
-DS1685_RTC_SYSFS_CTRL_REG_RO(dv0);
-DS1685_RTC_SYSFS_CTRL_REG_RW(rs3);
-DS1685_RTC_SYSFS_CTRL_REG_RW(rs2);
-DS1685_RTC_SYSFS_CTRL_REG_RW(rs1);
-DS1685_RTC_SYSFS_CTRL_REG_RW(rs0);
-
-static struct attribute*
-ds1685_rtc_sysfs_ctrla_attrs[] = {
-	&dev_attr_uip.attr,
-	&dev_attr_dv2.attr,
-	&dev_attr_dv1.attr,
-	&dev_attr_dv0.attr,
-	&dev_attr_rs3.attr,
-	&dev_attr_rs2.attr,
-	&dev_attr_rs1.attr,
-	&dev_attr_rs0.attr,
-	NULL,
-};
-
-static const struct attribute_group
-ds1685_rtc_sysfs_ctrla_grp = {
-	.name = "ctrla",
-	.attrs = ds1685_rtc_sysfs_ctrla_attrs,
-};
-
-
-/*
- * Control Register B bits.
- */
-DS1685_RTC_SYSFS_CTRL_REG_RO(set);
-DS1685_RTC_SYSFS_CTRL_REG_RW(pie);
-DS1685_RTC_SYSFS_CTRL_REG_RW(aie);
-DS1685_RTC_SYSFS_CTRL_REG_RW(uie);
-DS1685_RTC_SYSFS_CTRL_REG_RW(sqwe);
-DS1685_RTC_SYSFS_CTRL_REG_RO(dm);
-DS1685_RTC_SYSFS_CTRL_REG_RO(2412);
-DS1685_RTC_SYSFS_CTRL_REG_RO(dse);
-
-static struct attribute*
-ds1685_rtc_sysfs_ctrlb_attrs[] = {
-	&dev_attr_set.attr,
-	&dev_attr_pie.attr,
-	&dev_attr_aie.attr,
-	&dev_attr_uie.attr,
-	&dev_attr_sqwe.attr,
-	&dev_attr_dm.attr,
-	&dev_attr_2412.attr,
-	&dev_attr_dse.attr,
-	NULL,
-};
-
-static const struct attribute_group
-ds1685_rtc_sysfs_ctrlb_grp = {
-	.name = "ctrlb",
-	.attrs = ds1685_rtc_sysfs_ctrlb_attrs,
-};
-
-/*
- * Control Register C bits.
- *
- * Reading Control C clears these bits!  Reading them individually can
- * possibly cause an interrupt to be missed.  Use the /proc interface
- * to see all the bits in this register simultaneously.
- */
-DS1685_RTC_SYSFS_CTRL_REG_RO(irqf);
-DS1685_RTC_SYSFS_CTRL_REG_RO(pf);
-DS1685_RTC_SYSFS_CTRL_REG_RO(af);
-DS1685_RTC_SYSFS_CTRL_REG_RO(uf);
-
-static struct attribute*
-ds1685_rtc_sysfs_ctrlc_attrs[] = {
-	&dev_attr_irqf.attr,
-	&dev_attr_pf.attr,
-	&dev_attr_af.attr,
-	&dev_attr_uf.attr,
-	NULL,
-};
-
-static const struct attribute_group
-ds1685_rtc_sysfs_ctrlc_grp = {
-	.name = "ctrlc",
-	.attrs = ds1685_rtc_sysfs_ctrlc_attrs,
-};
-
-/*
- * Control Register D bits.
- */
-DS1685_RTC_SYSFS_CTRL_REG_RO(vrt);
-
-static struct attribute*
-ds1685_rtc_sysfs_ctrld_attrs[] = {
-	&dev_attr_vrt.attr,
-	NULL,
-};
-
-static const struct attribute_group
-ds1685_rtc_sysfs_ctrld_grp = {
-	.name = "ctrld",
-	.attrs = ds1685_rtc_sysfs_ctrld_attrs,
-};
-
-/*
- * Control Register 4A bits.
- */
-DS1685_RTC_SYSFS_CTRL_REG_RO(vrt2);
-DS1685_RTC_SYSFS_CTRL_REG_RO(incr);
-DS1685_RTC_SYSFS_CTRL_REG_RW(pab);
-DS1685_RTC_SYSFS_CTRL_REG_RW(rf);
-DS1685_RTC_SYSFS_CTRL_REG_RW(wf);
-DS1685_RTC_SYSFS_CTRL_REG_RW(kf);
-#if !defined(CONFIG_RTC_DRV_DS1685) && !defined(CONFIG_RTC_DRV_DS1689)
-DS1685_RTC_SYSFS_CTRL_REG_RO(bme);
-#endif
-
-static struct attribute*
-ds1685_rtc_sysfs_ctrl4a_attrs[] = {
-	&dev_attr_vrt2.attr,
-	&dev_attr_incr.attr,
-	&dev_attr_pab.attr,
-	&dev_attr_rf.attr,
-	&dev_attr_wf.attr,
-	&dev_attr_kf.attr,
-#if !defined(CONFIG_RTC_DRV_DS1685) && !defined(CONFIG_RTC_DRV_DS1689)
-	&dev_attr_bme.attr,
-#endif
-	NULL,
-};
-
-static const struct attribute_group
-ds1685_rtc_sysfs_ctrl4a_grp = {
-	.name = "ctrl4a",
-	.attrs = ds1685_rtc_sysfs_ctrl4a_attrs,
-};
-
-/*
- * Control Register 4B bits.
- */
-DS1685_RTC_SYSFS_CTRL_REG_RW(abe);
-DS1685_RTC_SYSFS_CTRL_REG_RW(e32k);
-DS1685_RTC_SYSFS_CTRL_REG_RO(cs);
-DS1685_RTC_SYSFS_CTRL_REG_RW(rce);
-DS1685_RTC_SYSFS_CTRL_REG_RW(prs);
-DS1685_RTC_SYSFS_CTRL_REG_RW(rie);
-DS1685_RTC_SYSFS_CTRL_REG_RW(wie);
-DS1685_RTC_SYSFS_CTRL_REG_RW(kse);
-
-static struct attribute*
-ds1685_rtc_sysfs_ctrl4b_attrs[] = {
-	&dev_attr_abe.attr,
-	&dev_attr_e32k.attr,
-	&dev_attr_cs.attr,
-	&dev_attr_rce.attr,
-	&dev_attr_prs.attr,
-	&dev_attr_rie.attr,
-	&dev_attr_wie.attr,
-	&dev_attr_kse.attr,
-	NULL,
-};
-
-static const struct attribute_group
-ds1685_rtc_sysfs_ctrl4b_grp = {
-	.name = "ctrl4b",
-	.attrs = ds1685_rtc_sysfs_ctrl4b_attrs,
-};
-#endif /* CONFIG_RTC_DS1685_SYSFS_REGS */
-
-
 /**
  * ds1685_rtc_sysfs_register - register sysfs files.
  * @dev: pointer to device structure.
@@ -1480,31 +1145,6 @@ ds1685_rtc_sysfs_register(struct device *dev)
 	if (ret)
 		return ret;
 
-#ifdef CONFIG_RTC_DS1685_SYSFS_REGS
-	ret = sysfs_create_group(&dev->kobj, &ds1685_rtc_sysfs_ctrla_grp);
-	if (ret)
-		return ret;
-
-	ret = sysfs_create_group(&dev->kobj, &ds1685_rtc_sysfs_ctrlb_grp);
-	if (ret)
-		return ret;
-
-	ret = sysfs_create_group(&dev->kobj, &ds1685_rtc_sysfs_ctrlc_grp);
-	if (ret)
-		return ret;
-
-	ret = sysfs_create_group(&dev->kobj, &ds1685_rtc_sysfs_ctrld_grp);
-	if (ret)
-		return ret;
-
-	ret = sysfs_create_group(&dev->kobj, &ds1685_rtc_sysfs_ctrl4a_grp);
-	if (ret)
-		return ret;
-
-	ret = sysfs_create_group(&dev->kobj, &ds1685_rtc_sysfs_ctrl4b_grp);
-	if (ret)
-		return ret;
-#endif
 	return 0;
 }
 
@@ -1518,15 +1158,6 @@ ds1685_rtc_sysfs_unregister(struct device *dev)
 	sysfs_remove_bin_file(&dev->kobj, &ds1685_rtc_sysfs_nvram_attr);
 	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_misc_grp);
 
-#ifdef CONFIG_RTC_DS1685_SYSFS_REGS
-	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_ctrla_grp);
-	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_ctrlb_grp);
-	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_ctrlc_grp);
-	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_ctrld_grp);
-	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_ctrl4a_grp);
-	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_ctrl4b_grp);
-#endif
-
 	return 0;
 }
 #endif /* CONFIG_SYSFS */
-- 
2.17.1

