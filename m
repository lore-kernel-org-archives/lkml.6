Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6B7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338962084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550764698;
	bh=jnfblnvzpcOe8w+JDNqPpjNAwy9zczrur4oLKML/PzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mytByzDwO5PKoOC4/TUMBxOW3pEOkd/nH721yNgd2DOxWSPbfukAWe845iinjmbSu
	 qWN4BXGh+6xmDMt+Z1vIfuaWVKDw74EovWZD3XfdrFgMijfU1uGgAOhFAOjK7K5KhL
	 MN5f9Vv2Tpg2N7mHdbyKaSYUCPrmVh2uLWeFaunI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfBUP6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfBUP6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:58:16 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9C902083E;
        Thu, 21 Feb 2019 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550764695;
        bh=jnfblnvzpcOe8w+JDNqPpjNAwy9zczrur4oLKML/PzE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lB/UEbzdYv7UjQdMXTesjehHmr4YKHz12hmAGSLVY+t8aHjm6WbrMaPGBPLFFbK8p
         FJAaoN+tyquS5G7jPZ93qf0DDuGPAFGygmgRUPeX4tpgGOPgYjqkUhi1K72wRFEXI6
         c0/0GZowHESpxUTaG/kQdPBGbJaei0ggmtNqPSHk=
Date:   Fri, 22 Feb 2019 00:58:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-Id: <20190222005812.04c5940c693b14cfdbe6ede7@kernel.org>
In-Reply-To: <20190221093625.56afccd2@gandalf.local.home>
References: <20190215174712.372898450@goodmis.org>
        <20190215174945.557218316@goodmis.org>
        <20190221165252.4a9033b3348f30f9d973dbc4@kernel.org>
        <20190221093625.56afccd2@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 09:36:25 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 21 Feb 2019 16:52:52 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Basically OK to me.
> > Could you use probe_kernel_read() in this context, since probe_mem_read() is a
> > wrapper function for template code.
> > 
> > With that change,
> > 
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> This already hit Linus's tree. I was able to reproduce the crash, so I
> streamlined it. I should have still pushed more for your ack first.
> Sorry about that.

Oh, never mind. That seems urgent issue for kprobe event.
Thank you very much for fixing it!

> For some reason, I thought the change was in the generic probe code,
> and accepted the probe_mem_read(). Anyway, did you want to send a patch
> to change it to probe_kernel_read(), for the merge window?

No problem.

> > And for the long term, I need to find more efficient (or smarter) way to do it,
> > like strnlen_user() does.
> 
> Agreed.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
