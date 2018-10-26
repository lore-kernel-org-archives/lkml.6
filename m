Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A172AC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B16B2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B16B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeJZSHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:07:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbeJZSHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:07:25 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9Q9Tl10023053
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 05:31:04 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nbw048fk1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 05:31:04 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 26 Oct 2018 10:31:02 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Oct 2018 10:30:59 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9Q9UwWa33882228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Oct 2018 09:30:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE81CAE053;
        Fri, 26 Oct 2018 09:30:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BC32AE056;
        Fri, 26 Oct 2018 09:30:56 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 26 Oct 2018 09:30:56 +0000 (GMT)
Date:   Fri, 26 Oct 2018 15:00:55 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Yi Wang <wang.yi59@zte.com.cn>, zhong.weidong@zte.com.cn,
        Yi Liu <liu.yi24@zte.com.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched/core: Don't mix isolcpus and housekeeping CPUs
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1540350169-18581-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20181024100323.GO3109@worktop.c.hoisthospitality.com>
 <20181024103002.GB18466@linux.vnet.ibm.com>
 <20181025000707.GR3109@worktop.c.hoisthospitality.com>
 <20181025173058.GD18466@linux.vnet.ibm.com>
 <20181026084105.GY3109@worktop.c.hoisthospitality.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181026084105.GY3109@worktop.c.hoisthospitality.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18102609-0008-0000-0000-000002860C39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102609-0009-0000-0000-000021F01695
Message-Id: <20181026093055.GF18466@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=926 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810260084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2018-10-26 10:41:05]:

> > #
> > # ./hist.sh
> > 10:35:21  IST   UID      TGID       TID    %usr %system  %guest    %CPU   CPU  Command
> > 10:35:21  IST     0      2645         -    8.70    0.01    0.00    8.71     1  ebizzy
> > 10:35:21  IST     0         -      2645    0.01    0.00    0.00    0.01     1  |__ebizzy
> > 10:35:21  IST     0         -      2647    0.14    0.00    0.00    0.14     1  |__ebizzy
> > 10:35:21  IST     0         -      2648    0.13    0.00    0.00    0.13     1  |__ebizzy
> > 10:35:21  IST     0         -      2649    0.13    0.00    0.00    0.13     1  |__ebizzy
> > 10:35:21  IST     0         -      2650    0.13    0.00    0.00    0.13     1  |__ebizzy
> > 10:35:21  IST     0         -      2651    0.13    0.00    0.00    0.13     1  |__ebizzy
> > 10:35:21  IST     0         -      2652    0.13    0.00    0.00    0.13     1  |__ebizzy
> > 10:35:21  IST     0         -      2653    0.13    0.00    0.00    0.13     1  |__ebizzy
> > 10:35:23  IST   UID      TGID       TID    %usr %system  %guest    %CPU   CPU  Command
> > 10:35:23  IST     0      2642         -    0.00    0.00    0.00    0.00     1  hist.sh
> > 10:35:23  IST     0         -      2642    0.00    0.00    0.00    0.00     1  |__hist.sh
> > #
> 
> That's correct and specified behaviour.
> 
> cpu1 has no sched domain (or the singleton domaon, which is the same)
> and thus its tasks will not be migrated.
> 

As I mentioned, If every run was the same, then it would have been good.
However if we increase the cpuset from 1-8 to 1-31 then we seen spreading
more often but not always.

./hist.sh
02:59:10  IST   UID      TGID       TID    %usr %system  %guest    %CPU   CPU  Command
02:59:10  IST     0      2244         -  100.00    0.13    0.00  100.00    30  ebizzy
02:59:10  IST     0         -      2244    0.00    0.02    0.00    0.02    30  |__ebizzy
02:59:10  IST     0         -      2246    4.37    0.00    0.00    4.37    21  |__ebizzy
02:59:10  IST     0         -      2247    2.14    0.00    0.00    2.14     8  |__ebizzy
02:59:10  IST     0         -      2248    3.13    0.00    0.00    3.13    28  |__ebizzy
02:59:10  IST     0         -      2249    5.57    0.00    0.00    5.57    18  |__ebizzy
02:59:10  IST     0         -      2250    4.29    0.00    0.00    4.29    11  |__ebizzy
02:59:10  IST     0         -      2251    5.32    0.00    0.00    5.32    19  |__ebizzy
02:59:10  IST     0         -      2252    5.62    0.00    0.00    5.62    17  |__ebizzy
02:59:11  IST   UID      TGID       TID    %usr %system  %guest    %CPU   CPU  Command
02:59:11  IST     0      2241         -    0.00    0.00    0.00    0.00    29  hist.sh
02:59:11  IST     0         -      2241    0.00    0.00    0.00    0.00    29  |__hist.sh


> If there is a problem, it is with cpuset and its interaction with
> isolcpus. I still have to look at the last version of cpuset-v2, but
> iirc that was better in this regard.

Okay.

-- 
Thanks and Regards
Srikar Dronamraju

