Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED8AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B79208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yZgrxmc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B79208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934834AbeFRKp4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:45:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55166 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932851AbeFRKpz (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8wZUfSjWZ9BO98vsE+XDA11K53mp0MUkTRbJlX/blvE=; b=yZgrxmc6A408O72qZ3ZPF3duA
        8bdyI1Ppicxa71ECaCgQAewY2ofDfWa3TI0xXdVaym2B8Kd67Gh631575ZjBkoSPi/0PbQ33R01xI
        2vWFQW0+IkLWmNjYfptwk0qTQQ3K/70mBnO7OROOyF+JkTdB+q37dQRDSigBFmIIpPKK08tpMlric
        6JshKJh4yqHO7f1/NtVlbj6IED4x63JZYiPyON36Z6yz+p4F4V1NOUGgLpyqXhjAWztBKI3fitf88
        Rp6GOV+WaqP7kayWA6SF+yUIZ5ZAYmNioKERkpPb9c7moa66Tzs2dEbiN3kO79RJGlqq+lwHH2SrI
        LsA2JhvBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUrf3-0003vx-UO; Mon, 18 Jun 2018 10:45:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77F792029FA11; Mon, 18 Jun 2018 12:45:22 +0200 (CEST)
Date:   Mon, 18 Jun 2018 12:45:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, acme@kernel.org,
        jolsa@kernel.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, me@kylehuey.com,
        Linux-kernel@vger.kernel.org, vincent.weaver@maine.edu,
        will.deacon@arm.com, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping
 leaked kernel samples
Message-ID: <20180618104522.GI2458@hirez.programming.kicks-ass.net>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
 <20180615113608.6m74sm7gpl5p6oqe@lakrids.cambridge.arm.com>
 <52c75f12-1f91-405d-0b05-0aa6a9c09306@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c75f12-1f91-405d-0b05-0aa6a9c09306@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 02:55:32PM +0800, Jin, Yao wrote:
> Thanks for providing the patch. I understand this approach.
> 
> In my opinion, the skid window is from counter overflow to interrupt
> delivered. While if the skid window is too *big* (e.g. user -> kernel), it
> should be not very useful. So personally, I'd prefer to drop the samples.

I really don't get your insitence on dropping the sample. Dropping
samples is bad. Furthermore, doing what Mark suggests actually improves
the result by reducing the skid, if the event happened before we entered
(as it damn well should) then the user regs, which point at the entry
site, are a better approximation than our in-kernel set.

So not only do you not loose the sample, you actually get a better
sample.
