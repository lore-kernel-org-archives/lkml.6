Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33033C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32C320882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KVObqUA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32C320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLGGkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:40:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33685 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeLGGkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:40:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so2630530ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 22:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pikRb1H5+iimWrXUrM6YIl9Ze/Ojza180B33SsQlzPg=;
        b=KVObqUA55qWwxchPXBeUYqAxkNFG0JHAw3OlrxE7eeopsMGGxrSBJ4+FL0Lh7RI2bf
         oM8GCEpl9ciA4gs2Nx5VoQE+b0epkqAB/bgizkOfiq55Vz8iqRskafFBLpkPdwUEARn8
         SI7U8he5NPoEgQRev6e5VBusidIYxUUuqWFok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pikRb1H5+iimWrXUrM6YIl9Ze/Ojza180B33SsQlzPg=;
        b=bFoIGg03JrWs/bQpXghlNG+GpoiN2GqGmclS95FxwrmF5rYEbM/S0EUHvQXzTj57Wk
         MYrK8G6gHvIdr0E0VIC14FU/KjgR/urCtcvqq0czL0m5pLmv6zrJRHUqNB/50YATVRXF
         rGEVkeEJO/Hjo3L7K70JdGx6M+AX7U6yWvxfVaIUqtZnTFnS/wmVeEM8W0h/TtzPla42
         qEGEV/rGMrSFseOIvE0wjmsZKJ0FNTZWj/g3ZxSbaI85d9SJB4B645Tid6DahxfNLaRY
         A9htJlYl7YTcJIqzWZdBpI3xdVQkc8rD/bFD0qyIt4uW9UBTZsR/9pcOxfTHS8LooPuW
         w9KA==
X-Gm-Message-State: AA+aEWa32PH+cS3Wo2FjP7oYo7DZIAzPgJ0OZmpWQawGMxH1WGQN2Kmz
        Ra8kXA4D0OibU6+fVJNxT2UxOMHgCVxXEvL1no3NkA==
X-Google-Smtp-Source: AFSGD/WbvglRz1A0qAw5lqSc3F10BsJAtdochEy+PHq+EWMHmck7aOWdinSkXzsrdkaKKzxgyTXbCXirld/+25S4L5k=
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr561498lji.30.1544164815145;
 Thu, 06 Dec 2018 22:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20181205093555.5386-1-sashal@kernel.org> <20181205093555.5386-40-sashal@kernel.org>
In-Reply-To: <20181205093555.5386-40-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 7 Dec 2018 12:10:03 +0530
Message-ID: <CA+G9fYt9o298ZzaiFWDrxMW8OvC2BqvY45r7oU9kz=jtmrUZ-Q@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 040/123] bpf: allocate local storage buffers
 using GFP_ATOMIC
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Roman Gushchin <guro@fb.com>
Cc:     linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, guroan@gmail.com,
        ast@kernel.org, sashal@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 at 15:08, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Roman Gushchin <guroan@gmail.com>
>
> [ Upstream commit 569a933b03f3c48b392fe67c0086b3a6b9306b5a ]
>
> Naresh reported an issue with the non-atomic memory allocation of
> cgroup local storage buffers:
>
> [   73.047526] BUG: sleeping function called from invalid context at
> /srv/oe/build/tmp-rpb-glibc/work-shared/intel-corei7-64/kernel-source/mm/slab.h:421
> [   73.060915] in_atomic(): 1, irqs_disabled(): 0, pid: 3157, name: test_cgroup_sto
> [   73.068342] INFO: lockdep is turned off.
> [   73.072293] CPU: 2 PID: 3157 Comm: test_cgroup_sto Not tainted
> 4.20.0-rc2-next-20181113 #1
> [   73.080548] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [   73.088018] Call Trace:
> [   73.090463]  dump_stack+0x70/0xa5
> [   73.093783]  ___might_sleep+0x152/0x240
> [   73.097619]  __might_sleep+0x4a/0x80
> [   73.101191]  __kmalloc_node+0x1cf/0x2f0
> [   73.105031]  ? cgroup_storage_update_elem+0x46/0x90
> [   73.109909]  cgroup_storage_update_elem+0x46/0x90
>
> cgroup_storage_update_elem() (as well as other update map update
> callbacks) is called with disabled preemption, so GFP_ATOMIC
> allocation should be used: e.g. alloc_htab_elem() in hashtab.c.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I have reported above issue on 4.20.0-rc2-next-20181113.
Now this BUG re-occurring on 4.19.8-rc1 on x86_64 and arm64 devices.

[   70.288592] BUG: sleeping function called from invalid context at
/srv/oe/build/tmp-rpb-glibc/work-shared/intel-corei7-64/kernel-source/mm/slab.h:421
[   70.301992] in_atomic(): 1, irqs_disabled(): 0, pid: 3001, name:
test_cgroup_sto
[   70.309424] INFO: lockdep is turned off.
[   70.313416] CPU: 0 PID: 3001 Comm: test_cgroup_sto Not tainted 4.19.8-rc1 #1
[   70.320483] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   70.327953] Call Trace:
[   70.330402]  dump_stack+0x70/0xa5
[   70.333765]  ___might_sleep+0x152/0x240
[   70.337599]  __might_sleep+0x4a/0x80
[   70.341169]  __kmalloc_node+0x1d1/0x300
[   70.345003]  ? cgroup_storage_update_elem+0x46/0x90
[   70.349881]  cgroup_storage_update_elem+0x46/0x90
[   70.354585]  map_update_elem+0x1fd/0x450
[   70.358504]  __x64_sys_bpf+0x129/0x270
[   70.362258]  do_syscall_64+0x55/0x190
[   70.365923]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   70.370974] RIP: 0033:0x7f42e0ebb969
[   70.374544] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d df e4 2b 00 f7 d8 64 89
01 48
[   70.393281] RSP: 002b:00007ffde61a0a08 EFLAGS: 00000202 ORIG_RAX:
0000000000000141
[   70.400845] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f42e0ebb969
[   70.407971] RDX: 0000000000000048 RSI: 00007ffde61a0a50 RDI: 0000000000000002
[   70.415094] RBP: 00007ffde61a0a20 R08: 00007ffde61a0a50 R09: 00007ffde61a0a50
[   70.422216] R10: 00007ffde61a0a50 R11: 0000000000000202 R12: 0000000000000005
[   70.429342] R13: 00007ffde61a0c10 R14: 0000000000000000 R15: 0000000000000000
selftests: bpf: test_cgroup_storage

Full test log links,
arm64 Juno
https://lkft.validation.linaro.org/scheduler/job/537820#L2971

x86_64 Supermicro SYS-5019S-ML/X11SSH-F
https://lkft.validation.linaro.org/scheduler/job/537772#L2724

Best regards
Naresh Kamboju

> ---
>  kernel/bpf/local_storage.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 830d7f095748..fc1605aee5ea 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -138,7 +138,8 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
>                 return -ENOENT;
>
>         new = kmalloc_node(sizeof(struct bpf_storage_buffer) +
> -                          map->value_size, __GFP_ZERO | GFP_USER,
> +                          map->value_size,
> +                          __GFP_ZERO | GFP_ATOMIC | __GFP_NOWARN,
>                            map->numa_node);
>         if (!new)
>                 return -ENOMEM;
> --
> 2.17.1
>
