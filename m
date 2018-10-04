Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7125C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D17E213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tF8b5S1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D17E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeJDQ3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:29:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeJDQ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZIMeokeig8RUrEQo+sVWgIPPQJDNecy0/idw547SOF0=; b=tF8b5S1wLhN9hhLLPOfFedrGa
        NpV/iESgX6auLO3rjH9v+gzGN6Yuahu9M7C1A7SBRN5eCEmHaK+KXerPsuvtHY4IdxtohFxYz730F
        xL17ImhnA0kOP/KgtxEUPVvAD5uFlJrBI2Q08L6S/myGsHor3hF9hXMJ8qitphy5aHzTzgvo1MQR3
        NceiKtkbcdvdD2ZO31YcEoRij4UFJ0h7MTMtB7WhurbuJPLUokZfPSycDBqHwv9mSKQkN3DBwyLwJ
        mSGwtKf4DkeUkTF3TiNsQ+u5rOITHkFgiWOgpUxXHrLe8m4OlqYMoRIIfD9giO6d8gALM+0jaSQ4N
        4VuF/9eSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g8046-0001Si-Ad; Thu, 04 Oct 2018 09:37:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22AA9202695A2; Thu,  4 Oct 2018 11:36:44 +0200 (CEST)
Date:   Thu, 4 Oct 2018 11:36:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@android.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Alex Shi <alex.shi@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
Message-ID: <20181004093644.GL19272@hirez.programming.kicks-ass.net>
References: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
 <1538638927-26846-2-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0iLAtfo0w=BE-G+YW1WAxXsAdveiRvNhBSkpVPsd+TC9A@mail.gmail.com>
 <4541426c-8c73-7fe6-b3b6-9707861564ce@linaro.org>
 <CAJZ5v0i+TMAeaMp8D8qGph1VZKg0L23RsqdPMEQ0xHhpTCHgQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i+TMAeaMp8D8qGph1VZKg0L23RsqdPMEQ0xHhpTCHgQA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 10:47:04AM +0200, Rafael J. Wysocki wrote:

> > The comment is irrelevant as the remaining function is used for
> > statistics in addition to the perf multiplier. It does exactly what the
> > function name is.
> 
> Which is my point.  It shouldn't be dropped entirely, but updated IMO.

But the function name isn't the problem.. the problem that any use of
the number is fundamentally broken.
