Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4659CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3165247A9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCt8imvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3165247A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeGBMTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:19:31 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36540 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752428AbeGBMTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:19:24 -0400
Received: by mail-ua0-f196.google.com with SMTP id y8-v6so9932620uan.3;
        Mon, 02 Jul 2018 05:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OXl16Ud0Q9bfEQW0BBVMzmaO5WGRqPBhuOZIGaYchfQ=;
        b=fCt8imvfGW2lGpbwGMjmN7vT1UxW7jxJBGxTYIgxhIkllMyvrDpT17Yj81MQhTjJ6Q
         lx1ohD5T5HW+eKrqGv6kevIsExwUQsPVe4TK00JiZwb+tGcueFRlV6g+XF+ZWOMDnWYL
         ev3CrdpKk9+ldJVkXjixsrKf8rLsP1IbRllg5iq5FVk9iOYMDyMUzyFNWuwJScO/e5lt
         jgxirkpE60d4dPj2sIga/tuubbO7ztpX/BxOesWfEY3WrJ9wgPizHfgOXbveOZzzfM+p
         /avbKv3aCw7VmbpNG/deJqf56KKjTPw4oHh5YSaDuidK6JGj0AcBJSJicyQ50B5InL3H
         cjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OXl16Ud0Q9bfEQW0BBVMzmaO5WGRqPBhuOZIGaYchfQ=;
        b=NabqORYEeLaNK28a1OPmzwEJ7VAVqt2S1dyyJj2bXy6DTAYBca+KV43u8670KiCyVm
         cugBShS+4+YIxX0Km3UoGnPhPP2N6RPjI7DsSwkEeeRX5EU6i0PEFwUYJv6TjqB5AQUg
         9qckufgiNi6mybWz0bnwj9AG3mT2qlpegBGo1G4uiXLQYi1Y9ADBwWJt91cUTEnccGhw
         2iF5pNDeY0xf62dKeNv3ueTwVklZ+BvAzLaATYimKgipL7ck4d90JTJt3toVxbXiYOyA
         zg+IcokDxh3442ybJzmJfctsAIxIxcFuNoHNZXTHApP9zZQmuSJoTiHqNsIGMZV2dQU3
         qP4w==
X-Gm-Message-State: APt69E2dat+iLmpKocpureftYP+xxbiDfcgm1EpCH5OZbFjhedbhY6ZA
        aH0NK0GkBF11BrEsuXcyFOvNTrVfkW5JslY/8EP99Q==
X-Google-Smtp-Source: AAOMgpfF4e3I9v/7fdXKf1Ue3DFSRvXhVI/mOsdjR5vmMNf+wdP1CRRBjgNMgxZEiGLgMGI/Zz0X1cds3lVLcOjLz28=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr15538883uai.47.1530533962884;
 Mon, 02 Jul 2018 05:19:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 05:19:22 -0700 (PDT)
In-Reply-To: <20180615112700.GA20210@raj-desk2.iind.intel.com>
References: <CAHp75Vdxz2h1N_bLQ4wxrYoo-kRAHQK=+36Db0BfK1QR4iwVPw@mail.gmail.com>
 <20180614221302.25663-1-david.e.box@linux.intel.com> <20180615112700.GA20210@raj-desk2.iind.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 Jul 2018 15:19:22 +0300
Message-ID: <CAHp75Vc7RfwbWZGz5NwWi4BbVtoUzS2fFMeLO4adW3V4mBGKag@mail.gmail.com>
Subject: Re: [PATCH V4] platform/x86: intel_pmc_core: Add CNP SLPS0 debug registers
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        kyle.d.pelton@linux.intel.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 2:27 PM, Rajneesh Bhardwaj
<rajneesh.bhardwaj@intel.com> wrote:
> On Thu, Jun 14, 2018 at 03:13:02PM -0700, David E. Box wrote:
>> From: <david.e.box@intel.com>
>>
>> Adds debugfs access to registers in the Cannonlake PCH PMC that are
>> useful for debugging #SLP_S0 signal assertion and other low power
>> related activities. Device pm states are latched in these registers
>> whenever the package enters C10 and can be read from slp_s0_debug_status.
>> The pm states may also be latched by writing 1 to slp_s0_debug_latch
>> which will immediately capture the current state on the next read of
>> slp_s0_debug_status.
>
> Reviewed-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>

