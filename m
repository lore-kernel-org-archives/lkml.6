Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B77DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A50E2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn3meXFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A50E2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeJPSkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbeJPSkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:40:47 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42D9B2089E;
        Tue, 16 Oct 2018 10:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539687056;
        bh=m6BkLeRjRJKtqLLYvRuVOGZ+TJMI8JRstcZ8V81HXR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wn3meXFSNoEgnvlhLVDtUy5BurBXchLLuBcmMnCKLCcPAkkIWK61SLabXgZ+h9M2O
         JY72mOejH/gL5NhytHJsDnFBA4igCIfkxyJgKCq98MtEx42FhJpMitDU8Ivdkbk3JZ
         dUPsngcyO27mqRxR4aujX04myaPfVJ2O6zvPkYis=
Date:   Tue, 16 Oct 2018 12:50:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v6 3/4] devres: provide devm_kstrdup_const()
Message-ID: <20181016105054.GC4768@kroah.com>
References: <20181014152010.2021-1-brgl@bgdev.pl>
 <20181014152010.2021-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181014152010.2021-4-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 05:20:09PM +0200, Bartosz Golaszewski wrote:
> Provide a resource managed version of kstrdup_const(). This variant
> internally calls devm_kstrdup() on pointers that are outside of
> .rodata section and returns the string as is otherwise.
> 
> Make devm_kfree() check if the passed pointer doesn't point to .rodata
> and if so - don't actually destroy the resource.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/devres.c  | 31 +++++++++++++++++++++++++++++++
>  include/linux/device.h |  2 ++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 438c91a43508..00c70f0fcdcd 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -11,6 +11,8 @@
>  #include <linux/slab.h>
>  #include <linux/percpu.h>
>  
> +#include <asm/sections.h>
> +
>  #include "base.h"
>  
>  struct devres_node {
> @@ -822,6 +824,28 @@ char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp)
>  }
>  EXPORT_SYMBOL_GPL(devm_kstrdup);
>  
> +/**
> + * devm_kstrdup_const - resource managed conditional string duplication
> + * @dev: device for which to duplicate the string
> + * @s: the string to duplicate
> + * @gfp: the GFP mask used in the kmalloc() call when allocating memory
> + *
> + * Strings allocated by devm_kstrdup_const will be automatically freed when
> + * the associated device is detached.
> + *
> + * RETURNS:
> + * Source string if it is in .rodata section otherwise it falls back to
> + * devm_kstrdup.
> + */
> +const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp)
> +{
> +	if (is_kernel_rodata((unsigned long)s))
> +		return s;
> +
> +	return devm_kstrdup(dev, s, gfp);
> +}
> +EXPORT_SYMBOL(devm_kstrdup_const);

This should be EXPORT_SYMBOL_GPL() to match the rest of the file.  I'll
go fix that up when I apply it.

thanks,

greg k-h
