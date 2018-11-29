Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863ADC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A217213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="GJBZLMxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A217213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbeK3GXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:23:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45067 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeK3GXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:23:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so1500214plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=fIL0B8/l9puNK4TzrT8jZbuHgkwtLqYMU8KX8IshhkQ=;
        b=GJBZLMxaDhfs2NnwrZNKEpziRLqaQptXa4zJmPBk+QGQ9v9JMqkZKf36XyaBAIEaeK
         HryaBINtQd+IngNMOe6xyA+XT/a/HAd+U6B4cg68IYFwUqg1moqhtbuSIuCKa3e/t81t
         3PHKP/4iAnPrT86ctc28yryQvfzi3UcoF0vUhEnJQNN1G9mcAWX/p+OP4LDWyPpojdmY
         Yn3mGbktI9U/iO/z+gpg8tTK8hAoWvJNg9Ass/nJdeg8pGL/xjNY1CeyDHj4fWl/YL0z
         8OWJqmp4OUV9AiurIZhEEAJx+Fv6sv507agnyt8VQSEIqen6D+IgJRcLeJYXB+5es9S2
         6tLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=fIL0B8/l9puNK4TzrT8jZbuHgkwtLqYMU8KX8IshhkQ=;
        b=hX+A5/RGZSpQ/WwDOOtOL9uDeq4DBIlufanNaUei7cOv5ZGfBKUhbxQ3UQi29D2atg
         5vvvg38dK3hAfSa6ESA8ceFz/w4eZf2B1aSR16q49L+6lWYsDW4V+uYl0DlXjhC4Z+re
         4/gyOfJfmr92CG/Jx0hDiFdQ8xOYbax+lUarx6t4I/Vixn/xSxBSZHj0UVVceWhMZKv9
         6zBhF7MPJw1v1p2T2JLi+j/3Jq1oZmronH0YaRGauj8CdRDYgTPoPg4rQb5oqAggVYlP
         mPWti/8/NFqAhnxNIK4X3qVLZCZSFsrryNmMMvfkeael8ZI/11qq6N7UQDwWPfAgURBw
         /zBQ==
X-Gm-Message-State: AA+aEWYfnGoibeuRd9ztJmCMb5pzfXDFxRIEzyWJk5t07pTEb1KD2sPd
        oYj7/Uk1TE1JxvkgT0x29UD+4A==
X-Google-Smtp-Source: AFSGD/WNJ9Mw9E0Q6ZxymKHdOFFcS7hJji6kkHXcJarJAMSsBi4ofBhP/GSc5dQI0KhzBSQkPUZzrg==
X-Received: by 2002:a17:902:45:: with SMTP id 63mr2579099pla.272.1543519025698;
        Thu, 29 Nov 2018 11:17:05 -0800 (PST)
Received: from ?IPv6:2404:4404:133a:4500:fd53:84f6:a1e8:48a3? ([2404:4404:133a:4500:fd53:84f6:a1e8:48a3])
        by smtp.gmail.com with ESMTPSA id l11sm3702526pff.65.2018.11.29.11.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:17:04 -0800 (PST)
Date:   Fri, 30 Nov 2018 08:16:52 +1300
User-Agent: K-9 Mail for Android
In-Reply-To: <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net>
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com> <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Andy Lutomirski <luto@amacapital.net>,
        Florian Weimer <fweimer@redhat.com>
CC:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 30, 2018 5:54:18 AM GMT+13:00, Andy Lutomirski <luto@amacapital=
=2Enet> wrote:
>
>
>> On Nov 29, 2018, at 4:28 AM, Florian Weimer <fweimer@redhat=2Ecom>
>wrote:
>>=20
>> Disclaimer: I'm looking at this patch because Christian requested it=2E
>> I'm not a kernel developer=2E
>>=20
>> * Christian Brauner:
>>=20
>>> diff --git a/arch/x86/entry/syscalls/syscall_32=2Etbl
>b/arch/x86/entry/syscalls/syscall_32=2Etbl
>>> index 3cf7b533b3d1=2E=2E3f27ffd8ae87 100644
>>> --- a/arch/x86/entry/syscalls/syscall_32=2Etbl
>>> +++ b/arch/x86/entry/syscalls/syscall_32=2Etbl
>>> @@ -398,3 +398,4 @@
>>> 384    i386    arch_prctl        sys_arch_prctl          =20
>__ia32_compat_sys_arch_prctl
>>> 385    i386    io_pgetevents        sys_io_pgetevents      =20
>__ia32_compat_sys_io_pgetevents
>>> 386    i386    rseq            sys_rseq            __ia32_sys_rseq
>>> +387    i386    procfd_signal        sys_procfd_signal      =20
>__ia32_compat_sys_procfd_signal
>>> diff --git a/arch/x86/entry/syscalls/syscall_64=2Etbl
>b/arch/x86/entry/syscalls/syscall_64=2Etbl
>>> index f0b1709a5ffb=2E=2E8a30cde82450 100644
>>> --- a/arch/x86/entry/syscalls/syscall_64=2Etbl
>>> +++ b/arch/x86/entry/syscalls/syscall_64=2Etbl
>>> @@ -343,6 +343,7 @@
>>> 332    common    statx            __x64_sys_statx
>>> 333    common    io_pgetevents        __x64_sys_io_pgetevents
>>> 334    common    rseq            __x64_sys_rseq
>>> +335    64    procfd_signal        __x64_sys_procfd_signal
>>>=20
>>> #
>>> # x32-specific system call numbers start at 512 to avoid cache
>impact
>>> @@ -386,3 +387,4 @@
>>> 545    x32    execveat        __x32_compat_sys_execveat/ptregs
>>> 546    x32    preadv2            __x32_compat_sys_preadv64v2
>>> 547    x32    pwritev2        __x32_compat_sys_pwritev64v2
>>> +548    x32    procfd_signal        __x32_compat_sys_procfd_signal
>>=20
>> Is there a reason why these numbers have to be different?
>>=20
>> (See the recent discussion with Andy Lutomirski=2E)
>
>Hah, I missed this part of the patch=2E  Let=E2=80=99s not add new x32 sy=
scall
>numbers=2E
>
>Also, can we perhaps rework this a bit to get rid of the compat entry
>point?  The easier way would be to check in_compat_syscall()=2E The nicer
>way IMO would be to use the 64-bit structure for 32-bit as well=2E

Do you have a syscall which set precedence/did this before I could look at=
?
Just if you happen to remember one=2E
Fwiw, I followed the other signal syscalls=2E
They all introduce compat syscalls=2E

