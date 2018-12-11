Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19498C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5E320879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5E320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeLKSFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:05:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:62974 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbeLKSFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:05:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 10:05:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="282759412"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2018 10:05:00 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gWmOw-0002DZ-TV; Tue, 11 Dec 2018 20:04:58 +0200
Date:   Tue, 11 Dec 2018 20:04:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     thomas.preston@codethink.co.uk,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>, geert+renesas@glider.be,
        Jonathan Corbet <corbet@lwn.net>, tcharding <me@tobin.cc>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        ben.dooks@codethink.co.uk
Subject: Re: [PATCH 2/2] vsprintf: Stop using obsolete simple_strtoul()
Message-ID: <20181211180458.GE10650@smile.fi.intel.com>
References: <20181211152113.8523-1-thomas.preston@codethink.co.uk>
 <20181211152113.8523-3-thomas.preston@codethink.co.uk>
 <CAHk-=wi2kvoDh3z_X3ZCBcyAX1MU4OedPkQjA-4=bR=6q7AT3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi2kvoDh3z_X3ZCBcyAX1MU4OedPkQjA-4=bR=6q7AT3w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 09:22:22AM -0800, Linus Torvalds wrote:
> On Tue, Dec 11, 2018 at 7:21 AM Thomas Preston
> <thomas.preston@codethink.co.uk> wrote:
> >
> > Stop using the obsolete functions simple_strtoul() and
> > simple_strtoull(). Instead, we should use the improved kstrtol() and
> > kstrtoll() functions. To do this, we must copy the current field into a
> > null-terminated tmpstr and advance the variable `next` manually.
> 
> I see what you're trying to do, but this fix is much much worse than
> the bug was.
> 
> > +               if (field_width > 0) {
> > +                       char tmpstr[INT_BUF_LEN];
> > +                       int ret;
> > +
> > +                       strscpy(tmpstr, str, field_width+1);
> 
> If field_width is larger than INT_BUF_LEN, you are now corrupting kernel stack.
> 
> And no, you can't fix it by limiting field_width, since a large
> field_width is quite possible and might even be valid - and still fit
> in an int. Maybe the number is
> 
>     000000000000000000000001
> 
> or something?
> 
> A fix might be to skip leading zeroes.
> 
> Honestly, just do it by hand. Don't use kstrol and friends at all.
> Just do something like
> 
>     unsigned long long val = 0;
>     p = str;
>     for (;;) {
>         int c;
>         if (field_width > 0 && p - str >= field_width)
>             break;
>         c = hexval(*p++);
>         if (c < 0 || c > base)
>             break;
>         val = val * base + c;
>         // check for overflow

I think it's slightly more complicated, I run the following test case on glibc:

	uint32_t hi, lo, t;

        sscanf("00fafafafa0d0b0b0b0c000000", "%8x%8x%x", &hi, &lo, &t);

64-bit:
	HI: 00fafafa LO: fa0d0b0b (c000000)
32-bit:
	HI: 00fafafa LO: fa0d0b0b (ffffffff)

>     }
>     /* Now do "sign" and range checking on val */
>     /* Ta-daa, all done */
> 
> or similar.  Treat the above as pseudo-code, I didn't fill in all the details.
> 
>             Linus

-- 
With Best Regards,
Andy Shevchenko


