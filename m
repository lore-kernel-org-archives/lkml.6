Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6744C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5918B2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gUd5ufkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5918B2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJBVLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:11:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4AMiJ06wJT0aqlGZntN890lxEZFNTF2KcatGwH9hxoQ=; b=gUd5ufkG/ByagFRv4cmkUZHLK
        tA5hHMHc7zjG862BsGSbL0hoHxGmWhzheJimSK+4wfLbs/lD7Zmpc/K3uEriB0rL5IIeR3910xz3v
        NWUv+kyvuQFRoDniev8YfhSYPTgl2jlE2F4hBeJqetiqWHIzr7gibXnudWsyVBTphMLF4jjUdxyl1
        1giBd0M4hODoBNrpR41erbfSm7BChWX/gYjtZipOvsjVQK13c1hxJzi6z77zXUwhI21x/6rbVrnXI
        Db0WG0+JU8+sm/rbcNVEKLk//WpzZSBXQwagvdm5GkL4H+Ge8v9ExVpZf6RwhuOh6WJCMYBp/A7DQ
        sa0qHiE6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7Lel-00012s-7y; Tue, 02 Oct 2018 14:28:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1E18202B9CBE; Tue,  2 Oct 2018 16:28:09 +0200 (CEST)
Date:   Tue, 2 Oct 2018 16:28:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] locking/lockdep: Make class->ops a percpu counter
Message-ID: <20181002142809.GH26858@hirez.programming.kicks-ass.net>
References: <1538157201-29173-1-git-send-email-longman@redhat.com>
 <1538157201-29173-5-git-send-email-longman@redhat.com>
 <20181002093907.GV3439@hirez.programming.kicks-ass.net>
 <20181002095543.GA55344@gmail.com>
 <dbc5a70a-91bb-d365-8977-2d88049e39bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc5a70a-91bb-d365-8977-2d88049e39bb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 10:10:48AM -0400, Waiman Long wrote:
> One alternative is to group it under CONFIG_DEBUG_LOCKDEP again. This
> metric was originally under CONFIG_DEBUG_LOCKDEP, but was moved to
> CONFIG_LOCKDEP when trying to make other lock debugging statistics
> per-cpu counters. It was probably because this metric is per lock class
> while the rests are global.
> 
> By doing so, you incur the memory cost only when CONFIG_DEBUG_LOCKDEP is
> defined.
> 
> What do you think?

Works for me.
