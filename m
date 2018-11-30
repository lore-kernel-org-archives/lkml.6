Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F0AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4229F206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4229F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeK3WiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:38:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeK3WiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:38:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FB683082141;
        Fri, 30 Nov 2018 11:29:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id 20E4F61081;
        Fri, 30 Nov 2018 11:29:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 30 Nov 2018 12:29:26 +0100 (CET)
Date:   Fri, 30 Nov 2018 12:29:21 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        strace-devel@lists.strace.io
Subject: Re: [PATCH v4 1/2] ptrace: save the type of syscall-stop in
 ptrace_message
Message-ID: <20181130112920.GD23670@redhat.com>
References: <20181128130439.GB28206@altlinux.org>
 <20181128130601.GC28206@altlinux.org>
 <20181128134913.GC30395@redhat.com>
 <20181128140533.GF28206@altlinux.org>
 <20181128142006.GE30395@redhat.com>
 <20181128152346.GG28206@altlinux.org>
 <20181128221125.GA2800@altlinux.org>
 <20181129144742.GB10645@redhat.com>
 <20181129211044.GA20529@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129211044.GA20529@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 30 Nov 2018 11:29:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30, Dmitry V. Levin wrote:
>
> On Thu, Nov 29, 2018 at 03:47:43PM +0100, Oleg Nesterov wrote:
>
> > > so that PTRACE_GETEVENTMSG users can easily tell
> > > whether this new semantics is supported by the kernel or not.
> >
> > Yes. And how much this can help? Again, an application can trivially detect
> > if this feature implemented or not, and it should do this anyway if it wants
> > to (try to) use PTRACE_EVENTMSG_SYSCALL_ENTRY/EXIT ?
>
> How an application can easily detect whether this feature is implemented?

As I already said, it can just do ptrace(PTRACE_GET_SYSCALL_INFO, NULL) ?
If it returns -EIO then this feature is not implemented. Any other error
code (actually EINVAL or EFAULT) means it is implemented.

Oleg.

