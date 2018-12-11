Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3258CC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0CA2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0CA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeLKVah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:30:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:25194 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeLKVah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:30:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 13:30:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="117986239"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 11 Dec 2018 13:30:33 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gWpbr-0003Ll-PC; Tue, 11 Dec 2018 23:30:31 +0200
Date:   Tue, 11 Dec 2018 23:30:31 +0200
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
Message-ID: <20181211213031.GF10650@smile.fi.intel.com>
References: <20181211152113.8523-1-thomas.preston@codethink.co.uk>
 <20181211152113.8523-3-thomas.preston@codethink.co.uk>
 <CAHk-=wi2kvoDh3z_X3ZCBcyAX1MU4OedPkQjA-4=bR=6q7AT3w@mail.gmail.com>
 <20181211180458.GE10650@smile.fi.intel.com>
 <CAHk-=wiDkpCdOdEHeSHKVwr6d5RJdVn7mLZaJO-mZkR=7hYkCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiDkpCdOdEHeSHKVwr6d5RJdVn7mLZaJO-mZkR=7hYkCA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:19:08AM -0800, Linus Torvalds wrote:
> On Tue, Dec 11, 2018 at 10:05 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > I think it's slightly more complicated, I run the following test case on glibc:
> >
> >         uint32_t hi, lo, t;
> >
> >         sscanf("00fafafafa0d0b0b0b0c000000", "%8x%8x%x", &hi, &lo, &t);
> >
> > 64-bit:
> >         HI: 00fafafa LO: fa0d0b0b (c000000)
> > 32-bit:
> >         HI: 00fafafa LO: fa0d0b0b (ffffffff)
> 
> But that's exactly the values my pseudo-code gets (well, my
> "pseudo-code obviously just said
> 
>     // Now do "sign" and range checking on val
> 
> The three sub-parts are: "00fafafa" "fa0d0b0b" and "0b0c000000"
> 
> and the third one encounters an overflow in "long" on 32-bit, so it
> turns into ~0.
> 
> And yes, the 64-bit "long" in that third value gets truncated to
> "uint32" when written to "t" (which is wht that "0b" part just gets
> lost.
> 
> And that's just because of historical C scanf behavior. There's no
> overflow checking in "int". Only in "long" and "long long".

Yes, that's what my test case showed.

So, whatever implementation would be done, I think it is a good time
to introduce some test cases.

P.S. I have briefly checked and didn't find a single test case for scanf().
Maybe I looked to the wrong module(s), but test_printf.c might be more or less a good choice.

-- 
With Best Regards,
Andy Shevchenko


