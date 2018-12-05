Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC82C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB95D20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skQMxdcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB95D20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeLEBpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:45:09 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:33154 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeLEBpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:45:09 -0500
Received: by mail-pg1-f179.google.com with SMTP id z11so8244907pgu.0;
        Tue, 04 Dec 2018 17:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IEbxTq5/NJcA2hpgMt7+0lllopevnpygJwYQ5Cpw9UA=;
        b=skQMxdcnaJRIhuFhQE6SQjWl++NargdRD8Tjw7LXWNgmHeQP9yORHiCa14AxNyBSwg
         MhZuqF9Yibq/FlMM25vgFto+XytzFiO+HkPWaXZ4L3uZdIMG42NJjjvq1SicdYfEkkuR
         QsFz+tg+D9AqhxR3FHu01/cE0n4kI7Pd1iw1HTxV9dlGWBUe4TH0w26g8haHaK2zkJ5h
         56OXDnngXH9y3CRfPh+WmHKZPcjpo1+cZ8mMSx6l/LtSGK2EcooLWUn2Qpkr9MqWjfzz
         /+0LaBkmym4bsTY1UQmy/uSDWeNRuYeE8HiOngo02Unkmc9hpDI1J2Wv3fPbw689Q638
         yZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IEbxTq5/NJcA2hpgMt7+0lllopevnpygJwYQ5Cpw9UA=;
        b=fi+LcQAVpDEaztvKhQd1yAAFGsv8YbJKyfm5EfaAiDgEE3bHWaHKNOPwPWea0samQ+
         FOVnnefLJWKMlOVfyfx1cFKQkSdcN6An98oOm96HApyYCwPFEWBM+cHBZr/C0ZxxsHGN
         VBox86uAyXhlgO0SePzxHnye47+Va8SKPUSojgVJtDCF+W3sxsH4Jpd0zylU9QnevnIf
         5xslCMCVCR5KQ2HDwpaCenrAOpztRrJZRxM8u8USk6ubh5E/1SuVvJX1gZSEAzQvXrku
         OziHpyIa0eRzr1L85XCP8xldgG3Q8qgh2vGomlmN1+DbqYuOmjl8Zu3y4IqeaA0ZwhSU
         oZ1A==
X-Gm-Message-State: AA+aEWZqa6D6MgpkExN0afOVV48e754VrW/TytKAicuSVPM19PqDo8dK
        5AxY3lv/noZDy5tuEMkEmGI=
X-Google-Smtp-Source: AFSGD/WovANz+G+bYGDMYFF/heTHBlSnnuoUNpseRGB+Igcd6KdMvTlqo2PZVaihtJKMT4LSLiz/5Q==
X-Received: by 2002:a62:109b:: with SMTP id 27mr21928622pfq.227.1543974307771;
        Tue, 04 Dec 2018 17:45:07 -0800 (PST)
Received: from [10.2.19.70] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id a18sm20440293pgj.30.2018.12.04.17.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 17:45:06 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <3c217322e990eba0269cc5ffea761cc1a5b17f4e.camel@intel.com>
Date:   Tue, 4 Dec 2018 17:45:04 -0800
Cc:     "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jannh@google.com" <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BA406CD6-1938-439B-A723-008AF84BFEF3@gmail.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com>
 <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
 <CALCETrXvddt148fncMJqpjK98uatiK-44knYFWU0-ytf8X+iog@mail.gmail.com>
 <08141F66-F3E6-4CC5-AF91-1ED5F101A54C@gmail.com>
 <CALCETrXLrsKDBzDkN7sc9HYPWe9aV3NQzf4vMvM+FD8j6aA6AQ@mail.gmail.com>
 <20CC2F71-308D-42E2-8C54-F64D7CC3863F@gmail.com>
 <3c217322e990eba0269cc5ffea761cc1a5b17f4e.camel@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 4, 2018, at 5:09 PM, Edgecombe, Rick P =
