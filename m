Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B715EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7116821CCF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T6sRmnol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7116821CCF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932994AbeFUThw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:37:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932866AbeFUThv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EDCZrv+eMl4xr7RVEe1OUTVzo60NpA5hOdG2uVBlW4g=; b=T6sRmnol+fb25ieqoFUSPI4x7
        WuZf91BO7fA/jNQlU32m5ZeldT7nIT3S6UWLhlbOCuyAaHa89nnzmKX0c1JiIxLjEPLUE3BOTyzbd
        B83YQbYCN97BQIaGRDuX/FnDuhZPBQqCh+aY5C3sfEhjW9g/wLQZaRD4eXUxAQgT1e7NIzYUj9fIR
        Wxde3lXsy4AyUB7EdNfL1EYUge2PRuSEQeixvHoJi/lyJ8SvMvzXCtdJCh5FYLSkc6WwSyLTGN1s2
        tejRG/fXoX+55mkYIxHdsYlkxldWQnkPVm8v9y663jdm+DaxVznzX2AVPKVsY8tzv1IBNdwsF4D65
        FGA71RbPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW5Oo-00019a-MT; Thu, 21 Jun 2018 19:37:43 +0000
Received: by worktop (Postfix, from userid 1000)
        id 796376E093A; Thu, 21 Jun 2018 21:37:38 +0200 (CEST)
Date:   Thu, 21 Jun 2018 21:37:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
Message-ID: <20180621193738.GA13636@worktop.programming.kicks-ass.net>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 08:45:49AM -0700, Fenghua Yu wrote:
> Currently we can trace split lock event counter for debug purpose. But

How? A while ago I actually tried that, but I could not find a suitable
perf event.

> Intel introduces mechanism to detect split lock via alignment
> check exception in Tremont and other future processors. If split lock is
> from user process, #AC handler can kill the process or re-execute faulting
> instruction depending on configuration. 

Ideally it would #AC any unaligned (implied) LOCK prefix instruction,
not just across lines.

> To detect split lock, a new control bit (bit 29) in per-core TEST_CTL
> MSR 0x33 will be introduced in future x86 processors. When the bit 29
> is set, the processor causes #AC exception for split locked accesses at
> all CPL.

Per-Core is really unfortunate, but better than nothing.
