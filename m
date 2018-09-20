Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13576C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4662152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QbCIj7CL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4662152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbeITTzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:55:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeITTzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yiZcEUS8m98q9XGHruVnJ+8dBj+1EQDt6SRzTVYFJ88=; b=QbCIj7CLkDtu56j2sdo3bKpJn
        xNn8EiMYsTDiOJYbJ13s0o55BazqtXLDphdiXhtML92OM08RGaYIUu1cUyPZRVVdwq9VEnkQ6mJiQ
        wdQzXLnUMp+4y6t73ymL2OZvjRFkl/uqKnSLjecxoBssU1pxbxPetwTAmbWnHAXHKZ16dhmotc1Ti
        eE8DWr7ZFXepgWMRcGwC5ftydS7g2SDb1yOXRwKtXRQdCqZvhO5TBBpvMTiNEqlOOb+Xtp/NxfkpK
        6qGfJi6TgwgtNovZniNxhsKchni+6pv420lmgx1DO2FZ4tP3bTLryH011ZaBk3m1hn3lYzlWSKhQy
        y0glIgEBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2zfr-0001sA-8S; Thu, 20 Sep 2018 14:11:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5E1C2024E448; Thu, 20 Sep 2018 16:11:15 +0200 (CEST)
Date:   Thu, 20 Sep 2018 16:11:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 5/6] x86/intel_rdt: Use perf infrastructure for
 measurements
Message-ID: <20180920141115.GX24124@hirez.programming.kicks-ass.net>
References: <cover.1537377064.git.reinette.chatre@intel.com>
 <d31d652432a62e770fc971d3e6fe59faa9e65413.1537377064.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31d652432a62e770fc971d3e6fe59faa9e65413.1537377064.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:29:10AM -0700, Reinette Chatre wrote:
> +static int measure_l3_residency(void *_plr)
> +{

> +	counts.miss_after -= counts.miss_before;
> +	if (boot_cpu_data.x86_model == INTEL_FAM6_BROADWELL_X) {
> +		/*
> +		 * On BDW references and misses are counted, need to adjust.
> +		 * Sometimes the "hits" counter is a bit more than the
> +		 * references, for example, x references but x + 1 hits.
> +		 * To not report invalid hit values in this case we treat
> +		 * that as misses equal to references.
> +		 */
> +		/* First compute the number of cache references measured */
> +		counts.hits_after -= counts.hits_before;

> +		/* Next convert references to cache hits */
> +		counts.hits_after -= counts.miss_after > counts.hits_after ?
> +					counts.hits_after : counts.miss_after;

Maybe:
		counts.hits_after -= min(counts.hits_after, counts.miss_after);

