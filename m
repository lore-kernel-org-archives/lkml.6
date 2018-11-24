Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB7EC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 12:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDED320868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 12:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="Li6zqp3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDED320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cumulusnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeKXXJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 18:09:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32858 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeKXXJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 18:09:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id 79so13244156wmo.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 04:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N2E7Pc0zVRLDUB1guUe+9JXVVdfIHz7GBFvgDy5DPmU=;
        b=Li6zqp3rQrkyICn3wxg8DJFy9wU2sWBHQrdJMyB6Kd0MqrfT2LE1ucZKXrxrePHQsh
         FAH29GyELydROpt+zt006J6ZrtBE3A5qauLfXwgsh+tjnfbkXJ1+vaf02cRiQUhh6En6
         uzAoBaXeUzVKn5+n6QOnsw5kgp4a/i5X+duGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N2E7Pc0zVRLDUB1guUe+9JXVVdfIHz7GBFvgDy5DPmU=;
        b=HoNRxgbu0TSr0fXOek6WJFJ9w8jJmqlD7cznVRbEXzRVV0SjGno2L5ARLgmx9AjEJj
         UrxCPGlC3nuf2EHU4HUkqLGPuhxEZDx7IgNWLQmgCe/ugnWZAoFWbUuK5zz8FeqNUrrF
         7WlSmz8noZB2LaFF8wQ12/1NtMsKKGuxuEaOb4MixXIIyhkB6UvC7h2Ywnha1DZeULHC
         llXn54SH7PZGQpot/MyJr5BPcpiEO3jXiM4Bqx3mSqSpvar0pRmFNEmofYOGeXW3CeBQ
         k9G/KdMyYV9Z89eiZENA1Zs1N1VyaC2rau/YBb9fo6rmx+W+k0t8Wj7t09WZigcpxuh3
         U3Dw==
X-Gm-Message-State: AA+aEWZqf1FeSJJawV7d3Xf6AjAkAhnh8zzD0qaY4N8mU1kEAlBh+uHp
        1Y/gaPLy0QLOL5rLF9Hh5/hq8AAgtYedRg==
X-Google-Smtp-Source: AFSGD/X1jSd4ctffN90tGz6WZahncj+V7MuXrk19mE4EOij3XUlEpy0kr8RFi+Am0s3qloGkXQ3Nzw==
X-Received: by 2002:a1c:2981:: with SMTP id p123mr1131499wmp.19.1543062069803;
        Sat, 24 Nov 2018 04:21:09 -0800 (PST)
Received: from ?IPv6:2001:470:1f0a:1832::2? (nikaleksandrov-1-pt.tunnel.tserv6.fra1.ipv6.he.net. [2001:470:1f0a:1832::2])
        by smtp.gmail.com with ESMTPSA id o81sm9811810wmd.10.2018.11.24.04.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 04:21:09 -0800 (PST)
Subject: Re: [PATCH] net: bridge: check for a null p->dev before dereferencing
 it
To:     Colin King <colin.king@canonical.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181124121551.6942-1-colin.king@canonical.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <85963d6a-3411-9461-67aa-42e1fd02e663@cumulusnetworks.com>
Date:   Sat, 24 Nov 2018 14:21:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181124121551.6942-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2018 14:15, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A recent change added a null check on p->dev after p->dev was being
> dereferenced by the ns_capable check on p->dev.  Fix this by performing
> the p->dev sanity check before it is dereferenced.
> 
> Detected by CoverityScan, CID#751490 ("Dereference before null check")
> 
> Fixes: a5f3ea54f3cc ("net: bridge: add support for raw sysfs port options")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/bridge/br_sysfs_if.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 7c87a2fe5248..aab8aa17cccf 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -314,15 +314,15 @@ static ssize_t brport_store(struct kobject *kobj,
>  	unsigned long val;
>  	char *endp;
>  
> +	if (!p->dev || !p->br)
> +		return -EINVAL;
> +
>  	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
>  		return -EPERM;
>  
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

Hi,
I was contacted recently about this privately and this was my reply:
"Checking new_nbp() and del_nbp() it should not be possible to reach that code
with p->dev or p->br as NULL. The cap check code has always been there, I just
shuffled the rest of the function to obtain rtnl lock and kept it as close to
the original as possible, thus the checks remained.
In order to avoid future reports like this I'll send a cleanup once net-next
opens up.

My reasoning of why it shouldn't be possible:
- On port add new_nbp() sets both p->dev and p->br before creating kobj/sysfs

- On port del (trickier) del_nbp() calls kobject_del() before call_rcu() to destroy
  the port which in turn calls sysfs_remove_dir() which uses kernfs_remove() which
  deactivates (shouldn't be able to open new files) and calls kernfs_drain() to drain
  current open/mmaped files in the respective dir before continuing, thus making it
  impossible to open a bridge port sysfs file with p->dev and p->br equal to NULL.
"

So I think it's safe to remove those checks altogether. It'd be nice to get a second
look over my reasoning as I might be missing something in sysfs/kernfs call path.

Thanks,
 Nik



