Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E5FECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D3721486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D3721486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeJSSno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:43:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbeJSSno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:43:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AFB6C050DF2;
        Fri, 19 Oct 2018 10:38:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id 609C117B6E;
        Fri, 19 Oct 2018 10:38:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 19 Oct 2018 12:38:13 +0200 (CEST)
Date:   Fri, 19 Oct 2018 12:38:10 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Message-ID: <20181019103810.GA23194@redhat.com>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
 <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
 <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
 <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com>
 <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
 <6F1FD9DA-5E86-42A2-8EAF-05F5D70FE2EF@vmware.com>
 <CALCETrWjeqMs7Z6auStk9VGT9vAn+U5REGE+=TBv1Yh4kmOF3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWjeqMs7Z6auStk9VGT9vAn+U5REGE+=TBv1Yh4kmOF3w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 19 Oct 2018 10:38:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18, Andy Lutomirski wrote:
>
> Oleg, the code in kernel/signal.c:
>
>                 preempt_disable();
>                 read_unlock(&tasklist_lock);
>                 preempt_enable_no_resched();
>                 freezable_schedule();
>
> looks bogus.  I don't get what it's trying to achieve with
> preempt_disable(), and I also don't see why no_resched does anything.
> Sure, it prevents a reschedule triggered during read_unlock() from
> causing a reschedule,

Yes. Lets suppose we remove preempt_disable/enable.

Debugger was already woken up, if it runs on the same CPU quite possibly
it will preemt the tracee. After that debugger will spin in wait_task_inactive(),
until it is in turn preempted or calls schedule_timeout(1), so that the tracee
(current) can finally call __schedule(preempt = F) and call deactivate_task() to
become inactive.

> but it doesn't prevent an interrupt immediately
> after the preempt_enable_no_resched() call from scheduling.

Yes, but this is less likely.

Oleg.

