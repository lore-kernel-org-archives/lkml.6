Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FCCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527EA20672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbeLQIT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:19:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37725 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeLQIT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:19:28 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so8757600lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 00:19:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3lXYt53xelRTnHTBNNsnKx9aQZw0kiPnwIkL436al0U=;
        b=sJh+jGV2T0nhZVZdo5O2i76LchidrOyTEI+ygKrJw+He9b6HZNsIkWh56qaQdJ9L65
         kbZ3sLyCadtCo/tuZgNdyw22OfKJD/+wQQMvvlf5IW4KOTZAESCZYrEQ+Wb7YFCwo5nn
         T32AOrpTsxeDHwp54ZB/CDr/OJrIGxJeV73Ab0T/c99BJw4v6hopq9q5KjQXlGfT+CMd
         dlc5tw6IVvvuRW9B7c3oUj8+FaKfL8JHvlOx8nhQrYY4IGVn92OXeUhg/DNLTTqbk5bV
         Imzq7bk9eoNGSFUDBf6m7Z/uUlJpyJ2615EWQzGwTVlsxPwe3g8NhIXqJzAJHcQnOrxK
         dpKQ==
X-Gm-Message-State: AA+aEWZ8QHVc+eP2tp44bDi0tM6iB8SL5SMIGy4jm4lXD4tSCQ7mL15v
        5ajV/+y7xVwWuvVeeRVqvD9vGKpL
X-Google-Smtp-Source: AFSGD/U4aNAgh2Igy70k6U89zniBzfkqzq3zx6kDaP2ZapGheJBPQUPQPe6IAld0u5bhF6WxvvAKIA==
X-Received: by 2002:a19:1f54:: with SMTP id f81mr6422001lff.153.1545034765111;
        Mon, 17 Dec 2018 00:19:25 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id o17sm2461951lff.77.2018.12.17.00.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 00:19:24 -0800 (PST)
Date:   Mon, 17 Dec 2018 10:19:12 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com
Subject: Re: [RFC] regmap-irq: add "main register" and level-irq support
Message-ID: <20181217081912.GA2477@localhost.localdomain>
References: <20181130085908.GA24983@localhost.localdomain>
 <20181204172137.GE6809@sirena.org.uk>
 <20181205082251.GE31204@localhost.localdomain>
 <20181205172701.GH6205@sirena.org.uk>
 <20181207075829.GA24940@localhost.localdomain>
 <20181207131418.GB6510@sirena.org.uk>
 <20181214135819.GA2735@localhost.localdomain>
 <20181214172619.GC6467@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214172619.GC6467@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark & All,

On Fri, Dec 14, 2018 at 05:26:19PM +0000, Mark Brown wrote:
> On Fri, Dec 14, 2018 at 03:58:19PM +0200, Matti Vaittinen wrote:
> > On Fri, Dec 07, 2018 at 01:14:18PM +0000, Mark Brown wrote:
> 
> > I could send an example on how the driver utilizing the original RFC
> > interface would look like. I am starting to think it was not *that* bad
> > after all...
> 
> That might help, yes.
> 
This is what I came up with. I think having the simple mapping arrays
(bitX_offsets) and REGMAP_IRQ_MAIN_REG_OFFSET macro makes this
not-so-bad :) I will also send an example on how this would look like
with the RFC v2 interface.

#include <linux/i2c.h>
#include <linux/interrupt.h>
#include <linux/irq.h>
#include <linux/mfd/core.h>
#include <linux/mfd/rohm-bd70528.h>
#include <linux/module.h>
#include <linux/of_device.h>
#include <linux/regmap.h>
#include <linux/types.h>

static struct mfd_cell bd70528_mfd_cells[] = {
	{ .name = "bd70528-pmic", },
	{ .name = "bd70528-rtc", },
	{ .name = "bd70528-gpio", },
	{ .name = "bd70528-led", },
	{ .name = "bd70528-power", },
	{ .name = "bd70528-clk", },
	{ .name = "bd70528-pwrkey", },
};

static const struct regmap_range bd70528_irq_reg_range = {
	.range_min = BD70528_REG_INT_MAIN,
	.range_max = BD70528_REG_INT_OP_FAIL,
};

static struct regmap_access_table volatile_regs = {
	.yes_ranges = &bd70528_irq_reg_range,
	.n_yes_ranges = 1,
};

static struct regmap_config bd70528_regmap = {
	.reg_bits = 8,
	.val_bits = 8,
	.volatile_table = &volatile_regs,
	.max_register = BD70528_MAX_REGISTER,
	.cache_type = REGCACHE_RBTREE,
};
/* bit [0] - Shutdown register */
unsigned int bit0_offsets[] = {0};

/* bit [1] - Power failure register */
unsigned int bit1_offsets[] = {1};

/* bit [2] - VR FAULT register */
unsigned int bit2_offsets[] = {2};

/* bit [3] - PMU register interrupts */
unsigned int bit3_offsets[] = {3};

