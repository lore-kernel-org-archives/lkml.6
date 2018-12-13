Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA70C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B07220989
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rENiGhGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B07220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeLMKIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:08:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeLMKIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QEGS9UZIzTSKcv9u0r4X/A1K8VcJujXRQzgKL+31vyk=; b=rENiGhGj1IdrDSLougaZd45hN
        fNGeYgWivWTswqfeYd3jJjmwiSQK+7N76rKAYcnD2jM+VMYVZMYI78eBkqFo+m1U2o3dJEB2pB9ai
        CuVkKbpiT9Gj98CtwnoanB1a2ac6MT0JHW6yzzOes64B8q96BQaFhfG5gCAz9YjYuAQxeIoIG44tQ
        mJDYt5Fm5o6Euikm1FrCGLTwUcDMBe4PFfNb7o1uMnBFMM4s+YN+tizXqOLBRFNMJYdkIAG0NIDYS
        IZSXmrqg6rX4JdiGihYbaJwzC27JktJh/c//oQYnEUJWvRm11ddOZKkurArvxr0LPPw1VG9XRbVoN
        izJY0DGiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXNuk-0008Kp-4J; Thu, 13 Dec 2018 10:08:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A26EA207261FE; Thu, 13 Dec 2018 11:08:16 +0100 (CET)
Date:   Thu, 13 Dec 2018 11:08:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181213100816.GC5307@hirez.programming.kicks-ass.net>
References: <20181207085839.GC2237@hirez.programming.kicks-ass.net>
 <20181207072701.5bc564c7@vmware.local.home>
 <20181207151105.GB5289@hirez.programming.kicks-ass.net>
 <20181207151433.20bf0399@vmware.local.home>
 <20181208104423.GE5289@hirez.programming.kicks-ass.net>
 <20181208123805.1c158665@vmware.local.home>
 <20181210101818.GJ5289@hirez.programming.kicks-ass.net>
 <20181213003938.GD24195@altlinux.org>
 <20181212202639.1978ec88@vmware.local.home>
 <20181213100149.GF5289@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213100149.GF5289@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 11:01:49AM +0100, Peter Zijlstra wrote:
>  - the wakeups side is icky; the best I can come up with is making the
>    data page R/O and single stepping on write fault, but that isn't
>    multi-threading safe.

We can emulate the instruction, that would actually work and be thread
safe. Just a small matter of decoding and interpreting any possible
write instruction ;-)
