Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CC7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA622087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JLRrkdMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfAHKLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:11:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48518 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfAHKLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6HFTOvCdOJyPtI074m0FbqlthaoX/Yqru68BY88Q/tk=; b=JLRrkdMW47F7LOHXj9h5jzSzx
        Rhhy7RBD+CZSNH5irRWgVrRyaPJy+PVPF/d1LxBXL1cI/sOpqkcoyUJ/S12X7Q9y5F5zmZn6qhsIz
        DHhdGeWKbJdIqLxDZzMFbRoHN1mwUhgMPZtweYU37HuvPPSdMI+Rr9BYemwADde1vfjTun7b1Djt1
        LFAEMgMJqCKOE+ZfCYyxr5aeZ4x4elTi1YiXUkatMhjbgZQSfR0710aUTMSmw75orsdlLr+3b2Z/1
        gBmQbeyq911DQYASXgpwy/+ZgxQDhETUDZuahH+syUH0xepvpqM0X1VEWhwIpFM7QXXiPRsLr9Iot
        g7uxhdYKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggoLc-0003is-SZ; Tue, 08 Jan 2019 10:11:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 248F6201BF307; Tue,  8 Jan 2019 11:10:58 +0100 (CET)
Date:   Tue, 8 Jan 2019 11:10:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Nadav Amit <namit@vmware.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        songliubraving@fb.com
Subject: Re: [RFC v2 0/6] x86: dynamic indirect branch promotion
Message-ID: <20190108101058.GB6808@hirez.programming.kicks-ass.net>
References: <20181231072112.21051-1-namit@vmware.com>
 <87zhshe66w.fsf@linux.intel.com>
 <20190107163227.GH14122@hirez.programming.kicks-ass.net>
 <c4e836e8-1949-27f5-f6a0-ed860f590ec5@intel.com>
 <20190108092559.GA6808@hirez.programming.kicks-ass.net>
 <306d38fb-7ce6-a3ec-a351-6c117559ebaa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <306d38fb-7ce6-a3ec-a351-6c117559ebaa@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 12:01:11PM +0200, Adrian Hunter wrote:
> The problem is that the jitted code gets freed from memory, which is why I
> suggested the ability to pin it for a while.

Then what do you tell the guy that keeps PT running for a day and runs
out of memory because he likes to JIT a lot?
