Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FEDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5159E2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKweT8ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5159E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395524AbeKWBF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:05:59 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36263 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388795AbeKWBF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:05:58 -0500
Received: by mail-wr1-f49.google.com with SMTP id t3so9459245wrr.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O9mtJItt77q3fDbJJ9bwC01gcz0u7ZRhcuPrGY5A47E=;
        b=IKweT8ma9LlN8u6z05TFs2SerJN9wfGI0FKo2RJZ/Gfatjzl1BFEVZNz7zCFhUPfci
         ItYWBRUvxbNiA4/WYFPwwlFi1SE/zRCQVeNkn8l2Qwp1cOVtx7fREQhMGAGG6RIyTyKY
         1fStjjfmLKFqXKxL15juGNJJ8pHZtBZddjF8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O9mtJItt77q3fDbJJ9bwC01gcz0u7ZRhcuPrGY5A47E=;
        b=Wf5uYDO/4IYcocZqmVezAYIF2kvKJXyIw0f6yAS1eCZcrxx1OUOLAGtwDW9qUYxJTn
         3h+9WN1FmEg51shw/mhfG5T3lrGmTuRY+oNqqcTK4cANSwTIq+6VsR0us8Vj45WluicI
         lfeTLlOEx2sKwDlHcG7yQMibi0C3PVOgtNpAUU/wMcPVQYZEIhIB6SQEqxMevdrKpfsT
         iV7DVvQFUXAgK1yZ6e2BM/IxJK6wCNcGy7YGZeRBhj4IoqXV9YmCSdo9cfknx3/ZfAh6
         bwGBvrwaykVdOxZ1BjoAbstkvnRGnw+H6UseemFbq86T3wE/Bqg9xx2Q3IxQ5QuhIwnq
         rdqQ==
X-Gm-Message-State: AA+aEWYYziWVaKX3wDgPiQXlT+6aEwpDuPkSPz7QdMmDH3rirVdd7O30
        5tb8F+QuNYZLxa6NlYMfGX0YkBsgi+U=
X-Google-Smtp-Source: AFSGD/XNs1pIhaEtRa1M+UV8IbJcM7dYtuOiqx1FjWMhtVSSSp3nuskCMnAiF+tdDI6Bk3njN6QkMg==
X-Received: by 2002:adf:8323:: with SMTP id 32mr534197wrd.176.1542896781219;
        Thu, 22 Nov 2018 06:26:21 -0800 (PST)
Received: from [192.168.0.40] (44.65.136.77.rev.sfr.net. [77.136.65.44])
        by smtp.googlemail.com with ESMTPSA id q185sm4781869wmg.14.2018.11.22.06.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 06:26:20 -0800 (PST)
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add of_node_put()
To:     Linus Walleij <linus.walleij@linaro.org>, tiny.windzz@gmail.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181120131853.19710-1-tiny.windzz@gmail.com>
 <CACRpkdbk_b2PbEPRQN2R=FJekLQ59Jv3-7DBBULYuM=FCWMz4g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7eb11ac5-3dff-93a4-8766-dfbeb76fb3b2@linaro.org>
Date:   Thu, 22 Nov 2018 15:26:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdbk_b2PbEPRQN2R=FJekLQ59Jv3-7DBBULYuM=FCWMz4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2018 15:22, Linus Walleij wrote:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
Thanks!

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

