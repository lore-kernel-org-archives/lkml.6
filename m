Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABFBC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24C420863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="U9frtaYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24C420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeLALDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:03:42 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38417 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbeLALDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:03:40 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so1004268ith.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=+G0fBAVnQecsG1FdBWn/9XnX3bRR2/ZEiqhtMrE3Uo4=;
        b=U9frtaYMnZldB0CTwjZpY9YMOOjYnWjziYsixXG4mzj4K4F2KI8VAnmtpxaho3pARF
         XeIKfO5LSfu90tSYkmoODFUMykGQ4PZO4liZkRuP/Dhzj0AhBgJ3rativVmzxWTUYFLt
         Ro8Jng/NtnBHGgyTU7MUvoOyM4Nj3rP6oyITE30BmQ01igeD4F2Kd/8x99TOjUE1YIAw
         e9Ne0Mi4OSWKH9IaIos5cwcywpw5UXcxceDqo5r4F0106yR7fkCBadu+nTv1OalmrtP8
         ODxtRuAO732MwJ48Xa8ElrFVZsFtaa9AdYrVgaB6R3MCSyMfuGUz8OHuPgdwfx7eGKYM
         TkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=+G0fBAVnQecsG1FdBWn/9XnX3bRR2/ZEiqhtMrE3Uo4=;
        b=Ms0SEv50MbWf84asHcsgqp/w6wQpwSKvxJ0lsOaM9RIiFBs2KOaXJDU8umWV3u7FVu
         aE0ExngNGD2BBChZedPcE29qGcRDLFQ3TI21oRTOHlqKgyD4VMm8Rur//2t+9mzTPWua
         yz3Vpu2UtFePBuC+GdYv74X4EY2DdwATVGkyLp0DXe7cZorcM8n3uptHY/QTqYi4Ca18
         eTbCxuG+oT3+iqbzM8fFZRuMOAlLy9YUJJoxSHZ5/bdbMz1O+kDNPP1es1Vvdkdj4NQl
         ReGAtnHvHbGLAHFcvlUOMgaTnGVoMj8PPOChIxvSuQ5sqdD/qNAvT24ek2dD+tBXjIdL
         Rvjw==
X-Gm-Message-State: AA+aEWbYblZyOSdCH8b30peRuJifNYOJD0KFWxSl3UOdJIYiioiTFjc7
        vepL1OsXZmvFlPzPpCZaqrs4yA==
X-Google-Smtp-Source: AFSGD/UgtjUbh0gqwGqPP6JOYI4i6APmxThLdcD1p9xF85sFVgedscjhOvVNQ6Y1DGwAQfZVvo6ZoA==
X-Received: by 2002:a02:5ec9:: with SMTP id h192mr6942815jab.112.1543621958099;
        Fri, 30 Nov 2018 15:52:38 -0800 (PST)
Received: from [26.67.58.27] ([172.56.12.18])
        by smtp.gmail.com with ESMTPSA id 195sm308533itm.2.2018.11.30.15.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 15:52:37 -0800 (PST)
Date:   Sat, 01 Dec 2018 12:52:24 +1300
User-Agent: K-9 Mail for Android
In-Reply-To: <87in0g5aqo.fsf@oldenburg.str.redhat.com>
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Florian Weimer <fweimer@redhat.com>
CC:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <746B7C49-CC7B-4040-A7EF-82491796D360@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 30, 2018 1:28:15 AM GMT+13:00, Florian Weimer <fweimer@redhat=
=2Ecom> wrote:
>Disclaimer: I'm looking at this patch because Christian requested it=2E
>I'm not a kernel developer=2E

Given all your expertise this really doesn't matter=2E :)
You're the one having to deal with this
in glibc after all=2E
Thanks for doing this and sorry for the late reply=2E
I missed that mail=2E

