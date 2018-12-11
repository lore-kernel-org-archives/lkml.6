Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04B0C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51CA2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51CA2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeLKKxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:53:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44851 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeLKKxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:53:48 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 50FE6208BE; Tue, 11 Dec 2018 11:53:46 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1F4FC2037D;
        Tue, 11 Dec 2018 11:53:36 +0100 (CET)
Date:   Tue, 11 Dec 2018 11:53:35 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v6 00/20] lib, rtc: Print rtc_time via %ptR[dt][r]
Message-ID: <20181211105335.GO8952@piout.net>
References: <20181204212330.69515-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204212330.69515-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2018 23:23:10+0200, Andy Shevchenko wrote:
> At some point I have noticed too many users of struct rtc_time that
> printing its content field by field.
> 
> In this series I introduce %ptR[dt][r] specifier to make life a bit
> easier.
> 
> There are still users of detailed output of the struct rtc_time, but we
> can introduce an additional extension for them in the future if needed,
> otherwise they might be converted to the proposed output format.
> 
> Some of the changes slightly modify the output. In those cases we are on
> the safe side since they are pure debug. Nevertheless I tried to leave
> numbers to be the same or quite close: in some cases year was printed
> +1900, though month was left in the range [0,11] instead of [1,12].
> 
> I didn't compile everything there, though I did a basic smoke test on
> some x86 hardware. So, I rely on kbuild test robot as well :-)
> 
> Most of the users currently are RTC drivers, thus the patch series is
> assumed to go via RTC tree.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> 
> Changelog v6:
> - add few test cases (Petr)
> - timeanddate -> time_and_date (Petr)
> - drop while loop for finding raw parameter (Petr)
> - drop first patch as seems to go via nvmem tree, though I didn't see it there
> 
> Changelog v5:                                                                                                     - remove leftover from pointer() comment in vsprintf.c
> - fix indentation in rtc-proc.c
> - fix patch 1 as suggested by Joe and Alexandre
> - add Thierry's Ab tag
> - update Alexandre's email and Cc to Petr
> 
> Changelog v4:
> - drop mention of PRINTK_PEXT_TIMEDATE (Joe)
> - drop deprecated validation (Alexandre)
> - add patch 1 to fix compilation warning (may be applied independently)
> 
> Changelog v3:
> - no one supported configuration option for new extension, so it's dropped
> - amend documentation (Geert)
> - optimize flags checking (Geert)
> - drop patch against non-existing anymore drivers
>   (due to massive architectures removal)
> - rebase on top of recent linux-next
> 
> Changelog v2:
> - split out lib/vsprintf changes to separate series
> - build it optionally depending on introduced PRINTK_PEXT_TIMEDATE
> - for now support only struct rtc_time
> - make an additional letter for different time representations
> - make above letter capital to reduce confusion on %ptr vs. %ptR
> - drop kdb patch since it's a candidate for time64_t support
> 
> Andy Shevchenko (20):
>   lib/vsprintf: Print time and date in human readable format via %pt
>   rtc: Switch to use %ptR
>   rtc: at91rm9200: Switch to use %ptR
>   rtc: at91sam9: Switch to use %ptR
>   rtc: m41t80: Switch to use %ptR
>   rtc: m48t59: Switch to use %ptR
>   rtc: mcp795: Switch to use %ptR
>   rtc: pcf50633: Switch to use %ptR
>   rtc: pic32: Switch to use %ptR
>   rtc: pm8xxx: Switch to use %ptR
>   rtc: puv3: Switch to use %ptR
>   rtc: rk808: Switch to use %ptR
>   rtc: rx6110: Switch to use %ptR
>   rtc: rx8025: Switch to use %ptR
>   rtc: s3c: Switch to use %ptR
>   rtc: s5m: Switch to use %ptR
>   rtc: tegra: Switch to use %ptR
>   Input: hp_sdc_rtc - Switch to use %ptR
>   m68k/mac: Switch to use %ptR
>   PM: Switch to use %ptR
> 

All applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
