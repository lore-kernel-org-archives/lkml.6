Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7C2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DA92086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A/smk7vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DA92086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbeKTCOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:14:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58898 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbeKTCOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qnl5gC8TS58Kn2r01SydYptbCj9xmTfCPuFt7Zr0GIY=; b=A/smk7vtKYomD/dnpKlROmQzl
        +4wH03BHoNf3kohYFjgiKqXo+QLleBldBGyCI8UFIk4NKuiSr6Qrv2rjxKLknJwUL36TOYsgQDEO8
        iiuJyzcNaSCnuyPGaq8Aeky0I60QPnXQtYL8VJerIWVy4B/fQ57y5zO/W8Xiw+9XEE8SBmYj0cVtA
        Am5k9Br1lTY9T8OCp/nlCZhcyGj3/jk6GxE697vE6e9OyyEHP7zm7N9isgz7Fx9eJmN78DU7C68b4
        7T80FjGSpxGr9QqrIYFlnzj1D3L9EOEUIK1swyEln0KvhopbjSI1OrM2SCow3ikBkkTkhgiYwz61i
        BDkd+Q3KA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOlob-0001AT-8z; Mon, 19 Nov 2018 15:50:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE9EE2029F87F; Mon, 19 Nov 2018 16:50:18 +0100 (CET)
Date:   Mon, 19 Nov 2018 16:50:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, yao.jin@linux.intel.com, sashal@kernel.org,
        stable@kernel.org
Subject: Re: [PATCH V2] perf/x86/intel/uncore: Fix client IMC events return
 huge result
Message-ID: <20181119155018.GB2131@hirez.programming.kicks-ass.net>
References: <20181116152055.5806-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116152055.5806-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 07:20:55AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The client IMC bandwidth events return very huge result.
>   perf stat -e uncore_imc/data_reads/ -e uncore_imc/data_writes/ -I
>   10000 -a
>   10.000117222 34,788.76 MiB uncore_imc/data_reads/
>   10.000117222 8.26 MiB uncore_imc/data_writes/
>   20.000374584 34,842.89 MiB uncore_imc/data_reads/
>   20.000374584 10.45 MiB uncore_imc/data_writes/
>   30.000633299 37,965.29 MiB uncore_imc/data_reads/
>   30.000633299 323.62 MiB uncore_imc/data_writes/
>   40.000891548 41,012.88 MiB uncore_imc/data_reads/
>   40.000891548 6.98 MiB uncore_imc/data_writes/
>   50.001142480 1,125,899,906,621,494.75 MiB uncore_imc/data_reads/
>   50.001142480 6.97 MiB uncore_imc/data_writes/
> 
> The client IMC events are freerunning counters. They still use the
> old event encoding format (0x1 for data_read and 0x2 for data write).
> The counter bit width is calculated by common code, which assume that
> the standard encoding format is used for the freerunning counters.
> Error bit width information is calculated.

So far so good; some client IMC events have a different format and need
converting.

> The event->attr.config, which directly from user space, should not be
> used by the functions of freerunning counters.
> For client IMC events, the attr.config needs to be converted to the
> standard encoding format. The modified event config will be stored in
> event->hw.config.
> For other freerunning counters, the attr.config has the correct format.
> Just save it in event->hw.config.
> Using event->hw.config to replace event->attr.config for the functions
> of freerunning counters.

This above section seems unclear/confusing at best. The first sentence
is actively wrong; it lost the 'client IMC' specification.

Please restructure.
