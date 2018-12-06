Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E0AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BFC20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="TY/HOGlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BFC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbeLFTDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:03:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34752 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLFTDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:03:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id 17so560312pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 11:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=QPlOkQh0m6/G5PL4R7Z69cysn/I3zGjF8duaHorvK4o=;
        b=TY/HOGlJmZiO2Y0kl/F48LbJgrvoNgEJPJ4SW7Ua0uzcannPm5u8kdVbJ4wn3EiGmr
         9cKWJY+egw3nWvVNQqD1W5/xQrY8/hhoBmYEt7ibNdp7NvQcOTvAzxcJRskPFMxMTnEi
         cjaM0/DBLIoDb+jj3ekwfj0WpaS7uxh5AZLZ3Bzu92B0KQ6fwEYa+DQyKCweGRq7TelV
         m34xN06hn387AwRCYpB22IwuR6ih5Yy7TRZrU9YPv29b4FVLSDZbw2RG2fn21wKNftFN
         RU4oLcbGjaBZ9yT/bz+Dx50Cex1aEAWDCaXGWshW+AIEfZKoXU/pmQ+o3KMqS7+O9ZKf
         NUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=QPlOkQh0m6/G5PL4R7Z69cysn/I3zGjF8duaHorvK4o=;
        b=iYG4StA3+qC0Be4z0+hdUICsQJxnmDpTgjxv4LNU3pa75T3Zqnqn93pb4tO3EYTbl0
         h6eJW8tE4qsDjl901hTvmtx3H19Qy0Y0kUitfu3c5sa0sddTrX5BI/6EnIMak51QUD5U
         35jOkFzGfym/oHjYIH/NaOdpJb/OdVlc/Y/RvssGAFQPvmMGUvSdToLztCRTJvgYJ/Am
         7kcursLiQEPyUKmKz7hWSb9LBM5N4h9oareT7sgG+ZR85MWoq9AaArSRJnY4yAvzotON
         LhOaU22k3buSDHixeJzBUb47aO8pdkTcXaraia6so/eWUBBlye/aMEl7oQcppMtpK2CL
         YkVQ==
X-Gm-Message-State: AA+aEWaS2mcb2H4dSALkMiZM+jDTADaFpgNziFuh1dZ6ncWokx5Js/to
        nkX9gQnFm37zu5TrybclZgQKTQ==
X-Google-Smtp-Source: AFSGD/VFl46cZ3Ffj3wxcHO+oFzzFpdx0rTM80sog3Hc1ikKYyppyuZOq4QSDB86s9p9slF0FEZwnA==
X-Received: by 2002:a63:de46:: with SMTP id y6mr25121081pgi.198.1544123033462;
        Thu, 06 Dec 2018 11:03:53 -0800 (PST)
Received: from ?IPv6:2404:4404:133a:4500:138:8204:e16a:7a26? ([2404:4404:133a:4500:138:8204:e16a:7a26])
        by smtp.gmail.com with ESMTPSA id v190sm1341964pfv.26.2018.12.06.11.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:03:52 -0800 (PST)
Date:   Fri, 07 Dec 2018 08:03:45 +1300
User-Agent: K-9 Mail for Android
In-Reply-To: <87y392h4b7.fsf@oldenburg2.str.redhat.com>
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com> <746B7C49-CC7B-4040-A7EF-82491796D360@brauner.io> <20181202100304.labt63mzrlr5utdl@brauner.io> <8736rebl9s.fsf@oldenburg.str.redhat.com> <20181203180224.fkvw4kajtbvru2ku@brauner.io> <874lbtjvtd.fsf@oldenburg2.str.redhat.com> <CALCETrViXJ0gD34yVd8QpB-CSeKZzzncvkPHReycTiQin4r4WQ@mail.gmail.com> <87y392h4b7.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Florian Weimer <fweimer@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <C5E71146-DE79-4145-B54B-E161E7372D95@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 7, 2018 7:56:44 AM GMT+13:00, Florian Weimer <fweimer@redhat=2E=
com> wrote:
>* Andy Lutomirski:
>
>>> I suppose that's fine=2E  Or alternatively, when thread group support
>is
>>> added, introduce a flag that applications have to use to enable it,
>so
>>> that they can probe for support by checking support for the flag=2E
>>>
>>> I wouldn't be opposed to a new system call like this either:
>>>
>>>  int procfd_open (pid_t thread_group, pid_t thread_id, unsigned
>flags);
>>>
>>> But I think this is frowned upon on the kernel side=2E
>>
>> I have no problem with it, except that I think it shouldn=E2=80=99t ret=
urn an
>> fd that can be used for proc filesystem access=2E
>
>Oh no, my intention was that it would just be used with  *_send_signal
>and related functions=2E

Let's postpone that discussion a little=2E
I think we don't need a syscall to base this off of pids=2E
As I said I rather send my revived version of CLONE_NEWFD that would serve=
 the same task=2E
The same way we could also just add a new open() flag that blocks fs acces=
s completely=2E
I just pitched that idea to Serge a few days back: O_NOCHDIR or similar=2E
That could even be part of Aleksa's path resolution patchset=2E

>
>Thanks,
>Florian

