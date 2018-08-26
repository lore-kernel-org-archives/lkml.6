Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF25C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD49F21536
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jzuS/ndi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD49F21536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeHZGCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 02:02:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeHZGCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 02:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DXy3C9g9nLljUsZFqz4KhJJhvxeq1dFvY/ZAYpt/Fyg=; b=jzuS/nditHz2BJKNVlOyA3SDA
        IqF/jWB4i2Visz2qsujOFrwJ++ktSYQy24oUJhh0ow9arwUuGN52ZVnameIq3jwyggaefBmBYTWFB
        lyAtX/vlukgkwhdO1SwF2mSNAD1aoqqgZvWgyFRuMEL2COgyEApKgPjIVnPD4XrOiwt5RIaSmgAc4
        tA9NKQRBkyEDZT68SGO9Rk6/kIItslfinhi889BiIcQouf9pqPr9pXWKVPM3uj3oBDhtoJ3UOzgyn
        WIJHsdVhR9ccsQvdPk8zWmEKiTncQdEKcLLhcVy6b0nsdKsqBGezTIaVKtCxkohMF6rVo6L4BbH2j
        AAPGYztkw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ftkfy-0007md-Iv; Sun, 26 Aug 2018 02:21:14 +0000
Date:   Sat, 25 Aug 2018 19:21:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] tools/vm/slabinfo.c: fix sign-compare warning
Message-ID: <20180826022114.GA23206@bombadil.infradead.org>
References: <1535103134-20239-1-git-send-email-n-horiguchi@ah.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535103134-20239-1-git-send-email-n-horiguchi@ah.jp.nec.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 06:32:14PM +0900, Naoya Horiguchi wrote:
> -	int hwcache_align, object_size, objs_per_slab;
> -	int sanity_checks, slab_size, store_user, trace;
> +	int hwcache_align, objs_per_slab;
> +	int sanity_checks, store_user, trace;
>  	int order, poison, reclaim_account, red_zone;
> +	unsigned int object_size, slab_size;

Surely hwcache_align and objs_per_slab can't be negative either?
Nor the other three.  So maybe convert all seven of these variables to
unsigned int?
