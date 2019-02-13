Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C14C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B5A2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cf+TYhiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404296AbfBMPI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:08:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44330 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbfBMPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B6Hjpqy7xmesO0Qjschsa/xWQvFbbpkd+0q/JbfvpyM=; b=Cf+TYhiF/Eohq3X9KPtkgIaIM
        15uhPMT0CtY+DXgu9tJnhvaqN07D7HiZZkICnydqBMpn5Q7SGBNh+sGKrk8y2jzT/c3QhzLgd3ctQ
        UPN4DBS0FAoG/qzy12UpoY9nTCnd8cTZaGl/4NXS5W+pOQqL/uIWXnCUbWWH+NVNn3V478RTibx8u
        gWtDzuuWQSt7uzEXaOYd1D05AlF3KYVqWhvqYXfQDYcNMw9vMip2Ny/PEb345zlRzWMWEWCLSKqSM
        Ou02S3BDAOaC54tAKIPKbRsDHImaxX3RmNvLgyq3RQwpXxcLFN/+TPPhN0Y5m7qE+ZPCFm7gOJawK
        EnENDn9Hw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtw97-0001mY-7j; Wed, 13 Feb 2019 15:08:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD4EA202CEF73; Wed, 13 Feb 2019 16:08:19 +0100 (CET)
Date:   Wed, 13 Feb 2019 16:08:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, catalin.marinas@arm.com, james.morse@arm.com,
        hpa@zytor.com, valentin.schneider@arm.com
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213150819.GP32534@hirez.programming.kicks-ass.net>
References: <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213141712.GV32494@hirez.programming.kicks-ass.net>
 <e8ff5f65-b8df-0296-e9e7-ba627a4ef1a4@arm.com>
 <20190213144000.GX32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213144000.GX32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 03:40:00PM +0100, Peter Zijlstra wrote:

> So far, all 6 in-tree users are indeed free of dodgy code, but *groan*.

because of this, there must also not be tracepoints (even implicit ones
like function-trace) between user_access_{begin,end}().

And while that is unlikely with the current code; it is not guaranteed
afaict.

What a ff'ing mess.
