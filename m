Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE82C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E8A218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FPELVP/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbfAaKAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:00:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfAaKAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VK0OZ9iMKqQ3od+fbZz6q+HhdAOmQzusQ/VV/rRIMmk=; b=FPELVP/QOc9f3f0BCxUzMx69O
        E7GX7KazSofD+iIv4OZun3XeHHLf9tPUzeCmEoUQo2zdtBMU5szqhefVkpnINqJMKVr4LXIcxprOa
        y18q0R+nzviUsTJHrzODcRVABLGaRM3jPp9ramnnXNRwV3VUj/Jkta6xttBAsM9UBt+t/vbaA2UJE
        C4MvviASjP8J0tpVR40UPpe+3lEzd3F6oC64zYebYx4QJkF4do58sQbHwyya0UUmjV4t5A2kaeD/R
        hpLHx07KEiDLcwyLpi/IsaDybkcGXIqb4jkvR3+jCKc/zWXhgavk1DcgImarJdI+8/LhMK9L9S1sq
        0YZZsGvvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gp98m-0007o7-Au; Thu, 31 Jan 2019 10:00:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C070C20423039; Thu, 31 Jan 2019 11:00:09 +0100 (CET)
Date:   Thu, 31 Jan 2019 11:00:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20190131100009.GB31534@hirez.programming.kicks-ass.net>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131030136.56999-4-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:01:35PM -0500, Alex Kogan wrote:
> Choose the next lock holder among spinning threads running on the same
> socket with high probability rather than always. With small probability,
> hand the lock to the first thread in the secondary queue or, if that
> queue is empty, to the immediate successor of the current lock holder
> in the main queue.  Thus, assuming no failures while threads hold the
> lock, every thread would be able to acquire the lock after a bounded
> number of lock transitions, with high probability.
> 
> Note that we could make the inter-socket transition deterministic,
> by sticking a counter of intra-socket transitions in the head node
> of the secondary queue. At the handoff time, we could increment
> the counter and check if it is below a threshold. This adds another
> field to queue nodes and nearly-certain local cache miss to read and
> update this counter during the handoff. While still beating stock,
> this variant adds certain overhead over the probabilistic variant.

(also heavily suffers from the socket == node confusion)

How would you suggest RT 'tunes' this?

RT relies on FIFO fairness of the basic spinlock primitives; you just
completely wrecked that.
