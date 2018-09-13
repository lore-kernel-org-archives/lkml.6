Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410B3C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC920213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="QvXPb52C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC920213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIMINE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:13:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41458 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeIMIND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:13:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so1971092pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 20:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yeOxLNL/cq6hLacUOPhB4Sx/KxG0gdcXtM1t8O97FjU=;
        b=QvXPb52CTyxJA9vmy3CqSldK5uHI0U2beMdqYB2OMedu4M1tp2vMU6w2A0io4C67Pp
         +AvjzQYtnQoatFfoLt62O+hkRgroG9jQyRfZf+gNa6evxUY4b+LpVXBuxhViuOwL6lyf
         b/BjpoLvlSL3btkZO6TRyItKYwme6lT2flmXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yeOxLNL/cq6hLacUOPhB4Sx/KxG0gdcXtM1t8O97FjU=;
        b=DjDrF5Z65f4C/KWvQRrKe2Br/uG7WoPcKpIUky7XpMSI953MsF3q3dZtkW8dI/pdAQ
         4bJUMS/vRB2dluhG/IupgPst+M3yVGe9fAnJyrHjdvH6MHVmPjqAPHnjufjd7yU+qszD
         Z5fznqjqs1QgJC55YHGYlP6Mc4Qze7IQJDo281y0PXI/yYcPUGxjY7ESJktJHIeWibu0
         yd9hwTRzVkS6uXfZtoPUyrZz06DdUmTP+UCO9q8ELRNfpAMz5rkey9awp5Op/2t9t6LT
         XLoAxbFQ/J7WAC29IwRRYrMo8z3O6XX9zG3TjQ+2bjCkGvBRpUJqBUJUr6cLkUWAbA91
         cCtQ==
X-Gm-Message-State: APzg51D6Hqb+akgAB5Pq27vwxkXTo3uMsx3xdTqBBVKGgM+IfsxNMlMK
        i5qEhRvPjWLGGtCAszAsICW8MAfxYg8=
X-Google-Smtp-Source: ANB0VdZQlbyUIx46yu4IsCAEpBX/dYTlPfXPWcDUvDpZg/75E2HYg/FChkIgddEH5AFcsXfaf+eSQQ==
X-Received: by 2002:a62:198e:: with SMTP id 136-v6mr5278566pfz.103.1536807935814;
        Wed, 12 Sep 2018 20:05:35 -0700 (PDT)
Received: from breakout.internal.digitalocean.com (97-120-204-225.ptld.qwest.net. [97.120.204.225])
        by smtp.gmail.com with ESMTPSA id r64-v6sm3422123pfk.157.2018.09.12.20.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 20:05:35 -0700 (PDT)
Received: by breakout.internal.digitalocean.com (Postfix, from userid 1000)
        id 2BFAA8A2A78; Wed, 12 Sep 2018 20:05:33 -0700 (PDT)
Date:   Wed, 12 Sep 2018 20:05:33 -0700
From:   Nishanth Aravamudan <naravamudan@digitalocean.com>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 00/60] Coscheduling for Linux
Message-ID: <20180913030533.GB1546@breakout>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180912002449.GA21797@breakout>
 <c41f4e4f-30a1-5a3c-dec6-dc8f1d181c94@amazon.de>
 <89b4f0cd-d324-14bd-3991-576de9849e34@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89b4f0cd-d324-14bd-3991-576de9849e34@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.2018 [01:18:14 +0200], Jan H. Schönherr wrote:
> On 09/12/2018 09:34 PM, Jan H. Schönherr wrote:
> > That said, I see a hang, too. It seems to happen, when there is a
> > cpu.scheduled!=0 group that is not a direct child of the root task group.
> > You seem to have "/sys/fs/cgroup/cpu/machine" as an intermediate group.
> > (The case ==0 within !=0 within the root task group works for me.)
> > 
> > I'm going to dive into the code.
> 
> With the patch below (which technically changes patch 55/60), the hang
> I experienced is gone.
> 
> Please let me know, if it works for you as well.

Yep, this does fix the soft lockups for me, thanks! However, if I do a:

