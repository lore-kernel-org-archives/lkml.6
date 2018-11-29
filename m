Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1213AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23C621019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGPJ1hIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23C621019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbeK3CID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:08:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728787AbeK3CIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:08:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15D9C2082F;
        Thu, 29 Nov 2018 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543503743;
        bh=7Xx1EbM+HfVYfGRaJ/LZZwcUlPvH0W0etgnu7fLP2No=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LGPJ1hILkeVUFTi/azWAEsqMiD8AYdQiLSLOGAjjLKrLeOJVF8Ysk0rUnS0raJVBj
         8sJEqOpjF3Na/HSdIXJ8q/7cG5R2t341gnSF6CBeNZjcs9UdubWQIDmDHsVsxytfY4
         4k8qxakQNcf0ql6wRWX3N/s+HyB6/TvQ/mEdJI2E=
Date:   Thu, 29 Nov 2018 16:02:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, sashal@kernel.org
Subject: Re: [PATCH 4.9 39/92] efi/arm: Revert deferred unmap of early memmap
 mapping
Message-ID: <20181129150221.GB22451@kroah.com>
References: <20181129140106.520639693@linuxfoundation.org>
 <20181129140109.438834361@linuxfoundation.org>
 <CAKv+Gu8cPOQaYY_KH3dq+2U517z7j67Od+Cxe+wB4gkEOqnQTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8cPOQaYY_KH3dq+2U517z7j67Od+Cxe+wB4gkEOqnQTA@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:28:44PM +0100, Ard Biesheuvel wrote:
> On Thu, 29 Nov 2018 at 15:21, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > [ Upstream commit 33412b8673135b18ea42beb7f5117ed0091798b6 ]
> >
> > Commit:
> >
> >   3ea86495aef2 ("efi/arm: preserve early mapping of UEFI memory map longer for BGRT")
> >
> > deferred the unmap of the early mapping of the UEFI memory map to
> > accommodate the ACPI BGRT code, which looks up the memory type that
> > backs the BGRT table to validate it against the requirements of the UEFI spec.
> >
> > Unfortunately, this causes problems on ARM, which does not permit
> > early mappings to persist after paging_init() is called, resulting
> > in a WARN() splat. Since we don't support the BGRT table on ARM anway,
> > let's revert ARM to the old behaviour, which is to take down the
> > early mapping at the end of efi_init().
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-efi@vger.kernel.org
> > Fixes: 3ea86495aef2 ("efi/arm: preserve early mapping of UEFI memory ...")
> 
> This commit is only in v4.19 as far as I know. Does it even apply?

This commit is in the following releases:
	4.9.129 4.14.72 4.18.10 4.19

so it should apply :)

thanks,

greg k-h
