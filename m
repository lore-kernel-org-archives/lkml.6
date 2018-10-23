Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E63AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63E720652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ssy7RLmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63E720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJWQm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 12:42:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbeJWQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 12:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3hJRvoIl6+dIAR7VKncYG7G4ggseIO9swjtJz6FdSt8=; b=ssy7RLmG11QsXu/XAMTlDquAD
        5sfwceGiAJQFQ9h/ktkYd9ZA9bAGqVkyseJ9YsF04YcnSqeqnG/0+agFfED3Y77C9mdVovghJTwuk
        Jgy+ueckBib4U5pK97Zf8792vKWfUE0+Piz4K0KvXcLlUxP0yhNmLmcuO0YFJZHlkMh6s2j7t2gh1
        MavFm44fqn7wqdtISuZrjRRBgojQRe8SuCU1aciHAoIpfWZOBp4oGFnwVOjJxIJbNLXvg6GfWxAHI
        X8J4pMSrHeU/3waF6GwS4QSNRCJV2Zkd/ux3vYj4kFhyNltoS02XDbqRTYbSid5SmUiscQBuXqi43
        ZD3Yz4gcA==;
Received: from [185.7.230.213] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gErvL-0005Cj-EV; Tue, 23 Oct 2018 08:20:23 +0000
Received: by worktop (Postfix, from userid 1000)
        id CFFCB6E08B3; Tue, 23 Oct 2018 08:55:17 +0200 (CEST)
Date:   Tue, 23 Oct 2018 08:55:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "eranian@google.com" <eranian@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Message-ID: <20181023065517.GE3109@worktop.c.hoisthospitality.com>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <9DFB7D45-76CD-4E77-8360-FBCE1AD9A78F@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DFB7D45-76CD-4E77-8360-FBCE1AD9A78F@fb.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 06:13:29AM +0000, Song Liu wrote:
> This might be a little off topic...
> 
> What's you plan about this effort and the PMU sharing work 
> (https://lkml.org/lkml/2018/10/4/10)? Would PMU sharing work better/simpler
> with this effort? 

It is on my todo list to look at; sorry for being tardy :/
