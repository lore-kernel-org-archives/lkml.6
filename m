Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120B5C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44492073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44492073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIELHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:07:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbeIELHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:07:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w856cYQt065947
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 02:39:03 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2maa0n85jd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:39:03 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 07:39:00 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 07:38:51 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w856cop542991788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 06:38:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23D7E4C044;
        Wed,  5 Sep 2018 09:38:45 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B14244C050;
        Wed,  5 Sep 2018 09:38:42 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Sep 2018 09:38:42 +0100 (BST)
Date:   Wed, 5 Sep 2018 09:38:46 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>, alex.kogan@oracle.com,
        akpm@linux-foundation.org, boqun.feng@gmail.com, brouer@redhat.com,
        dave@stgolabs.net, dave.dice@oracle.com,
        Dhaval Giani <dhaval.giani@oracle.com>, ktkhai@virtuozzo.com,
        ldufour@linux.vnet.ibm.com, Pavel.Tatashin@microsoft.com,
        paulmck@linux.vnet.ibm.com, shady.issa@oracle.com,
        tariqt@mellanox.com, tglx@linutronix.de, tim.c.chen@intel.com,
        vbabka@suse.cz, longman@redhat.com, yang.shi@linux.alibaba.com,
        shy828301@gmail.com, Huang Ying <ying.huang@intel.com>,
        subhra.mazumdar@oracle.com,
        Steven Sistare <steven.sistare@oracle.com>, jwadams@google.com,
        ashwinch@google.com, sqazi@google.com,
        Shakeel Butt <shakeelb@google.com>, walken@google.com,
        rientjes@google.com, junaids@google.com,
        Neha Agarwal <nehaagarwal@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090506-0028-0000-0000-000002F47D17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090506-0029-0000-0000-000023ADFA29
Message-Id: <20180905063845.GA23342@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 05:28:13PM -0400, Daniel Jordan wrote:
> Pavel Tatashin, Ying Huang, and I are excited to be organizing a performance and scalability microconference this year at Plumbers[*], which is happening in Vancouver this year.  The microconference is scheduled for the morning of the second day (Wed, Nov 14).
> 
> We have a preliminary agenda and a list of confirmed and interested attendees (cc'ed), and are seeking more of both!
> 
> Some of the items on the agenda as it stands now are:
> 
>  - Promoting huge page usage:  With memory sizes becoming ever larger, huge pages are becoming more and more important to reduce TLB misses and the overhead of memory management itself--that is, to make the system scalable with the memory size.  But there are still some remaining gaps that prevent huge pages from being deployed in some situations, such as huge page allocation latency and memory fragmentation.
> 
>  - Reducing the number of users of mmap_sem:  This semaphore is frequently used throughout the kernel.  In order to facilitate scaling this longstanding bottleneck, these uses should be documented and unnecessary users should be fixed.
> 
>  - Parallelizing cpu-intensive kernel work:  Resolve problems of past approaches including extra threads interfering with other processes, playing well with power management, and proper cgroup accounting for the extra threads.  Bonus topic: proper accounting of workqueue threads running on behalf of cgroups.
> 
>  - Preserving userland during kexec with a hibernation-like mechanism.

Just some crazy idea: have you considered using checkpoint-restore as a
replacement or an addition to hibernation?
 
> These center around our interests, but having lots of topics to choose from ensures we cover what's most important to the community, so we would like to hear about additional topics and extensions to those listed here.  This includes, but is certainly not limited to, work in progress that would benefit from in-person discussion, real-world performance problems, and experimental and academic work.
> 
> If you haven't already done so, please let us know if you are interested in attending, or have suggestions for other attendees.
> 
> Thanks,
> Daniel
> 
> [*] https://blog.linuxplumbersconf.org/2018/performance-mc/
> 

-- 
Sincerely yours,
Mike.

