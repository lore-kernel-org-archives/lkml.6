Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14839C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7668206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7668206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeI2DHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:07:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60311 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbeI2DHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:07:36 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (fmdmzpr04-ext.fm.intel.com [192.55.54.39])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w8SKfpn4555004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 28 Sep 2018 13:41:52 -0700
Subject: Re: [PATCH] x86/boot: define CC_HAVE_ASM_GOTO
To:     Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        x86@kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180907202618.258569-1-ndesaulniers@google.com>
 <CAKwvOdn4BcKUjGnGgFfbGxbwvSh9mYLT1gJ_ozDHua1LcjJ1rw@mail.gmail.com>
 <20180925190829.GC15464@zn.tnic>
 <CAKwvOdmaUMmLAv-529A0ShW7et3Jnnmc4Agjody+VReN5feTeg@mail.gmail.com>
 <CAKwvOdmLSVH7EVGY1ExU1Fh_hvL=FUzhq-80snDfZ+QhCT2FOA@mail.gmail.com>
 <20180926090841.GC5745@zn.tnic>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <56442061-7f55-878d-5b26-7cdd14e901d2@zytor.com>
Date:   Fri, 28 Sep 2018 13:41:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926090841.GC5745@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/18 02:08, Borislav Petkov wrote:
> On Tue, Sep 25, 2018 at 02:13:16PM -0700, Nick Desaulniers wrote:
>> Orthogonally, do you know *why* this Makefile overwrites
>> KBUILD_CFLAGS?  We take great care to set various compiler flags in
>> the top level Makefile, so to reset them lower in the tree seems
>> troublesome on first glance.  Take for instance the fact that GCC
>> changed the default C standard from gnu89 to gnu11 in GCC 5.  So a
>> kernel dev with gcc 5+ is now building a kernel with some translation
>> units built as gnu89, and some as gnu11.
> 
> Right, so I'd defer to hpa for a definitive answer here but AFAICT, the
> reasoning is that because this is the special relocatable compressed
> kernel and as such, it is redefining build flags completely so that
> nothing leaks from kernel proper.
> 
> Which is funny because what happens is, that something *does* leak,
> and what you're trying to fix is one incarnation. Because we do use
> facilities from include/linux/. And looking at your error:
> 
> #warning "Compiler lacks ASM_GOTO support. Add -D __BPF_TRACING__ to your compiler arguments"
> 
> I don't think it does matter to the compressed kernel whether the
> compiler has asm goto or not.
> 
> And looking at arch/x86/boot/Makefile, it does:
> 
> KBUILD_CFLAGS   := $(REALMODE_CFLAGS) -D_SETUP
> 
> and that _SETUP guard is kinda used to separate that early boot code
> from kernel proper.
> 
> And I wonder if adding such guard to arch/x86/boot/compressed/Makefile
> and then protect the asm goto check in arch/x86/include/asm/cpufeature.h
> with it, would be more in line with how this whole machinery should
> work...
> 

It overrides CFLAGS because it is by necessity a 32-bit compile (16
bits, really, but that's done at the assembly level only.)  Some 64-bit
flags cause the 32-bit compile to error out.

	-hpa

