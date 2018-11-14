Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6F4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567222077C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567222077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733259AbeKOBMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:12:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732527AbeKOBMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:12:45 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAEF5GZj066591
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 10:09:07 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nrn7nka1p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 10:09:06 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 14 Nov 2018 15:09:06 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 14 Nov 2018 15:09:02 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAEF91YY33095776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Nov 2018 15:09:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DA65B2064;
        Wed, 14 Nov 2018 15:09:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5B97B206B;
        Wed, 14 Nov 2018 15:09:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.230.167])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 14 Nov 2018 15:09:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D5F3816C356F; Wed, 14 Nov 2018 07:08:59 -0800 (PST)
Date:   Wed, 14 Nov 2018 07:08:59 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: KMSAN: uninit-value in rcu_accelerate_cbs / KMSAN: uninit-value
 in rcu_process_callbacks
Reply-To: paulmck@linux.ibm.com
References: <CAEAjamtSGa6hVqe2QDTONjHp7H8qCvMYYuFSTswiSEnx5oUAeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEAjamtSGa6hVqe2QDTONjHp7H8qCvMYYuFSTswiSEnx5oUAeQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111415-0064-0000-0000-0000037401FF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010048; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01117358; UDB=6.00577118; IPR=6.00897467;
 MB=3.00024160; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-14 15:09:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111415-0065-0000-0000-00003B55395E
Message-Id: <20181114150859.GT4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-14_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 04:03:33AM -0500, Kyungtae Kim wrote:
> We report two crashes in v4.19-rc8 (4.20-rc1 as well, I guess):
> (Unfortunately, there is no repro for those.)
> 
> The two crashes seem to share the same issue.
> In both cases, (uninitialized) memory access violation occurs
> when "rdp->cblist" is about to be accessed (kernel/rcu/tree.c:2838,1728).
> I guess those are freed before the use, but I still haven't figured
> out the reason why.
> I'm looking forward to some help.

You lost me on this one.  In both cases, rdp references a per-CPU
variable that is implicitly initialized to all zeroes, due to being
(sort of) a C-language global.

If a callback is queued early, then the following lines in __call_rcu()
will make an honest list of that field because of the :

		if (rcu_segcblist_empty(&rdp->cblist))
			rcu_segcblist_init(&rdp->cblist);

Otherwise, when rcu_init() is invoked during early boot, we have this
in rcu_init_percpu_data(), which is called from rcutree_prepare_cpu()
which is called from rcu_init(), which is called from start_kernel():

	if (rcu_segcblist_empty(&rdp->cblist) && /* No early-boot CBs? */
	    !init_nocb_callback_list(rdp))
		rcu_segcblist_init(&rdp->cblist);  /* Re-enable callbacks. */

So either init_nocb_callback_list() initializes the alternative callback
lists for a no-CBs CPU or rcu_segcblist_init() again makes an honest
list of that field.

My guess is that your tool is missing the

	rdp = this_cpu_ptr(rsp->rda);

in the __call_rcu() case, and also missing the

	struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);

Note that the ->rda field is explicitly compile-time initialized to
the base address of the per-CPU variable, which is rcu_preempt_data,
rcu_bh_data, or rcu_sched_data, depending on which RCU flavor is at hand.
(In v4.20-rc1, these are all merged into a single flavor to rule them all.)

Alternatively, your tool might be missing the implicit initialization
of per-CPU variables.

Or maybe I am missing something.  If so, please let me know what it is.

							Thanx, Paul

