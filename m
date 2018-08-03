Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A720AC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B7421717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BWOCABnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B7421717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeHCMpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:45:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41368 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeHCMpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/qwhg8ehYM5XbpNEFKpfjvMubpSOQER8VooZv9yxljo=; b=BWOCABnvcxC3Y19LhUr91mX9m
        pshoJ5QBUNUTNxAIb/WJlEB6l9k3lWfk6Ry7/SSUlBk4HNfaBCh5cEHBPODQ3IRkyxnnVObppGT29
        MwAEqJiQ9o0Nc4F0PVY7Qm2Pfdufp1gKFoXjyvxW9JVM5acCc7/MS3MJc4r1cRU5pFHuBn26jnKkY
        e1LG3d3KDUTNW+KtpbR5TOOqJTMj62wOvsP6U1HkI6TqVaZJNePt586vNIlqnWfF6EunaUmXUsBQx
        IquyAIP/EWuAEt1jDk0sunJEpM7QjW4ZHCzchxHrODEt1X6oQS5TS7T7Fw/DWeEq+sdjaOa04ANoK
        na+CZ4kXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flXeg-0005qx-4X; Fri, 03 Aug 2018 10:49:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA0F92057EA10; Fri,  3 Aug 2018 12:49:56 +0200 (CEST)
Date:   Fri, 3 Aug 2018 12:49:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
Message-ID: <20180803104956.GU2494@hirez.programming.kicks-ass.net>
References: <20180802123923.GJ2530@hirez.programming.kicks-ass.net>
 <1af731f8-b5d3-5aca-af02-575802a961b9@intel.com>
 <20180802161823.GJ2458@hirez.programming.kicks-ass.net>
 <f990df31-ab75-974e-b142-47af07a33a08@intel.com>
 <20180802173727.GP2494@hirez.programming.kicks-ass.net>
 <653e874f-5e77-a9b5-996a-ed9daa3c6d43@intel.com>
 <20180802195410.GR2494@hirez.programming.kicks-ass.net>
 <d64f85e8-98ca-a81d-bf2d-13dd72fc411e@intel.com>
 <20180802201312.GS2494@hirez.programming.kicks-ass.net>
 <086b93f5-da5b-b5e5-148a-cef25117b963@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086b93f5-da5b-b5e5-148a-cef25117b963@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 01:43:42PM -0700, Reinette Chatre wrote:

> The goal of this work is to use the existing PMU hardware coordination
> mechanism to ensure that perf and resctrl will not interfere with each
> other.

I understand what it does.. but if I'd seen you frobbing at the PMU
earlier your patches would've never gotten merged.

It's simply not going to happen.
