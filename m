Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B94C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6611A2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RVvS+WT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6611A2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeJOTog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:44:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38248 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeJOTog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:44:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id g89-v6so13860935lfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+wA/SSIjFiNKtL2S4Mc/EU0I/dZapFfAaR7iRgtXDdA=;
        b=RVvS+WT+lKAKm2pO0Fqij9wN8kfcI1iuSnsX5m6iVFWGI7IB5ibffNv+0xJbPTQhvY
         Gb6TWl8oLFKgTGZaEfZFq/8P3Ie2RNpMMysUsSmNLT7OoQJRt+3gk8zWmYbwEVVVZhoX
         qEhoqmRvk56ij+T2F/4wISaW2CqXFMQ6hrvLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+wA/SSIjFiNKtL2S4Mc/EU0I/dZapFfAaR7iRgtXDdA=;
        b=aiUduWN09iG2+4xqAk50TLEi9CSKjz7/M5Jl6a8W3JYB266n8qri2JT8i/NOq/TFko
         ogEgD+SQiQcH5qq3eN5Pnpj/9D4nPuRRk11modWSxWLWebdpU86Cd1prmbcfPaqB/ZJN
         rMUsePlbxaD5zu4rv18BaXSRESxAeOiTzXNgXHzhKZMOX/184EF9vq6yVUD1QNZClJ3L
         R+gARi7BvbmcgYJwiFcnETGOihETY++Llb706bWwV2+9XkGjjBtlC+Tn1MjqBai37mhy
         6RbmyMDL4jIAmKgPmf6D2ckhdHbwb9z8wkz+nyza78/sgA6cc9nBjgURihG0iIKxb6rY
         4JBg==
X-Gm-Message-State: ABuFfogkfofv096D50wQyAsXw4ACyc0x7UngaHuxM2DwkCG3+KAQKcao
        ugreAXAann4eNXZCQoAjfb++sw==
X-Google-Smtp-Source: ACcGV60PKXWx5f6sc1nZnWiogDenAsTob1KUDLdlg0ewmT+FFN5MJX2AhXw9QS36DlDoMob8YTYQ8A==
X-Received: by 2002:a19:cece:: with SMTP id e197-v6mr2191420lfg.152.1539604776037;
        Mon, 15 Oct 2018 04:59:36 -0700 (PDT)
Received: from [172.26.255.55] ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id b132-v6sm2141550lfe.56.2018.10.15.04.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 04:59:35 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 3/8] gpio: 104-dio-48e: Utilize
 for_each_set_clump macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linus.walleij@linaro.org, akpm@linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <5906381114b14d5b0359510a1d23accbd239eaa5.1538441919.git.vilhelm.gray@gmail.com>
 <822be05b-092b-41c2-3c31-8981acd5cb9e@rasmusvillemoes.dk>
 <20181014041933.GA7335@icarus>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <afbe5c62-f003-ca92-d185-8e6e9340c75d@rasmusvillemoes.dk>
Date:   Mon, 15 Oct 2018 13:59:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181014041933.GA7335@icarus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-14 06:19, William Breathitt Gray wrote:

> a bit value of 0 in the
> bits array does not necessarily mean the input was not requested, but
> may instead mean that the value at the input is 0;

sure enough, but...

> therefore, the caller
> must keep track of the requested inputs rather than try to deduce them
> from the values in the bits array.

...I don't agree that this logically follows. A caller might reasonably
expect not to find any bits set in positions other than those in mask. A
simple example would be caller that just tried to ask "are any of
_these_ inputs set"; it would be reasonable to implement that using
bitmap_empty() on the returned bitset, without first having to mask by
the mask he passed in.

Rasmus
