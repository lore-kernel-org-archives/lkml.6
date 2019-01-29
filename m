Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D8FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E83D2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Wplr7vFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfA2WPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:15:52 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40608 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729556AbfA2WPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:15:52 -0500
Received: by mail-yw1-f65.google.com with SMTP id g194so8842470ywe.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 14:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cjPKJoHf3Gll+qk80dZ1zwwaf8+ItgdBe9DjCPAWJDM=;
        b=Wplr7vFthNztMxNfahA1bdj2lR3+YAdLQRgxzerOl/TRr5R4rFJx8TUrvIk1v7GEmQ
         kW80/oYXICrRj09V7xe49KhmG2HZE1rJdek1rUmiqrM2TA1ik6ZtsJgqvXoDfbFUOR+S
         r4jYBxwP6P+szzZp1EYHRu4AAGuOv48jtQZkBrJIuIK+HpL2oLgfyUT6VPMjGkKDonHS
         muByxxO7QtKKoPg2xVphTkV4PvV79xkf5ySxjt/21cxk5LPq3n5eJ1Ke3iNPGFjjCCDn
         eVLHYSC/VtVDEYZMxvnvbWN0zOjJl29ex2JcIHoqtd4k3gYMyhNO+XXv3bD3rnJ2e43X
         LLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cjPKJoHf3Gll+qk80dZ1zwwaf8+ItgdBe9DjCPAWJDM=;
        b=HMjJsDxqmQGQNakievnO1EjuoUcxvI9ctsPCU3WkfvBw4VeSF/dq6IuL+0dSflWlmr
         aPIe0NMXQ3Q42VQsmXNvBKTyHPVXa1fWZy9o3lPpHX9TDskOgUjWLuAA6bXjMg7ownZY
         rqgBdigIFM6lEZIr1Vxq73IjaEsffdtLYWBn5SQtBlMwhVgYWxcgMN7mSjHXxfOpiNkb
         5YXmIux12jxWcRj7CNHCbPnQudg3EXiq0HjcKm7V5OI2ZSbMol6JH5Sfn/JzS4E81HZD
         FMssEfcffZg1qVoi22GZGbqL0CZdrrA5c/QUmEtXzK71D3lRz6oDgynBQHPknvBJpjEx
         Dd1A==
X-Gm-Message-State: AJcUukd1LZRwC1HYLAIuPCpgRXz75vRFRMTuObAOOwa5pVV0F9gUPIao
        bGLTKxNBeaE+LNN9PJA0Ulfi9A==
X-Google-Smtp-Source: ALg8bN7irhuyfL8ClWcmZz429auZ4MvffBQRSq6hSXFkHXRmgB0027WWy+O8lD2sUt1XagmxX0AEHg==
X-Received: by 2002:a81:1282:: with SMTP id 124mr27709051yws.154.1548800151050;
        Tue, 29 Jan 2019 14:15:51 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:1d25])
        by smtp.gmail.com with ESMTPSA id e189sm14009152ywc.101.2019.01.29.14.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 14:15:50 -0800 (PST)
Date:   Tue, 29 Jan 2019 17:15:49 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: Expose THP events on a per-memcg basis
Message-ID: <20190129221549.GA13066@cmpxchg.org>
References: <20190129205852.GA7310@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129205852.GA7310@chrisdown.name>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 03:58:52PM -0500, Chris Down wrote:
> Currently THP allocation events data is fairly opaque, since you can
> only get it system-wide. This patch makes it easier to reason about
> transparent hugepage behaviour on a per-memcg basis.
> 
> For anonymous THP-backed pages, we already have MEMCG_RSS_HUGE in v1,
> which is used for v1's rss_huge [sic]. This is reused here as it's
> fairly involved to untangle NR_ANON_THPS right now to make it
> per-memcg, since right now some of this is delegated to rmap before we
> have any memcg actually assigned to the page. It's a good idea to rework
> that, but let's leave untangling THP allocation for a future patch.
>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com

Looks good to me. It's useful to know if a cgroup is getting the THP
coverage and allocation policy it's asking for.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

The fallback numbers could be useful as well, but they're tricky to
obtain as there isn't an obvious memcg context. We can do them later.
