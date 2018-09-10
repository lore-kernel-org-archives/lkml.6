Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6135020866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbUgfjEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6135020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeIJMnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:43:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39397 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeIJMnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:43:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so11812046wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Tj6PaSu4b14QJQ9ZNYQ3lZKEUJjXCqXUjueBirjJ08=;
        b=cbUgfjEHAG2FH4SJe75xr79lp9/hdNlZ3DIMZO+FzSfE/NBbySGlFqU1botqEs/oT2
         YpcgT4OyuGBOyEfFdAIh7dFKB1SUvXTkRdfOPoOhLqsEcv2m3oAZlWSaQScYy9uD0K04
         CRApZsdillWqGNtsom1tfuqulVj8pIbpsMJvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Tj6PaSu4b14QJQ9ZNYQ3lZKEUJjXCqXUjueBirjJ08=;
        b=XX/Hx3Qe+zKWZBGD3Iw8DSJEVDDKKwoo4T6C7SnlitlV8tsMbqGJwjOBODgWVTHpTx
         Ser5dYDZycPm7QvUc7ycm4nusS+gVfGQVc0/I+4UlSwZxjDwkW32cnwSYnvkljo8qSXr
         yAYWIpX92dWsIGujsoHPqNdTfy0mcJlDEPkaGYOrcP3X1f7BVeQ4ddQ1+Dh5BJlcJxoh
         Iry1k++qlqJxDnpmu8B/DM0WvhPv2gRdPsJmUAQ4rMi4Oaf1sXR2KMAzcqlj3dxnETm5
         Xrrv9M/k1+uWx7NQgKzT7RpppYgfldjsbs06X89jjRaGnHNwURgj9AIwpqNoL4bORRuy
         vvUA==
X-Gm-Message-State: APzg51DXo2eYky7Qpcs1/oHHcgyFycUAVPeJzM3dIq2m7O5Deu+/wWyc
        L+MScEhM7aCWTPqtXDizQ2L2UA==
X-Google-Smtp-Source: ANB0Vdbf6PCdxZBMHs9O660PbbH/MHc2oGSeWzt8RQhvQV53CxBAV0+AW7DR2KQSex5TDHo16E2ESw==
X-Received: by 2002:a5d:428a:: with SMTP id k10-v6mr14797830wrq.225.1536565854977;
        Mon, 10 Sep 2018 00:50:54 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id k34-v6sm23031537wre.18.2018.09.10.00.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 00:50:54 -0700 (PDT)
Subject: Re: [PATCH 0/2] eeprom: use devres for nvmem providers
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Devang Panchal <devang.panchal@softnautics.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180910074404.8041-1-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a25ef4b9-18cf-ab08-af8f-72b6eaa32602@linaro.org>
Date:   Mon, 10 Sep 2018 08:50:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180910074404.8041-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/18 08:44, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> While working on the nvmem framework recently I noticed that there are
> many providers that don't use the devm variant of nvmem_register().
> This series contains relevant updates for eeprom drivers.
> 
> Bartosz Golaszewski (2):
>    eeprom: eeprom_93xx46: use resource management
>    eeprom: at25: use devm_nvmem_register()
> 
>   drivers/misc/eeprom/at25.c          | 3 +--
>   drivers/misc/eeprom/eeprom_93xx46.c | 7 ++-----

Can you please consider consolidating the devm related changes in a 
single series, to easy the review!

>   2 files changed, 3 insertions(+), 7 deletions(-)
> 
