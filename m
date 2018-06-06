Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75BE960764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932522AbeFFJSL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:18:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44052 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932472AbeFFJSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:18:07 -0400
Subject: Re: Is this a kernel BUG? ///Re: [Question] Can we use SIGRTMIN when
 vdso disabled on X86?
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86l <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5B1672FE.4050705@huawei.com> <5B1792C9.8010203@huawei.com>
CC: <yaomin2@huawei.com>, Thunder Town <thunder.leizhen@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B17A6B6.70300@huawei.com>
Date: Wed, 6 Jun 2018 17:17:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <5B1792C9.8010203@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that glibc has already dealt with this case. So this issue must have been met before, should it be maintained by libc/user?

	if (GLRO(dl_sysinfo_dso) == NULL)
	{
		kact.sa_flags |= SA_RESTORER;

		kact.sa_restorer = ((act->sa_flags & SA_SIGINFO)
			? &restore_rt : &restore);
	}


On 2018/6/6 15:52, Leizhen (ThunderTown) wrote:
> 
> 
> On 2018/6/5 19:24, Leizhen (ThunderTown) wrote:
>> After I executed "echo 0 > /proc/sys/abi/vsyscall32" to disable vdso, the rt_sigaction01 test case from ltp_2015 failed.
>> The test case source code please refer to the attachment, and the output as blow:
>>
>> -----------------
>> ./rt_sigaction01
>> rt_sigaction01    0  TINFO  :  signal: 34
>> rt_sigaction01    1  TPASS  :  rt_sigaction call succeeded: result = 0
>> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
>> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
>>
>> Segmentation fault
>> ------------------
>>
>>
>> Is this the desired result? In function ia32_setup_rt_frame, I found below code:
>>
>> 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
>> 		restorer = ksig->ka.sa.sa_restorer;
>> 	else
>> 		restorer = current->mm->context.vdso +
>> 			vdso_image_32.sym___kernel_rt_sigreturn;
>> 	put_user_ex(ptr_to_compat(restorer), &frame->pretcode);
>>
>> Because the vdso is disabled, so current->mm->context.vdso is NULL, which cause the result of frame->pretcode invalid.
>>
>> I'm not sure whether this is a kernel bug or just an error of test case itself. Can anyone help me?
>>
> 

-- 
Thanks!
BestRegards
