Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8FBC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583BA20645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583BA20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeJBPEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:04:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:30067 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbeJBPEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:04:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 01:22:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,331,1534834800"; 
   d="scan'208";a="93831728"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 02 Oct 2018 01:21:44 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1g7Fw6-0005NM-TY; Tue, 02 Oct 2018 11:21:42 +0300
Date:   Tue, 2 Oct 2018 11:21:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v4 1/8] bitops: Introduce the for_each_set_clump
 macro
Message-ID: <20181002082142.GC15943@smile.fi.intel.com>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <f5250b9c78377e476667be1b616c86cf573b57dc.1538441919.git.vilhelm.gray@gmail.com>
 <40ecad49-2797-0d30-b52d-a2e6838dc1ab@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ecad49-2797-0d30-b52d-a2e6838dc1ab@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 09:42:48AM +0200, Rasmus Villemoes wrote:
> On 2018-10-02 03:13, William Breathitt Gray wrote:

> The cover letter says
> 
>   The clump_size argument can be an arbitrary number of bits and is not
>   required to be a multiple of 2.
> 
> by which I assume you mean "power of 2", but either way, the above code
> does not seem to take into account the case where bits_offset +
> clump_size straddles a word boundary, so it wouldn't work for a
> clump_size that does not divide BITS_PER_LONG.

E.g. 3 bits in a clump? Hmm...

Why would we need that? I mean some real use case?

> May I suggest another approach:

You may, of course, but see above and my comments below.

> unsigned long bitmap_get_value(const unsigned long *bitmap, unsigned
> start, unsigned width): Get the value of bitmap[start:start+width] for
> 1<=width<=BITS_PER_LONG (it's up to the caller to ensure this is within
> the defined region). That can almost be an inline
> 
> bitmap_get_value(const unsigned long *bitmap, unsigned start, unsigned
> width)
> {
>   unsigned idx = BIT_WORD(start);
>   unsigned offset = start % BITS_PER_LONG;
>   unsigned long lower = bitmap[idx] >> offset;
>   unsigned long upper = offset <= BITS_PER_LONG - width ? 0 :
> bitmap[idx+1] << (BITS_PER_LONG - offset);
>   return (lower | upper) & GENMASK(width-1, 0)
> }
> 
> Then you can implement the for_each_set_clump by a (IMO) more readable
> 
>   for (i = 0, start = 0; i < num_ports; i++, start += gpio_reg_size) {
>     word_mask = bitmap_get_value(mask, start, gpio_reg_size);
>     if (!word_mask)
>       continue;
>     ...
>   }

I would rather go with two prototypes to get()/set() a clump in the bitmap
in a way when it's aligned and BITS_PER_LONG % clump_size == 0.

unsigned long bitmap_get_clump(unsigned long *src, unsigned int start, unsigned int clump_size)
{
	unsigned int index = BIT_WORD(start);
	unsigned int offset = start % BITS_PER_LONG;


	/* These just for spelling the restrictions */
	WARN_ON(BITS_PER_LONG % clump_size);
	WARN_ON(offset % clump_size);

	/* TODO: take care of clump_size == 64 */
	return (bitmap[index] >> offset) & GENMASK(clump_size - 1, 0);
}

Something similar with set with additional parameter unsigned long value
which has MSB cleared till we reach [clump_size - 1 : 0].

-- 
With Best Regards,
Andy Shevchenko


