Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4158CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A1D21917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545412361;
	bh=AC3N5cPmiWWCoi55jyxZG7SDG+N0rDbDxh2J62m/Kd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AlBdZYv8v1saB1FXtCronZp5nDIT9Xmcd7/LywuWpyHB7NUxDtjclEdigvsxahst4
	 TTflA9QCH501ecpepcxmlQGPu9u1Eq2S/oYB7hmmIKvq8eXh8ikoS0OGqLH1R0wMcy
	 s2u8bzZfKVgKjgXLpY//58rlirzMt6VizlBloLlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390078AbeLURMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:12:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390041AbeLURMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:12:38 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84FEB21924
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 17:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545412356;
        bh=AC3N5cPmiWWCoi55jyxZG7SDG+N0rDbDxh2J62m/Kd4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j0ZOzJzUwQGJViXlXiGXzuLtogRDNIDIMf3u7tuc7oxXVJOLWwDevwoJzWOjy/xdM
         +TI7ZZr3ZIkIpEDRUI6ycSepBJdHrvB/I277GFpcIkaRLZQCOZvL34SPcfBGgXorCq
         wZTy/0xtBYw2wROx9hSzaQbzXbXR3cZHvJ9Wsi+w=
Received: by mail-wm1-f45.google.com with SMTP id f188so6400954wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:12:36 -0800 (PST)
X-Gm-Message-State: AJcUukfxI4X9rF1CqmNjoN/b1+lo5hyx3Nz6MmI37Azlmg5SeFGc04BG
        Oe6cb1/QeXaOf/dgNV24PtIfbaEZmS87mbfBnsp+rQ==
X-Google-Smtp-Source: ALg8bN5xcqaM3jE5hJcUPjCFtOO3g6YR0MFVkz8Pn8U7+8VNRxUUknF1JZtAsfGq7SfDWSwZEu46tAxAcKayRH2OiRo=
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr3851149wmk.74.1545412354958;
 Fri, 21 Dec 2018 09:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20181212000354.31955-1-rick.p.edgecombe@intel.com>
 <20181212000354.31955-2-rick.p.edgecombe@intel.com> <CALCETrVP577NvdeYj8bzpEfTXj3GZD3nFcJxnUq5n1daDBxU=g@mail.gmail.com>
 <CAKv+Gu_kunBqhUAQt6==SN-ei4Xc+z6=Z=pKXHHJYjk4Gdw73g@mail.gmail.com>
In-Reply-To: <CAKv+Gu_kunBqhUAQt6==SN-ei4Xc+z6=Z=pKXHHJYjk4Gdw73g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 21 Dec 2018 09:12:23 -0800
X-Gmail-Original-Message-ID: <CALCETrWScgJpdnzNswJSKioQ93Oyw+Y_dJLoRxPX2Z=REVV1Ug@mail.gmail.com>
Message-ID: <CALCETrWScgJpdnzNswJSKioQ93Oyw+Y_dJLoRxPX2Z=REVV1Ug@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] vmalloc: New flags for safe vfree on special perms
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jessica Yu <jeyu@kernel.org>, Nadav Amit <namit@vmware.com>,
        Network Development <netdev@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 21, 2018, at 9:39 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> w=
