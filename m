Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0490C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34C724625
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A6VbSVSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34C724625
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753699AbeGCTcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:32:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeGCTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fYgIgyxHLvKpoME8RhL1Rt4pwFWRmLPU3Us/KdAKp3Y=; b=A6VbSVSXi+YnblRCQ3otr3P8P
        989dBYylfXY+rsrrBE++92I13/SvA96okCGU7E7WO4mPKl/geqUHQskmne9PipekTtG+0XlO1Tqr8
        dTb2S4hJvz7YUAuQfnh3uYnSzl79kYje6ABvGPTcQ65NA3f2JkjoiSUKLsGvomm1OPVUhS2IB26Cj
        uJSrorIXtgICbb4jUBAgdyk3B50Y400VOJLGy3GeC5nbyqgNQ32xJrBtBG8pmZgcDELAZapkPAxeh
        5SnTkFekLRDM4vDXP+TA1sI2mnatTqEXF5QvEdFInZduKc4fkpt/awEFhN9e2UIUZ9DsHo/8Ih1JA
        4/cU9SEbA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faR25-0000JC-WF; Tue, 03 Jul 2018 19:32:14 +0000
Subject: Re: [PATCH 12/14] block: introduce blk-iolatency io controller
To:     Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Cc:     Josef Bacik <jbacik@fb.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
 <20180703151503.2549-13-josef@toxicpanda.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e1f98f78-bf01-272f-3121-02612d01d57e@infradead.org>
Date:   Tue, 3 Jul 2018 12:32:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703151503.2549-13-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 08:15 AM, Josef Bacik wrote:
> diff --git a/block/Kconfig b/block/Kconfig
> index 28ec55752b68..074c6099c31f 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -149,6 +149,18 @@ config BLK_WBT
>  	dynamically on an algorithm loosely based on CoDel, factoring in
>  	the realtime performance of the disk.
>  
> +config BLK_CGROUP_IOLATENCY
> +	bool "Enable support for latency based cgroup IO protection"
> +	depends on BLK_CGROUP=y
> +	default n
> +	---help---
> +	Enabling this option enables the .latency interface for IO throttling.
> +	The IO controller will attempt to maintain average IO latencies below
> +	the configured latency target, throttling anybody with a higher latency

	Could that be:                            any process {or any task}
	I don't want to see it throttling any bodies.

> +	target than the victimized group.
> +
> +	Note, this is an experimental interface and could be changed someday.
> +
>  config BLK_WBT_SQ
>  	bool "Single queue writeback throttling"
>  	default n


-- 
~Randy
