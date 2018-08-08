Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3D9C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148B921A6D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148B921A6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeHIH5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:57:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728152AbeHIH5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:57:51 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w795YFXM027136
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 01:34:48 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kr9j8u465-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 01:34:47 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Thu, 9 Aug 2018 01:34:46 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 01:34:44 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w795YhTd6685026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 05:34:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31192B2068;
        Thu,  9 Aug 2018 01:34:06 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3058B205F;
        Thu,  9 Aug 2018 01:34:05 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.39])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  9 Aug 2018 01:34:05 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 4267C2E2DEB; Thu,  9 Aug 2018 11:04:40 +0530 (IST)
Date:   Wed, 8 Aug 2018 21:11:16 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org,
        ego@linux.vnet.ibm.com, huntbag@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 3/3] cpuidle/powernv: Conditionally save-restore sprs
 using opal
Reply-To: ego@linux.vnet.ibm.com
References: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
 <20180802045132.12432-4-akshay.adiga@linux.vnet.ibm.com>
 <20180803000547.08a37175@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803000547.08a37175@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18080905-0072-0000-0000-0000038DF09B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009511; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01071192; UDB=6.00551543; IPR=6.00850808;
 MB=3.00022602; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-09 05:34:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080905-0073-0000-0000-000049045481
Message-Id: <20180808154116.GA31919@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nicholas,

On Fri, Aug 03, 2018 at 12:05:47AM +1000, Nicholas Piggin wrote:
> On Thu,  2 Aug 2018 10:21:32 +0530
> Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:
> 
> > From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> > 
> > If a state has "opal-supported" compat flag in device-tree, an opal call
> > needs to be made during the entry and exit of the stop state. This patch
> > passes a hint to the power9_idle_stop and power9_offline_stop.
> > 
> > This patch moves the saving and restoring of sprs for P9 cpuidle
> > from kernel to opal. This patch still uses existing code to detect
> > first thread in core.
> > In an attempt to make the powernv idle code backward compatible,
> > and to some extent forward compatible, add support for pre-stop entry
> > and post-stop exit actions in OPAL. If a kernel knows about this
> > opal call, then just a firmware supporting newer hardware is required,
> > instead of waiting for kernel updates.
> 
> Still think we should make these do-everything calls. Including
> executing nap/stop instructions, restoring timebase, possibly even
> saving and restoring SLB (although a return code could be used to
> tell the kernel to do that maybe if performance advantage is
enough).

So, if we execute the stop instruction in opal, the wakeup from stop
still happens at the hypervisor 0x100. On wake up, we need to check
SRR1 to see if we have lost state, in which case, the stop exit also
needs to be handled inside opal. On return from this opal call, we
need to unwind the extra stack frame that would have been created when
kernel entered opal to execute the stop from which there was no
return. In the case where a lossy stop state was requested, but wakeup
happened from a lossless stop state, this adds additional overhead.

Furthermore, the measurements show that the additional time taken to
perform the restore of the resources in OPAL vs doing so in Kernel on
wakeup from stop takes additional 5-10us. For the current stop states
that lose hypervisor state, since the latency is relatively high (100s
of us), this is a relatively small penalty (~1%) .

However, in future if we do have states that lose only a part of
hypervisor state to provide a wakeup latency in the order of few tens
of microseconds the additional latency caused by OPAL call would
become noticable, no ?

	
> 
> I haven't had a lot of time to go through it, I'm working on moving
> ~all of idle_book3s.S to C code, I'd like to do that before this
> OPAL idle driver if possible.
> 
> A minor thing I just noticed, you don't have to allocate the opal
> spr save space in Linux, just do it all in OPAL.

The idea was to not leave any state in OPAL, as OPAL is supposed to be
state-less. However, I agree, that if OPAL is not going to interpret
the contents of the save/area, it should be harmless to move that bit
into OPAL.

That said, if we are going to add the logic of determining the first
thread in the core waking up, etc, then we have no choice but to
maintain that state in OPAL.


> 
> Thanks,
> Nick
> 
--
Thanks and Regards
gautham.

