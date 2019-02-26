Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048A5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C012421848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n2ybBfEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfBZRSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:18:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54882 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfBZRSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=63AhurtXGOF8ePBGYgo26nqcc0tEnN3D8KR69kpyXKI=; b=n2ybBfEASGqC4yNryWndctZWd
        Xwh6YVQBeZXZY7W6bxBdPBAUadEQNFVbSRGP8LHbcMdJ8NnZBkT0bJnVf6AYln0Ol+DhWcACivacR
        M8IuOIU9ZsGKLQy2AhwxjqeExFuIFKztgNy0fJrRElEZQQS5DB4oKF7xsLgiPs5Br8TdVpVt06Mr3
        KCHuGKVHp/9o+8ZsOsOi46CfZACcVKsMnU4R5TAcr7jkqY+hM1SbjV04+tgpbRnyW6x99RtKIEKbx
        lpdQgaKeNb/4Ui1DZubjmAX2/GFVb0UNTA0dIFb+vlcipgxbMsZN9G6HVfWkgC+V2I8KiHR8kVm3x
        RSZw8zZww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gygMa-0007Sm-R5; Tue, 26 Feb 2019 17:17:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 376802393C1E5; Tue, 26 Feb 2019 18:17:50 +0100 (CET)
Date:   Tue, 26 Feb 2019 18:17:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v7 18/23] locking/lockdep: Add support for dynamic keys
Message-ID: <20190226171750.GH32494@hirez.programming.kicks-ass.net>
References: <20190214230058.196511-1-bvanassche@acm.org>
 <20190214230058.196511-19-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214230058.196511-19-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 03:00:53PM -0800, Bart Van Assche wrote:
> +/* hash_entry is used to keep track of dynamically allocated keys. */
>  struct lock_class_key {
> +	struct hlist_node		hash_entry;
>  	struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
>  };

I think we can make that:

struct lock_class_key {
	union {
		struct hlist_node		hash_entry;
		struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
	};
};

I've added a patch to that effect at the end. IIRC we never actually
store anything in the subkeys, we just use the address.
