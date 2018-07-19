Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCED8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E5E2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rt00k9Kw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E5E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbeGSQnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:43:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36378 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731839AbeGSQnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:43:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JFsHil127388;
        Thu, 19 Jul 2018 15:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=sHXO+eiLtn+rzspQduVDWvXcu5kSWyuk5LS1+cPO4rs=;
 b=Rt00k9KwHS7MmwGh5m7Njw4G+UkIUcnZXeruYavX9ksh/S2a5DFF7KZlKuvWI4KFG2f+
 VQaE5tdYSXrD5LmuU7OCaU9CbObub1JWMxSnVUNC0I8A2RAXH3FnQbuDe4kCEMnCu6yw
 2mJriYs4PF9IIO7VORi0wy3Hbf3Do2whM85GRissM7VaDPuLsrEVzU7ULPOpXuQDna9t
 BWwEjazbJuz3eEdJ1omsnkOmHhb72hcrHn6KOX+fDgZaE+ci8rlMD8CVJns0eQVhwjDf
 3x5+3oBJfKtPFrY0JuLa66JhIxn5+F4S9m2G/HexceJEHII3cPJqqluw8ZwRIThtDYLZ HA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2k9ykc7suq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 15:58:48 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6JFwl1X014122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 15:58:48 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6JFwiQt004431;
        Thu, 19 Jul 2018 15:58:44 GMT
Received: from [192.168.1.10] (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 15:58:43 +0000
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-21-pasha.tatashin@oracle.com>
 <20180719103340.GA2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1807191300150.1602@nanos.tec.linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <4295075b-8a0f-1723-2e80-1bbd2f038846@oracle.com>
Date:   Thu, 19 Jul 2018 11:58:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807191300150.1602@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8958 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/19/2018 07:01 AM, Thomas Gleixner wrote:
> On Thu, 19 Jul 2018, Peter Zijlstra wrote:
>> On Tue, Jul 17, 2018 at 10:22:06PM -0400, Pavel Tatashin wrote:
>>> During boot tsc is calibrated twice: once in tsc_early_delay_calibrate(),
>>> and the second time in tsc_init().
>>>
>>> Rename tsc_early_delay_calibrate() to tsc_early_init(), and rework it so
>>> the calibration is done only early, and make tsc_init() to use the values
>>> already determined in tsc_early_init().
>>>
>>> Sometimes it is not possible to determine tsc early, as the subsystem that
>>> is required is not yet initialized, in such case try again later in
>>> tsc_init().
>>
>> It might be nice to preserve some of the information tglx dug out during
>> review of all this. Like the various methods of calibrate_*() and their
>> dependencies.
>>
>> And I note that this patch relies on the magic of native_calibrate_cpu()
>> working really early and not exploding in the quick calibration run.
>> This either wants fixing or documenting.
>>
>> I think the initial idea was to only do the fast_calibrate (cpuid, msr
>> and possibly the quick_pit) things early and delay the HPET/PMTIMER
>> magic until later.
> 
> Yes. I really would prefer to have this as an explicit expressed mechanism
> rather than relying on magic variables not being initialized.

What is the best way to achieve this?

I did the following:

1367 static bool __init determine_cpu_tsc_frequencies(bool early)
1368 {
1369         /* Make sure that cpu and tsc are not already calibrated */
1370         WARN_ON(cpu_khz || tsc_khz);
1371                    
1372         if (early) {
1373                 cpu_khz = x86_platform.calibrate_cpu();
1374                 tsc_khz = x86_platform.calibrate_tsc();
1375         } else {
1376                 cpu_khz = hpet_pmtime_calibrate_cpu();
1377         }

 833 /**
 834  * native_calibrate_cpu - calibrate the cpu on boot
 835  */
 836 unsigned long native_calibrate_cpu(void)
 837 {
 838         unsigned long flags, fast_calibrate;
 839 
 840         fast_calibrate = cpu_khz_from_cpuid();
 841         if (fast_calibrate)
 842                 return fast_calibrate;
 843 
 844         fast_calibrate = cpu_khz_from_msr();
 845         if (fast_calibrate)
 846                 return fast_calibrate;
 847 
 848         local_irq_save(flags);
 849         fast_calibrate = quick_pit_calibrate();
 850         local_irq_restore(flags);
 851         if (fast_calibrate)
 852                 return fast_calibrate;
 853 
 854         return hpet_pmtime_calibrate_cpu();
 855 }


And hpet_pmtime_calibrate_cpu() contains all the hpet/pmtime stuff.

However, when cpu_khz = x86_platform.calibrate_cpu() is called the first time, we still call hpet_pmtime_calibrate_cpu() from native_calibrate_cpu(). We cannot simply split native_calibrate_cpu() into two independent functions because it is also called from recalibrate_cpu_khz().

So, the question is how to enforce that the first time we do not call hpet/pmtime?

1. Use a new global variable? Kind of ugly.
2. Use system_state == SYSTEM_BOOTING ? Ugly, and probably not very safe.

Any other suggestion?

Thank you,
Pavel
