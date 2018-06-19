Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E72C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BA82083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UkjjTBnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BA82083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757307AbeFSObJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:31:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756821AbeFSOa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wiXYdNDX1A6oXT0bEeOp2BlHcqb7LpwyL0AmgVwPRG4=; b=UkjjTBnJIuQPMImC+E2d6k4Mt
        3qnYCnKQ6jq/Fx0/sXdzyjGnxD9YXbzvyGbBSlO4eajp2lE1AFautoQYxPwUz+hC2NlWZrQ+zht6e
        d/EWztwvx2L8Gf3AwVZsAw/CsXBf11usheLv//OWHvaGVdVg7QFZsOI9jwu+4gHmxdTxsRLJb9PGy
        DTGir+s+iE1LGBxSp/ZUCU0lmKe1GCh8dGzLlaTQdZLsLYA4UqvoloXOakcl8VU1Y0aRdKyFeaDdM
        AxlYx6eXqI1/DHmUvFRQVT+zn6apBugIoKJrKCXMUfOH/PK5zbNV2K0LQHMq6/ZV4RztbEFVz21vi
        j2qqtUCug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVHeg-0007Yp-UT; Tue, 19 Jun 2018 14:30:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3A6B20267E79; Tue, 19 Jun 2018 16:30:44 +0200 (CEST)
Date:   Tue, 19 Jun 2018 16:30:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180619143044.GB2512@hirez.programming.kicks-ass.net>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180619113408.GQ2458@hirez.programming.kicks-ass.net>
 <20180619125857.GY17720@e108498-lin.cambridge.arm.com>
 <20180619132338.GF2476@hirez.programming.kicks-ass.net>
 <20180619133844.GB17720@e108498-lin.cambridge.arm.com>
 <20180619141642.GE2494@hirez.programming.kicks-ass.net>
 <20180619142116.GA2512@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619142116.GA2512@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 04:21:16PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 19, 2018 at 04:16:42PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 19, 2018 at 02:38:45PM +0100, Quentin Perret wrote:
> > > But maybe I could use something simpler than a lock in this case ?
> > > Would WRITE_ONCE/READ_ONCE be enough to ensure that atomicity for
> > > example ?
> > 
> > Yes, since its a single pointer, smp_store_release() + READ_ONCE()
> > should be sufficient (these are the foundations of RCU).
> 
> Note that per_cpu()/this_cpu_read() and friends should imply READ_ONCE().

Mark reminded me that per_cpu() does not in fact imply that, but
READ_ONCE(per_cpu()) should work.
