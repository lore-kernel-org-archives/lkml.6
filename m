Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95540C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FF42075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FF42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbeIGSZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:25:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbeIGSZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:25:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w87DiYcx094422
        for <linux-kernel@vger.kernel.org>; Fri, 7 Sep 2018 09:44:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mbrb5wjrp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:44:36 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 7 Sep 2018 14:44:28 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Sep 2018 14:44:24 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w87DiNTC30736496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Sep 2018 13:44:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAF02AE058;
        Fri,  7 Sep 2018 16:43:43 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D11FAE051;
        Fri,  7 Sep 2018 16:43:42 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.199.46.141])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  7 Sep 2018 16:43:41 +0100 (BST)
Date:   Fri, 7 Sep 2018 19:14:20 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jirka Hladky <jhladky@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jakub Ra??ek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kkolakow@redhat.com" <kkolakow@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [SCHEDULER] Performance drop in 4.19 compared to 4.18 kernel
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <CAE4VaGC+FcE4cTUwzTLuCRd8rnd-=MhSZHfjKstiRTKcYq-39g@mail.gmail.com>
 <20180907125649.GA3995@linux.vnet.ibm.com>
 <20180907131923.GB24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180907131923.GB24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090713-0020-0000-0000-000002C2BF06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090713-0021-0000-0000-0000210FFC85
Message-Id: <20180907134420.GD3995@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809070140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2018-09-07 15:19:23]:

> On Fri, Sep 07, 2018 at 06:26:49PM +0530, Srikar Dronamraju wrote:
> 
> > Can you please pick
> > 
> > 
> > 1. 69bb3230297e881c797bbc4b3dbf73514078bc9d sched/numa: Stop multiple tasks
> > from moving to the cpu at the same time
> > 2. dc62cfdac5e5b7a61cd8a2bd4190e80b9bb408fc sched/numa: Avoid task migration
> > for small numa improvement
> > 3. 76e18a67cdd9e3609716c8a074c03168734736f9 sched/numa: Pass destination cpu as
> > a parameter to migrate_task_rq
> > 4.  489c19b440ebdbabffe530b9a41389d0a8b315d9 sched/numa: Reset scan rate
> > whenever task moves across nodes
> > 5.  b7e9ae1ae3825f35cd0f38f1f0c8e91ea145bc30 sched/numa: Limit the
> > conditions where scan period is reset
> > 
> > from https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/kernel/sched
> 
> That is not a stable tree; the whole thing is re-generated from my quilt
> set every time I feel like it.
> 
> It is likely those commit ids will no longer exist in a few hours.
> 

Okay, I will forward the relevant mails to Jirka.

-- 
Thanks and Regards
Srikar Dronamraju