rote:
>
>> On Wed, 12 Dec 2018 at 03:20, Andy Lutomirski <luto@kernel.org> wrote:
>>
>> On Tue, Dec 11, 2018 at 4:12 PM Rick Edgecombe
>> <rick.p.edgecombe@intel.com> wrote:
>>>
>>> This adds two new flags VM_IMMEDIATE_UNMAP and VM_HAS_SPECIAL_PERMS, fo=
r
>>> enabling vfree operations to immediately clear executable TLB entries t=
o freed
>>> pages, and handle freeing memory with special permissions.
>>>
>>> In order to support vfree being called on memory that might be RO, the =
vfree
>>> deferred list node is moved to a kmalloc allocated struct, from where i=
t is
>>> today, reusing the allocation being freed.
>>>
>>> arch_vunmap is a new __weak function that implements the actual unmappi=
ng and
>>> resetting of the direct map permissions. It can be overridden by more e=
fficient
>>> architecture specific implementations.
>>>
>>> For the default implementation, it uses architecture agnostic methods w=
hich are
>>> equivalent to what most usages do before calling vfree. So now it is ju=
st
>>> centralized here.
>>>
>>> This implementation derives from two sketches from Dave Hansen and Andy
>>> Lutomirski.
>>>
>>> Suggested-by: Dave Hansen <dave.hansen@intel.com>
>>> Suggested-by: Andy Lutomirski <luto@kernel.org>
>>> Suggested-by: Will Deacon <will.deacon@arm.com>
>>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>>> ---
>>> include/linux/vmalloc.h |  2 ++
>>> mm/vmalloc.c            | 73 +++++++++++++++++++++++++++++++++++++----
>>> 2 files changed, 69 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
>>> index 398e9c95cd61..872bcde17aca 100644
>>> --- a/include/linux/vmalloc.h
>>> +++ b/include/linux/vmalloc.h
>>> @@ -21,6 +21,8 @@ struct notifier_block;                /* in notifier.=
h */
>>> #define VM_UNINITIALIZED       0x00000020      /* vm_struct is not full=
y initialized */
>>> #define VM_NO_GUARD            0x00000040      /* don't add guard page =
*/
>>> #define VM_KASAN               0x00000080      /* has allocated kasan s=
hadow memory */
>>> +#define VM_IMMEDIATE_UNMAP     0x00000200      /* flush before releasi=
ng pages */
>>> +#define VM_HAS_SPECIAL_PERMS   0x00000400      /* may be freed with sp=
ecial perms */
>>> /* bits [20..32] reserved for arch specific ioremap internals */
>>>
>>> /*
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index 97d4b25d0373..02b284d2245a 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>> @@ -18,6 +18,7 @@
>>> #include <linux/interrupt.h>
>>> #include <linux/proc_fs.h>
>>> #include <linux/seq_file.h>
>>> +#include <linux/set_memory.h>
>>> #include <linux/debugobjects.h>
>>> #include <linux/kallsyms.h>
>>> #include <linux/list.h>
>>> @@ -38,6 +39,11 @@
>>>
>>> #include "internal.h"
>>>
>>> +struct vfree_work {
>>> +       struct llist_node node;
>>> +       void *addr;
>>> +};
>>> +
>>> struct vfree_deferred {
>>>        struct llist_head list;
>>>        struct work_struct wq;
>>> @@ -50,9 +56,13 @@ static void free_work(struct work_struct *w)
>>> {
>>>        struct vfree_deferred *p =3D container_of(w, struct vfree_deferr=
ed, wq);
>>>        struct llist_node *t, *llnode;
>>> +       struct vfree_work *cur;
>>>
>>> -       llist_for_each_safe(llnode, t, llist_del_all(&p->list))
>>> -               __vunmap((void *)llnode, 1);
>>> +       llist_for_each_safe(llnode, t, llist_del_all(&p->list)) {
>>> +               cur =3D container_of(llnode, struct vfree_work, node);
>>> +               __vunmap(cur->addr, 1);
>>> +               kfree(cur);
>>> +       }
>>> }
>>>
>>> /*** Page table manipulation functions ***/
>>> @@ -1494,6 +1504,48 @@ struct vm_struct *remove_vm_area(const void *add=
r)
>>>        return NULL;
>>> }
>>>
>>> +/*
>>> + * This function handles unmapping and resetting the direct map as eff=
iciently
>>> + * as it can with cross arch functions. The three categories of archit=
ectures
>>> + * are:
>>> + *   1. Architectures with no set_memory implementations and no direct=
 map
>>> + *      permissions.
>>> + *   2. Architectures with set_memory implementations but no direct ma=
p
>>> + *      permissions
>>> + *   3. Architectures with set_memory implementations and direct map p=
ermissions
>>> + */
>>> +void __weak arch_vunmap(struct vm_struct *area, int deallocate_pages)
>>
>> My general preference is to avoid __weak functions -- they don't
>> optimize well.  Instead, I prefer either:
>>
>> #ifndef arch_vunmap
>> void arch_vunmap(...);
>> #endif
>>
>> or
>>
>> #ifdef CONFIG_HAVE_ARCH_VUNMAP
>> ...
>> #endif
>>
>>
>>> +{
>>> +       unsigned long addr =3D (unsigned long)area->addr;
>>> +       int immediate =3D area->flags & VM_IMMEDIATE_UNMAP;
>>> +       int special =3D area->flags & VM_HAS_SPECIAL_PERMS;
>>> +
>>> +       /*
>>> +        * In case of 2 and 3, use this general way of resetting the pe=
rmissions
>>> +        * on the directmap. Do NX before RW, in case of X, so there is=
 no W^X
>>> +        * violation window.
>>> +        *
>>> +        * For case 1 these will be noops.
>>> +        */
>>> +       if (immediate)
>>> +               set_memory_nx(addr, area->nr_pages);
>>> +       if (deallocate_pages && special)
>>> +               set_memory_rw(addr, area->nr_pages);
>>
>> Can you elaborate on the intent here?  VM_IMMEDIATE_UNMAP means "I
>> want that alias gone before any deallocation happens".
>> VM_HAS_SPECIAL_PERMS means "I mucked with the direct map -- fix it for
>> me, please".  deallocate means "this was vfree -- please free the
>> pages".  I'm not convinced that all the various combinations make
>> sense.  Do we really need both flags?
>>
>> (VM_IMMEDIATE_UNMAP is a bit of a lie, since, if in_interrupt(), it's
>> not immediate.)
>>
>> If we do keep both flags, maybe some restructuring would make sense,
>> like this, perhaps.  Sorry about horrible whitespace damage.
>>
>> if (special) {
>>  /* VM_HAS_SPECIAL_PERMS makes little sense without deallocate_pages. */
>>  WARN_ON_ONCE(!deallocate_pages);
>>
>>  if (immediate) {
>>    /* It's possible that the vmap alias is X and we're about to make
>> the direct map RW.  To avoid a window where executable memory is
>> writable, first mark the vmap alias NX.  This is silly, since we're
>> about to *unmap* it, but this is the best we can do if all we have to
>> work with is the set_memory_abc() APIs.  Architectures should override
>> this whole function to get better behavior. */
>
> So can't we fix this first? Assuming that architectures that bother to
> implement them will not have executable mappings in the linear region,
> all we'd need is set_linear_range_ro/rw() routines that default to
> doing nothing, and encapsulate the existing code for x86 and arm64.
> That way, we can handle do things in the proper order, i.e., release
> the vmalloc mapping (without caring about the permissions), restore
> the linear alias attributes, and finally release the pages.

Seems reasonable, except that I think it should be
set_linear_range_not_present() and set_linear_range_rw(), for three
reasons:

1. It=E2=80=99s not at all clear to me that we need to keep the linear mapp=
ing
around for modules.

2. At least on x86, the obvious algorithm to do the free operation
with a single flush requires it.  Someone should probably confirm that
arm=E2=80=99s TLB works the same way, i.e. that no flush is needed when
changing from not-present (or whatever ARM calls it) to RW.

3. Anyone playing with XPFO wants this facility anyway.  In fact, with
this change, Rick=E2=80=99s series will more or less implement XPFO for
vmalloc memory :)

Does that seem reasonable to you?
