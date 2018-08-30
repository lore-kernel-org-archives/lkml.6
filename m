Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449DFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC92205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC92205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeH3Vi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:38:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726732AbeH3Vi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:38:29 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7UHYpWU120888
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 13:35:15 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m6kj0m43w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 13:35:15 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 Aug 2018 13:35:14 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Aug 2018 13:35:09 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7UHZ8K024969440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Aug 2018 17:35:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29ACCB2065;
        Thu, 30 Aug 2018 13:34:03 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB80EB2066;
        Thu, 30 Aug 2018 13:34:02 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 Aug 2018 13:34:02 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E253116C0F41; Thu, 30 Aug 2018 10:35:09 -0700 (PDT)
Date:   Thu, 30 Aug 2018 10:35:09 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH tip/core/rcu 3/3] srcu: Make early-boot call_srcu() reuse
 workqueue lists
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180829212036.GA22033@linux.vnet.ibm.com>
 <20180829212313.22903-3-paulmck@linux.vnet.ibm.com>
 <20180829215616.1c10e476@vmware.local.home>
 <20180830020701.GE4225@linux.vnet.ibm.com>
 <20180829224609.5ffdc9ec@vmware.local.home>
 <20180830032315.GG4225@linux.vnet.ibm.com>
 <20180830124444.6bb9faac@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830124444.6bb9faac@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18083017-0072-0000-0000-0000039A00F2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009640; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01081122; UDB=6.00557725; IPR=6.00861106;
 MB=3.00023020; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-30 17:35:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083017-0073-0000-0000-000049411888
Message-Id: <20180830173509.GL4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808300177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 12:44:44PM -0400, Steven Rostedt wrote:
> On Wed, 29 Aug 2018 20:23:15 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > > > Glad you like it!  Does it actually work for you?  ;-)  
> > > 
> > > Oh, you want me to actually test it too? ;-)  
> > 
> > ;-) ;-) ;-)
> > 
> > > I'll try to add that in my todo list tomorrow.  
> > 
> > Much appreciated!
> 
> I reverted the change that prevents calling call_srcu() early:
> 
> I checked out v4.19-rc1 and applied these three patches, then did:
> 
> git show f8a79d5c7ef47c62d97a30e16064caf2ef91f648 | patch -p1 -R
> 
> But still triggered the following:
> 
>  WARNING: CPU: 0 PID: 0 at /work/git/linux-trace.git/kernel/rcu/srcutree.c:242 check_init_srcu_struct+0x85/0x90

Gah!!!  I needed to have removed that WARN_ON_ONCE(), didn't I?
In fact, I should have removed that once I started using workqueues,
quite some time back.

Thank you even more for testing this!!!  Glad I asked.  ;-)

Now to figure out why my testing didn't hit this...  I do invoke
call_srcu() at rcu_init() time and verify that the callback is
eventually invoked.  A printk() placed there really does print...

							Thanx, Paul

>  Modules linked in:
>  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0-rc1-test+ #1194
>  Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
>  RIP: 0010:check_init_srcu_struct+0x85/0x90
>  Code: 16 25 00 f6 83 70 06 00 00 03 74 0d be 01 00 00 00 48 89 df e8 6c f6 ff ff 5b 4c 89 ee 4c 89 e7 5d 41 5c 41 5d e9 db 4a d7 00 <0f> 0b eb 9a 0f 1f 80 00 00 00 00 0f 1f 44 00 00 41 57 48 8d 87 90
>  RSP: 0000:ffff8800d3c07d90 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: ffffffffb9d4d960 RCX: ffffffffb81dab0a
>  RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffffffffba1cd854
>  RBP: ffffffffb827de70 R08: fffffbfff76a9525 R09: fffffbfff76a9524
>  R10: ffff8800d3c07db0 R11: fffffbfff76a9525 R12: ffff8800cfacba88
>  R13: ffffffffb9d4d960 R14: 000000000000000a R15: ffff8800d3c07eb0
>  FS:  0000000000000000(0000) GS:ffff8800d3c00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: ffff88011e7ff000 CR3: 00000000a2c14001 CR4: 00000000001606f0
>  Call Trace:
>   <IRQ>
>   ? rcu_free_old_probes+0x20/0x20
>   ? for_each_kernel_tracepoint+0x50/0x50
>   __call_srcu+0x29/0x570
>   ? rcu_process_callbacks+0x403/0xcd0
>   ? for_each_kernel_tracepoint+0x50/0x50
>   rcu_process_callbacks+0x44f/0xcd0
>   ? __bpf_trace_timer_class+0x10/0x10
>   ? sched_clock+0x5/0x10
>   ? note_gp_changes+0xf0/0xf0
>   ? __lock_is_held+0x26/0xf0
>   __do_softirq+0x13b/0x561
>   irq_exit+0x12c/0x140
>   smp_apic_timer_interrupt+0xd4/0x2f0
>   apic_timer_interrupt+0xf/0x20
>   </IRQ>
>  RIP: 0010:mwait_idle+0x83/0x260
>  Code: 48 89 d1 48 89 d8 0f 01 c8 48 89 df e8 f6 d5 4d ff 48 8b 03 a8 08 0f 85 c0 01 00 00 e8 f6 dc 35 ff 31 c0 48 89 c1 fb 0f 01 c9 <e8> 68 ee 85 ff 41 89 c4 0f 1f 44 00 00 65 48 8b 04 25 c0 ed 01 00
>  RSP: 0000:ffffffffb9c07d28 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
>  RAX: 0000000000000000 RBX: ffffffffb9c1f9c0 RCX: 0000000000000000
>  RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffffffffb9c2028c
>  RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>  R13: ffffffffba1cd740 R14: 0000000000000000 R15: 0000000000000000
>   ? mwait_idle+0x7a/0x260
>   default_idle_call+0x2d/0x50
>   do_idle+0x251/0x310
>   ? arch_cpu_idle_exit+0x40/0x40
>   cpu_startup_entry+0xc2/0xd0
>   ? cpu_in_idle+0x20/0x20
>   ? preempt_count_sub+0xaa/0x100
>   start_kernel+0x640/0x67d
>   ? thread_stack_cache_init+0x6/0x6
>   ? load_ucode_intel_bsp+0x5f/0xa5
>   ? load_ucode_intel_bsp+0x5f/0xa5
>   ? init_intel_microcode+0xb0/0xb0
>   ? load_ucode_bsp+0xbb/0x156
>   secondary_startup_64+0xa4/0xb0
>  irq event stamp: 21271
>  hardirqs last  enabled at (21270): [<ffffffffb81e1e52>] rcu_process_callbacks+0x982/0xcd0
>  hardirqs last disabled at (21271): [<ffffffffb800447f>] trace_hardirqs_off_thunk+0x1a/0x1c
>  softirqs last  enabled at (21252): [<ffffffffb811529c>] irq_enter+0x7c/0x80
>  softirqs last disabled at (21253): [<ffffffffb81153cc>] irq_exit+0x12c/0x140
>  ---[ end trace 64bab84b86e8ec96 ]---
> 
> Attached is my config, and my kernel command line has:
> 
>  trace_event=sched_switch
> 
> -- Steve


