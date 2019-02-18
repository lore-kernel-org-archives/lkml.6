Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29604206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u3E9+YOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfBRDsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:48:45 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33568 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfBRDso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 22:48:44 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1I3i9bj144705;
        Mon, 18 Feb 2019 03:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=oVScqPJ3Zij7bvX89910UvrBpF5sFfs79BfFYV+drFk=;
 b=u3E9+YOl220xa2OWxaIV3oAquxaxH/n6fiD3ToDhgs27BMIFqN7uF98C347VsnuL9Li5
 mXdPM+qFZFlojWkR7pJdYhqojrnEzFeuhMWX8LOp/PDw3B7O5CZsSHPdxyYBmfRd1wrW
 R9Xqo0Qoz7RhoKx+ME3dMR6oNoMMBY0cqX1dW41ZgFoogHjvGucd4fxiZLuPtIkGUkfN
 3s8ay5ApwhwBLgs5kskbyqQ13UGJ9RqueMaT858xL7Wockfm2q9pFeYMpZAQnhl3GNTY
 JYki8Ex2uQORq8gkj/S+o5OTTwkCjglmytoThTuoESW9V1SO0O6Zvjk4GQjXugJXYjTg zg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qp81dv5ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 03:48:30 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1I3mUGP002944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 03:48:30 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1I3mTbt013623;
        Mon, 18 Feb 2019 03:48:30 GMT
Received: from [192.168.1.166] (/60.223.138.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 17 Feb 2019 19:48:29 -0800
Reply-To: zhenzhong.duan@oracle.com
Subject: Re: [PATCH] acpi_pm: Reduce PMTMR counter read contention
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>, kin.cho@oracle.com
References: <1548141807-25825-1-git-send-email-zhenzhong.duan@oracle.com>
 <alpine.DEB.2.21.1901300903350.1950@nanos.tec.linutronix.de>
 <019e583c-7bcb-c234-200c-fcdb6c49fbb0@oracle.com>
 <alpine.DEB.2.21.1901311525360.8200@nanos.tec.linutronix.de>
 <853e8cf6-aba9-0200-8e39-e362848399ba@oracle.com>
 <alpine.DEB.2.21.1902102159070.8784@nanos.tec.linutronix.de>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <8ffea578-5eb6-f479-7bd4-668df84d930f@oracle.com>
Date:   Mon, 18 Feb 2019 11:48:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902102159070.8784@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902180027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/11 5:08, Thomas Gleixner wrote:
> On Sat, 2 Feb 2019, Zhenzhong Duan wrote:
>> On 2019/1/31 22:26, Thomas Gleixner wrote:
> 
>>>>> I'm not against the change per se, but I really want to understand
>>>>> why we need all the complexity for something which should never be
>>>>> used in a real world deployment.
>>>>>
>>>> Hmm, it's a strong word of "never be used". Customers may happen to
>>>> use nohpet(sanity test?) and report bug to us. Sometimes they does
>>>> report a bug that reproduce with their customed config. There may
>>>> also be BIOS setting HPET disabled.
>>>
>>> And because the customer MAY do completely nonsensical things (and there
>>> are a lot more than the HPET) the kernel has to handle all of them?
>>
>> Ok, then. I don't have more suggestion to convince you.
> 
> You give up too fast :)

Ah, because I thought of a simple fix.
> 
> The point is, that we really want proper justifications for changes like
> this. Some 'may, could and more handwaving' simply does not cut it.
> 
> So if you can just describe a realistic scenario, which does not involve
> thoughtless flipping of BIOS options, then this becomes way more palatable.

I indeed don't see a realistic scenario in a product env needing to use 
nohpet. My only justification is now that we have nohpet as kernel 
parameter, we should fix the softlockup in large machines for enterprise 
use.
> 
>> I just think of a simple fix as below. I think it will work for both hpet
>> and pmtmr. We will test it when the env is available.
> 
>> --- a/kernel/time/timekeeping.c
>> +++ b/kernel/time/timekeeping.c
>> @@ -1353,6 +1353,7 @@ static int change_clocksource(void *data)
>>
>>          write_seqcount_end(&tk_core.seq);
>>          raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
>> +       tick_clock_notify();
>>
>>          return 0;
>>   }
>> @@ -1371,7 +1372,6 @@ int timekeeping_notify(struct clocksource *clock)
>>          if (tk->tkr_mono.clock == clock)
>>                  return 0;
>>          stop_machine(change_clocksource, clock, NULL);
>> -       tick_clock_notify();
>>          return tk->tkr_mono.clock == clock ? 0 : -1;
>>   }
> 
> This won't resolve the concurrency issues of HPET or PMTIMER in any
> way.

Just got chance to test and Kin confirmed it fix the softlockup of 
PMTMR(with nohpet) and HPET(without nohpet, revert previous hpet commit) 
at bootup stage.

My understandig is, at bootup stage tick device is firstly initialized 
in periodic mode and then switch to one-shot mode. In periodic mode 
clock event interrupt is triggered every 1ms(HZ=1000), contention in 
HPET or PMTIMER exceeds 1ms and delayed the clock interrupt. Then CPUs 
continue to process interrupt one by one without a break, 
tick_clock_notify() have no chance to be called and we never switch to 
one-shot mode.

In one-shot mode, the contention is still there but next event is always 
set with a future value. We may missed some ticks, but the timer code is 
smart enough to pick up those missed ticks.

By moving tick_clock_notify() in stop_machine, kernel changes to 
one-shot mode early before the contention accumulate and lockup system.

> Instead it breaks the careful orchestrated mechanism of clocksource
> change.

Sorry, I didn't get a idea how it breaks, tick_clock_notify() is a 
simple function setting bitmask in percpu variable. Could you explain a bit?

Thanks
Zhenzhong
