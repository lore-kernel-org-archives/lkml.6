Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E932ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E37208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E37208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeGPJ7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:59:01 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18181 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726305AbeGPJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:59:00 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42282714"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Jul 2018 17:32:26 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id C1E724B66B65;
        Mon, 16 Jul 2018 17:32:22 +0800 (CST)
Received: from localhost.localdomain (10.167.226.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Mon, 16 Jul 2018 17:32:23 +0800
Subject: Re: [PATCH v13 13/18] x86/tsc: calibrate tsc only once
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
CC:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux@armlinux.org.uk>, <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, <sboyd@codeaurora.org>,
        <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>, <hpa@zytor.com>,
        <peterz@infradead.org>, <prarit@redhat.com>, <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>, <gnomes@lxorguk.ukuu.org.uk>,
        <linux-s390@vger.kernel.org>, <boris.ostrovsky@oracle.com>,
        <jgross@suse.com>
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-14-pasha.tatashin@oracle.com>
 <928b8490-89d2-46a3-8596-16751bcd12db@cn.fujitsu.com>
 <CAGM2reb-MwiT8qoiSkXCjAAM46JOYL9BP+U3q7PMTcxp9EiK7w@mail.gmail.com>
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <01812492-b88b-4436-570b-ef776eaafc6a@cn.fujitsu.com>
Date:   Mon, 16 Jul 2018 17:32:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGM2reb-MwiT8qoiSkXCjAAM46JOYL9BP+U3q7PMTcxp9EiK7w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: C1E724B66B65.ABE64
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



At 07/13/2018 07:30 PM, Pavel Tatashin wrote:
> On Fri, Jul 13, 2018 at 3:24 AM Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>>
>>
>> At 07/12/2018 08:04 AM, Pavel Tatashin wrote:
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
>>>
>>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>>
>> Hi Pavel,
>>
>> Aha, a complex solution for a simple problem! ;-) And I did find any
>> benefits of doing that. did I miss something?
> 
> Hi Dou,
> 
> I had this in previous version:  init early, and unconditionally
> re-init later (which required to resync sched clocks for continuity,
> and check for some other corner cases). Thomas did not like the idea,
> as it is less deterministic: it leads for code to work by accident,
> where we might get one tsc frequency early and another later, and so
> on. The request was to initialize only once, and if that fails do it
> again later. This way, if early initialization is broken, we will know
> and fix it.
> 

Hi Pavel,

Yes, right, I have seen the purpose in v12.

>>
>> As the cpu_khz and tsc_khz are global variables and the tsc_khz may
>> be reset to cpu_khz. How about the following patch.
> 
> Could you please explain where you think this patch can be applied,
> and what it fixes?
> 

This patch is just an simple alternative to realize what you want in
your patch. your patch is also good but complex, and need some scrub.
eg:
   - Is it suitable to using the WARN_ON()
   - the name of determine_cpu_tsc_frequncies() function,
    s/frequncies/frequencies/. BTW, How about tsc_calibrate_frequencies()
   - ...

BTW, before this patch, seems we need make sure xen should work well, I
can investigate and try to test if we can also move the pagetable_init()
to the front of tsc_early_init() for you.

Thanks,
	dou

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index da1dbd99cb6e..74cb16d89e25 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1197,12 +1197,12 @@ void __init setup_arch(char **cmdline_p)

         memblock_find_dma_reserve();

+       x86_init.paging.pagetable_init();
+
         tsc_early_delay_calibrate();
         if (!early_xdbc_setup_hardware())
                 early_xdbc_register_console();

-       x86_init.paging.pagetable_init();
-
         kasan_init();

         /*

> Thank you,
> Pavel
> 
>>
>> Thanks,
>>          dou
>> ------------------------8<-----------------------------------
>>
>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
>> index 74392d9d51e0..e54fa1037d45 100644
>> --- a/arch/x86/kernel/tsc.c
>> +++ b/arch/x86/kernel/tsc.c
>> @@ -1370,8 +1370,10 @@ void __init tsc_init(void)
>>                   return;
>>           }
>>
>> -       cpu_khz = x86_platform.calibrate_cpu();
>> -       tsc_khz = x86_platform.calibrate_tsc();
>> +       if (!tsc_khz) {
>> +               cpu_khz = x86_platform.calibrate_cpu();
>> +               tsc_khz = x86_platform.calibrate_tsc();
>> +       }
>>
>>           /*
>>            * Trust non-zero tsc_khz as authorative,
> 
> 
> 


