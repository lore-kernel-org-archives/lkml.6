Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171CFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA73C2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA73C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbeK3CJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:09:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbeK3CJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:09:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D629E83F3E;
        Thu, 29 Nov 2018 15:03:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id F1B6C842A7;
        Thu, 29 Nov 2018 15:03:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 29 Nov 2018 16:03:33 +0100 (CET)
Date:   Thu, 29 Nov 2018 16:03:28 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, strace-devel@lists.strace.io
Subject: Re: [PATCH v4 1/2] ptrace: save the type of syscall-stop in
 ptrace_message
Message-ID: <20181129150327.GC10645@redhat.com>
References: <20181128130439.GB28206@altlinux.org>
 <20181128130601.GC28206@altlinux.org>
 <20181128134913.GC30395@redhat.com>
 <20181128140533.GF28206@altlinux.org>
 <20181128142006.GE30395@redhat.com>
 <20181128152346.GG28206@altlinux.org>
 <20181128221125.GA2800@altlinux.org>
 <CALCETrVjMorQDsJzQGaREEB5_7B24ApWSoNQfRd3K3QNSGAyEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVjMorQDsJzQGaREEB5_7B24ApWSoNQfRd3K3QNSGAyEA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 29 Nov 2018 15:03:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28, Andy Lutomirski wrote:
>
> I don't like any of this at all.  Can we please choose a sensible API
> design and let the API drive the implementation instead of vice versa?

I too do not understand your concerns...

>  ISTM the correct solution is to add some new state to task_struct for
> this.

Sure we can do this. I have argued with the previous version not because
the new member blows the task_struct. Although I think it is better to avoid
this if possible.

But this doesn't affect the API.

Yes, this version uses ->ptrace_message but I think this is _good_ exactly
because it is already visible to userspace, so if debugger only needs to
distinguish syscall entry/exit it can simply use PTRACE_GETEVENTMSG without
PTRACE_GET_SYSCALL_INFO.

> If we're concerned about making task_struct bigger, I have a
> half-finished patch to factor all the ptrace tracee state into a
> separate struct.

I even sent the patch(es) which does this several years ago ;)

Oleg.

