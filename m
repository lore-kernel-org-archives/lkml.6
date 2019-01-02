Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18B8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736B6218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ejq8pC35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfABRNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:13:20 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:36633 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbfABRNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:13:18 -0500
Received: by mail-it1-f176.google.com with SMTP id c9so39506643itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 09:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xaBXVnhI8jzlprEy4nyQcmkkWlMQFIARzFDRwXd03K4=;
        b=ejq8pC35mSmtizWEUyTBnF4fgQoBgvS14/5HPQskfxt1IlMsbc8+BJZESp4N7ct13V
         znU5dCSXIbH76cYuZrsxi/Sj9VFaVDQ+3MiMlh0XsRDaIo/nZ4xtlFyJzYHdN9laFy4g
         omQrhkoR/lWTFulNF2tra4Q0fVw22EePRugd4oA6WYrox/SYzvxIJG5ldupFC7MXaYyY
         YD7i1SpJ6n9+MaDKJEeHgPPaNWTutqcrF9R+C7lDhBIWIivk98eafaEeTQqmlfFx6RcW
         drAcPkfRAZMy9ymx/Z1XcKCBon/FL3Mns+lYLj6RtCRTmsTkGyjMdpIyD4G+8UhkU2Jq
         U2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xaBXVnhI8jzlprEy4nyQcmkkWlMQFIARzFDRwXd03K4=;
        b=mgWkv5eCOAl1Nvp4Cae1aa2uMxe5dBr7YhCj/UxJvsAr74h78j4R/q8eO4wMPPlUPO
         aAYgEoI090W732c5qX2I5TPdTvyQNrLGBhJKGbD7TiRju3y9f3sx5AzqM44j95ID5BQn
         EKIY3QHfKC2oabdU6Zj5LJpCo8clXefJ565fF8gBPWoPyyHMvoOoX+FIH3CeBKa8M79E
         qszTJQyDdKSqu33ELTyL0YZbChKUVDWsOED2s3LcjvSqc0xzyf8W6jqIbyP+Uip44xsn
         +7sKRRMSETch3w9SlR5jEgBaEUucqBUQKgmBgLwopOMiUpm7HYKl7K15kR+KdZKvYmpR
         k6Eg==
X-Gm-Message-State: AA+aEWZz76YkvtbN2X54ZQOVGm27qC8UZxDs0+7a2+QCJFHmrYGOKSMj
        whLuhu7T1edG3xRjGzQRHmdnCqEsBiZOJg==
X-Google-Smtp-Source: AFSGD/V6+uFjC9pkE5afSipAjtLisw2n2opyw61bB5J1eXLODdVbnPGgk1mGOLO5LGDBeJs7yPyngA==
X-Received: by 2002:a02:57c4:: with SMTP id b65mr30248858jad.79.1546449196569;
        Wed, 02 Jan 2019 09:13:16 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e22sm3090809iol.49.2019.01.02.09.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 09:13:15 -0800 (PST)
To:     linux-raid@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: Shaohua Li
Message-ID: <398a74fa-6566-8d0d-6434-e68ff3763656@kernel.dk>
Date:   Wed, 2 Jan 2019 10:13:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got some very sad news to share with you - over Christmas, Shaohua
Li passed away after battling cancer for most of last year.

As you know, Shaohua acted as the maintainer for md. He remained
dedicated to that through the difficult times. With his passing, we
obviously have a void that needs to be filled.

For now, I'll act as interim maintainer for md until we can find a good
permanent solution. I'll queue up reviewed patches in a separate branch,
in the block tree, and help review fixes. I'm subscribed to linux-raid,
but please do CC me as well.

-- 
Jens Axboe

