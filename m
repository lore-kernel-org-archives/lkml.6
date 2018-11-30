Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CDFC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A8C204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A8C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeLABw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:52:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726398AbeLABw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:52:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAUEdUYY008598
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 09:43:24 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p35tqve5w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 09:43:23 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 30 Nov 2018 14:43:23 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Nov 2018 14:43:19 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAUEhIZO17563650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Nov 2018 14:43:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E7A0B2066;
        Fri, 30 Nov 2018 14:43:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBEB2B2065;
        Fri, 30 Nov 2018 14:43:17 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.156.56])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 30 Nov 2018 14:43:17 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D6F3616C3243; Fri, 30 Nov 2018 06:43:17 -0800 (PST)
Date:   Fri, 30 Nov 2018 06:43:17 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "He, Bo" <bo.he@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "Zhang, Jun" <jun.zhang@intel.com>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: Re: rcu_preempt caused oom
Reply-To: paulmck@linux.ibm.com
References: <CD6925E8781EFD4D8E11882D20FC406D52A11F61@SHSMSX104.ccr.corp.intel.com>
 <20181129130647.GG4170@linux.ibm.com>
 <20181129142712.GA16607@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A1243D@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52A1243D@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18113014-0072-0000-0000-000003D1F6AE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010148; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01124971; UDB=6.00582089; IPR=6.00905098;
 MB=3.00024399; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-30 14:43:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18113014-0073-0000-0000-00004A48B183
Message-Id: <20181130144317.GQ4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-30_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811300125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 08:03:38AM +0000, He, Bo wrote:
> Thanks for your great suggestions.
> After enable the CONFIG_RCU_BOOST=y, we don't reproduce the issue until now, we will keep it running and update you with the test results.
> 
> The enclosed is the kernel config, here is the config I grep with the RCU, we don't enable the CONFIG_RCU_BOOST in our build.
> # RCU Subsystem
> CONFIG_PREEMPT_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> # RCU Debugging
> CONFIG_RCU_PERF_TEST=m
> CONFIG_RCU_TORTURE_TEST=m
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> CONFIG_RCU_TRACE=y
> CONFIG_RCU_EQS_DEBUG=y

Thank you!

What likely happened is that a low-priority RCU reader was preempted
indefinitely.  Though I would have expected an RCU CPU stall warning
in that case, so it might well be that something else is going on.
Could you please send me your list of kernel boot parameters?  They
usually appear near the start of your console output.

							Thanx, Paul

