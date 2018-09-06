Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E15C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4762D20869
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4762D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeIFKX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:23:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbeIFKX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:23:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w865nTM4022907
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 01:50:12 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mat7a8rtj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 01:50:11 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 6 Sep 2018 06:50:09 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 06:50:01 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w865o0nH42729486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 05:50:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3165511C050;
        Thu,  6 Sep 2018 08:49:52 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C92AA11C054;
        Thu,  6 Sep 2018 08:49:49 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.92])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Sep 2018 08:49:49 +0100 (BST)
Date:   Thu, 6 Sep 2018 08:49:56 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>,
        "alex.kogan@oracle.com" <alex.kogan@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "dave.dice@oracle.com" <dave.dice@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>,
        "ldufour@linux.vnet.ibm.com" <ldufour@linux.vnet.ibm.com>,
        "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
        "shady.issa@oracle.com" <shady.issa@oracle.com>,
        "tariqt@mellanox.com" <tariqt@mellanox.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tim.c.chen@intel.com" <tim.c.chen@intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "longman@redhat.com" <longman@redhat.com>,
        "yang.shi@linux.alibaba.com" <yang.shi@linux.alibaba.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        "subhra.mazumdar@oracle.com" <subhra.mazumdar@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        "jwadams@google.com" <jwadams@google.com>,
        "ashwinch@google.com" <ashwinch@google.com>,
        "sqazi@google.com" <sqazi@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "walken@google.com" <walken@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "junaids@google.com" <junaids@google.com>,
        Neha Agarwal <nehaagarwal@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
 <20180905063845.GA23342@rapoport-lnx>
 <846ac52b-1839-4aa1-3154-1925c159bf4c@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846ac52b-1839-4aa1-3154-1925c159bf4c@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090605-0008-0000-0000-0000026D0250
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090605-0009-0000-0000-000021D522FA
Message-Id: <20180906054955.GB27492@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 05, 2018 at 07:51:34PM +0000, Pasha Tatashin wrote:
> 
> On 9/5/18 2:38 AM, Mike Rapoport wrote:
> > On Tue, Sep 04, 2018 at 05:28:13PM -0400, Daniel Jordan wrote:
> >> Pavel Tatashin, Ying Huang, and I are excited to be organizing a performance and scalability microconference this year at Plumbers[*], which is happening in Vancouver this year.  The microconference is scheduled for the morning of the second day (Wed, Nov 14).
> >>
> >> We have a preliminary agenda and a list of confirmed and interested attendees (cc'ed), and are seeking more of both!
> >>
> >> Some of the items on the agenda as it stands now are:
> >>
> >>  - Promoting huge page usage:  With memory sizes becoming ever larger, huge pages are becoming more and more important to reduce TLB misses and the overhead of memory management itself--that is, to make the system scalable with the memory size.  But there are still some remaining gaps that prevent huge pages from being deployed in some situations, such as huge page allocation latency and memory fragmentation.
> >>
> >>  - Reducing the number of users of mmap_sem:  This semaphore is frequently used throughout the kernel.  In order to facilitate scaling this longstanding bottleneck, these uses should be documented and unnecessary users should be fixed.
> >>
> >>  - Parallelizing cpu-intensive kernel work:  Resolve problems of past approaches including extra threads interfering with other processes, playing well with power management, and proper cgroup accounting for the extra threads.  Bonus topic: proper accounting of workqueue threads running on behalf of cgroups.
> >>
> >>  - Preserving userland during kexec with a hibernation-like mechanism.
> > 
> > Just some crazy idea: have you considered using checkpoint-restore as a
> > replacement or an addition to hibernation?
> 
> Hi Mike,
> 
> Yes, this is one way I was thinking about, and use kernel to pass the
> application stored state to new kernel in pmem. The only problem is that
> we waste memory: when there is not enough system memory to copy and pass
> application state to new kernel this scheme won't work. Think about DB
> that occupies 80% of system memory and we want to checkpoint/restore it.
>
> So, we need to have another way, where the preserved memory is the
> memory that is actually used by the applications, not copied. One easy
> way is to give each application that has a large state that is expensive
> to recreate a persistent memory device and let applications to keep its
> state on that device (say /dev/pmemN). The only problem is that memory
> on that device must be accessible just as fast as regular memory without
> any file system overhead and hopefully without need for DAX.
 
Like hibernation, checkpoint persists the state, so it won't require
additional memory. At the restore time, the memory state is recreated from
the persistent checkpoint and of course it's slower than the regular
memory access, but it won't differ much from resuming from hibernation.

Maybe it would be possible to preserve applications state if we extend
suspend-to-RAM -> resume with the ability to load a new kernel during
resume...

> I just want to get some ideas of what people are thinking about this,
> and what would be the best way to achieve it.
> 
> Pavel
> 
> 
> >  
> >> These center around our interests, but having lots of topics to choose from ensures we cover what's most important to the community, so we would like to hear about additional topics and extensions to those listed here.  This includes, but is certainly not limited to, work in progress that would benefit from in-person discussion, real-world performance problems, and experimental and academic work.
> >>
> >> If you haven't already done so, please let us know if you are interested in attending, or have suggestions for other attendees.
> >>
> >> Thanks,
> >> Daniel
> >>
> >> [*] https://blog.linuxplumbersconf.org/2018/performance-mc/
> >>
> > 

-- 
Sincerely yours,
Mike.

