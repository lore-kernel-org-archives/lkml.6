Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E370DECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A448E20779
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A448E20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbeGQQQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:16:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:64704 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729755AbeGQQQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:16:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 08:43:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,366,1526367600"; 
   d="scan'208";a="55690109"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2018 08:43:06 -0700
Message-ID: <8f62965ad89f82b0f4bd73d6e5acf352dc2b767e.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/3] lib: add crc64 calculation routines
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Eric Biggers <ebiggers3@gmail.com>
Date:   Tue, 17 Jul 2018 18:43:05 +0300
In-Reply-To: <20180717145525.50852-2-colyli@suse.de>
References: <20180717145525.50852-1-colyli@suse.de>
         <20180717145525.50852-2-colyli@suse.de>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 22:55 +0800, Coly Li wrote:
> This patch adds the re-write crc64 calculation routines for Linux
> kernel.
> The CRC64 polynomical arithmetic follows ECMA-182 specification,
> inspired
> by CRC paper of Dr. Ross N. Williams
> (see http://www.ross.net/crc/download/crc_v3.txt) and other public
> domain
> implementations.
> 
> All the changes work in this way,
> - When Linux kernel is built, host program lib/gen_crc64table.c will
> be
>   compiled to lib/gen_crc64table and executed.
> - The output of gen_crc64table execution is an array called as lookup
>   table (a.k.a POLY 0x42f0e1eba9ea369) which contain 256 64bits-long
>   numbers, this talbe is dumped into header file lib/crc64table.h.
> - Then the header file is included by lib/crc64.c for normal 64bit crc
>   calculation.
> - Function declaration of the crc64 calculation routines is placed in
>   include/linux/crc64.h

Thanks for an update! My comments below.

> Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As required by coding style this tag should be accompanied with SoB of
co-developer(s).

> +u64 __pure crc64_update(u64 crc, const void *_p, size_t len);

For sake of consistency I would name _len as well.

> + * Normal 64bit CRC calculation.

I think 64-bit form is slightly better and more often

$ git grep -n -w 64bit | wc -l
809

$ git grep -n -w 64-bit | wc -l
2957

> + * crc64table[256] is the lookup table of a table-driver 64bit CRC

Ditto.

> + * Copyright 2018 SUSE Linux.
> + *   Author: Coly Li <colyli@suse.de>

> + *

This (blank comment) line is not needed.

> +u64 __pure crc64_update(u64 crc, const void *_p, size_t len)

_len ?

> + * Copyright 2018 SUSE Linux.
> + *   Author: Coly Li <colyli@suse.de>

> + *

Not needed line.


> +#include <inttypes.h>
> +#include <stdio.h>

+ blank line? Would separate groups of headers logically.

> +#include <linux/swab.h>

> +static int64_t crc64_table[256] = {0,};

I guess {0} would work as well (no comma).

> +	printf("#include <uapi/linux/types.h>\n");
> +	printf("#include <linux/cache.h>\n\n");

Do wee need these? CRC32 case seems fine without.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
