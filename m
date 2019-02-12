Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF14C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753982190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="bCg7kSok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbfBLSr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:47:27 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39525 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbfBLSr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:47:27 -0500
Received: by mail-yb1-f196.google.com with SMTP id s5so1448462ybp.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NHgwJW8uZa1+IvdRZWLjiQxpHR7wp1gc5jbfvmSpeBI=;
        b=bCg7kSokGrTdQuBARH3O2Nhzc9WlfTeQ+dtwHWXUq8FY03gFuSmjwOa27VYdYL6r9f
         ycv8bQvneBI0LpeN/3T+N7HhFHyZHDGgx8GXwdwcC1kUnVdGVh1L9k0gydFUjw1PLI2l
         5pVhOnK1GDqV/uNs0hhwBWvIrDiIGl60RrKhy9Oy3nHZ8oECt2xwFF7a8L2vSR3cqX7x
         c1FjWP/BAzVD9n8OYBFun6pRHCgO8FYIW+ws0fUzLJ5hCwZchsxkr5aRcNVOL+4vDDnL
         EX+VxLAM0y0SNb1r5DT/RTkOt9zTqGGW5HDoktGG2uYO1Vuxg/FwNLgd4gZh1v2h46Su
         MjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NHgwJW8uZa1+IvdRZWLjiQxpHR7wp1gc5jbfvmSpeBI=;
        b=raoL1JnawZ6JYTGgRSz5Lti7LVBoFM2BMTYU4JpFb+S51UFARNmDFsTjecWxyUgWOw
         XVzACmw1E561YQcsLRR3vRIc7cTCBVpsjbx0nRwwtgbOCyJ8w+0GfTB07xphWtlMD7Xl
         i+pD31ki9kd1iffaO3nt54qN8//3iUMy3J6kqKsA1ClWPuNGFOS5h4Qs+ho1ntx2Cw4+
         /Y27hsnllT0axFjkfhQ1roRzcG1u4aAFCWoqvyVniwKILRNfJRpPGtUYWeRU+A3GdY/H
         RyvDFgNeC6x0gTjBSnviR7cE0eb0lj8H2qz6GDFoIf+nTbn6epJXFehdC/8T3RadsjV4
         nicw==
X-Gm-Message-State: AHQUAuYdZapGOmUKA/YXGjRPplwTxjyHJZ812+CkuZDkZCtH4u/LC7qh
        paIuJxiIXwWFztOH3htpo9WkZA==
X-Google-Smtp-Source: AHgI3IaQHJL8sj8e3YvFWEGuPHknSiaKLw50Q46hJ9x70lqKEK4DXNI2Ft7jqYE/pbh+h08dEyhTkw==
X-Received: by 2002:a25:c207:: with SMTP id s7mr4123285ybf.37.1549997246781;
        Tue, 12 Feb 2019 10:47:26 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:41f4])
        by smtp.gmail.com with ESMTPSA id t10sm5228536ywa.17.2019.02.12.10.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:47:25 -0800 (PST)
Date:   Tue, 12 Feb 2019 13:47:24 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v2 0/3] vmalloc enhancements
Message-ID: <20190212184724.GA18339@cmpxchg.org>
References: <20190212175648.28738-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212175648.28738-1-guro@fb.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 09:56:45AM -0800, Roman Gushchin wrote:
> The patchset contains few changes to the vmalloc code, which are
> leading to some performance gains and code simplification.
> 
> Also, it exports a number of pages, used by vmalloc(),
> in /proc/meminfo.
> 
> Patch (1) removes some redundancy on __vunmap().
> Patch (2) separates memory allocation and data initialization
>   in alloc_vmap_area()
> Patch (3) adds vmalloc counter to /proc/meminfo.
> 
> v2->v1:
>   - rebased on top of current mm tree
>   - switch from atomic to percpu vmalloc page counter

I don't understand what prompted this change to percpu counters.

All writers already write vmap_area_lock and vmap_area_list, so it's
not really saving much. The for_each_possible_cpu() for /proc/meminfo
on the other hand is troublesome.
