Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32E6C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8107E2184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hy+NjvEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfAaDtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:49:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60368 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaDtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:49:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0V3hsJd118910;
        Thu, 31 Jan 2019 03:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ie+pi/8jCd0b5uAXDbtHCukN8QhnTVdmEXHAPFWDg8E=;
 b=Hy+NjvEemCPaiYyvXnuuShetgtq1VSgcmygnfSHq2lzKtCq6j/szgA1xAK7IClf0JswC
 Sq5JkYUFF3VR80FMb11aicyZFzJ11x4R8DBUaP9FxE8YGQKbiyDl5MNeQAmoEPf8MIEu
 tjtdU6XY7q7AEF0cErc9Yf4ir+vwG7tvB2PSA8Jq5lYqs7sxQKYcPf4T1RjCdJjJ22eK
 HdnaxEEaYhoOE9onb0zORWUJKt6lv9PxRsbmSr75RL0VhaIzppUSb44iVdslmpq87Nad
 erQ1ndrt9oj70qdqcGnunKQPhsaT0qQK9qyNLy59ni1wxh5jfoVBAoVzq1OuyBUfFHU3 cQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2q8eyup79e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 03:49:07 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0V3n6Go014224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 03:49:06 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0V3n6XU005162;
        Thu, 31 Jan 2019 03:49:06 GMT
Received: from [192.168.0.118] (/171.117.190.182)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Jan 2019 19:49:06 -0800
Reply-To: zhenzhong.duan@oracle.com
Subject: Re: [PATCH] acpi_pm: Reduce PMTMR counter read contention
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
References: <1548141807-25825-1-git-send-email-zhenzhong.duan@oracle.com>
 <alpine.DEB.2.21.1901300903350.1950@nanos.tec.linutronix.de>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <019e583c-7bcb-c234-200c-fcdb6c49fbb0@oracle.com>
Date:   Thu, 31 Jan 2019 11:50:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901300903350.1950@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9152 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901310028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/30 16:06, Thomas Gleixner wrote:
> On Tue, 22 Jan 2019, Zhenzhong Duan wrote:
> 
>> On a large system with many CPUs, using PMTMR as the clock source can
>> have a significant impact on the overall system performance because
>> of the following reasons:
>>   1) There is a single PMTMR counter shared by all the CPUs.
>>   2) PMTMR counter reading is a very slow operation.
>>
>> Using PMTMR as the default clock source may happen when, for example,
>> the TSC clock calibration exceeds the allowable tolerance and HPET
>> disabled by nohpet on kernel command line. Sometimes the performance
> 
> The question is why would anyone disable HPET on a larger machine when the
> TSC is wreckaged?

There may be broken hardware where TSC is wreckaged.
On our instances(X8-8/X7-8), TSC isn't wreckaged. Sometimes we are lucky 
to pass the bootup stage, then TSC is the final default clocksource. See 
log:
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[   13.963224] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 1911260446275000 ns
[   19.903175] clocksource: Switched to clocksource refined-jiffies
[   20.190467] clocksource: acpi_pm: mask: 0xffffff max_cycles: 
0xffffff, max_idle_ns: 2085701024 ns
[   20.201634] clocksource: Switched to clocksource acpi_pm
[   39.082577] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0x2113ba2fe3c, max_idle_ns: 440795266816 ns
[   39.138781] clocksource: Switched to clocksource tsc

When we are unlucky, logs:
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[   19.905741] clocksource: Switched to clocksource refined-jiffies
[   20.181521] clocksource: acpi_pm: mask: 0xffffff max_cycles: 
0xffffff, max_idle_ns: 2085701024 ns
[   44.273786] watchdog: BUG: soft lockup - CPU#48 stuck for 23s! 
[swapper/48:0]
[   44.279992] watchdog: BUG: soft lockup - CPU#49 stuck for 23s! 
[migration/49:307]

So we paniced when acpi_pm is initializing and is chosed as default 
clocksource temporarily, it paniced just because we add nohpet parameter.
> 
> I'm not against the change per se, but I really want to understand why we
> need all the complexity for something which should never be used in a real
> world deployment.

Hmm, it's a strong word of "never be used". Customers may happen to use 
nohpet(sanity test?) and report bug to us. Sometimes they does report a 
bug that reproduce with their customed config. There may also be BIOS 
setting HPET disabled.

Thanks
Zhenzhong
