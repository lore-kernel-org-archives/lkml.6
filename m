Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3992CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9338421566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BmjqvUHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9338421566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbeHBT3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:29:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52020 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387423AbeHBT3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oJiz/8aARGFPY1OEeaUkxNLa5LQ0uhPtU2ayiEipenI=; b=BmjqvUHDHC2Mir8Okh8kC9m8j
        2v8ri5tiNJuTbJXJaqqL4MwL/qkhdbw0xA4DWWIV1jTtV2+IXO/4YhPq+qmFurDt0e/dY9dx3AKxG
        nQJic63ffK/Tm0OjHoqdihGUF8kT+rNTBGISRLmJcRQY6YSRAJosR+T/ZhGe7qCQGpDlzh9nYPhc5
        Hw5lsHvWmM9dH1wyNOGrbYVAlMtDjhS2Z5tBYAXZ69wal2uld1qw94Yq/a59OL6H0lYVh0vE1Zyjj
        QLgWep+OGee2XCDHWIpuzzTcatnHlLQ3BC5c95Or49825jvUKGjVZtfQO3nxvO+WD4JYJrqWf4B1F
        009HEOiXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flHXV-0004t1-Vb; Thu, 02 Aug 2018 17:37:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6A7B20267E4D; Thu,  2 Aug 2018 19:37:27 +0200 (CEST)
Date:   Thu, 2 Aug 2018 19:37:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, fenghua.yu@intel.com,
        tony.luck@intel.com, vikas.shivappa@linux.intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
Message-ID: <20180802173727.GP2494@hirez.programming.kicks-ass.net>
References: <cover.1533064851.git.reinette.chatre@intel.com>
 <20180802123923.GJ2530@hirez.programming.kicks-ass.net>
 <1af731f8-b5d3-5aca-af02-575802a961b9@intel.com>
 <20180802161823.GJ2458@hirez.programming.kicks-ass.net>
 <f990df31-ab75-974e-b142-47af07a33a08@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f990df31-ab75-974e-b142-47af07a33a08@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 09:44:13AM -0700, Reinette Chatre wrote:
> On 8/2/2018 9:18 AM, Peter Zijlstra wrote:
> > On Thu, Aug 02, 2018 at 09:14:10AM -0700, Reinette Chatre wrote:
> > 
> >> The current implementation does not coordinate with perf and this is
> >> what I am trying to fix in this series.
> >>
> >> I do respect your NAK but it is not clear to me how to proceed after
> >> obtaining it. Could you please elaborate on what you would prefer as a
> >> solution to ensure accurate measurement of cache-locked data that is
> >> better integrated?
> > 
> > We have an in-kernel interface to perf, use that if you want access to
> > the PMU. You will not directly stomp on PMU registers.
> 
> I do not see how I can do so without incurring the cache hits and misses
> from the data needed and instructions run by this interface. Could you
> please share how I can do so and still obtain the accurate measurement
> of cache residency of a specific memory region?

That's the best you're going to get. You do _NOT_ get to use raw PMU.
