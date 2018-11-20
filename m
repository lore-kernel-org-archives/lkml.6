Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8063EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AC02080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGWdi3ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AC02080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbeKTKyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:54:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732399AbeKTKyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:54:20 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3BB5214D9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542673683;
        bh=0ABb1ctiMdVdAeLz1lt0xVWTc4C/BrpsdWdE+q1CLOk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lGWdi3ryESna+rIZjNw9nG3Re8wls5EtFRIaTpTSIthnYpda5y7RAoHMTIRijP5sA
         ZQfgeMNWlmkW+PIaXfJmUMZsSkyfipgy4py/aHT/Yuau0FGD1zOjZiOoPyHrjFPan3
         fsmNmrDK342VhXBB/DOVr8/K3V0ewma0R4sMud9w=
Received: by mail-wm1-f43.google.com with SMTP id g131so455838wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:28:02 -0800 (PST)
X-Gm-Message-State: AGRZ1gKzdz5upgRqVQp7ThjpVEBH7oPAKlB9bzwYkprenozQIFjE1tK2
        /Z9IuXZKiAg4yRS1/vuPtK9F4gY7nC+3XFOZYb2jAA==
X-Google-Smtp-Source: AFSGD/WZRPLLdJrK8vT/DT4/Cma1rHsDDW/mytH+4vb7bhL2uG+I3WcEUMYLq19Gxj19KieLyl0JkVQUpV/EMeNCnQ8=
X-Received: by 2002:a1c:bb42:: with SMTP id l63-v6mr232252wmf.32.1542673681110;
 Mon, 19 Nov 2018 16:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20181119103241.5229-1-christian@brauner.io> <20181119103241.5229-3-christian@brauner.io>
 <20181119223954.GA4992@cisco> <CAKOZuetQDziWeRLydHbDNv1abGM3LyF=WohLFvbzmtdT_+nBdg@mail.gmail.com>
 <20181119230709.GB4992@cisco>
In-Reply-To: <20181119230709.GB4992@cisco>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 19 Nov 2018 16:27:49 -0800
X-Gmail-Original-Message-ID: <CALCETrWyuQvTtksN1J1XbCFPka_rLOaFqa5W==EvGQvoaf9f3Q@mail.gmail.com>
Message-ID: <CALCETrWyuQvTtksN1J1XbCFPka_rLOaFqa5W==EvGQvoaf9f3Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 3:07 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > These tools also care about ioctls. Adding a system call is a pain,
> > but the solution is to make adding system calls less of a pain, not to
> > permanently make the Linux ABI worse.
>
> For user-defined values of "worse" :)
>

I tend to agree with Tycho here.  But I'm wondering if it might be
worth considering a better ioctl.

/me dons flame-proof hat

We could do:

long better_ioctl(int fd, u32 nr, const void *inbuf, size_t inlen,
const void *outbuf, size_t outlen);

and have a central table in the kernel listing all possible nr values
along with which driver they belong to.  We could have a sane
signature and get rid of the nr collision problem.

The major problem I see is that u32 isn't really enough to have a sane
way to allow out-of-tree drivers to use this, and that we can't
readily use anything bigger than u32 without indirection because we're
out of syscall argument space.
