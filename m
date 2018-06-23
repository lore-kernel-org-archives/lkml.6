Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3216CC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C4024CD0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YzDM8K2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C4024CD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeFWSuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 14:50:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36610 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbeFWSuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 14:50:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5NIelHH170975;
        Sat, 23 Jun 2018 18:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=snvynx3bprYARk9l5Uy99cZP02+YASDQ3/GsegssAjE=;
 b=YzDM8K2gNzAyEnVag9BhK2aEAgimSTTzyPhl3M7w/7K+SObqShYWocBH7XTZwLSegupb
 nseU1fIACIK5OPpsDOGAeVtmV/oDU2gPc9tkr2nRA4sZ3quJsfMeISs/VrVt5XqpVc3j
 V+LSQkl4QUkpp95+5+0XRg8K49VmXgK4ppnUdGkXOLmDHTy0ZtmVd9Gzlg7suZC9hqdQ
 cIVKEpQDe7LZkb5rW4/l1mizQMa2gc/DHT9wASXt/WUOBlv80GAtUJNfp/W8dEs5UU5f
 OBkARzUwkH1QP3SABbsqi0CYKn8HGiGATVwig7WfAUCRgWBBpJ/NH9GYjiinny/WSSqa 8w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jsfg0rs0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jun 2018 18:49:50 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5NInnEv014422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jun 2018 18:49:49 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5NInhZ1024082;
        Sat, 23 Jun 2018 18:49:43 GMT
Received: from [10.39.237.95] (/10.39.237.95)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 23 Jun 2018 11:49:43 -0700
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-10-pasha.tatashin@oracle.com>
 <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <cafa3d94-075c-d9ed-048c-37a9b2494154@oracle.com>
Date:   Sat, 23 Jun 2018 14:49:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8932 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806230220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me give you an example:
> 
>   When tsc_init() enables the usage of TSC for sched_clock() the
>   initialization of the tsc sched clock conversion data starts from zero
>   and not from the current jiffies based sched_clock() value. This makes
>   the timestamps jump backwards:
> 
>   [    0.010000] tsc: Detected 3192.137 MHz processor
>   [    0.011000] clocksource: tsc-early: mask:  ... 
>   [    0.002233] Calibrating delay loop (skipped), ....
> 
>   To address this, extend set_cyc2ns_scale() with an argument to base the
>   cyc2ns offset on the current sched_clock() value. During run time this
>   offset is 0 as the cyc2ns offset is based on the TSC sched_clock()
>   itself.
> 
> See? Precise and pure technical. No we/us/would/ and no irrelevant
> information.

Yes, thank you Thomas. I will update the changelog based on your suggestions, and no longer will impersonating my commit comments.

> 
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>> ---
>>  arch/x86/kernel/tsc.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
>> index 186395041725..654a01cc0358 100644
>> --- a/arch/x86/kernel/tsc.c
>> +++ b/arch/x86/kernel/tsc.c
>> @@ -133,7 +133,9 @@ static inline unsigned long long cycles_2_ns(unsigned long long cyc)
>>  	return ns;
>>  }
>>  
>> -static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
>> +static void set_cyc2ns_scale(unsigned long khz, int cpu,
>> +			     unsigned long long tsc_now,
>> +			     unsigned long long sched_now)
> 
> sched_now is not a real good name for this as it's only used at
> initialization time. So the argument name should reflect this otherwise you
> wonder yourself when looking at that code 6 month from now, why it's 0 on
> all the run time call sites. init_offset or some other sensible name which
> makes the purpose entirely clear.
> 
>>  void __init tsc_init(void)
>>  {
>> -	u64 lpj, cyc;
>> +	u64 lpj, cyc, sch;
> 
> sch? what's wrong with sched_now or now? It's not that there is a 3 letter
> limit.

Sometimes I get caught into following the local style too much:

void __init tsc_init(void)
{
u64 lpj, cyc;
int cpu;

Hm, all the above are 3-letter variables, lets add another 3 letter one :)

I will change it to init_offset as you suggested above for set_cyc2ns_scale().

Also, I will address all the other comments that you provided in this series.

Thank you,
Pavel
