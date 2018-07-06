Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC217C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E58E23E87
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="W6q6yI7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E58E23E87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cumulusnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933223AbeGFMvd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:51:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38710 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932780AbeGFMvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:51:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id j33-v6so4091768wrj.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZFVj5xcLDlXbz7jow5/ZFXywlIPzslJwcrQ3McVl3oA=;
        b=W6q6yI7uV5zlQtY44+Gte1pwQIa++53doTBjESs0BS1uBFhN4mb2dwEEp/VsQeSBOb
         negVlLQXQYxmEbXrPE5DweFlSmbAWAPm1PMf/yiv8gDZILxLLKsc3rmbrJiueAHpMWWx
         vwwULtdwjQ00s/rFgY75Q/S233le9oEqULGlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZFVj5xcLDlXbz7jow5/ZFXywlIPzslJwcrQ3McVl3oA=;
        b=OV7TiiJ8IMT8eQ8+PpSFW6tPAauiSSAEm9mCFCRxIHzaankSE1+TLQPP1FVxwKln6r
         +cilC9SIqtLNUVicTpCgcC4ftXCc3324XetZlhJBOFyYut73IfZLiO1/rrgXAr6z2dcY
         mNQwNJukKH39Hh5OKNhd42vwVKH4Anpu1HA4SG0VwMmD9b2Dv4qwh0dIXa2PKa6pqQ79
         T9I+MKAQeoDwfi5zlYeeejVLXAOdWSw4NcpfN5z7OhcK942wV5dQ1YdwUkXtZSmA8pGB
         2MpRCoFu3CmOk7UG9s0tJVSHa29cy4bFy17DdHBO41wmfXG2z6HkEIoM2lRWBIbgCUOo
         Ydhg==
X-Gm-Message-State: APt69E3M92wuhWNuJNQk1bQXz/kcy7MkqGGUHxS7IT1lNpkFO4KWEqv6
        q2S13geSobAI+YHMZZiJiaapREPp
X-Google-Smtp-Source: AAOMgpctqpVlPY2CbLwSW2EPwLHlSyBQAAxJOeoaSStmJ/0xdEygmANZSm6/D6OmoIyO8Eiznch5cw==
X-Received: by 2002:adf:8895:: with SMTP id f21-v6mr7326274wrf.250.1530881490416;
        Fri, 06 Jul 2018 05:51:30 -0700 (PDT)
Received: from [192.168.51.243] ([93.152.141.58])
        by smtp.gmail.com with ESMTPSA id i4-v6sm13078319wmf.4.2018.07.06.05.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 05:51:29 -0700 (PDT)
Subject: Re: [PATCH net] net: bridge: fix br_vlan_get_{pvid,info} return
 values
To:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Jiri Pirko <jiri@mellanox.com>, Yotam Gigi <yotamg@mellanox.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180706124420.3129099-1-arnd@arndb.de>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <49b31434-53e5-72e9-ae0b-1c1200806a50@cumulusnetworks.com>
Date:   Fri, 6 Jul 2018 15:51:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706124420.3129099-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/18 15:44, Arnd Bergmann wrote:
> These two functions return the regular -EINVAL failure in the normal
> code path, but return a nonstandard '-1' error otherwise, which gets
> interpreted as -EPERM.
> 
> Let's change it to -EINVAL for the dummy functions as well.
> 
> Fixes: 4d4fd36126d6 ("net: bridge: Publish bridge accessor functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/if_bridge.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index 7843b98e1c6e..c20c7e197d07 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -105,13 +105,13 @@ static inline bool br_vlan_enabled(const struct net_device *dev)
>  
>  static inline int br_vlan_get_pvid(const struct net_device *dev, u16 *p_pvid)
>  {
> -	return -1;
> +	return -EINVAL;
>  }
>  
>  static inline int br_vlan_get_info(const struct net_device *dev, u16 vid,
>  				   struct bridge_vlan_info *p_vinfo)
>  {
> -	return -1;
> +	return -EINVAL;
>  }
>  #endif
>  
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

