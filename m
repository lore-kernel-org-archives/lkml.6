Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D2FC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB0A21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sJXgD7rN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB0A21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJDOoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:44:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48374 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeJDOoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LrNOzD3TfQFL2caf/QzqJBzZsuR7xM1xQhbhCHLruFo=; b=sJXgD7rNu07ugk6m1S9xnSkru
        EP4Q99MtxHfSKHF1nCPgc1qQ1QJ3fbvM+xcPXDgWGgWuFMW7u9gwfVNf4vtktbwdr3iVEO+05gk7D
        Zdkm55Nw5Mnh1qNT6haMpBwqiJDGZvvjYPIIYxA3Nr3FYpf1rzXzQ/4r9OKqcixIgY4+10DiKn/qF
        oH8h8GO7fEktLxwbtylOVdnHPKUgJlqCYhTx7EYLbeKeUXTZIWr0L3YtCMDeCfFWxTduIVPjWCQvL
        90sjiXbU5MWUwOnlVG2bs13+U3+gyiBLQCdv9xup7LLhdn1HV0Dl2ycWV/1vNe0buK4IDIsoCYWat
        iREc7XI1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7yQW-00073x-VO; Thu, 04 Oct 2018 07:52:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BF1020709440; Thu,  4 Oct 2018 09:51:57 +0200 (CEST)
Date:   Thu, 4 Oct 2018 09:51:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/6] cpuidle: menu: Fixes, optimizations and cleanups
Message-ID: <20181004075157.GF19272@hirez.programming.kicks-ass.net>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <CAJZ5v0jYvV_C5AVMf+FhNfqsJuveYDRVOYjuOC8+yi8DPf1N6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jYvV_C5AVMf+FhNfqsJuveYDRVOYjuOC8+yi8DPf1N6w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 08:55:45AM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 2, 2018 at 11:51 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > Hi All,
> >
> > This series fixes a couple of issues with the menu governor, optimizes it
> > somewhat and makes a couple of cleanups in it.  Please refer to the
> > patch changelogs for details.
> >
> > All of the changes in the series are straightforward in my view.  The
> > first two patches are fixes, the rest is optimizations and cleanups.
> 
> I'm inclined to take this stuff in for 4.20 if nobody has problems
> with it, so please have a look if you care (and you should, because
> the code in question is run on all tickless systems out there).

Looks ok to me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
