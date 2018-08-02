Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF1C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86C5214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qzlbilNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86C5214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbeHBOgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:36:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58376 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732130AbeHBOgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Pii8l6UzTDMFVsEEYXI3f4EMFHca1mSUOZRFBYnMG8E=; b=qzlbilNjY3QDB/G0ItG85YLI8
        FJnbXIUZMEOGv47miKsdTrVWL/a0icElpF7BOqL65jd4NnuVo71K7rBD5ZzHNmRghmMwFACnCsWzR
        FdTu0EDN1bbuNTky0YiM6MnrayHgfsYFXuS0VXxzkCQLzBct30JxCtHBBjbe45AdZulGn5kY2iOR+
        DwzEzzyVpEI5lZRgzg+uweuh7J/hcedxdmEnhwP/ZzUDPkBNOC0BAWVMKzyXI1qWqklkLw+sgyb+/
        h9Gp6/az76BsWaiIWj/lqRA0q71ka8gUlseFpOD0hAFMcQdfRG/9y8oiZGVxAzNcqTjNrqo8GgGOl
        6ZjJ33VQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flCyf-0005VH-SI; Thu, 02 Aug 2018 12:45:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9ABDC2026826B; Thu,  2 Aug 2018 14:45:11 +0200 (CEST)
Date:   Thu, 2 Aug 2018 14:45:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     skannan@codeaurora.org
Cc:     Quentin Perret <quentin.perret@arm.com>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org, linux-pm-owner@vger.kernel.org
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
Message-ID: <20180802124511.GN2512@hirez.programming.kicks-ass.net>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com>
 <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180802123315.GV2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802123315.GV2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 02:33:15PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 30, 2018 at 12:35:27PM -0700, skannan@codeaurora.org wrote:
> > On 2018-07-24 05:25, Quentin Perret wrote:
> > If it's going to be a different aggregation from what's done for frequency
> > guidance, I don't see the point of having this inside schedutil. Why not
> > keep it inside the scheduler files? Also, it seems weird to use a governor's
> > code when it might not actually be in use. What if someone is using
> > ondemand, conservative, performance, etc?
> 
> EAS hard relies on schedutil -- I suppose we need a check for that
> somewhere and maybe some infrastructure to pin the cpufreq governor.

Either that or disable EAS when another governor is selected.

> We're simply not going to support it for anything else.

To clarify, it makes absolutely no sense what so ever to attempt EAS
when the DVFS control is not coordinated.
