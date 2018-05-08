Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbeEHPCV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932683AbeEHPCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:02:19 -0400
Date: Wed, 9 May 2018 00:02:15 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v7 00/16] tracing: probeevent: Improve fetcharg features
Message-Id: <20180509000215.b4e907b419540d8c84abcdd9@kernel.org>
In-Reply-To: <1525772835.npvwj0nws0.naveen@linux.ibm.com>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
        <20180503181137.6d82d897@gandalf.local.home>
        <20180505004828.9b75b6802472f09b0d2de5b8@kernel.org>
        <20180504120642.354cdd1f@gandalf.local.home>
        <20180505113803.45700179a93091b114ec6984@kernel.org>
        <1525506231.y43xvmd3yw.naveen@linux.ibm.com>
        <20180505233211.ecad929b13461f1e5f6427d2@kernel.org>
        <1525680222.8nou0tzkkt.naveen@linux.ibm.com>
        <20180507235317.fa04131c603dbe59ef78a829@kernel.org>
        <1525772835.npvwj0nws0.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 May 2018 15:41:11 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > On Mon, 07 May 2018 13:41:53 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> >> >> 
> >> >> I didn't understand that. Which code are you planning to remove? Can you 
> >> >> please elaborate? I thought we still need to disable preemption in the 
> >> >> ftrace handler.
> >> > 
> >> > Yes, kprobe_ftrace_handler itself must be run under preempt disabled
> >> > because it depends on a per-cpu variable. What I will remove is the
> >> > redundant preempt disable/enable_noresched (unbalanced) pair in the
> >> > kprobe_ftrace_handler, and jprobe x86 ports which is no more used.
> >> 
> >> Won't that break out-of-tree users depending on returning a non-zero 
> >> value to handle preemption differently? You seem to have alluded to it 
> >> earlier in the mail chain above where you said that this is not just for 
> >> jprobes (though it was added for jprobes as the main use case).
> > 
> > No, all users are in tree already (function override for bpf and error-injection).
> 
> Ok, so BPF error injection is a new user that can return a non-zero 
> value from the pre handler. It looks like it can use KPROBES_ON_FTRACE 
> too.
> 
> In that case, on function entry, we call into kprobe_ftrace_handler() 
> which will call fei_kprobe_handler(), which can re-enable premption 
> before returning 1. So, if you remove the additional 
> prempt_disable()/enable_no_resched() in kprobe_ftrace_handler(), then it 
> will become imbalanced, right?

Right. So we have to fix both at once. Please check the patch below.

https://patchwork.kernel.org/patch/10386171/

(Sorry, I missed to cc you...)

> 
> > And also, for changing execution path by using kprobes, user handler must call
> > not only preempt_enable(), but also clear current_kprobe per-cpu variable which
> > is not exported to kmodules.
> 
> Ok, good point. And that means we don't have any external users any 
> more.

Yes :)

Thank you,

> 
> Thanks,
> Naveen
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
