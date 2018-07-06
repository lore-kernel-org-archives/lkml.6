Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD769C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8137123DBD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8137123DBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932995AbeGFPVW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:21:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:16802 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932598AbeGFPVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:21:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 08:21:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,316,1526367600"; 
   d="scan'208";a="72763735"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2018 08:21:08 -0700
Message-ID: <74c4e64cec310b2c79cdea03d10b1567b2e10ca1.camel@linux.intel.com>
Subject: Re: [PATCH 01/19 v3] regulator: fixed: Convert to use GPIO
 descriptor only
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Date:   Fri, 06 Jul 2018 18:21:08 +0300
In-Reply-To: <CACRpkdaJ7UjpXKDEi2jR65vzt-Fp42U5PnMGkuw5r-H83ggbSA@mail.gmail.com>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
         <20180514080640.12515-2-linus.walleij@linaro.org>
         <afc54477ac8bd9a69cfa8754270342cfc8487109.camel@linux.intel.com>
         <CACRpkdaJ7UjpXKDEi2jR65vzt-Fp42U5PnMGkuw5r-H83ggbSA@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-21 at 13:27 +0200, Linus Walleij wrote:
> On Mon, May 14, 2018 at 1:03 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, 2018-05-14 at 10:06 +0200, Linus Walleij wrote:
> > > The hunk hitting the x86 BCM43xx driver is especially tricky as
> > > the
> > > number
> > > comes out of SFI which is a mystery to me. I definately need
> > > someone
> > > to
> > > look at this. (Hi Andy.)
> > 
> > Since there is no link to repo with a branch and I wasn't Cc'ed to
> > cover
> > letter, asking here for a such. I would then pull it and test on
> > real
> > hardware.
> 
> I'm sorry about this.
> This branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/
> log/?h=gpio-descriptors-regulator
> 
> Has all the patches.
> 
> git pull git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-
> gpio.git
> gpio-descriptors-regulator
> 
> will bring in the patches to a testing branch.

As of today I took only one patch from that folder, i.e. 
commit c032bce1c0b5 ("regulator: fixed: Convert to use GPIO descriptor
only") and applied on top of recent linux-next and tested on Intel
Edison. Wi-Fi has been detected and I got interface in 'ip link list'
output.

Thus,

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(for Intel MID bits only)

Sorry it took a bit.

> 
> > The code itself looks good, so:
> > 
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > for Intel MID bits.
> 


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
