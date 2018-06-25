Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C91C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFD925CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WPK3cxjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFD925CA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755690AbeFYPXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:23:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbeFYPXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=//ZsFiahOmIUzl2Q1wxaKiAu2vudkvolCbII4sfKZTY=; b=WPK3cxjqjUFB4kT4EekQvO1f0
        LKPmTt8mg+TbfUIapDBela3rtMJUgudHAR5TG68clX07oKTlnMM499moC5ptTIrpWYFHkdP/0inUz
        93AKKFfYl1uq0HbZ3y/iYHXlmv1kHc+cyuQaBiVlM5eKImF3GbYEicQwaIA8/pO15ji1Yz0MyISV2
        0HS8vd8wPVbACuV2MO73OHV0F+/B1hbzzAwuEqCMnIqXBxqxNckLeS1V7L9eW2MD6KzLpg1hKA9lV
        25ndXPZMkmsboyLrcwSreXXBr0wpMaEFiPKY99UAZ06CtO+wHEmYEoaGkG7mkXInJheaUAAsrq+pO
        HOyTQ3XEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXTKX-0006fg-VN; Mon, 25 Jun 2018 15:23:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A91CD2029F1D7; Mon, 25 Jun 2018 17:22:59 +0200 (CEST)
Date:   Mon, 25 Jun 2018 17:22:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        boqun.feng@gmail.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        catalin.marinas@arm.com, dvyukov@google.com, glider@google.com,
        hpa@zytor.com, linuxdrivers@attotech.com, mingo@redhat.com,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de
Subject: Re: [PATCHv2 00/11] atomics: generate atomic headers / instrument
 arm64
Message-ID: <20180625152259.GD2494@hirez.programming.kicks-ass.net>
References: <20180625105952.3756-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625105952.3756-1-mark.rutland@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:59:41AM +0100, Mark Rutland wrote:

> That scripting comes to ~900 lines, and replaces ~1700 lines of hand-written
> boilerplate with ~4700 lines of generated code. Some of that increase in line
> count is due to filling in missing portions of the API (e.g. adding all the
> ordering variants to the instrumented atomics), while some of that is due to
> expanding fallbacks in place, and consistently spreading these across multiple
> lines.

> Mark Rutland (10):
>   atomics/x86: reduce arch_cmpxchg64*() instrumentation
>   atomics: simplify cmpxchg() instrumentation
>   atomics/treewide: instrument xchg()
>   atomics: instrument cmpxchg_double*()
>   atomics/treewide: rework ordering barriers
>   atomics: add common header generation files
>   atomics: switch to generated fallbacks
>   atomics: switch to generated atomic-long
>   atomics: switch to generated instrumentation
>   arm64: use instrumented atomics

Awesome work Mark, thanks for doing that!

Aside from the nitpicks I mentioned on IRC (mostly spelling and
Changelog inconsistencies),

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
