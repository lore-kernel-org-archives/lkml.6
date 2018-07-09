Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C892C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF10208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF10208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754367AbeGIGxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:53:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:9480 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbeGIGw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:52:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 23:52:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,329,1526367600"; 
   d="scan'208";a="71123373"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2018 23:52:57 -0700
Message-ID: <f9c8cf81df29006bc9c79932f3bcd599b559b408.camel@linux.intel.com>
Subject: Re: [PATCH] x86/mtrr: don't copy out-of-bounds data in mtrr_write
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 09 Jul 2018 09:52:56 +0300
In-Reply-To: <20180706215003.156702-1-jannh@google.com>
References: <20180706215003.156702-1-jannh@google.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 23:50 +0200, Jann Horn wrote:
> Don't access the provided buffer out of bounds - this can cause a
> kernel
> out-of-bounds read when invoked through sys_splice() or other things
> that
> use kernel_write()/__kernel_write().
> 

Can you elaborate a bit this change?

Only few places in the kernel do this way and I would like to understand
 why in most of the cases it's okay to supply maximum available length
and here is not the one.


> Fixes: 7f8ec5a4f01a ("x86/mtrr: Convert to use strncpy_from_user()
> helper")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  arch/x86/kernel/cpu/mtrr/if.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mtrr/if.c
> b/arch/x86/kernel/cpu/mtrr/if.c
> index 4021d3859499..40eee6cc4124 100644
> --- a/arch/x86/kernel/cpu/mtrr/if.c
> +++ b/arch/x86/kernel/cpu/mtrr/if.c
> @@ -106,7 +106,8 @@ mtrr_write(struct file *file, const char __user
> *buf, size_t len, loff_t * ppos)
>  
>  	memset(line, 0, LINE_SIZE);
>  
> -	length = strncpy_from_user(line, buf, LINE_SIZE - 1);
> +	len = min_t(size_t, len, LINE_SIZE - 1);
> +	length = strncpy_from_user(line, buf, len);
>  	if (length < 0)
>  		return length;
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
