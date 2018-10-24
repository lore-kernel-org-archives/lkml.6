Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87696C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8B52082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8B52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeJXSOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:14:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbeJXSOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:14:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9O9in1u123435
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 05:46:58 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nak642uwh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 05:46:57 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 24 Oct 2018 10:46:54 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Oct 2018 10:46:49 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9O9kmLA4325860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Oct 2018 09:46:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACE7952052;
        Wed, 24 Oct 2018 09:46:48 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id CDBDC52057;
        Wed, 24 Oct 2018 09:46:46 +0000 (GMT)
Date:   Wed, 24 Oct 2018 15:16:46 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Yi Wang <wang.yi59@zte.com.cn>, zhong.weidong@zte.com.cn,
        Yi Liu <liu.yi24@zte.com.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched/core: Don't mix isolcpus and housekeeping CPUs
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1540350169-18581-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20181024085636.GB23537@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181024085636.GB23537@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18102409-0028-0000-0000-0000030C6167
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102409-0029-0000-0000-000023C86E2E
Message-Id: <20181024094646.GA18466@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810240087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2018-10-24 09:56:36]:

> On Wed, Oct 24, 2018 at 08:32:49AM +0530, Srikar Dronamraju wrote:
> It would certainly be a bit odd because the
> application is asking for some protection but no guarantees are given
> and the application is not made aware via an error code that there is a
> problem. Asking the application to parse dmesg hoping to find the right
> error message is going to be fragile.

Its a actually a good question.
What should we be doing if a mix of isolcpus and housekeeping (aka
non-isolcpus) is given in the mask.

Right now as you pointed, there is no easy way for the application to know
which are the non-isolcpus to set its affinity. cpusets effective_cpus and
cpus_allowed both will contain isolcpus too.

> Would it be more appropriate to fail sched_setaffinity when there is a
> mix of isolated and housekeeping CPUs? In that case, an info message in
> dmesg may be appropriate as it'll likely be a once-off configuration
> error that's obvious due to an application failure.

I was looking at option of returning an error in that case. However our
own perf bench numa cant handle it. We can be sure that there will other
tools who could have coded that way and may start failing. So I am not sure
if thats a good option. Previously they would *seem* to be working.

Thats why I have taken an option of correcting within the kernel.

> Alternatively,
> should NUMA balancing ignore isolated CPUs? The latter seems unusual as
> the application has specified a mask that allows those CPUs and it's not
> clear why NUMA balancing should ignore them. If anything, an application
> that wants to avoid all interference should also be using memory policies
> to bind to nodes so it behaves predictably with respect to access latencies
> (presumably if an application cannot tolerate kernel threads interfering
> then it also cannot tolerate remote access latencies) or disabling NUMA
> balancing entirely to avoid incurring minor faults.
> 

The numa balancing is doing the right thing because if the application has
the mask specified, then we should allow the application to run.

The problem happens when the unbound application starts to run on the isolcpu,
regular load balancing will no more work. If another task is bound on the
isolcpu, and other cpus in the node are free, this task will still contend
with task bound to the isolcpus. (Unless numa affinity of the unbound thread
changes).

Also isocpus are suppose to run only those tasks that are bound to it.
So we are kind of breaking that rule.

-- 
Thanks and Regards
Srikar Dronamraju

