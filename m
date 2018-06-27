Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48463C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB04229FC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dxBg0h8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB04229FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbeF0Xx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 19:53:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeF0XxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 19:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oMG3/n6/0KNf/mtHzcV5hXn/+e5Nb1KS54PZI1A4Z2Y=; b=dxBg0h8k8GHltwinNK+z+58n6
        hUW3vAn0+DOuJ6jATpS5a7Evlvy86MszddJu3mUSSwsWal0tNj+KnLoS9+YHx5qkDb1PgOlQAW1DP
        O1EHLi7pN3HaOvv78Uec7gTdFaa4vcVAPCiE6Sf3Y9FoTvxau6+Dw26xBIlMjeu13v7Xlmn4P5j0T
        8ZSQw6L1WCPBqoy7wgJn/IFUiGd4OiGRKC8+13eGji+AX2VTL2GNPTPaaYHuJy0myN2d5flxAiDjd
        na5zbpDMZMp5Ir0X+NedVaDcLJPEyjD18tM/BBHkl60ppebjhk02/nwfSLuiDP/oVYoH43SlbkZ0x
        e+0gtvHzA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYKFX-0004yr-7F; Wed, 27 Jun 2018 23:53:23 +0000
Subject: Re: [PATCH 12/15] block: introduce blk-iolatency io controller
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
 <8a8c7008-b64d-1cf0-4cad-bdb73d37b53e@kernel.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <46234c71-9e27-b2f5-63cf-c9727117af82@infradead.org>
Date:   Wed, 27 Jun 2018 16:53:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8a8c7008-b64d-1cf0-4cad-bdb73d37b53e@kernel.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/2018 12:06 PM, Jens Axboe wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Hi,

> ---
>  block/Kconfig             |  12 +
>  block/Makefile            |   1 +
>  block/blk-iolatency.c     | 903 ++++++++++++++++++++++++++++++++++++++++++++++
>  block/blk-sysfs.c         |   2 +
>  block/blk.h               |   6 +
>  include/linux/blk_types.h |   2 -
>  6 files changed, 924 insertions(+), 2 deletions(-)
>  create mode 100644 block/blk-iolatency.c
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 28ec55752b68..c3205b2003a0 100644
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
> +	The IO controller will attempt to maintain average io latencies below

	                                                   IO
please.

> +	the configured latency target, throttling anybody with a higher latency
> +	target than the victimized group.
> +
> +	Note, this is an experimental interface and could be changed someday.
> +
>  config BLK_WBT_SQ
>  	bool "Single queue writeback throttling"
>  	default n


-- 
~Randy
