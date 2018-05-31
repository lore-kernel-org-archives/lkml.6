Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754645AbeEaKzv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:55:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754464AbeEaKzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:55:49 -0400
Date: Thu, 31 May 2018 16:25:38 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH -tip v4 24/27] bpf: error-inject: kprobes: Clear
 current_kprobe and enable preempt in kprobe
To: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Josef Bacik <jbacik@fb.com>, James Hogan <jhogan@kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>, Will Deacon <will.deacon@arm.com>,
        x86@kernel.org
References: <152749074878.15132.16693721906742461289.stgit@devbox>
        <152749149794.15132.15817377604536829521.stgit@devbox>
In-Reply-To: <152749149794.15132.15817377604536829521.stgit@devbox>
User-Agent: astroid/0.11.1 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18053110-0008-0000-0000-000002425340
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053110-0009-0000-0000-000021A7FEC5
Message-Id: <1527763450.f65xiu4yuz.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-31_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=723 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310126
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> Clear current_kprobe and enable preemption in kprobe
> even if pre_handler returns !0.
> 
> This simplifies function override using kprobes.
> 
> Jprobe used to require to keep the preemption disabled and
> keep current_kprobe until it returned to original function
> entry. For this reason kprobe_int3_handler() and similar
> arch dependent kprobe handers checks pre_handler result
> and exit without enabling preemption if the result is !0.
> 
> After removing the jprobe, Kprobes does not need to
> keep preempt disabled even if user handler returns !0
> anymore.

I think the reason jprobes did it that way is to address architecture 
specific requirements when changing a function. So, without that 
infrastructure, I am not sure if we will be able to claim support for 
over-riding functions with kprobes. I am not sure if we want to claim 
that, but this is something we need to be clear on.

For powerpc, the current function override in error-inject works fine 
since the new function does nothing. But, if anyone wants to do more 
work in the replacement function, it won't work with the current 
approach.

> 
> But since the function override handler in error-inject
> and bpf is also returns !0 if it overrides a function,
> to balancing the preempt count, it enables preemption
> and reset current kprobe by itself.
> 
> That is a bad design that is very buggy. This fixes
> such unbalanced preempt-count and current_kprobes setting
> in kprobes, bpf and error-inject.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arc/kernel/kprobes.c          |    5 +++--
>  arch/arm/probes/kprobes/core.c     |   10 +++++-----
>  arch/arm64/kernel/probes/kprobes.c |   10 +++++-----
>  arch/ia64/kernel/kprobes.c         |   13 ++++---------
>  arch/mips/kernel/kprobes.c         |    4 ++--
>  arch/powerpc/kernel/kprobes.c      |    7 +++++--

I think you should also update arch/powerpc/kernel/kprobes-ftrace.c

- Naveen