/* bit [4] - Charger 1 and Charger 2 registers */
unsigned int bit4_offsets[] = {4, 5};

/* bit [5] - RTC register */
unsigned int bit5_offsets[] = {6};

/* bit [6] - GPIO register */
unsigned int bit6_offsets[] = {7};

/* bit [7] - Invalid operation register */
unsigned int bit7_offsets[] = {8};

static struct regmap_irq_sub_irq_map bd70528_sub_irq_offsets[] = {
	REGMAP_IRQ_MAIN_REG_OFFSET(bit0_offsets),
	REGMAP_IRQ_MAIN_REG_OFFSET(bit1_offsets),
	REGMAP_IRQ_MAIN_REG_OFFSET(bit2_offsets),
	REGMAP_IRQ_MAIN_REG_OFFSET(bit3_offsets),
	REGMAP_IRQ_MAIN_REG_OFFSET(bit4_offsets),
	REGMAP_IRQ_MAIN_REG_OFFSET(bit5_offsets),
	REGMAP_IRQ_MAIN_REG_OFFSET(bit6_offsets),
	REGMAP_IRQ_MAIN_REG_OFFSET(bit7_offsets),
};

static struct regmap_irq bd70528_irqs[] = {
	REGMAP_IRQ_REG(BD70528_INT_LONGPUSH, 0, BD70528_INT_LONGPUSH_MASK),
	REGMAP_IRQ_REG(BD70528_INT_WDT, 0, BD70528_INT_WDT_MASK),
	REGMAP_IRQ_REG(BD70528_INT_HWRESET, 0, BD70528_INT_HWRESET_MASK),
	REGMAP_IRQ_REG(BD70528_INT_RSTB_FAULT, 0, BD70528_INT_RSTB_FAULT_MASK),
	REGMAP_IRQ_REG(BD70528_INT_VBAT_UVLO, 0, BD70528_INT_VBAT_UVLO_MASK),
	REGMAP_IRQ_REG(BD70528_INT_TSD, 0, BD70528_INT_TSD_MASK),
	REGMAP_IRQ_REG(BD70528_INT_RSTIN, 0, BD70528_INT_RSTIN_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BUCK1_FAULT, 1, BD70528_INT_BUCK1_FAULT_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BUCK2_FAULT, 1, BD70528_INT_BUCK2_FAULT_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BUCK3_FAULT, 1, BD70528_INT_BUCK3_FAULT_MASK),
	REGMAP_IRQ_REG(BD70528_INT_LDO1_FAULT, 1, BD70528_INT_LDO1_FAULT_MASK),
	REGMAP_IRQ_REG(BD70528_INT_LDO2_FAULT, 1, BD70528_INT_LDO2_FAULT_MASK),
	REGMAP_IRQ_REG(BD70528_INT_LDO3_FAULT, 1, BD70528_INT_LDO3_FAULT_MASK),
	REGMAP_IRQ_REG(BD70528_INT_LED1_FAULT, 1, BD70528_INT_LED1_FAULT_MASK),
	REGMAP_IRQ_REG(BD70528_INT_LED2_FAULT, 1, BD70528_INT_LED2_FAULT_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BUCK1_OCP, 2, BD70528_INT_BUCK1_OCP_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BUCK2_OCP, 2, BD70528_INT_BUCK2_OCP_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BUCK3_OCP, 2, BD70528_INT_BUCK3_OCP_MASK),
	REGMAP_IRQ_REG(BD70528_INT_LED1_OCP, 2, BD70528_INT_LED1_OCP_MASK),
	REGMAP_IRQ_REG(BD70528_INT_LED2_OCP, 2, BD70528_INT_LED2_OCP_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BUCK1_FULLON, 2, BD70528_INT_BUCK1_FULLON_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BUCK2_FULLON, 2, BD70528_INT_BUCK2_FULLON_MASK),
	REGMAP_IRQ_REG(BD70528_INT_SHORTPUSH, 3, BD70528_INT_SHORTPUSH_MASK),
	REGMAP_IRQ_REG(BD70528_INT_AUTO_WAKEUP, 3, BD70528_INT_AUTO_WAKEUP_MASK),
	REGMAP_IRQ_REG(BD70528_INT_STATE_CHANGE, 3, BD70528_INT_STATE_CHANGE_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BAT_OV_RES, 4, BD70528_INT_BAT_OV_RES_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BAT_OV_DET, 4, BD70528_INT_BAT_OV_DET_MASK),
	REGMAP_IRQ_REG(BD70528_INT_DBAT_DET, 4, BD70528_INT_DBAT_DET_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BATTSD_COLD_RES, 4, BD70528_INT_BATTSD_COLD_RES_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BATTSD_COLD_DET, 4, BD70528_INT_BATTSD_COLD_DET_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BATTSD_HOT_RES, 4, BD70528_INT_BATTSD_HOT_RES_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BATTSD_HOT_DET, 4, BD70528_INT_BATTSD_HOT_DET_MASK),
	REGMAP_IRQ_REG(BD70528_INT_CHG_TSD, 4, BD70528_INT_CHG_TSD_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BAT_RMV, 5, BD70528_INT_BAT_RMV_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BAT_DET, 5, BD70528_INT_BAT_DET_MASK),
	REGMAP_IRQ_REG(BD70528_INT_DCIN2_OV_RES, 5, BD70528_INT_DCIN2_OV_RES_MASK),
	REGMAP_IRQ_REG(BD70528_INT_DCIN2_OV_DET, 5, BD70528_INT_DCIN2_OV_DET_MASK),
	REGMAP_IRQ_REG(BD70528_INT_DCIN2_RMV, 5, BD70528_INT_DCIN2_RMV_MASK),
	REGMAP_IRQ_REG(BD70528_INT_DCIN2_DET, 5, BD70528_INT_DCIN2_DET_MASK),
	REGMAP_IRQ_REG(BD70528_INT_DCIN1_RMV, 5, BD70528_INT_DCIN1_RMV_MASK),
	REGMAP_IRQ_REG(BD70528_INT_DCIN1_DET, 5, BD70528_INT_DCIN1_DET_MASK),
	REGMAP_IRQ_REG(BD70528_INT_RTC_ALARM, 6, BD70528_INT_RTC_ALARM_MASK),
	REGMAP_IRQ_REG(BD70528_INT_ELPS_TIM, 6, BD70528_INT_ELPS_TIM_MASK),
	REGMAP_IRQ_REG(BD70528_INT_GPIO0, 7, BD70528_INT_GPIO0_MASK),
	REGMAP_IRQ_REG(BD70528_INT_GPIO1, 7, BD70528_INT_GPIO1_MASK),
	REGMAP_IRQ_REG(BD70528_INT_GPIO2, 7, BD70528_INT_GPIO2_MASK),
	REGMAP_IRQ_REG(BD70528_INT_GPIO3, 7, BD70528_INT_GPIO3_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BUCK1_DVS_OPFAIL, 8, BD70528_INT_BUCK1_DVS_OPFAIL_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BUCK2_DVS_OPFAIL, 8, BD70528_INT_BUCK2_DVS_OPFAIL_MASK),
	REGMAP_IRQ_REG(BD70528_INT_BUCK3_DVS_OPFAIL, 8, BD70528_INT_BUCK3_DVS_OPFAIL_MASK),
	REGMAP_IRQ_REG(BD70528_INT_LED1_VOLT_OPFAIL, 8, BD70528_INT_LED1_VOLT_OPFAIL_MASK),
	REGMAP_IRQ_REG(BD70528_INT_LED2_VOLT_OPFAIL, 8, BD70528_INT_LED2_VOLT_OPFAIL_MASK),
};

