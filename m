Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5huxKe3QGVvCPAAAmS7hNA
	; Fri, 08 Jun 2018 00:42:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8FAC36074D; Fri,  8 Jun 2018 00:42:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeVL0u3v"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DE853605A2;
	Fri,  8 Jun 2018 00:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE853605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752621AbeFHAmR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752178AbeFHAmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:42:15 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FEFB2087F;
        Fri,  8 Jun 2018 00:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528418535;
        bh=n6KDyK6WuIh2JMGkRzw+vqo/C7kSZM3VdG2XSN96vy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZeVL0u3vKHfzWZy1tdkBYKI0dB0CISblXjQMsySuxYKNjN9JbGqjv+dyCCTgnJCeu
         pQRVdoGBEvfiCsems6zTqpnnAfr9gmfVAFLBB+ApSIfRLQNndouM6Gko4XlPcprymY
         uwq3BH7b6RZMMy7BOHg6ioLjp8Q6pwLonla6PWq8=
Date: Fri, 8 Jun 2018 09:42:11 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH -tip v5 18/27] powerpc/kprobes: Don't call the
 ->break_handler() in arm kprobes code
Message-Id: <20180608094211.0d225831bb7acc100b7c2436@kernel.org>
In-Reply-To: <1528389409.62iyaqw9yn.naveen@linux.ibm.com>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
        <152812783350.10068.4690566636762511152.stgit@devbox>
        <1528371112.vwnh1m0k39.naveen@linux.ibm.com>
        <20180607232802.c5fcea960e94ef2f3cd4cde8@kernel.org>
        <1528389409.62iyaqw9yn.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jun 2018 22:07:26 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > On Thu, 07 Jun 2018 17:07:00 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> >> Masami Hiramatsu wrote:
> >> > Don't call the ->break_handler() from the arm kprobes code,
> >> 					    ^^^ powerpc
> >> 
> >> > because it was only used by jprobes which got removed.
> >> > 
> >> > This also makes skip_singlestep() a static function since
> >> > only ftrace-kprobe.c is using this function.
> >> > 
> >> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> >> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> > Cc: Paul Mackerras <paulus@samba.org>
> >> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> >> > Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> >> > Cc: linuxppc-dev@lists.ozlabs.org
> >> > ---
> >> >  arch/powerpc/include/asm/kprobes.h   |   10 ----------
> >> >  arch/powerpc/kernel/kprobes-ftrace.c |   16 +++-------------
> >> >  arch/powerpc/kernel/kprobes.c        |   31 +++++++++++--------------------
> >> >  3 files changed, 14 insertions(+), 43 deletions(-)
> >> 
> >> With 2 small comments...
> > 
> > 2 ? or 1 ?
> 
> Two, with one in the commit log above :)

Oops, sorry I missed it. yeah, the comment above is my mistake. I'll fix it.

Thanks!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
