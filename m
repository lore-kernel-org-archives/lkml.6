Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1FBECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A2B208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hBs90ARH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A2B208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeGPRp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:45:59 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35888 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeGPRp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:45:59 -0400
Received: by mail-io0-f193.google.com with SMTP id k3-v6so38526508iog.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yH3vDhVizbSYESjPGnLyyju4VuKGhQU3EBUpH+aRj1s=;
        b=hBs90ARH7A/vsbjBLIxGTTbrm2Lze9dY9K6r/rM3KRlv49N4Q0sJz3M+a185QRxRJf
         c7dEZ+nHpyCMQ0FXYtdjKbiXZ3ICbwkJV9gtEfnEQ47WCG1uWYuKMymHNSHkNEgNJdQS
         lPQZaLrf5qnO0fJk++2C9jrOo6whYNhFijXaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yH3vDhVizbSYESjPGnLyyju4VuKGhQU3EBUpH+aRj1s=;
        b=rP28yQQMY1K7xdTOopUmJiKG5BJAAURVDkEjNSTTtIcLk0Zn9sScWZZ22ywXBsv79e
         /rZ/f+0dk3zK/o9XsmZJVKIP8o7mcaw2gg/s+RLEKo0DfhCD7LvKm9F0NTc56BLi8taN
         LgIr7AbcCTfmvr66AgkE4tdAStaSOVLFu74CODlg5UHFWSxF1UY4zIPnt2RM0lW9l28c
         PGN3d/1d8M/ju2rT2C/Mtuo1WBZ94pIjYB1bwuTfQ1Ct5WrQdhZUxSgo5ifJWsn9qqn1
         1BQ1ImOQrLyUuXwxI1pyfMvSgyBz1EfVxVtleOLbVKa35o1KNkp/BWwAdRX71i0N++UO
         5IWA==
X-Gm-Message-State: AOUpUlGg/qLMwrFMDuADZuN5dM1Aeou/KRsscdsFajRIxHut2ifgOYb/
        +A7mLM4R11vBE1jmQGQEY/V1wI8wBYSFzAkxF58=
X-Google-Smtp-Source: AAOMgpdac1Jd/OSfAyOfRflh8OexKPxu7+KLv9M1CIVlxEZLFNxvFryyIq1Q2hLyOpEbWE1WdTtYbkYgZLArIjzwk3k=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr42223087ion.259.1531761457698;
 Mon, 16 Jul 2018 10:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <877em2jxyr.fsf_-_@xmission.com> <20180711024459.10654-7-ebiederm@xmission.com>
 <20180716125144.GA18262@redhat.com> <8736wjtetv.fsf@xmission.com>
In-Reply-To: <8736wjtetv.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Jul 2018 10:17:26 -0700
Message-ID: <CA+55aFxDsE8sb5wQQNJdxvt8m6n6aVpOo1yVpk1BEzXDv8XzaQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 07/11] signal: Deliver group signals via PIDTYPE_TGID
 not PIDTYPE_PID
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 7:50 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> In practice since glibc does not make thread id's available I don't
> expect anyone relies on this behavior.  Since no one relies on it we
> can change it without creating a regression.

Maybe.

However, possibly not.

The thing is, glibc wasn't the original or only use of our threads. In
fact, there are people out there that use clone() directly, without
using it for posix threading. And Oleg was right to notice this,
because the traditional model was literally to just use "kill()" on
the pid returned from clone().

So the semantics of Linux kill() really is to kill the thread, not the
group leader. glibc's implementation of pthreads is not the only model
out there.

Now, it is possible that at none of the legacy uses use CLONE_THREAD
and thus aren't affected (because tgid will always be pid). So maybe
nobody notices.

But we really have three different 'kill' system calls:

 - the original 'kill' system call (#37 on x86-32).

   This looks up the thread ID, but signals the *group*.

 - tkill (#238)

   This looks up the thread, and signals the specific thread.

 - tgkill (#270)

   This looks up the tgid, and signals the group.

Modern glibc will not even use the original 'kill()' at all, I think.
But it's the legacy behavior.

So I do think Oleg is right. We should be careful. You'll not notice
breakage on a modern distro, but you might easily break old code.

                 Linus
