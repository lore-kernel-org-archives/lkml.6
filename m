Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A722C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AEE20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcXz/e1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AEE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbeLDWso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:48:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32923 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeLDWso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:48:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so9030347plo.0;
        Tue, 04 Dec 2018 14:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VTvZVqQimxTmbuXQK5L7tIUCwiWSTRq7isVfprnSZIg=;
        b=FcXz/e1ciuCkmRxun7ocOwEMff+jX0BBn9XshuGzd2HZbIqkkIQne3ztL/co8kRbQg
         hAQxj9t/3oLbUNvZ1DDI9L2uibLO1MYvurdAP7NEmsI5S3Wawl1HpkboFjELfdYppn1P
         Dq0J4+Mc0rMv3wYHP/O0GwIMLedGEloJ9j895xEsGOFQztqyBT6pbXCYDxt/B5MUPlk7
         kPiOOQBdr9SuH9fm5VI8BuGo1/+EMBAfeno1a/rgCy0+Mo/djIhWqXLIqTlc5qPxlhx1
         b431VbKse96UsS+AswkBDNG1yEYIa9jiBXz4axqHyh+BTtn5mEsgGil9SnFah3mmOJGy
         uX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VTvZVqQimxTmbuXQK5L7tIUCwiWSTRq7isVfprnSZIg=;
        b=UdxvF2Y5SWHQF9/+pj++XKcDYYBtIwoDMna3x80++ydc8yNWLGrwTbJPjljXkYGetg
         gbfrB7Cxrk361Ux1u+94HqHxfqUNeCPdZTJQ+svx347GdYImGccC40e3Eec+BFtXux3i
         Qk+n7DFDvLSS1+LloDI/LpWtLJoLR5NYEiA9tixkmkLU9w7Fq22ycuZO16j5XYfj/tNV
         gbje2mM3c5q4iharwsF307SnCuTJP1R11VTDEsBsknJ6PUHElGMEohCkdx36ZMVxNh/8
         Qwan90ieCNIaCvQlh2hpVgfNTYwF5EsXpcZ5s7Pnz0p8REZw86ZNtfrNnSNmKvSRr+34
         5iQw==
X-Gm-Message-State: AA+aEWYKbqDoZ7vZhAt5Q6mUJFyMTQQAWFbNlbeUpY4BchBKdmhXgFYN
        rgvabnfQz34z8MxRp8TtxhA=
X-Google-Smtp-Source: AFSGD/WwoDHQTtB6fjCbn4RtQxMLgTFFGK2BkqHNxzo6FSXKXvDyPK4Necxgva/po/ssV3E1tSZS5A==
X-Received: by 2002:a17:902:714c:: with SMTP id u12mr21574780plm.234.1543963723038;
        Tue, 04 Dec 2018 14:48:43 -0800 (PST)
Received: from [10.2.19.70] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id v70sm32180583pfa.152.2018.12.04.14.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:48:42 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrXLrsKDBzDkN7sc9HYPWe9aV3NQzf4vMvM+FD8j6aA6AQ@mail.gmail.com>
Date:   Tue, 4 Dec 2018 14:48:40 -0800
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
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
        Daniel Borkmann <daniel@iogearbox.net>, jeyu@kernel.org,
        Network Development <netdev@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <20CC2F71-308D-42E2-8C54-F64D7CC3863F@gmail.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com>
 <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
 <CALCETrXvddt148fncMJqpjK98uatiK-44knYFWU0-ytf8X+iog@mail.gmail.com>
 <08141F66-F3E6-4CC5-AF91-1ED5F101A54C@gmail.com>
 <CALCETrXLrsKDBzDkN7sc9HYPWe9aV3NQzf4vMvM+FD8j6aA6AQ@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 4, 2018, at 11:48 AM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Tue, Dec 4, 2018 at 11:45 AM Nadav Amit <nadav.amit@gmail.com> =
