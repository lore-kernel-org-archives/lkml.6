Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83672ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7EE20881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eQV0BS4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7EE20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388612AbeGWQRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:17:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388115AbeGWQRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5UZcmUt5oaXoO6Kj0ow48JNGaBwuVVKG2U8tE/wpClQ=; b=eQV0BS4ovURWx1EXQmzxJ8I2h
        Mdu/ybY1S6//yzNYZ3NSFqXiOkPQRsCE2gMHtJoLp7OjYEq7dBEGBfrSMGjyHDDIqZ+Mjpwkg5mes
        HClf7E34LFj2pN1QUDcUpuL+tDnaxTfANk+Ozlxb3wOtfViCvjh0BSHZ7w8bn/aRE4pmsUMFWmuiE
        UwsjnQNeGhF7CHNcgPjnwtqPhU6tXDc2sTvyvdJGJ3fonunpGZQAULuh/QotBNLP6TQgtmwfeTuru
        3CWJHGJrfU0G6IO3DYrVODQ06r4e6r0nNRKBDB2d20hRtpGGp3Nr34zmHtcjU88uqVA1VvFvGCBkf
        NCtSNx69g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhcZB-0005t2-0X; Mon, 23 Jul 2018 15:16:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 785D320272168; Mon, 23 Jul 2018 17:16:03 +0200 (CEST)
Date:   Mon, 23 Jul 2018 17:16:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        vincent.weaver@maine.edu, jolsa@redhat.com, ak@linux.intel.com
Subject: Re: [PATCH 1/4] x86/perf/intel: Introduce PMU flag for Extended PEBS
Message-ID: <20180723151603.GC2458@hirez.programming.kicks-ass.net>
References: <20180309021542.11374-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309021542.11374-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 06:15:39PM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The Extended PEBS feature, introduced in Goldmont Plus
> microarchitecture, supports all events as "Extended PEBS".
> 
> Introduce flag PMU_FL_PEBS_ALL to indicate the platforms which support
> extended PEBS.
> To support all events, it needs to support all constraints for PEBS. To
> avoid duplicating all the constraints in the PEBS table, making the PEBS
> code search the normal constraints too.
> 

So I like PEBS_ALL.. what I don't like is that it seems to be mutually
exclusive with PEBS Load Latency.

Took the patches.
