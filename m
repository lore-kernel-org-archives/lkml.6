Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC5DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C5220868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A/KwvVM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C5220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeLABP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:15:56 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34874 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeLABPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2+/eZdjUG8kcHi3yO+CnTE1ws8GVzsX1ltlfZu+KFSo=; b=A/KwvVM+MNJ7bqvpERetsjHpb
        07FBu8n79QFYS0mM6rwQGnsfOSucxr80U0B8RjWZC789rktgh+uExFYHoZP23qP0jBtYmmYyodw/c
        9J74Oo1cctkHlT11R2bPnyFo+DZa+Dd3Pxwa3xOHJp0u2Lj7tjJvLjJFysme18uFbip/GJgw2UYph
        c8JkzjhBMDdn5okn8FTIp/K2+fki6q/98IrANfPswiBhW0Fc9YVnYlBZ79RkBy3a4xuzesb2VmotT
        N1MZ4fdmZ+NcpnApn6r/pfjOtgFTNPUqSm8rCKYuFS9WxBMf2jhI4w98L9BEFrcuPYVR6Wkj5r4zw
        qOgRIaDLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSjQv-0003vB-Tr; Fri, 30 Nov 2018 14:06:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5DA052029FD58; Fri, 30 Nov 2018 15:06:14 +0100 (CET)
Message-Id: <20181130134455.490139778@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 30 Nov 2018 14:44:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Yesterday Tom reported a CPA bug triggered by the AMDGPU team.

It turns out that with commit:

  a7295fd53c39 ("x86/mm/cpa: Use flush_tlb_kernel_range()")

I misread the cpa array code and messed up the TLB invalidations for it. These
patches (hopefully) fix the issue while also shrinking the CPA code again.

Tom, would you be so kind as to test again? These patches are significantly
different from what I send you yesterday.

---
arch/x86/mm/mm_internal.h |   2 +
arch/x86/mm/pageattr.c    | 167 ++++++++++++++++++++--------------------------
arch/x86/mm/tlb.c         |   4 +-
3 files changed, 79 insertions(+), 94 deletions(-)

