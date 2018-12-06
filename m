Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18759C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26BC20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tiu7Oz8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26BC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbeLFSa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:30:59 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45892 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbeLFSa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:30:57 -0500
Received: by mail-yb1-f196.google.com with SMTP id f6-v6so1185893ybg.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8zA2oFI7kLEza08UqU37PFOwA4GSQKRkAhhqMD2RU8=;
        b=Tiu7Oz8WuLTy4ErPQAZXUhh0/MrgcL011iqNypxW1vAoeVa2t1HoCwDZqS1U7jLQh/
         E0k0R1LK048tLwtgUbAMAyXxlUVB18nuMqD+gdwcx0N9WxWm3Q8AU3BYovKjnYk+kJDK
         Zewoovj2wE6S3zcJZIaXQl8lHGy3KM2D+wLvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8zA2oFI7kLEza08UqU37PFOwA4GSQKRkAhhqMD2RU8=;
        b=NlnrK8gsLpaOfOu53Kt29FyRBORkKxFoXusdIUHIzZSRm+lV7QbvIfGLGkqP2ybD9I
         La8u4vg4t02ArogxQajp6ogXazrWJAT4icltSW+w4o/73NZtezxHE9XZGpYTEwYi0rTq
         DLZizMk2JzFZr2MpIBUEvia9UyTU7ysNSX7iP6LTsDHNlSpJD4WSTrsPxCpIC1jrTfib
         Srn8ZpwTQCFSQzdZpoBdhVGGUYIIFJ6QweYu8mDGB7WA0u9a+yL7tgvwjNaeQPo6A4J2
         1v+Zn/lw6qj5j6SwsmWhcP+EFKHfVYKnO6U3c4OUFzyXA2G3XmgMKP1Rw0VDGBaAmdwP
         oYvw==
X-Gm-Message-State: AA+aEWaeg5/WLGHEe4bUyPP8xw/YDE1RvQUKYXhXiLPCG+MdlPxb4/RY
        DuWO+6tdfloYb+M2T+/wSL3zLX01kkw=
X-Google-Smtp-Source: AFSGD/WwqdmDnRtyXT+Dq08rplq8JPQV578++Dk+Yre9J+/SCMsQ9TDsqydfcr0SqpSeFd0sFpaDfg==
X-Received: by 2002:a81:39c4:: with SMTP id g187mr30461702ywa.468.1544121055924;
        Thu, 06 Dec 2018 10:30:55 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id m126sm253520ywd.39.2018.12.06.10.30.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:30:52 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id t18-v6so255351ybc.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:30:52 -0800 (PST)
X-Received: by 2002:a81:2890:: with SMTP id o138mr30677976ywo.168.1544121051760;
 Thu, 06 Dec 2018 10:30:51 -0800 (PST)
MIME-Version: 1.0
References: <20181206121858.12215-1-christian@brauner.io> <87sgzahf7k.fsf@xmission.com>
 <CAKOZuet4ayDu-54u2tO9tRDCgxa9JQ4avAiYS8xEtReN4MMhAA@mail.gmail.com>
 <878t12efg3.fsf@xmission.com> <20181206174129.taakmwekysbkaosu@brauner.io>
In-Reply-To: <20181206174129.taakmwekysbkaosu@brauner.io>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 6 Dec 2018 10:30:40 -0800
X-Gmail-Original-Message-ID: <CAGXu5jL8PciZAXvOvCeCU3wKUEB_dU-O3q0tDw4uB_ojMvDEew@mail.gmail.com>
Message-ID: <CAGXu5jL8PciZAXvOvCeCU3wKUEB_dU-O3q0tDw4uB_ojMvDEew@mail.gmail.com>
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Colascione <dancol@google.com>,
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
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 9:41 AM Christian Brauner <christian@brauner.io> wrote:
> I feel changing the name around by a single persons preferences is not
> really a nice thing to do community-wise. So I'd like to hear other
> people chime in first before I make that change.

I don't think the name is hugely critical (but it's always the hardest
to settle on). My preference order would be:

taskfd_send_signal()
pidfd_send_signal()
procfd_send_signal()
fd_send_signal()

But, agreed, I think fdkill() should not be used.

-- 
Kees Cook
