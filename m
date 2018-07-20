Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0934ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E4E204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E4E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbeGTOgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:36:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731583AbeGTOgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:36:11 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KDi9Xq015972
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 09:47:47 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kbf09nnqs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 09:47:46 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 20 Jul 2018 14:47:44 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Jul 2018 14:47:38 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6KDlbtw27656404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Jul 2018 13:47:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F30FB42047;
        Fri, 20 Jul 2018 16:47:54 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7F424203F;
        Fri, 20 Jul 2018 16:47:44 +0100 (BST)
Received: from [9.77.210.204] (unknown [9.77.210.204])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jul 2018 16:47:44 +0100 (BST)
Subject: Re: [PATCH v6 0/6] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     srikar@linux.vnet.ibm.com, oleg@redhat.com, mhiramat@kernel.org,
        Song Liu <liu.song.a23@gmail.com>
Cc:     rostedt@goodmis.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Fri, 20 Jul 2018 19:17:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18072013-0028-0000-0000-000002DE0D08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072013-0029-0000-0000-00002395E006
Message-Id: <0c0adc46-ca53-94d6-658e-77c724e6ce73@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807200156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg, Srikar, Masami, Song,

Any feedback please? :)

Thanks,
Ravi

On 07/16/2018 02:17 PM, Ravi Bangoria wrote:
> Userspace Statically Defined Tracepoints[1] are dtrace style markers
> inside userspace applications. Applications like PostgreSQL, MySQL,
> Pthread, Perl, Python, Java, Ruby, Node.js, libvirt, QEMU, glib etc
> have these markers embedded in them. These markers are added by developer
> at important places in the code. Each marker source expands to a single
> nop instruction in the compiled code but there may be additional
> overhead for computing the marker arguments which expands to couple of
> instructions. In case the overhead is more, execution of it can be
> omitted by runtime if() condition when no one is tracing on the marker:
> 
>     if (reference_counter > 0) {
>         Execute marker instructions;
>     }
> 
> Default value of reference counter is 0. Tracer has to increment the 
> reference counter before tracing on a marker and decrement it when
> done with the tracing.
> 
> Currently, perf tool has limited supports for SDT markers. I.e. it
> can not trace markers surrounded by reference counter. Also, it's
> not easy to add reference counter logic in userspace tool like perf,
> so basic idea for this patchset is to add reference counter logic in
> the a uprobe infrastructure. Ex,[2]
> 
>   # cat tick.c
>     ... 
>     for (i = 0; i < 100; i++) {
> 	DTRACE_PROBE1(tick, loop1, i);
>         if (TICK_LOOP2_ENABLED()) {
>             DTRACE_PROBE1(tick, loop2, i); 
>         }
>         printf("hi: %d\n", i); 
>         sleep(1);
>     }   
>     ... 
> 
> Here tick:loop1 is marker without reference counter where as tick:loop2
> is surrounded by reference counter condition.
> 
>   # perf buildid-cache --add /tmp/tick
>   # perf probe sdt_tick:loop1
>   # perf probe sdt_tick:loop2
> 
>   # perf stat -e sdt_tick:loop1,sdt_tick:loop2 -- /tmp/tick
>   hi: 0
>   hi: 1
>   hi: 2
>   ^C
>   Performance counter stats for '/tmp/tick':
>              3      sdt_tick:loop1
>              0      sdt_tick:loop2
>      2.747086086 seconds time elapsed
> 
> Perf failed to record data for tick:loop2. Same experiment with this
> patch series:
> 
>   # ./perf buildid-cache --add /tmp/tick
>   # ./perf probe sdt_tick:loop2
>   # ./perf stat -e sdt_tick:loop2 /tmp/tick
>     hi: 0
>     hi: 1
>     hi: 2
>     ^C  
>      Performance counter stats for '/tmp/tick':
>                  3      sdt_tick:loop2
>        2.561851452 seconds time elapsed
> 
> 
> v6 changes:
>  - Do not export struct uprobe outside of uprobe.c. Instead, use
>    container_of(arch_uprobe) to regain uprobe in uprobe_write_opcode().
>  - Allow 0 as a special value for reference counter _offset_. I.e.
>    two uprobes, one having ref_ctr_offset=0 and the other having
>    non-zero ref_ctr_offset can coexists.
>  - If vma holding reference counter is not present while patching an
>    instruction, we add that uprobe in delayed_uprobe_list. When
>    appropriate mapping is created, we increment the reference counter
>    and remove uprobe from delayed_uprobe_list. While doing all this,
>    v5 was searching for all such uprobes in uprobe_tree which is not 
>    require. Also, uprobes are stored in rbtree with inode+offset as
>    the key and v5 was searching uprobe based on inode+ref_ctr_offset
>    which is wrong too. Fix this by directly looing on delayed_uprobe_list.
>  - Consider VM_SHARED vma as invalid for reference counter. Return
>    false from valid_ref_ctr_vma() if vma->vm_flags has VM_SHARED set.
>  - No need to use FOLL_FORCE in get_user_pages_remote() while getting
>    a page to update reference counter. Remove it.
>  - Do not mention usage of reference counter in Documentation/.
> 
> 
> v5 can be found at: https://lkml.org/lkml/2018/6/28/51
> 
> Ravi Bangoria (6):
>   Uprobes: Simplify uprobe_register() body
>   Uprobe: Additional argument arch_uprobe to uprobe_write_opcode()
>   Uprobes: Support SDT markers having reference count (semaphore)
>   trace_uprobe/sdt: Prevent multiple reference counter for same uprobe
>   Uprobes/sdt: Prevent multiple reference counter for same uprobe
>   perf probe: Support SDT markers having reference counter (semaphore)
> 
>  arch/arm/probes/uprobes/core.c |   2 +-
>  arch/mips/kernel/uprobes.c     |   2 +-
>  include/linux/uprobes.h        |   7 +-
>  kernel/events/uprobes.c        | 358 ++++++++++++++++++++++++++++++++++++-----
>  kernel/trace/trace.c           |   2 +-
>  kernel/trace/trace_uprobe.c    |  78 ++++++++-
>  tools/perf/util/probe-event.c  |  39 ++++-
>  tools/perf/util/probe-event.h  |   1 +
>  tools/perf/util/probe-file.c   |  34 +++-
>  tools/perf/util/probe-file.h   |   1 +
>  tools/perf/util/symbol-elf.c   |  46 ++++--
>  tools/perf/util/symbol.h       |   7 +
>  12 files changed, 503 insertions(+), 74 deletions(-)
> 

