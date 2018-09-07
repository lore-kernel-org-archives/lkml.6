Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89618C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD532077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NdPR2FJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD532077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbeIGTFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:05:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIGTFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eoVD+e/iiDjmhTM8IEbTtRUmVZx/mTb5jewjouqlMaA=; b=NdPR2FJKz0hUTsFaPOorWxAEn
        enQuBJMHFBTKT3k8nE7kIB6rYL3SYv7XBQFbgUNQ2jstA6ihm58TXcHVeH0eENPDar4n6a/gCFRFs
        3epzJgkUGY7kNe1n4PlmvsyUGYtuQy4Q//xMhTXG1ceDWnP/4TUb7wPfJCTjtm+oOUqScaF3FHRRl
        z36OG3RrG1jzrQR0+rbGm1n+uw2+B1Ur46DA8kYU2CmTzu3Cg3yY26MiI/+A5G5dfxhP6qRT7eoGc
        ZbzyvfV7Is7zJ2xhZiQV9LuEY/y8nNpDG4oXkxB7IrB/8vZVZk2CvPAWGpsHcAuNaadZUMix77qMw
        Kh0qXn1mA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyHfu-0001ga-PO; Fri, 07 Sep 2018 14:23:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21C0C2024E442; Fri,  7 Sep 2018 16:23:53 +0200 (CEST)
Date:   Fri, 7 Sep 2018 16:23:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] perf: enum overflow in uapi/linux/perf_event.h
Message-ID: <20180907142353.GI24106@hirez.programming.kicks-ass.net>
References: <a70172863fa7d3c138f788b18d36524bd45b0a73.1536326078.git.christophe.leroy@c-s.fr>
 <20180907134246.GC24106@hirez.programming.kicks-ass.net>
 <ae32181d-37b2-1a13-3c72-66775e05ff88@c-s.fr>
 <20180907135817.GF24106@hirez.programming.kicks-ass.net>
 <7a086a56-a896-9513-7315-9d0d21b61a44@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a086a56-a896-9513-7315-9d0d21b61a44@c-s.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 04:15:33PM +0200, Christophe LEROY wrote:

> Ah yes, it seems that GCC is happy. So sparse should be fixed instead ?

Ideally, yes.

> Anyway, is it really correct to put this constant inside that enum, after
> PERF_SAMPLE_MAX  ?

It is a bit of a hack, agreed. What we do is use the top bit of that
word (u64) for some internal state. By placing it there (after MAX) we
ensure it is not available for userspace (trying to set it will return
in -EINVAL) and by keeping it in the enum we know that bit is
unavailable for future use.

I have a patch queued that puts a little comment on that:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=perf/urgent&id=34cad593c9ea350a1811ab718e64b36e5cde870c

(url is not stable, as I regenerate that git tree from quilt every so
often, but it should probably last the day).
