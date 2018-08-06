Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9769C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D5D21990
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YB+xCOL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D5D21990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbeHFUbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:31:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38224 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeHFUbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SKwwxZC6fbcNN5ShM6Jqz5WpuKDvc2DQ0/7dlxDOSJg=; b=YB+xCOL81z8ve3MvBIzvPcCIG
        GAZNll32FoWb9Mn2vvn5Xm/ohIhiYnNYSeq45d6Y3b64oZYAmkhQCimLUS+3kZHVpHa5Pe/6McdVT
        oXLBPzXcEXt46B3zxxnq9EdxgB5TPTr54/pGem2y4CHgI2DP+RfjauHxEWE5QdVGPzeoweU4tz2Do
        GUDzpoelaoU1/BykGsGDG+csgpN1KnA/v7FHb1/CgkrClzxXSOjpfdApqUZ4HYa08ZJERBefkqUEX
        vCgZEFMgrpyWivIuFDiDAQgThkF03xdkl711fBEvOy6xDeLyPiLWQlXJ3fA6vUHUKANSXfcW4M4h4
        UO4IpCSEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmk7k-000361-JT; Mon, 06 Aug 2018 18:20:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 53FE8205881DA; Mon,  6 Aug 2018 20:20:55 +0200 (CEST)
Date:   Mon, 6 Aug 2018 20:20:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 1/3] perf/x86/intel: Factor out common code of PMI handler
Message-ID: <20180806182055.GQ2494@hirez.programming.kicks-ass.net>
References: <1533576223-11588-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533576223-11588-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 10:23:41AM -0700, kan.liang@linux.intel.com wrote:
> +	if (++loops > 100) {
> +		static bool warned;
> +
> +		if (!warned) {
> +			WARN(1, "perfevents: irq loop stuck!\n");
> +			perf_event_print_debug();
> +			warned = true;
> +		}

Bah, that really reads like we want WARN_ONCE(), except for that
perf_event_print_debug() thing :/
