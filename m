Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50FBC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9417F2148D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sJUHo+KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfBBCvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 21:51:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50384 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfBBCvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 21:51:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x122oMcc118355;
        Sat, 2 Feb 2019 02:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5SyRWrX99SQGWL9Dm9iSP84Xge+Qfg3ORLwR4lyHxiM=;
 b=sJUHo+KOOtb1+v2oDeLsneFBGcIUyDQ8ZLDNRz1DGTtVzMW81VlL9+Ke8AGp+/UAWdwm
 maFiva4O+VSrd7NN9IYd0lpP78Czlj+UvC/N8qmX/QhTj8d+CdpLtyq+Sou+b/HxD56A
 rUCmM/L/jGXizBG3s8csm6t4NmvWxL+Cw+OV/0WAHLde/BIntW/sB05q7kUxY5FPsKgo
 YGNhRpaZv91S+mACldMGNgXEqIm9Nbikhz8YFzE5YwoPaTidpsHKdb4485QseuzdfGja
 bjWjDOi69kJm5MUpc6Q4jwo1JcI/+tZAgZSPUsak/1JQlIZ4qHPmELdqOfE1x57kuatV 5g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2q8g6rsjj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Feb 2019 02:51:01 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x122p09R031673
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 2 Feb 2019 02:51:00 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x122p0qf006426;
        Sat, 2 Feb 2019 02:51:00 GMT
Received: from [10.191.0.151] (/10.191.0.151)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Feb 2019 18:50:59 -0800
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
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <853e8cf6-aba9-0200-8e39-e362848399ba@oracle.com>
Date:   Sat, 2 Feb 2019 10:52:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901311525360.8200@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9154 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902020019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/31 22:26, Thomas Gleixner wrote:
> On Thu, 31 Jan 2019, Zhenzhong Duan wrote:
> 
>> On 2019/1/30 16:06, Thomas Gleixner wrote:
>>> On Tue, 22 Jan 2019, Zhenzhong Duan wrote:
>>>
>>>> On a large system with many CPUs, using PMTMR as the clock source can
>>>> have a significant impact on the overall system performance because
>>>> of the following reasons:
>>>>    1) There is a single PMTMR counter shared by all the CPUs.
>>>>    2) PMTMR counter reading is a very slow operation.
>>>>
>>>> Using PMTMR as the default clock source may happen when, for example,
>>>> the TSC clock calibration exceeds the allowable tolerance and HPET
>>>> disabled by nohpet on kernel command line. Sometimes the performance
>>>
>>> The question is why would anyone disable HPET on a larger machine when the
>>> TSC is wreckaged?
>>
>> There may be broken hardware where TSC is wreckaged.
> 
> I know that.
> 
>>> I'm not against the change per se, but I really want to understand why we
>>> need all the complexity for something which should never be used in a real
>>> world deployment.
>>
>> Hmm, it's a strong word of "never be used". Customers may happen to use
>> nohpet(sanity test?) and report bug to us. Sometimes they does report a bug
>> that reproduce with their customed config. There may also be BIOS setting HPET
>> disabled.
> 
> And because the customer MAY do completely nonsensical things (and there
> are a lot more than the HPET) the kernel has to handle all of them?

Ok, then. I don't have more suggestion to convince you. I just think of 
a simple fix as below. I think it will work for both hpet and pmtmr. We 
will test it when the env is available.

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1353,6 +1353,7 @@ static int change_clocksource(void *data)

         write_seqcount_end(&tk_core.seq);
         raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+       tick_clock_notify();

         return 0;
  }
@@ -1371,7 +1372,6 @@ int timekeeping_notify(struct clocksource *clock)
         if (tk->tkr_mono.clock == clock)
                 return 0;
         stop_machine(change_clocksource, clock, NULL);
-       tick_clock_notify();
         return tk->tkr_mono.clock == clock ? 0 : -1;
  }


Thanks
Zhenzhong
