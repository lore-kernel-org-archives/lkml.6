Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1495C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769F120880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769F120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeILUW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:22:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726677AbeILUW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:22:26 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CFGpna025399
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 11:17:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mf3fu5ry1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 11:17:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 12 Sep 2018 16:17:24 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 16:17:22 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8CFHLer66060304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 15:17:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CFC952059;
        Wed, 12 Sep 2018 18:17:10 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.199.45.134])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id C49F25205F;
        Wed, 12 Sep 2018 18:17:08 +0100 (BST)
Date:   Wed, 12 Sep 2018 20:47:19 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/6] sched/numa: Avoid task migration for small numa
 improvement
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com>
 <20180910084633.GD48257@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180910084633.GD48257@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18091215-4275-0000-0000-000002B94F00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091215-4276-0000-0000-000037C2848D
Message-Id: <20180912151719.GA14603@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=776 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  
> >  /*
> > + * Maximum numa importance can be 1998 (2*999);
> > + * SMALLIMP @ 30 would be close to 1998/64.
> > + * Used to deter task migration.
> > + */
> > +#define SMALLIMP	30
> > +
> > +/*
> >  
> >  	/*
> > +	 * If the numa importance is less than SMALLIMP,
> > +	 * task migration might only result in ping pong
> > +	 * of tasks and also hurt performance due to cache
> > +	 * misses.
> > +	 */
> > +	if (imp < SMALLIMP || imp <= env->best_imp + SMALLIMP / 2)
> > +		goto unlock;
> > +
> > +	/*
> >  	 * In the overloaded case, try and keep the load balanced.
> >  	 */
> >  	load = task_h_load(env->p) - task_h_load(cur);
> 
> So what is this 'NUMA importance'? Seems just like a random parameter which generally isn't a 
> good idea.
> 

I refer the weight that is used to compare the suitability of the task to a
node as NUMA Importance. It varies between -999 to 1000. This is not
something that was introduced by this patch, but was introduced as part of
Numa balancing couple of years ago. group_imp, task_imp, best_imp all refer
to the NUMA importance. May be I am using a wrong term here. May be imp
stands for something other than importance.

In this patch, we are trying to limit task migration for small NUMA
importance. i.e if the NUMA importance for moving/swapping tasks is only 10,
then should we drop all the cache affinity for NUMA affinity? May be we need
to wait for the trend to stabilize.

I have chosen 30 as the weight below which we refuse to consider NUMA
importance. Its based on maximum NUMA importance / 64.
Please do suggest if you have a better method to limit task migrations for
small NUMA gain.


