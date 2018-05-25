Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967600AbeEYR6I convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:58:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45307 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967386AbeEYR6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:58:08 -0400
Date: Fri, 25 May 2018 10:57:56 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKwvOdnq-H2M=psJMxo7k7HiEvZVY+z+4+geONwNZdBC9VmhvQ@mail.gmail.com>
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com> <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com> <dd1626ae-114f-3817-c8b2-f845e079bfc6@zytor.com> <CAKwvOdkEHqv7Ut8H6Rb+gSvfWsMHqO=E3f7yxm=06m9yEn=h6w@mail.gmail.com> <26B017D5-4063-46CB-8768-B0E5E7CD3838@zytor.com> <CAKwvOdk_4g5PsRUoLgOeWEwt+d0diyD_Ycx6s7LQsJrSMsBEuA@mail.gmail.com> <319FB971-ABB6-4BE7-969B-D87D84853196@zytor.com> <CAKwvOdmryseROx=iSs6CZ86-tr90Fni8RC_w6Y7nFSXGW=508g@mail.gmail.com> <31A5469A-176F-451F-886A-ECD649DDC78C@zytor.com> <CAKwvOdkpWZC4vWK8hDdgUGseTmK4Hz5uDHn_mP9yc=jbfdVPmg@mail.gmail.com> <12a870df-5f9d-94d1-8318-42cfff1bedab@redhat.com> <CAKwvOdnq-H2M=psJMxo7k7HiEvZVY+z+4+geONwNZdBC9VmhvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [clang] stack protector and f1f029c7bf
To: Nick Desaulniers <ndesaulniers@google.com>, tstellar@redhat.com
CC: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@google.com>
From: hpa@zytor.com
Message-ID: <EE0F328A-4B60-44D9-A726-4CF5276CDBE7@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 25, 2018 10:49:28 AM PDT, Nick Desaulniers <ndesaulniers@google.com> wrote:
>On Fri, May 25, 2018 at 10:35 AM Tom Stellard <tstellar@redhat.com>
>wrote:
>> On 05/25/2018 10:31 AM, Nick Desaulniers wrote:
>> > On Fri, May 25, 2018 at 9:53 AM <hpa@zytor.com> wrote:
>> >> On May 25, 2018 9:46:42 AM PDT, Nick Desaulniers <
>ndesaulniers@google.com>
>> > wrote:
>> >>> On Fri, May 25, 2018 at 9:33 AM <hpa@zytor.com> wrote:
>> >>>> On May 25, 2018 9:27:40 AM PDT, Nick Desaulniers
>> >>> <ndesaulniers@google.com> wrote:
>> >>> When you say
>> >>>
>> >>>> It still should be available as as inline, however, but now
>"extern
>> >>> inline".
>> >>>
>> >>> Am I understanding correctly that native_save_fl should be
>inlined
>into
>> >>> all
>> >>> call sites (modulo the problematic pv_irq_ops.save_fl case)? 
>Because
>> >>> for
>> >>> these two assembly implementations, it's not, but maybe there's
>> >>> something
>> >>> missing in my implementation?
>> >
>> >> Yes, that's what "extern inline" means. Maybe it needs a must
>inline
>> > annotation, but that's really messed up.
>> >
>
>> What about doing something like suggested here:
>> https://bugs.llvm.org/show_bug.cgi?id=37512#c17
>
>> This would keep the definition in C and make it easier for compilers
>> to inline.
>
>The GCC docs for __attribute__((naked)) seem to imply this is a machine
>specific constraint (of which x86 is not listed):
>https://gcc.gnu.org/onlinedocs/gcc-4.7.2/gcc/Function-Attributes.html
>
>But let's try with source:
>https://godbolt.org/g/aJ4gZB
>
>Clang errors:
><source>:3:3: error: non-ASM statement in naked function is not
>supported
>   unsigned long flags;
>   ^
>
>Is it valid to use assembly to place the results in %rax and mark the c
>function somehow?
>
>gcc doesn't support this attribute until 4.9 (but we can add a feature
>test
>for attributes with gcc (unlike builtins)), but warns that:
>
>warning: ‘naked’ attribute directive ignored [-Wattributes]
>
>gcc 8.1 and trunk inserts a `ud2` instruction (what?!) (let me see if I
>can
>repro outside of godbolt, and will file a bug report).

No, we found that the paravirt code can do the wrong thing for a C implementation.

Nick, could you forward the list of problems so we all have it?
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
