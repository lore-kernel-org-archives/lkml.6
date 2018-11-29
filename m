Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48576C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E192081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JkxQMZGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E192081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeK2XJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:09:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbeK2XJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H38HqaUv/H+8egw9M9bJBQ4gKWt4IizwB/Uo0FTFydI=; b=JkxQMZGvhsbjkv4KVBuM+gmcS
        OhEuM1dDDX9czCNw1uwTEkwMsQWlrvitQCDKNLopxoBOXsCyBZRLLM+9dLSvRvJFgRL7Pz6ULCLfv
        RKQW4yP7oL1URiiQFPLl1PcztWsDmSd1dQ2tBCXnRvcQAnOoZVq8zBocaN3YW0teOZ1AjM+h0vlKd
        9AMF1dzFqC68E29jbo+Lh3vxSS3kxfa2aG4JlbYssq4ogm31L7kBdwzOhVE1eyT6RFU/hED2hOFox
        fz/ncQHiuCK6B2MskC+MXlVanDxUcA17nQCogl/qE7YoKETNIHvKprameqcLIbruz5IxbiCDiZZ7r
        PZMfVMmcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSL3M-0000yb-BP; Thu, 29 Nov 2018 12:04:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8DFF2029FD58; Thu, 29 Nov 2018 13:04:18 +0100 (CET)
Date:   Thu, 29 Nov 2018 13:04:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/27] locking/lockdep: Add support for dynamic keys
Message-ID: <20181129120418.GI2131@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
 <20181128234325.110011-26-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128234325.110011-26-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:43:23PM -0800, Bart Van Assche wrote:
> A shortcoming of the current lockdep implementation is that it requires
> lock keys to be allocated statically. That forces certain lock objects
> to share lock keys. Since lock dependency analysis groups lock objects
> per key sharing lock keys can cause false positive lockdep reports.
> Make it possible to avoid such false positive reports by allowing lock
> keys to be allocated dynamically. Require that dynamically allocated
> lock keys are registered before use by calling lockdep_register_key().
> Complain about attempts to register the same lock key pointer twice
> without calling lockdep_unregister_key() between successive
> registration calls.

>  struct lock_class_key {
> +	struct hlist_node		hash_entry;
>  	struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
>  };

That hash_entry is purely for that double-register warning, right? I
wonder if we can do that differently; by always doing
register_lock_class(), and checking that state.
