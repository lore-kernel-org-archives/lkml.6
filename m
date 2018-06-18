Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6217DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C236208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="dMv4CDyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C236208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934857AbeFRQ6o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:58:44 -0400
Received: from one.firstfloor.org ([193.170.194.197]:52028 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932870AbeFRQ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:58:43 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 0E9AF86A14; Mon, 18 Jun 2018 18:58:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1529341121;
        bh=dSKRAFAqpvfIBE+Sz5sw6CwGtWpMwKnIao7qYcg2NkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dMv4CDyWLdfXPizwi7yk42bM72Q+wlwD6ies+Qnxn2CQHbnDcYjYMQiDDZMtHI7Q2
         yG4OI523VosdT1F2R0hibQZ8hK4EcEjq3b2YEum/zZnE9kGm3zE1dlXb59cNTZDm5F
         3oW+40NryFiIaG6HiKj/SuHmueGCizck9KLoGiuE=
Date:   Mon, 18 Jun 2018 09:58:40 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Andi Kleen <andi@firstfloor.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Kyle Huey <khuey@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>
Subject: Re: [RFC PATCH] x86/arch_prctl: Add ARCH_SET_XCR0 to mask XCR0
 per-thread
Message-ID: <20180618165840.gikljqhaxtiiw27x@two.firstfloor.org>
References: <1529195582-64207-1-git-send-email-keno@alumni.harvard.edu>
 <20180617163530.rvwf7fcukmoletgo@two.firstfloor.org>
 <CABV8kRyf2R=a2zezgovByK9Lc8HhDXyfZ4OPE_DHfKKg34bNfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABV8kRyf2R=a2zezgovByK9Lc8HhDXyfZ4OPE_DHfKKg34bNfw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, that is insufficient. Almost difference in CPU behavior
> between the replayer
> and the replayee. In particular, the problems for rr here are
> 1) xgetbv, which can introduce differing register contents (and if
> code branches on this,
>     potentially differences in control flow).

So you're saying that software checks XGETBV first before checking
CPUID?

That seems broken. Without AVX XGETBV may not exist.

You always have to check CPUID first. And then it should just branch
around the XGETBV.

So we're talking about a workaround for broken software. The question
is how wide spread is it?


> 2) xsave writing more memory than the trace expects, causing
> divergence in the memory
> contents of the process.

Do memory contents which are never read by the application matter?


-Andi

