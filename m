Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DF7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F032087B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qcZCSSAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfBTLMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:12:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42126 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfBTLMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8QGenAOyUaWvUavoLeYUPdtQ2+95jyYbdI4z9qzzps8=; b=qcZCSSApKtdNyC2TDj7tpdzcJ
        oOdf49zyMcNYk4iJ4FUXIkQthsX92hfCprt8J441lKdyez2x51eBDZ6SChp3IB0Ltf4yEK5Z3yqT8
        bumNRAyf24vUXTvzGcS/lIN5CJ4ns5DvPuPtM6Ns4QvKJw54GSSNaJVWAIsgzwNabpmpYhT8uudhR
        PyPJia+5iGJ41RgJIXm/P8eR+ZtDflqOqieoolMOfbyOdI33uwF55hkkrNpOHlij/MPpq2HHNTBZD
        /CXSJo23fc2roBfr0ZlhixrrQrjFyUlDxQlO12+3gRZUcwMHcXUWilACLG285q46zM+qWhfZB1IS9
        XDaxsPR+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwPnf-0006Vn-Ib; Wed, 20 Feb 2019 11:12:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D979202BC404; Wed, 20 Feb 2019 12:12:26 +0100 (CET)
Date:   Wed, 20 Feb 2019 12:12:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, acme@kernel.org, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com,
        jolsa@redhat.com, namhyung@kernel.org, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH 01/10] perf/x86/intel: Introduce a concept "domain" as
 the scope of counters
Message-ID: <20190220111226.GG32494@hirez.programming.kicks-ass.net>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
 <1550606411-5313-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550606411-5313-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 12:00:02PM -0800, kan.liang@linux.intel.com wrote:
> It's very useful to abstract several common topology related codes for
> these modules to reduce the code redundancy.

>  3 files changed, 96 insertions(+), 1 deletion(-)

So you add 100 lines, so we can remove lines when we start to use this.

Except all 3 follow up patches that employ this, all add more lines
still:

 1 file changed, 184 insertions(+), 157 deletions(-)
 3 files changed, 164 insertions(+), 80 deletions(-)
 1 file changed, 224 insertions(+), 82 deletions(-)


