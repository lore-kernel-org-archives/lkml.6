Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C503FC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7798020833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7798020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeILL6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:58:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbeILL6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:58:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8C6ssid110154
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:55:02 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2metq5xd54-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:54:59 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 12 Sep 2018 07:54:17 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 07:54:14 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8C6sC4p590158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 06:54:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE72B52054;
        Wed, 12 Sep 2018 09:54:01 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.199.37.200])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 9F07552051;
        Wed, 12 Sep 2018 09:54:00 +0100 (BST)
Date:   Wed, 12 Sep 2018 12:24:10 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180910094147.GH1719@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18091206-0020-0000-0000-000002C5054E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091206-0021-0000-0000-000021125928
Message-Id: <20180912065410.GA5352@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2018-09-10 10:41:47]:

> On Fri, Sep 07, 2018 at 01:37:39PM +0100, Mel Gorman wrote:
> > > Srikar's patch here:
> > > 
> > >   http://lkml.kernel.org/r/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com
> > > 
> > > Also frobs this condition, but in a less radical way. Does that yield
> > > similar results?
> > 
> > I can check. I do wonder of course if the less radical approach just means
> > that automatic NUMA balancing and the load balancer simply disagree about
> > placement at a different time. It'll take a few days to have an answer as
> > the battery of workloads to check this take ages.
> > 
> 
> Tests completed over the weekend and I've found that the performance of
> both patches are very similar for two machines (both 2 socket) running a
> variety of workloads. Hence, I'm not worried about which patch gets picked
> up. However, I would prefer my own on the grounds that the additional
> complexity does not appear to get us anything. Of course, that changes if
> Srikar's tests on his larger ppc64 machines show the more complex approach
> is justified.
> 

Running SPECJbb2005. Higher bops are better.

Kernel A = 4.18+ 13 sched patches part of v4.19-rc1.
Kernel B = Kernel A + 6 patches (http://lore.kernel.org/lkml/1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com)
Kernel C = Kernel B - (Avoid task migration for small numa improvement) i.e
	http://lore.kernel.org/lkml/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com
	+ 2 patches from Mel
	(Do not move imbalanced load purely)
	http://lore.kernel.org/lkml/20180907101139.20760-5-mgorman@techsingularity.net
	(Stop comparing tasks for NUMA placement)
	http://lore.kernel.org/lkml/20180907101139.20760-4-mgorman@techsingularity.net

To me, Kernel B which is the 13 patches accepted in v4.19-rc1 + 6 patches
posted for review seem to be giving better performance.

The numbers are compared to previous kernel i.e
for Kernel A, v4.18 is prev
for kernel B, Kernel A is prev
for Kernel C, B is prev

2 node x86 Haswell

v4.18 or 94710cac0ef4
JVMS  Prev    Current  %Change
4     203769
1     316734

Kernel A
JVMS  Prev    Current  %Change
4     203769  209790   2.95482
1     316734  312377   -1.3756

Kernel B
JVMS  Prev    Current  %Change
4     209790  202059   -3.68511
1     312377  326987   4.67704

Kernel C
JVMS  Prev    Current  %Change
4     202059  200681   -0.681979
1     326987  316715   -3.14141

================================================


4 Node / 2 Socket PowerNV / Power 8

v4.18 or 94710cac0ef4
JVMS  Prev    Current  %Change
8     88411.9
1     222075

Kernel A
JVMS  Prev     Current  %Change
8     88411.9  88733.5  0.363752
1     222075   214607   -3.36283

Kernel B
JVMS  Prev     Current  %Change
8     88733.5  89952    1.37321
1     214607   217226   1.22037

Kernel C
JVMS  Prev    Current  %Change
8     89952   89912.9  -0.0434676
1     217226  219281   0.946019


================================================


2 Node / 2 Socket Power 9 / PowerNV

v4.18 or 94710cac0ef4
JVMS  Prev    Current  %Change
4     195989
1     202854

Kernel A
JVMS  Prev    Current  %Change
4     195989  193108   -1.46998
1     202854  204042   0.585643

Kernel B
JVMS  Prev    Current  %Change
4     193108  196422   1.71614
1     204042  211219   3.51741

Kernel C
JVMS  Prev    Current  %Change
4     196422  195052   -0.697478
1     211219  207854   -1.59313


================================================

4 Node / 4 Socket Power 7 PhyP LPAR.

v4.18 or 94710cac0ef4
JVMS  Prev    Current  %Change
8     52826.9
1     103103

Kernel A
JVMS  Prev     Current  %Change
8     52826.9  59504.4  12.6403
1     103103   102542   -0.544116

Kernel B
JVMS  Prev     Current  %Change
8     59504.4  61674.8  3.64746
1     102542   108211   5.52847

Kernel C
JVMS  Prev     Current  %Change
8     61674.8  57946.5  -6.04509
1     108211   104533   -3.39892

