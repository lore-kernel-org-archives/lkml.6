Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB759C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC9F20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC9F20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbeKHBnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:43:47 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:39936 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeKHBnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:43:46 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C1DAC72CA56;
        Wed,  7 Nov 2018 19:12:44 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id B418F7CC774; Wed,  7 Nov 2018 19:12:44 +0300 (MSK)
Date:   Wed, 7 Nov 2018 19:12:44 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org, strace-devel@lists.strace.io
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181107161244.GA27809@altlinux.org>
Mail-Followup-To: Oleg Nesterov <oleg@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org, strace-devel@lists.strace.io
References: <20181107042751.3b519062@akathisia>
 <20181107112100.GA20419@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107112100.GA20419@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 12:21:01PM +0100, Oleg Nesterov wrote:
> On 11/07, Elvira Khabirova wrote:
> >
> > In short, if a 64-bit task performs a syscall through int 0x80, its tracer
> > has no reliable means to find out that the syscall was, in fact,
> > a compat syscall, and misidentifies it.
> > * Syscall-enter-stop and syscall-exit-stop look the same for the tracer.
> 
> Yes, this was discussed many times...
> 
> So perhaps it makes sense to encode compat/is_enter in ->ptrace_message,
> debugger can use PTRACE_GETEVENTMSG to get this info.

This would mean for the debugger an extra syscall invocation for each
syscall stop.  When strace doesn't have to fetch memory, it invokes three
syscalls per syscall stop (wait4, PTRACE_GETREGSET, and PTRACE_SYSCALL).
We definitely want to avoid adding PTRACE_GETEVENTMSG on top of that.


-- 
ldv
