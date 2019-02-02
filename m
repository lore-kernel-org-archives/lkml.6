Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31825C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0377720870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SqSlHh+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfBBH4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 02:56:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59736 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfBBH4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 02:56:17 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x127s38p130686;
        Sat, 2 Feb 2019 07:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=eYwJld7D21KisTBpcpc6RiaWFNd6PlO5sI7o9AkKA2M=;
 b=SqSlHh+K+ZGDWc6Fg6qS6tYA3wKbQIMrTvbguY5d+VEepta3Z8f+3ktkpsNosGBx58n1
 DuwPJ2H4xLroUbCUZIRoWETn2/KDObgdYry0EO21CT6oPpKdp0U7hwQeIU8B9NPpW15U
 DIogmvOPkxYl0ayu8+wR0afvmzj5c/Uw3NjyLpnrYWlOWhsNrdvt5Fya9Pf9yOfjQMXU
 MzGB/+z7UU7d1iuRlRjglgeApxz7/bQvcXE/DOLKk/aklWkuJaD4yegcluDSzikcAOY0
 YEmPnGx3OvRsHgHPM3bZ5Ob++l8TJrmG9DbedL1JgMqOxNnx1Aaw/n+ufMagduarzWSV TQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qd2mu0byk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Feb 2019 07:56:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x127tvDi001587
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 2 Feb 2019 07:55:58 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x127tvt9032080;
        Sat, 2 Feb 2019 07:55:57 GMT
Received: from [10.154.174.82] (/10.154.174.82)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 02 Feb 2019 07:55:56 +0000
Subject: Re: [PATCH] acpi_pm: Reduce PMTMR counter read contention
To:     zhenzhong.duan@oracle.com, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
References: <1548141807-25825-1-git-send-email-zhenzhong.duan@oracle.com>
 <alpine.DEB.2.21.1901300903350.1950@nanos.tec.linutronix.de>
 <019e583c-7bcb-c234-200c-fcdb6c49fbb0@oracle.com>
 <alpine.DEB.2.21.1901311525360.8200@nanos.tec.linutronix.de>
 <853e8cf6-aba9-0200-8e39-e362848399ba@oracle.com>
From:   Kin Cho <kin.cho@oracle.com>
Message-ID: <b307e679-8a12-1eff-595d-2c39e6c6fb6a@oracle.com>
Date:   Fri, 1 Feb 2019 23:55:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <853e8cf6-aba9-0200-8e39-e362848399ba@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9154 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902020063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhenzhong,
The machine is running test this weekend, I'll try your simple fix next 
week.

All,
We're not aware of a specific customer need for acpi_pm/PMTMR,
but if we must keep acpi_pm/PMTMR in the kernel, let's fix it so it
actually works, even on machine like ours.
On our hardware currently it's broken both during clocksource selection
and as a permanent clocksource.

Thanks,

-kin

On 2/1/19 6:52 PM, Zhenzhong Duan wrote:
> On 2019/1/31 22:26, Thomas Gleixner wrote:
>> On Thu, 31 Jan 2019, Zhenzhong Duan wrote:
>>
>>> On 2019/1/30 16:06, Thomas Gleixner wrote:
>>>> On Tue, 22 Jan 2019, Zhenzhong Duan wrote:
>>>>
>>>>> On a large system with many CPUs, using PMTMR as the clock source can
>>>>> have a significant impact on the overall system performance because
>>>>> of the following reasons:
>>>>>    1) There is a single PMTMR counter shared by all the CPUs.
>>>>>    2) PMTMR counter reading is a very slow operation.
>>>>>
>>>>> Using PMTMR as the default clock source may happen when, for example,
>>>>> the TSC clock calibration exceeds the allowable tolerance and HPET
>>>>> disabled by nohpet on kernel command line. Sometimes the performance
>>>>
>>>> The question is why would anyone disable HPET on a larger machine 
>>>> when the
>>>> TSC is wreckaged?
>>>
>>> There may be broken hardware where TSC is wreckaged.
>>
>> I know that.
>>
>>>> I'm not against the change per se, but I really want to understand 
>>>> why we
>>>> need all the complexity for something which should never be used in 
>>>> a real
>>>> world deployment.
>>>
>>> Hmm, it's a strong word of "never be used". Customers may happen to use
>>> nohpet(sanity test?) and report bug to us. Sometimes they does 
>>> report a bug
>>> that reproduce with their customed config. There may also be BIOS 
>>> setting HPET
>>> disabled.
>>
>> And because the customer MAY do completely nonsensical things (and there
>> are a lot more than the HPET) the kernel has to handle all of them?
>
> Ok, then. I don't have more suggestion to convince you. I just think 
> of a simple fix as below. I think it will work for both hpet and 
> pmtmr. We will test it when the env is available.
>
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1353,6 +1353,7 @@ static int change_clocksource(void *data)
>
>         write_seqcount_end(&tk_core.seq);
>         raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
> +       tick_clock_notify();
>
>         return 0;
>  }
> @@ -1371,7 +1372,6 @@ int timekeeping_notify(struct clocksource *clock)
>         if (tk->tkr_mono.clock == clock)
>                 return 0;
>         stop_machine(change_clocksource, clock, NULL);
> -       tick_clock_notify();
>         return tk->tkr_mono.clock == clock ? 0 : -1;
>  }
>
>
> Thanks
> Zhenzhong

