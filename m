Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9692ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533EC20871
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wvU+Bc+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533EC20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeGMLHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:07:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39504 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeGMLHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+RcBWhtlIsgX5SPlqSYCeOZVBuk4qr6SyH8gAr7ZpeY=; b=wvU+Bc+dGKXrrVoluTdqUuNwX
        IK1vQidtMKlSUrBt3a32z/3dvTTeUGNEVXc6siVWYMID2I/NulctikJWan2v/nxqen39nfm286Zst
        +SnYsSY4TZClz9Ae1xCbC4oLALi9ZAJz+lWpCjTa3cj8fQstBZP+fj4byTFLcPMwO52njk/qhP+lV
        /cS4JieSv79PRKogKaCS1WCPOvgMpbUGKJzwDS44ln1n5FOu8EnheA9KOj7ldCj7kLPmkf0W5b76L
        Or3DYKsyrAF/yDk/Ow3vbU/bO2sidp0KWBao8XR672ZSRpjskyHMcaPjOhPkFSK8n0CD0XYgSaAOg
        mjl9BEsQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdvhN-0006f6-I0; Fri, 13 Jul 2018 10:53:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CDA720298BAE; Fri, 13 Jul 2018 12:53:16 +0200 (CEST)
Date:   Fri, 13 Jul 2018 12:53:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     "Metzger, Markus T" <markus.t.metzger@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephane Eranian <eranian@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [bug] kpti, perf_event, bts: sporadic truncated trace
Message-ID: <20180713105316.GX2494@hirez.programming.kicks-ass.net>
References: <A78C989F6D9628469189715575E55B236B330102@IRSMSX104.ger.corp.intel.com>
 <alpine.LSU.2.11.1807121743050.5425@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1807121743050.5425@eggly.anvils>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:22:13PM -0700, Hugh Dickins wrote:
> A little "optimization" crept into alloc_bts_buffer() along the way,
> which now places bts_interrupt_threshold not on a record boundary.
> And Stephane has shown me the sentence in Vol 3B, 17.4.9, which says
> "This address must point to an offset from the BTS buffer base that
> is a multiple of the BTS record size."
> 
> Please give the patch below a try, and let us know if it helps (if it
> does not, then I think we'll need perfier expertise than I can give).

Ooh, good find!

> --- 4.18-rc4/arch/x86/events/intel/ds.c	2018-06-03 14:15:21.000000000 -0700
> +++ linux/arch/x86/events/intel/ds.c	2018-07-12 17:38:28.471378616 -0700
> @@ -408,9 +408,11 @@ static int alloc_bts_buffer(int cpu)
>  	ds->bts_buffer_base = (unsigned long) cea;
>  	ds_update_cea(cea, buffer, BTS_BUFFER_SIZE, PAGE_KERNEL);
>  	ds->bts_index = ds->bts_buffer_base;
> -	max = BTS_RECORD_SIZE * (BTS_BUFFER_SIZE / BTS_RECORD_SIZE);
> -	ds->bts_absolute_maximum = ds->bts_buffer_base + max;
> -	ds->bts_interrupt_threshold = ds->bts_absolute_maximum - (max / 16);
> +	max = BTS_BUFFER_SIZE / BTS_RECORD_SIZE;
> +	ds->bts_absolute_maximum = ds->bts_buffer_base +
> +					max * BTS_RECORD_SIZE;
> +	ds->bts_interrupt_threshold = ds->bts_absolute_maximum -
> +					(max / 16) * BTS_RECORD_SIZE;
>  	return 0;
>  }
>  
