Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295EBC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23EC20645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7itfcJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23EC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJCPRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:17:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37233 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeJCPRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:17:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so5077637wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 01:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B04iEOn+glMgsdFsnBr09o4CJZURwtx/azkbpqKl9Y0=;
        b=d7itfcJLK2vREqQebiDwGtlNe96ME2rd16Pj0juoPLC/C5K7lYbfaMcYgTgAwulEmb
         w6GWRKA+yYdAgDRoVjM2voTjp4p7FoPHZBFwn0d6cK6G0oy5sETbGDz0huIiwNtmpYjr
         YVxKJRT95lWgEIt5Qp8XJ18V68pO1S5p/F6e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B04iEOn+glMgsdFsnBr09o4CJZURwtx/azkbpqKl9Y0=;
        b=l1E7w5DEeorSQKUMm+qUe5SgzNLOGsiySE2GQsPxW+d7PQMIBWxCm9kHcCL8/8nCtE
         ffZThyZ6LleEBizCxkwT1DvNvi8SMLayvZXlAWsjxmgkHl6TxeUhYdDZT8j0vM41F6g1
         POqEH6MG+rMmJez8fL77tSGF7PFaNWptZpP03Mw8z/RNiY6yAsHDvEoB+ITW7sWGWOOM
         XiRQl5WFTOy8hy4daJpgAScY7M5xSwdbq59BX8+iSqSl/+83S1hfSVd0pqGINxRea2SU
         SiKyHmEh+VGJ2j4bC+AJisKPNoQXFJmaAbcb8kjRyZ+4JYoHgu7NLuizqFt/6/+VaEGE
         ssAw==
X-Gm-Message-State: ABuFfojqQ2qsC6FTcz8cN14JOcR63kc5AFXKoVkoOGKlSyf2UGYOBC9i
        dggzx6yA7RwBFT/QCzjWucjzpJsw0/M=
X-Google-Smtp-Source: ACcGV637WompO8ec9jHQejaa3qs7PJS3QAjeYRn5TJQUDWQT5CqM72MF8c8mKnVLqkGeANSWW/yT7Q==
X-Received: by 2002:adf:c793:: with SMTP id l19-v6mr381382wrg.230.1538555413170;
        Wed, 03 Oct 2018 01:30:13 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id x186-v6sm2400537wmx.24.2018.10.03.01.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 01:30:12 -0700 (PDT)
Subject: Re: [PATCH] nvmem: hide unused nvmem_find_cell_by_index function
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20181002211123.2662419-1-arnd@arndb.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e212aa6a-e3d3-8d58-fdf4-7d22919184d1@linaro.org>
Date:   Wed, 3 Oct 2018 09:30:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181002211123.2662419-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/10/18 22:11, Arnd Bergmann wrote:
> nvmem_find_cell_by_index() is only called from inside an #ifdef,
> so we get a build warning without CONFIG_OF:
> 
> drivers/nvmem/core.c:496:1: error: 'nvmem_find_cell_by_index' defined but not used [-Werror=unused-function]
> 
> Move it into the same #ifdef as the caller to avoid the warning.
> 
> Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Missing Reported-by: other than that..

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
