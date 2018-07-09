Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEFBC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2F120877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RZwNhOAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2F120877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754522AbeGIKhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:37:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754431AbeGIKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=boWSXLK+hte0o3FvjqL2u+rwepKvfPAc44lUihJTRYI=; b=RZwNhOAceCLKSYk2xMM9USkoJ
        POhSrX4ehjpFbDhf9BqtmimXTnW9jvJ5OsPDQPZ/0sG4hiMxxBhoVKfC0pV0ZNAUEjmYgVHbrnRHI
        tGR1U6V/McBY++h/EgXBP1Y1wGocW5b4VzXUGkq8m9bX2Lq5nym8fAM0vc4z+v9B1GUAalpSxynRZ
        rCKNhrcyi4m+L12629l9OHr/EPIoiDbJrb+uwcPa+3nbgZ4y7eTpO0usRSxvDAAQdE6Z11bONtDqC
        FMCW78/DKj2xk4xSYmajmp0XoeQ1IyRbBNChAaWf1cfhE0x3KKR5Bb4+R9ihYQebS+kowMIof/rU9
        Zey8ghAOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcTXO-0006Tf-Th; Mon, 09 Jul 2018 10:36:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF1302029764D; Mon,  9 Jul 2018 12:36:56 +0200 (CEST)
Date:   Mon, 9 Jul 2018 12:36:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 11/12] sched: use for_each_if in topology.h
Message-ID: <20180709103656.GH2476@hirez.programming.kicks-ass.net>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-11-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709083650.23549-11-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:36:49AM +0200, Daniel Vetter wrote:
> Avoids complaints from gcc about ambiguous else clauses.

Is that a new thing? I'm fairly sure I've never seen it do that,

> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  include/linux/topology.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index cb0775e1ee4b..4fba5a5b148d 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -40,7 +40,7 @@
>  
>  #define for_each_node_with_cpus(node)			\
>  	for_each_online_node(node)			\
> -		if (nr_cpus_node(node))
> +		for_each_if (nr_cpus_node(node))

Not having gotten any of the other patches, I'm not really sure what
this does and such, but improve readability it does not :/
