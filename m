Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B042C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A15620862
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f6vD4s5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A15620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754468AbeGIKtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:49:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbeGIKtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AU3VzjDuKP+hogjQcfzNF7swXQMTksQ5IubBbpoAgZk=; b=f6vD4s5+HHTM4r4XMJ91mXspk
        hudkWAETPeKnq1EVgj2Hptt3W9W/y9CvJtzs8uOkvb8iZC9a493nR+aNx7Lpu2C99ITrgZXf7lavV
        ngXxv0cLJ/FdfzBLeFECdwa0ndasI/LX+neTvzNPmCazq2X9RclhpY4GhmSEs1bEcuAxdwvqZsdVo
        envSIo4HGrNExD9MqypUCREIuVA1xes8KzIawW9Gux8bq0dKdQiob42gl8BhW5Odf/SWIGfwvfhuG
        obSBznWI7L7BFhwXpbisPzI/9EqwWlHQNHNs0LRQUdI+GqF65uN1tf0y+DOLhpXx1S+Ve8+uyc8sN
        GHliSK4AQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcTj0-00044B-QF; Mon, 09 Jul 2018 10:48:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 510A72029764D; Mon,  9 Jul 2018 12:48:57 +0200 (CEST)
Date:   Mon, 9 Jul 2018 12:48:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/cputime: Ensure correct utime and stime proportion
Message-ID: <20180709104857.GK2476@hirez.programming.kicks-ass.net>
References: <20180622071542.61569-1-xlpang@linux.alibaba.com>
 <b9363fa9-826f-611f-3ab3-27e50c03422a@linux.alibaba.com>
 <20180626154908.GE2458@hirez.programming.kicks-ass.net>
 <e1b69cf9-a3a7-ea67-7c0e-d67ac81f29f1@linux.alibaba.com>
 <20180705104632.GE2494@hirez.programming.kicks-ass.net>
 <bd275aff-61dd-557f-5b91-da4ce82f9501@linux.alibaba.com>
 <5a3354c1-d3fe-33dc-53cf-6eb621177052@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a3354c1-d3fe-33dc-53cf-6eb621177052@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:52:38PM +0800, Xunlei Pang wrote:
> Please see the enclosure for the reproducer cputime_adjust.tgz

No, I'm not going to reverse engineer something if you cannot even
explain what the problem is.
