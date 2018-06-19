Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DAAC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84E520661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r0CzZWyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84E520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030398AbeFSSnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:43:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56078 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030279AbeFSSnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nvsakX3yIjrgAKKW3IMjW1d44N8LFBzBwvDWk+RPMbE=; b=r0CzZWyEwgLuiHbphREp2w8ym
        0qsPZt413+eTFcwF1evR7KJ5lz1Pr4wvXt3AaM+tedAiHyF9caljdp1tua4pOMF/hbWoQ3pyOHNkb
        8d2DDAtlReqdcec1tRWN/TrA3KX1H6+kS2Ql1Tvq750zcJJBYisH2/aqBheyXvYIm4t5KbuqqThSS
        22pS54bV3lvqrXeKO12Rsh0C7tl+WkZpYL2j2zXdv6KZJ5Mjte+JPx26WUCX0miNe0okN8D/e272N
        ijGRbvwtVQNHF82iSDZEsrJbEhkFnHNC0OshhMAP+TNoYqDwgF6o3CZLCwMCNM/4Sul2x0a6Dy3Cv
        ZYd6eUk1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVLaf-00078Y-MN; Tue, 19 Jun 2018 18:42:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB38D2026ACCB; Tue, 19 Jun 2018 20:42:50 +0200 (CEST)
Date:   Tue, 19 Jun 2018 20:42:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model
 of CPUs when available
Message-ID: <20180619184250.GF2494@hirez.programming.kicks-ass.net>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
 <20180619122632.GS2458@hirez.programming.kicks-ass.net>
 <20180619132449.GA17720@e108498-lin.cambridge.arm.com>
 <20180619162042.GT2458@hirez.programming.kicks-ass.net>
 <20180619171316.GB29374@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619171316.GB29374@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 06:13:17PM +0100, Quentin Perret wrote:
> I agree having one list per root_domain should be better. I'll change that
> in v4. But I also think the idea of a global static_key is broken then.

Static keys are global per definition, there is only a single copy of
the code.

You have to enable if there is a root domain with more than 1
freq-domain.

> We need a per root_domain thing as well. The SD_ASYM_CPUCAPACITY flag
> might be set on one hierarchy and not the other for ex. Not sure if
> attaching a static_key to each root_domain really makes sense though ...
> 
> Would replacing the static_key by a flag attached to the root_domain be
> reasonable ? 

Keep the static key as is, enable if any root domain needs it.

> > (and an empty list if there is but one entry on).
> 
> Sorry but I didn't understand that ...

If you have only a single freq-domain, there is nothing to do, right?
