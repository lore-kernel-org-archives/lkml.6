Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB037C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A7720652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A7720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJCAPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:15:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726772AbeJCAPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:15:00 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w92HUMQS070035
        for <linux-kernel@vger.kernel.org>; Tue, 2 Oct 2018 13:30:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mvbeq4gu0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 13:30:26 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Tue, 2 Oct 2018 18:30:11 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Oct 2018 18:30:08 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w92HU7TU31326366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Oct 2018 17:30:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C4B6AE059;
        Tue,  2 Oct 2018 20:29:00 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92D3DAE045;
        Tue,  2 Oct 2018 20:28:58 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.199.45.239])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  2 Oct 2018 20:28:58 +0100 (BST)
Date:   Tue, 2 Oct 2018 23:00:05 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm, numa: Migrate pages to local nodes quicker early
 in the lifetime of a task
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20181001100525.29789-1-mgorman@techsingularity.net>
 <20181001100525.29789-3-mgorman@techsingularity.net>
 <20181002124149.GB4593@linux.vnet.ibm.com>
 <20181002135459.GA7003@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181002135459.GA7003@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18100217-0016-0000-0000-0000020D6E4E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100217-0017-0000-0000-00003264ADE5
Message-Id: <20181002173005.GD4593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810020167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > This does have issues when using with workloads that access more shared faults
> > than private faults.
> > 
> 
> Not as such. It can have issues on workloads where memory is initialised
> by one thread, then additional threads are created and access the same
> memory. They are not necessarily shared once buffers are handed over. In
> such a case, migrating quickly is the right thing to do. If it's truely
> shared pages then there may be some unnecessary migrations early in the
> lifetime of the task but it'll settle down quickly enough.
> 

Do you have a workload recommendation to try for shared fault accesses.
I will try to get a DayTrader run in a day or two. There JVM and db threads
act on the same memory, I presume it might show some insights.

> Is it just numa01 that was affected for you? I ask because that particular
> workload is an averse workload on any machine with more than sockets and
> your machine description says it has 4 nodes. What it is testing is quite
> specific to 2-node machines.
> 

Agree, 

Some variations of numa01.sh where I have one process having threads equal
to number of cpus does regress but not as much as numa01.

./numa03.sh      Real:  484.84    555.51    518.59    22.91    -5.84277%
./numa03.sh      Sys:   44.41     64.40     53.24     6.65     -11.3824%
./numa03.sh      User:  51328.77  59429.39  55366.62  2744.39  -9.47912%


> > SPECJbb did show some small loss and gains.
> > 
> 
> That almost always shows small gains and losses so that's not too
> surprising.
> 

Okay.

> > Our numa grouping is not fast enough. It can take sometimes several
> > iterations before all the tasks belonging to the same group end up being
> > part of the group. With the current check we end up spreading memory faster
> > than we should hence hurting the chance of early consolidation.
> > 
> > Can we restrict to something like this?
> > 
> > if (p->numa_scan_seq >=MIN && p->numa_scan_seq <= MIN+4 &&
> >     (cpupid_match_pid(p, last_cpupid)))
> > 	return true;
> > 
> > meaning, we ran atleast MIN number of scans, and we find the task to be most likely
> > task using this page.
> > 
> 


> What's MIN? Assuming it's any type of delay, note that this will regress
> STREAM again because it's very sensitive to the starting state.
> 

I was thinking of MIN as 3 to give a chance for things to settle.
but that might not help STREAM as you pointed out.

Do you have a hint on which commit made STREAM regress?

if we want to prioritize STREAM like workloads (i.e private faults) one simpler
fix could be to change the quadtraic equation

from:
	if (!cpupid_pid_unset(last_cpupid) &&
				cpupid_to_nid(last_cpupid) != dst_nid)
		return false;
to:
	if (!cpupid_pid_unset(last_cpupid) &&
				cpupid_to_nid(last_cpupid) == dst_nid)
		return true;

i.e to say if the group tasks likely consolidated to a node or the task was
moved to a different node but access were private, just move the memory.

The drawback though is we keep pulling memory everytime the task moves
across nodes. (which is probably restricted for long running tasks to some
extent by your fix)

-- 
Thanks and Regards
Srikar Dronamraju

