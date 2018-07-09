Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FC2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CE220840
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BwJ5sYNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CE220840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933364AbeGIQea (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:34:30 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37942 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932806AbeGIQe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:34:29 -0400
Received: by mail-it0-f47.google.com with SMTP id v71-v6so16725508itb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jYWDz6H5cCpUiAp4+Y4I7nn7NfP4kihfMOvr6Y8rCTs=;
        b=BwJ5sYNNPx+KQEA3GUqJ0+hM+bISwaQxyfdKe41Rj/Vune7kAmZvGO7gUj2vVFAN6j
         ygFeu+2I0Mb4pTzl/4uYSdF82Vpz2X/bfOnajF3aBZmDoIru65gV6nSIesMlQ1Kn9JNM
         BiaPw3KM8J2IKitAK6PEk13zjlZ344+2NpppGdC9uqylIUkBnf7U9TFghhC0FKU8DoRn
         UMh0X/sYyEyXnifQgCECZbpkkgltr9OmFq/uP36ykO5TUK0mKRvrFOe0+ee1jaiXsuFc
         6IxvRRwFHbv6RmYap+nBVaxKhIfKk2LDpJdvUqIl6ZzLfH8s/+UsoiqkdKv2hXp77qq4
         ENEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jYWDz6H5cCpUiAp4+Y4I7nn7NfP4kihfMOvr6Y8rCTs=;
        b=ruQ7HaALFJoYk3Dlx93thEwZzbJX2NiBZSJFD1C4dJEfn04SnjfFKTvdkwimcPgk+c
         aK6ORZlDeRygPij7I4q5N3RN/BLfScB9n0b/3NAGQ5DxM3JORl7sOcWjNeEJJjxXGPdC
         R9zWH3RWomeBVqpcO0OOKjjvYhWe9JcsNYq7pAkW3uNwetz2zYf0qNVBkfGAvPSstD/X
         yBnDzEa4xzIMmyphNLtRi8v/D39jq/mPGM1MTEVOZrBUYR0Mr1RTOuQfLX2KixkDEPvA
         /T1VPUwCvBjB3wZClS0ZwIecimV32MgCCpZW7v+Ea1QFI6y1iXyjj+IDDsJg9KUgOoHk
         YhGg==
X-Gm-Message-State: APt69E2ZtmM4TrMeol5DaLJvrGFFlrm3lkzinRy4D0MmW7CQ+CmYCJan
        jO1Q3jUI2luTbgi11Qv3rzjt4w==
X-Google-Smtp-Source: AAOMgpeCHg3hhExCkMBKu4HaZFY5hTctrpH4K6F+7VEhOJs5waIpcbT34ovlr27cAlw6wY9hEuXnKQ==
X-Received: by 2002:a02:9b9c:: with SMTP id p28-v6mr16759648jak.28.1531154068682;
        Mon, 09 Jul 2018 09:34:28 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o193-v6sm8238503itb.41.2018.07.09.09.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 09:34:27 -0700 (PDT)
Subject: Re: [PATCH 0/2] null_blk: zone support
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        loberman@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart.VanAssche@wdc.com, Damien.LeMoal@wdc.com
References: <20180706173839.28355-1-mb@lightnvm.io>
 <1530899118.31977.1.camel@redhat.com>
 <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
Date:   Mon, 9 Jul 2018 10:34:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/18 1:54 AM, Matias Bjørling wrote:
> For fio, you can use the zone support here:
> 
>    https://github.com/bvanassche/fio
> 
> It is in the process of being upstreamed.

In the spirit of making some progress on this, I just don't like how
it's done. For example, it should not be necessary to adjust what
comes out of the block generator, instead the block generator should
be told to do what we need on zbc. This is a key concept. The workload
should be defined as such that it works for zoned devices.

The trim as zone resets seems odd. What happens if you end up with a
zoned flash device in the future?

The support code looks fine.

-- 
Jens Axboe

