Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B008EC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3A520834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="svmqsThE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3A520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeLEB5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:57:30 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:39685 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLEB53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:57:29 -0500
Received: by mail-pf1-f172.google.com with SMTP id c72so9166117pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 17:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fNOZUy8yIZfGQzBreGA8wjx1LGZ7WUerRPF713cS4cw=;
        b=svmqsThE6dvMqYlgi8W+FxGrGBZiy/bSrk7+aV2rnf0ZL+mGhhYNg3Tv6swb+YWR/j
         zpsiHp4twTeWRV/i6bm5E9XI5GfL9ooPYL4P4Yewq5zm3u0sh7orMHX7HpITjTTQi+w5
         cYSU7lfACUKMCEC6VFQo6XRhNq6UkGCyw6+OXNbnZNs7DcisV5JkxSz1OAv9YDoKH+Bp
         WgCOeGmLn+dJYx9iV1CgoGH2k5yHDBL1N14Oyp9ow3A853OJnDIsXAbgS+1Gxg1Hi9Gm
         68GEKu1S+kGNln5APCYJfhftmNK8NZmG3ccxHSVlsWO89M2q3k1DJ91FAj+M3NxpMfNm
         xKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fNOZUy8yIZfGQzBreGA8wjx1LGZ7WUerRPF713cS4cw=;
        b=JkiZaJCTPgyB5t0h1ilMaWoFic1JCq8b2TLXvBg4mWEcPHaOxvi/DvBjIzHt9GbRWK
         9lV42j30WvhGVZelwWYHg1hLLVdWVaFg2d1Pf0Oz3UoGG4Ss0bId8oZquOQEA0l/H3uX
         QxMYNPWo2cwx+Uj/wAl09BSRnsUI1VOepwlIGa+ZQ9Vdpmdnl6611Xhf0nppYo0HYZky
         IU3dZvaXiVFJkiFjRzMvSUyIFSB53mWxte1bNXcYdB5w0IJYCAzJpaGzAv1gsuiY9/kh
         /op8mYf/7XNBr+K50ZXNj6qqRrafXVa6IEIV3lLr29BtaW4/gpLShNc/JK+azYV71ccm
         104Q==
X-Gm-Message-State: AA+aEWa3ndYhBRPZ49ZssSiXhE6X+reQMAsvdhqUfAdlj5Jf+wn9H5UZ
        +cnZbMRFCy8SNiH9Elsa5hzQ3A==
X-Google-Smtp-Source: AFSGD/UH4Vusu8cNyw0o8NGUzQdoUciYhZMBekE1J/nrDTw71NuFEhSTVwXIDHIhVrufvh3a5QCtmA==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr17147279pgh.206.1543975048555;
        Tue, 04 Dec 2018 17:57:28 -0800 (PST)
Received: from ?IPv6:2600:1010:b05a:3e8f:cd65:4915:ea8d:fbab? ([2600:1010:b05a:3e8f:cd65:4915:ea8d:fbab])
        by smtp.gmail.com with ESMTPSA id g3sm45387367pfe.37.2018.12.04.17.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 17:57:27 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <58a3b01c78b6c299f76c156f96211ff22ec28751.camel@intel.com>
Date:   Tue, 4 Dec 2018 17:57:26 -0800
Cc:     "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1913CD9F-B912-490A-8DEC-8C24CFF0F6D6@amacapital.net>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com> <20181128000754.18056-2-rick.p.edgecombe@intel.com> <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com> <20181204160304.GB7195@arm.com> <51281e69a3722014f718a6840f43b2e6773eed90.camel@intel.com> <CALCETrUiEWkSjnruCbBSi8WsDm071YiU5WEqoPhZbjezS0CrFw@mail.gmail.com> <58a3b01c78b6c299f76c156f96211ff22ec28751.camel@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 4, 2018, at 3:52 PM, Edgecombe, Rick P <rick.p.edgecombe@intel.com>=
 wrote:
