Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9E9C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3952081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3952081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeLDNag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:30:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:39350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbeLDNaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:30:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CD32AE21;
        Tue,  4 Dec 2018 13:30:30 +0000 (UTC)
Date:   Tue, 4 Dec 2018 14:30:28 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v5 02/21] lib/vsprintf: Print time and date in human
 readable format via %pt
Message-ID: <20181204133028.xkdnc5bqtqlnb3zu@pathway.suse.cz>
References: <20181129105956.25933-1-andriy.shevchenko@linux.intel.com>
 <20181129105956.25933-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129105956.25933-3-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-11-29 12:59:40, Andy Shevchenko wrote:
> There are users which print time and date represented by content of
> struct rtc_time in human readable format.
> 
> Instead of open coding that each time introduce %ptR[dt][r] specifier.
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

Just by chance, do you have any plans to add the test code? ;-)

I understand that you did now want to spend time on it before
the real change was accepted.


>  static void __init
>  struct_clk(void)
>  {
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 37a54a6dd594..b7114799b91f 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> +static noinline_for_stack
> +char *rtc_str(char *buf, char *end, const struct rtc_time *tm, const char *fmt)
> +{
> +	bool have_t = true, have_d = true;
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
> +		default:
> +			found = false;
> +			break;
> +		}
> +	} while (found);

I guess that the while cycle is remainder from an older version and
should not be here. It handles only the final 'r' now. 


> +	if (have_d)
> +		buf = date_str(buf, end, tm, raw);
> +	if (have_d && have_t) {
> +		/* Respect ISO 8601 */
> +		if (buf < end)
> +			*buf = 'T';

I checked several conversion patches and the original code did not use
the ISO format. The change makes sense (even though I personally
do not like the format much ;-)

Anyway, people might expect that the conversion is 1:1. The change
should get mentioned in the affected patches so that people are
not later surprised.


> +		buf++;
> +	}
> +	if (have_t)
> +		buf = time_str(buf, end, tm, raw);
> +
> +	return buf;
> +}
> +
> +static noinline_for_stack
> +char *timeanddate(char *buf, char *end, void *ptr, struct printf_spec spec,
> +		  const char *fmt)

Please, rename the function to time_and_date(). It is the style used
in this source file and it is much easier to read.

Otherwise, the patch looks fine. It helps to remove the many variants
of the code and unifies the output format.

Best Regards,
Petr
