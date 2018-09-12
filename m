Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5510EC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBEC20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBEC20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeILPtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:49:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726970AbeILPtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:49:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CAdb36048191
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 06:45:13 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mf17g0893-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 06:45:12 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 12 Sep 2018 11:45:10 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 11:45:08 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8CAj7RK65667296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 10:45:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80C59A405E;
        Wed, 12 Sep 2018 13:44:56 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 326B0A4040;
        Wed, 12 Sep 2018 13:44:55 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.199.37.200])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 12 Sep 2018 13:44:55 +0100 (BST)
Date:   Wed, 12 Sep 2018 16:15:05 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/numa: Do not move imbalanced load purely on
 the basis of an idle CPU
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
 <20180907101139.20760-5-mgorman@techsingularity.net>
 <20180907113309.GU24106@hirez.programming.kicks-ass.net>
 <20180907123739.GE1719@techsingularity.net>
 <20180910094147.GH1719@techsingularity.net>
 <20180912065410.GA5352@linux.vnet.ibm.com>
 <20180912093621.GY24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180912093621.GY24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18091210-0016-0000-0000-0000020433EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091210-0017-0000-0000-0000325AFCE4
Message-Id: <20180912104505.GC5352@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2018-09-12 11:36:21]:

> On Wed, Sep 12, 2018 at 12:24:10PM +0530, Srikar Dronamraju wrote:
> 
> > Kernel A = 4.18+ 13 sched patches part of v4.19-rc1.
> > Kernel B = Kernel A + 6 patches (http://lore.kernel.org/lkml/1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com)
> > Kernel C = Kernel B - (Avoid task migration for small numa improvement) i.e
> > 	http://lore.kernel.org/lkml/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com
> > 	+ 2 patches from Mel
> > 	(Do not move imbalanced load purely)
> > 	http://lore.kernel.org/lkml/20180907101139.20760-5-mgorman@techsingularity.net
> > 	(Stop comparing tasks for NUMA placement)
> > 	http://lore.kernel.org/lkml/20180907101139.20760-4-mgorman@techsingularity.net
> 
> But that's not a fair comparison :/ You've complicated things by adding
> that second patch from Mel.
> 

One patch does choose a idle thread over a possible swap. This is the one
that conflicts with "Avoid task migration for small numa improvement".

The other one detects if we have already found an idle thread and stops
iterating. So if we have already chosen a idle CPU, then dont iterate. So
this patch should ideally help the above patch.

My take on both the patches:
If there is a possible swap candidate (i.e if choosing a thread over idle is
better from a NUMA score improvement perspective), then it means the swap
candidate will benefit from movement. It means the swap candidate is not
running on its preferred node at this moment. If we don't do it, the swap
candidate will later on try migrating to its preferred node. We could avoid
that if we choose swap candidate over idle thread. Please note if the idle
and swap candidates yield the same NUMA score, then we still choose the idle
thread and not the swap candidate.

> Now you cannot (unambiguously) tell what the cause for the performance
> difference is.
> 

The difference as I listed above is should we choose a swap candidate with
more NUMA score compared to idle thread.

My patch would hurt if there was an idle thread and we still iterate for
possible swap candidates and we dont find any. But that we cant speculate.

