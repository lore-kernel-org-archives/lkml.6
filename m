Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65147C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFFD24D3A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RbKVJhF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFFD24D3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeFWVjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 17:39:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35758 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeFWVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 17:39:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5NKkTK8168889;
        Sat, 23 Jun 2018 21:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=9aoRzr6dnDZJ1AwQvvbtyTPpOvubfIpqEEpOoyFmbq4=;
 b=RbKVJhF/Oqo0QtJkByJVlQIhwUax7eqgDLbDWxQiHlkzTDR7EWMhlIk51aPhFhFPw1Q6
 k4bypLetTf7l0FtVJF1pdG1rLQwv6q8u82Sy1jmCOgSbJwrXP7Fd7NVPwrOR+CglxY0z
 f5aIcOeVVx9f1qGri1iiDd5hQ3hikNgOo7XecEklWaX2SUTFta7nM4K/MGb8+DagcDGu
 agFGKmBVayrEm8aSe0U879Lb9ZHFWjxktGsTdnkeMRFeIT51Z5EzOmzi51QVBl95DiRX
 l4p5/CzMJuhrO01DPKLkDDgx+Ihe9gpvg4Hbmh6LwxAfUUVqskHVsMK85/XStKtzW+Wj vg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2jsfg0rvme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jun 2018 21:38:58 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5NLcuj0002054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jun 2018 21:38:56 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5NLcsH5017309;
        Sat, 23 Jun 2018 21:38:54 GMT
Received: from [10.39.237.95] (/10.39.237.95)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 23 Jun 2018 14:38:54 -0700
Subject: Re: [PATCH v12 11/11] x86/tsc: use tsc early
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
 <20180621212518.19914-12-pasha.tatashin@oracle.com>
 <alpine.DEB.2.21.1806231850430.8650@nanos.tec.linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <640e2de9-22e3-24bd-4987-5b02344aa727@oracle.com>
Date:   Sat, 23 Jun 2018 17:38:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806231850430.8650@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8933 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806230241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23/2018 12:56 PM, Thomas Gleixner wrote:
> On Thu, 21 Jun 2018, Pavel Tatashin wrote:
>>  /*
>>   * Scheduler clock - returns current time in nanosec units.
>>   */
>> @@ -1354,6 +1364,7 @@ void __init tsc_early_delay_calibrate(void)
>>  	lpj = tsc_khz * 1000;
>>  	do_div(lpj, HZ);
>>  	loops_per_jiffy = lpj;
>> +	sched_clock_early_init(tsc_khz);
>>  }
>>  
>>  void __init tsc_init(void)
>> @@ -1382,6 +1393,7 @@ void __init tsc_init(void)
>>  	if (!tsc_khz) {
>>  		mark_tsc_unstable("could not calculate TSC khz");
>>  		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
>> +		static_branch_disable(&__use_tsc);
> 
> This wants a proper comment.

Yes, I will add a comment. Basically, this change is for a rare scenario where early in boot we were able to get TSC frequency but failed to do so later in boot when we tried to calculate it more precisely. Though, I am not sure if this is actually possible. However, if this is indeed possible, we will get into the same continuity problem as the one that is solved in "x86/tsc: prepare for early sched_clock". So, I guess we would have to modify either "jiffies_64" or  __sched_clock_offset if we want to take care of this corner case.

Thank you,
Pavel

