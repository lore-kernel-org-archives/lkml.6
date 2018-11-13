Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A71C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A93223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS3DOgAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A93223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbeKNEVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:21:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeKNEVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:21:02 -0500
Received: from devnote (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBCB521582;
        Tue, 13 Nov 2018 18:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542133306;
        bh=nGZXDGtXuCpyXV0BdKWObyawac9dSFmS+6jhuTXTrc4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hS3DOgAxCvD5pVcjl4PV6ClC3OkEm12bWnbhs2m8QQGF5r/wAFymp9DoM2CwozFhd
         juaEn0uPL6OLR0JwqmYqMwchbN0OQAmM4rtcDbI/tQQyMY6I3dpwLaEE6QGxIKhj0B
         tZcfpv9mEEX2xnhtXdM7FmlFoggcLTnPJCbyKcGE=
Date:   Tue, 13 Nov 2018 10:21:45 -0800
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] stackleak: Disable ftrace for stackleak.c
Message-Id: <20181113102145.2274aedc6f9edaba681bfd3a@kernel.org>
In-Reply-To: <20181112122148.0fab4c7f@vmware.local.home>
References: <1541887530-16610-1-git-send-email-alex.popov@linux.com>
        <20181110183011.2290fc20@gandalf.local.home>
        <eeb7f5ee-1e2e-d37b-cca2-e0a29826e8eb@linux.com>
        <20181111205351.1874bb1e@vmware.local.home>
        <20181112115058.39e98750750c91eeb349cfdf@kernel.org>
        <31b45d77-7b49-3984-a1e5-17993f50eee3@linux.com>
        <20181112122148.0fab4c7f@vmware.local.home>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 12:21:48 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 12 Nov 2018 19:51:00 +0300
> Alexander Popov <alex.popov@linux.com> wrote:
> 
> > By the way, are there any other tracing/instrumentation mechanisms that should
> > be disabled?
> 
> ftrace and kprobes are pretty much the only ones that currently do self
> modification of code all over the kernel. Kprobes even more so than
> ftrace.

Right, since kprobes uses int3 or sw breakpoint exception for hooking into
the code, it consumes stack much more.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
