Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A9AC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07152084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07152084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbeGSHaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:30:12 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:37169 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727743AbeGSHaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:30:11 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42408349"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Jul 2018 14:48:35 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 2D9614B69D90;
        Thu, 19 Jul 2018 14:48:32 +0800 (CST)
Received: from localhost.localdomain (10.167.226.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Thu, 19 Jul 2018 14:48:34 +0800
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        <steven.sistare@oracle.com>, <daniel.m.jordan@oracle.com>,
        <linux@armlinux.org.uk>, <schwidefsky@de.ibm.com>,
        <heiko.carstens@de.ibm.com>, <john.stultz@linaro.org>,
        <sboyd@codeaurora.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <hpa@zytor.com>, <peterz@infradead.org>, <prarit@redhat.com>,
        <feng.tang@intel.com>, <pmladek@suse.com>,
        <gnomes@lxorguk.ukuu.org.uk>, <linux-s390@vger.kernel.org>,
        <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <pbonzini@redhat.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-21-pasha.tatashin@oracle.com>
 <4f0933a3-27b4-5468-83f5-af9b90842812@cn.fujitsu.com>
 <alpine.DEB.2.21.1807190818110.1689@nanos.tec.linutronix.de>
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <82b363bb-de81-0ddf-cb0d-83945eba72f0@cn.fujitsu.com>
Date:   Thu, 19 Jul 2018 14:48:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807190818110.1689@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 2D9614B69D90.AC364
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

At 07/19/2018 02:25 PM, Thomas Gleixner wrote:
> On Thu, 19 Jul 2018, Dou Liyang wrote:
>> At 07/18/2018 10:22 AM, Pavel Tatashin wrote:
>>> +		(unsigned long)cpu_khz % KHZ);
>>>      	if (cpu_khz != tsc_khz) {
>>>    		pr_info("Detected %lu.%03lu MHz TSC",
>>> -			(unsigned long)tsc_khz / 1000,
>>> -			(unsigned long)tsc_khz % 1000);
>>> +			(unsigned long)tsc_khz / KHZ,
>>> +			(unsigned long)tsc_khz % KHZ);
>>> +	}
>>
>> this curly brackets can be removed
> 
> No. They want to stay, really.
> 
>      https://lkml.kernel.org/r/alpine.DEB.2.20.1701171956290.3645@nanos
> 
> The pr_info() is a multiline statement due to the line breaks.
> 

I see, I¡¯ll keep that in mind.

Thanks,

	dou


