Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6E0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040DE20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbfAORGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:06:52 -0500
Received: from relay.sw.ru ([185.231.240.75]:53218 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbfAORGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:06:51 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gjSAm-0004U5-70; Tue, 15 Jan 2019 20:06:44 +0300
Subject: Re: [PATCH v3 1/3] powerpc/mm: prepare kernel for KAsan on PPC32
To:     Dmitry Vyukov <dvyukov@google.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
References: <cover.1547289808.git.christophe.leroy@c-s.fr>
 <0c854dd6b110ac2b81ef1681f6e097f59f84af8b.1547289808.git.christophe.leroy@c-s.fr>
 <CACT4Y+aEsLWqhJmXETNsGtKdbfHDFL1NF8ofv3KwvQPraXdFyw@mail.gmail.com>
 <801c7d58-417d-1e65-68a0-b8cf02f9f956@c-s.fr>
 <CACT4Y+ZdA-w5OeebZg3PYPB+BX5wDxw_DxNe2==VJfbpy2eJ7A@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <330696c0-90c6-27de-5eb3-4da2159fdfbc@virtuozzo.com>
Date:   Tue, 15 Jan 2019 20:07:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZdA-w5OeebZg3PYPB+BX5wDxw_DxNe2==VJfbpy2eJ7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/19 2:14 PM, Dmitry Vyukov wrote:
> On Tue, Jan 15, 2019 at 8:27 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>> On 01/14/2019 09:34 AM, Dmitry Vyukov wrote:
>>> On Sat, Jan 12, 2019 at 12:16 PM Christophe Leroy
>>> <christophe.leroy@c-s.fr> wrote:
>>> &gt;
>>> &gt; In kernel/cputable.c, explicitly use memcpy() in order
>>> &gt; to allow GCC to replace it with __memcpy() when KASAN is
>>> &gt; selected.
>>> &gt;
>>> &gt; Since commit 400c47d81ca38 ("powerpc32: memset: only use dcbz once cache is
>>> &gt; enabled"), memset() can be used before activation of the cache,
>>> &gt; so no need to use memset_io() for zeroing the BSS.
>>> &gt;
>>> &gt; Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> &gt; ---
>>> &gt;  arch/powerpc/kernel/cputable.c | 4 ++--
>>> &gt;  arch/powerpc/kernel/setup_32.c | 6 ++----
>>> &gt;  2 files changed, 4 insertions(+), 6 deletions(-)
>>> &gt;
>>> &gt; diff --git a/arch/powerpc/kernel/cputable.c
>>> b/arch/powerpc/kernel/cputable.c
>>> &gt; index 1eab54bc6ee9..84814c8d1bcb 100644
>>> &gt; --- a/arch/powerpc/kernel/cputable.c
>>> &gt; +++ b/arch/powerpc/kernel/cputable.c
>>> &gt; @@ -2147,7 +2147,7 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
>>> &gt;         struct cpu_spec *t = &amp;the_cpu_spec;
>>> &gt;
>>> &gt;         t = PTRRELOC(t);
>>> &gt; -       *t = *s;
>>> &gt; +       memcpy(t, s, sizeof(*t));
>>>
>>> Hi Christophe,
>>>
>>> I understand why you are doing this, but this looks a bit fragile and
>>> non-scalable. This may not work with the next version of compiler,
>>> just different than yours version of compiler, clang, etc.
>>
>> My felling would be that this change makes it more solid.
>>
>> My understanding is that when you do *t = *s, the compiler can use
>> whatever way it wants to do the copy.
>> When you do memcpy(), you ensure it will do it that way and not another
>> way, don't you ?
> 
> It makes this single line more deterministic wrt code-gen (though,
> strictly saying compiler can turn memcpy back into inlines
> instructions, it knows memcpy semantics anyway).
> But the problem I meant is that the set of places that are subject to
> this problem is not deterministic. So if we go with this solution,
> after this change it's in the status "works on your machine" and we
> either need to commit to not using struct copies and zeroing
> throughout kernel code or potentially have a long tail of other
> similar cases, and since they can be triggered by another compiler
> version, we may need to backport these changes to previous releases
> too. Whereas if we would go with compiler flags, it would prevent the
> problem in all current and future places and with other past/future
> versions of compilers.
> 

The patch will work for any compiler. The point of this patch is to make
memcpy() visible to the preprocessor which will replace it with __memcpy().

After preprocessor's work, compiler will see just __memcpy() call here.

