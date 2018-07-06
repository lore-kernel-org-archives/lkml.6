Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6ACC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A6523E08
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lBbqIwLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A6523E08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932540AbeGFNuA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:50:00 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54934 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754125AbeGFNt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:49:58 -0400
Received: by mail-it0-f68.google.com with SMTP id s7-v6so16577724itb.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9C3vQcIDK3Ji+dTrYx4zGuIY7nRiku9gy98G5yQbHWI=;
        b=lBbqIwLzK6Eqb/CzY7vCovKAZH5XmrHvhWJDZotJ5gxrmoYw4QcgPEXOELQRm4cbEj
         I8YIhvilg+I3gAzkXcU6TXh0wOOTsAnU8ywsXlQvxSbeeBRatveGeuE5Vyx0ToDSsWwe
         LAJ3GxStj9Q0QBqC2m34LMlKDyu3YJvsCX680HhZc7caxqTpScUv2C96oJ6/IYffqTsm
         OmEaNMBJWDX7vEA0eZtf7WLqqqT3eVAcsrORNg3+uEvMDogFwJrNrCihzn+nA3niSXiu
         usbC/0JBpefZ48l4uAXZi7nb2U5N8awqdvZoveiFi7FklBNgShbcLOgqDZ2Tzm8duMcZ
         Bjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9C3vQcIDK3Ji+dTrYx4zGuIY7nRiku9gy98G5yQbHWI=;
        b=BeWweTzXMGe5kBzE5S/4aa57ThAJbCbyFUovp6z8TN/VYOFMnHpbqNuYgDakqJE2yZ
         7xShupgM/8JNoWo/uHTQlcN2V3zrThxPuyN/y2+bcef5NSIvux7NsOrdUNJWDRt0vyVE
         iIXeCdIvwBz18ppv02D9PIYlSksdo8bKmYBA+aE3EdC0TAan4/ONfbj9j0hi28xlxjds
         j6BQ9trkUt+cy7ThoKK8h3ohXB1n/VVv9G2JYAYyFi5uQF/VQFQn3oR8snD0+HjfjvO6
         UmGO6UOqRsDodzoVFmnAQo251ZjWr7YEw2Arce44Q6VKVr4Et8k4tNWEwhJERk+H26RZ
         RceA==
X-Gm-Message-State: APt69E3t57AKeI1xYRZCiYXx8aixE72ubNyINyFMRSmh7qEavSziRDRJ
        AoYMZ2A9tKwcyGagZoQWySnwveaKMpU=
X-Google-Smtp-Source: AAOMgpdhBOLxt/Jae6mF4PWrUQzKRaSjSY/4VkNwLefMWIu/Ys1uNmfNuz61rfLiG/8PfNJ0lbMucw==
X-Received: by 2002:a24:46d4:: with SMTP id j203-v6mr8508375itb.93.1530884997701;
        Fri, 06 Jul 2018 06:49:57 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id o139-v6sm403845itc.21.2018.07.06.06.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 06:49:56 -0700 (PDT)
Subject: Re: [PATCH] block, mm: remove unnecessary __GFP_HIGH flag
To:     Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org
References: <20180703171446.220105-1-shakeelb@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1c8e690d-c3ff-602f-9f26-0dc7f7e65284@kernel.dk>
Date:   Fri, 6 Jul 2018 07:49:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180703171446.220105-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/18 11:14 AM, Shakeel Butt wrote:
> The flag GFP_ATOMIC already contains __GFP_HIGH. There is no need to
> explicitly or __GFP_HIGH again. So, just remove unnecessary __GFP_HIGH.

Applied, thanks.

-- 
Jens Axboe

