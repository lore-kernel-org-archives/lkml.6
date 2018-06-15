Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 96D9AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D8D20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jkNxR2LD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D8D20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755952AbeFOHpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 03:45:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755925AbeFOHpN (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 03:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tuQhFlerIgYW+Pyntjohd18YxKK8bU5xgHtRqZmBctE=; b=jkNxR2LDOgiGWMaUjKT0hzmE2
        jNDZA+EPXr6E/ALD+huweNPmV+lKPJY1QqcWvx98HuEz1Z1+4X7+u5po5Ok0kcw9IKDOFcq9OttBX
        5CWr+KJIhI6XpZFzz6W19GX09dDKzL+g9LzCPUvRtG1oji3jPOCqMTN0YQqE9okbfVJB+WlMKLlSv
        cV/oVRWNGdGpO9XXWmQhje1H6CAHM1BmaEKHmLPqGVkjJQIXADmHMzuTCtjGTXvhocRq97l77POYS
        E4LQ06UPiKwlK25u/ZqsY0Mr12gO7GWUaI8dQmOYqjI1yjnjNPrYE5j6WZDKd54ST2j+A9Dqd8lwg
        seF5wQj5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTjPu-0001q6-Gy; Fri, 15 Jun 2018 07:45:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1721D2029FA11; Fri, 15 Jun 2018 09:45:04 +0200 (CEST)
Date:   Fri, 15 Jun 2018 09:45:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, me@kylehuey.com,
        Linux-kernel@vger.kernel.org, vincent.weaver@maine.edu,
        will.deacon@arm.com, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/2] perf: Drop leaked kernel samples
Message-ID: <20180615074504.GA2458@hirez.programming.kicks-ass.net>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 06:03:21PM +0800, Jin Yao wrote:
> On workloads that do a lot of kernel entry/exits we see kernel
> samples, even though :u is specified. This is due to skid existing.
> 
> This might be a security issue because it can leak kernel addresses even
> though kernel sampling support is disabled.
> 
> One patch "perf/core: Drop kernel samples even though :u is specified"
> was posted in last year but it was reverted because it introduced a
> regression issue that broke the rr-project.
> 
> Now this patch set uses sysctl to control the dropping of leaked
> kernel samples.

So what happened to the suggestion of keeping the samples but 0-stuffing
all the tricky bits?
