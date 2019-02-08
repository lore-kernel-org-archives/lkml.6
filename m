Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5660C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF7220855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfBHRZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:25:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:26170 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfBHRZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:25:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 09:25:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="scan'208";a="318754742"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 08 Feb 2019 09:25:19 -0800
Received: from andy by smile with local (Exim 4.92-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gs9tu-0007oN-ET; Fri, 08 Feb 2019 19:25:18 +0200
Date:   Fri, 8 Feb 2019 19:25:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/9] vsprintf: Consolidate handling of unknown pointer
 specifiers
Message-ID: <20190208172518.GV9224@smile.fi.intel.com>
References: <20190208152310.29531-1-pmladek@suse.com>
 <20190208152310.29531-8-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208152310.29531-8-pmladek@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 04:23:08PM +0100, Petr Mladek wrote:
> There are few printk formats that make sense only with two or more
> specifiers. Also some specifiers make sense only when a kernel feature
> is enabled.
> 
> The handling of unknown specifiers is inconsistent and not helpful.
> Using WARN() looks like an overkill for this type of error. pr_warn()
> is not good either. It would by handled via printk_safe buffer and
> it might be hard to match it with the problematic string.
> 
> A reasonable compromise seems to be writing the unknown format specifier
> into the original string with a question mark, for example (%pC?).
> It should be self-explaining enough. Note that it is in brackets
> to follow the (null) style.
> 

> Note that the changes in test_printf.c revert many changes made
> by the commit 4d42c44727a062e233 ("lib/vsprintf: Print time and
> date in human readable format via %pt\n"). The format %pt does
> not longer produce a hashed pointer.

It seems in further patch you partially restore back what was brought by that patch.
I would suggest not to touch at least changes for plain_pointer_to_buffer().

Also it would be nice to have a coverage for hashed pointers.

-- 
With Best Regards,
Andy Shevchenko


