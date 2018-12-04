Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1CEC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45BB2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45BB2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeLDQMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:12:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:21166 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLDQMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:12:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 08:12:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,314,1539673200"; 
   d="scan'208";a="300946631"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 04 Dec 2018 08:12:44 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gUDJS-0003SB-8v; Tue, 04 Dec 2018 18:12:42 +0200
Date:   Tue, 4 Dec 2018 18:12:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
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
Message-ID: <20181204161242.GD10650@smile.fi.intel.com>
References: <20181129105956.25933-1-andriy.shevchenko@linux.intel.com>
 <20181129105956.25933-3-andriy.shevchenko@linux.intel.com>
 <20181204133028.xkdnc5bqtqlnb3zu@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204133028.xkdnc5bqtqlnb3zu@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:30:28PM +0100, Petr Mladek wrote:
> On Thu 2018-11-29 12:59:40, Andy Shevchenko wrote:
> > There are users which print time and date represented by content of
> > struct rtc_time in human readable format.
> > 
> > Instead of open coding that each time introduce %ptR[dt][r] specifier.

> > +static void __init
> > +struct_rtc_time(void)
> > +{
> > +}
> 
> Just by chance, do you have any plans to add the test code? ;-)
> 
> I understand that you did now want to spend time on it before
> the real change was accepted.

You see, there were several iterations with no consensus on everything:
specifier format changed 3 times, for example.

But it might be good idea to eventually add couple simple tests at some point.

Is it a show stopper?

> > +	found = true;
> > +	do {
> > +		switch (fmt[count++]) {
> > +		case 'r':
> > +			raw = true;
> > +			break;
> > +		default:
> > +			found = false;
> > +			break;
> > +		}
> > +	} while (found);
> 
> I guess that the while cycle is remainder from an older version and
> should not be here. It handles only the final 'r' now.

See again above. Do you insist to make a change now?

> > +	if (have_d)
> > +		buf = date_str(buf, end, tm, raw);
> > +	if (have_d && have_t) {
> > +		/* Respect ISO 8601 */
> > +		if (buf < end)
> > +			*buf = 'T';
> 
> I checked several conversion patches and the original code did not use
> the ISO format. The change makes sense (even though I personally
> do not like the format much ;-)
> 
> Anyway, people might expect that the conversion is 1:1. The change
> should get mentioned in the affected patches so that people are
> not later surprised.

It's defined in cover letter, all ABI cases are _not_ changed.
The rest either information or, in most cases, debug messages.
Alexandre is OK with the change, he actually requested this.

> > +static noinline_for_stack
> > +char *timeanddate(char *buf, char *end, void *ptr, struct printf_spec spec,
> > +		  const char *fmt)
> 
> Please, rename the function to time_and_date(). It is the style used
> in this source file and it is much easier to read.

OK.

> Otherwise, the patch looks fine. It helps to remove the many variants
> of the code and unifies the output format.

Thanks for review!

-- 
With Best Regards,
Andy Shevchenko


