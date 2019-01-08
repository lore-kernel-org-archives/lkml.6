Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01D0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927192070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfAHIqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:46:13 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60827 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727745AbfAHIqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:46:13 -0500
X-IronPort-AV: E=Sophos;i="5.56,453,1539619200"; 
   d="scan'208";a="51545107"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Jan 2019 16:46:05 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 585F04BAC80B;
        Tue,  8 Jan 2019 16:46:04 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 8 Jan 2019 16:46:03 +0800
Subject: Re: [PATCH] x86/boot: drop memset from copy.S
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
References: <20190107074056.12532-1-caoj.fnst@cn.fujitsu.com>
Message-ID: <4bb8f61a-f93c-4b30-9990-ecf5a8ddc998@cn.fujitsu.com>
Date:   Tue, 8 Jan 2019 16:46:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107074056.12532-1-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 585F04BAC80B.A9274
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One more question: in compressed/, for mem*(), it seems we both use the
macros of boot/string.h, and the functions of compressed/string.c. Is
that what we want?

compressed/ is compiled with -O2, so it cannot be told by objdump -d,
but still can be confirmed by nm <*.o>, for example:

$nm arch/x86/boot/compressed/eboot.o
                 U memcpy
                 U memset

$nm arch/x86/boot/compressed/pgtable_64.o
                 # No entry of mem*()

both of eboot.c and pgtable_64.c #include "../string.h", and use some of
 mem*(), it is counter-intuitive to me. Very appreciate it someone can
leave a hint.

-- 
Sincerely,
Cao jin

On 1/7/19 3:40 PM, Cao jin wrote:
> According to objdump output of setup, function memset is not used in
> setup code. Currently, all usage of memset in setup come from macro
> definition of string.h.
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
> Compiled and booted under x86_64; compiled under i386.
> 
> Questions: now there is 2 definition of memcpy, one lies in copy.S,
> another lies in string.h which is mapped to gcc builtin function. Do we
> still need 2 definition? Could we move the content of copy.S to
> boot/string.c?
> 
> At first glance, the usage of string.{c.h} of setup is kind of confusing,
> they are also used in compressed/ and purgatory/
> 
>  arch/x86/boot/copy.S | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/arch/x86/boot/copy.S b/arch/x86/boot/copy.S
> index 15d9f74b0008..5157d08b0ff2 100644
> --- a/arch/x86/boot/copy.S
> +++ b/arch/x86/boot/copy.S
> @@ -33,21 +33,6 @@ GLOBAL(memcpy)
>  	retl
>  ENDPROC(memcpy)
>  
> -GLOBAL(memset)
> -	pushw	%di
> -	movw	%ax, %di
> -	movzbl	%dl, %eax
> -	imull	$0x01010101,%eax
> -	pushw	%cx
> -	shrw	$2, %cx
> -	rep; stosl
> -	popw	%cx
> -	andw	$3, %cx
> -	rep; stosb
> -	popw	%di
> -	retl
> -ENDPROC(memset)
> -
>  GLOBAL(copy_from_fs)
>  	pushw	%ds
>  	pushw	%fs
> 


