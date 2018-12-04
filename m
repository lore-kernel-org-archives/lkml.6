Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE91C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C37208E7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C37208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeLDQi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:38:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:7130 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLDQi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:38:58 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 08:38:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,314,1539673200"; 
   d="scan'208";a="115902335"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 04 Dec 2018 08:38:52 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gUDik-0003jU-02; Tue, 04 Dec 2018 18:38:50 +0200
Date:   Tue, 4 Dec 2018 18:38:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 02/21] lib/vsprintf: Print time and date in human
 readable format via %pt
Message-ID: <20181204163849.GE10650@smile.fi.intel.com>
References: <20181129105956.25933-1-andriy.shevchenko@linux.intel.com>
 <20181129105956.25933-3-andriy.shevchenko@linux.intel.com>
 <20181204133028.xkdnc5bqtqlnb3zu@pathway.suse.cz>
 <20181204161242.GD10650@smile.fi.intel.com>
 <CAMuHMdUXQX=Y6K5XZok38W75KSBM+5PNRMKMhavNG_JtbxoNAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUXQX=Y6K5XZok38W75KSBM+5PNRMKMhavNG_JtbxoNAw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 05:16:58PM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 4, 2018 at 5:12 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Dec 04, 2018 at 02:30:28PM +0100, Petr Mladek wrote:
> > > On Thu 2018-11-29 12:59:40, Andy Shevchenko wrote:
> > > > There are users which print time and date represented by content of
> > > > struct rtc_time in human readable format.
> > > >
> > > > Instead of open coding that each time introduce %ptR[dt][r] specifier.
> >
> > > > +static void __init
> > > > +struct_rtc_time(void)
> > > > +{
> > > > +}
> > >
> > > Just by chance, do you have any plans to add the test code? ;-)
> > >
> > > I understand that you did now want to spend time on it before
> > > the real change was accepted.
> >
> > You see, there were several iterations with no consensus on everything:
> > specifier format changed 3 times, for example.
> >
> > But it might be good idea to eventually add couple simple tests at some point.
> >
> > Is it a show stopper?
> 
> Can the user trigger formatting, and exploit a bug in the formatting code?

Might happen, it's a software at the end.
Do we need to revisit all formatting specifiers right now?

In any case, to be productive out of this discussion, I would like to gather
test cases you want to see.

-- 
With Best Regards,
Andy Shevchenko


