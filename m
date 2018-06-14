Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 805BDC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C2A208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MKp0J7w4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C2A208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964906AbeFNTuS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:50:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755424AbeFNTrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C/X3E6u8dfZIlkopVoQQvLoaqrb22f9W4cIdwRtL0Yw=; b=MKp0J7w4VheTg+D+XWVIEanBa
        sL7tBVtBsuWydvNlQzjPA2ihgTZCiHbofNMdg4qSZWJj/ffLeyPt6G41T2V+5AhawHI7LbqMyyB0O
        D9kf3HUeov+3tv2xmPKZuCrldcNpl35hD98qyDmKER5o6eBqG2irAnyIsd74rFr8+55rAwmdd/Wv8
        RW3vFOR+md61cnYzSd/cs7n1R9RfLeQBS4EPawWkRuWnybVGc1edmBu+YNuHyhR8rgpZNdOVwfcCE
        hqSbdzQUbm+Hp4sL0Ga3nKvw+qgD/AZHOBYLeGcmQxLmKsFK/o85PBp70TELIVR9Xt4nvZiqFIOOv
        kqTLM3GnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTYDK-0002Lj-2b; Thu, 14 Jun 2018 19:47:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C7AF201EA7C8; Thu, 14 Jun 2018 21:47:20 +0200 (CEST)
Date:   Thu, 14 Jun 2018 21:47:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Subject: Re: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
Message-ID: <20180614194720.GA12217@hirez.programming.kicks-ass.net>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
 <20180612075117.65420-5-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612075117.65420-5-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:51:15AM +0300, Alexander Shishkin wrote:
> @@ -6112,6 +6219,32 @@ void perf_prepare_sample(struct perf_event_header *header,
>  
>  	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
>  		data->phys_addr = perf_virt_to_phys(data->addr);
> +
> +	if (sample_type & PERF_SAMPLE_AUX) {
> +		u64 size;
> +
> +		header->size += sizeof(u64); /* size */
> +
> +		/*
> +		 * Given the 16bit nature of header::size, an AUX sample can
> +		 * easily overflow it, what with all the preceding sample bits.
> +		 * Make sure this doesn't happen by using up to U16_MAX bytes
> +		 * per sample in total (rounded down to 8 byte boundary).
> +		 */
> +		size = min_t(size_t, U16_MAX - header->size,
> +			     event->attr.aux_sample_size);
> +		size = rounddown(size, 8);
> +		size = perf_aux_sample_size(event, data, size);
> +
> +		WARN_ON_ONCE(size + header->size > U16_MAX);
> +		header->size += size;
> +	}
> +	/*
> +	 * If you're adding more sample types here, you likely need to do
> +	 * something about the overflowing header::size, like repurpose the
> +	 * lowest 3 bits of size, which should be always zero at the moment.
> +	 */

Bugger yes.. I fairly quickly (but still too late) realized we should've
used that u16 in u64 increments to allow up to 512K instead of 64K
events.

Still, even 64K samples are pretty terrifyingly huge. They'll be
_sloowww_.

In any case, I suppose we can grab one of the attribute bits to rev. the
output format -- a la sample_id_all. Do we really want to do that? 512K
samples.... *shudder*.
