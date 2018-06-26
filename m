Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE34C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4452660D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y1fxBcOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4452660D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbeFZHbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:31:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbeFZHbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wFKmCCMr/9QHxWFaodU87qz+JDdudOybdDbcl7nIgMg=; b=Y1fxBcOwT69bh9vC6muPN0J6g8
        9eQM+YCy8/CDmnKB/pb3mQlYtrx47VXpJfOwWwp3BsbQpO5XubgUb6ATozwQ0FAlFLPh8r0wk+9r+
        X9XtSdfn7xcXjg2l414oU4m74B831a4L0Gz0UTElOuSnd+/rq3y//G3kTqKSxJBbieSnoHWefwb+s
        4ArX1BeotSIM7YfKl9vlr5yI+AK+2Z/IWpBpWc5xeh/b5hsa40sKJhkmlzr2Hz2KQ07wsrkcnvqsa
        ExJsd81/6HHrzCVMEBF24WRw/PqCCdtligu48XGswwfEM1KYITg7lrwPUCxqQ5z0vcVo5IO2riNk8
        Qnxr3JpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXiRs-0003AM-PR; Tue, 26 Jun 2018 07:31:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DB242029FA0E; Tue, 26 Jun 2018 09:31:34 +0200 (CEST)
Date:   Tue, 26 Jun 2018 09:31:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
Subject: Re: [PATCH] RFC: siox: don't create a thread without starting it
Message-ID: <20180626073134.GW2458@hirez.programming.kicks-ass.net>
References: <20180625102056.28468-1-u.kleine-koenig@pengutronix.de>
 <20180625125105.GZ2494@hirez.programming.kicks-ass.net>
 <20180625192121.k3hx32xbbhqkyfu4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180625192121.k3hx32xbbhqkyfu4@pengutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 09:21:21PM +0200, Uwe Kleine-König wrote:
> > > So I wonder where the real problem is and how it can be fixed.
> > 
> > Without the first wakeup, the kthread will not run the provided function
> > and we can therefore argue the creation is incomplete. I really feel you
> > should just wake the thing up to land in your own wait-condition-loop.

> Is this an ack for the RFC patch you replied to?

Yes,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
