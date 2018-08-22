Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0021C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D173208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Kp1kipQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D173208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeHVSDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:03:22 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:39784 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbeHVSDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:03:22 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id B05025C0934;
        Wed, 22 Aug 2018 16:38:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1534948689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87aA3Vmf1ef8OfgYcsPDmJP+wsMjVljSL9Ffv2L/7q8=;
        b=Kp1kipQKGJCjPfFMJMlJPXaFh/TJFa8X6um3fpnUfja8FB3gnzWN2KrQOxzVg4Ty99eJqY
        tK2vaYsH1Glb1X9Tr+l3SdfaSWfmDKfwfDBTrHpx0VT1/ITV+1JAsmuZ/z41K4fJzIyfCT
        ZPcOc0Nyaao4ReTt8IfS97c1h6+xRto=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Aug 2018 16:38:09 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: use choice for kernel unwinders
In-Reply-To: <CAK8P3a0oaMS12R4tazChMHENQduO0-Wb-gw-inKjH0oz7_5s3g@mail.gmail.com>
References: <20180821222416.7771-1-stefan@agner.ch>
 <CAK8P3a0oaMS12R4tazChMHENQduO0-Wb-gw-inKjH0oz7_5s3g@mail.gmail.com>
Message-ID: <77d139d225e16b90d9b8da1982a11707@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.2018 12:02, Arnd Bergmann wrote:
> On Wed, Aug 22, 2018 at 12:24 AM Stefan Agner <stefan@agner.ch> wrote:
>>
>> While in theory multiple unwinders could be compiled in, it does
>> not make sense in practise. Use a choice to make the unwinder
>> selection mutually exclusive and mandatory.
>>
>> Already before this commit it has not been possible to deselect
>> FRAME_POINTER. Remove the obsolete comment.
>>
>> Furthermore, to produce a meaningful backtrace with FRAME_POINTER
>> enabled the kernel needs a specific function prologue:
>>     mov    ip, sp
>>     stmfd    sp!, {fp, ip, lr, pc}
>>     sub    fp, ip, #4
>>
>> To get to the required prologue gcc uses apcs and no-sched-prolog.
>> This compiler options are not available on clang, and clang is not
>> able to generate the required prologue. Make the FRAME_POINTER
>> config symbol depending on !clang.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Looks ok to me. I've added it to my randconfig test environment, you
> will hear from me within a day if I run into build regressions.
> 
> We may still want to clean up these three lines:
> 
> lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC &&
> !ARM_UNWIND && !S390 && !MICROBLAZE && !ARC && !X86
> lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC && !S390 &&
> !MICROBLAZE && !ARM_UNWIND && !ARC && !X86
> lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC && !S390 &&
> !MICROBLAZE && !ARM_UNWIND && !ARC && !X86
> 
> in which ARM is the odd case that currently depends on an architecture
> specific rather than the architecture itself.

I guess we would just follow X86 lead by saying ARM is guaranteed to
have unwinding support, and hence we can add !ARM.

> We could introduce a 'config ARCH_HAS_UNWINDER' symbol that gets
> selected by mips, ppc, s390, microblaze, arm and x86 unconditionally,
> and then simplify the 'select' statements here.

Yeah I was thinking about something like that too.

It seems to be a bit weird to me that lib/Kconfig.debug selects a
specific stack unwinding technique...

Ideally other config symbol should just ask arch to make sure a
unwinding technique is available (NEED_STACK_UNWINDING?) and arch then
makes sure to provide a reasonable default.

This then also would make it possible to select no stack unwinding in
case arch supports that and all the users of stack unwinding are
disabled too. Not sure how that exactly would look like in Kconfig, I
was thinking like:

choice
    prompt "Choose kernel unwinder"
    optional if !NEED_STACK_UNWINDING
    default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
    default UNWINDER_FRAME_POINTER if !AEABI || FUNCTION_GRAPH_TRACER

But "optional if" does not exist yet :-)

Reading the comments in arch/arm/Kconfig.debug seems to suggest that
once upon a time it was possible to disable stack unwinding on ARM.

But then, maybe we don't really want to go there? Might be interesting
for tinification efforts.

--
Stefan
