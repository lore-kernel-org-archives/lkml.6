Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BFEC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0916E2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0916E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeJXSaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:30:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:19670 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbeJXSaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:30:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 03:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,420,1534834800"; 
   d="scan'208";a="243918192"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 24 Oct 2018 03:02:31 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1gFFzi-0003Zb-F8; Wed, 24 Oct 2018 13:02:30 +0300
Date:   Wed, 24 Oct 2018 13:02:30 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
Message-ID: <20181024100230.GQ10650@smile.fi.intel.com>
References: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
 <20181018215101.169847-1-rajatja@google.com>
 <CAHp75Vd_r4QGR5xw2cJigM2J3WStg_0PdynBXMZOyZh+t1znKg@mail.gmail.com>
 <CACK8Z6HOsUcPFyf-GguxPxh_Zdj6gCXP=FpGw-vQXJfnM=cquw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6HOsUcPFyf-GguxPxh_Zdj6gCXP=FpGw-vQXJfnM=cquw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 04:34:55PM -0700, Rajat Jain wrote:
> On Fri, Oct 19, 2018 at 2:13 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Oct 19, 2018 at 12:53 AM Rajat Jain <rajatja@google.com> wrote:

> > > across other users of this API (other MMC host controller drivers).
> >
> > >         if (slot->cd_idx >= 0) {
> > > -               ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
> > > +               ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
> > >                                            slot->cd_override_level, 0, NULL);
> >
> > Yes.
> >
> > > +               if (ret && ret != -EPROBE_DEFER)
> > > +                       ret = mmc_gpiod_request_cd(host->mmc, NULL,
> > > +                                                  slot->cd_idx,
> > > +                                                  slot->cd_override_level,
> > > +                                                  0, NULL);
> >
> > And no. Instead of this part you need to provide an ACPI GPIO mapping table.
> 
> Sure, I am willing to do so, and I tried earlier too. However, certain
> doubts arose in my mind when I tried that and I posted my questions
> earlier (https://lkml.org/lkml/2018/9/28/507) but couldn't elicit any
> response. Unfortunately I still do not have answers. My primary
> questions are:
> 
> 1) - It seems that 1 SDHCI device may support multiple slots (looking
> at the code). It is not clear to me if they could share card detect
> interrupts, or should have separate ones? 

This is more likely question to HW engineers of your platform with a caveat
that there should be a way to distinguish exact slot in which card is being
inserted.

> Also, the driver may not
> really know? 

I think in such case the bug in HW design and / or driver.

> So should I add 1 or two pins using the
> devm_acpi_dev_add_driver_gpios().

This depends on the above, e.g. HW design, ACPI tables.

> Is some one familiar with SDHC
> driver can answer these questions, it shall be great.

Actually above questions better to ask in linux-mmc mailing list, which by the
fact is in Cc list already. So, wait for someone to clarify.


> 2) I'm not really sure what should I set "active_low" to? Isn't this
> something that should be specified by platform / ACPI too, and driver
> should just be able to say say choose whatever the ACPI says?
> 
> struct acpi_gpio_params {
>         unsigned int crs_entry_index;
>         unsigned int line_index;
>         bool active_low;
> };


ACPI specification misses this property, that's why we have it in the
structure. In your case it should be provided by _DSD and thus be consistent
with the hardcoded values.

> Since I do not understand the above two issues, and thus I chose the
> safest path and not disturb the current code so as not to cause any
> regressions.

As far as I can see in the above it is disturbing the current code more than
needed.

> 
> Please let me know, and I'm happy to re-spin my patch.

-- 
With Best Regards,
Andy Shevchenko


