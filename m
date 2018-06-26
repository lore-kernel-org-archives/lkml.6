Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC4EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C77926CD7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yg81cp+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C77926CD7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeFZPH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:07:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeFZPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l523Jc+3bpxRIDW2M0HQtHcTDrB9ndQPp3J4kXPJbHc=; b=Yg81cp+nSxR9Cug4f7KxO41uR
        7+ZlLGEuShKxBzXjK8tdWuY5mCjoRkwnAnzm4p+SSqUCcNsrm5F1VuI/jIyE1s69iGnqI1fYHzIl0
        ZJGN1cx8Bhtq2M+tgym56gERPZRvBlsobVll7mbY/67Sj+hQKET0qEo+4wdqsF14IFg0Iv6sIh6T9
        7xZr/VHlbgUr6m971qRGQCYxqzFkv8bgPh2XM7OJvVYb3y7u9A4OACbCaQasE5jNlUBxDm4TnMhuP
        ZHoQF88thoU5LzSwJmuZ0vJP3E9YYktr1JnXuDmrmwWfLCwExpLhU93b6X2Q4NXGviqpN5PnWYOYL
        vwDlcLO6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXpYf-0004To-VY; Tue, 26 Jun 2018 15:07:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A8512029FA0E; Tue, 26 Jun 2018 17:07:03 +0200 (CEST)
Date:   Tue, 26 Jun 2018 17:07:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v12 10/11] sched: early boot clock
Message-ID: <20180626150703.GC2458@hirez.programming.kicks-ass.net>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-11-pasha.tatashin@oracle.com>
 <20180625085543.GT2494@hirez.programming.kicks-ass.net>
 <20180625192320.kzmqkvmfh5aeuhhx@xakep.localdomain>
 <20180626090003.GA2458@hirez.programming.kicks-ass.net>
 <20180626112705.4dxrsd5acvobla5y@xakep.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626112705.4dxrsd5acvobla5y@xakep.localdomain>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 07:27:05AM -0400, Pavel Tatashin wrote:

> We start getting timer interrupts. Is it acceptable to move
> sched_clock_init() after late_time_init()?

After much puzzling and cursing, yes, I suppose that'll work.
