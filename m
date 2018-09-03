Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B65C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863B820658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863B820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeICSKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:10:02 -0400
Received: from foss.arm.com ([217.140.101.70]:56418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbeICSKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:10:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8168580D;
        Mon,  3 Sep 2018 06:49:44 -0700 (PDT)
Received: from [10.4.13.84] (e119884-lin.Emea.Arm.com [10.4.13.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3EBF3F557;
        Mon,  3 Sep 2018 06:49:39 -0700 (PDT)
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by
 sparse
To:     Andrey Konovalov <andreyknvl@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        linux-kselftest@vger.kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arch@vger.kernel.org, Jacob Bramley <Jacob.Bramley@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <cover.1535629099.git.andreyknvl@google.com>
 <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <20180831081123.6mo62xnk54pvlxmc@ltop.local>
 <20180831134244.GB19965@ZenIV.linux.org.uk>
 <CAAeHK+w86m6YztnTGhuZPKRczb-+znZ1hiJskPXeQok4SgcaOw@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <01cadefd-c929-cb45-500d-7043cf3943f6@arm.com>
Date:   Mon, 3 Sep 2018 14:49:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAeHK+w86m6YztnTGhuZPKRczb-+znZ1hiJskPXeQok4SgcaOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/18 13:34, Andrey Konovalov wrote:
> On Fri, Aug 31, 2018 at 3:42 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> On Fri, Aug 31, 2018 at 10:11:24AM +0200, Luc Van Oostenryck wrote:
>>> On Thu, Aug 30, 2018 at 01:41:16PM +0200, Andrey Konovalov wrote:
>>>> This patch adds __force annotations for __user pointers casts detected by
>>>> sparse with the -Wcast-from-as flag enabled (added in [1]).
>>>>
>>>> [1] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292
>>>
>>> Hi,
>>>
>>> It would be nice to have some explanation for why these added __force
>>> are useful.
> 
> I'll add this in the next version, thanks!
> 
>>         It would be even more useful if that series would either deal with
>> the noise for real ("that's what we intend here, that's what we intend there,
>> here's a primitive for such-and-such kind of cases, here we actually
>> ought to pass __user pointer instead of unsigned long", etc.) or left it
>> unmasked.
>>
>>         As it is, __force says only one thing: "I know the code is doing
>> the right thing here".  That belongs in primitives, and I do *not* mean the
>> #define cast_to_ulong(x) ((__force unsigned long)(x))
>> kind.
>>
>>         Folks, if you don't want to deal with that - leave the warnings be.
>> They do carry more information than "someone has slapped __force in that place".
>>
>> Al, very annoyed by that kind of information-hiding crap...
> 
> This patch only adds __force to hide the reports I've looked at and
> decided that the code does the right thing. The cases where this is
> not the case are handled by the previous patches in the patchset. I'll
> this to the patch description as well. Is that OK?
> 
I think as well that we should make explicit the information that
__force is hiding.
A possible solution could be defining some new address spaces and use
them where it is relevant in the kernel. Something like:

# define __compat_ptr __attribute__((noderef, address_space(5)))
# define __tagged_ptr __attribute__((noderef, address_space(6)))

In this way sparse can still identify the casting and trigger a warning.

We could at that point modify sparse to ignore these conversions when a
specific flag is passed (i.e. -Wignore-compat-ptr, -Wignore-tagged-ptr)
to exclude from the generated warnings the ones we have already dealt
with.

What do you think about this approach?
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Regards,
Vincenzo
