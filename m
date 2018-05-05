Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeEEHqN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 03:46:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750764AbeEEHqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 03:46:12 -0400
Date: Sat, 05 May 2018 13:16:04 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 00/16] tracing: probeevent: Improve fetcharg features
To: Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, shuah@kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
        <20180503181137.6d82d897@gandalf.local.home>
        <20180505004828.9b75b6802472f09b0d2de5b8@kernel.org>
        <20180504120642.354cdd1f@gandalf.local.home>
        <20180505113803.45700179a93091b114ec6984@kernel.org>
In-Reply-To: <20180505113803.45700179a93091b114ec6984@kernel.org>
User-Agent: astroid/0.11.1 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18050507-0040-0000-0000-000004553ED6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050507-0041-0000-0000-000020F96F1C
Message-Id: <1525506231.y43xvmd3yw.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805050070
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> On Fri, 4 May 2018 12:06:42 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Sat, 5 May 2018 00:48:28 +0900
>> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>> 
>> > > Also, when looking at the kprobe code, I was looking at this 
>> > > function:
>> > >   
>> > > > /* Ftrace callback handler for kprobes -- called under preepmt disabed */
>> > > > void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>> > > > 			   struct ftrace_ops *ops, struct pt_regs *regs)
>> > > > {
>> > > > 	struct kprobe *p;
>> > > > 	struct kprobe_ctlblk *kcb;
>> > > > 
>> > > > 	/* Preempt is disabled by ftrace */
>> > > > 	p = get_kprobe((kprobe_opcode_t *)ip);
>> > > > 	if (unlikely(!p) || kprobe_disabled(p))
>> > > > 		return;
>> > > > 
>> > > > 	kcb = get_kprobe_ctlblk();
>> > > > 	if (kprobe_running()) {
>> > > > 		kprobes_inc_nmissed_count(p);
>> > > > 	} else {
>> > > > 		unsigned long orig_ip = regs->ip;
>> > > > 		/* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
>> > > > 		regs->ip = ip + sizeof(kprobe_opcode_t);
>> > > > 
>> > > > 		/* To emulate trap based kprobes, preempt_disable here */
>> > > > 		preempt_disable();
>> > > > 		__this_cpu_write(current_kprobe, p);
>> > > > 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>> > > > 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
>> > > > 			__skip_singlestep(p, regs, kcb, orig_ip);
>> > > > 			preempt_enable_no_resched();  
>> > > 
>> > > This preemption disabling and enabling looks rather strange. Looking at
>> > > git blame, it appears this was added for jprobes. Can we remove it now
>> > > that jprobes is going away?  
>> > 
>> > No, that is not for jprobes but for compatibility with kprobe's user
>> > handler. Since this transformation is done silently, user can not
>> > change their handler for ftrace case. So we need to keep this condition
>> > same as original kprobes.
>> > 
>> > And anyway, for using smp_processor_id() for accessing per-cpu,
>> > we should disable preemption, correct?
>> 
>> But as stated at the start of the function:
>> 
>>  /* Preempt is disabled by ftrace */
> 
> Ah, yes. So this is only for the jprobes.
> 
>> 
>> 
>> The reason I ask, is that we have for this function:
>> 
>> 		/* To emulate trap based kprobes, preempt_disable here */
>> 		preempt_disable();
>> 		__this_cpu_write(current_kprobe, p);
>> 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>> 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
>> 			__skip_singlestep(p, regs, kcb, orig_ip);
>> 			preempt_enable_no_resched();
>> 		}
>> 
>> And in arch/x86/kernel/kprobes/core.c we have:
>> 
>> 	preempt_disable();
>> 
>> 	kcb = get_kprobe_ctlblk();
>> 	p = get_kprobe(addr);
>> 
>> 	if (p) {
>> 		if (kprobe_running()) {
>> 			if (reenter_kprobe(p, regs, kcb))
>> 				return 1;
>> 		} else {
>> 			set_current_kprobe(p, regs, kcb);
>> 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>> 
>> 			/*
>> 			 * If we have no pre-handler or it returned 0, we
>> 			 * continue with normal processing.  If we have a
>> 			 * pre-handler and it returned non-zero, it prepped
>> 			 * for calling the break_handler below on re-entry
>> 			 * for jprobe processing, so get out doing nothing
>> 			 * more here.
>> 			 */
>> 			if (!p->pre_handler || !p->pre_handler(p, regs))
>> 				setup_singlestep(p, regs, kcb, 0);
>> 			return 1;
>> 
>> 
>> Which is why I thought it was for jprobes. I'm a bit confused about
>> where preemption is enabled again.
> 
> You're right. So I would like to remove it with x86 jprobe support
> code to avoid inconsistency.

I didn't understand that. Which code are you planning to remove? Can you 
please elaborate? I thought we still need to disable preemption in the 
ftrace handler.

Thanks,
Naveen
