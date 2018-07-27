Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616DEC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1865F20873
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="EE9nz9Ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1865F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389596AbeG0VnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:43:15 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33258 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389416AbeG0VnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:43:15 -0400
Received: by mail-yw0-f193.google.com with SMTP id c135-v6so2319775ywa.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xKoV9XZrM6rn7yc27J0PJxg87wpt9Zpdhgaytzl/gIM=;
        b=EE9nz9Ob01HeRZYh+hxP50gCBhRfsaw7ucCv6RDDhPyFu6l1m4zzYZ3GZKU8IOFrmS
         t0x1DM2ZqLUGI4fAaQstq+h7fgn7qbm2FvYtQicTy6vz0Vs6vts83hm7MOsoBM2L9gEF
         Y1eL0gAddisjoVLimRlun/LgzGjrXS/S91UggnMuzXDy4Abig/3nzbypkCXAuJjVzrnV
         LckXPHruaS5jc27Hm+baBc4Q4Ztx323Kw4jYM79FuN+bEu7ysmndhXjUDNw7IiFqxjiA
         Lo3uiiGZfItGXCyLI1/itxgZJ6ZKLRfzpYHmZBYYWXLTytQxY7OsXUfSgo29J0b4bVLR
         Mkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xKoV9XZrM6rn7yc27J0PJxg87wpt9Zpdhgaytzl/gIM=;
        b=llAfvw8scVKtFAR9eAL9abPYm8LVOInpNxvw/h1PLPffPME6Rj67lJiry8nuWD4Tlm
         g2EtxojDZYh9DwLOsPE5ivmvsVpYMkJx++bdLBfExdp51bONEGZ3YE6i4WxxZuMzF+zY
         o15gP1kCal7q+j3x7e1SGqPPBFzP0dwAuwZl/0IZ2GAdEIZUnvs75S4KyaiE32D7Ye93
         w5/aWxPqxdz3TIICHfEDIKuV6eobbeGgli8qI/v2IDxJ3RlhS8+3Dlj3GXc3dhhqFNp+
         nI6Y3uJoWp9oBnF1ZYCT/rO2BK+nJFabH42ex5TQiij/x/MHAFbHohuOdjYPVun/kQ8K
         aS7g==
X-Gm-Message-State: AOUpUlErK/mf1EipzUp/3PtIng1FD1WXQfMgkg1skFExswK1aeJ3RywH
        B/M/XNorYWFc73wDS7eDdRPh4g==
X-Google-Smtp-Source: AAOMgpeTDTg1YPRDI/aX7tNSyO42UvTPmHhj9tWDH79SsJnCCNv7afq88VSgtDLuoNgoSv1nowNMrQ==
X-Received: by 2002:a81:2ac2:: with SMTP id q185-v6mr4159326ywq.190.1532722785658;
        Fri, 27 Jul 2018 13:19:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:b944])
        by smtp.gmail.com with ESMTPSA id z125-v6sm3652121ywg.57.2018.07.27.13.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 13:19:44 -0700 (PDT)
Date:   Fri, 27 Jul 2018 16:22:36 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     mhocko@kernel.org, linux-mm@kvack.org, linux@endlessm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Making direct reclaim fail when thrashing
Message-ID: <20180727202236.GB12399@cmpxchg.org>
References: <20180727162143.26466-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727162143.26466-1-drake@endlessm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:21:43AM -0500, Daniel Drake wrote:
> Split from the thread
>   [PATCH 0/10] psi: pressure stall information for CPU, memory, and IO v2
> where we were discussing if/how to make the direct reclaim codepath
> fail if we're excessively thrashing, so that the OOM killer might
> step in. This is potentially desirable when the thrashing is so bad
> that the UI stops responding, causing the user to pull the plug.
> 
> On Tue, Jul 17, 2018 at 7:23 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > mm/workingset.c allows for tracking when an actual page got evicted.
> > workingset_refault tells us whether a give filemap fault is a recent
> > refault and activates the page if that is the case. So what you need is
> > to note how many refaulted pages we have on the active LRU list. If that
> > is a large part of the list and if the inactive list is really small
> > then we know we are trashing. This all sounds much easier than it will
> > eventually turn out to be of course but I didn't really get to play with
> > this much.

I've mentioned it in the other thread, but whether refaults are a
performance/latency problem depends 99% on your available IO capacity
and the IO patterns. On a highly contended IO device, refaults of a
single unfortunately located page can lead to multi-second stalls. On
an idle SSD, thousands of refaults might not be noticable to the user.

Without measuring how much time these events take out of your day, you
can't really tell eif they're a problem or not. The event rate or the
proportion between pages and refaults doesn't carry that signal.
