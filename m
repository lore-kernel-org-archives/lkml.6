Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933020AbeCFRrZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:47:25 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35362 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932660AbeCFRrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:47:24 -0500
X-Google-Smtp-Source: AG47ELtJKCFGA7RY1sGFa4a3IJh/eapazX+72u4TgYsGMCsH0M75xNYHuBxXYmr0fetV6bSANLfV/CeJc7i1UTBgR/Q=
MIME-Version: 1.0
In-Reply-To: <CAAeHK+y4hze8CUDMJ_G6W+diBO88+WYu892SK9QAt36y8nbZYQ@mail.gmail.com>
References: <083f58501e54731203801d899632d76175868e97.1519400992.git.andreyknvl@google.com>
 <26dd94c5-19ca-dca6-07b8-7103f53c0130@virtuozzo.com> <CAAeHK+y4hze8CUDMJ_G6W+diBO88+WYu892SK9QAt36y8nbZYQ@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 6 Mar 2018 18:47:22 +0100
Message-ID: <CAAeHK+z+Q0qKdSt4R=Cd7XPS0njNM3c+66Q-JA97aZ5nEa6Kug@mail.gmail.com>
Subject: Re: [PATCH] kasan, slub: fix handling of kasan_slab_free hook
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Kostya Serebryany <kcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 6:42 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> On Fri, Mar 2, 2018 at 1:10 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>> On 02/23/2018 06:53 PM, Andrey Konovalov wrote:
>>> The kasan_slab_free hook's return value denotes whether the reuse of a
>>> slab object must be delayed (e.g. when the object is put into memory
>>> qurantine).
>>>
>>> The current way SLUB handles this hook is by ignoring its return value
>>> and hardcoding checks similar (but not exactly the same) to the ones
>>> performed in kasan_slab_free, which is prone to making mistakes.
>>>
>>
>> What are those differences exactly? And what problems do they cause?
>> Answers to these questions should be in the changelog.
>
>
> The difference is that with the old code we end up proceeding with
> invalidly freeing an object when an invalid-free (or double-free) is
> detected. Will add this in v2.
>
>>
>>
>>> This patch changes the way SLUB handles this by:
>>> 1. taking into account the return value of kasan_slab_free for each of
>>>    the objects, that are being freed;
>>> 2. reconstructing the freelist of objects to exclude the ones, whose
>>>    reuse must be delayed.
>>>
>>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>>> ---
>>
>>
>>
>>
>>>
>>> @@ -2965,14 +2974,13 @@ static __always_inline void slab_free(struct kmem_cache *s, struct page *page,
>>>                                     void *head, void *tail, int cnt,
>>>                                     unsigned long addr)
>>>  {
>>> -     slab_free_freelist_hook(s, head, tail);
>>>       /*
>>> -      * slab_free_freelist_hook() could have put the items into quarantine.
>>> -      * If so, no need to free them.
>>> +      * With KASAN enabled slab_free_freelist_hook modifies the freelist
>>> +      * to remove objects, whose reuse must be delayed.
>>>        */
>>> -     if (s->flags & SLAB_KASAN && !(s->flags & SLAB_TYPESAFE_BY_RCU))
>>> -             return;
>>> -     do_slab_free(s, page, head, tail, cnt, addr);
>>> +     slab_free_freelist_hook(s, &head, &tail);
>>> +     if (head != NULL)
>>
>> That's an additional branch in non-debug fast-path. Find a way to avoid this.
>
> Hm, there supposed to be a branch here. We either have objects that we
> need to free, or we don't, and we need to do different things in those
> cases. Previously this was done with a hardcoded "if (s->flags &
> SLAB_KASAN && ..." statement, not it's a different "if (head !=
> NULL)".
>
> I could put this check under #ifdef CONFIG_KASAN if the performance is
> critical here, but I'm not sure if that's the best solution. I could
> also add an "unlikely()" there.

OK, I have a solution better for this, stay tuned for v2.

>
>>
>>
>>> +             do_slab_free(s, page, head, tail, cnt, addr);
>>>  }
>>>
>>>  #ifdef CONFIG_KASAN
>>>
