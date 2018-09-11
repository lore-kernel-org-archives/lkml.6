Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6C9C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC5B2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="luFOAxNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC5B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeIKRmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:42:13 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38823 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbeIKRmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:42:12 -0400
Received: by mail-yb1-f195.google.com with SMTP id e18-v6so9257422ybq.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8kJlw7yEXDazQLIHw8sS1uExHVoxW/EX6Ci2vaSal/g=;
        b=luFOAxNNwpe6NfiCadhZx7TBPNR/mQwk2A7f7RtFjjng8pIXDYnEo9SdNgPIjiX6+Y
         U/qr9DIpklezfxm834gqIe7zHNcuxN0YoGfzseVpDoOOe0rke/vF7mma6WkpTGFP+uo6
         UpoPgxwVgv/iKAbAmI8dvhCAL+e42iuPn80g7glH5IOtGof7dYlqtcic8GZI/Akgc3BF
         GgpXrAsj0HfkhSE0wT9mueJhBOp3x3tkMkzJB69Sc725D05byZ4TATmpP6yMAFzmvLax
         SxjAAdYQYjXcs6M+AO24cv4TJ6CPD5r2sGu/bGBPcz3yKDzXzQCapDMpicVHvNaa/Y+c
         HkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8kJlw7yEXDazQLIHw8sS1uExHVoxW/EX6Ci2vaSal/g=;
        b=S+LHOnENtpVQzUkOd8H3t8u23DiohfgDzKItz3LV6PGbZvj76dh+3mBVCg6hURZHtF
         8nlZcm1ay0b8qOKFI68qEMaV74DQbtWLASDZWf6nDw5rnSsIySdtEXEpKYS0nEXnu9+P
         Y4f77pSmHc58J/jkDC9NTVyZA/3dfAUYTkKMEI3RAgccZcobMYCLX2Jv0Mhxb/9Sxxb8
         Q04S9BfnE8qheDLs94+OzJ1HK0gHhwjKygOEDL3SQx3eEoEGH9fP7M9XbzOUW6MZnC6x
         uCxLgtvN6W7HjHwFhJQCc09vUz4h6/pZPuN3kolwywm5Elxr8pxNFaKpgpgAlxtdYHBP
         DCOA==
X-Gm-Message-State: APzg51BOH8vl9GHTqZVslP9gs0GbemTjCS26diJpUdg79ztBril66JhK
        U3ck54sk8tv2qlsPTUEgsFpIfw==
X-Google-Smtp-Source: ANB0VdaBlzvG8VOoPS0x3T5g2+U2iroy1NDXP6aEW6UbexhV1TWXv+crdIw0Xtjg7VDVa2oL4WYSNw==
X-Received: by 2002:a25:42ce:: with SMTP id p197-v6mr12680620yba.294.1536669782751;
        Tue, 11 Sep 2018 05:43:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:1f19])
        by smtp.gmail.com with ESMTPSA id u196-v6sm6619808ywg.68.2018.09.11.05.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 05:43:01 -0700 (PDT)
Date:   Tue, 11 Sep 2018 08:43:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RFC] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
Message-ID: <20180911124303.GA19043@cmpxchg.org>
References: <20180910215622.4428-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910215622.4428-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 02:56:22PM -0700, Roman Gushchin wrote:
> The memcg OOM killer is never invoked due to a failed high-order
> allocation, however the MEMCG_OOM event can be easily raised.

Wasn't the same also true for kernel allocations until recently? We'd
signal MEMCG_OOM and then return -ENOMEM.

> Under some memory pressure it can happen easily because of a
> concurrent allocation. Let's look at try_charge(). Even if we were
> able to reclaim enough memory, this check can fail due to a race
> with another allocation:
> 
>     if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
>         goto retry;
> 
> For regular pages the following condition will save us from triggering
> the OOM:
> 
>    if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
>        goto retry;
> 
> But for high-order allocation this condition will intentionally fail.
> The reason behind is that we'll likely fall to regular pages anyway,
> so it's ok and even preferred to return ENOMEM.

These seem to be more implementation details than anything else.

Personally, I'm confused by the difference between the "oom" and
"oom_kill" events, and I don't understand when you would be interested
in one and when in the other. The difference again seems to be mostly
implementation details.

But the definition of "oom"/MEMCG_OOM in cgroup-v2.rst applies to the
situation of failing higher-order allocations. I'm not per-se against
changing the semantics here, as I don't think they are great. But can
you please start out with rewriting the definition in a way that shows
the practical difference for users?

The original idea behind MEMCG_OOM was to signal when reclaim had
failed and we defer to the oom killer. The oom killer may or may not
kill anything, which is the case for higher order allocations, but
that doesn't change the out-of-memory situation that has occurred.

Konstantin added the OOM_KILL events to count actual kills. It seems
to me that this has much more practical applications than the more
theoretical OOM, since users care more about kills and not necessarily
about "reclaim failed (but i might have been able to handle it with
retries and fallback allocations, and so there isn't an actual issue".

Is there a good reason for keeping OOM now that we have OOM_KILL?
