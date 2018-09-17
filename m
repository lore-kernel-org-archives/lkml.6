Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27414ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2769214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QpE+v3pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2769214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbeIREhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44404 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeIREhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZCL3HgdmOEscZMRp29ovpQdUgumnD0V9H/8hzqWR4NU=; b=QpE+v3pehnsgJlDvNRH1e85z7
        mWeNNZHTt//5SyZYrFdzX0GUrv5JkWinTyPStqpSvphRtYZByGAyBGa76mcV9umyCBQ8I3B5zUMN0
        ly7ib1FGcxIYA/obtfeu4RfBNwyG/zLnO0FquG34wcacpntPP95oMKMi58k1ML6+2/Odh5Fu1nJmn
        ULsbDB8Ad+5vRMcz6b5v7duE529h00FdHiGHJ1+I3XDoJ1UJ4TXRy21o04tgFrRdVKxabaFM5ozJp
        tVQKxOkKdJr+37/aZaOqcN5lA9e2LD0T7k+oEwO07U1sS0PfL5weQuYGSxrpeH5GkMb7S1rp766V2
        CbgUK8Y5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g22ca-00074r-2V; Mon, 17 Sep 2018 23:08:00 +0000
Received: by worktop (Postfix, from userid 1000)
        id 2AE226E0A92; Tue, 18 Sep 2018 01:07:58 +0200 (CEST)
Date:   Tue, 18 Sep 2018 01:07:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/6] perf/core: Add helper to obtain performance
 counter index
Message-ID: <20180917230758.GA3117@worktop.programming.kicks-ass.net>
References: <cover.1536685533.git.reinette.chatre@intel.com>
 <6f93048a74c66a275f8eb6e1298f10552d1e5d95.1536685533.git.reinette.chatre@intel.com>
 <20180917082336.GP24124@hirez.programming.kicks-ass.net>
 <fdb736aa-3c2a-67d3-473f-b5a2a7d2c0e5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdb736aa-3c2a-67d3-473f-b5a2a7d2c0e5@intel.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 09:37:14AM -0700, Reinette Chatre wrote:
> On 9/17/2018 1:23 AM, Peter Zijlstra wrote:

> > I said arch/x86/include/asm/perf_events.h and call it:
> > x86_perf_rdpmc_index().
> > 
> > This function is very much x86 specific.

> Moving it to arch/x86/include/asm/perf_event.h is not trivial since this
> file is not familiar with struct perf_event.

Urgh, right you are. Does it work if you make it a regular function
instead of an inline? Put the thing in arch/x86/events/core.c or so and
only an extern decl in asm/perf_event.h.
