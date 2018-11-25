Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B67C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB15E20850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="CnVjt8Ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB15E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cumulusnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeKZD6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 22:58:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39940 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeKZD6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 22:58:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so16514398wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 09:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HbDMpepYnesllhsIW//oNX57QiUUur6Q/GuACT7KuHA=;
        b=CnVjt8Ce15YkrVwm81j7Ek1cZ+uvXLNCY+NdPLlWNsFOSxN+lGfhkgXurYXZje4yZN
         CiLEj1sFTNkWWTAaAQDjqUz89PYXeoilYSsanr0RT58ygYWIptx2nrnGMH/Vx1gPHey8
         /EsWiKK1QeTL4cIc9sVyZriq2hE9+RVYAThu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HbDMpepYnesllhsIW//oNX57QiUUur6Q/GuACT7KuHA=;
        b=n0xNQGtULucN7sKa4sjwSYITjKr9AaxJk3ACojcIGz4sHz1Z8Ny6C3NepUfpuOkNPq
         wQNxsGGz4eGBWsom76ozPc/f+fij12hcj4jLUSaFPGYciJ6LOLBdu5Ys92iHEbc7tOy2
         /p5HbC3HsRU2C+zB44NR1TzJ5hM6Tx7g3lASAB8b71kBP1JzVf5aJ8MysXyN+wVt6W5K
         k3JXEpuQPA1hQboIFNm8kX7TorONevDBKNE0qYoZ7atN8fBgvkQSJUb9zAcUCLtxEWlg
         zupoSPgXy7l9rC7L5Zkuo7xr0Ks4l8CgyYTeI53uiVm0prF/YKDKVG1prG4aoRvxy4Al
         MdTQ==
X-Gm-Message-State: AA+aEWbPzeNLxeO0maNONUxsX2lk5+l+q9XwHn4JiyWTyW6YuSX74uRk
        el2nS27DDGWqYkGVsMIZXIdFyjshqF0=
X-Google-Smtp-Source: AFSGD/U9hg17pFEklr0CS7J3sywrtlYtLglhoGnzEnlOAZcjjnSCXCMLGor2jX5waO6/gSJmXf1mpw==
X-Received: by 2002:adf:8505:: with SMTP id 5-v6mr21560640wrh.224.1543165602989;
        Sun, 25 Nov 2018 09:06:42 -0800 (PST)
Received: from ?IPv6:2001:470:1f0a:1832::2? (nikaleksandrov-1-pt.tunnel.tserv6.fra1.ipv6.he.net. [2001:470:1f0a:1832::2])
        by smtp.gmail.com with ESMTPSA id h16sm8739557wrb.62.2018.11.25.09.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 09:06:42 -0800 (PST)
Subject: Re: [PATCH][V2] net: bridge: remove redundant checks for null p->dev
 and p->br
To:     Colin King <colin.king@canonical.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181125160851.6919-1-colin.king@canonical.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <074d65f8-d6e8-078e-9365-a2d8f74b0c5e@cumulusnetworks.com>
Date:   Sun, 25 Nov 2018 19:06:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181125160851.6919-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2018 18:08, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A recent change added a null check on p->dev after p->dev was being
> dereferenced by the ns_capable check on p->dev. It turns out that
> neither the p->dev and p->br null checks are necessary, and can be
> removed, which cleans up a static analyis warning.
> 
> As Nikolay Aleksandrov noted, these checks can be removed because:
> 
> "My reasoning of why it shouldn't be possible:
> - On port add new_nbp() sets both p->dev and p->br before creating
>   kobj/sysfs
> 
> - On port del (trickier) del_nbp() calls kobject_del() before call_rcu()
>   to destroy the port which in turn calls sysfs_remove_dir() which uses
>   kernfs_remove() which deactivates (shouldn't be able to open new
>   files) and calls kernfs_drain() to drain current open/mmaped files in
>   the respective dir before continuing, thus making it impossible to
>   open a bridge port sysfs file with p->dev and p->br equal to NULL.
> 
> So I think it's safe to remove those checks altogether. It'd be nice to
> get a second look over my reasoning as I might be missing something in
> sysfs/kernfs call path."
> 
> Thanks to Nikolay Aleksandrov's suggestion to remove the check and
> David Miller for sanity checking this.
> 
> Detected by CoverityScan, CID#751490 ("Dereference before null check")
> 
> Fixes: a5f3ea54f3cc ("net: bridge: add support for raw sysfs port options")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> ---
> 
> V2: remove checks instead of moving them before the dereference of
> p->dev.
> ---
>  net/bridge/br_sysfs_if.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 7c87a2fe5248..88715edb119a 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -320,9 +320,6 @@ static ssize_t brport_store(struct kobject *kobj,
>  	if (!rtnl_trylock())
>  		return restart_syscall();
>  
> -	if (!p->dev || !p->br)
> -		goto out_unlock;
> -
>  	if (brport_attr->store_raw) {
>  		char *buf_copy;
>  
> 

Thanks,
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

