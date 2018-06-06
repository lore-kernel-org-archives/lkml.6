Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F25E360555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeFFRtN convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Wed, 6 Jun 2018 13:49:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54439 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754023AbeFFRtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:49:11 -0400
Date: Wed, 06 Jun 2018 10:48:49 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <5B17A6B6.70300@huawei.com>
References: <5B1672FE.4050705@huawei.com> <5B1792C9.8010203@huawei.com> <5B17A6B6.70300@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Is this a kernel BUG? ///Re: [Question] Can we use SIGRTMIN when vdso disabled on X86?
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86l <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC: yaomin2@huawei.com, Thunder Town <thunder.leizhen@huawei.com>
From: hpa@zytor.com
Message-ID: <B2D1D0A5-D35B-435C-9548-1FB5964F61BA@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 6, 2018 2:17:42 AM PDT, "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com> wrote:
>I found that glibc has already dealt with this case. So this issue must
>have been met before, should it be maintained by libc/user?
>
>	if (GLRO(dl_sysinfo_dso) == NULL)
>	{
>		kact.sa_flags |= SA_RESTORER;
>
>		kact.sa_restorer = ((act->sa_flags & SA_SIGINFO)
>			? &restore_rt : &restore);
>	}
>
>
>On 2018/6/6 15:52, Leizhen (ThunderTown) wrote:
>> 
>> 
>> On 2018/6/5 19:24, Leizhen (ThunderTown) wrote:
>>> After I executed "echo 0 > /proc/sys/abi/vsyscall32" to disable
>vdso, the rt_sigaction01 test case from ltp_2015 failed.
>>> The test case source code please refer to the attachment, and the
>output as blow:
>>>
>>> -----------------
>>> ./rt_sigaction01
>>> rt_sigaction01    0  TINFO  :  signal: 34
>>> rt_sigaction01    1  TPASS  :  rt_sigaction call succeeded: result =
>0
>>> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
>>> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal
>number 34
>>>
>>> Segmentation fault
>>> ------------------
>>>
>>>
>>> Is this the desired result? In function ia32_setup_rt_frame, I found
>below code:
>>>
>>> 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
>>> 		restorer = ksig->ka.sa.sa_restorer;
>>> 	else
>>> 		restorer = current->mm->context.vdso +
>>> 			vdso_image_32.sym___kernel_rt_sigreturn;
>>> 	put_user_ex(ptr_to_compat(restorer), &frame->pretcode);
>>>
>>> Because the vdso is disabled, so current->mm->context.vdso is NULL,
>which cause the result of frame->pretcode invalid.
>>>
>>> I'm not sure whether this is a kernel bug or just an error of test
>case itself. Can anyone help me?
>>>
>> 

The use of signals without SA_RESTORER is considered obsolete, but it's somewhat surprising that the vdso isn't there; it should be mapped even for static binaries esp. on i386 since it is the preferred way to do system calls (you don't need to parse the ELF for that.) Are you explicitly disabling the VDSO? If so, Don't Do That.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
