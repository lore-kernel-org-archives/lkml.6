Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73D2206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mu7XdSgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfAJPzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:55:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47592 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbfAJPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9rLe6q7TGOb74FBUwSmjWkg+y1QnCtkNuKYUt6E1KoQ=; b=Mu7XdSgYadr77jGNPVUGc4+kP
        jOXc9rG+MPG0aGAMTOTvIRjIgy8f9qt/9bjQdhSCg4H+1hlGwApH26wEXrEc7wIWnrO2sywSg5akj
        SBNSDS69H0s7YWie71Q2pX/Uvv3BsNdxQhAuyc8RAJFWyyuhw/tZw+5BQX15d1luH1qID8JpY8QjH
        IMo/hNfNAz1SgsQ74zL3vBdTukOXdAFKp9dTn8VMAzp4PSsPLvOqaeIGMpCkhs/6cnYcIsvRdhqTL
        sv5MA7ROn14ielp7NupRN2WGyIvw5YoUO8cB82bWU8KLhUGqT3nH9DemB2ZCCssBVbNkCZenEfwoD
        7Fm0XSF+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghcfm-00058E-IU; Thu, 10 Jan 2019 15:55:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54F7A2081518E; Thu, 10 Jan 2019 16:55:09 +0100 (CET)
Date:   Thu, 10 Jan 2019 16:55:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v5 11/15] locking/lockdep: Check data structure
 consistency
Message-ID: <20190110155509.GJ30894@hirez.programming.kicks-ass.net>
References: <20181217213002.73776-1-bvanassche@acm.org>
 <20181217213002.73776-12-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217213002.73776-12-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 01:29:58PM -0800, Bart Van Assche wrote:
> +	/* Check whether all classes occur in a lock list. */
> +	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
> +		class = &lock_classes[i];
> +		if (!in_list(&class->lock_entry, &all_lock_classes) &&
> +		    !in_list(&class->lock_entry, &free_lock_classes) &&
> +		    !in_any_zapped_class_list(class)) {
> +			printk(KERN_INFO "class %px/%s is not in any class list\n",
> +			       class, class->name ? : "(?)");
> +			return false;
> +			return false;

I'm thinking just one return statement will suffice ;-)

> +		}
> +	}
