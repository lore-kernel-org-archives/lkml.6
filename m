Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3147FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FD12081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ouWWw8YH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FD12081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeK2VOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:14:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbeK2VOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IMJpVXiytxGRxJD4JJI93mTdj9xn2lIZROq4kdVCULY=; b=ouWWw8YH2/DE6SRHWevKRjoJm
        UIuVxPJ0BN8b4N3I8YTgr6emORup7dbU/un59EQloBt4kOqqRGQxz7JBlObHZJvYvSadsK9VXDiGM
        7TUXwk6VuPbXNIIOqbJqn9NSaMwPCFVKz0QIS+4JWkl13W7R9InJdEgGkazYfpZPWXRmTmpWOyhcF
        o4ubMm6xPwN+2WPUqMNJXJAvfHLk5F8QTU0AUE0pKWl6Z4t9OGw9Lb5FVJzqQWIcMzW/zArrlRxf1
        Dew5cM+y/k2IfzwU8VCemUTuI4UibRrF5ogGkg8FfbhSSTP6YMKRVrca0gcRE/oIqXy0x6TL1LCzi
        lPkIq0gFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSJGk-0003xQ-8J; Thu, 29 Nov 2018 10:10:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE3D02029FD58; Thu, 29 Nov 2018 11:10:00 +0100 (CET)
Date:   Thu, 29 Nov 2018 11:10:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/27] locking/lockdep: Add support for dynamic keys
Message-ID: <20181129101000.GF2131@hirez.programming.kicks-ass.net>
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
> +/* hash_entry is used to keep track of dynamically allocated keys. */
>  struct lock_class_key {
> +	struct hlist_node		hash_entry;
>  	struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
>  };

One consideration; and maybe we should have a BUILD_BUG for that, is
that this object should be no larger than the smallest lock primitive.

That typically is raw_spinlock_t, which normally is 4 bytes, but with
lockdep on that at least also includes struct lockdep_map.

So what we want is:

	sizeof(lock_class_key) <= sizeof(raw_spinlock_t)

Otherwise, two consecutive spinlocks could end up with key overlap in
their subclass range.

Now, I think that is still valid after this patch, but it is something
that gave me pause.
