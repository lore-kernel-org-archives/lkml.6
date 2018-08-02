Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB87C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE8E2152D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KOUnqq82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE8E2152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeHBSKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:10:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47602 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeHBSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nWrQ6NejIid/12l1ZH6BEZRIbOydxvkcLcUPRs0vj7o=; b=KOUnqq82xtGTeoAYUVnRAF0Gy
        ScL1uzxUVoa046NHkjsfi9Jgq51Kro/9yag+LwsLDGprQ98fYxEXsT5v5ZcSWzYEwXrF5hVA2UGsl
        bPUoZw84qD9M+P0fJ46TABqsDEk4+h8UernjbjleVOkTCpe9FKgcfOmaWSSp5PECnkjKXIFD1+aFR
        L6l1wKXNZitnV/9H0fsrKYCvXqO58Mdd6iArFk3U04yqRZwhpPt2pDC2LWgRizvi8V28QHieQUA7k
        DRlBEWp+ZZsURuM0LE6eaXpTN6owoQsXpvk6Jnp+Bv4vrRGw0iTh1KLE4p8jWlC25gcHcG7nCSqIq
        UMOhh50Bg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flGIz-0000x8-Dl; Thu, 02 Aug 2018 16:18:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41D8D20268265; Thu,  2 Aug 2018 18:18:23 +0200 (CEST)
Date:   Thu, 2 Aug 2018 18:18:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, fenghua.yu@intel.com,
        tony.luck@intel.com, vikas.shivappa@linux.intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
Message-ID: <20180802161823.GJ2458@hirez.programming.kicks-ass.net>
References: <cover.1533064851.git.reinette.chatre@intel.com>
 <20180802123923.GJ2530@hirez.programming.kicks-ass.net>
 <1af731f8-b5d3-5aca-af02-575802a961b9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1af731f8-b5d3-5aca-af02-575802a961b9@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 09:14:10AM -0700, Reinette Chatre wrote:

> The current implementation does not coordinate with perf and this is
> what I am trying to fix in this series.
> 
> I do respect your NAK but it is not clear to me how to proceed after
> obtaining it. Could you please elaborate on what you would prefer as a
> solution to ensure accurate measurement of cache-locked data that is
> better integrated?

We have an in-kernel interface to perf, use that if you want access to
the PMU. You will not directly stomp on PMU registers.