<rick.p.edgecombe@intel.com> wrote:
>=20
> On Tue, 2018-12-04 at 14:48 -0800, Nadav Amit wrote:
>>> On Dec 4, 2018, at 11:48 AM, Andy Lutomirski <luto@kernel.org> =
wrote:
>>>=20
>>> On Tue, Dec 4, 2018 at 11:45 AM Nadav Amit <nadav.amit@gmail.com> =
wrote:
>>>>> On Dec 4, 2018, at 10:56 AM, Andy Lutomirski <luto@kernel.org> =
wrote:
>>>>>=20
>>>>> On Mon, Dec 3, 2018 at 5:43 PM Nadav Amit <nadav.amit@gmail.com> =
wrote:
>>>>>>> On Nov 27, 2018, at 4:07 PM, Rick Edgecombe <
>>>>>>> rick.p.edgecombe@intel.com> wrote:
>>>>>>>=20
>>>>>>> Since vfree will lazily flush the TLB, but not lazily free the
>>>>>>> underlying pages,
>>>>>>> it often leaves stale TLB entries to freed pages that could get =
re-
>>>>>>> used. This is
>>>>>>> undesirable for cases where the memory being freed has special
>>>>>>> permissions such
>>>>>>> as executable.
>>>>>>=20
>>>>>> So I am trying to finish my patch-set for preventing transient =
W+X
>>>>>> mappings
>>>>>> from taking space, by handling kprobes & ftrace that I missed =
(thanks
>>>>>> again for
>>>>>> pointing it out).
>>>>>>=20
>>>>>> But all of the sudden, I don=E2=80=99t understand why we have the =
problem that
>>>>>> this
>>>>>> (your) patch-set deals with at all. We already change the =
mappings to
>>>>>> make
>>>>>> the memory writable before freeing the memory, so why can=E2=80=99t=
 we make it
>>>>>> non-executable at the same time? Actually, why do we make the =
module
>>>>>> memory,
>>>>>> including its data executable before freeing it???
>>>>>=20
>>>>> All the code you're looking at is IMO a very awkward and possibly
>>>>> incorrect of doing what's actually necessary: putting the direct =
map
>>>>> the way it wants to be.
>>>>>=20
>>>>> Can't we shove this entirely mess into vunmap?  Have a flag (as =
part
>>>>> of vmalloc like in Rick's patch or as a flag passed to a vfree =
variant
>>>>> directly) that makes the vunmap code that frees the underlying =
pages
>>>>> also reset their permissions?
>>>>>=20
>>>>> Right now, we muck with set_memory_rw() and set_memory_nx(), which
>>>>> both have very awkward (and inconsistent with each other!) =
semantics
>>>>> when called on vmalloc memory.  And they have their own flushes, =
which
>>>>> is inefficient.  Maybe the right solution is for vunmap to remove =
the
>>>>> vmap area PTEs, call into a function like set_memory_rw() that =
resets
>>>>> the direct maps to their default permissions *without* flushing, =
and
>>>>> then to do a single flush for everything.  Or, even better, to =
cause
>>>>> the change_page_attr code to do the flush and also to flush the =
vmap
>>>>> area all at once so that very small free operations can flush =
single
>>>>> pages instead of flushing globally.
>>>>=20
>>>> Thanks for the explanation. I read it just after I realized that =
indeed
>>>> the
>>>> whole purpose of this code is to get cpa_process_alias()
>>>> update the corresponding direct mapping.
>>>>=20
>>>> This thing (pageattr.c) indeed seems over-engineered and very =
unintuitive.
>>>> Right now I have a list of patch-sets that I owe, so I don=E2=80=99t =
have the time
>>>> to deal with it.
>>>>=20
>>>> But, I still think that disable_ro_nx() should not call =
set_memory_x().
>>>> IIUC, this breaks W+X of the direct-mapping which correspond with =
the
>>>> module
>>>> memory. Does it ever stop being W+X?? I=E2=80=99ll have another =
look.
>>>=20
>>> Dunno.  I did once chase down a bug where some memory got freed =
while
>>> it was still read-only, and the results were hilarious and hard to
>>> debug, since the explosion happened long after the buggy code
>>> finished.
>>=20
>> This piece of code causes me pain and misery.
>>=20
>> So, it turns out that the direct map is *not* changed if you just =
change
>> the NX-bit. See change_page_attr_set_clr():
>>=20
>>        /* No alias checking for _NX bit modifications */
>>        checkalias =3D (pgprot_val(mask_set) | pgprot_val(mask_clr)) =
!=3D
>> _PAGE_NX;
>>=20
>> How many levels of abstraction are broken in the way? What would =
happen
>> if somebody tries to change the NX-bit and some other bit in the PTE?
>> Luckily, I don=E2=80=99t think someone does=E2=80=A6 at least for =
now.
>>=20
>> So, again, I think the change I proposed makes sense. nios2 does not =
have
>> set_memory_x() and it will not be affected.
> Hold on...so on architectures that don't have set_memory_ but do have =
something
> like NX, wont the executable stale TLB continue to live to re-used =
pages, and so
> it doesn't fix the problem this patch is trying to address generally? =
I see at
> least a couple archs use vmalloc and have an exec bit, but don't =
define
> set_memory_*.

Again, this does not come instead of your patch (the one in this =
thread).
And if you follow Andy=E2=80=99s suggestion, the patch I propose will =
not be needed.
However, in the meantime - I see no reason to mark data as executable, =
even
for a brief period of time.

