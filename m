Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9510C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFA5216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFA5216FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeHHKjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:39:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726979AbeHHKjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:39:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w788KadP032117
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 04:20:48 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kqrkyh2ds-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 04:20:47 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 8 Aug 2018 09:19:48 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 09:19:45 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w788JiH939124992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 08:19:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0003CA405B;
        Wed,  8 Aug 2018 11:19:51 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68E4DA4040;
        Wed,  8 Aug 2018 11:19:50 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.40.192.68])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  8 Aug 2018 11:19:50 +0100 (BST)
Date:   Wed, 8 Aug 2018 01:19:42 -0700
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Andre Wild <wild@linux.vnet.ibm.com>
Subject: Re: [PATCH] sched/topology: Use Identity node only if required
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1533712172-11428-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180808075840.GO2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180808075840.GO2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18080808-0012-0000-0000-00000296D128
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080808-0013-0000-0000-000020C9DAB3
Message-Id: <20180808081942.GA37418@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2018-08-08 09:58:41]:

> On Wed, Aug 08, 2018 at 12:39:31PM +0530, Srikar Dronamraju wrote:
> >  - numa topology on 2 node systems no more marked as NUMA_DIRECT.  After
> >    this commit, it gets reported as NUMA_BACKPLANE. This is because
> >    sched_domains_numa_level now equals 2 on 2 node systems.
> > 
> >  - Extra numa sched domain that gets added and degenerated on most
> >    machines.  The Identity node is only needed on very few systems.
> >    Also all non-numa systems will end up populating
> >    sched_domains_numa_distance and sched_domains_numa_masks tables.
> > 
> >  - On shared lpars like powerpc, this extra sched domain creation can
> >    lead to repeated rcu stalls, sometimes even causing unresponsive
> >    systems on boot. On such stalls, it was noticed that
> >    init_sched_groups_capacity() (sg != sd->groups is always true).
> 
> The idea was that if the topology level is redundant (as it often is);
> then the degenerate code would take it out.
> 
> Why is that not working (right) and can we fix that instead?
> 

All I have found is regular NUMA sched_domains use OVERLAP flag, which
inturn results in build_overlap_sched_groups(). The Identity node uses
build_sched_groups. Somehow build_sched_groups is unable to create the
group list. I still getting to see why that makes a difference.

I have tried with passing .flags = SDTL_OVERLAP to the identity node and
that works well. 

However, I still think if majority of the cases the identity node is
going to be redundant, then we should use hint.

We could fix the numa topology to be NUMA_DIRECT for 2 node machines, by
checking if sched_domains_numa_levels == 2, but then I dont know what it
means for a system that has only NODE but not NUMA level.

i.e what should we say the numa topology type of a machine that has only
NODE but not NUMA sched_domain?

-- 
Thanks and Regards
Srikar

