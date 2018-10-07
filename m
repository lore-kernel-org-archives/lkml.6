Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FF4C6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 22:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CF72088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 22:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CF72088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbeJHFRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 01:17:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38687 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeJHFRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 01:17:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so9152723plr.5;
        Sun, 07 Oct 2018 15:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YZ7BXXiQMt6Ugf4OF7z3nfT027Rh0chNaueHXupqcmc=;
        b=fgng3Aa5N4KTwtNo4SjNLoFneMk+NmcTPVlHb/rsB3gcOS6j7v3WWGxkol56jpHPiL
         tygqhgP7htYkZfmDsDN9MQFuuI2qDW5AhLKaE2Na+lJQBYAng2Jm7rt4/Kddmw5pf/Tg
         H16cH31mg0JXEM4qvdLpsho7wG6vKUA30nBYegNZMN0qD4Q/IdQxBW7EQD5pAIBpN2sT
         /riWnrwV50jO8zdKX9vrfxofnhYfsKidhmwNmB1YZkYiLbY6Jn7EoUZCjLIfOsAF+0pC
         DJDcMjfGMJua+GayGl28GSrOIq7z/nd/GZ8IysXaJchDRVF9xldH5XNnj0CmZZfS/w0C
         ljaA==
X-Gm-Message-State: ABuFfogfkm6+7r4OOqMGzTzpluc89tZ4WczYGl7rBV2UgrxBCuG7ae2C
        5Ttqh4j7ONOK2Lknx7nDwZ4=
X-Google-Smtp-Source: ACcGV63FvN0qjpk+jcYa0hNr7jXJwlZ6BOfBMVpZ5yH0yRFgVWQRDo1uQHdon54zdpW8uD3G9+1fAg==
X-Received: by 2002:a17:902:48:: with SMTP id 66-v6mr10559757pla.7.1538950155541;
        Sun, 07 Oct 2018 15:09:15 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:461d])
        by smtp.gmail.com with ESMTPSA id 84-v6sm26607222pfv.33.2018.10.07.15.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 15:09:14 -0700 (PDT)
Date:   Sun, 7 Oct 2018 15:09:11 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] percpu: stop leaking bitmap metadata blocks
Message-ID: <20181007220911.GA3425@dennisz-mbp.dhcp.thefacebook.com>
References: <1538901111-22823-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538901111-22823-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Sun, Oct 07, 2018 at 11:31:51AM +0300, Mike Rapoport wrote:
> The commit ca460b3c9627 ("percpu: introduce bitmap metadata blocks")
> introduced bitmap metadata blocks. These metadata blocks are allocated
> whenever a new chunk is created, but they are never freed. Fix it.
> 
> Fixes: ca460b3c9627 ("percpu: introduce bitmap metadata blocks")
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/percpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index d21cb13..25104cd 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1212,6 +1212,7 @@ static void pcpu_free_chunk(struct pcpu_chunk *chunk)
>  {
>  	if (!chunk)
>  		return;
> +	pcpu_mem_free(chunk->md_blocks);
>  	pcpu_mem_free(chunk->bound_map);
>  	pcpu_mem_free(chunk->alloc_map);
>  	pcpu_mem_free(chunk);

Ah a bit of a boneheaded miss on my part.. Thanks for catching this!
I've applied it to for-4.19-fixes.

Thanks,
Dennis
