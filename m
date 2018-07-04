Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E51C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BD024496
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BD024496
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753743AbeGDLTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:19:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753600AbeGDLTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:19:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64BJTNc132683
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 07:19:30 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k0vm59nus-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:19:30 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 12:19:19 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 12:19:15 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w64BJEuJ27852846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 11:19:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C3CCA4055;
        Wed,  4 Jul 2018 14:19:40 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB3AEA4051;
        Wed,  4 Jul 2018 14:19:38 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.40.192.68])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  4 Jul 2018 14:19:38 +0100 (BST)
Date:   Wed, 4 Jul 2018 04:19:13 -0700
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 18/19] sched/numa: Reset scan rate whenever task moves
 across nodes
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1529514181-9842-19-git-send-email-srikar@linux.vnet.ibm.com>
 <20180621100505.a6gzpn7r6yj2gkgd@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180621100505.a6gzpn7r6yj2gkgd@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18070411-4275-0000-0000-000002951102
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070411-4276-0000-0000-0000379C94CA
Message-Id: <20180704111913.GB21902@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We talked about this before but I would at least suggest that you not
> reset the scan if moving to the preferred node or if the node movement
> has nothing to do with the preferred nid. e.g.
> 

I understand your concern and okay to drop this patch for now.
I will try to rework and come back later.

> 	/*
> 	 * Ignore if the migration is not changing node, if it is migrating to
> 	 * the preferred node or moving between two nodes that are not preferred
> 	 */
> 
> 	if (p->numa_faults) {
> 		int src_nid = cpu_to_node(task_cpu(p));
> 		int dst_nid = cpu_to_node(new_cpu);
> 
> 		if (src_nid == dst_nid || dst_nid == p->numa_preferred_nid ||
> 		    (p->numa_preferred_nid != -1 && src_nid != p->numa_preferred_nid))

With out this change/patch, we used to reduce our scan rate whenever numa
balancer moved a task to a preferred node. This was made to verify that
the task movement was correct. The check ( dst_nid == p->numa_preferred_nid)
will negate that verification. I thought the whole point of reducing the
scan period was to correct if we choose a wrong node.

> 			return;
> 
> 		p->numa_scan_period = task_scan_start(p);
> 
> Note too that the next scan can be an arbitrary amount of time in the
> future. Consider as an alternative to schedule an immediate scan instead
> of adjusting the rate with
> 
> 		p->mm->numa_next_scan = jiffies;
> 

I will try to work along these lines.  Though the scan happens
immediately the task placement will not happen immediately so I am not
sure if it would help much.

> That might be less harmful in terms of overhead while still collecting
> some data in the short-term.
> 

-- 
Thanks and Regards
Srikar

