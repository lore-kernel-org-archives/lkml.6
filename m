Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA4EECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB6520684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HWET9PP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB6520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeGSVca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:32:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42696 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeGSVc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:32:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JKhlCx152834;
        Thu, 19 Jul 2018 20:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=hCbfYzHy2VPUGTIZDFyoI28Bb6i4Aj1f1ubmsNa0Ua0=;
 b=HWET9PP6sj3/2TwrFC4TjgqTSd0PwVuGf6BEi9dKZ0IecyWtIDLICk4GeOJEf/paF7c+
 Qqu4Iv2ofUkbiGXOmAOWiTll2mCQGnOm8bC5FY6EPhUVmIDOqrN4Y8VM4qQyIc0m0jKi
 CcTVVXIypqUirbmcZt8MPBn8g3eoDuyTkcqO6kzhA8A4bxTHOFES5WWyDEQ5ODie8UGj
 Ybrsm79PkyeaJSV6Qf9jwaMtg9XRjuv6t5KqqHZi3Iv+QkhD/1XbvCIaBymkqIlD/qi0
 Ofw76xkB0CftObbH4ZBpMK097QK0opKZ27WpaClK71aVqe7UhFQD+C+axEtsTh8Zd8jh CA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2k9ykc8u8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:46:47 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6JKkkjm015386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:46:46 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6JKkkGA029904;
        Thu, 19 Jul 2018 20:46:46 GMT
Received: from [192.168.1.10] (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 13:46:45 -0700
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, pbonzini@redhat.com
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-21-pasha.tatashin@oracle.com>
 <20180719103340.GA2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1807191300150.1602@nanos.tec.linutronix.de>
 <4295075b-8a0f-1723-2e80-1bbd2f038846@oracle.com>
 <alpine.DEB.2.21.1807191817080.1693@nanos.tec.linutronix.de>
 <CAGM2reYpApca9v-2qpVbTGXGVWiEEL5mkEWzTAvXFiztmtkh1Q@mail.gmail.com>
 <CAGM2rebBN0v0epfTssM=ShiWZ4GTDaN_cgGWdKE4+k+jV6CxyA@mail.gmail.com>
 <alpine.DEB.2.21.1807192240260.1693@nanos.tec.linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <ae3e5320-b389-e8af-2905-1ccc37953da3@oracle.com>
Date:   Thu, 19 Jul 2018 16:46:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807192240260.1693@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8959 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=941
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/19/2018 04:44 PM, Thomas Gleixner wrote:
> On Thu, 19 Jul 2018, Pavel Tatashin wrote:
> 
>> On Thu, Jul 19, 2018 at 12:49 PM Pavel Tatashin
>> <pasha.tatashin@oracle.com> wrote:
>>>
>>>> So create two functions. native_...early..() and native....(). The early
>>>> one does not contain the hpet/pmtimer stuff and it replaces the ops.pointer
>>>> with the late one which contains all of it.
>>>
>>> Good idea. Actually, the late one will contain only hpet/pmtimer and I
>>> will set it only if tsc frequency was not determined only.
>>
>> If we determined tsc early in boot using one of the quick methods:
>> from cpuid/msr/quick_pit, can we assume that frequencies of all other
>> CPUs will be determined the same way? Or do we still have to fallback
>> to PIT/HPET/PMTIMER? I wondering if we support heterogeneous
>> multi-socket platforms with different CPUs, because that the only
>> platforms where I see such scenario is possible.
> 
> The frequency for secondary CPUs is usually taken from the boot CPU and the
> only reason why recalibration can happen is when the CPU does not have a
> constant frequency TSC.
> 
> For that case the quick PIT + hpet/pmtimer calibration bundle is
> required. So yes, the early calibration might work with quick PIT (those
> CPUs definitely do not have MSR/CPUID based calibration), but the
> recalibration might fail the quick PIT calibration for various reasons.

OK, good, I implemented with this in-mind. I will send out a new series shortly.

Thank you,
Pavel

> 
> Thanks,
> 
> 	tglx
> 
