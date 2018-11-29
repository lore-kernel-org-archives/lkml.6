Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10494C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90C720868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b57HvBbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90C720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeK2Qmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 11:42:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbeK2Qmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 11:42:40 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E21C1206B6;
        Thu, 29 Nov 2018 05:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543469912;
        bh=Wg7SJ6frgwXp6Fb08biGS2Z2ahe164Bgoiwk8ChgJTA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b57HvBbOUfP2tssEdznisWKmb/qZql78U7eMzr9Tn4sAs87jbr6QHtPyrE7zZeD7d
         B0lpNefkWtY6lw/orNvu7bZKB5n9aSpFU/53LSKA0uUDVJZUuUHpeVeo0BFiqWXaJd
         R5CF+xmgvP99x/HZXdYviKXePr7iUL60KOi7G/Js=
Date:   Thu, 29 Nov 2018 14:38:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH] arm64: ftrace: Fix to enable syscall events on arm64
Message-Id: <20181129143829.5917e021741a2a883b28ea77@kernel.org>
In-Reply-To: <20181128195921.GA32668@arm.com>
References: <CAA93ih1-xpm1P0suT6SNCc_ARvAfyBEwb0-uKFikM5k4CvG8jg@mail.gmail.com>
        <154333618522.27355.8094935453351562295.stgit@devbox>
        <20181127165848.GA19569@arm.com>
        <20181127131859.79ce7da9@gandalf.local.home>
        <20181128085555.a8987cbe18aa6d1d1f0a827e@kernel.org>
        <20181128120502.GC24868@arm.com>
        <20181128092223.2a100448@gandalf.local.home>
        <20181128195921.GA32668@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 19:59:22 +0000
Will Deacon <will.deacon@arm.com> wrote:

> On Wed, Nov 28, 2018 at 09:22:23AM -0500, Steven Rostedt wrote:
> > On Wed, 28 Nov 2018 12:05:02 +0000
> > Will Deacon <will.deacon@arm.com> wrote:
> > 
> > > Ok! Then please add a comment to arch_syscall_match_sym_name() along those
> > > lines, and you can add my ack:
> > > 
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Shouldn't this go through your tree?
> 
> Yup; I'm hoping Catalin will pick it up as a fix for 4.20 (we take it in
> turns, so I'm looking at stuff for 4.21 atm).

OK, I'll add a comment about compat syscalls. BTW, this should be applied
to 4.19 too, since without this, no one can use syscall events on arm64.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
