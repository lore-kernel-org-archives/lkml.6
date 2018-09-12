Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB082C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E912146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="d6mSPj9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E912146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIMEWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:22:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44802 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeIMEWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:22:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so1788079pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 16:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UoKqXwFgOsjqLaGWIQfyCA4+jxGGduXNkniMp/RwKlk=;
        b=d6mSPj9zWY0o0f8NDJ9NZ2IhofuJBVvvvRDOx/L2dkc9qF7ApyfCVkxfBbeWDO+p4Z
         fNH/SpDBhA9mIFExx7xND11KBNqV80rqI5fvIIh2Lj1rv3/3mWeUeFvycJB/JFxTotIv
         C+DfUBkUkXl2lOhalvZmkUc4oQfeKpFsICtng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UoKqXwFgOsjqLaGWIQfyCA4+jxGGduXNkniMp/RwKlk=;
        b=PSKLnf1p7ERMroa5SFRhHo1vN2zTPeq8aMG8r64HIfAVXFgbVQHnkPttpYIggNZiMX
         ynFhJ2h2aDU0OnhGGoBY4y7ULG6lFYuSMxhtrcgPkFm+Q5AIK9OavAjD4xWjBR+7OgQw
         eVfQPZ/JRl5YdD+my4ydAK5Q90xh7kni2Gpdw0bPioKCoiRHPJ+OBX23Y3SRu0FYGTC9
         G4umJXBT2cse5V/4IR9UiniS/xuuQ2Y03puZy4rvFVBpAYLcF2ZS6lcKEpkF106JK+ga
         BjppyKtvF4G99hCr0LFmLEEQvokmB9YlBXpdruFhcBI6loTj+1R+fF4fjHWXt6LilfUt
         nYnw==
X-Gm-Message-State: APzg51CcwoTXaEWxf1BBDJPN8oncpeXFzc/tJI/6jZ1n9DdEanx9AtLE
        QKGO4Oht5oZnF4g1F26lb2AqXanaWjI=
X-Google-Smtp-Source: ANB0VdZf0GkZs29geyB6m/KmTegqAWBNC9gpltkbNT/jvRyMSFaBkX9898KlfdOlqHSMaHEJM+iFTA==
X-Received: by 2002:a65:490e:: with SMTP id p14-v6mr4393133pgs.437.1536794136832;
        Wed, 12 Sep 2018 16:15:36 -0700 (PDT)
Received: from breakout.internal.digitalocean.com (97-120-204-225.ptld.qwest.net. [97.120.204.225])
        by smtp.gmail.com with ESMTPSA id f13-v6sm2530042pgs.92.2018.09.12.16.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 16:15:36 -0700 (PDT)
Received: by breakout.internal.digitalocean.com (Postfix, from userid 1000)
        id 7F6838A2A78; Wed, 12 Sep 2018 16:15:35 -0700 (PDT)
Date:   Wed, 12 Sep 2018 16:15:35 -0700
From:   Nishanth Aravamudan <naravamudan@digitalocean.com>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 00/60] Coscheduling for Linux
Message-ID: <20180912231535.GA1546@breakout>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180912002449.GA21797@breakout>
 <c41f4e4f-30a1-5a3c-dec6-dc8f1d181c94@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c41f4e4f-30a1-5a3c-dec6-dc8f1d181c94@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.09.2018 [21:34:14 +0200], Jan H. Schönherr wrote:
> On 09/12/2018 02:24 AM, Nishanth Aravamudan wrote:
> > [ I am not subscribed to LKML, please keep me CC'd on replies ]
> > 
> > I tried a simple test with several VMs (in my initial test, I have 48
> > idle 1-cpu 512-mb VMs and 2 idle 2-cpu, 2-gb VMs) using libvirt, none
> > pinned to any CPUs. When I tried to set all of the top-level libvirt cpu
> > cgroups' to be co-scheduled (/bin/echo 1 >
> > /sys/fs/cgroup/cpu/machine/<VM-x>.libvirt-qemu/cpu.scheduled), the
> > machine hangs. This is using cosched_max_level=1.
> > 
> > There are several moving parts there, so I tried narrowing it down, by
> > only coscheduling one VM, and thing seemed fine:
> > 
> > /sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# echo 1 > cpu.scheduled 
> > /sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# cat cpu.scheduled 
> > 1
> > 
> > One thing that is not entirely obvious to me (but might be completely
> > intentional) is that since by default the top-level libvirt cpu cgroups
> > are empty:
> > 
> > /sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# cat tasks 
> > 
> > the result of this should be a no-op, right? [This becomes relevant
> > below] Specifically, all of the threads of qemu are in sub-cgroups,
> > which do not indicate they are co-scheduling:
> > 
> > /sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# cat emulator/cpu.scheduled 
> > 0
> > /sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# cat vcpu0/cpu.scheduled 
> > 0
> > 
> 
> This setup *should* work. It should be possible to set cpu.scheduled
> independent of the cpu.scheduled values of parent and child task groups.
> Any intermediate regular task group (i.e. cpu.scheduled==0) will still
> contribute the group fairness aspects.

