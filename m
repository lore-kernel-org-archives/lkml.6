Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DD8C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 04:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83032064C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 04:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LG6/trAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83032064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeJYNX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 09:23:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45167 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeJYNX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 09:23:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id t10-v6so7139752eds.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 21:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dgURxOrOIM6UEDItFy3ornyJhobgxSte/+4zp7Hb9vE=;
        b=LG6/trAvtBtz+0rR1/WKCo21uImO9PGEQeJJAx3t6OcdnO/WhsCz2EKhusHg19Ubao
         gEqeUWnjz7pHDUPwDoT+BOaJD4cSScpvxdHYwIBD7s8F4vU8Py57jS/O9bblFirKqgze
         TUEPMI+k4bc+aurvm00OjWMCzn3WC/WsTyWtcHib0qMhKGmcSPDUVe2DICpLpZRWB8HL
         eGiGDVTniDivWybpYjue33p1OiWB9INopy9fBuEfQhUgHdHvf2VozAOtIqK7S85g2KDv
         otRY/itcYeq7ObAykyBB1I7GGPAI+GpZ05ycBf0dDTXvCwBUjkPSSita47GjVEL6iyhw
         fQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dgURxOrOIM6UEDItFy3ornyJhobgxSte/+4zp7Hb9vE=;
        b=NcL5YTqnNGwRYaj+6//fdhnhDliPi5u3SyudUSAPUdqEYzrKSbPLHn1cAuhDvXib+d
         ppXmmQ0u6wAFrMziLOdgUpIX0sW3aKK3SxqaA+iiFnbkZIbfB+VUqFLh3a4Hh3azcsM8
         fbr5ACwK+Sare/hfgaiCxwPeu2JzvSSdiGNYx73ddkg+bOlgFAT/AQM0R0P42U9iu3Rx
         G55cF+nc60qzoeg9ifhD/AmL2jPijmJx6bg6GlvK1Pvppm8qCwnBxumtG2rWGKJUi3C6
         o6zV+6JdbmcI4BeZZcx+Sm437BhmfJ6SjXQ8ymXtCILv0eTP5W5AXslM86zRNdFKleMw
         bMCw==
X-Gm-Message-State: AGRZ1gLWD+F4z0vsosBUafIGLrc1QOnt0JP8hDgFGbfzGifJzA4/Rtsd
        Su5PYsboCfXnRBuo+as0IBrgdw==
X-Google-Smtp-Source: AJdET5fLlf4ZLW+MwE/kUPu5aXMVWmXbaphSpv96Up12r1PzdFUV34oCZOCSQxv5CM6IOIf6dzfGIA==
X-Received: by 2002:a50:96d1:: with SMTP id z17-v6mr316373eda.268.1540443175175;
        Wed, 24 Oct 2018 21:52:55 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id v16-v6sm2390271edm.49.2018.10.24.21.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 21:52:54 -0700 (PDT)
Subject: Re: [PATCH] netfilter: conntrack: fix calculation of next bucket
 number in early_drop
To:     Vasily Khoruzhick <vasilykh@arista.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20181025034853.23573-1-vasilykh@arista.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <a2fa755a-048b-459a-b526-2fe27cbb6574@arista.com>
Date:   Thu, 25 Oct 2018 05:52:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025034853.23573-1-vasilykh@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 4:48 AM, Vasily Khoruzhick wrote:
> If there's no entry to drop in bucket that corresponds to the hash,
> early_drop() should look for it in other buckets. But since it increments
> hash instead of bucket number, it actually looks in the same bucket 8
> times: hsize is 16k by default (14 bits) and hash is 32-bit value, so
> reciprocal_scale(hash, hsize) returns the same value for hash..hash+7 in
> most cases.
> 
> Fix it by increasing bucket number instead of hash and rename _hash
> to bucket to avoid future confusion.
> 
> Fixes: 3e86638e9a0b ("netfilter: conntrack: consider ct netns in early_drop logic")
> Cc: <stable@vger.kernel.org> # v4.7+
> Signed-off-by: Vasily Khoruzhick <vasilykh@arista.com>

Nice work!

Reviewed-by: Dmitry Safonov <dima@arista.com>

> ---
>   net/netfilter/nf_conntrack_core.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
> index ca1168d67fac..a04af246b184 100644
> --- a/net/netfilter/nf_conntrack_core.c
> +++ b/net/netfilter/nf_conntrack_core.c
> @@ -1073,19 +1073,22 @@ static unsigned int early_drop_list(struct net *net,
>   	return drops;
>   }
>   
> -static noinline int early_drop(struct net *net, unsigned int _hash)
> +static noinline int early_drop(struct net *net, unsigned int hash)
>   {
>   	unsigned int i;
>   
>   	for (i = 0; i < NF_CT_EVICTION_RANGE; i++) {
>   		struct hlist_nulls_head *ct_hash;
> -		unsigned int hash, hsize, drops;
> +		unsigned int bucket, hsize, drops;
>   
>   		rcu_read_lock();
>   		nf_conntrack_get_ht(&ct_hash, &hsize);
> -		hash = reciprocal_scale(_hash++, hsize);
> +		if (!i)
> +			bucket = reciprocal_scale(hash, hsize);
> +		else
> +			bucket = (bucket + 1) % hsize;
>   
> -		drops = early_drop_list(net, &ct_hash[hash]);
> +		drops = early_drop_list(net, &ct_hash[bucket]);
>   		rcu_read_unlock();
>   
>   		if (drops) {
> 

-- 
           Dima
