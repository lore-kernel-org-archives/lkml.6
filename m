Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754705AbeEHKLZ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:11:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754366AbeEHKLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:11:22 -0400
Date: Tue, 08 May 2018 15:41:11 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 00/16] tracing: probeevent: Improve fetcharg features
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
        <20180503181137.6d82d897@gandalf.local.home>
        <20180505004828.9b75b6802472f09b0d2de5b8@kernel.org>
        <20180504120642.354cdd1f@gandalf.local.home>
        <20180505113803.45700179a93091b114ec6984@kernel.org>
        <1525506231.y43xvmd3yw.naveen@linux.ibm.com>
        <20180505233211.ecad929b13461f1e5f6427d2@kernel.org>
        <1525680222.8nou0tzkkt.naveen@linux.ibm.com>
        <20180507235317.fa04131c603dbe59ef78a829@kernel.org>
In-Reply-To: <20180507235317.fa04131c603dbe59ef78a829@kernel.org>
User-Agent: astroid/0.11.1 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18050810-0040-0000-0000-0000043750E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050810-0041-0000-0000-0000263B8ACB
Message-Id: <1525772835.npvwj0nws0.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=8 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=8
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805080098
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> On Mon, 07 May 2018 13:41:53 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>> >> 
>> >> I didn't understand that. Which code are you planning to remove? Can you 
>> >> please elaborate? I thought we still need to disable preemption in the 
>> >> ftrace handler.
>> > 
>> > Yes, kprobe_ftrace_handler itself must be run under preempt disabled
>> > because it depends on a per-cpu variable. What I will remove is the
>> > redundant preempt disable/enable_noresched (unbalanced) pair in the
>> > kprobe_ftrace_handler, and jprobe x86 ports which is no more used.
>> 
>> Won't that break out-of-tree users depending on returning a non-zero 
>> value to handle preemption differently? You seem to have alluded to it 
>> earlier in the mail chain above where you said that this is not just for 
>> jprobes (though it was added for jprobes as the main use case).
> 
> No, all users are in tree already (function override for bpf and error-injection).

Ok, so BPF error injection is a new user that can return a non-zero 
value from the pre handler. It looks like it can use KPROBES_ON_FTRACE 
too.

In that case, on function entry, we call into kprobe_ftrace_handler() 
which will call fei_kprobe_handler(), which can re-enable premption 
before returning 1. So, if you remove the additional 
prempt_disable()/enable_no_resched() in kprobe_ftrace_handler(), then it 
will become imbalanced, right?

> And also, for changing execution path by using kprobes, user handler must call
> not only preempt_enable(), but also clear current_kprobe per-cpu variable which
> is not exported to kmodules.

Ok, good point. And that means we don't have any external users any 
more.

Thanks,
Naveen
