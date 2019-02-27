Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFFCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFE021734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551267553;
	bh=W+gQquKt0qM0wI3W5Fbfeh192JvhRmWyaa89JadvxvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=n/4sJxSxSrqVnGRz6SX1DV50pmLP/9iGVxYs28UIpqgwvMMwaNSHMHM3mLuGKoBX9
	 si1jsfuNT+eO+mF0oFZ3nXL9K/npF2nqiKy+ucw06K49ZZGuRgWT/OZAhbFzbwQ8qB
	 oK+37LzSKtZ3PgTDGJTvnPYSNP7kNHfR9VUCSRAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfB0LjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:39:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfB0LjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 06:39:11 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABECE20C01;
        Wed, 27 Feb 2019 11:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551267550;
        bh=W+gQquKt0qM0wI3W5Fbfeh192JvhRmWyaa89JadvxvA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m06nZvHLvocjOH1w/cCzaikYoynNhS4CWmmDPaLiGap5DwFZRMFoIJk6cqD0j4qdJ
         5cRXy73G36ipO9y04MLFj6C1Zfc/TzZxgjLc2sL+lAC624clIQYI5DRT8Vn/8VdhMD
         u87xFFjkao+SYiKDOYQPOGp+YHKkmEIXpl77v65E=
Date:   Wed, 27 Feb 2019 20:39:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [RFC PATCH 0/4] tracing/probes: uaccess: Add support user-space
 access
Message-Id: <20190227203906.c4f2e1bf1def44f32e37758e@kernel.org>
In-Reply-To: <20190227080034.GJ32494@hirez.programming.kicks-ass.net>
References: <155110348217.21156.3874419272673328527.stgit@devbox>
        <20190226213850.GA219025@google.com>
        <20190227164104.5f53f029a7fec898204e9b67@kernel.org>
        <20190227080034.GJ32494@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 09:00:34 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Feb 27, 2019 at 04:41:04PM +0900, Masami Hiramatsu wrote:
> > 
> > IMHO, checking in access_ok() inside it is reasonable, but as it
> > commented, it is for "if pagefaults are enabled.". What we need another 
> > access_ok() for the case when pagefaults are disabled, that is what PeterZ
> > suggested in below mail.
> > 
> > https://lore.kernel.org/lkml/20190225150603.GE32494@hirez.programming.kicks-ass.net/T/#u
> 
> FWIW, feel free to carry that patch with your other changes that require
> it.
> 
> You can add my SoB if you write the Changelog ;-)

OK, I'll send v3 patch including your fix :)

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
