Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3CEECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D8C2151C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YBZdMZI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D8C2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbeISSa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:30:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34380 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731419AbeISSa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2PBXzP63wx/moa6VlflkmSL69hR5b374uZW4i277Q5s=; b=YBZdMZI3BGsQj6bS0N+q872Ie
        nJprUip5pLm6S4Gr2Zf2W66lJOtREnqeS2G4Eprk7/TJETLJCwuEZVHs4eZ58XoM3/EHTyGO4RBUD
        qIuzHJZuR8oK3L0b8m9P4TJ4t/ymOhnXFFrfioRxDb9TqZf6j41y7DZR1P0mthha9owEj2lX8Qkf9
        GfjkU6AhWtU8+NB5LJdX2BttQ7R66odCPX9ZYnCLkY1IG0vRKnvRSg+vSCXRzWLYgQk1j+S08XUmB
        Fks8ZzAr6D4ycLw8WvOZEMXm2wEijpiSm0HCkgvQDTZx9A0yold1U7hZi9m+1JzlSDeKO75S8fW4j
        jDjgejuoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2byY-0008Qm-I0; Wed, 19 Sep 2018 12:53:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 161062024E44A; Wed, 19 Sep 2018 14:52:59 +0200 (CEST)
Date:   Wed, 19 Sep 2018 14:52:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>, segher@kernel.crashing.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] sched: move stack_canary field at the top of
 task_struct
Message-ID: <20180919125259.GG24124@hirez.programming.kicks-ass.net>
References: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
 <20180919115836.GE24124@hirez.programming.kicks-ass.net>
 <f6a36d25-ce19-5d56-69d9-198215a7b9e1@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6a36d25-ce19-5d56-69d9-198215a7b9e1@c-s.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 02:25:00PM +0200, Christophe LEROY wrote:
> I have not been able to find a way to define the compilation flags AFTER
> building asm-offsets.h, see https://patchwork.ozlabs.org/patch/971521/
> 
> If you have a suggestion, it is welcomed.

Not really; I always get lost in that stuff :/

> > Might as well put it before state, right after the task_info thing.
> > 
> 
> Yes, it doesn't make much difference, don't any arch expect state at offset
> 0 ?

Uhmm.. dunno. I would not expect so, but then I didn't check.
