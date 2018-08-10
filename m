Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DECC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A88D2244F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A88D2244F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeHJThX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:37:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727381AbeHJThX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:37:23 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7AH3vbS053722
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:06:40 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ksccr5wmk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:06:40 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 10 Aug 2018 13:06:39 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 10 Aug 2018 13:06:36 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7AH6ZQ413762956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Aug 2018 17:06:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3716B205F;
        Fri, 10 Aug 2018 13:05:56 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3AA3B2066;
        Fri, 10 Aug 2018 13:05:56 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 10 Aug 2018 13:05:56 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CDE2A16C3991; Fri, 10 Aug 2018 10:06:35 -0700 (PDT)
Date:   Fri, 10 Aug 2018 10:06:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] tracepoints: Free early tracepoints after RCU is
 initialized
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180810123042.51ceddb9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810123042.51ceddb9@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18081017-2213-0000-0000-000002D8CDB4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009519; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01071717; UDB=6.00551962; IPR=6.00851509;
 MB=3.00022638; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-10 17:06:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081017-2214-0000-0000-00005B278B95
Message-Id: <20180810170635.GV24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-10_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808100183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 12:30:42PM -0400, Steven Rostedt wrote:
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> When enabling trace events via the kernel command line, I hit this warning:
> 
> WARNING: CPU: 0 PID: 13 at kernel/rcu/srcutree.c:236 check_init_srcu_struct+0xe/0x61
> Modules linked in:
> CPU: 0 PID: 13 Comm: watchdog/0 Not tainted 4.18.0-rc6-test+ #6
> Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
> RIP: 0010:check_init_srcu_struct+0xe/0x61
> Code: 48 c7 c6 ec 8a 65 b4 e8 ff 79 fe ff 48 89 df 31 f6 e8 f2 fa ff ff 5a
> 5b 41 5c 5d c3 0f 1f 44 00 00 83 3d 68 94 b8 01 01 75 02 <0f> 0b 48 8b 87 f0
> 0a 00 00 a8 03 74 45 55 48 89 e5 41 55 41 54 4c
> RSP: 0000:ffff96eb9ea03e68 EFLAGS: 00010246
> RAX: ffff96eb962b5b01 RBX: ffffffffb4a87420 RCX: 0000000000000001
> RDX: ffffffffb3107969 RSI: ffff96eb962b5b40 RDI: ffffffffb4a87420
> RBP: ffff96eb9ea03eb0 R08: ffffabbd00cd7f48 R09: 0000000000000000
> R10: ffff96eb9ea03e68 R11: ffffffffb4a6eec0 R12: ffff96eb962b5b40
> R13: ffff96eb9ea03ef8 R14: ffffffffb3107969 R15: ffffffffb3107948
> FS:  0000000000000000(0000) GS:ffff96eb9ea00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff96eb13ab2000 CR3: 0000000192a1e001 CR4: 00000000001606f0
> Call Trace:
>  <IRQ>
>  ? __call_srcu+0x2d/0x290
>  ? rcu_process_callbacks+0x26e/0x448
>  ? allocate_probes+0x2b/0x2b
>  call_srcu+0x13/0x15
>  rcu_free_old_probes+0x1f/0x21
>  rcu_process_callbacks+0x2ed/0x448
>  __do_softirq+0x172/0x336
>  irq_exit+0x62/0xb2
>  smp_apic_timer_interrupt+0x161/0x19e
>  apic_timer_interrupt+0xf/0x20
>  </IRQ>
> 
> The problem is that the enabling of trace events before RCU is set up will
> cause SRCU to give this warning. To avoid this, add a list to store probes
> that need to be freed till after RCU is initialized, and then free them
> then.
> 
> Link: http://lkml.kernel.org/r/20180810113554.1df28050@gandalf.local.home
> 
> Fixes: e6753f23d961d ("tracepoint: Make rcuidle tracepoint callers use SRCU")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

SRCU is fully initialized by the end of the core_initcall(), so the
choice of postcore_initcall() is a good one.  It would be nice for
call_srcu() to work at early boot, just like call_rcu() currently does,
but that is not a change I will be pushing into the upcoming merge
window.  ;-)

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  kernel/tracepoint.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 955148d91b74..36635d1d8045 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -53,6 +53,9 @@ static LIST_HEAD(tracepoint_module_list);
>   */
>  static DEFINE_MUTEX(tracepoints_mutex);
> 
> +static struct rcu_head *early_probes;
> +static bool ok_to_free_tracepoints;
> +
>  /*
>   * Note about RCU :
>   * It is used to delay the free of multiple probes array until a quiescent
> @@ -80,11 +83,40 @@ static void rcu_free_old_probes(struct rcu_head *head)
>  	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
>  }
> 
> +static __init int release_early_probes(void)
> +{
> +	struct rcu_head *tmp;
> +
> +	ok_to_free_tracepoints = true;
> +
> +	while (early_probes) {
> +		tmp = early_probes;
> +		early_probes = tmp->next;
> +		call_rcu_sched(tmp, rcu_free_old_probes);
> +	}
> +
> +	return 0;
> +}
> +
> +/* RCU is initialized at core_initcall */
> +postcore_initcall(release_early_probes);
> +
>  static inline void release_probes(struct tracepoint_func *old)
>  {
>  	if (old) {
>  		struct tp_probes *tp_probes = container_of(old,
>  			struct tp_probes, probes[0]);
> +
> +		/*
> +		 * We can't free probes if RCU is not initialized yet.
> +		 * Postpone the freeing till after RCU is initialized.
> +		 */
> +		if (unlikely(!ok_to_free_tracepoints)) {
> +			tp_probes->rcu.next = early_probes;
> +			early_probes = &tp_probes->rcu;
> +			return;
> +		}
> +
>  		/*
>  		 * Tracepoint probes are protected by both sched RCU and SRCU,
>  		 * by calling the SRCU callback in the sched RCU callback we
> -- 
> 2.13.6
> 

