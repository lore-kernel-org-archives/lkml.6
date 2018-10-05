Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99397C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4300E20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QeXvx906"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4300E20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeJEQZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:25:05 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47712 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeJEQZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:25:05 -0400
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0E8FB19E6;
        Fri,  5 Oct 2018 11:27:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538731629;
        bh=lu2GSoBJRMytTGh30rW+64ufgUKMR+Mgyc9gMqAXliY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QeXvx90656pLyOSMte7rQ+vbYQbTzJ2irnJRsh8HA3uN7E5WuantybMdyGACNUPzo
         UCGAhWwNjHXFZoxPeAXnk//wmBjAs+JbShI/iC51VUy2FDSb6eebe5vdo50JPVrKJJ
         IyPOrXC8SLmNbEkHzvmyrt3Aycw57u2dsHwZbkME=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH] kbuild: fix kernel/bounds.c 'W=1' warning
To:     Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@aculab.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
 <20181005083313.2088252-1-arnd@arndb.de>
 <08b190b9dabd4625ae3d636b88b43ccb@AcuMS.aculab.com>
 <CAK8P3a0ZWfjGfpCRzoVw9vg=xg2ov2c7et_qTi5mzd81_RParQ@mail.gmail.com>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <56169e56-2cbd-dc70-e324-44f8e511a1e7@ideasonboard.com>
Date:   Fri, 5 Oct 2018 10:27:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0ZWfjGfpCRzoVw9vg=xg2ov2c7et_qTi5mzd81_RParQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/18 10:07, Arnd Bergmann wrote:
> On Fri, Oct 5, 2018 at 10:52 AM David Laight <David.Laight@aculab.com> wrote:
>>
>> From: Arnd Bergmann
>>> Sent: 05 October 2018 09:33
>>>
>>> Building any configuration with 'make W=1' produces a warning:
>>>
>>> kernel/bounds.c:16:6: warnign: no previous prototype for 'foo' [-Wmissing-prototypes]
>>>
>>> When also passing -Werror, this prevents us from building any
>>> other files. Nobody ever calls the function, but we can't make
>>> it 'static' either since we want the compiler output.
>>>
>>> Calling it 'main' instead however avoids the warning, because gcc
>>> does not insist on having a declaration for main.
>>
>> Ugg.
>> main() might be special in other ways too.
>> It wouldn't surprise me if some linkers don't do special stuff for it.

I worried about this but didn't think it would be too much of an issue.
But perhaps we should check...

<compile bounds.s in both configurations> as bounds.s.foo and bounds.s.main:


 diff -Nurp bounds.s.*
--- bounds.s.foo        2018-10-05 10:20:53.269941404 +0100
+++ bounds.s.main       2018-10-05 10:20:31.375891260 +0100
@@ -108,11 +108,12 @@

        .global _mcount
 #NO_APP
+       .section        .text.startup,"ax",@progbits
        .align  2
        .p2align 3,,7
-       .global foo
-       .type   foo, %function
-foo:
+       .global main
+       .type   main, %function
+main:
        stp     x29, x30, [sp, -16]!    //,,,
        add     x29, sp, 0      //,,
 // /home/linuxembedded/iob/renesas/vsp1/sources/linux/kernel/bounds.c:17: {
@@ -139,10 +140,11 @@ foo:

 .ascii "->SPINLOCK_SIZE 56 sizeof(spinlock_t)" //
 // 0 "" 2
-// /home/linuxembedded/iob/renesas/vsp1/sources/linux/kernel/bounds.c:26: }
+// /home/linuxembedded/iob/renesas/vsp1/sources/linux/kernel/bounds.c:28: }
 #NO_APP
+       mov     w0, 0   //,
        ldp     x29, x30, [sp], 16      //,,,
        ret
-       .size   foo, .-foo
+       .size   main, .-main
        .ident  "GCC: (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0"
        .section        .note.GNU-stack,"",@progbits



compiled with aarch64-linux-gnu-gcc, and with no debug enabled.

Other than the entry point rename (and section name) and the return
value being added, I can't see anything problematic here.

And as far as I know - this file gets processed after to extract
definitions which should be independent. This file is not executed or
further compiled as far as I am aware.

--
Kieran



>>
>> What is wrong with just putting and extra "void foo(void);" before
>> the function?
> 
> Greg objected to that on the basis that we don't want declarations
> in .c files -- they should be in a shared header:
> 
> https://lkml.org/lkml/2018/9/21/735
> 
> I don't see what could go wrong here with calling it main(), after
> all we are just interested in the assembler output, not even
> creating an object file.
> 
>       Arnd
> 

