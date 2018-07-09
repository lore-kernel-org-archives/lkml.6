Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357CDC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D963B20854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FLNAPTC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D963B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754440AbeGIJFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:05:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754214AbeGIJFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EhtPrH01DT5W2D2bi/NdA24mXUO99/NlC2563fNhnUQ=; b=FLNAPTC2uRLPMzg5+dKt12dtt
        l64FOpjYBPKhj7uhPNBpI+PDTSsOu2qtQ0PWxU5lnJdTOqu9/UuPCBTXW6JMOcyP1wuIqr1R5/ZPs
        vI366oEBKWf0csWdS8qSaGHKuZkEhCWG4e61DnBtMvfkVhTnW4rLcNwIHEcAcklp1KjpbxdFx2XxD
        BURtwQVpOiHUsl2YWkAYTUcmsQt9udNs+yfXbkYYW+wrljAR4TGZCBhfYQcrIAicjJwkjCmcroHZd
        8WXFaCBgcF4FO2hT88rtg5z3INFeC+Dusz/jM+I4CBvpo4tUt/E35cJMQwWL6ugbKb/X2GfbkMyvG
        oh4EXg6mQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcS6d-0005Yh-LU; Mon, 09 Jul 2018 09:05:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29A362028932D; Mon,  9 Jul 2018 11:05:14 +0200 (CEST)
Date:   Mon, 9 Jul 2018 11:05:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        x86@kernel.org, kvm@vger.kernel.org
Subject: Re: [patch 4/7] x86/kvmclock: Cleanup the code
Message-ID: <20180709090514.GF2476@hirez.programming.kicks-ass.net>
References: <20180706161307.733337643@linutronix.de>
 <20180706162049.585702951@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706162049.585702951@linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 06:13:11PM +0200, Thomas Gleixner wrote:
> -	native_write_msr(msr_kvm_wall_clock, low, high);
> +	wrmsrl(msr_kvm_wall_clock, slow_virt_to_phys(&wall_clock));

Does it matter that you went from an explicit native WRMSR instruction
to a potentially paravirt MSR thing?
