Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B60DC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7AE20684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7AE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeJDTD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:03:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:38447 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbeJDTD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:03:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 05:10:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,338,1534834800"; 
   d="scan'208";a="268409948"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 04 Oct 2018 05:10:47 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1g82Ss-0007tM-9i; Thu, 04 Oct 2018 15:10:46 +0300
Date:   Thu, 4 Oct 2018 15:10:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v4 1/8] bitops: Introduce the for_each_set_clump
 macro
Message-ID: <20181004121046.GT15943@smile.fi.intel.com>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <f5250b9c78377e476667be1b616c86cf573b57dc.1538441919.git.vilhelm.gray@gmail.com>
 <40ecad49-2797-0d30-b52d-a2e6838dc1ab@rasmusvillemoes.dk>
 <20181002082142.GC15943@smile.fi.intel.com>
 <20181003114804.GE15943@smile.fi.intel.com>
 <20181004103620.GB4779@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004103620.GB4779@icarus>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 07:36:20PM +0900, William Breathitt Gray wrote:
> On Wed, Oct 03, 2018 at 02:48:04PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 02, 2018 at 11:21:42AM +0300, Andy Shevchenko wrote:
> > 
> > > I would rather go with two prototypes to get()/set() a clump in the bitmap
> > > in a way when it's aligned and BITS_PER_LONG % clump_size == 0.
> > 
> > To make things much easier, restrict clump_size to the one
> > from the following set:
> > 
> > 1, 2, 4, 8, 16, 32 even on 64-bit platforms.
> > 
> > If it would be simpler solution to add 64 here (implying 32-bit platform),
> > I would vote for that.
> > 
> > For the generic case we might need something like:
> > 
> > unsigned long bitmap_get_bits(unsigned long *src, unsigned int start, unsigned int nbits)
> > {
> > 	assert(nbits > BITS_PER_LONG);
> > 
> > 	/* Something like Rasmus proposed earlier */
> > }
> > 
> > And similar to setter.
> > 
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> 
> I have no objections to have a simplier macro for these common clump
> sizes -- afterall, I suspect most drivers will likely use clump sizes
> that are powers of 2 anyway. It would be nice to have a more versatile
> macro though for those drivers that would benefit from odd clump sizes,
> but we can perhaps postpone that until the need arises (the GPIO drivers
> in this patchset all use a power of 2).

Yes, this is my point of view: don't produce additional complexity to some
which has no users (yet).

When we would really have groups out of an odd bit number, we may reconsider.

-- 
With Best Regards,
Andy Shevchenko


