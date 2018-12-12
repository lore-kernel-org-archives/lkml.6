Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59781C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128B32084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a9XS/cbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128B32084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeLLSGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:06:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbeLLSGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3fQI/6AQd+D3CBYXnBJryEqNUq+UuHjPUoutHgfzl98=; b=a9XS/cbKAyMLqWH1H29u5/CJ8
        o7d4ACP/WIMy5bOCJjMHNP4ROi4s5Qm0BXRpkT0lyIsfmHvG5at2YB4z8jkPKvnd3qOXUYOFud5LK
        N4Src0qef5ZJXmYrhI3rA7cgE+yqJWvvilIxRjDOjBKWmluTlT5jU22f/IItSNTExlRjw9cz4uhoD
        OmO+vV6oY9JSm0gXs2LoWfGc7Tl4AbBGV2rpNlm5gxaASPRhpTyflgp7XpsQSyRBRs1Unw66AGYaS
        2yVQG9y/0Dwc9xKctXWOmq7GcUoV1YTwCWOKSgypbmy0/bnZqN8j5yWSZdUaczX8acKudVOFzGMSD
        FP7Ekvzeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gX8tP-00079S-7j; Wed, 12 Dec 2018 18:05:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90B332075BF47; Wed, 12 Dec 2018 19:05:53 +0100 (CET)
Date:   Wed, 12 Dec 2018 19:05:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20181212180553.GC5289@hirez.programming.kicks-ass.net>
References: <20181211233351.4036381-1-songliubraving@fb.com>
 <20181211233351.4036381-2-songliubraving@fb.com>
 <20181212131549.GZ5289@hirez.programming.kicks-ass.net>
 <C6E2C200-4C86-4EE0-97FA-228C0E0629B1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6E2C200-4C86-4EE0-97FA-228C0E0629B1@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 05:09:17PM +0000, Song Liu wrote:
> > And while this tracks the bpf kallsyms, it does not do all kallsyms.
> > 
> > .... Oooh, I see the problem, everybody is doing their own custom
> > kallsym_{add,del}() thing, instead of having that in generic code :-(
> > 
> > This, for example, doesn't track module load/unload nor ftrace
> > trampolines, even though both affect kallsyms.
> 
> I think we can use PERF_RECORD_MMAP(or MMAP2) for module load/unload. 
> That could be separate sets of patches. 

So I would actually like to move bpf_lock/bpf_kallsyms/bpf_tree +
bpf_prog_kallsyms_*() + __bpf_address_lookup() into kernel/kallsyms.c
and also have ftrace use that.

Because currently the ftrace stuff is otherwise invisible.

A generic kallsym register/unregister for any JIT.