>
>* Christian Brauner:
>
>> diff --git a/arch/x86/entry/syscalls/syscall_32=2Etbl
>b/arch/x86/entry/syscalls/syscall_32=2Etbl
>> index 3cf7b533b3d1=2E=2E3f27ffd8ae87 100644
>> --- a/arch/x86/entry/syscalls/syscall_32=2Etbl
>> +++ b/arch/x86/entry/syscalls/syscall_32=2Etbl
>> @@ -398,3 +398,4 @@
>>  384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
>>=20
>385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevent=
s
>>  386	i386	rseq			sys_rseq			__ia32_sys_rseq
>>
>+387	i386	procfd_signal		sys_procfd_signal		__ia32_compat_sys_procfd_sign=
al
>> diff --git a/arch/x86/entry/syscalls/syscall_64=2Etbl
>b/arch/x86/entry/syscalls/syscall_64=2Etbl
>> index f0b1709a5ffb=2E=2E8a30cde82450 100644
>> --- a/arch/x86/entry/syscalls/syscall_64=2Etbl
>> +++ b/arch/x86/entry/syscalls/syscall_64=2Etbl
>> @@ -343,6 +343,7 @@
>>  332	common	statx			__x64_sys_statx
>>  333	common	io_pgetevents		__x64_sys_io_pgetevents
>>  334	common	rseq			__x64_sys_rseq
>> +335	64	procfd_signal		__x64_sys_procfd_signal
>> =20
>>  #
>>  # x32-specific system call numbers start at 512 to avoid cache
>impact
>> @@ -386,3 +387,4 @@
>>  545	x32	execveat		__x32_compat_sys_execveat/ptregs
>>  546	x32	preadv2			__x32_compat_sys_preadv64v2
>>  547	x32	pwritev2		__x32_compat_sys_pwritev64v2
>> +548	x32	procfd_signal		__x32_compat_sys_procfd_signal
>
>Is there a reason why these numbers have to be different?
>
>(See the recent discussion with Andy Lutomirski=2E)
>
>> +static int do_procfd_signal(int fd, int sig, kernel_siginfo_t
>*kinfo, int flags,
>> +			    bool had_siginfo)
>> +{
>> +	int ret;
>> +	struct fd f;
>> +	struct pid *pid;
>> +
>> +	/* Enforce flags be set to 0 until we add an extension=2E */
>> +	if (flags)
>> +		return -EINVAL;
>> +
>> +	f =3D fdget_raw(fd);
>> +	if (!f=2Efile)
>> +		return -EBADF;
>> +
>> +	/* Is this a process file descriptor? */
>> +	ret =3D -EINVAL;
>> +	if (!proc_is_tgid_procfd(f=2Efile))
>> +		goto err;
>[=E2=80=A6]
>> +	ret =3D kill_pid_info(sig, kinfo, pid);
>
>I would like to see some comment here what happens to zombie processes=2E

You'd get ESRCH=2E
I'm not sure if that has always been the case=2E
Eric recently did some excellent refactoring of the signal code=2E
Iirc, part of that involved not delivering signals to zombies=2E
That's at least how I remember it=2E
I don't have access to source code though atm=2E

>
>> +/**
>> + *  sys_procfd_signal - send a signal to a process through a process
>file
>> + *                      descriptor
>> + *  @fd: the file descriptor of the process
>> + *  @sig: signal to be sent
>> + *  @info: the signal info
>> + *  @flags: future flags to be passed
>> + */
>> +SYSCALL_DEFINE4(procfd_signal, int, fd, int, sig, siginfo_t __user
>*, info,
>> +		int, flags)
>
>Sorry, I'm quite unhappy with the name=2E  =E2=80=9Csignal=E2=80=9D is fo=
r signal handler
>management=2E  procfd_sendsignal, procfd_sigqueueinfo or something like
>that would be fine=2E  Even procfd_kill would be better IMHO=2E

Ok=2E I only have strong opinions to procfd_kill()=2E
Mainly because the new syscall takes
the job of multiple other syscalls
so kill gives the wrong impression=2E
I'll come up with a better name in the next iteration=2E

>
>Looking at the rt_tgsigqueueinfo interface, is there a way to implement
>the =E2=80=9Ctg=E2=80=9D part with the current procfd_signal interface?  =
Would you use
>openat to retrieve the Tgid: line from "status"?

Yes, the tg part can be implemented=2E
As I pointed out in another mail my
I is to make this work by using file
descriptors for /proc/<pid>/task/<tid>=2E
I don't want this in the initial patchset though=2E
I prefer to slowly add those features
once we have gotten the basic functionality
in=2E


>
>Thanks,
>Florian

