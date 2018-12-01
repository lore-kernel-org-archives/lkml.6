Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8BEC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0739B20867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="KCuUtnNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0739B20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLAMgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:36:50 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44986 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbeLAMgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:36:49 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so6030706iod.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 17:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=wp5WpQaUj8L83+/r3AKv1KvjDv7nhf3IntrUC6vo1ig=;
        b=KCuUtnNNOyAHdtIjyphgpdlvzC9ejr5oF3HGdzP/O3rHuFnrS+yzWKVDUBUqyBnNOZ
         73t2x/RRBKBkG5Iri7whnbnPqk5lcRcWld36NrDTdFwKfDbg4xd8bZWhiOXvf5ogjASq
         mtXQ+4+OovHCos7YRuLZIgYTsZ7JOasTEPjP3t5GQ/wmCbRLBrzvm8fBoqavLaCDAruS
         CPp0wJkab+C73ssOtR4PyPm8Q9JqfPgswq9970RfpPUdCG/rhTBp2L2Ws7aTQQKRPCv+
         cnGShbnFnNbksLCdi27QOn7rfwN97i9oiq2mgeUVYEWpNXRlbBOC1YnwGz+1DTJqgOIN
         Gl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=wp5WpQaUj8L83+/r3AKv1KvjDv7nhf3IntrUC6vo1ig=;
        b=oV+OIpG2PhMYGs1Md15U0ixEXo3WgdFt2tC8JrtJnhOgNPKluOaPh8GHxahnWpPfRK
         OYoYZQsunKQ1QRcAged2l8GBrmA4IO6s4lMKhTVsvCZr1xMKAkw/zxgCFGS23AaxOCy5
         UhYdPpT8YvcQyA+KEXwGSsJ4Dakmd6hxUDCbxStDI+hp8qYS5V+rNEUJsF20mYndYefH
         cvbGZVqluR7ujTrTexvs/Qw+q1UW4fPd9yfEYhw33n4zjvL85IhbfJ3G1Yl8aGKu4HEl
         DNPqqer5zdA03+iY9kKOkxEI4K13xUXqQroAPg37pcuchRiI6SM4/FFK6F+L9jfiEgo1
         dIuQ==
X-Gm-Message-State: AA+aEWYtxwXttZGlr9HBHy90cxrJwAQu0XQMrIa0Ohri9vkl5h7Kfgxu
        B2KImbEjg3c5CcOG3hE5w4+VlQ==
X-Google-Smtp-Source: AFSGD/V1p/zEfhJzZ27GzxWL8wRpQVVzMAUCwZ5I2P8//jnEcXdGGQg4jRBfLf3fD4qkiCG1wm0guQ==
X-Received: by 2002:a5d:870c:: with SMTP id u12mr6679411iom.168.1543627533453;
        Fri, 30 Nov 2018 17:25:33 -0800 (PST)
Received: from [26.67.58.27] ([172.56.12.18])
        by smtp.gmail.com with ESMTPSA id e10sm2847246ioa.65.2018.11.30.17.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 17:25:32 -0800 (PST)
Date:   Sat, 01 Dec 2018 14:25:10 +1300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAK8P3a1_if7+Ak2eefU6JeZT9KW827gkLHaObX-QOsHrB5ZwfA@mail.gmail.com>
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com> <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io> <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com> <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net> <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com> <20181129213458.4h44dpg6ltqow4k4@brauner.io> <CAK8P3a1_if7+Ak2eefU6JeZT9KW827gkLHaObX-QOsHrB5ZwfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
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
Message-ID: <7D934AED-82E4-4DC3-8CCB-973680316B60@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 30, 2018 10:40:49 AM GMT+13:00, Arnd Bergmann <arnd@arndb=2Ede>=
 wrote:
>On Thu, Nov 29, 2018 at 10:35 PM Christian Brauner
><christian@brauner=2Eio> wrote:
>> On Thu, Nov 29, 2018 at 10:02:13PM +0100, Arnd Bergmann wrote:
>> > On Thu, Nov 29, 2018 at 9:14 PM Andy Lutomirski
><luto@amacapital=2Enet> wrote:
>> >
>> > Is the current procfd_signal() proposal (under whichever name)
>sufficient
>> > to correctly implement both sys_rt_sigqueueinfo() and
>sys_rt_tgsigqueueinfo()?
>>
>> Yes, I see no reason why not=2E My idea is to extend it - after we have
>a
>> basic version in - to also work with:
>> /proc/<pid>/task/<tid>
>> If I'm not mistaken this should be sufficient to get
>rt_tgsigqueueinfo=2E
>> The thread will be uniquely identified by the tid descriptor and no
>> combination of /proc/<pid> and /proc/<pid>/task/<tid> is needed=2E Does
>> that sound reasonable?
>
>Yes=2E So it would currently replace rt_gsigqueueinfo() but
>not rt_tgsigqueueinfo(), and could be extended to do both
>afterwards, without making the interface ugly in any form?

Yes=2E :)

>
>I suppose we can always add more flags if needed, and you
>already ensure that flags is zero for the moment=2E

Yep=2E

>
>> > Can we implement sys_rt_sigtimedwait() based on signalfd()?
>> >
>> > If yes, that would leave waitid(), which already needs a
>replacement
>> > for y2038, and that should then also return a signalfd_siginfo=2E
>> > My current preference for waitid() would be to do a version that
>> > closely resembles the current interface, but takes a
>signalfd_siginfo
>> > and a __kernel_timespec based rusage replacement (possibly
>> > two of them to let us map wait6), but does not operate on procfd or
>> > take a signal mask=2E That would require yet another syscall, but I
>> > don't think I can do that before we want to have the set of y2038
>> > safe syscalls=2E
>>
>> All sounds reasonable to me but that's not a blocker for the current
>> syscall though, is it?
>
>I'd like to at least understand about sys_rt_sigtimedwait() before
>we go on, so we all know what's coming, and document the
>plans in the changelog=2E
>
>waitid() probably remains on my plate anyway, and I hope understand
>where we're at with it=2E
>
>     Arnd