> -----Original Message-----
> From: Paul E. McKenney <paulmck@linux.ibm.com> 
> Sent: Thursday, November 29, 2018 10:27 PM
> To: He, Bo <bo.he@intel.com>
> Cc: linux-kernel@vger.kernel.org; josh@joshtriplett.org; rostedt@goodmis.org; mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; Zhang, Jun <jun.zhang@intel.com>; Xiao, Jin <jin.xiao@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>
> Subject: Re: rcu_preempt caused oom
> 
> On Thu, Nov 29, 2018 at 05:06:47AM -0800, Paul E. McKenney wrote:
> > On Thu, Nov 29, 2018 at 08:49:35AM +0000, He, Bo wrote:
> > > Hi, 
> > >       we test on kernel 4.19.0 on android, after run more than 24 Hours monkey stress test, we see OOM on 1/10 2G memory board, the issue is not seen on the 4.14 kernel.
> > > we have done some debugs:
> > > 1. OOM is due to the filp consume too many memory: 300M vs 2G board.
> > > 2. with the 120s hung task detect, most of the tasks will block at 
> > > __wait_rcu_gp: wait_for_completion(&rs_array[i].completion);
> 
> Did you did see any RCU CPU stall warnings?  Or have those been disabled?
> If they have been disabled, could you please rerun with them enabled?
> 
> > > [47571.863839] Kernel panic - not syncing: hung_task: blocked tasks
> > > [47571.875446] CPU: 1 PID: 13626 Comm: FinalizerDaemon Tainted: G     U     O      4.19.0-quilt-2e5dc0ac-gf3f313245eb6 #1
> > > [47571.887603] Call Trace:
> > > [47571.890547]  dump_stack+0x70/0xa5 [47571.894456]  
> > > panic+0xe3/0x241 [47571.897977]  ? 
> > > wait_for_completion_timeout+0x72/0x1b0
> > > [47571.903830]  __wait_rcu_gp+0x17b/0x180 [47571.908226]  
> > > synchronize_rcu.part.76+0x38/0x50 [47571.913393]  ? 
> > > __call_rcu.constprop.79+0x3a0/0x3a0
> > > [47571.918948]  ? __bpf_trace_rcu_invoke_callback+0x10/0x10
> > > [47571.925094]  synchronize_rcu+0x43/0x50 [47571.929487]  
> > > evdev_detach_client+0x59/0x60 [47571.934264]  
> > > evdev_release+0x4e/0xd0 [47571.938464]  __fput+0xfa/0x1f0 
> > > [47571.942072]  ____fput+0xe/0x10 [47571.945683]  
> > > task_work_run+0x90/0xc0 [47571.949884]  
> > > exit_to_usermode_loop+0x9f/0xb0 [47571.954855]  
> > > do_syscall_64+0xfa/0x110 [47571.959151]  
> > > entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> This is indeed a task waiting on synchronize_rcu().
> 
> > > 3. after enable the rcu trace, we don't see rcu_quiescent_state_report trace in a long time, we see rcu_callback: rcu_preempt will never response with the rcu_invoke_callback.
> > > [47572.040668]      ps-12388   1d..1 47566097572us : rcu_grace_period: rcu_preempt 23716088 AccWaitCB
> > > [47572.040707]      ps-12388   1d... 47566097621us : rcu_callback: rcu_preempt rhp=00000000783a728b func=file_free_rcu 4354/82824
> > > [47572.040734]      ps-12388   1d..1 47566097622us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Startleaf
> > > [47572.040756]      ps-12388   1d..1 47566097623us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Prestarted
> > > [47572.040778]      ps-12388   1d..1 47566097623us : rcu_grace_period: rcu_preempt 23716088 AccWaitCB
> > > [47572.040802]      ps-12388   1d... 47566097674us : rcu_callback: rcu_preempt rhp=0000000042c76521 func=file_free_rcu 4354/82825
> > > [47572.040824]      ps-12388   1d..1 47566097676us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Startleaf
> > > [47572.040847]      ps-12388   1d..1 47566097676us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Prestarted
> > > [47572.040868]      ps-12388   1d..1 47566097676us : rcu_grace_period: rcu_preempt 23716088 AccWaitCB
> > > [47572.040895]      ps-12388   1d..1 47566097716us : rcu_callback: rcu_preempt rhp=000000005e40fde2 func=avc_node_free 4354/82826
> > > [47572.040919]      ps-12388   1d..1 47566097735us : rcu_callback: rcu_preempt rhp=00000000f80fe353 func=avc_node_free 4354/82827
> > > [47572.040943]      ps-12388   1d..1 47566097758us : rcu_callback: rcu_preempt rhp=000000007486f400 func=avc_node_free 4354/82828
> > > [47572.040967]      ps-12388   1d..1 47566097760us : rcu_callback: rcu_preempt rhp=00000000b87872a8 func=avc_node_free 4354/82829
> > > [47572.040990]      ps-12388   1d... 47566097789us : rcu_callback: rcu_preempt rhp=000000008c656343 func=file_free_rcu 4354/82830
> > > [47572.041013]      ps-12388   1d..1 47566097790us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Startleaf
> > > [47572.041036]      ps-12388   1d..1 47566097790us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Prestarted
> > > [47572.041057]      ps-12388   1d..1 47566097791us : rcu_grace_period: rcu_preempt 23716088 AccWaitCB
> > > [47572.041081]      ps-12388   1d... 47566097871us : rcu_callback: rcu_preempt rhp=000000007e6c898c func=file_free_rcu 4354/82831
> > > [47572.041103]      ps-12388   1d..1 47566097872us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Startleaf
> > > [47572.041126]      ps-12388   1d..1 47566097872us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Prestarted
> > > [47572.041147]      ps-12388   1d..1 47566097873us : rcu_grace_period: rcu_preempt 23716088 AccWaitCB
> > > [47572.041170]      ps-12388   1d... 47566097945us : rcu_callback: rcu_preempt rhp=0000000032f4f174 func=file_free_rcu 4354/82832
> > > [47572.041193]      ps-12388   1d..1 47566097946us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Startleaf
> 
> Callbacks are being queued and future grace periods to handle them are being requested, but as you say, no progress on the current grace period.
> 
> Is it possible to start the trace earlier?
> 
> > > Do you have any suggestions to debug the issue?
> > 
> > If you do not already have CONFIG_RCU_BOOST=y set, could you please 
> > rebuild with that?
> > 
> > Could you also please send your .config file?
> 
> So, to summarize:
> 
> 1.	If you don't have RCU CPU stall warnings enabled,
> 	please enable them.  For example, please remove
> 	rcupdate.rcu_cpu_stall_suppress from the kernel boot
> 	parameters if it is there.
> 
> 	Getting an RCU CPU stall warning would be extremely
> 	helpful.  It contains many useful diagnostics.
> 
> 2.	If possible, please start the trace before the last
> 	grace period starts.
> 
> 3.	If CONFIG_RCU_BOOST=y is not set, please try setting it.
> 
> 4.	Please send me your .config file.
> 
> 						Thanx, Paul
> 


