Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 04642C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAADB208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="srMvNASc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAADB208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755376AbeFNTg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:36:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45274 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755316AbeFNTgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yQKQYCI3TtYE354OxjVFyVrXBrkPoOILXL7i5CxHakM=; b=srMvNAScQjladtnTYNXAnKVFR
        E/wxeh5/iHqEY8fIBnqhYW+FpX2jBDwc3unbzcgFKVo6P6LdX5YXTfAP+Ms75X1x2ZXuj7BhKsdRN
        yERGoueFVWxh6diBQBmEC0RiBzSa5ZIEnP1uu7o1CM5Fmu0FvwxKJ7Bgoq0P+ko1S2XnQgI9X4d7r
        thM6f3NRdw5JBmBs8x6olRVIatuLIz71p1qD5vZNHkCfJzKndtGeV7ZoaWGPAUQE/7S8GztKTRquS
        RLDIyRZ9DGwfmG1eEYO9R04s1p/uvnYhkQOVWycDknPf6zk5+s3Y6fB+yqB48SIT0XBb/xyzQ8DXq
        4GX1QD/vQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTY2d-0007cl-3W; Thu, 14 Jun 2018 19:36:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFD45201EA7C8; Thu, 14 Jun 2018 21:36:17 +0200 (CEST)
Date:   Thu, 14 Jun 2018 21:36:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 6/6] perf: Allow set-output for task contexts of
 different types
Message-ID: <20180614193617.GZ12217@hirez.programming.kicks-ass.net>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
 <20180612075117.65420-7-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612075117.65420-7-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:51:17AM +0300, Alexander Shishkin wrote:
> From: Adrian Hunter <adrian.hunter@intel.com>
> 
> Set-output must be limited to events that cannot be active on different
> cpus at the same time.  Thus either the event cpu must be the same, or
> the event task must be the same.

>                                  Current logic does not check the task
> directly but checks whether the perf_event_context is the same, however
> there are separate contexts for hardware and software events so in that
> case the perf_event_context is different even though the task is the same.

Thing is, __perf_event_task_sched_out() can lazy switch the different
contexts independently. So if someone breaks clone on either software or
hardware but not both, we'll flip only one ctx around and schedule the
other, completely breaking your assumption above.

> This patch changes the logic to check the task directly.

This Changelog completly and utterly fails to explain why though.

