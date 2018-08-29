Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D5FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1888220867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2PW0vxDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1888220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeH2Ql4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:41:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52818 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbeH2Ql4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=COjqZmReYv6wVg8dlSBcrb0SxfyyNTJlBQxG6+ian+0=; b=2PW0vxDhyL9CyQwcUwGZELHcg
        9Z5aoLxU/bKq2fhY7EEqJrG0D8zfs+sW2fveQsjduPrivDXG0sB0Lx4sfPAUaNk8t7WWfHNTPvu2p
        MCf24gcsS8hU1xzuW+sV4cIBIUkZaDnmGJwis3Is1CTN3a8GQ1Rz4T91qk9L4qCzjOcP00wbycV/J
        3yq/NU7gLkbBzRFkbVeAYALhiisxABE6C30kVC2qnDnh2E0Ay2yX7yPYuqrTY8/zrM72clxdFuU0i
        3HbWZtvmxIxeF1fvxtN3Y275Sf3rg8FrGQxtAFqXUUYMNqtzF4VlTr5JNLUs0mDY3cpu6TjrLEHEw
        Phz9iKpsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuzqM-00014l-Oz; Wed, 29 Aug 2018 12:45:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 48C052059B9FD; Wed, 29 Aug 2018 14:45:03 +0200 (CEST)
Date:   Wed, 29 Aug 2018 14:45:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, kernellwp@gmail.com
Subject: Re: [PATCH] sched/schedutil : optimize utilization scaling for guest
 kernel
Message-ID: <20180829124503.GU24124@hirez.programming.kicks-ass.net>
References: <1535532702-3508-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535532702-3508-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:51:42AM +0200, Vincent Guittot wrote:
> Scaling the utilization of CPUs with irq util_avg in schedutil doesn't give
> any benefit and just waste CPU cycles when irq time is not accounted but
> only steal time.
> Add an internal _scale_irq_capacity() for scale_rt_capacity but scale
> cpu utilization in schedutil only if we are accounting irq time.

This makes a mess of things; also it doesn't really do what it says.

Even if we have CONFIG_IRQ_TIME_ACCOUNTING, that doesn't mean we do it,
just that it is capable.


