Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32146C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0331B208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0331B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389515AbeKPUHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:07:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727442AbeKPUHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:07:49 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAG9sGcE104278
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 04:56:13 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nssgtdr3b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 04:56:12 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 16 Nov 2018 09:56:10 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 16 Nov 2018 09:56:07 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAG9u5u55898538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Nov 2018 09:56:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5744AE053;
        Fri, 16 Nov 2018 09:56:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C6BFAE045;
        Fri, 16 Nov 2018 09:56:03 +0000 (GMT)
Received: from [9.124.35.46] (unknown [9.124.35.46])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Nov 2018 09:56:03 +0000 (GMT)
Subject: Re: [PATCH] Powerpc/perf: Wire up PMI throttling
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        paulus@samba.org, ebiederm@xmission.com, muriloo@linux.ibm.com,
        christophe.leroy@c-s.fr, npiggin@gmail.com, leitao@debian.org,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20181114141425.1892-1-ravi.bangoria@linux.ibm.com>
 <8736s2v7d0.fsf@concordia.ellerman.id.au>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Fri, 16 Nov 2018 15:26:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <8736s2v7d0.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18111609-0016-0000-0000-00000227E180
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111609-0017-0000-0000-000032800A12
Message-Id: <90eaac98-4c9a-566d-734a-f435b0f20603@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/18 6:13 PM, Michael Ellerman wrote:
> Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:
> 
>> Commit 14c63f17b1fde ("perf: Drop sample rate when sampling is too
>> slow") introduced a way to throttle PMU interrupts if we're spending
>> too much time just processing those. Wire up powerpc PMI handler to
>> use this infrastructure.
> 
> To be clear we have throttling of the *rate* of interrupts, but this
> adds throttling based on the *time taken* to process the interrupts. Or
> at least that's my understanding?

Right. This throttles based on time taken to process the interrupts.

> 
>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>> index 9a86572db1ef..44f85fa22356 100644
>> --- a/arch/powerpc/kernel/traps.c
>> +++ b/arch/powerpc/kernel/traps.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/errno.h>
>>  #include <linux/sched.h>
>>  #include <linux/sched/debug.h>
>> +#include <linux/sched/clock.h>
>>  #include <linux/kernel.h>
>>  #include <linux/mm.h>
>>  #include <linux/pkeys.h>
>> @@ -1803,9 +1804,12 @@ void vsx_unavailable_tm(struct pt_regs *regs)
>>  
>>  void performance_monitor_exception(struct pt_regs *regs)
>>  {
>> +	u64 start_clock;
>>  	__this_cpu_inc(irq_stat.pmu_irqs);
>>  
>> +	start_clock = sched_clock();
>>  	perf_irq(regs);
>> +	perf_sample_event_took(sched_clock() - start_clock);
>>  }
> 
> Despite the name, perf_irq() may not actually be the perf IRQ handler :)
> 
> It's a function pointer which might call perf or might call oprofile, or
> a dummy handler.
> 
> I don't think we should be calling perf_sample_event_took() if we're not
> actually using perf, that is wasteful at best.
> 
> So the timing logic should go in the perf specific handler I think.
> ie. perf_event_interrupt().

Makes sense. I'll re-send with that change.

Thanks,
Ravi

