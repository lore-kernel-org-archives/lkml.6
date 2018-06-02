Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeFBL6T convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 07:58:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750740AbeFBL6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 07:58:17 -0400
Date: Sat, 02 Jun 2018 17:28:05 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH -tip v4 24/27] bpf: error-inject: kprobes: Clear
 current_kprobe and enable preempt in kprobe
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Josef Bacik <jbacik@fb.com>, James Hogan <jhogan@kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>, Will Deacon <will.deacon@arm.com>,
        x86@kernel.org
References: <152749074878.15132.16693721906742461289.stgit@devbox>
        <152749149794.15132.15817377604536829521.stgit@devbox>
        <1527763450.f65xiu4yuz.naveen@linux.ibm.com>
        <20180602083648.fc40ce260c2cafb9a0d31aaa@kernel.org>
In-Reply-To: <20180602083648.fc40ce260c2cafb9a0d31aaa@kernel.org>
User-Agent: astroid/0.11.1 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18060211-0020-0000-0000-000002960319
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060211-0021-0000-0000-000020E18D90
Message-Id: <1527937081.8b4s5988lk.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=737 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806020140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> On Thu, 31 May 2018 16:25:38 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
>> Masami Hiramatsu wrote:
>> > Clear current_kprobe and enable preemption in kprobe
>> > even if pre_handler returns !0.
>> > 
>> > This simplifies function override using kprobes.
>> > 
>> > Jprobe used to require to keep the preemption disabled and
>> > keep current_kprobe until it returned to original function
>> > entry. For this reason kprobe_int3_handler() and similar
>> > arch dependent kprobe handers checks pre_handler result
>> > and exit without enabling preemption if the result is !0.
>> > 
>> > After removing the jprobe, Kprobes does not need to
>> > keep preempt disabled even if user handler returns !0
>> > anymore.
>> 
>> I think the reason jprobes did it that way is to address architecture 
>> specific requirements when changing a function. So, without that 
>> infrastructure, I am not sure if we will be able to claim support for 
>> over-riding functions with kprobes. I am not sure if we want to claim 
>> that, but this is something we need to be clear on.
> 
> Really? as far as I can see, there seems no such architecture.
> The keeping preempt disabled is corresponding to keeping current_kprobe
> since the current_kprobe is per-cpu.

Right, and the reason for not resetting current_kprobe after kprobe 
handling is done is primarily for jprobes. 

> This means if it is preempted
> before hitting break_handler and changed cpu core, we missed to
> handle current_kprobe and goes to panic. But if we don't need
> such "break back" (removing break_handler), we don't need to
> keep current_kprobe (because it is not handled afterwards).

Agreed.

> 
> Anyway, changing function execution path is a "one-way" change.

This is the problem. With jprobes, over-riding a function was not a 
"one-way" change because it involves more than just changing the [n]ip.  
That is the reason we had setjmp/longjmp (aka break_handler).

> We don't have a chance to fixup that disabled preemption and current_kprobe
> after returning to the new function. So current error-inject clears
> current_kprobe and enable preemption before returning !0 from its
> kprobe pre_handler.
> 
> This is just moving such needless operation from user-pre_handler to
> kprobes itself. 
> 
>> For powerpc, the current function override in error-inject works fine 
>> since the new function does nothing. But, if anyone wants to do more 
>> work in the replacement function, it won't work with the current 
>> approach.
> 
> If you are considering about TOC change etc. yes, it depends on
> the archtecture. As far as I know IA64 and powerpc will not allow
> to support changing execution path without special care.
> Other "flat and simple" function call architectures like x86, arm
> can change execution path without special care. 

Yes, that's the concern. As I stated earlier, the only user seems to be 
error-injection where this is not a concern. I wanted this to be made 
clear.

I've since noticed that you are updating Documentation/kprobes.txt to 
make this clear in patch 24/27 in this series. So, I'm ok with the 
changes in this series.


Thanks,
Naveen