Ah I see, that makes sense, thank you.

> That said, I see a hang, too. It seems to happen, when there is a
> cpu.scheduled!=0 group that is not a direct child of the root task group.
> You seem to have "/sys/fs/cgroup/cpu/machine" as an intermediate group.
> (The case ==0 within !=0 within the root task group works for me.)
>
> I'm going to dive into the code.
> 
> [...]
> > I am happy to do any further debugging I can do, or try patches on top
> > of those posted on the mailing list.
> 
> If you're willing, you can try to get rid of the intermediate "machine"
> cgroup in your setup for the moment. This might tell us, whether we're
> looking at the same issue.

Yep I will do this now. Note that if I just try to set machine's
cpu.scheduled to 1, with no other changes (not even changing any child
cgroup's cpu.scheduled yet), I get the following trace:

[16052.164259] ------------[ cut here ]------------
[16052.168973] rq->clock_update_flags < RQCF_ACT_SKIP
[16052.168991] WARNING: CPU: 59 PID: 59533 at kernel/sched/sched.h:1303 assert_clock_updated.isra.82.part.83+0x15/0x18
[16052.184424] Modules linked in: act_police cls_basic ebtable_filter ebtables ip6table_filter iptable_filter nbd ip6table_raw ip6_tables xt_CT iptable_raw ip_tables s
[16052.255653]  xxhash raid10 raid0 multipath linear raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq ses libcrc32c raid1 enclosure scsi
[16052.276029] CPU: 59 PID: 59533 Comm: bash Tainted: G           O      4.19.0-rc2-amazon-cosched+ #1
[16052.291142] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 1.4.9 06/29/2018
[16052.298728] RIP: 0010:assert_clock_updated.isra.82.part.83+0x15/0x18
[16052.305166] Code: 0f 85 75 ff ff ff 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 c7 c7 28 30 eb 94 31 c0 c6 05 47 18 27 01 01 e8 f4 df fb ff <0f> 0b c3 48 8b 970
[16052.324050] RSP: 0018:ffff9cada610bca8 EFLAGS: 00010096
[16052.329361] RAX: 0000000000000026 RBX: ffff8f06d65bae00 RCX: 0000000000000006
[16052.336580] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff8f1edf756620
[16052.343799] RBP: ffff8f06e0462e00 R08: 000000000000079b R09: ffff9cada610bc48
[16052.351018] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8f06e0462e80
[16052.358237] R13: 0000000000000001 R14: ffff8f06e0462e00 R15: 0000000000000001
[16052.365458] FS:  00007ff07ab02740(0000) GS:ffff8f1edf740000(0000) knlGS:0000000000000000
[16052.373647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16052.379480] CR2: 00007ff07ab139d8 CR3: 0000002ca2aea002 CR4: 00000000007626e0
[16052.386698] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[16052.393917] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[16052.401137] PKRU: 55555554
[16052.403927] Call Trace:
[16052.406460]  update_curr+0x19f/0x1c0
[16052.410116]  dequeue_entity+0x21/0x8c0
[16052.413950]  ? terminate_walk+0x55/0xb0
[16052.417871]  dequeue_entity_fair+0x46/0x1c0
[16052.422136]  sdrq_update_root+0x35d/0x480
[16052.426227]  cosched_set_scheduled+0x80/0x1c0
[16052.430675]  cpu_scheduled_write_u64+0x26/0x30
[16052.435209]  cgroup_file_write+0xe3/0x140
[16052.439305]  kernfs_fop_write+0x110/0x190
[16052.443397]  __vfs_write+0x26/0x170
[16052.446974]  ? __audit_syscall_entry+0x101/0x130
[16052.451674]  ? _cond_resched+0x15/0x30
[16052.455509]  ? __sb_start_write+0x41/0x80
[16052.459600]  vfs_write+0xad/0x1a0
[16052.462997]  ksys_write+0x42/0x90
[16052.466397]  do_syscall_64+0x55/0x110
[16052.470152]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[16052.475286] RIP: 0033:0x7ff07a1e93c0
[16052.478943] Code: 73 01 c3 48 8b 0d c8 2a 2d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d bd 8c 2d 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff4
[16052.497827] RSP: 002b:00007ffc73e335b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[16052.505498] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ff07a1e93c0
[16052.512715] RDX: 0000000000000002 RSI: 00000000023a0408 RDI: 0000000000000001
[16052.519936] RBP: 00000000023a0408 R08: 000000000000000a R09: 00007ff07ab02740
[16052.527156] R10: 00007ff07a4bb6a0 R11: 0000000000000246 R12: 00007ff07a4bd400
[16052.534374] R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
[16052.541593] ---[ end trace b20c73e6c2bec22c ]---

I'll reboot and move some cgroups around :)

Thanks,
Nish
