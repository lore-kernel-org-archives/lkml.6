Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2130C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896E42083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID6KDr3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896E42083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeHaVzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:32962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbeHaVzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:55:48 -0400
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 391FC20850
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 17:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535737634;
        bh=vqu41/HKLxovzNFtRsiHtVyE8uf86TQAz6H509UnfNA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ID6KDr3tfmvj+Qg7Pi1a7TQHomcjOHYvvD+w1vZSpbBQ1Kf061issDbpFkQ0uVulS
         Eu/6jndqNORhL1hfwnqOHxH3cSWcRkV6veJqEFp4FYZq5wIkeqzfs9HR4VJFxvbnQ0
         awPW8NeqCL1rhfKNl2oP/AUeYJQvDdwLR4FZhn5I=
Received: by mail-wm0-f42.google.com with SMTP id f21-v6so5978609wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 10:47:14 -0700 (PDT)
X-Gm-Message-State: APzg51Bx7W/cQ37bO2YD3qYS9tWT28HqwOxyG29QDSKOf2obEIHbPMBa
        ID2aejCRbHT/Kr+ZqLc5yKISbKTCxqihct7jbXzcrw==
X-Google-Smtp-Source: ANB0VdZt82Kiru+Um+/nn44dB0Le4SuwcjMHldZDTEQaR8ua3G2+Qz4OduxdNzau7cZo/YArKAWFZRyu++hiu8g/q80=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr4972068wmd.144.1535737632515;
 Fri, 31 Aug 2018 10:47:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:6008:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 10:46:51
 -0700 (PDT)
In-Reply-To: <e164a320-25a4-a9fc-3256-901b778468f3@linux.intel.com>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com> <20180830143904.3168-13-yu-cheng.yu@intel.com>
 <CAG48ez0Rca0XsdXJZ07c+iGPyep0Gpxw+sxQuACP5gyPaBgDKA@mail.gmail.com>
 <079a55f2-4654-4adf-a6ef-6e480b594a2f@linux.intel.com> <CAG48ez2gHOD9hH4+0wek5vUOv9upj79XWoug2SXjdwfXWoQqxw@mail.gmail.com>
 <ce051b5b-feef-376f-e085-11f65a5f2215@linux.intel.com> <B2222C69-337B-44F2-9DA6-69E685AA469B@amacapital.net>
 <e164a320-25a4-a9fc-3256-901b778468f3@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 31 Aug 2018 10:46:51 -0700
X-Gmail-Original-Message-ID: <CALCETrUE6mY-+YCaJjGJuEqE_OBQc=QUR1XMnPW9VwTb8=HK4w@mail.gmail.com>
Message-ID: <CALCETrUE6mY-+YCaJjGJuEqE_OBQc=QUR1XMnPW9VwTb8=HK4w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 12/24] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Jann Horn <jannh@google.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:55 AM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
> On 08/30/2018 10:34 AM, Andy Lutomirski wrote:
>>> But, to keep B's TLB from picking up the entry, I think we can just make
>>> it !Present for a moment.  No TLB can cache it, and I believe the same
>>> "don't set Dirty on a !Writable entry" logic also holds for !Present
>>> (modulo a weird erratum or two).
>> Can we get documentation?  Pretty please?
>
> The accessed bit description in the SDM looks pretty good to me today:
>
>> Whenever the processor uses a paging-structure entry as part of
>> linear-address translation, it sets the accessed flag in that entry
>> (if it is not already set).
> If it's !Present, it can't used as part of a translation so can't be
> set.  I think that covers the thing I was unsure about.
>
> But, Dirty is a bit, er, muddier, but mostly because it only gets set on
> leaf entries:
>
>> Whenever there is a write to a linear address, the processor sets the
>> dirty flag (if it is not already set) in the paging- structure entry
>> that identifies the final physical address for the linear address
>> (either a PTE or a paging-structure entry in which the PS flag is
>> 1).
>
> That little hunk will definitely need to get updated with something like:
>
>         On processors enumerating support for CET, the processor will on
>         set the dirty flag on paging structure entries in which the W
>         flag is 1.

Can we get something much stronger, perhaps?  Like this:

On processors enumerating support for CET, the processor will write to
the accessed and/or dirty flags atomically, as if using the LOCK
CMPXCHG instruction.  The memory access, any cached entries in any
paging-structure caches, and the values in the paging-structure entry
before and after writing the A and/or D bits will all be consistent.

I'm sure this could be worded better.  The point is that the CPU
should, atomically, load the PTE, check if it allows the access, set A
and/or D appropriately, write the new value to the TLB, and use that
value for the access.  This is clearly a little bit slower than what
old CPUs could do when writing to an already-in-TLB writable non-dirty
entry, but new CPUs are going to have to atomically check the W bit.
(I assume that even old CPUs will *atomically* set the D bit as if by
LOCK BTS, but this is all very vague in the SDM IIRC.)
