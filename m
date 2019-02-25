Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20165C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6B920842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551107781;
	bh=NE1Qv8PQ9Uke1gVorfEBqHMVLo5SgvMICV9K3hpX4+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ucr3nn8Lm4+WZBl4iir4vgO8s2MEQxT9Hgex3/yM7CLYTiT4KBk7cZKC8YL+syoml
	 +ZmYDEn7Z0zbMOReJoV5Oc/CpeiRaFcrYJ5bI8OOPoME091BdDbUjH6qz3cls5SKAv
	 ZcOVuK3ESmSsGQ2RWTR2YT+LwvrnVdiV62cOEaUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfBYPQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:16:20 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44452 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfBYPQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:16:20 -0500
Received: by mail-yb1-f193.google.com with SMTP id c3so1554295ybo.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 07:16:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SukbM8CMAxoSkIyo1H69YojjlibI/3WJVBKhZOY9v1E=;
        b=snu2dam0ZzYO71OMCuG6TWk6oFqxMpLUUOg3qSljziT5U3mpeYuFkQYqWUDXGvqYt3
         s9cuORAUa+SShqsVTKhtFv7lGDrrw706ZU9dbA62BLnkwcwsVjnk3vJPCxfwOez8G+hA
         lnORYXNg/lDhTw3qtM0yEsWWaC7vygC8k+gZEuY/bxCMlSjmUhEgQQHxyOxhYlr/N9EB
         xcM2vpf4lM/IRoxhc8Wh4U1BLq2zaT+TeMzNETzZfSaSx/J/VKRiPIx5a3+a9DFBjA7j
         CCVL2IVlBFiMIwCCryUKyKeJQkd3A6sIJusJabKcKxLB0h3Q8scS4HmJHkTYest/H28N
         oFQg==
X-Gm-Message-State: AHQUAuaNHkcnFvBSN5trth5sMIy4xgH7ViMZZ21inWMi3X2NmoXN525H
        a8xuqVxr/w7WwBwRmJalquY=
X-Google-Smtp-Source: AHgI3IbPQDBBJv5dmRbrs6BvonMys2urOn/4rMhLOBnGs/VbY7xZxJp+i6QbgO4LmkeqW5c9WftOFg==
X-Received: by 2002:a25:23ce:: with SMTP id j197mr6003459ybj.145.1551107779237;
        Mon, 25 Feb 2019 07:16:19 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::1:8bb9])
        by smtp.gmail.com with ESMTPSA id d138sm1986291ywa.43.2019.02.25.07.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 07:16:18 -0800 (PST)
Date:   Mon, 25 Feb 2019 10:16:16 -0500
From:   "dennis@kernel.org" <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH 2/2] percpu: km: no need to consider pcpu_group_offsets[0]
Message-ID: <20190225151616.GB49611@dennisz-mbp.dhcp.thefacebook.com>
References: <20190224132518.20586-1-peng.fan@nxp.com>
 <20190224132518.20586-2-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224132518.20586-2-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 01:13:50PM +0000, Peng Fan wrote:
> percpu-km is used on UP systems which only has one group,
> so the group offset will be always 0, there is no need
> to subtract pcpu_group_offsets[0] when assigning chunk->base_addr
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  mm/percpu-km.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/percpu-km.c b/mm/percpu-km.c
> index 66e5598be876..8872c21a487b 100644
> --- a/mm/percpu-km.c
> +++ b/mm/percpu-km.c
> @@ -67,7 +67,7 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
>  		pcpu_set_page_chunk(nth_page(pages, i), chunk);
>  
>  	chunk->data = pages;
> -	chunk->base_addr = page_address(pages) - pcpu_group_offsets[0];
> +	chunk->base_addr = page_address(pages);
>  
>  	spin_lock_irqsave(&pcpu_lock, flags);
>  	pcpu_chunk_populated(chunk, 0, nr_pages, false);
> -- 
> 2.16.4
> 

While I do think you're right, creating a chunk is not a part of the
critical path and subtracting 0 is incredibly minor overhead. So I'd
rather keep the code as is to maintain consistency between percpu-vm.c
and percpu-km.c.

Thanks,
Dennis
