Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C443FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8131F20851
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g80dPLdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8131F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeK1MRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:17:31 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35194 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeK1MRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 07:17:31 -0500
Received: by mail-yb1-f195.google.com with SMTP id z2-v6so9949537ybj.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 17:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WLX4LM1KnWwlnrhXuJXnwnHs/4U+peBdLnD9uUBRmxo=;
        b=g80dPLdKRI9YvXafd6F1iPO9160bWVhcY2bBsfSsDDMriEIWUl1SpiVfa3t5tRe4Bg
         18/DSQADSp7X6+081kCqOj3tTSxsIE7F0aG2L3/dom75dFPZiQr7nsIkF5c8WcwC/zMA
         Uod6IjeGOkfszeYFWPMKyxGD4azec1+vqSri4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WLX4LM1KnWwlnrhXuJXnwnHs/4U+peBdLnD9uUBRmxo=;
        b=fTOVLsASYjPJ8RZ8z2Bw4nw8yYav0vqtXdU3g7qDdXR9YNmH8S4S3Dt9LcP+gmdJit
         WI+VlRL0zoMU+1xn4FFwfyp7wvS90yaljfSDbQJ8c1dWjm+nClLJuj0IDO8dviF5NdI/
         ZLix/NkjkrJFMsv4o4fBH+IEb5Azf6LeAxPzawyE4emZNvvoHlUhTDRohn2/y5v0s5IP
         6oE2ShSw85WuJ/yilRHGzMHPm1P/dSbsitffJdtyj6H4iCQUhh2MdA8ekYJRCSDlUwLq
         mmiQ6+NOePruikvA8obptGq6GWP2eu/11399bb69bHBC2q10H1XQ36Xxpxi5DX/0VFYS
         DAaQ==
X-Gm-Message-State: AA+aEWY+Tn5OkCvjF1YTl12kGCTk9ajZGIKknLbEhrRdjpAvJn7F8WLW
        4e4JlMdCv1arMDCpV83WFWUcA1kIxe0=
X-Google-Smtp-Source: AFSGD/W6Hre/gdK+mTdfw4ztRfV2NrdaQDbOHp+F/PoI7oiZDkdee4oJ8U4kfIS3DcrM2sKLdAh78A==
X-Received: by 2002:a25:7ac1:: with SMTP id v184-v6mr15989566ybc.115.1543367864756;
        Tue, 27 Nov 2018 17:17:44 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id l140sm2728968ywe.77.2018.11.27.17.17.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 17:17:43 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id h187-v6so9930374ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 17:17:42 -0800 (PST)
X-Received: by 2002:a25:a22a:: with SMTP id b39-v6mr22466801ybi.209.1543367862381;
 Tue, 27 Nov 2018 17:17:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 17:17:41
 -0800 (PST)
In-Reply-To: <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
References: <20181112171144.GI3645@cisco> <87efbqi1xa.fsf@xmission.com>
 <20181112185538.GK3645@cisco> <20181112192443.GL3645@cisco>
 <20181127232126.GA23658@cisco> <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Nov 2018 17:17:41 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
Message-ID: <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
Subject: Re: siginfo pid not populated from ptrace?
To:     Tycho Andersen <tycho@tycho.ws>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 4:38 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Nov 27, 2018 at 3:21 PM, Tycho Andersen <tycho@tycho.ws> wrote:
>> On Mon, Nov 12, 2018 at 12:24:43PM -0700, Tycho Andersen wrote:
>>> On Mon, Nov 12, 2018 at 11:55:38AM -0700, Tycho Andersen wrote:
>>> > I haven't manage to reproduce it on stock v4.20-rc2, unfortunately.
>>>
>>> Ok, now I have,
>>>
>>> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1493) == info._sifields._kill.si_pid (0)
>>> global.syscall_restart: Test failed at step #22
>>
>> Seems like this is still happening on v4.20-rc4,
>>
>> [ RUN      ] global.syscall_restart
>> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1901) == info._sifields._kill.si_pid (0)
>> global.syscall_restart: Test failed at step #22
>
> This fails every time for me -- is it still racey for you?
>
> I'm attempting a bisect, hoping it doesn't _become_ racey for me. ;)

This bisect to here for me:

commit f149b31557446aff9ca96d4be7e39cc266f6e7cc
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Mon Sep 3 09:50:36 2018 +0200

    signal: Never allocate siginfo for SIGKILL or SIGSTOP

    The SIGKILL and SIGSTOP signals are never delivered to userspace so
    queued siginfo for these signals can never be observed.  Therefore
    remove the chance of failure by never even attempting to allocate
    siginfo in those cases.

    Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

They are certainly visible via seccomp ;)


-- 
Kees Cook