Oops, sorry, it went without your tag.
patchwork seems didn't recognize this kind of combined tags.

>
>>
>> Signed-off-by: Box, David E <david.e.box@intel.com>
>> ---
>> V4:
>>       - rename slp_s0_dbg string to slp_s0_debug for consistency
>>       - ADD ISCLK prefix to MAIN_PLL and OC_PLL
>> V3:
>>       - use null terminator in bit_map array
>>       - replaced ternary operator with if/else
>>       - Removed space fixes on old code
>> V2:
>>       - Clear latch bit after use
>>       - Pass pmc_dev as parameter
>>       - Use DEFINE_SHOW_ATTRIBUTE macro
>>  drivers/platform/x86/intel_pmc_core.c | 120 ++++++++++++++++++++++++++++++++++
>>  drivers/platform/x86/intel_pmc_core.h |   6 ++
>>  2 files changed, 126 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
>> index 43bbe74..d00fee2 100644
>> --- a/drivers/platform/x86/intel_pmc_core.c
>> +++ b/drivers/platform/x86/intel_pmc_core.c
>> @@ -196,9 +196,67 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
>>       {}
>>  };
>>
>> +static const struct pmc_bit_map cnp_slps0_dbg0_map[] = {
>> +     {"AUDIO_D3",            BIT(0)},
>> +     {"OTG_D3",              BIT(1)},
>> +     {"XHCI_D3",             BIT(2)},
>> +     {"LPIO_D3",             BIT(3)},
>> +     {"SDX_D3",              BIT(4)},
>> +     {"SATA_D3",             BIT(5)},
>> +     {"UFS0_D3",             BIT(6)},
>> +     {"UFS1_D3",             BIT(7)},
>> +     {"EMMC_D3",             BIT(8)},
>> +     {}
>> +};
>> +
>> +static const struct pmc_bit_map cnp_slps0_dbg1_map[] = {
>> +     {"SDIO_PLL_OFF",        BIT(0)},
>> +     {"USB2_PLL_OFF",        BIT(1)},
>> +     {"AUDIO_PLL_OFF",       BIT(2)},
>> +     {"ISCLK_OC_PLL_OFF",    BIT(3)},
>> +     {"ISCLK_MAIN_PLL_OFF",  BIT(4)},
>> +     {"XOSC_OFF",            BIT(5)},
>> +     {"LPC_CLKS_GATED",      BIT(6)},
>> +     {"PCIE_CLKREQS_IDLE",   BIT(7)},
>> +     {"AUDIO_ROSC_OFF",      BIT(8)},
>> +     {"HPET_XOSC_CLK_REQ",   BIT(9)},
>> +     {"PMC_ROSC_SLOW_CLK",   BIT(10)},
>> +     {"AON2_ROSC_GATED",     BIT(11)},
>> +     {"CLKACKS_DEASSERTED",  BIT(12)},
>> +     {}
>> +};
>> +
>> +static const struct pmc_bit_map cnp_slps0_dbg2_map[] = {
>> +     {"MPHY_CORE_GATED",     BIT(0)},
>> +     {"CSME_GATED",          BIT(1)},
>> +     {"USB2_SUS_GATED",      BIT(2)},
>> +     {"DYN_FLEX_IO_IDLE",    BIT(3)},
>> +     {"GBE_NO_LINK",         BIT(4)},
>> +     {"THERM_SEN_DISABLED",  BIT(5)},
>> +     {"PCIE_LOW_POWER",      BIT(6)},
>> +     {"ISH_VNNAON_REQ_ACT",  BIT(7)},
>> +     {"ISH_VNN_REQ_ACT",     BIT(8)},
>> +     {"CNV_VNNAON_REQ_ACT",  BIT(9)},
>> +     {"CNV_VNN_REQ_ACT",     BIT(10)},
>> +     {"NPK_VNNON_REQ_ACT",   BIT(11)},
>> +     {"PMSYNC_STATE_IDLE",   BIT(12)},
>> +     {"ALST_GT_THRES",       BIT(13)},
>> +     {"PMC_ARC_PG_READY",    BIT(14)},
>> +     {}
>> +};
>> +
>> +static const struct pmc_bit_map *cnp_slps0_dbg_maps[] = {
>> +     cnp_slps0_dbg0_map,
>> +     cnp_slps0_dbg1_map,
>> +     cnp_slps0_dbg2_map,
>> +     NULL,
>> +};
>> +
>>  static const struct pmc_reg_map cnp_reg_map = {
>>       .pfear_sts = cnp_pfear_map,
>>       .slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
>> +     .slps0_dbg_maps = cnp_slps0_dbg_maps,
>> +     .slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
>>       .ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
>>       .regmap_length = CNP_PMC_MMIO_REG_LEN,
>>       .ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
>> @@ -252,6 +310,8 @@ static int pmc_core_check_read_lock_bit(void)
>>  }
>>
>>  #if IS_ENABLED(CONFIG_DEBUG_FS)
>> +static bool slps0_dbg_latch;
>> +
>>  static void pmc_core_display_map(struct seq_file *s, int index,
>>                                u8 pf_reg, const struct pmc_bit_map *pf_map)
>>  {
>> @@ -481,6 +541,57 @@ static const struct file_operations pmc_core_ltr_ignore_ops = {
>>       .release        = single_release,
>>  };
>>
>> +static void pmc_core_slps0_dbg_latch(struct pmc_dev *pmcdev, bool reset)
>> +{
>> +     const struct pmc_reg_map *map = pmcdev->map;
>> +     u32 fd;
>> +
>> +     mutex_lock(&pmcdev->lock);
>> +
>> +     if (!reset && !slps0_dbg_latch)
>> +             goto out_unlock;
>> +
>> +     fd = pmc_core_reg_read(pmcdev, map->slps0_dbg_offset);
>> +     if (reset)
>> +             fd &= ~CNP_PMC_LATCH_SLPS0_EVENTS;
>> +     else
>> +             fd |= CNP_PMC_LATCH_SLPS0_EVENTS;
>> +     pmc_core_reg_write(pmcdev, map->slps0_dbg_offset, fd);
>> +
>> +     slps0_dbg_latch = 0;
>> +
>> +out_unlock:
>> +     mutex_unlock(&pmcdev->lock);
>> +}
>> +
>> +static int pmc_core_slps0_dbg_show(struct seq_file *s, void *unused)
>> +{
>> +     struct pmc_dev *pmcdev = s->private;
>> +     const struct pmc_bit_map **maps = pmcdev->map->slps0_dbg_maps;
>> +     const struct pmc_bit_map *map;
>> +     int offset;
>> +     u32 data;
>> +
>> +     pmc_core_slps0_dbg_latch(pmcdev, false);
>> +     offset = pmcdev->map->slps0_dbg_offset;
>> +     while (*maps) {
>> +             map = *maps;
>> +             data = pmc_core_reg_read(pmcdev, offset);
>> +             offset += 4;
>> +             while (map->name) {
>> +                     seq_printf(s, "SLP_S0_DBG: %-32s\tState: %s\n",
>> +                                map->name,
>> +                                data & map->bit_mask ?
>> +                                "Yes" : "No");
>> +                     ++map;
>> +             }
>> +             ++maps;
>> +     }
>> +     pmc_core_slps0_dbg_latch(pmcdev, true);
>> +     return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(pmc_core_slps0_dbg);
>> +
>>  static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
>>  {
>>       debugfs_remove_recursive(pmcdev->dbgfs_dir);
>> @@ -514,6 +625,15 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>>                                   0444, dir, pmcdev,
>>                                   &pmc_core_mphy_pg_ops);
>>
>> +     if (pmcdev->map->slps0_dbg_maps) {
>> +             debugfs_create_file("slp_s0_debug_status", 0444,
>> +                                 dir, pmcdev,
>> +                                 &pmc_core_slps0_dbg_fops);
>> +
>> +             debugfs_create_bool("slp_s0_debug_latch", 0644,
>> +                                 dir, &slps0_dbg_latch);
>> +     }
>> +
>>       return 0;
>>  }
>>  #else
>> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
>> index 5fa5f97..93a7e99 100644
>> --- a/drivers/platform/x86/intel_pmc_core.h
>> +++ b/drivers/platform/x86/intel_pmc_core.h
>> @@ -127,12 +127,14 @@ enum ppfear_regs {
>>  #define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET      0x193C
>>  #define CNP_PMC_LTR_IGNORE_OFFSET              0x1B0C
>>  #define CNP_PMC_PM_CFG_OFFSET                  0x1818
>> +#define CNP_PMC_SLPS0_DBG_OFFSET             0x10B4
>>  /* Cannonlake: PGD PFET Enable Ack Status Register(s) start */
>>  #define CNP_PMC_HOST_PPFEAR0A                  0x1D90
>>
>>  #define CNP_PMC_MMIO_REG_LEN                   0x2000
>>  #define CNP_PPFEAR_NUM_ENTRIES                 8
>>  #define CNP_PMC_READ_DISABLE_BIT               22
>> +#define CNP_PMC_LATCH_SLPS0_EVENTS           BIT(31)
>>
>>  struct pmc_bit_map {
>>       const char *name;
>> @@ -145,6 +147,7 @@ struct pmc_bit_map {
>>   * @pfear_sts:               Maps name of IP block to PPFEAR* bit
>>   * @mphy_sts:                Maps name of MPHY lane to MPHY status lane status bit
>>   * @pll_sts:         Maps name of PLL to corresponding bit status
>> + * @slps0_dbg_maps:  Array of SLP_S0_DBG* registers containing debug info
>>   * @slp_s0_offset:   PWRMBASE offset to read SLP_S0 residency
>>   * @ltr_ignore_offset:       PWRMBASE offset to read/write LTR ignore bit
>>   * @regmap_length:   Length of memory to map from PWRMBASE address to access
>> @@ -153,6 +156,7 @@ struct pmc_bit_map {
>>   *                   PPFEAR
>>   * @pm_cfg_offset:   PWRMBASE offset to PM_CFG register
>>   * @pm_read_disable_bit: Bit index to read PMC_READ_DISABLE
>> + * @slps0_dbg_offset:        PWRMBASE offset to SLP_S0_DEBUG_REG*
>>   *
>>   * Each PCH has unique set of register offsets and bit indexes. This structure
>>   * captures them to have a common implementation.
>> @@ -161,6 +165,7 @@ struct pmc_reg_map {
>>       const struct pmc_bit_map *pfear_sts;
>>       const struct pmc_bit_map *mphy_sts;
>>       const struct pmc_bit_map *pll_sts;
>> +     const struct pmc_bit_map **slps0_dbg_maps;
>>       const u32 slp_s0_offset;
>>       const u32 ltr_ignore_offset;
>>       const int regmap_length;
>> @@ -168,6 +173,7 @@ struct pmc_reg_map {
>>       const int ppfear_buckets;
>>       const u32 pm_cfg_offset;
>>       const int pm_read_disable_bit;
>> +     const u32 slps0_dbg_offset;
>>  };
>>
>>  /**
>> --
>> 2.7.4
>>
>
> --
> Best Regards,
> Rajneesh



-- 
With Best Regards,
Andy Shevchenko
