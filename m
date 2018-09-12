Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF982C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5E820839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rI9ZxGNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5E820839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeILKBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 06:01:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38687 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeILKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 06:01:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so382003pfh.5;
        Tue, 11 Sep 2018 21:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pCPl6VdbXdq/0aEWzW2wUZ3z9/BeDtwpNC0lheZ+VrY=;
        b=rI9ZxGNqWiOxplPJC6zvh/Mo/DyV9qowVenZCMBNZPDe6mql8ENGEFfpqfrPmfR9xs
         zbwI4M5JKQPoC6v5WouA3Q8R5z0jktX0Bu77YMB9rUEBG2BEo5nAZ2vtDFPOh8+SAaDC
         vbuA71a8vwSGUQOMLpDRpjEurvJLYd0DWTa58HgxnDhq6PRcvImo3rjUKL83TAeAU4Hm
         gwVnGggVqzRV/hL5BEioakELrrxzGhM93FeOu8E5rY/MdBYZpFGKLRTBujbtAGv6YlvX
         wcF4TAnDeRWUeb29Hq5ZnzanX7cj5/rRhxkRAklV+kE0NysVRP6L5VRmNH3FQhz2+ZtG
         KcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pCPl6VdbXdq/0aEWzW2wUZ3z9/BeDtwpNC0lheZ+VrY=;
        b=DNySQWPcFOCSuZhXhRDPEapLN3vXQiC4s4vcc4kaOO930kMfTeqsQxWA0k/sfBqA+1
         tgUkqaBk3YFetHdS/2R4ep6Sv83lDvkcCrETMVQcLq7KLZk+D96Aw36poqjrlVSKnb3r
         LJTRLpLSkrUDyCEdstxPxF7UUKFNeMrI9wsnd1+aQP4PyEFRsUlPVB5yzZntGgjQGZks
         PmLZa7TL7KrK/ibM8AHIpAGSCa8IyFM021awtcAI2x/H/OtpgW65pRVEEdBt4eOBf603
         dvN94siznXPSjEcNPbFg5Hle6XJou1EDRv3vz4KPtvkow4Bnvd3CDCErQLGsPxCj1E9g
         lZdA==
X-Gm-Message-State: APzg51AdH8zXWkLeXCFr6wZm6TSSYyru9pXh6Wop/CsYi1V1J3PDPdRK
        3mW0Cwa/Se8Nv4DrfmFdFbP5aCGB
X-Google-Smtp-Source: ANB0VdYe1plpMxCDjIxdTFqGzLF3rL+f4x++gmMEI8BvGfVYFu4mI3DCjAuHWDY5KJ2FeqbgKVkF6g==
X-Received: by 2002:a63:cd4c:: with SMTP id a12-v6mr90790pgj.15.1536728330452;
        Tue, 11 Sep 2018 21:58:50 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m15-v6sm33904413pfk.149.2018.09.11.21.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 21:58:49 -0700 (PDT)
Subject: Re: [PATCH] firmware: vpd: fix spelling mistake "partion" ->
 "partition"
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180911165858.3015-1-colin.king@canonical.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <50220bc9-326f-7a93-fecb-9b67fbac98b9@roeck-us.net>
Date:   Tue, 11 Sep 2018 21:58:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911165858.3015-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 09:58 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in comment
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Interesting - drivers/firmware/google/ does not have a maintainer.
Greg - is it correct to assume that you are the de-facto maintainer ?

Guenter

> ---
>   drivers/firmware/google/vpd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
> index 1aa67bb5d8c0..c0c0b4e4e281 100644
> --- a/drivers/firmware/google/vpd.c
> +++ b/drivers/firmware/google/vpd.c
> @@ -198,7 +198,7 @@ static int vpd_section_init(const char *name, struct vpd_section *sec,
>   
>   	sec->name = name;
>   
> -	/* We want to export the raw partion with name ${name}_raw */
> +	/* We want to export the raw partition with name ${name}_raw */
>   	sec->raw_name = kasprintf(GFP_KERNEL, "%s_raw", name);
>   	if (!sec->raw_name) {
>   		err = -ENOMEM;
> 