>=20
>> On Tue, 2018-12-04 at 12:09 -0800, Andy Lutomirski wrote:
>> On Tue, Dec 4, 2018 at 12:02 PM Edgecombe, Rick P
>> <rick.p.edgecombe@intel.com> wrote:
>>>=20
>>>> On Tue, 2018-12-04 at 16:03 +0000, Will Deacon wrote:
>>>> On Mon, Dec 03, 2018 at 05:43:11PM -0800, Nadav Amit wrote:
>>>>>> On Nov 27, 2018, at 4:07 PM, Rick Edgecombe <
>>>>>> rick.p.edgecombe@intel.com>
>>>>>> wrote:
>>>>>>=20
>>>>>> Since vfree will lazily flush the TLB, but not lazily free the
>>>>>> underlying
>>>>>> pages,
>>>>>> it often leaves stale TLB entries to freed pages that could get re-
>>>>>> used.
>>>>>> This is
>>>>>> undesirable for cases where the memory being freed has special
>>>>>> permissions
>>>>>> such
>>>>>> as executable.
>>>>>=20
>>>>> So I am trying to finish my patch-set for preventing transient W+X
>>>>> mappings
>>>>> from taking space, by handling kprobes & ftrace that I missed (thanks
>>>>> again
>>>>> for
>>>>> pointing it out).
>>>>>=20
>>>>> But all of the sudden, I don=E2=80=99t understand why we have the prob=
lem that
>>>>> this
>>>>> (your) patch-set deals with at all. We already change the mappings to
>>>>> make
>>>>> the memory writable before freeing the memory, so why can=E2=80=99t we=
 make it
>>>>> non-executable at the same time? Actually, why do we make the module
>>>>> memory,
>>>>> including its data executable before freeing it???
>>>>=20
>>>> Yeah, this is really confusing, but I have a suspicion it's a combinati=
on
>>>> of the various different configurations and hysterical raisins. We can'=
t
>>>> rely on module_alloc() allocating from the vmalloc area (see nios2) nor=

>>>> can we rely on disable_ro_nx() being available at build time.
>>>>=20
>>>> If we *could* rely on module allocations always using vmalloc(), then
>>>> we could pass in Rick's new flag and drop disable_ro_nx() altogether
>>>> afaict -- who cares about the memory attributes of a mapping that's abo=
ut
>>>> to disappear anyway?
>>>>=20
>>>> Is it just nios2 that does something different?
>>>>=20
>>>> Will
>>>=20
>>> Yea it is really intertwined. I think for x86, set_memory_nx everywhere
>>> would
>>> solve it as well, in fact that was what I first thought the solution sho=
uld
>>> be
>>> until this was suggested. It's interesting that from the other thread Ma=
sami
>>> Hiramatsu referenced, set_memory_nx was suggested last year and would ha=
ve
>>> inadvertently blocked this on x86. But, on the other architectures I hav=
e
>>> since
>>> learned it is a bit different.
>>>=20
>>> It looks like actually most arch's don't re-define set_memory_*, and so a=
ll
>>> of
>>> the frob_* functions are actually just noops. In which case allocating R=
WX
>>> is
>>> needed to make it work at all, because that is what the allocation is go=
ing
>>> to
>>> stay at. So in these archs, set_memory_nx won't solve it because it will=
 do
>>> nothing.
>>>=20
>>> On x86 I think you cannot get rid of disable_ro_nx fully because there i=
s
>>> the
>>> changing of the permissions on the directmap as well. You don't want som=
e
>>> other
>>> caller getting a page that was left RO when freed and then trying to wri=
te
>>> to
>>> it, if I understand this.
>>>=20
>>=20
>> Exactly.
>>=20
>> After slightly more thought, I suggest renaming VM_IMMEDIATE_UNMAP to
>> VM_MAY_ADJUST_PERMS or similar.  It would have the semantics you want,
>> but it would also call some arch hooks to put back the direct map
>> permissions before the flush.  Does that seem reasonable?  It would
>> need to be hooked up that implement set_memory_ro(), but that should
>> be quite easy.  If nothing else, it could fall back to set_memory_ro()
>> in the absence of a better implementation.
>=20
> With arch hooks, I guess we could remove disable_ro_nx then. I think you w=
ould
> still have to flush twice on x86 to really have no W^X violating window fr=
om the
> direct map (I think x86 is the only one that sets permissions there?). But=
 this
> could be down from sometimes 3. You could also directly vfree non exec RO m=
emory
> without set_memory_, like in BPF.=20

Just one flush if you=E2=80=99re careful. Set the memory not-present in the d=
irect map and zap it from the vmap area, then flush, then set it RW in the=20=


>=20
> The vfree deferred list would need to be moved since it then couldn't reus=
e the
> allocations since now the vfreed memory might be RO. It could kmalloc, or l=
ookup
> the vm_struct. So would probably be a little slower in the interrupt case.=
 Is
> this ok?

I=E2=80=99m fine with that. For eBPF, we should really have a lookaside list=
 for small allocations.

