Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A32C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E3E2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qDyTtmOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E3E2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeJBOyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:54:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47130 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJBOyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XJGToe+j9/mqvY8OCPGKjl7mFmSBeeVhm+0S97N2Ca4=; b=qDyTtmOxvpmpcmE1+4np13Xbq
        uhLe9Ip0TUq8aneRHKfsFPTFoI5MK8FKY4JYmu2hNuXFLJ/I/VL0QdXbMX09eXX8rY4XkdgERrj/o
        wIm7ieiZI9/DhfOfmTyNQXjApnOQlZRVh2cf0RhcNJqoFgNDfLTV2P/ODoX0gzwjL93Ua21o8RitI
        wOcrXzJxVh3VdIWraeyvM6++q6KqbYZjF8HOeYSuP4zwbxQ5x4k+z/Nfr1/U/UGAAjfEvD2QLDpUE
        9/hVJ1OQNvvJLKwZblF3b62pDYmNmFBLCKAc/f77mTlJI+ZfeLsu6x+RulrC7lgZNw1V+HcHte24y
        Ggjh4DvSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7Fmq-0003IJ-D4; Tue, 02 Oct 2018 08:12:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 017CE2025A358; Tue,  2 Oct 2018 10:12:06 +0200 (CEST)
Date:   Tue, 2 Oct 2018 10:12:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 RESEND] trace_uprobe: support reference counter in
 fd-based uprobe
Message-ID: <20181002081206.GS3439@hirez.programming.kicks-ass.net>
References: <20181002053636.1896903-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002053636.1896903-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 10:36:36PM -0700, Song Liu wrote:
> Changes v1 -> v2: Fix PMU_FORMAT_ATTR as Peter suggested
> 
> This patch enables uprobes with reference counter in fd-based uprobe.
> Highest 32 bits of perf_event_attr.config is used to stored offset
> of the reference count (semaphore).
> 
> Format information in /sys/bus/event_source/devices/uprobe/format/ is
> updated to reflect this new feature.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Peter Zijlstra <peterz@infradead.org>

Works for me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
