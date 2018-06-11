Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gs8CNWuEHlsUGwAAmS7hNA
	; Mon, 11 Jun 2018 14:18:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6C7AB607BB; Mon, 11 Jun 2018 14:18:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X4ZGc+hB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0B0CA60351;
	Mon, 11 Jun 2018 14:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B0CA60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934121AbeFKOR5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:17:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933534AbeFKORw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c9JGmXcXEjBX4HtNBYNB06krYjNwA+3mpPGd6VgAfZk=; b=X4ZGc+hBnyU8MS/2o/N3XUUDv
        1kUZLPxOg7ldwM79RbbFcbtEdCcAFllK/JRGTtVVIVQ+0SMSm1MNBoZ8VL3Z4WZTGtqVSUIpJi+zp
        N4SdZ1EqtR4QcLPwmsckI6OZR89EJI/UomFvlNAaBupi95fMcuvGVB48JVMoHkAej3cvpTnuX2ehO
        5jNPadtpwExUy3T9EkTb6XV6I2ftoDQUG4tifrOMiEU8sDYU0IveQq8zeiEt3U6/e0OVIMSQjmbrF
        8R/fGRlssrakhI0isZxaEd+13X/SwuQ7hCgVC4YEu6I6Tssdl2fHvgID0KODB9csnVBHOfhSPKBeZ
        2VAvIAouQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNdg-0006lt-KZ; Mon, 11 Jun 2018 14:17:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04C5E201EA7A5; Mon, 11 Jun 2018 16:17:43 +0200 (CEST)
Date: Mon, 11 Jun 2018 16:17:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jeremy Cline <jeremy@jcline.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, len.brown@intel.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        Diego Viola <diego.viola@gmail.com>
Subject: Re: Regression: x86/tsc: Fix mark_tsc_unstable()
Message-ID: <20180611141742.GP12198@hirez.programming.kicks-ass.net>
References: <01000163ef24c875-daa2c00e-611e-4383-99a6-c8c72ef04a14-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000163ef24c875-daa2c00e-611e-4383-99a6-c8c72ef04a14-000000@email.amazonses.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 01:59:15PM +0000, Jeremy Cline wrote:
> A user has bisected the problem to the v4.16 commit 1ab4ca7c59d4
> ("x86/tsc: Fix mark_tsc_unstable()"). According to the reporter,
> explicitly setting "tsc=" on the kernel command line causes the boot to
> always succeed. All the users have Thinkpad T500s or T400s (Core 2 Duos)

Weird. So Core2 typically triggers mark_tsc_unstable() in either
intel_idle or processor_idle. ISTR testing that when I did the patches.

When I make that mark_tsc_unstable() in the idle drivers unconditional
and boot my ivb with that, it doesn't want to fail. I've booted the
machine 5 consequctive times without issue.

Let me try and checkout -stable, maybe something's up with that.
