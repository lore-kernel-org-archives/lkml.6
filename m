Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21896C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0D1206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0D1206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeKUFdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 00:33:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60080 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbeKUFdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 00:33:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C56A1BF7;
        Tue, 20 Nov 2018 11:03:02 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B48D3F5AF;
        Tue, 20 Nov 2018 11:03:02 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 8D1031AE07D8; Tue, 20 Nov 2018 19:03:17 +0000 (GMT)
Date:   Tue, 20 Nov 2018 19:03:17 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Jan Glauber <Jan.Glauber@cavium.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dcache_readdir NULL inode oops
Message-ID: <20181120190317.GA29161@arm.com>
References: <20181109143744.GA12128@hc>
 <20181109155856.GC2091@brain-police>
 <20181110111656.GA16667@hc>
 <20181120182854.GC28838@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120182854.GC28838@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 06:28:54PM +0000, Will Deacon wrote:
> On Sat, Nov 10, 2018 at 11:17:03AM +0000, Jan Glauber wrote:
> > On Fri, Nov 09, 2018 at 03:58:56PM +0000, Will Deacon wrote:
> > > On Fri, Nov 09, 2018 at 02:37:51PM +0000, Jan Glauber wrote:
> > > > I'm seeing the following oops reproducible with upstream kernel on arm64
> > > > (ThunderX2):
> > > 
> > > [...]
> > > 
> > > > It happens after 1-3 hours of running 'stress-ng --dev 128'. This testcase
> > > > does a scandir of /dev and then calls random stuff like ioctl, lseek,
> > > > open/close etc. on the entries. I assume no files are deleted under /dev
> > > > during the testcase.
> > > >
> > > > The NULL pointer is the inode pointer of next. The next dentry->d_flags is
> > > > DCACHE_RCUACCESS when this happens.
> > > >
> > > > Any hints on how to further debug this?
> > > 
> > > Can you reproduce the issue with vanilla -rc1 and do you have a "known good"
> > > kernel?
> > 
> > I can try out -rc1, but IIRC this wasn't bisectible as the bug was present at
> > least back to 4.14. I need to double check that as there were other issues
> > that are resolved now so I may confuse things here. I've defintely seen
> > the same bug with 4.18.
> > 
> > Unfortunately I lost access to the machine as our data center seems to be
> > moving currently so it might take some days until I can try -rc1.
> 
> Ok, I've just managed to reproduce this in a KVM guest running v4.20-rc3 on
> both the host and the guest, so if anybody has any ideas of things to try then
> I'm happy to give them a shot. In the meantime, I'll try again with a bunch of
> debug checks enabled.

Weee, I eventually hit a use-after-free from KASAN. See below.

Will

--->8

[  615.973367] ==================================================================
[  615.974675] BUG: KASAN: use-after-free in next_positive.isra.2+0x188/0x1a0
[  615.975574] Read of size 8 at addr ffff8002fb33c190 by task stress-ng-dev/3145
[  615.977348] 
[  615.977692] CPU: 16 PID: 3145 Comm: stress-ng-dev Tainted: G      D           4.20.0-rc3-00012-g40b114779944 #2
[  615.980171] Hardware name: linux,dummy-virt (DT)
[  615.981325] Call trace:
[  615.981765]  dump_backtrace+0x0/0x280
[  615.982386]  show_stack+0x14/0x20
[  615.983125]  dump_stack+0xc4/0xec
[  615.983141]  print_address_description+0x60/0x25c
[  615.985226]  kasan_report+0x1a8/0x358
[  615.986161]  __asan_report_load8_noabort+0x18/0x20
[  615.986978]  next_positive.isra.2+0x188/0x1a0
[  615.987767]  dcache_readdir+0x2cc/0x488
[  615.988428]  iterate_dir+0x168/0x448
[  615.989342]  ksys_getdents64+0xe8/0x248
[  615.990334]  __arm64_sys_getdents64+0x68/0x98
[  615.990341]  el0_svc_common+0x104/0x210
[  615.990345]  el0_svc_handler+0x48/0xb0
[  615.990349]  el0_svc+0x8/0xc
[  615.990356] 
[  615.994175] Allocated by task 2720:
[  615.994184]  kasan_kmalloc.part.1+0x40/0x108
[  615.994188]  kasan_kmalloc+0xb4/0xc8
[  615.994192]  kasan_slab_alloc+0x14/0x20
[  615.994195]  kmem_cache_alloc+0x130/0x1f8
[  615.994203]  __d_alloc+0x30/0x848
[  615.994215]  d_alloc+0x30/0x1d0
[  616.000554]  d_alloc_name+0x84/0xb0
[  616.000562]  devpts_pty_new+0x2e0/0x5e8
[  616.000568]  ptmx_open+0x14c/0x288
[  616.000576]  chrdev_open+0x194/0x408
[  616.000586]  do_dentry_open+0x2e8/0xac8
[  616.004282]  vfs_open+0x8c/0xc0
[  616.004286]  path_openat+0x694/0x33e8
[  616.004288]  do_filp_open+0x13c/0x200
[  616.004296]  do_sys_open+0x1dc/0x2e0
[  616.006865]  __arm64_sys_openat+0x88/0xc8
[  616.006872]  el0_svc_common+0x104/0x210
[  616.006876]  el0_svc_handler+0x48/0xb0
[  616.006880]  el0_svc+0x8/0xc
[  616.006881] 
[  616.006883] Freed by task 0:
[  616.006889]  __kasan_slab_free+0x114/0x228
[  616.006897]  kasan_slab_free+0x10/0x18
[  616.012068]  kmem_cache_free+0x60/0x1e8
[  616.012071]  __d_free+0x18/0x20
[  616.012081]  rcu_process_callbacks+0x46c/0x940
[  616.012086]  __do_softirq+0x28c/0x6cc
[  616.012087] 
[  616.012100] The buggy address belongs to the object at ffff8002fb33c100
[  616.012100]  which belongs to the cache dentry of size 192
[  616.017462] The buggy address is located 144 bytes inside of
[  616.017462]  192-byte region [ffff8002fb33c100, ffff8002fb33c1c0)
[  616.017465] The buggy address belongs to the page:
[  616.017470] page:ffff7e000beccf00 count:1 mapcount:0 mapping:ffff800358c13400 index:0x0 compound_mapcount: 0
[  616.017477] flags: 0x1ffff00000010200(slab|head)
[  616.017488] raw: 1ffff00000010200 dead000000000100 dead000000000200 ffff800358c13400
[  616.024873] raw: 0000000000000000 0000000080400040 00000001ffffffff 0000000000000000
[  616.024875] page dumped because: kasan: bad access detected
[  616.024876] 
[  616.024877] Memory state around the buggy address:
[  616.024882]  ffff8002fb33c080: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
[  616.024885]  ffff8002fb33c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  616.024887] >ffff8002fb33c180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[  616.024889]                          ^
[  616.024891]  ffff8002fb33c200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  616.024893]  ffff8002fb33c280: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
[  616.024894] ==================================================================
