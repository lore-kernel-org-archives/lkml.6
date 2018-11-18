Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF91C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD922086A
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="TuHbueyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD922086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeKSHEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:04:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35885 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeKSHEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:04:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so5684244pgm.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 12:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZOzAzEkZSeShnw3IMWJ8pwJU/havDmGTKyO1QCcP0nI=;
        b=TuHbueyyHKqDlzEwj6DNNwGBuag+9zMFflkGgFJLJK/YmI6CFHFTd7N0DdOsSayT7f
         IAam6wSju81ElDKeLjMCeL2UDLFfqStlROJcMdoTFQ1SJP3UCvHJWGd/DFnSxdtYitPF
         soa3SCwlkEPqsetCsDR0AYyisyjS+RjOwZ97pijtKscD+OrM91liVHs0aBIo2Arz8aPo
         1qBA2HzbtJyYq+W11l1TGfIvaHy9HlhZ/myfvAohX/7M3iq4Uc0lL8Nusbp3yw93loDE
         8wJaq3ak5eONy2Awj2+UBvAnI/PabycKI0R89UgL2jNp/ZXX660qeKtwwY/0SFW7VZr0
         5XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZOzAzEkZSeShnw3IMWJ8pwJU/havDmGTKyO1QCcP0nI=;
        b=Q88vqgsvcoAjQ2P/+h5LtE8KHujfefJGheqi3Qaxe2bveEwivOWvbn2Sv066g0KFw7
         EC6chrHaokM6REhZjs2wdNlkdfSy50u1NPezvsdszeBuhuqfK0tUYVm0i5AbuZHhHtLf
         Ep6D8HU6N6gxtCh/t1F0RFszc84DQ8FH77FUoNm3L7/DGb65PEVQd2PIlLYM88Hr4tvH
         nkUPNGJ1Xp1mdev3+P00JXp74CMJdOSVoZJ/Qkpy8xUPw2F9470qmT0IbN3J88TokWed
         hQlXsun5At5Z9DRd6tGxggQiWo23+DNGE9uLQt01zY+FPDXAwFs+hvjxCrKFmdYzCnNb
         F+AA==
X-Gm-Message-State: AGRZ1gLDmf7qK4s4/v+svGaHHZIvBalFqUv4gwTTTwq/fRuIQwBQcxbj
        m2VJ++su4M4z6YBoo8Q/PUpieg==
X-Google-Smtp-Source: AJdET5dfT6KgM+xTjt8EBxm5KVr0S/N29SehGxIPTb3xqF8Q9S7oEMkjlwOzOdd7aNRnz9AKYtw09g==
X-Received: by 2002:a65:514c:: with SMTP id g12mr17493493pgq.169.1542573808768;
        Sun, 18 Nov 2018 12:43:28 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id v12-v6sm52238102pfa.167.2018.11.18.12.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 12:43:28 -0800 (PST)
Date:   Sun, 18 Nov 2018 21:43:19 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Daniel Colascione <dancol@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jan Engelhardt <jengelh@inai.de>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
Message-ID: <20181118204317.seaztq7fqmysucns@brauner.io>
References: <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
 <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
 <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
 <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
 <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
 <CAKOZuevRq-igh06zS_nsGG400zXrKFCtajpEG9-xgU2+Rtb2Pw@mail.gmail.com>
 <20181118190504.ixglsqbn6mxkcdzu@yavin>
 <CAKOZuetfqvn1uVqKJ=16iEzG4g449YOjC_tLM60eKBSkv9u+bQ@mail.gmail.com>
 <608F2959-800D-46EE-A7CD-8C972ACD2F02@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <608F2959-800D-46EE-A7CD-8C972ACD2F02@amacapital.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 01:28:41PM -0700, Andy Lutomirski wrote:
> 
> 
> > On Nov 18, 2018, at 12:44 PM, Daniel Colascione <dancol@google.com> wrote:
> > 
> 
> > 
> > That is, I'm proposing an API that looks like this:
> > 
> > int process_kill(int procfs_dfd, int signo, const union sigval value)
> > 
> > If, later, process_kill were to *also* accept process-capability FDs,
> > nothing would break.
> 
> Except that this makes it ambiguous to the caller as to whether their current creds are considered.  So it would need to be a different syscall or at least a flag.  Otherwise a lot of those nice theoretical properties go away.

I can add a flag argument
int process_signal(int procfs_dfd, int signo, siginfo_t *info, int flags)
The way I see it process_signal() should be equivalent to kill(pid, signal) for now.
That is siginfo_t is cleared and set to:

info.si_signo = sig;
info.si_errno = 0;
info.si_code = SI_USER;
info.si_pid = task_tgid_vnr(current);
info.si_uid = from_kuid_munged(current_user_ns(), current_uid());

> 
> > Yes, that's what I have in mind. A siginfo_t is small enough that we
> > could just store it as a blob allocated off the procfs inode or
> > something like that without bothering with a shmfs file. You'd be able
> > to read(2) the exit status as many times as you wanted.
> 
> I think that, if the syscall in question is read(2), then it should work *once* per struct file.  Otherwise running cat on the file would behave very oddly.
> 
> Read and poll have the same problem as write: we can’t check caps in read or poll either.
