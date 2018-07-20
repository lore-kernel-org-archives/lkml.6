Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00172ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B6920856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0z0JJRaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B6920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbeGTQf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:35:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40324 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731939AbeGTQf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0KjDptHM3EYIRmgjkv4xWtAhehzOFoEPRTKtl/fxrGg=; b=0z0JJRaBgdNhwDy4LAm0sSgd7
        rQGIjDMMBP7D2wICf5YhVv27NKswkY+XQOQzodGYZt5IjyBy5IQBdunhvGGDgnB22EWOd8lEFxbCI
        qXQV2Jui/SZStLNLRgdP6Dfqc1kAeEu+VkcwHPOU9m5ea9SFgVDxefTNiBiEOKxWWTVFf96W/1Mtp
        W87nNwuJOo/SqaKz3iKe4kwK5fPufbLlzKPR2LyzCFvENHLkwoDAzDa56tzOMPRngboBHkl1Cj8JQ
        cCHCkSwaMROhlVEc3gnGM6gKxu8VTqvRIm/pFylPk+VGp2QFsIeFnMJ8hTwZIz5nVEE5oCWgiCKk2
        k8/uxf1rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgXby-0006Fs-NR; Fri, 20 Jul 2018 15:46:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5226C20275F3E; Fri, 20 Jul 2018 17:46:29 +0200 (CEST)
Date:   Fri, 20 Jul 2018 17:46:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH V3] sched/deadline: Update rq_clock of later_rq when
 pushing a task
Message-ID: <20180720154629.GS2494@hirez.programming.kicks-ass.net>
References: <ca31d073a4788acf0684a8b255f14fea775ccf20.1532077269.git.bristot@redhat.com>
 <20180720124615.GM2476@hirez.programming.kicks-ass.net>
 <20180720124821.GB2512@hirez.programming.kicks-ass.net>
 <20180720125329.GD3642@localhost.localdomain>
 <183815b1-50dd-9027-31df-a18a604719e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <183815b1-50dd-9027-31df-a18a604719e8@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 05:36:06PM +0200, Daniel Bristot de Oliveira wrote:
> Am I missing something?

Nothing, I was missing why exactly this was deadline only. Figured it
out now :-)