wrote:
>>> On Dec 4, 2018, at 10:56 AM, Andy Lutomirski <luto@kernel.org> =
wrote:
>>>=20
>>> On Mon, Dec 3, 2018 at 5:43 PM Nadav Amit <nadav.amit@gmail.com> =
wrote:
>>>>> On Nov 27, 2018, at 4:07 PM, Rick Edgecombe =
<rick.p.edgecombe@intel.com> wrote:
>>>>>=20
>>>>> Since vfree will lazily flush the TLB, but not lazily free the =
underlying pages,
>>>>> it often leaves stale TLB entries to freed pages that could get =
re-used. This is
>>>>> undesirable for cases where the memory being freed has special =
permissions such
>>>>> as executable.
>>>>=20
>>>> So I am trying to finish my patch-set for preventing transient W+X =
mappings
>>>> from taking space, by handling kprobes & ftrace that I missed =
(thanks again for
>>>> pointing it out).
>>>>=20
>>>> But all of the sudden, I don=E2=80=99t understand why we have the =
problem that this
>>>> (your) patch-set deals with at all. We already change the mappings =
to make
>>>> the memory writable before freeing the memory, so why can=E2=80=99t =
we make it
>>>> non-executable at the same time? Actually, why do we make the =
module memory,
>>>> including its data executable before freeing it???
>>>=20
>>> All the code you're looking at is IMO a very awkward and possibly
>>> incorrect of doing what's actually necessary: putting the direct map
>>> the way it wants to be.
>>>=20
>>> Can't we shove this entirely mess into vunmap?  Have a flag (as part
>>> of vmalloc like in Rick's patch or as a flag passed to a vfree =
variant
>>> directly) that makes the vunmap code that frees the underlying pages
>>> also reset their permissions?
>>>=20
>>> Right now, we muck with set_memory_rw() and set_memory_nx(), which
>>> both have very awkward (and inconsistent with each other!) semantics
>>> when called on vmalloc memory.  And they have their own flushes, =
which
>>> is inefficient.  Maybe the right solution is for vunmap to remove =
the
>>> vmap area PTEs, call into a function like set_memory_rw() that =
resets
>>> the direct maps to their default permissions *without* flushing, and
>>> then to do a single flush for everything.  Or, even better, to cause
>>> the change_page_attr code to do the flush and also to flush the vmap
>>> area all at once so that very small free operations can flush single
>>> pages instead of flushing globally.
>>=20
>> Thanks for the explanation. I read it just after I realized that =
indeed the
>> whole purpose of this code is to get cpa_process_alias()
>> update the corresponding direct mapping.
>>=20
>> This thing (pageattr.c) indeed seems over-engineered and very =
unintuitive.
>> Right now I have a list of patch-sets that I owe, so I don=E2=80=99t =
have the time
>> to deal with it.
>>=20
>> But, I still think that disable_ro_nx() should not call =
set_memory_x().
>> IIUC, this breaks W+X of the direct-mapping which correspond with the =
module
>> memory. Does it ever stop being W+X?? I=E2=80=99ll have another look.
>=20
> Dunno.  I did once chase down a bug where some memory got freed while
> it was still read-only, and the results were hilarious and hard to
> debug, since the explosion happened long after the buggy code
> finished.

This piece of code causes me pain and misery.

So, it turns out that the direct map is *not* changed if you just change
the NX-bit. See change_page_attr_set_clr():

        /* No alias checking for _NX bit modifications */
        checkalias =3D (pgprot_val(mask_set) | pgprot_val(mask_clr)) !=3D =
_PAGE_NX;

How many levels of abstraction are broken in the way? What would happen
if somebody tries to change the NX-bit and some other bit in the PTE?
Luckily, I don=E2=80=99t think someone does=E2=80=A6 at least for now.

So, again, I think the change I proposed makes sense. nios2 does not =
have
set_memory_x() and it will not be affected.

[ I can add a comment, although I don=E2=80=99t have know if nios2 has =
an NX bit,
and I don=E2=80=99t find any code that defines PTEs. Actually where is =
pte_present()
of nios2 being defined? Whatever. ]

