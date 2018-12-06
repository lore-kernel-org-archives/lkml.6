Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79A3C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70ED52146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dJxwV+vd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70ED52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbeLFD1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:27:47 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39489 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeLFD1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:27:46 -0500
Received: by mail-yb1-f193.google.com with SMTP id s15so1525607ybk.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 19:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GgOaxFb0wS9eV+VCdVOjM9paHcEenGs+NuGYPceyNkc=;
        b=dJxwV+vdufvJ4v2jqmuv8rKOmaRaML57v37UQEQw9TIJnEA/ZjypDxK+q0HOQdAU5a
         9IxP97jH+7ZtMwpJecFtE+YrnfQmj4CWoqgOKX4sjoJ8hjMhF+fYFhNQFDZEkyMPPXyd
         mQSEgRIFjQ3HaESTvwysyBWCPs9pL5EtSCgUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GgOaxFb0wS9eV+VCdVOjM9paHcEenGs+NuGYPceyNkc=;
        b=AlED4Udt7brASormihMmBabcyr99z9pFanHl6LmlFBSAqbViBoxMrQlE/o1cvjpMec
         YmTWupfBU8hi+aNkgEYF4i17gaL9yiKjOjWOEKFKftOTPbp6jozNEN7LOQUtq150gfcg
         Myn7+gwU041udenB0uir6AdDXv0bCL//X1FFrt2nMDJSALeqzGjck6zX2jFUyGVPb930
         itVsQAvia7eAdL0Zida1cvvqF3kHuHFrN4mNTmJoAn83xsvwuYzmSNyKKA6RjflrEPsL
         2h+xCEveirDq010qD/1ex5RPl58zEv/w1isj2NruMPgWEO/SXySEae68MJ9pBOCsZM0Y
         3TnA==
X-Gm-Message-State: AA+aEWafN58VsRrSOqaBe6E8TgGry/khBOMRZI244iNjoq5hWIL6zY/2
        y6PvVMBtCi15S7XOADBgnSJpiOmhb6o=
X-Google-Smtp-Source: AFSGD/Xn5yqmT6k4+rOveHWCzdt5J0ZNY1FszdHHXrHuEtXjdv194A2sawGgDTS0zTcuE7SIbVrbaA==
X-Received: by 2002:a81:7045:: with SMTP id l66mr25972833ywc.194.1544066864760;
        Wed, 05 Dec 2018 19:27:44 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id y83sm10439543ywd.65.2018.12.05.19.27.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 19:27:42 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id a67-v6so10066673ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 19:27:41 -0800 (PST)
X-Received: by 2002:a81:2f0f:: with SMTP id v15mr28016653ywv.124.1544066861535;
 Wed, 05 Dec 2018 19:27:41 -0800 (PST)
MIME-Version: 1.0
References: <20181205092203.14105-1-christian@brauner.io> <87zhtjn8ck.fsf@xmission.com>
 <20181205205242.hxgba5opiapinj56@brauner.io> <CAGXu5jJgYyhUBgzfkkcHGtu6AcC4MBpfwcEoj3M=Y+8q0FZ_dA@mail.gmail.com>
 <20181206030810.jo5julsc4v5zy34z@brauner.io>
In-Reply-To: <20181206030810.jo5julsc4v5zy34z@brauner.io>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Dec 2018 19:27:30 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+MRVdo_qjRdiMVSOnm2+d46CsDqdjH21AyzY7e=WNp+Q@mail.gmail.com>
Message-ID: <CAGXu5j+MRVdo_qjRdiMVSOnm2+d46CsDqdjH21AyzY7e=WNp+Q@mail.gmail.com>
Subject: Re: [PATCH v3] signal: add procfd_send_signal() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 7:08 PM Christian Brauner <christian@brauner.io> wrote:
> As a sidenote I'm switching the name from procfd_send_signal() to
> taskfd_send_signal(). It seems to me the best way to handle Eric's
> request to reflect that we can eventually both signal tgids and tids.

Cool; sounds fine to me.

-- 
Kees Cook