> Crash log 1
> =========================================
> BUG: KMSAN: uninit-value in __rcu_process_callbacks
> kernel/rcu/tree.c:2838 [inline]
> BUG: KMSAN: uninit-value in rcu_process_callbacks+0x5ac/0x1cb0
> kernel/rcu/tree.c:2864
> CPU: 0 PID: 20 Comm: kauditd Not tainted 4.19.0-rc8+ #18
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x305/0x460 lib/dump_stack.c:113
>  kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:917
>  __msan_warning+0x7d/0xe0 mm/kmsan/kmsan_instr.c:500
>  __rcu_process_callbacks kernel/rcu/tree.c:2838 [inline]
>  rcu_process_callbacks+0x5ac/0x1cb0 kernel/rcu/tree.c:2864
>  __do_softirq+0x5ff/0xa55 kernel/softirq.c:292
>  invoke_softirq kernel/softirq.c:373 [inline]
>  irq_exit+0x22d/0x270 kernel/softirq.c:414
>  exiting_irq+0xe/0x10 arch/x86/include/asm/apic.h:536
>  smp_apic_timer_interrupt+0x64/0x90 arch/x86/kernel/apic/apic.c:1059
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:869
>  </IRQ>
> RIP: 0010:finish_lock_switch+0x2b/0x40 kernel/sched/core.c:2578
> Code: 48 89 e5 53 48 89 fb e8 e3 43 9a 00 8b b8 88 0c 00 00 48 8b 00
> 48 85 c0 75 12 48 89 df e8 7d 38 9a 00 c6 00 00 c6 03 00 fb 5b <5d> c3
> e8 de 42 9a 00 eb e7 66 66 66 2e 0f 1f 84 00 00 00 00 00 55
> RSP: 0018:ffff88010622fca0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
> RAX: ffff8801105bcc40 RBX: ffff8801061554c0 RCX: ffff8801105bdc40
> RDX: ffff8801105bdc40 RSI: aaaaaaaaaaaab000 RDI: ffffea00077ec560
> RBP: ffff88010622fca0 R08: ffffffff7fffffff R09: 0000000000000002
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8800751cb880
> R13: 0000000000000000 R14: ffff880106155db8 R15: ffff88013fcb9c40
>  finish_task_switch+0xe3/0x270 kernel/sched/core.c:2679
>  context_switch kernel/sched/core.c:2832 [inline]
>  __schedule+0x78f/0x8f0 kernel/sched/core.c:3479
>  schedule+0x1cc/0x300 kernel/sched/core.c:3523
>  kauditd_thread+0xc64/0xee0 kernel/audit.c:889
>  kthread+0x5b1/0x5f0 kernel/kthread.c:247
>  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:416
> 
> Uninit was created at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:255 [inline]
>  kmsan_internal_alloc_meta_for_pages+0x157/0x730 mm/kmsan/kmsan.c:693
>  kmsan_alloc_page+0x80/0xe0 mm/kmsan/kmsan_hooks.c:320
>  __alloc_pages_nodemask+0x128c/0x69b0 mm/page_alloc.c:4416
>  alloc_pages_current+0x51f/0x760 mm/mempolicy.c:2093
>  alloc_pages include/linux/gfp.h:511 [inline]
>  alloc_slab_page mm/slub.c:1459 [inline]
>  allocate_slab mm/slub.c:1604 [inline]
>  new_slab+0x552/0x1f30 mm/slub.c:1675
>  new_slab_objects mm/slub.c:2438 [inline]
>  ___slab_alloc+0x1414/0x1dd0 mm/slub.c:2590
>  __slab_alloc mm/slub.c:2630 [inline]
>  slab_alloc_node mm/slub.c:2693 [inline]
>  slab_alloc mm/slub.c:2735 [inline]
>  kmem_cache_alloc+0xc9b/0xda0 mm/slub.c:2740
>  kmem_cache_zalloc include/linux/slab.h:697 [inline]
>  avc_alloc_node+0x109/0xb90 security/selinux/avc.c:572
>  avc_update_node+0x172/0x1ee0 security/selinux/avc.c:859
>  avc_denied+0x312/0x360 security/selinux/avc.c:1024
>  avc_has_perm_noaudit+0x733/0x770 security/selinux/avc.c:1155
>  avc_has_perm+0x172/0x480 security/selinux/avc.c:1184
>  sock_has_perm security/selinux/hooks.c:4539 [inline]
>  selinux_socket_sendmsg+0x297/0x360 security/selinux/hooks.c:4875
>  security_socket_sendmsg+0x127/0x200 security/security.c:1410
>  sock_sendmsg net/socket.c:628 [inline]
>  ___sys_sendmsg+0xd5f/0x1290 net/socket.c:2116
>  __sys_sendmsg net/socket.c:2154 [inline]
>  __do_sys_sendmsg net/socket.c:2163 [inline]
>  __se_sys_sendmsg+0x307/0x460 net/socket.c:2161
>  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
>  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> =========================================================
> 
> Crash log 2
> =========================================================
> BUG: KMSAN: uninit-value in rcu_accelerate_cbs+0x821/0x990
> kernel/rcu/tree.c:1728
> CPU: 0 PID: 10 Comm: rcu_sched Not tainted 4.19.0-rc8+ #18
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x305/0x460 lib/dump_stack.c:113
>  kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:917
>  __msan_warning+0x7d/0xe0 mm/kmsan/kmsan_instr.c:500
>  rcu_accelerate_cbs+0x821/0x990 kernel/rcu/tree.c:1728
>  __note_gp_changes+0x2ac/0x9e0 kernel/rcu/tree.c:1807
>  rcu_gp_cleanup kernel/rcu/tree.c:2109 [inline]
>  rcu_gp_kthread+0x3019/0x3990 kernel/rcu/tree.c:2236
>  kthread+0x5b1/0x5f0 kernel/kthread.c:247
>  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:416
> 
> Uninit was created at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:255 [inline]
>  kmsan_internal_alloc_meta_for_pages+0x157/0x730 mm/kmsan/kmsan.c:693
>  kmsan_alloc_page+0x80/0xe0 mm/kmsan/kmsan_hooks.c:320
>  __alloc_pages_nodemask+0x128c/0x69b0 mm/page_alloc.c:4416
>  alloc_pages_current+0x51f/0x760 mm/mempolicy.c:2093
>  alloc_pages include/linux/gfp.h:511 [inline]
>  alloc_slab_page mm/slub.c:1459 [inline]
>  allocate_slab mm/slub.c:1604 [inline]
>  new_slab+0x552/0x1f30 mm/slub.c:1675
>  new_slab_objects mm/slub.c:2438 [inline]
>  ___slab_alloc+0x1414/0x1dd0 mm/slub.c:2590
>  __slab_alloc mm/slub.c:2630 [inline]
>  slab_alloc_node mm/slub.c:2693 [inline]
>  slab_alloc mm/slub.c:2735 [inline]
>  kmem_cache_alloc+0xc9b/0xda0 mm/slub.c:2740
>  kmem_cache_zalloc include/linux/slab.h:697 [inline]
>  avc_alloc_node+0x109/0xb90 security/selinux/avc.c:572
>  avc_insert security/selinux/avc.c:696 [inline]
>  avc_compute_av+0x31e/0x1050 security/selinux/avc.c:1008
>  avc_has_perm_noaudit+0x516/0x770 security/selinux/avc.c:1149
>  avc_has_perm+0x172/0x480 security/selinux/avc.c:1184
>  selinux_socket_create+0x248/0x3c0 security/selinux/hooks.c:4560
>  security_socket_create+0x146/0x210 security/security.c:1372
>  __sock_create+0x26b/0xf30 net/socket.c:1232
>  sock_create net/socket.c:1317 [inline]
>  __sys_socket+0x180/0x670 net/socket.c:1347
>  __do_sys_socket net/socket.c:1356 [inline]
>  __se_sys_socket+0x8d/0xb0 net/socket.c:1354
>  __x64_sys_socket+0x4a/0x70 net/socket.c:1354
>  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> =========================================================
> 
> Thanks,
> Kyungtae Kim
> 

