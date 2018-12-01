Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC40C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742EA206B7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="KYMc9rxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742EA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeLBDkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:40:45 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51077 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbeLBDkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:40:45 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so3206424iti.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 08:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=Qjnvh4ajYLsVGCnXt4P8Q7SKLP5Uf/VkVaKTpjJJXlI=;
        b=KYMc9rxWncaEcLe4uE7gQVyeoWQSLBE/DRRX6Y/He4wwt6DeWIHlGHmJiA2zTOSbPA
         yrmv4TGXcLOEHlLKVX82T2eE3zXvaDMVuy9AQyDeL+F5+kGg5UD6NLq+/2NUg6KTGQhx
         TDHorkU9WmxSltN1f5Apn8m4RE5/0UIWCDAyWdjcuVFI3cTcxWKMpBOqRZ/bfb+nExif
         bLBpSfg6weevNjUEgqdZ0TbFtJi3RK6z/dtwappf69QTYGElP5f15i/l7LPsBcbP8kDX
         4x+O1zK016H6vPv82Y5zJtBE1Ciij1xZMX4/1TXo8atxzhkw258eTiKXZZ49mPgBeJVB
         L9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Qjnvh4ajYLsVGCnXt4P8Q7SKLP5Uf/VkVaKTpjJJXlI=;
        b=C7jOkiNfNC8FOEe0U/qUDRE5YDTalHj3SIPb4tMG/E3pHhlSfEVbzQ1DzXgwiZPaOk
         gxtKBU8WzqGmdKOBbBgjSeNOb2WY25ga6leeyB533FqALC8yi1HMaBR+4JG+mpNy8xwR
         ef+N6Lw492E9yoLWpfJVv7Hps0SgrG1DfMcPtKZIu2qcZndHPGl8xvNkXzMCrEy5Q4tn
         lMKdJDXQsCipXNWDpaYGprNY/aB3gwu4qLOuYAS9asw6DzaRtfeYDKJFAn4zlmxrAy3d
         BDQkyQM9MusoH+NKpwtnJlRj02EKJfDMc0qpc90Dobp/MG2HSrFIw0yoRqYTDBe2ucpP
         bSIg==
X-Gm-Message-State: AA+aEWbxS2JjAbsXvV1L0Wuyq8GUe+XRe69VLuI0znehO7vZFyqZDdnl
        wFqOMXwqUktT2tZuDWh8KLXEMg==
X-Google-Smtp-Source: AFSGD/XPQzY0GU8DOmC8GgZWevEXokxro293vtHO7ToLHlOJ5973pR+zfDB+gVBcEDA69CXo+o6SPA==
X-Received: by 2002:a24:67c6:: with SMTP id u189mr2679135itc.106.1543681671629;
        Sat, 01 Dec 2018 08:27:51 -0800 (PST)
Received: from [26.67.160.54] ([172.56.13.56])
        by smtp.gmail.com with ESMTPSA id p74sm3454237iod.14.2018.12.01.08.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 08:27:50 -0800 (PST)
Date:   Sun, 02 Dec 2018 05:27:40 +1300
User-Agent: K-9 Mail for Android
In-Reply-To: <F53D6D38-3521-4C20-9034-5AF447DF62FF@amacapital.net>
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com> <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io> <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com> <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net> <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com> <87y39b2lm2.fsf@xmission.com> <20181130065606.kmilbbq46oeycjp5@brauner.io> <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com> <87y399s3sc.fsf@xmission.com> <87tvjxp8pc.fsf@xmission.com> <F53D6D38-3521-4C20-9034-5AF447DF62FF@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Andy Lutomirski <luto@amacapital.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <7089A038-6685-4EB4-A67A-CE692B32147B@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 2, 2018 4:52:37 AM GMT+13:00, Andy Lutomirski <luto@amacapital=
=2Enet> wrote:
>
>
>> On Dec 1, 2018, at 7:28 AM, Eric W=2E Biederman <ebiederm@xmission=2Eco=
m>
>wrote:
>>=20
>>=20
>> It just occurs to me that the simple way to implement
>> procfd_sigqueueinfo info is like:
>>=20
>> int copy_siginfo_from_user_any(kernel_siginfo_t *info, siginfo_t
>*uinfo)
>> {
>> #ifdef CONFIG_COMPAT
>>    if (in_compat_syscall)
>>        return copy_siginfo_from_user32(info, uinfo);
>> #endif
>>    return copy_siginfo_from_user(info, uinfo);                      =20
>
>> }
>>=20
>> long procfd_sigqueueinfo(int fd, siginfo_t *uinfo)
>> {
>>    kernel_siginfo info;
>>=20
>>        if (copy_siginfo_from_user_any(&info, uinfo))
>>            return -EFAULT;
>>    =2E=2E=2E;               =20
>> }
>>=20
>> It looks like there is already a place in ptrace=2Ec that already
>> hand rolls copy_siginfo_from_user_any=2E
>>=20
>> So while I would love to figure out the subset of siginfo_t tha we
>can
>> just pass through, as I think that would make a better more forward
>> compatible copy_siginfo_from_user32=2E
>
>Seems reasonable to me=2E It=E2=80=99s less code overall than any other
>suggestion, too=2E

Thanks everyone, that was super helpful!
All things equal I'm going to send out an
updated version of the patch latest next week!

>
>>  I think for this use case we just
>> add the in_compat_syscall test and then we just need to ensure this
>new
>> system call is placed in the proper places in the syscall table=2E
>>=20
>> Because we will need 3 call sights: x86_64, x32 and ia32=2E  As the
>layout
>> changes between those three subarchitecuters=2E
>>=20
>>=20
>
>If it=E2=80=99s done this way, it can just be =E2=80=9Ccommon=E2=80=9D in=
 the 64-bit table=2E And
>we kick the can a bit farther down the road :)
>
>I=E2=80=99m working on patches to clean up x86=E2=80=99s syscall mess=2E =
It=E2=80=99s slow
>because I keep finding new messes=2E  So far I have rt_sigreturn working
>like every other syscall =E2=80=94 whee=2E
>
>Also, Eric, for your edification, I have a draft patch set to radically
>simplify x86=E2=80=99s signal delivery and return=2E  Once that=E2=80=99s=
 done, I can
>trivially speed up delivery by a ton by using sysret=2E

