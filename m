Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884CDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505A3206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kPtcD0BO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfAHNLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:11:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50100 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfAHNLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RH/5lh2hI9xb1gFqv9RkB8AxW7I9vax/KHqnXcNAOZ0=; b=kPtcD0BOgYYx4w3+uLkJOFHfY
        aPy3Z9tsHajOvgIPDjACd9fLvlpcz86AAU9NX/b3MetRNl/II9/ZfJtmxMsaR4Ojbs0BKHu7aFPuh
        3GMH7jfC34bUOu+7k9/d70/8bjbyfIrD5dKQCQIhltSctV9MAu1tS44ksuQYrEpPBU3LaoKpTZjBU
        LLsHcmtnbXLemCSvNswgS3sSMho8SXIzG77q4cqfhpXwyI/T+EYtMTaS/rHqSmHlfrrvAcf9aEXww
        bcD9PnSs51+qndEegxOlVTNxWBpFEF2PHmf0/l3sH4sqS3QS4wQj1L7cmlrD4rTMiX7hocuqIOboo
        zIe48jn+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggr9O-0006v4-6L; Tue, 08 Jan 2019 13:10:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 837B82019FEBB; Tue,  8 Jan 2019 14:10:31 +0100 (CET)
Date:   Tue, 8 Jan 2019 14:10:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Russell King <linux@armlinux.org.uk>, suzuki.poulose@arm.com,
        robin.murphy@arm.com, Michael Ellerman <mpe@ellerman.id.au>,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-alpha@vger.kernel.org
Subject: Re: [PATCH v4 05/13] arm: perf: conditionally use
 PERF_PMU_CAP_NO_EXCLUDE
Message-ID: <20190108131031.GG6808@hirez.programming.kicks-ass.net>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
 <1546878450-20341-6-git-send-email-andrew.murray@arm.com>
 <20190108102802.GC6808@hirez.programming.kicks-ass.net>
 <20190108130740.GC56789@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108130740.GC56789@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 01:07:41PM +0000, Andrew Murray wrote:

> Yes I found lots of examples like this across the tree whilst doing this
> work. However I decided to initially start with simply removing duplicated
> code as a result of adding this flag and attempting to preserve existing
> functionality. I thought that if I add missing checks then the patchset
> will get much bigger and be harder to merge. I would like to do this though
> as another non-cross-arch series.
> 
> Can we limit this patch series to the minimal changes required to fully
> use PERF_PMU_CAP_NO_EXCLUDE and then attempt to fix these existing problems
> in subsequent patch sets?

Ok, but it would've been nice to see that mentioned somewhere.
