Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F1CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7092086C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7092086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbeIGSXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:23:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729579AbeIGSXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:23:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w87DcdFe039823
        for <linux-kernel@vger.kernel.org>; Fri, 7 Sep 2018 09:42:10 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mbrbenn3g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:42:09 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 7 Sep 2018 14:42:06 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Sep 2018 14:42:04 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w87Dg3dm61800532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Sep 2018 13:42:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E86B311C064;
        Fri,  7 Sep 2018 16:41:54 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A091D11C04A;
        Fri,  7 Sep 2018 16:41:53 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.199.46.141])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  7 Sep 2018 16:41:53 +0100 (BST)
Date:   Fri, 7 Sep 2018 19:12:01 +0530
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
 <20180907124432.GN24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180907124432.GN24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090713-0016-0000-0000-00000201D016
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090713-0017-0000-0000-00003258814A
Message-Id: <20180907134201.GC3995@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809070139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2018-09-07 14:44:32]:

> On Fri, Sep 07, 2018 at 01:37:39PM +0100, Mel Gorman wrote:
> > On Fri, Sep 07, 2018 at 01:33:09PM +0200, Peter Zijlstra wrote:
> > > > ---
> > > >  kernel/sched/fair.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index d59d3e00a480..d4c289c11012 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -1560,7 +1560,7 @@ static bool task_numa_compare(struct task_numa_env *env,
> > > >  		goto unlock;
> > > >  
> > > >  	if (!cur) {
> > > > -		if (maymove || imp > env->best_imp)
> > > > +		if (maymove)
> > > >  			goto assign;
> > > >  		else
> > > >  			goto unlock;
> > > 
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
> 
> Yeah, I was afraid it would.. Srikar, can you also evaluate, I suspect
> we'll have to pick one of these two patches.

I can surely run some benchmarks between the two patches.
However comparing  Mel's patch with
http://lkml.kernel.org/r/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com

Mel's patch

  	if (!cur) {
 -		if (maymove || imp > env->best_imp)
 +		if (maymove)
  			goto assign;
  		else
http://lkml.kernel.org/r/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com


 	if (!cur) {
-		if (maymove || imp > env->best_imp)
+		if (maymove && moveimp >= env->best_imp)
 			goto assign;
 		else

In Mel's fix, if we already found a candidate task to swap and then encounter a
idle cpu, we are going ahead and overwriting the swap candidate. There is
always a chance that swap candidate is a better fit than moving to idle cpu.

In the patch which is in your queue, we are saying move only if it is better than
swap candidate. So this is noway less radical than Mel's patch and probably
more correct.

-- 
Thanks and Regards
Srikar Dronamraju
> 

