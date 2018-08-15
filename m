Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52783C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B93214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="YXWDIsaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B93214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbeHOUFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:05:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43262 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOUFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:05:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id a14-v6so766694pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=z2n8tXPPZOiGrIDINz3F1gojepmxxUzXsiSeWHPwrbw=;
        b=YXWDIsajzLu5hpnV7by4oKyK41T1vPL08WjcaLdkkckO7I8iYD7i7hmvEaGz02rb1K
         AaWt91Hz6lhLsnr5RstpuMzGajQCZ+YbpSIwiWVFvk7C95d84xTpeEGSTqmI9tlBfMIL
         x4B73VBek4MwRL7KtFCqbkzdQ0L6JhxFQnw4rGIq2RwS+QsaUUtuI1J8krfUqVTb26KD
         +YJQU3RDh2AxLOdMe9sGFllqB1p/1W6zDroNV0R3Lb99uEVHW/HXmoueORuSj4BEfH3I
         x8Bti6I40TVOXeGGolMZKPLPXdjSMTGX0MXguFqfz2doNjrXvjJhqa1TdS8eXm2moaq0
         ckeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=z2n8tXPPZOiGrIDINz3F1gojepmxxUzXsiSeWHPwrbw=;
        b=DCh+73QJ82LX+ivRVhRPe6zrSC7zDwlcoSNh4noVqO6yMxQZBfKLe0czhF4lfhd4jK
         icgDjf7GBZkA4kPWQMgAadkhtW9YF2PeZMbtgJgf/cyiPSW8+75aV7nFVYAeVna5lrJ9
         hwO4tuu1H+jwZpS6XBkZSOjEuGShl6tDTyRSj1q5Ahug08nO34cl3xZcXdUiIVeIDxBL
         CDleR0leORneYfYoVCVqUXEWUPJOUCpmEofnSbHckm3sejuZxJj0Z/gWoQrOVR8ljVqV
         n3iRn/uBNau1peXzo5mp+Bp+/hrFykhyEyPzEbM4sNCfg2KLsRd/ADaTmvc2SHhnQt7C
         s9hA==
X-Gm-Message-State: AOUpUlH11ZL5e2gMX5G9oNW1evJO/vlT0oKqGzVkS1anNm7dDFYWfTTc
        r/NfjNSeI5pqSNlEU5lgNGTciA==
X-Google-Smtp-Source: AA+uWPxLGWGXg/tjgZXeP60D6/3Nfmb5twGTV7ZybyYdq7ujy0SDHGLl9YOkdmpYcu8wFc7wq3fq5g==
X-Received: by 2002:a62:6283:: with SMTP id w125-v6mr28619019pfb.108.1534353164218;
        Wed, 15 Aug 2018 10:12:44 -0700 (PDT)
Received: from ?IPv6:2600:1010:b010:3fbd:7d76:67ee:fa0f:6b7f? ([2600:1010:b010:3fbd:7d76:67ee:fa0f:6b7f])
        by smtp.gmail.com with ESMTPSA id e7-v6sm47712998pgc.55.2018.08.15.10.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 10:12:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 1/2] mm: rework memcg kernel stack accounting
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180815165513.GA26330@castle.DHCP.thefacebook.com>
Date:   Wed, 15 Aug 2018 10:12:42 -0700
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Michal Hocko <mhocko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2393E780-2B97-4BEE-8374-8E9E5249E5AD@amacapital.net>
References: <20180815003620.15678-1-guro@fb.com> <20180815163923.GA28953@cmpxchg.org> <20180815165513.GA26330@castle.DHCP.thefacebook.com>
To:     Roman Gushchin <guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 15, 2018, at 9:55 AM, Roman Gushchin <guro@fb.com> wrote:
>=20
>> On Wed, Aug 15, 2018 at 12:39:23PM -0400, Johannes Weiner wrote:
>>> On Tue, Aug 14, 2018 at 05:36:19PM -0700, Roman Gushchin wrote:
>>> @@ -224,9 +224,14 @@ static unsigned long *alloc_thread_stack_node(struc=
t task_struct *tsk, int node)
>>>        return s->addr;
>>>    }
>>>=20
>>> +    /*
>>> +     * Allocated stacks are cached and later reused by new threads,
>>> +     * so memcg accounting is performed manually on assigning/releasing=

>>> +     * stacks to tasks. Drop __GFP_ACCOUNT.
>>> +     */
>>>    stack =3D __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
>>>                     VMALLOC_START, VMALLOC_END,
>>> -                     THREADINFO_GFP,
>>> +                     THREADINFO_GFP & ~__GFP_ACCOUNT,
>>>                     PAGE_KERNEL,
>>>                     0, node, __builtin_return_address(0));
>>>=20
>>> @@ -246,12 +251,41 @@ static unsigned long *alloc_thread_stack_node(stru=
ct task_struct *tsk, int node)
>>> #endif
>>> }
>>>=20
>>> +static void memcg_charge_kernel_stack(struct task_struct *tsk)
>>> +{
>>> +#ifdef CONFIG_VMAP_STACK
>>> +    struct vm_struct *vm =3D task_stack_vm_area(tsk);
>>> +
>>> +    if (vm) {
>>> +        int i;
>>> +
>>> +        for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
>>> +            memcg_kmem_charge(vm->pages[i], __GFP_NOFAIL,
>>> +                      compound_order(vm->pages[i]));
>>> +
>>> +        /* All stack pages belong to the same memcg. */
>>> +        mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
>>> +                     THREAD_SIZE / 1024);
>>> +    }
>>> +#endif
>>> +}
>>=20
>> Before this change, the memory limit can fail the fork, but afterwards
>> fork() can grow memory consumption unimpeded by the cgroup settings.
>>=20
>> Can we continue to use try_charge() here and fail the fork?
>=20
> We can, but I'm not convinced we should.
>=20
> Kernel stack is relatively small, and it's already allocated at this point=
.
> So IMO exceeding the memcg limit for 1-2 pages isn't worse than
> adding complexity and handle this case (e.g. uncharge partially
> charged stack). Do you have an example, when it does matter?

What bounds it to just a few pages?  Couldn=E2=80=99t there be lots of forks=
 in flight that all hit this path?  It=E2=80=99s unlikely, and there are sur=
ely easier DoS vectors, but still.=
