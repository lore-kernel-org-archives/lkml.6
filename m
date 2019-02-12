Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE517C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8112C20842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfBLMOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:14:23 -0500
Received: from relay.sw.ru ([185.231.240.75]:36560 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBLMOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:14:23 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gtWx9-000831-M1; Tue, 12 Feb 2019 15:14:19 +0300
Subject: Re: [PATCH v4 3/3] powerpc/32: Add KASAN support
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <cover.1548166824.git.christophe.leroy@c-s.fr>
 <1f5629e03181d0e30efc603f00dad78912991a45.1548166824.git.christophe.leroy@c-s.fr>
 <87ef8i45km.fsf@dja-thinkpad.axtens.net>
 <69720148-fd19-0810-5a1d-96c45e2ec00c@c-s.fr>
 <CAAeHK+wcUwLiSQffUkcyiH2fuox=VihJadEqQqRG1YfU3Y2gDA@mail.gmail.com>
 <f8b9e9ec-991b-6824-46c2-f7fc0aaa7fb8@c-s.fr>
 <CAAeHK+zop5ajOJQ4KEYbuxMRegk2GM1LvuGcSbCU1O5EZxB0MA@mail.gmail.com>
 <805fbf9d-a10f-03e0-aa52-6f6bd16059b9@virtuozzo.com>
 <87imxpak4r.fsf@linkitivity.dja.id.au>
 <a11adaf3-beda-ed0c-e6aa-9ef30f2e80cf@c-s.fr>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <c5599614-128b-69a8-2526-72b135070e8d@virtuozzo.com>
Date:   Tue, 12 Feb 2019 15:14:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <a11adaf3-beda-ed0c-e6aa-9ef30f2e80cf@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 2:38 PM, Christophe Leroy wrote:
> 
> 
> Le 12/02/2019 à 02:08, Daniel Axtens a écrit :
>> Andrey Ryabinin <aryabinin@virtuozzo.com> writes:
>>
>>>
>>> Christophe, you can specify KASAN_SHADOW_OFFSET either in Kconfig (e.g. x86_64) or
>>> in Makefile (e.g. arm64). And make early mapping writable, because compiler generated code will write
>>> to shadow memory in function prologue/epilogue.
>>
>> Hmm. Is this limitation just that compilers have not implemented
>> out-of-line support for stack instrumentation, or is there a deeper
>> reason that stack/global instrumentation relies upon inline
>> instrumentation?
> 
> No, it looks like as soon as we define KASAN_SHADOW_OFFSET in Makefile in addition to asm/kasan.h, stack instrumentation works with out-of-line.
> 


I think you confusing two different things.
CONFIG_KASAN_INLINE/CONFIG_KASAN_OUTLINE affects only generation of code that checks memory accesses,
whether we call __asan_loadx()/__asan_storex() or directly insert code, checking shadow memory. 

But with stack instrumentation we also need to poison redzones around stack variables and unpoison them
when we leave the function. That poisoning/unpoisoning thing is always inlined. Currently there is no option to make it out-of-line.

So you can have stack instrumentation with KASAN_OUTLINE, but it just means that checking shadow memory on memory access will be outlined,
poisoning/unpoisoing stack redzones will remain inlined.

