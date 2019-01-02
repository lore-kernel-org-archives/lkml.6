Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA76BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D0720651
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+y/jTqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfABWfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:35:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55928 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfABWfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:35:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so27702307wmc.5;
        Wed, 02 Jan 2019 14:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eyZMVtWQ9pJz7gTpoPE8jVT2lTLYfy7xLcQPY07+6Bk=;
        b=L+y/jTqqWOL0AvTlu8/Rsb2qO/E8dUvpvSeQ+azIXW1c/1auulLGCcQ7NbPAbRJqny
         7VhC5ZesrzmODcZ8041OefW6JQaCPJ1phLJ+RyuSG9wuETiO4GS7it4uxGz5UP3w6VWA
         rm6NbHiVmlFjlCjFB0QzTjdwOPKi+yxFRKPA0lyVWCTdUpfD73JNQTaMt5Ex6J1iSrkn
         /hJo7mwVsSAjkN7z7LK+W2jS61mwjHnAt4xA9X5buNzAWo6GyuusZBrM9HxPIXxh5ivx
         H8NJH8DaQQRHpEUNzTXgEGyN59FX0MZ0TDEgSrhmLfvRUy0ALufghc5Qny/dfsn7t3RA
         nHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eyZMVtWQ9pJz7gTpoPE8jVT2lTLYfy7xLcQPY07+6Bk=;
        b=ndqcaMn9eqE5gUu4xkv+o2uRCiKhAsUDF5s6EenwBimuunwvzdQb3j3JKQvJTFvHZw
         nYoTmFnh42n2TzPdYhmU9uHoJp4gLDR6uMUHztZJLgQG6/qFXyMLXbiT4fubnpU8Hbj+
         ih1ZdOQiE7AniKiaAoEtswuF3BxEkBIZPJNuktACQe6czaCvV4YH8i1F8Oh/eUoTx4KA
         N+NUd/qw70bF1IkaBn52Gxb3dqFOjYO54jXDJ7tIUFckNMu6wo+DBuC3kIRX6Yq9tRZF
         KYZZqeygeMa8Erdvy/qZcQa1hdVpCThyFdIOBzDlzK8lBUo2GSZQm1uyDjUAcomFWS0d
         ZDVw==
X-Gm-Message-State: AJcUuke5vAvRheUUDK8pLZbLTsZf8x2IHJW14N6rV7PaB4mg367lfB39
        lHs1mR/3Ps+B0EZsNL141TbeV5JP
X-Google-Smtp-Source: ALg8bN73sIsGs3fxgSo8fjIgsGsRvvGM5tVIBChJGDzse5XgJ+Y5tZR7fxfudCDh7gOd4MdztDu0WQ==
X-Received: by 2002:a1c:cbcb:: with SMTP id b194mr33392474wmg.64.1546468503810;
        Wed, 02 Jan 2019 14:35:03 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:b1b0:e226:6e4a:92da? (p200300EA8BCFE300B1B0E2266E4A92DA.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:b1b0:e226:6e4a:92da])
        by smtp.googlemail.com with ESMTPSA id l14sm110895889wrp.55.2019.01.02.14.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 14:35:03 -0800 (PST)
Subject: Re: [PATCH] r8169: Add support for new Realtek Ethernet
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, davem@davemloft.net
Cc:     nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190102064507.32122-1-kai.heng.feng@canonical.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <e7c57645-3bc0-2689-bbf6-c8e915514e51@gmail.com>
Date:   Wed, 2 Jan 2019 23:34:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190102064507.32122-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.01.2019 07:45, Kai-Heng Feng wrote:
> There are two new Realtek Ethernet devices which are re-branded r8168h.
> Add the IDs to to support them.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/realtek/r8169.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
