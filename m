Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF42DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5A220855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5A220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeKIRyL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:54:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:42858 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbeKIRyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:54:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2018 00:14:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,482,1534834800"; 
   d="scan'208";a="94910480"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.106])
  by FMSMGA003.fm.intel.com with SMTP; 09 Nov 2018 00:14:43 -0800
Received: by ubuntu (sSMTP sendmail emulation); Fri, 09 Nov 2018 16:14:39 +0800
Message-ID: <1541751278.79160.2.camel@intel.com>
Subject: Re: [PATCH] nios2: ksyms: Add missing symbol exports
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org
Date:   Fri, 09 Nov 2018 16:14:38 +0800
In-Reply-To: <1538924000-17898-1-git-send-email-linux@roeck-us.net>
References: <1538924000-17898-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-10-07 at 07:53 -0700, Guenter Roeck wrote:
> Building nios2:allmodconfig fails as follows (each symbol is only
> listed
> once).
> 
> ERROR: "__ashldi3" [drivers/md/dm-writecache.ko] undefined!
> ERROR: "__ashrdi3" [fs/xfs/xfs.ko] undefined!
> ERROR: "__ucmpdi2" [drivers/media/i2c/adv7842.ko] undefined!
> ERROR: "__lshrdi3" [drivers/md/dm-zoned.ko] undefined!
> ERROR: "flush_icache_range" [drivers/misc/lkdtm/lkdtm.ko] undefined!
> ERROR: "empty_zero_page" [drivers/md/dm-mod.ko] undefined!
> 
> The problem is seen with gcc 7.3.0.
> 
> Export the missing symbols.
> 
> Fixes: 2fc8483fdcde ("nios2: Build infrastructure")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>

> ---
>  arch/nios2/kernel/nios2_ksyms.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/nios2/kernel/nios2_ksyms.c
> b/arch/nios2/kernel/nios2_ksyms.c
> index bf2f55d10a4d..4e704046a150 100644
> --- a/arch/nios2/kernel/nios2_ksyms.c
> +++ b/arch/nios2/kernel/nios2_ksyms.c
> @@ -9,12 +9,20 @@
>  #include <linux/export.h>
>  #include <linux/string.h>
> 
> +#include <asm/cacheflush.h>
> +#include <asm/pgtable.h>
> +
>  /* string functions */
> 
>  EXPORT_SYMBOL(memcpy);
>  EXPORT_SYMBOL(memset);
>  EXPORT_SYMBOL(memmove);
> 
> +/* memory management */
> +
> +EXPORT_SYMBOL(empty_zero_page);
> +EXPORT_SYMBOL(flush_icache_range);
> +
>  /*
>   * libgcc functions - functions that are used internally by the
>   * compiler...  (prototypes are not correct though, but that
> @@ -31,3 +39,7 @@ DECLARE_EXPORT(__udivsi3);
>  DECLARE_EXPORT(__umoddi3);
>  DECLARE_EXPORT(__umodsi3);
>  DECLARE_EXPORT(__muldi3);
> +DECLARE_EXPORT(__ucmpdi2);
> +DECLARE_EXPORT(__lshrdi3);
> +DECLARE_EXPORT(__ashldi3);
> +DECLARE_EXPORT(__ashrdi3);
> --
> 2.7.4
> 
> 
> ________________________________
> 
> Confidentiality Notice.
> This message may contain information that is confidential or
> otherwise protected from disclosure. If you are not the intended
> recipient, you are hereby notified that any use, disclosure,
> dissemination, distribution, or copying of this message, or any
> attachments, is strictly prohibited. If you have received this
> message in error, please advise the sender by reply e-mail, and
> delete the message and any attachments. Thank you.
