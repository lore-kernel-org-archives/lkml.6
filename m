Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367C1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22F220838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22F220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeJaOrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:47:33 -0400
Received: from ozlabs.org ([203.11.71.1]:54655 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbeJaOrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:47:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42lHWK1DbLz9s5c;
        Wed, 31 Oct 2018 16:50:52 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        reiserfs-devel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] reiserfs: remove workaround code for GCC 3.x
In-Reply-To: <1535337230-13222-1-git-send-email-yamada.masahiro@socionext.com>
References: <1535337230-13222-1-git-send-email-yamada.masahiro@socionext.com>
Date:   Wed, 31 Oct 2018 16:50:50 +1100
Message-ID: <87o9bais05.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> bumped the minimum GCC version to 4.6 for all architectures.
>
> The workaround code in fs/reiserfs/Makefile is obsolete now.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  fs/reiserfs/Makefile | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/fs/reiserfs/Makefile b/fs/reiserfs/Makefile
> index a39a562..bd29c58 100644
> --- a/fs/reiserfs/Makefile
> +++ b/fs/reiserfs/Makefile
> @@ -26,14 +26,5 @@ ifeq ($(CONFIG_REISERFS_FS_POSIX_ACL),y)
>  reiserfs-objs += xattr_acl.o
>  endif
>  
> -# gcc -O2 (the kernel default)  is overaggressive on ppc32 when many inline
> -# functions are used.  This causes the compiler to advance the stack
> -# pointer out of the available stack space, corrupting kernel space,
> -# and causing a panic. Since this behavior only affects ppc32, this ifeq
> -# will work around it. If any other architecture displays this behavior,
> -# add it here.
> -ccflags-$(CONFIG_PPC32) := $(call cc-ifversion, -lt, 0400, -O1)
> -
>  TAGS:
>  	etags *.c

Oh wow that's gross. Thanks for cleaning it up.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
