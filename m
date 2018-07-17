Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF82ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A931B2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A931B2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeGQK3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:29:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:50190 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbeGQK3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:29:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 02:57:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="54965934"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2018 02:57:25 -0700
Message-ID: <4a25d281a0e7f622872f1e9fe3abf44288ec87e4.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/3] lib: add crc64 calculation routines
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Date:   Tue, 17 Jul 2018 12:57:24 +0300
In-Reply-To: <20180717065711.28281-2-colyli@suse.de>
References: <20180717065711.28281-1-colyli@suse.de>
         <20180717065711.28281-2-colyli@suse.de>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 14:57 +0800, Coly Li wrote:
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

> + * crc64.h
> + *

Do we need file name in the file?

> + * See lib/crc64.c for the related specification and polynomical
> arithmetic.
> + */

> +// SPDX-License-Identifier: GPL-2.0

> +#include <linux/module.h>
> +#include <uapi/linux/types.h>

Why not simple linux/types.h ?

> +#include "crc64table.h"
> +
> +MODULE_DESCRIPTION("CRC64 calculations");

> +MODULE_LICENSE("GPL");

License mismatch with SPDX.

> +#include <inttypes.h>
> +#include <linux/swab.h>
> +#include <stdio.h>

I would follow the common grouping of the headers, like more generic
first, more particular last:

inttupes
stdio

linux/foo

asm/bar

> +#include "../usr/include/asm/byteorder.h"

Hmm...


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
