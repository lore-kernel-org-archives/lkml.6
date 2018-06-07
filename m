Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KTfQKkCOGFtZCwAAmS7hNA
	; Thu, 07 Jun 2018 01:46:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0D351608B8; Thu,  7 Jun 2018 01:46:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5F6A2601A8;
	Thu,  7 Jun 2018 01:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F6A2601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbeFGBp5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 21:45:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58974 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752344AbeFGBp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 21:45:56 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9FCF6B19E18B3;
        Thu,  7 Jun 2018 09:45:52 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.382.0; Thu, 7 Jun 2018
 09:45:45 +0800
Subject: Re: Is this a kernel BUG? ///Re: [Question] Can we use SIGRTMIN when
 vdso disabled on X86?
To: <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86l <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5B1672FE.4050705@huawei.com> <5B1792C9.8010203@huawei.com>
 <5B17A6B6.70300@huawei.com> <B2D1D0A5-D35B-435C-9548-1FB5964F61BA@zytor.com>
CC: <yaomin2@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B188E2B.7040700@huawei.com>
Date: Thu, 7 Jun 2018 09:45:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <B2D1D0A5-D35B-435C-9548-1FB5964F61BA@zytor.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/6/7 1:48, hpa@zytor.com wrote:
> On June 6, 2018 2:17:42 AM PDT, "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com> wrote:
>> I found that glibc has already dealt with this case. So this issue must
>> have been met before, should it be maintained by libc/user?
>>
>> 	if (GLRO(dl_sysinfo_dso) == NULL)
>> 	{
>> 		kact.sa_flags |= SA_RESTORER;
>>
>> 		kact.sa_restorer = ((act->sa_flags & SA_SIGINFO)
>> 			? &restore_rt : &restore);
>> 	}
>>
>>
>> On 2018/6/6 15:52, Leizhen (ThunderTown) wrote:
>>>
>>>
>>> On 2018/6/5 19:24, Leizhen (ThunderTown) wrote:
>>>> After I executed "echo 0 > /proc/sys/abi/vsyscall32" to disable
>> vdso, the rt_sigaction01 test case from ltp_2015 failed.
>>>> The test case source code please refer to the attachment, and the
>> output as blow:
>>>>
>>>> -----------------
>>>> ./rt_sigaction01
>>>> rt_sigaction01    0  TINFO  :  signal: 34
>>>> rt_sigaction01    1  TPASS  :  rt_sigaction call succeeded: result =
>> 0
>>>> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
>>>> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal
>> number 34
>>>>
>>>> Segmentation fault
>>>> ------------------
>>>>
>>>>
>>>> Is this the desired result? In function ia32_setup_rt_frame, I found
>> below code:
>>>>
>>>> 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
>>>> 		restorer = ksig->ka.sa.sa_restorer;
>>>> 	else
>>>> 		restorer = current->mm->context.vdso +
>>>> 			vdso_image_32.sym___kernel_rt_sigreturn;
>>>> 	put_user_ex(ptr_to_compat(restorer), &frame->pretcode);
>>>>
>>>> Because the vdso is disabled, so current->mm->context.vdso is NULL,
>> which cause the result of frame->pretcode invalid.
>>>>
>>>> I'm not sure whether this is a kernel bug or just an error of test
>> case itself. Can anyone help me?
>>>>
>>>
> 
> The use of signals without SA_RESTORER is considered obsolete, but it's somewhat surprising that the vdso isn't there; it should be mapped even for static binaries esp. on i386 since it is the preferred way to do system calls (you don't need to parse the ELF for that.) Are you explicitly disabling the VDSO? If so, Don't Do That.

Yes, the vdso was explicitly disabled by the tester. Thanks.

> 

-- 
Thanks!
BestRegards