static struct regmap_irq_chip bd70528_irq_chip = {
	.name = "bd70528_irq",
	.main_status = BD70528_REG_INT_MAIN,
	.irqs = &bd70528_irqs[0],
	.num_irqs = ARRAY_SIZE(bd70528_irqs),
	.status_base = BD70528_REG_INT_SHDN,
	.mask_base = BD70528_REG_INT_SHDN_MASK,
	.ack_base = BD70528_REG_INT_SHDN,
	.init_ack_masked = true,
	.num_regs = 9,
	.num_main_regs = 1,
	.sub_reg_offsets = &bd70528_sub_irq_offsets[0],
	.num_main_status_bits = 8,
	.irq_reg_stride = 1,
};

static int bd70528_i2c_probe(struct i2c_client *i2c,
			    const struct i2c_device_id *id)
{
	struct bd70528 *bd70528;
	struct regmap_irq_chip_data *irq_data;
	int ret, i;

	if (!i2c->irq) {
		dev_err(&i2c->dev, "No IRQ configured\n");
		return -EINVAL;
	}
	bd70528 = devm_kzalloc(&i2c->dev, sizeof(*bd70528), GFP_KERNEL);

	if (!bd70528)
		return -ENOMEM;

	dev_set_drvdata(&i2c->dev, bd70528);

	bd70528->regmap = devm_regmap_init_i2c(i2c, &bd70528_regmap);
	if (IS_ERR(bd70528->regmap)) {
		dev_err(&i2c->dev, "regmap initialization failed\n");
		return PTR_ERR(bd70528->regmap);
	}

	ret = devm_regmap_add_irq_chip(&i2c->dev, bd70528->regmap,
				       i2c->irq, IRQF_ONESHOT, 0,
				       &bd70528_irq_chip, &irq_data);
	if (ret) {
		dev_err(&i2c->dev, "Failed to add irq_chip\n");
		return ret;
	}
	else
		pr_info("Registered %d irqs for chip\n",
			bd70528_irq_chip.num_irqs);

	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
				   bd70528_mfd_cells,
				   ARRAY_SIZE(bd70528_mfd_cells), NULL, 0,
				   regmap_irq_get_domain(irq_data));
	if (ret)
		dev_err(&i2c->dev, "Failed to create subdevices\n");

	return ret;
}

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
