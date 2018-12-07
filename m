Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387C8C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB04208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S4WPA1TM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB04208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbeLGIwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:52:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33046 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeLGIwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2LZ4fnPgQ2siTRSwReZNb7F73vZ2I4lbPRUKxgN0Wgg=; b=S4WPA1TMAVZDFwrQtpb8x5o1bu
        jJ6FxOTQQVTqQV+X9g1aeBkQLd2mN9SrYhfNQ0IXb2S/d+m8uuWd/VZLr26j9YXKDXKDL0Edt2ggq
        uHuu84GGUp4Sfuy4idcofvACjmfL4KQNACx8nrc9wmSDbu4tOw3EPaw/EUplCrdNUxAUGrH5AEHFM
        Uxhu7WhRBAFux9IEYLj4SxKj0CnCtNaVyUPBL0D5jGbYcN1s2XqjYK/Ltk71dwnXXVr7IwtahoduS
        IZJH/o99z/qU6LujO9Vu00j5tm9KTDE5BM9VYWQ7Cb1rwWIycWweblhT0yy5KJNOUycofzyv9AuT6
        62uLRPdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVBro-0005XH-Lk; Fri, 07 Dec 2018 08:52:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0D20200FB7D8; Fri,  7 Dec 2018 09:52:09 +0100 (CET)
Date:   Fri, 7 Dec 2018 09:52:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 2/2] x86/speculation: switch_to_cond_stibp on is the
 likely case
Message-ID: <20181207085209.GB2237@hirez.programming.kicks-ass.net>
References: <1544039368-9009-1-git-send-email-longman@redhat.com>
 <1544039368-9009-2-git-send-email-longman@redhat.com>
 <20181206084141.GA13538@hirez.programming.kicks-ass.net>
 <3732de84-a14f-e32a-61de-29c5965dd405@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3732de84-a14f-e32a-61de-29c5965dd405@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 10:38:00AM -0500, Waiman Long wrote:
> On 12/06/2018 03:41 AM, Peter Zijlstra wrote:
> > On Wed, Dec 05, 2018 at 02:49:28PM -0500, Waiman Long wrote:
> >> Since conditional STIBP is the default, it should be treated as
> >> the likely case. Changes the use of static_branch_unlikely() to
> >> static_branch_likely() for switch_to_cond_stibp.
> > So now you're making kernels on 'fixed' or unaffected hardware slower.
> 
> Good point.
> 
> The reason I sent out this patch is because of the inconsistency in the
> use of likely/unlikely hints.
> 
> arch/x86/kernel/cpu/bugs.c:156:        if
> (static_branch_unlikely(&switch_to_cond_stibp))
> arch/x86/kernel/process.c:440:       
> static_branch_unlikely(&switch_to_cond_stibp)) {
> arch/x86/kernel/process.h:26:        if
> (!static_branch_likely(&switch_to_cond_stibp)) {
> 
> So if we are aiming to optimize for "fixed" or unaffected hardware,
> maybe we should modify the likely hint to unlikely then.

Right, I think that makes sense, Thomas?
