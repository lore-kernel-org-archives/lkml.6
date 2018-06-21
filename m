Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61D9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888DF21E5B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FGVvafUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888DF21E5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbeFUUHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:07:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbeFUUG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lXg9TXZPPDt5ZOaHmKgjD55UOPu3lRFzxeUKise8as8=; b=FGVvafUtkp0esef/cyUZOXETz
        erRTN4Xbqb18+Nb0P8eHwL9GzwMzU0YFXSLpII5Kyl8loW23eVkYudqfOCXfBTwGj/wxzk0Lhi3Sf
        kB/NOGYBKzzuKPO3ih7moD76iNwHkuYVE66Vp7u6NsMGF0Y4ZsmAV6cgJ6ijYccWp9x3aIZOwc6tA
        xlRVkb7l4f9Vvn9lS/K4TMeCnXAr9+hjRzrrZTJK/EKm9RJKLxFycWoXF+e4kGzdU7lWHphFti66M
        qoBzQM6VcMTSjL07bSl1WdjkwRgAsAJ58g47SOPeEjOaGNxrOKtJhj/yPivBmmVlqWH7Re9pUT9lx
        /+2B4WAYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW5r7-0004U4-8O; Thu, 21 Jun 2018 20:06:57 +0000
Received: by worktop (Postfix, from userid 1000)
        id A87656E093E; Thu, 21 Jun 2018 22:06:54 +0200 (CEST)
Date:   Thu, 21 Jun 2018 22:06:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
Message-ID: <20180621200654.GE13636@worktop.programming.kicks-ass.net>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <b4d3e2d0-dfb1-fa1d-8430-0bcb124063e5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d3e2d0-dfb1-fa1d-8430-0bcb124063e5@intel.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 09:40:09AM -0700, Dave Hansen wrote:
> Split-lock-detection is a new hardware feature that generates
> alignment-check (#AC) faults to help detect when badly-aligned atomic
> instructions might impact whole-system performance.  These patches are
> primarily targeted at application-level issues, but we can also detect
> the same issues in the kernel.

Which is nice, Thomas and me spend quite a while searching for a perf
event that could tell us about unaligned LOCK insns a few months back
and could not find anything useful.

> There is a significant interaction
> between this feature and firmware because firmware may or may not be
> prepared for this feature to be enabled.

And allowing firmware to muddle through, instead of drawing a hard line
in the sand means we'll be stuck with crap firmware for at least another
decade :/

Just say no.
