Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 15166C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43B1208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vh/God27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43B1208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754992AbeFNTaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:30:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45250 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754736AbeFNTaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yzAAnjGzcRtgo9zCAvP16847g5GB1W0hKkEYioTHHZc=; b=Vh/God27m/tDTaEVzNbuceqWX
        zTOthzy7GiZFZ5lYcoLaaSCUPVUIiguUl8u1irqkuFTfFkGJC0ZzVkzhWCiSSNWo16+uDX1TqrMCk
        gkabhsUzTN2+zazf945HagbgpfdXBWe8SAj+jMBqUefh0KX0BjujMKuTR3/rpn9KfY/hX5ui4WjpP
        tw6Dlcvd5aBTx1DZCEd50qGGUjJqJSHp3zz5KdRlrBeiwJnE/vExnZbbTG7Q3byjVS4y3jUsH7xHq
        zOYFzG/UM4KPrsIzLfXCmKR5m/MEDOFJJC0Dbs+FuDzj1PJRMxfEt9sRojqrfp2udVEi4TTivwTe9
        nXktCAC4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTXwZ-0007bs-NP; Thu, 14 Jun 2018 19:30:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B078201EA7C8; Thu, 14 Jun 2018 21:30:01 +0200 (CEST)
Date:   Thu, 14 Jun 2018 21:30:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Subject: Re: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
Message-ID: <20180614193001.GY12217@hirez.programming.kicks-ass.net>
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
> @@ -416,6 +418,7 @@ struct perf_event_attr {
>  	__u32	aux_watermark;
>  	__u16	sample_max_stack;
>  	__u16	__reserved_2;	/* align to __u64 */
> +	__u64	aux_sample_size;
>  };

Do we really need a __u64 for that? I can see how that __u16 hole might
be too small (512K), but do we really need >4G 'samples' ?
