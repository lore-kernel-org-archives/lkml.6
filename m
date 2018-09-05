Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EC0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1802C20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1802C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeIETg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:36:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbeIETg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:36:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85EwsUn116056
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 11:05:53 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2maggdkpp7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 11:05:52 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 11:05:51 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 11:05:48 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85F5l1835586152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 15:05:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BB71B207B;
        Wed,  5 Sep 2018 11:04:34 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A24CB2072;
        Wed,  5 Sep 2018 11:04:34 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  5 Sep 2018 11:04:34 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A4F2816C1B2F; Wed,  5 Sep 2018 08:05:46 -0700 (PDT)
Date:   Wed, 5 Sep 2018 08:05:46 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, joel@joelfernandes.org
Subject: Re: [PATCH] tracing: Add back in rcu_irq_enter/exit_irqson() for
 rcuidle tracepoints
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180901173559.GC26871@zn.tnic>
 <20180901175442.GO4225@linux.vnet.ibm.com>
 <20180901184531.72ffb792@vmware.local.home>
 <20180902041639.GQ4225@linux.vnet.ibm.com>
 <20180904162611.6a120068@gandalf.local.home>
 <20180904205321.GQ4225@linux.vnet.ibm.com>
 <20180905082254.GA2237@zn.tnic>
 <20180905125941.GE4225@linux.vnet.ibm.com>
 <20180905092629.6ecb003b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905092629.6ecb003b@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18090515-0040-0000-0000-0000046AA907
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009676; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01083935; UDB=6.00559420; IPR=6.00863935;
 MB=3.00023126; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-05 15:05:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090515-0041-0000-0000-00000871CA95
Message-Id: <20180905150546.GK4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 09:26:29AM -0400, Steven Rostedt wrote:
> On Wed, 5 Sep 2018 05:59:41 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Wed, Sep 05, 2018 at 10:22:54AM +0200, Borislav Petkov wrote:
> > > On Tue, Sep 04, 2018 at 01:53:21PM -0700, Paul E. McKenney wrote:  
> > > > I must defer to Borislav on this one.  Assuming it has the desired
> > > > effect, I am good with it.  
> > > 
> > > It did survive a bunch of reboots (the WARN would fire after boot
> > > finishes, normally) so I guess we can run with it and see how it works
> > > out in the next couple of weeks.
> > > 
> > > Thanks guys!  
> > 
> > Woo-hoo!!!  Thank you for testing this!
> > 
> 
> Here's the official patch if you want to add an Ack/review/tested-by:
> 
> -- Steve
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Borislav reported the following splat:
> 
>  =============================
>  WARNING: suspicious RCU usage
>  4.19.0-rc1+ #1 Not tainted
>  -----------------------------
>  ./include/linux/rcupdate.h:631 rcu_read_lock() used illegally while idle!
>  other info that might help us debug this:
> 
>  RCU used illegally from idle CPU!
>  rcu_scheduler_active = 2, debug_locks = 1
>  RCU used illegally from extended quiescent state!
>  1 lock held by swapper/0/0:
>   #0: 000000004557ee0e (rcu_read_lock){....}, at: perf_event_output_forward+0x0/0x130
> 
>  stack backtrace:
>  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0-rc1+ #1
>  Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
>  Call Trace:
>   dump_stack+0x85/0xcb
>   perf_event_output_forward+0xf6/0x130
>   __perf_event_overflow+0x52/0xe0
>   perf_swevent_overflow+0x91/0xb0
>   perf_tp_event+0x11a/0x350
>   ? find_held_lock+0x2d/0x90
>   ? __lock_acquire+0x2ce/0x1350
>   ? __lock_acquire+0x2ce/0x1350
>   ? retint_kernel+0x2d/0x2d
>   ? find_held_lock+0x2d/0x90
>   ? tick_nohz_get_sleep_length+0x83/0xb0
>   ? perf_trace_cpu+0xbb/0xd0
>   ? perf_trace_buf_alloc+0x5a/0xa0
>   perf_trace_cpu+0xbb/0xd0
>   cpuidle_enter_state+0x185/0x340
>   do_idle+0x1eb/0x260
>   cpu_startup_entry+0x5f/0x70
>   start_kernel+0x49b/0x4a6
>   secondary_startup_64+0xa4/0xb0
> 
> This is due to the tracepoints moving to SRCU usage which does not require
> RCU to be "watching". But perf uses these tracepoints with RCU and expects
> it to be. Hence, we still need to add in the rcu_irq_enter/exit_irqson()
> calls for "rcuidle" tracepoints. This is a temporary fix until we have SRCU
> working in NMI context, and then perf can be converted to use that instead
> of normal RCU.
> 
> Link: http://lkml.kernel.org/r/20180904162611.6a120068@gandalf.local.home
> 
> Cc: x86-ml <x86@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Reported-by: Borislav Petkov <bp@alien8.de>
> Fixes: e6753f23d961d ("tracepoint: Make rcuidle tracepoint callers use SRCU")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

> ---
>  include/linux/tracepoint.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 7f2e16e76ac4..041f7e56a289 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -158,8 +158,10 @@ extern void syscall_unregfunc(void);
>  		 * For rcuidle callers, use srcu since sched-rcu	\
>  		 * doesn't work from the idle path.			\
>  		 */							\
> -		if (rcuidle)						\
> +		if (rcuidle) {						\
>  			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> +			rcu_irq_enter_irqson();				\
> +		}							\
>  									\
>  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
>  									\
> @@ -171,8 +173,10 @@ extern void syscall_unregfunc(void);
>  			} while ((++it_func_ptr)->func);		\
>  		}							\
>  									\
> -		if (rcuidle)						\
> +		if (rcuidle) {						\
> +			rcu_irq_exit_irqson();				\
>  			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
> +		}							\
>  									\
>  		preempt_enable_notrace();				\
>  	} while (0)
> -- 
> 2.13.6
> 