# find /sys/fs/cgroup/cpu/machine -mindepth 2 -maxdepth 2 -name cpu.scheduled -exec /bin/sh -c "echo 1 > {} " \;

which should co-schedule all the cgroups for emulator and vcpu threads,
I see the same warning I mentioned in my other e-mail:

[10469.832822] ------------[ cut here ]------------
[10469.837555] rq->clock_update_flags < RQCF_ACT_SKIP
[10469.837574] WARNING: CPU: 89 PID: 49630 at kernel/sched/sched.h:1303 assert_clock_updated.isra.82.part.83+0x15/0x18
[10469.853042] Modules linked in: act_police cls_basic ebtable_filter ebtables ip6table_filter iptable_filter nbd ip6table_raw ip6_tables xt_CT iptable_raw ip_tables s
[10469.924590]  xxhash raid10 raid0 multipath linear raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq ses libcrc32c raid1 enclosure scsi
[10469.945010] CPU: 89 PID: 49630 Comm: sh Tainted: G           O      4.19.0-rc2-amazon-cosched+ #2
[10469.960061] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 1.4.9 06/29/2018
[10469.967657] RIP: 0010:assert_clock_updated.isra.82.part.83+0x15/0x18
[10469.974126] Code: 0f 85 75 ff ff ff 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 c7 c7 28 30 eb 8d 31 c0 c6 05 67 18 27 01 01 e8 14 e0 fb ff <0f> 0b c3 48 8b 970
[10469.993018] RSP: 0018:ffffabc0b534fca8 EFLAGS: 00010096
[10469.998341] RAX: 0000000000000026 RBX: ffff9d74d12ede00 RCX: 0000000000000006
[10470.005559] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff9d74dfb16620
[10470.012780] RBP: ffff9d74df562e00 R08: 0000000000000796 R09: ffffabc0b534fc48
[10470.020005] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9d74d2849800
[10470.027226] R13: 0000000000000001 R14: ffff9d74df562e00 R15: 0000000000000001
[10470.034445] FS:  00007fea86812740(0000) GS:ffff9d74dfb00000(0000) knlGS:0000000000000000
[10470.042678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10470.048511] CR2: 00005620f00314d8 CR3: 0000002cc55ea004 CR4: 00000000007626e0
[10470.055739] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[10470.062965] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[10470.070186] PKRU: 55555554
[10470.072976] Call Trace:
[10470.075508]  update_curr+0x19f/0x1c0
[10470.079211]  dequeue_entity+0x21/0x8c0
[10470.083056]  dequeue_entity_fair+0x46/0x1c0
[10470.087321]  sdrq_update_root+0x35d/0x480
[10470.091420]  cosched_set_scheduled+0x80/0x1c0
[10470.095892]  cpu_scheduled_write_u64+0x26/0x30
[10470.100427]  cgroup_file_write+0xe3/0x140
[10470.104523]  kernfs_fop_write+0x110/0x190
[10470.108624]  __vfs_write+0x26/0x170
[10470.112236]  ? __audit_syscall_entry+0x101/0x130
[10470.116943]  ? _cond_resched+0x15/0x30
[10470.120781]  ? __sb_start_write+0x41/0x80
[10470.124871]  vfs_write+0xad/0x1a0
[10470.128268]  ksys_write+0x42/0x90
[10470.131668]  do_syscall_64+0x55/0x110
[10470.135421]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10470.140558] RIP: 0033:0x7fea863253c0
[10470.144213] Code: 73 01 c3 48 8b 0d c8 2a 2d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d bd 8c 2d 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff4
[10470.163114] RSP: 002b:00007ffe7cb22d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[10470.170783] RAX: ffffffffffffffda RBX: 00005620f002f4d0 RCX: 00007fea863253c0
[10470.178002] RDX: 0000000000000002 RSI: 00005620f002f4d0 RDI: 0000000000000001
[10470.185222] RBP: 0000000000000002 R08: 0000000000000001 R09: 000000000000006b
[10470.192486] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000001
[10470.199705] R13: 0000000000000002 R14: 7fffffffffffffff R15: 0000000000000002
[10470.206923] ---[ end trace fbf46e2c721c7acb ]---

Thanks,
Nish
