Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00BBC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 07:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A709D21905
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 07:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGKr19S5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeLWHbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 02:31:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36383 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeLWHbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 02:31:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so9054157wrp.3;
        Sat, 22 Dec 2018 23:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b4BSxs5OmDvkxRnOxnJFJ3IX148xL98kma57v+jE6f8=;
        b=KGKr19S5Q6Zsr2+Zatjr0Ky/EXlq91lwkOkc8yZLkvpHUDGsdp3cLRQ0XzbY7RJGCo
         4G/nuM/Whb03XNP8LnM4Ubc9odo90oLYxsov9sSBUVKqYoqcM6RC3B9XKk1Yu9VB1uZo
         4t4m36O8Hi/6duuklXsC2x8dT3EdBF6g9tR4Nj0k93/8ByBaPKR74ISlqLATMrEB1lMp
         DY3uNa1A26RdX4+rWSAJpALVqanOksgIC6tbNWfsMnUSOKAdWkouRj9I6GBw9ScU9IRZ
         OwHcLNQs5M0UPhHin2kV5t+i0It30adLB/zusK9SNJEZt6G3WdhXD/pz4d37myGEVPCp
         gs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b4BSxs5OmDvkxRnOxnJFJ3IX148xL98kma57v+jE6f8=;
        b=t8f+YWB+g9eFzT/yeh3wd/ZX1d54yOLktL/EOqKN3MYDfdtOe27vwmeumXeq7ObIp0
         mHGxhkmmNwEHbXG0iC4buT3zfgrfYHlpFjP3e++jVMF3CGN9/XXgggWA8K/n64hOBTfX
         E9skmv3hwsB9CDd57s3AzFaf//WFWIJjnMZWGhDthUUbCOCUpvDzGzGD0nWjEoJm332H
         R9P1NsdnPtTvF9w9hZrik6X92GF8EBigMJoUqZkw80XEHVzjSM30pEg2xyGSQGnl5fWM
         y+/JZdBxZOGPpZ2bhH25CcPFPSnOheQvz5Q7rFGJ4db2EnV+hinLIcHfeRm0ps18hzBX
         EoYw==
X-Gm-Message-State: AJcUukftDxxcc5vwPUJMP18CBJudPxg1fMOqYgbZIXuXu+wnEzEg4hfW
        KUbuyxEOFfKPCvWB6yPA35s=
X-Google-Smtp-Source: ALg8bN5MbZ/GARwPkxGhoyKzj0duytZ7tW7D9sNFmXrS8Uku/AxdFl+KN+qfaNlt80cS/ygQxvWEXA==
X-Received: by 2002:a5d:5208:: with SMTP id j8mr8459652wrv.188.1545550270329;
        Sat, 22 Dec 2018 23:31:10 -0800 (PST)
Received: from [192.168.8.147] (140.15.136.77.rev.sfr.net. [77.136.15.140])
        by smtp.gmail.com with ESMTPSA id 126sm31974209wmx.26.2018.12.22.23.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 23:31:09 -0800 (PST)
Subject: Re: [PATCH] sock: Make sock->sk_tstamp thread-safe
To:     Deepa Dinamani <deepa.kernel@gmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, arnd@arndb.de, y2038@lists.linaro.org
References: <20181221202733.19627-1-deepa.kernel@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <e4f80b85-eafb-691d-2ebc-056d565f5d62@gmail.com>
Date:   Sat, 22 Dec 2018 23:31:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181221202733.19627-1-deepa.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/2018 12:27 PM, Deepa Dinamani wrote:
> Al Viro mentioned that there is probably a race condition
> lurking in accesses of sk_tstamp on 32-bit machines.
> 
> sock->sk_tstamp is of type ktime_t which is always an s64.
> On a 32 bit architecture, we might run into situations of
> unsafe access as the access to the field becomes non atomic.
> 
> Use seqlocks for synchronization.
> This allows us to avoid using spinlocks for readers as
> readers do not need mutual exclusion.
>

Hi Deepa

Please come up with something that has zero added costs for 64bit kernels.

Most of us do not really care about 32bit kernels anymore, so we do not want to slow
down 64bits kernels for such things.

Look at include/linux/u64_stats_sync.h for initial thoughts.

Thanks.

