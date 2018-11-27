Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ACCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A2620851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QemfJRMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A2620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeK1Kze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:55:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbeK1Kze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:55:34 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3172206B6;
        Tue, 27 Nov 2018 23:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543362959;
        bh=NwmAfCvjrtIu027XRWGklT99k8OoEMCM0fPWNpvoAg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QemfJRMV2NexJ1aagIkbv5ABn1RPDKSF5IcBHqwkQzIIQZfhArXbrpK8XuVzdL2aj
         DzNmuUB2fKXreUqHKB6OA8TaxauVO1xmSiZt+rvK2ib3TWH05DEvYvshcCa8fE08SE
         qMxT2c0A22c/GGWClHTC0yGWLiMbVacuUYc1Eg4Q=
Date:   Wed, 28 Nov 2018 08:55:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH] arm64: ftrace: Fix to enable syscall events on arm64
Message-Id: <20181128085555.a8987cbe18aa6d1d1f0a827e@kernel.org>
In-Reply-To: <20181127131859.79ce7da9@gandalf.local.home>
References: <CAA93ih1-xpm1P0suT6SNCc_ARvAfyBEwb0-uKFikM5k4CvG8jg@mail.gmail.com>
        <154333618522.27355.8094935453351562295.stgit@devbox>
        <20181127165848.GA19569@arm.com>
        <20181127131859.79ce7da9@gandalf.local.home>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Tue, 27 Nov 2018 13:18:59 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 27 Nov 2018 16:58:49 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> 
> > This looks fine to me, but I'm curious about whether this is supposed to
> > work with compat syscalls as well, where the prefix is "__arm64_compat_".
> > 
> > If we broadly follow the x86 lead, we'd have:
> > 
> > 	return (!strncmp(sym, "__arm64_", 8) && !strcmp(sym + 8, name)) ||
> > 		(!strncmp(sym, "__arm64_compat_", 15) && !strcmp(sym + 15, name));
> > 
> > Do we need to handle compat (i.e. 32-bit) tasks here?
> 
> Only if you want to trace compat syscalls as well ;-)

Actually I thought about that, but I found below comment in
arch/arm64/include/asm/ftrace.h

 * Because AArch32 mode does not share the same syscall table with AArch64,
 * tracing compat syscalls may result in reporting bogus syscalls or even
 * hang-up, so just do not trace them.

That's why I dropped compat syscall support.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
