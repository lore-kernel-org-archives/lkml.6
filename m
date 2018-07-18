Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BB2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB212084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nAMKFq9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB212084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeGRTDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:03:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47984 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeGRTDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ovTgJXDjiV/784XGqPdj5kGszXVFWaKKl2FdlmdTUR4=; b=nAMKFq9cS6lpnFA1VqKW++gLX
        T91k+QCnvYJRnZTW0g2n++rWP2fVoL9LioOEteSqtsd2fwEfzOLzyaUiX5lQT0l2tcKkJs1PPf03v
        5s6TiHy4esdCi78qqCgVBtM2KquRJ45XJcFirFD5WqI6koGpqU/+b7sbhtOwIg6tGb0WDSb5Ub8y0
        IFN7vGtRTejSeyewvCxUCGoSKZ2xNCvAIhox2bFKvIBIt3whVqBCoI90a/lCJyAuB4qSbiQT9Gbq5
        INp4z5SLOZ65hKAwlJqnQ8fRcFcCH6suoItLT68tbdMyziWvShOoJhxXOhF1PclYBhZB+5WhiCFZg
        8mosVapEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffr7K-000171-Jt; Wed, 18 Jul 2018 18:24:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE85520275F38; Wed, 18 Jul 2018 20:23:59 +0200 (CEST)
Date:   Wed, 18 Jul 2018 20:23:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     songliubraving@fb.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, torvalds@linux-foundation.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] x86/mm/tlb: Make lazy TLB mode lazier
Message-ID: <20180718182359.GW2494@hirez.programming.kicks-ass.net>
References: <20180716190337.26133-5-riel@surriel.com>
 <tip-ac0315896970d8589291e9d8a1569fc65967b7f1@git.kernel.org>
 <20180717113330.GU2476@hirez.programming.kicks-ass.net>
 <08AC2AF2-17DE-4416-BBBD-B6B950D20906@surriel.com>
 <20180718160007.GS2494@hirez.programming.kicks-ass.net>
 <081E558D-DB34-4A18-A35C-896BC47F6EBA@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <081E558D-DB34-4A18-A35C-896BC47F6EBA@surriel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 01:22:19PM -0400, Rik van Riel wrote:
> > On Jul 18, 2018, at 12:00 PM, Peter Zijlstra <peterz@infradead.org> wrote:

> > Also, I don't suppose you've looked at the paravirt instances of
> > flush_tlb_other() ? They don't elide the flushes because of lazy.
> 
> Let me look at those now :)

<snip xen>

> kvm_flush_tlb_other takes out preempted VCPUs from the flush mask, 
> before calling native_flush_tlb_others, so it should get the optimization 
> automatically.

Ah, ok. I wasn't entirely sure the new lazy was purely for the idle
case. But yes, the KVM paravirt thing should get the idle case right.

> Hyperv does ... sad magic.

Yeah,.. it got us to switch to 'rcu' freeing of page-tables and enabled
the kvm thing though, so that all is good :-)
