Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D35C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457C32075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z8Wu6BS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457C32075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeIENVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:21:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58434 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIENVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=euO650ErHHFroJgFxx9JP66Mh2PFJ0AdVManSkZHYjE=; b=Z8Wu6BS8wUbfIjZZ8hIQEMGhx
        k/QnOBI7d9CD5AkKqx0bZjxT+A8kobj7vGIw0EBPOMQcWpXU/FbrN4NtEu8AgNFaEreUcL/I6/lwa
        mcFHSUGBezWLZU7QQzFwb6FN99OStmvK/yYETq4X3bxLU2J92cexp9BAh2gKOqKpvhZwgoRd27vkt
        jwmRTpA0jRDuZ/p0vFXgacm+ZnsQZqCAeoAOiQN8WQYvD50zEeBX72RQKg2HSB9uWjIhHdXId6ZMY
        sWhkp6bfpfqPxE7rv+mUNo6o4Ls3tSXIxrWpLSS4vA9bBKvSAMd02KPOob+RmZ1ixbttEG1W0mofw
        InySy7CPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxTXq-00042M-9u; Wed, 05 Sep 2018 08:52:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D018A20191BFB; Wed,  5 Sep 2018 10:52:12 +0200 (CEST)
Date:   Wed, 5 Sep 2018 10:52:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/1] perf/x86/intel: make error messages less confusing
Message-ID: <20180905085212.GS24124@hirez.programming.kicks-ass.net>
References: <20180823150732.11249-1-eduval@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823150732.11249-1-eduval@amazon.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 08:07:32AM -0700, Eduardo Valentin wrote:
> On a system with X86_FEATURE_ARCH_PERFMON disabled
> and with a model not known by family PMU drivers,
> user gets a kernel message log like the following:
> [ 0.100114] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.
> 
> The "unsupported .. CPU" part may be confusing for some
> users leading to wrong understanding that the kernel
> does not support the CPU model.

Send them back to first grade, such that they might learn to read?
