Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E3FECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A24214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X0OF+EkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A24214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeIQOZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:25:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32788 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeIQOZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QkTxYdgDOlRq2zyG+S+QLDOVfmhSN3dXupFwDLvcAKw=; b=X0OF+EkBJPNd38RCKBXMeguNV
        xl+ep8UdJ6msAMHL6rQFkHSONdMdvDab+gn61vxaSn2tU2fdTPHO31V/CH6V4tsXvxvVtdCuWIKm3
        EHDbqpFl9SH+47s94FdRZGXbQWMVbEueyQqfVm9CNsqe2vccxnNNUuyhiKlwoK+ao1mHaaptm2B6g
        rV9e98Xgmwx+SJJOGXQZ92enF1hxHJ6Bx2PFJAZ4WtFagk5vaYlT5P/as9+LKaebdefXaLbP9YbhN
        Ug3y4bXw4EFHlv4HPZFnt3QDUwzjea467UmGI6DXpYbA4lWykWfkehpW+KiRNfSAaCs6XlPDIUu3J
        HZ7Aflqqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1pMp-0001sZ-9b; Mon, 17 Sep 2018 08:58:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2CC12058A23D; Mon, 17 Sep 2018 10:58:48 +0200 (CEST)
Date:   Mon, 17 Sep 2018 10:58:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 5/6] x86/intel_rdt: Use perf infrastructure for
 measurements
Message-ID: <20180917085848.GQ24124@hirez.programming.kicks-ass.net>
References: <cover.1536685533.git.reinette.chatre@intel.com>
 <e49f32d40c53839c31e1376f11059539afd08f23.1536685533.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e49f32d40c53839c31e1376f11059539afd08f23.1536685533.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 10:14:36AM -0700, Reinette Chatre wrote:
> +static int measure_l2_residency(void *_plr)
> +{

> +	measure_residency_fn(&perf_miss_attr, &perf_hit_attr, plr, &counts);

> +}
> +
> +static int measure_l3_residency(void *_plr)
> +{

> +	measure_residency_fn(&perf_miss_attr, &perf_hit_attr, plr, &counts);

Not sure it's important, but both sites loose the error return.
