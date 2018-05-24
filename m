Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935890AbeEXWn3 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:43:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41593 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935803AbeEXWn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:43:26 -0400
Date: Thu, 24 May 2018 15:43:14 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKwvOdkEHqv7Ut8H6Rb+gSvfWsMHqO=E3f7yxm=06m9yEn=h6w@mail.gmail.com>
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com> <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com> <dd1626ae-114f-3817-c8b2-f845e079bfc6@zytor.com> <CAKwvOdkEHqv7Ut8H6Rb+gSvfWsMHqO=E3f7yxm=06m9yEn=h6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [clang] stack protector and f1f029c7bf
To: Nick Desaulniers <ndesaulniers@google.com>
CC: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>
From: hpa@zytor.com
Message-ID: <26B017D5-4063-46CB-8768-B0E5E7CD3838@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 24, 2018 3:31:05 PM PDT, Nick Desaulniers <ndesaulniers@google.com> wrote:
>On Thu, May 24, 2018 at 3:05 PM H. Peter Anvin <hpa@zytor.com> wrote:
>> COMPILER AR: "=rm" should NEVER generate worse code than "=r". That
>is
>> unequivocally a compiler bug.
>
>Filed: https://bugs.llvm.org/show_bug.cgi?id=37583
>
>> >> You are claiming it doesn't buy us anything, but you are only
>looking
>at
>> > the paravirt case which is kind of "special" (in the short bus kind
>of
>way),
>> >
>> > That's fair.  Is another possible solution to have paravirt maybe
>not
>use
>> > native_save_fl() then, but its own
>non-static-inline-without-m-constraint
>> > implementation?
>
>> KERNEL AR: change native_save_fl() to an extern inline with an
>assembly
>> out-of-line implementation, to satisfy the paravirt requirement that
>no
>> GPRs other than %rax are clobbered.
>
>i'm happy to add that, do you have a recommendation if it should go in
>an
>existing .S file or a new one (and if so where/what shall I call it?).

How about irqflags.c since that is what the .h file is called.

It should simply be:

push %rdi
popf
ret

pushf
pop %rax
ret

... but with all the regular assembly decorations, of course.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
