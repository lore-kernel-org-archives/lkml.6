Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13761C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8822081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmHb9mZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8822081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbeKHEVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:21:02 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36278 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeKHEVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:21:02 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so22225507qkf.3;
        Wed, 07 Nov 2018 10:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+3ZamjbwwK/rLdZXffbKuwJ2yFy7jvMdLv24u+z477A=;
        b=EmHb9mZ/LzXsmzB45WNvqxC6uFF7HIZ+1Zth1/KGDPI1t5gJqqb1yBoWzMIzKcr+oh
         UbH1M03q+8J/ZUBmK4O5fMVeqruFGup/m6+lfwQJprH5VJWYGVaaV484rUpfIbR6WUXF
         WaGWIC+iO0HajVDt6bbJHDujVYVPHydk36YpOZu/bc+LN7Rllp6Sw0uia1+ixE/y+l9J
         vHYt1nf4qbF3UtbQcaW23icbT/bE6Ts5jgZVRfjWnd9t92uFnYDviEk0sc3rxhrOch5j
         zrnlFWYnYnXkaE4SbgTVgMBpFxxsOP0WqC3VpKZ7kp+BJsIQsx2Nu1/kFm4AY8qVN3D7
         qTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+3ZamjbwwK/rLdZXffbKuwJ2yFy7jvMdLv24u+z477A=;
        b=TzRXvw4gUfejUoxSBA8WSIhiUyiPEaQkudTtrjWRyG6UXoxoMelmz3SDetUmU9GkQD
         avIEe/auKJIjQc/EcpTF0i0Iq0FbJOr8ye8kXh7gi+e+VV8reK1gp0SN4eJeb5ztRinx
         dUsx+SwC5x9ouq2VbWU1fZie58+/PzrbZdEoSHywA5C+Z6XbhE/+T3JB/6Fqq2a4r08u
         6Yu3K6xdeJd+6WGJqUIiDuVS/jeJadhde7KAGt9T/M0eJ6/iK2v9KQs+HGd2tGjGltwj
         Mz2ehxjtmdQb2nveBFtP82BNdGI9qvO4FM6kuMSSQ8kkVVtg5c7ChEspNhZnMoZ0x5yP
         sWsQ==
X-Gm-Message-State: AGRZ1gK7fLsf404V4vuO9bTNbQXkwp9+FcnPpoUhp0y7bcapbn2hoO/w
        xefe+1XacKyg+48tI82U6qo=
X-Google-Smtp-Source: AJdET5cLWUNl8x8zgsSEAUI0JC+lsmk0+ZJH3BypgQZWIFZZMW45U1dlZpUAYJtaG8FEfjkAbg8IsQ==
X-Received: by 2002:ac8:3a22:: with SMTP id w31mr1408658qte.302.1541616563091;
        Wed, 07 Nov 2018 10:49:23 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id z20-v6sm639980qti.75.2018.11.07.10.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 10:49:22 -0800 (PST)
From:   Giuliano Belinassi <giuliano.belinassi@gmail.com>
X-Google-Original-From: Giuliano Belinassi <giuliano.belinassi@usp.br>
Date:   Wed, 7 Nov 2018 16:49:16 -0200
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        renatogeh@gmail.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 0/3] staging: iio: ad7780: pattern generation and gain update
Message-ID: <cover.1541615978.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches fixes a bug in ad717x chips where the PAT2 bit
was wrongly read as a GAIN bit. It also refactors the pattern_mask
generation with the PAT bits.

Giuliano Belinassi (3):
  staging: iio: ad7780: Add is_ad778x flag chip info
  staging: iio: ad7780: check if ad778x before gain update
  staging: iio: ad7780: generates pattern_mask from PAT bits

 drivers/staging/iio/adc/ad7780.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

-- 
2.19.1

