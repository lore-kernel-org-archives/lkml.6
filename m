Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A2C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43237207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43237207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeJXGaS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:30:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48941 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbeJXGaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:30:17 -0400
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w9NM4hsd3196776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 23 Oct 2018 15:04:44 -0700
Date:   Tue, 23 Oct 2018 15:04:37 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20181023215811.GA10771@flashbox>
References: <20181023003725.21463-1-natechancellor@gmail.com> <F3BBC06A-A9CB-4ABF-ADF4-6B0971FAE364@vmware.com> <CAKwvOdmsKbW9v9or+u-W9V7T+LrF4ODY9cgUStkjkmsbMcqJ2g@mail.gmail.com> <96ffedd2-a19d-95de-45fd-3a83025dd48a@zytor.com> <20181023215811.GA10771@flashbox>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH RFC] x86: Don't include '-Wa,-' when building with Clang
To:     Nathan Chancellor <natechancellor@gmail.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>, namit@vmware.com,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From:   hpa@zytor.com
Message-ID: <05360B86-A640-4242-9E87-BB43CC8B794D@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 23, 2018 2:58:11 PM PDT, Nathan Chancellor <natechancellor@gmail.com> wrote:
>On Tue, Oct 23, 2018 at 01:01:22PM -0700, H. Peter Anvin wrote:
>> On 10/23/18 11:40, Nick Desaulniers wrote:
>> > On Mon, Oct 22, 2018 at 10:11 PM Nadav Amit <namit@vmware.com>
>wrote:
>> >>
>> >> at 5:37 PM, Nathan Chancellor <natechancellor@gmail.com> wrote:
>> >>
>> >> Commit 77b0bf55bc67 ("kbuild/Makefile: Prepare for using macros in
>> >> inline assembly code to work around asm() related GCC inlining
>bugs")
>> >> added this flag to KBUILD_CFLAGS, where it works perfectly fine
>with
>> >> GCC. However, when building with Clang, all of the object files
>compile
>> >> fine but the build hangs indefinitely at init/main.o, right before
>the
>> >> linking stage. Don't include this flag when building with Clang.
>> >>
>> >> The kernel builds and boots to a shell in QEMU with both GCC and
>Clang
>> >> with this patch applied.
>> >>
>> >> Link:
>https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FClangBuiltLinux%2Flinux%2Fissues%2F213&amp;data=02%7C01%7Cnamit%40vmware.com%7C871daebc2ca44947d28d08d638811fb5%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C1%7C0%7C636758524579997650&amp;sdata=shuxW81QRrO3TSqbgf462wgZYdLeAKeQEdGRxmnUX30%3D&amp;reserved=0
>> >> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> >> ---
>> >>
>> >> The reason this patch is labeled RFC is while I can verify that
>this
>> >> fixes the issue, I'm not entirely sure why the '-Wa,-' works for
>GCC
>> >> and not Clang. I looked into what the flag means and I couldn't
>really
>> >> find anything so I just assume it's taking input from stdin? The
>issue
>> >> could stem from how GCC forks gas versus how Clang does it. If
>this
>> >> isn't of concern and the maintainers are happy with this patch as
>is,
>> >> feel free to take it.
>> >>
>> 
>> Perhaps someone could actually, you know, time the build and see how
>> much -pipe actually matters, if at all?
>> 
>> 	-hpa
>> 
>
>Thank you for the suggestion! With the attached diff for removing
>'-pipe' and 'make -j1' with defconfig (just to make sure any variance
>would stand out), here are my results:
>
>-pipe (GCC):
>
>real    15m55.202s
>user    14m17.748s
>sys     1m47.496s
>
>No -pipe (GCC):
>
>real    16m4.430s
>user    14m16.277s
>sys     1m46.604s
>
>-pipe (Clang):
>
>real    21m26.016s
>user    19m21.722s
>sys     2m2.606s
>
>No -pipe (Clang):
>
>real    21m27.822s
>user    19m22.092s
>sys     2m4.151s
>
>Certainly seems like -pipe doesn't make a ton of difference. If this is
>a better fix, I am happy to draft up a proper commit message and send
>it out for review.
>
>==================================================
>
>diff --git a/arch/x86/Makefile b/arch/x86/Makefile
>index 73f4831283ac..672c689c1faa 100644
>--- a/arch/x86/Makefile
>+++ b/arch/x86/Makefile
>@@ -213,8 +213,6 @@ ifdef CONFIG_X86_64
> KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
> endif
> 
>-# Speed up the build
>-KBUILD_CFLAGS += -pipe
># Workaround for a gcc prelease that unfortunately was shipped in a
>suse release
> KBUILD_CFLAGS += -Wno-sign-compare
> #
>@@ -239,7 +237,7 @@ archheaders:
> archmacros:
>        $(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
> 
>-ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s -Wa,-
>+ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
> export ASM_MACRO_FLAGS
> KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)

make -j1 makes the test useless. You should aim for optimal performance for your machine.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
