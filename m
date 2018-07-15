Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73FFECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 05:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FC2208BA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 05:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsfuxnNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FC2208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeGOFrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 01:47:45 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46444 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeGOFrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 01:47:45 -0400
Received: by mail-io0-f195.google.com with SMTP id i18-v6so19058391ioj.13;
        Sat, 14 Jul 2018 22:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QW17LzTKLHMlIiGKf4STqLTs13MMTL942LYGFPuVZMs=;
        b=gsfuxnNZDAHzAckT+84CKifnK1H6CjeiwwVqmDCh4AEcJxLtb+NKczlxkm6bB/enwe
         UQYgimzDW4iol9c2ZJ/MQQSuByGTW4xEGfe2fg/767BVzLcJqErlDIDJwsBNHqloCvhL
         ZzUStoMcCOhVTHIsxDFLO+tWqztC/tpkZq/zy6XoogUapdWEm8a8hmQ5e0opbKMWM/4c
         e+cQ8c3cdY1uQOkMTV0VUhpTiMJLZoSGfag0+8GZep3Q78x45rD5AjHL+EJLgZ8ss9E9
         sQgGNR+07oHVddAoCUXr8tp0fdI5MJ09khQguO/8Z8ItYMc0C1uFez2aMVmqStkdpJJd
         DmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QW17LzTKLHMlIiGKf4STqLTs13MMTL942LYGFPuVZMs=;
        b=ckofZw61MY6LK0QaWilQSD7RJOpQJ0Z/bAHxrWOfcUesTfmkUo3r3gTW99FdVyFToK
         P9tksXhbncv8+8hBACj8bzH+Jwr2FUcUMfZm4uwhrQzhhhQOGOM2F6Ac4MCKUi6jb5Xy
         OTZhXmoOPRiA1fwCTFoxuA8wj+DxNCph5h0OeL8cxelREPvmhtPelmNtZBmLVQjiW05g
         j+yIItKs1l5PJFgWtae0BHPZGlm4j4rOB+5FjHEXxGOCW+FAgdKdBNf2+8k+iluXlyzX
         rLw8+5WK/aNbWVnfkp9mDOPuNw6OsC1HjbhiPBgS17P5dxdQqn0piwbIglIQ3WcJKKcf
         B/bA==
X-Gm-Message-State: AOUpUlHpWAxvp1wJ46REpMBxonfRdexcUVU05s2CTOC0qaGzWAF014p5
        fkn30xGnQAjEQgzd+owqixnCC7GquS2n/CwUmJo=
X-Google-Smtp-Source: AAOMgpeygcqlePFDkuZPqoPEM8E43l4IyJd+Uv+m+WPOUdvkwrnV0hSn+9/7PUg+yL0UD7r0eWigwiGeCyEUjasC7rQ=
X-Received: by 2002:a6b:b845:: with SMTP id i66-v6mr33801372iof.142.1531632366361;
 Sat, 14 Jul 2018 22:26:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 22:25:25
 -0700 (PDT)
In-Reply-To: <CALvZod5d37v8fv=VCFLa7g+ntPvaT-h8jRQw1+iry2dxb=yXxQ@mail.gmail.com>
References: <1531557122-12540-1-git-send-email-laoar.shao@gmail.com>
 <CALvZod57QFRVQ7kM4LSNQJACQ+dGC_otJkqK-5+i-0b53Zq5aA@mail.gmail.com>
 <CALOAHbDV73+X-y7V2Z4nX1C7uCY6yzBPTPZhEvTpN3f7_qWwUw@mail.gmail.com> <CALvZod5d37v8fv=VCFLa7g+ntPvaT-h8jRQw1+iry2dxb=yXxQ@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 15 Jul 2018 13:25:25 +0800
Message-ID: <CALOAHbBQurMrE6ZCLLsdmbqFrUX3vFVpZtFLvvL_WGnPoF0OSA@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid bothering interrupted task when charge memcg in softirq
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 12:25 PM, Shakeel Butt <shakeelb@google.com> wrote:
> On Sat, Jul 14, 2018 at 7:10 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>
>> On Sat, Jul 14, 2018 at 11:38 PM, Shakeel Butt <shakeelb@google.com> wrote:
>> > On Sat, Jul 14, 2018 at 1:32 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>> >>
>> >> try_charge maybe executed in packet receive path, which is in interrupt
>> >> context.
>> >> In this situation, the 'current' is the interrupted task, which may has
>> >> no relation to the rx softirq, So it is nonsense to use 'current'.
>> >>
>> >
>> > Have you actually seen this occurring?
>>
>> Hi Shakeel,
>>
>> I'm trying to produce this issue, but haven't find it occur yet.
>>
>> > I am not very familiar with the
>> > network code but I can think of two ways try_charge() can be called
>> > from network code. Either through kmem charging or through
>> > mem_cgroup_charge_skmem() and both locations correctly handle
>> > interrupt context.
>> >
>>
>> Why do you say that mem_cgroup_charge_skmem() correctly hanle
>> interrupt context ?
>>
>> Let me show you why mem_cgroup_charge_skmem isn't hanling interrupt
>> context correctly.
>>
>> mem_cgroup_charge_skmem() is calling  try_charge() twice.
>> The first one is with GFP_NOWAIT as the gfp_mask, and the second one
>> is with  (GFP_NOWAIT |  __GFP_NOFAIL) as the gfp_mask.
>>
>> If page_counter_try_charge() failes at the first time, -ENOMEM is returned.
>> Then mem_cgroup_charge_skmem() will call try_charge() once more with
>> __GFP_NOFAIL set, and this time if If page_counter_try_charge() failes
>> again the '
>> force' label in  try_charge() will be executed and 0 is returned.
>>
>> No matter what, the 'current' will be used and touched, that is
>> meaning mem_cgroup_charge_skmem() isn't hanling the interrupt context
>> correctly.
>>
>
> Hi Yafang,
>
> If you check mem_cgroup_charge_skmem(), the memcg passed is not
> 'current' but is from the sock object i.e. sk->sk_memcg for which the
> network buffer is allocated for.
>

That's correct, the memcg if from the sock object.
But the point is, in this situation why 'current' is used in try_charge() ?
As 'current' is not related with the memcg, which is just a interrupted task.


> If the network buffers is allocated through kmem interface, the
> charging is bypassed altogether (through memcg_kmem_bypass()) for
> interrupt context.
>

Yes.

Thanks
Yafang
