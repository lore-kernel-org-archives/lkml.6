Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4D4C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A2720878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BitPXz7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A2720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeG1QIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 12:08:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36761 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbeG1QIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 12:08:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id b22-v6so5395544lfa.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YoQveHrYPV6rU/j6PVFFUOjhVI5Q9WMAt3fDuIHGSbM=;
        b=BitPXz7QmrW9S+70TwZk4jE6m1OiZrpkfvoouudQxxkrC+zOOGHcuoSa1v0oHqLJip
         hoJsEflmmpqz48OZcVsCAkZEhYOsWoyv+TDHgHvbeaZ1UMHTiy5dEdBKDdArFqL5SPH9
         CwEksJGkkOjhUrBAXM1S2V41v+khZkPaFdJ5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=YoQveHrYPV6rU/j6PVFFUOjhVI5Q9WMAt3fDuIHGSbM=;
        b=NVODSq7lT7cGtJsKZUcG6BoMY5VH7fGhs01cJb8fNd1JH/o3DdAupPQpOvtNTwVorm
         DqWw22W0wA9q5byjR3pGtSmq2vWB4+xbJURwPIA8BWQuR/Ly3BNnQ0GjCL5Bt9R4nMhj
         QmXeiktqm6PGmCrc3LblMKiBNtEgizWNR8q82yRqy9kw6MUVVl4cfECBm7ju/G97gPso
         oDGgDJnshuMwA0ydcFLqxTTUZs/brdL595CXBqFLKIRbNURwHf7xx860yr1jzhGwUTa8
         VEf8+bKfhFmbzjgW9fbDdbvo8zAwV7hMUAI8YqJLgm38SmmXq+W9Wt/6+DzpVjQTJUBw
         wKHw==
X-Gm-Message-State: AOUpUlHVkwkQy1NirQwqlOSoCuumjQfc/7f7aMDkv5aWVVO/57xFt2lx
        ATpevlHqpqTWQ69Zx+AhSESNWg==
X-Google-Smtp-Source: AAOMgpdLNXr9e9X5oR8YmIJCoYWlFe+Bg1hec8U91w8pLd6UzG5dblacOll8aC30oruJrpvJIUor+A==
X-Received: by 2002:a19:a417:: with SMTP id q23-v6mr6267670lfc.59.1532788889080;
        Sat, 28 Jul 2018 07:41:29 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id t8-v6sm900684lfd.2.2018.07.28.07.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Jul 2018 07:41:28 -0700 (PDT)
Date:   Sat, 28 Jul 2018 17:41:26 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch
Subject: Re: [PATCH v3 net-next] net: ethernet: ti: cpsw: replace
 unnecessarily macroses on functions
Message-ID: <20180728144125.GA7561@khorivan>
Mail-Followup-To: Joe Perches <joe@perches.com>, grygorii.strashko@ti.com,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch
References: <20180727225725.3843-1-ivan.khoronzhuk@linaro.org>
 <c2b3f36b8e7e1a2799580e76f19a267351da5491.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c2b3f36b8e7e1a2799580e76f19a267351da5491.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 04:30:54PM -0700, Joe Perches wrote:
>On Sat, 2018-07-28 at 01:57 +0300, Ivan Khoronzhuk wrote:
>> Replace ugly macroses on functions.
>
>trivia:
>
>As cpsw_src_port_detect is only used once, and is a
>very small function, it might make the code more
>intelligible to just directly code it where it's used.
>
>> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>[]
>> @@ -565,40 +565,40 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
>[]
>> +static void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
>> +				 struct sk_buff *skb)
>> +{
>> +	if (!cpsw->data.dual_emac)
>> +		return;
>> +
>> +	if (CPDMA_RX_SOURCE_PORT(status) == 1)
>> +		skb->dev = cpsw->slaves[0].ndev;
>> +	else if (CPDMA_RX_SOURCE_PORT(status) == 2)
>> +		skb->dev = cpsw->slaves[1].ndev;
>> +}
>[]
>> @@ -801,7 +801,8 @@ static void cpsw_rx_handler(void *token, int len, int status)
>>  	int			ret = 0;
>>  	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
>>
>> -	cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb);
>> +	cpsw_src_port_detect(cpsw, status, skb);
>
>here
Can put here, instead of function, the following:
	if (cpsw->data.dual_emac) {
		port = CPDMA_RX_SOURCE_PORT(status);
		if (port) {
			ndev = cpsw->slaves[--port].ndev;
			skb->dev = ndev;
		}
	}

if no objection ofc.

>
>> +	ndev = skb->dev;

-- 
Regards,
Ivan Khoronzhuk
