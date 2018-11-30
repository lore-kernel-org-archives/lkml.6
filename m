Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67C2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE5220834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hpa0ODCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE5220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLAFAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:00:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39394 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAFAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rZ4i5YUx8GSZCqHcS0TXd7Gh+ggHh7FrHGTy2zR3LDQ=; b=hpa0ODCCnv4cmhzUDEAB4icmS
        HsSFgUssGKrf2I01pEXXT85Vcd080ups+k//W1ALCledhCj7Gpt+8Epb/6cs5C8SwUe1/Zo1TMA0K
        VDYGTqES/sSKS1gJDbRCBrKw4swQ4maUL2sOd32SnoxITdiBO4DQnVqvmuwee0SvHU+PWFpPrcNBH
        1+ua/UEYD0IdUzPGv5jRzrb3Ld+KV2lBolc+/n5Zy0Aa2ZS87RanBCfyDFePa2loiRtjpkot/2Ypq
        a3ZHzvveVM9pZUXLsVTDgPgaZWgwrwFc2ajxK9T9iImb3Am3RsaQvrjAPb+PwdWMIRwj9WriXpDaw
        pFBepYM7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSmvt-0005kT-6d; Fri, 30 Nov 2018 17:50:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0B3A2029FD58; Fri, 30 Nov 2018 18:50:26 +0100 (CET)
Date:   Fri, 30 Nov 2018 18:50:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "StDenis, Tom" <Tom.StDenis@amd.com>
Cc:     "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Message-ID: <20181130175026.GB11573@hirez.programming.kicks-ass.net>
References: <20181130134455.490139778@infradead.org>
 <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
 <20181130150959.GA11614@hirez.programming.kicks-ass.net>
 <9b172efa-0279-0a39-0b6b-7cf3492d326d@amd.com>
 <20181130152347.GB11614@hirez.programming.kicks-ass.net>
 <2b50ff31-11a5-21d1-a22a-4ffda0664c9a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b50ff31-11a5-21d1-a22a-4ffda0664c9a@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 03:27:02PM +0000, StDenis, Tom wrote:
> I can apply the patch you attached but the inline patches just don't 
> apply.  Could be my imap client (thunderbird) mangled them but I've 
> applied patches this way before.  could you attach them instead please?

That's arguably a bug in Thunderbird; but there's already upstream quilt
changes (that I used to have before Debian helpfully updated my quilt
package) that should remedy this as well.

It seems some MUA's get horribly confused about the
"Content-Disposition: inline; filename=$patch" header quilt-mail adds.

I've once again removed that from my local copy; hopefully the next time
Debian updates that package it will actually be with a new enough
version to also include those changes :/
