Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22906C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC3420882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="v+IFQX2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfA2WxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:53:20 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33715 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfA2WxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:53:20 -0500
Received: by mail-yb1-f194.google.com with SMTP id m132so7149858ybf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 14:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6MYSIu9/mxSgvVDzeyAbkyzekemqllHuVnpF2mA9+JM=;
        b=v+IFQX2U1tBEJewgmJ5IQT8W9FVVwF+gS7oR55ixFbJeRF7KjjVOIbSTaW7vfyuyX+
         zjFJZOO5EVvQvAgZq7GTtAbi0SAPexF0xlpZ6/EkDeSTVwEwCJbwJvuChhXGZyxXx7vF
         0dBbo5wjw63dB2MMh2qwuwVBr0sPkXb7FxDG3gSVDAH7KbVN/bidpdIcXP6Og7YT4RwX
         3Gqzd7Y2Oj67G1PqpHGsGFMkTX+1a39TtEAxbsSC4uXztAb1AfZpEq50Ctpy8pToLNXo
         5KJq3QATze1/eg2Cs5FVThUAYi3WQZTiw96tjPiVav6ClaDAcyEhrbvtPO2Flm0ZWYb5
         54Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6MYSIu9/mxSgvVDzeyAbkyzekemqllHuVnpF2mA9+JM=;
        b=QdvkHOKSKEzcM4C1lftjjm8xQxJxj2Bh+b1S9nZa7Ws3pVBqP4EkLIaVAuKp4NzcLF
         JPBUDEr22Tct7fJXBLF6OlXIDRto8ju3gt3g9lx1Uv/OWGqunBGK/VX9ytl+hgqLmYK/
         55w0uhIsOOBSsZlNCmeynH+GIH9QAiErioPgqjRezFsSyVN/f7EvFs2aAERrHA+3jSw5
         Tnknyb/ZXzYJOLEoBkzT4zyk1uKBKvTit3ROcXIFsov3qqRrPXSukyt+B1vrJXWd8lWN
         C5MK6oIY5S3T1+BZk+7BK/y+dJJjsTROjfyBh1k1MVs5R7i3TpHDsPaofZ00BE6Jh8/h
         ywqA==
X-Gm-Message-State: AHQUAuYClHuHI2Hvk8vfxCQ8Rl712y2/sNDu1Pp8nbKaMt6GLctKTZLm
        wg07OUqh+KVfDtP2kXIaWXkJZb1lOzU=
X-Google-Smtp-Source: AHgI3IbQOkhPGIi2VDq4AzAvBM7PZMZp6f/mE9dZqw4Ul4vZAEUBaNyh9TTj+V1JCKaR6Z0f3mMHoA==
X-Received: by 2002:a25:db06:: with SMTP id g6mr10082131ybf.498.1548802399444;
        Tue, 29 Jan 2019 14:53:19 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:1d25])
        by smtp.gmail.com with ESMTPSA id n16sm18580765ywn.31.2019.01.29.14.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 14:53:18 -0800 (PST)
Date:   Tue, 29 Jan 2019 17:53:17 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@suse.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 PATCH] mm: vmscan: do not iterate all mem cgroups for
 global direct reclaim
Message-ID: <20190129225317.GA15515@cmpxchg.org>
References: <1548799877-10949-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548799877-10949-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:11:17AM +0800, Yang Shi wrote:
> In current implementation, both kswapd and direct reclaim has to iterate
> all mem cgroups.  It is not a problem before offline mem cgroups could
> be iterated.  But, currently with iterating offline mem cgroups, it
> could be very time consuming.  In our workloads, we saw over 400K mem
> cgroups accumulated in some cases, only a few hundred are online memcgs.
> Although kswapd could help out to reduce the number of memcgs, direct
> reclaim still get hit with iterating a number of offline memcgs in some
> cases.  We experienced the responsiveness problems due to this
> occassionally.
> 
> A simple test with pref shows it may take around 220ms to iterate 8K memcgs
> in direct reclaim:
>              dd 13873 [011]   578.542919: vmscan:mm_vmscan_direct_reclaim_begin
>              dd 13873 [011]   578.758689: vmscan:mm_vmscan_direct_reclaim_end
> So for 400K, it may take around 11 seconds to iterate all memcgs.
> 
> Here just break the iteration once it reclaims enough pages as what
> memcg direct reclaim does.  This may hurt the fairness among memcgs.  But
> the cached iterator cookie could help to achieve the fairness more or
> less.
> 
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Looks sane to me, thanks Yang.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
