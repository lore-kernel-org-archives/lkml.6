Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933894AbeCGQkm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933487AbeCGQkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:40:37 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5C32177C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELsE6SqLXew5nAiiK0nm4PVQByGu77jAik7HWKDUzadmcRji9HG9Gi3tO8RPPOWWu1VpotxQuKhH7Ey4JHxwfk0=
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1803071120410.15778@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1803071120410.15778@cbobk.fhfr.pm>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 7 Mar 2018 16:40:16 +0000
X-Gmail-Original-Message-ID: <CALCETrWhZ5ermtpfMt6UdLAC0M9mv7L_TsTfErGStPxznz-AWg@mail.gmail.com>
Message-ID: <CALCETrWhZ5ermtpfMt6UdLAC0M9mv7L_TsTfErGStPxznz-AWg@mail.gmail.com>
Subject: Re: [PATCH] audit: set TIF_AUDIT_SYSCALL only if audit filter has
 been populated
To: Jiri Kosina <jikos@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 10:32 AM, Jiri Kosina <jikos@kernel.org> wrote:
> From: Jiri Kosina <jkosina@suse.cz>
>
> There is no point going through all the audit slow path syscall entry/exit
> in case the audit daemon is running, but hasn't populated the audit filter
> with any rules whatsoever.
>
> Only set TIF_AUDIT_SYSCALL in case the number of populated audit rules is
> non-zero.
>
> Originally-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>
> This is basically resurrection / rebase of patch Andi Lutomirski sent some
> time back in 2014 or so.
>
> Andi, is there any reason this hasn't been pursued further? I think we
> still want to get some of the slow path performance back.
>

Wow, this was a long time ago.  From memory and a bit of email diving,
there are two reasons.

1. The probably was partially solved (by Oleg, IIRC) by making
auditctl -a task,never cause newly spawned tasks to not suck.  Yes,
it's a very partial solution.  After considerable nagging, I got Fedora
to default to -a task,never.

2. This patch, as is, may be a bit problematic.  In particular, if one
task changes the audit rules while another task is in the middle of
the syscall, then it's too late to audit that syscall correctly.  This
could be seen as a bug or it could be seen as being just fine.

--Andy
