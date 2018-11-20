Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F87C46463
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC1D2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC1D2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeKUI72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:59:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56521 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbeKUI72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:59:28 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2E657207BD; Tue, 20 Nov 2018 23:27:57 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id E30032072D;
        Tue, 20 Nov 2018 23:27:56 +0100 (CET)
Date:   Tue, 20 Nov 2018 23:27:57 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 01/20] lib/vsprintf: Print time and date in human
 readable format via %pt
Message-ID: <20181120222756.GI8367@piout.net>
References: <20181113171729.19645-1-andriy.shevchenko@linux.intel.com>
 <20181113171729.19645-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113171729.19645-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(Please update my email address).

On 13/11/2018 19:17:10+0200, Andy Shevchenko wrote:
> There are users which print time and date represented by content of
> struct rtc_time in human readable format.
> 
> Instead of open coding that each time introduce %ptR[dt][rv] specifier.
> 
> Note, users have to select PRINTK_PEXT_TIMEDATE option in a Kconfig.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/core-api/printk-formats.rst |  20 ++++
>  lib/test_printf.c                         |   6 +
>  lib/vsprintf.c                            | 140 ++++++++++++++++++++++
>  3 files changed, 166 insertions(+)
> 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index ff48b55040ef..8342a65eab0b 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -412,6 +412,26 @@ Examples::
>  
>  Passed by reference.
>  
> +Time and date (struct rtc_time)
> +-------------------------------
> +
> +::
> +
> +	%ptR		YYYY-mm-dd HH:MM:SS
> +	%ptRd		YYYY-mm-dd
> +	%ptRt		HH:MM:SS
> +	%ptR[dt][rv]
> +
> +For printing date and time as represented by struct rtc_time structure in
> +human readable format.
> +
> +By default year will be incremented by 1900 and month by 1. Use %ptRr (raw)
> +to suppress this behaviour. On the other hand when %ptRv is applied
> +validation mechanism will be in use, i.e. numbers out of range will be
> +replaced by ** or ****.
> +
> +Passed by reference.
> +
>  struct clk
>  ----------
>  
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 53527ea822b5..97b7d14961d6 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -418,6 +418,11 @@ struct_va_format(void)
>  {
>  }
>  
> +static void __init
> +struct_rtc_time(void)
> +{
> +}
> +
>  static void __init
>  struct_clk(void)
>  {
> @@ -529,6 +534,7 @@ test_pointer(void)
>  	uuid();
>  	dentry();
>  	struct_va_format();
> +	struct_rtc_time();
>  	struct_clk();
>  	bitmap();
>  	netdev_features();
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 37a54a6dd594..8455cbda8d6c 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -30,6 +30,7 @@
>  #include <linux/ioport.h>
>  #include <linux/dcache.h>
>  #include <linux/cred.h>
> +#include <linux/rtc.h>
>  #include <linux/uuid.h>
>  #include <linux/of.h>
>  #include <net/addrconf.h>
> @@ -822,6 +823,20 @@ static const struct printf_spec default_dec_spec = {
>  	.precision = -1,
>  };
>  
> +static const struct printf_spec default_dec02_spec = {
> +	.base = 10,
> +	.field_width = 2,
> +	.precision = -1,
> +	.flags = ZEROPAD,
> +};
> +
> +static const struct printf_spec default_dec04_spec = {
> +	.base = 10,
> +	.field_width = 4,
> +	.precision = -1,
> +	.flags = ZEROPAD,
> +};
> +
>  static noinline_for_stack
>  char *resource_string(char *buf, char *end, struct resource *res,
>  		      struct printf_spec spec, const char *fmt)
> @@ -1549,6 +1564,127 @@ char *address_val(char *buf, char *end, const void *addr, const char *fmt)
>  	return special_hex_number(buf, end, num, size);
>  }
>  
> +static noinline_for_stack
> +char *date_str(char *buf, char *end, const struct rtc_time *tm, bool v, bool r)
> +{
> +	int year = tm->tm_year + (r ? 0 : 1900);
> +	int mon = tm->tm_mon + (r ? 0 : 1);
> +
> +	if (unlikely(v && (unsigned int)tm->tm_year > 200))
> +		buf = string(buf, end, "****", default_str_spec);

I think you should drop the validation option. This is only used in a
deprecated ABI and is mostly wrong as many RTCs will still be valid
after 2100.

> +	else
> +		buf = number(buf, end, year, default_dec04_spec);
> +
> +	if (buf < end)
> +		*buf = '-';
> +	buf++;
> +
> +	if (unlikely(v && (unsigned int)tm->tm_mon > 11))
> +		buf = string(buf, end, "**", default_str_spec);
> +	else
> +		buf = number(buf, end, mon, default_dec02_spec);
> +
> +	if (buf < end)
> +		*buf = '-';
> +	buf++;
> +
> +	if (unlikely(v && (unsigned int)tm->tm_mday > 31))
> +		buf = string(buf, end, "**", default_str_spec);

Same here, this doesn't protect February, April, June, September and
November. There is one RTC that think that 31st of November is valid.

> +	else
> +		buf = number(buf, end, tm->tm_mday, default_dec02_spec);
> +
> +	return buf;
> +}
> +
> +static noinline_for_stack
> +char *time_str(char *buf, char *end, const struct rtc_time *tm, bool v, bool r)
> +{
> +	if (unlikely(v && (unsigned int)tm->tm_hour > 24))
> +		buf = string(buf, end, "**", default_str_spec);
> +	else
> +		buf = number(buf, end, tm->tm_hour, default_dec02_spec);
> +
> +	if (buf < end)
> +		*buf = ':';
> +	buf++;
> +
> +	if (unlikely(v && (unsigned int)tm->tm_min > 59))
> +		buf = string(buf, end, "**", default_str_spec);
> +	else
> +		buf = number(buf, end, tm->tm_min, default_dec02_spec);
> +
> +	if (buf < end)
> +		*buf = ':';
> +	buf++;
> +
> +	if (unlikely(v && (unsigned int)tm->tm_sec > 59))
> +		buf = string(buf, end, "**", default_str_spec);

Some RTCs will consider 60 valid. So, really, instead of fixing all of
those, I'd just get rid of the validation option.

> +	else
> +		buf = number(buf, end, tm->tm_sec, default_dec02_spec);
> +
> +	return buf;
> +}
> +
> +static noinline_for_stack
> +char *rtc_str(char *buf, char *end, const struct rtc_time *tm, const char *fmt)
> +{
> +	bool have_t = true, have_d = true;
> +	bool validate = false;
> +	bool raw = false;
> +	int count = 2;
> +	bool found;
> +
> +	switch (fmt[count]) {
> +	case 'd':
> +		have_t = false;
> +		count++;
> +		break;
> +	case 't':
> +		have_d = false;
> +		count++;
> +		break;
> +	}
> +
> +	found = true;
> +	do {
> +		switch (fmt[count++]) {
> +		case 'r':
> +			raw = true;
> +			break;
> +		case 'v':
> +			validate = true;
> +			break;
> +		default:
> +			found = false;
> +			break;
> +		}
> +	} while (found);
> +
> +	if (have_d)
> +		buf = date_str(buf, end, tm, validate, raw);
> +	if (have_d && have_t) {
> +		if (buf < end)
> +			*buf = ' ';

I'd go for ISO 8601 and use a 'T' here.

> +		buf++;
> +	}
> +	if (have_t)
> +		buf = time_str(buf, end, tm, validate, raw);
> +
> +	return buf;
> +}
> +
> +static noinline_for_stack
> +char *timeanddate(char *buf, char *end, void *ptr, struct printf_spec spec,
> +		  const char *fmt)
> +{
> +	switch (fmt[1]) {
> +	case 'R':
> +		return rtc_str(buf, end, (const struct rtc_time *)ptr, fmt);
> +	default:
> +		return ptr_to_id(buf, end, ptr, spec);
> +	}
> +}
> +
>  static noinline_for_stack
>  char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
>  	    const char *fmt)
> @@ -1828,6 +1964,8 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>   * - 'd[234]' For a dentry name (optionally 2-4 last components)
>   * - 'D[234]' Same as 'd' but for a struct file
>   * - 'g' For block_device name (gendisk + partition number)
> + * - 't[R][dt][rv]' For time and date as represented:
> + *      R    struct rtc_time
>   * - 'C' For a clock, it prints the name (Common Clock Framework) or address
>   *       (legacy clock framework) of the clock
>   * - 'Cn' For a clock, it prints the name (Common Clock Framework) or address
> @@ -1952,6 +2090,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  		return address_val(buf, end, ptr, fmt);
>  	case 'd':
>  		return dentry_name(buf, end, ptr, spec, fmt);
> +	case 't':
> +		return timeanddate(buf, end, ptr, spec, fmt);
>  	case 'C':
>  		return clock(buf, end, ptr, spec, fmt);
>  	case 'D':
> -- 
> 2.19.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
