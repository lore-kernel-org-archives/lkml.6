Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964850AbeEISjj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 14:39:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50480 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755415AbeEISji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 14:39:38 -0400
X-Google-Smtp-Source: AB8JxZo1q4NnVGdB+sTd1RDDnotqLJe95RaDikQZ+0y5JJcnQixNs5BUDrTMher1yavBIuQ59e4NKQ==
Subject: Re: [PATCH 04/13] mm: Use array_size() helpers for kmalloc()
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <20180509004229.36341-1-keescook@chromium.org>
 <20180509004229.36341-5-keescook@chromium.org>
 <20180509113446.GA18549@bombadil.infradead.org>
 <fea0a346-6f36-ff8c-f036-13f22dfb9bfe@rasmusvillemoes.dk>
 <CAGXu5j+ds=4tKM=GwzgfpA0YheUSX30pTbQqXg0gKUniOeDzww@mail.gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f761626f-03e5-ef91-1f73-ae1cf2c9714f@rasmusvillemoes.dk>
Date: Wed, 9 May 2018 20:39:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+ds=4tKM=GwzgfpA0YheUSX30pTbQqXg0gKUniOeDzww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-09 20:07, Kees Cook wrote:
> On Wed, May 9, 2018 at 11:00 AM, Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> Okay, consensus is to remove new SIZE_MAX checks, then?

Yes, don't add such to static inlines. But the out-of-line
implementations do need an audit (as you've observed) for unsafe
arithmetic on the passed-in size.

>> With __builtin_constant_p(size) && size == SIZE_MAX, gcc could be smart
>> enough to elide those two instructions and have the jo go directly to
>> the caller's error handling, but at least gcc 5.4 doesn't seem to be
>> that smart. So let's just omit that part for now.
>>
>> But in case of the kmalloc_array functions, with a direct call of
>> __builtin_mul_overflow(), gcc does combine the "return NULL" with the
>> callers error handling, thus avoiding the six byte "%rdi = -1; jmp
>> back;" thunk. That, along with the churn factor, might be an argument
>> for leaving the current callers of *_array alone. But if we are going to
>> keep those longer-term, we might as well convert kmalloc(a, b) into
>> kmalloc_array(a, b) instead of kmalloc(array_size(a, b)). In any case, I
>> do see the usefulness of the struct_size helper, and agree that we
>> definitely should not introduce a new *_struct variant that needs to be
>> implemented in all families.
> 
> I'd like to drop *calloc() and *_array() to simplify APIs (and improve
> developer sanity). Are you suggesting we should not use the overflow
> helpers in kmalloc_array(), instead leaving the existing open-coded
> overflow check?

No, quite the contrary. I suggest using check_mul_overflow() directly in
kmalloc_array (and by implication, kcalloc), and also all other *_array
or *_calloc that are static inlines. That's separate from converting
kmalloc(a*b) to use some safer variant, and should not be controversial
(and can generate better code for all the existing callers).

Now, what kmalloc(a*b) should be converted to is a question of the
long-term plans for *_array. If you want to remove it completely,
eventually, it doesn't make sense to coccinel (yeah, that's a verb) in
new users.

And a third question is whether and when to mechanically change all
(pre-)existing kmalloc_array() into kmalloc(array_size()). I don't have
an opinion on the latter two.

Rasmus
