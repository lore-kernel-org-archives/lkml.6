Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC54C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB7921501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIeyQTFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB7921501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387482AbeHBOwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:52:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45415 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbeHBOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:52:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16-v6so906410edq.12;
        Thu, 02 Aug 2018 06:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgF9JAIBDi6u6MOBEHQHr5JIXJo5NdSPo0fX4sx0fyA=;
        b=KIeyQTFktuS3ZFSQ7dn7fZ7nI9Bx4EQBfV0YSKp4ue2oimVRNtR7g1BO4IXxJzFTK/
         3L1nCwklaMoxztC75jZxMurQ/MJqETPAhIkIPJRNL17WilPgeWA7sazAMXe5d88cRuYU
         Dul+9sgjGv75bp0wjILcEIO8Qauk/Wm+7k2Ifm5x/gakOvvIFnhDmENZdvlQrz/KwdpC
         uXEBegbb1PptFZmhBVme8cdM454q2k6Fl3ARlG8gHWk6/2o/WCYXvl/aezBy7Mumv0J5
         xug0ebxVjKNfAco4+1vUciotAjVm5Y/wW8LgJsQi5ACZyU2fyGQXXIVHI30haLYLoTR9
         3tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgF9JAIBDi6u6MOBEHQHr5JIXJo5NdSPo0fX4sx0fyA=;
        b=o+4iJjvlRgN4649Tqk9b3oI05XTTRMlHWKDtZKhDypsQ2ZdvodKl29AsxGIi+okXwG
         CZ70zGuF2m3LuGhXNnpYwlFWRkA+GZgHcIpdzWYTdhEY5DzIYfTv8Qm4+pYAUdd1kdB7
         nLNcPeRT0TVqS4NxTdhntxSMqig4N+4vueKmMGx6hAN74dHkFT0vX1pJj1QETE3wj9Cx
         dkBpjXd4lklV5Ymglvqo0/sFdlYuFitxEs2ZHacaDoCZXtEAYP9NfJsS5j/KMVqbQ02r
         CVEx1/gzN62+BDx5g3YeCaHmn7Lsj78AXOsNAmQLp8lVSKaygLltuoiTCosKU+jG61pt
         3MlA==
X-Gm-Message-State: AOUpUlG6NK5pkI13lJlO0wNWNgJmtySmpoNQadv/gJxAKuqZPaGpX9eT
        kFl8AI/85uT1mJV7k0akKD8=
X-Google-Smtp-Source: AAOMgpdJiFTeZGRUqCu5SOc0o1xe60Zal4yGp+fu9FRbEumw2TYZFSVQCsCfnMXl97H41JTPuJWgsQ==
X-Received: by 2002:a50:8b88:: with SMTP id m8-v6mr3262989edm.165.1533214887553;
        Thu, 02 Aug 2018 06:01:27 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id b41-v6sm1236098eda.38.2018.08.02.06.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 06:01:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] pinctrl: tegra: Move drivers registration to arch_init level
Date:   Thu, 02 Aug 2018 16:01:24 +0300
Message-ID: <4576764.PLucfz68jK@dimapc>
In-Reply-To: <20180802111144.12512-1-digetx@gmail.com>
References: <20180802111144.12512-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 2 August 2018 14:11:43 MSK Dmitry Osipenko wrote:
> There is a bug in regards to deferred probing within the drivers core
> that causes GPIO-driver to suspend after its users. The bug appears if

I meant "before its users", of course. If the rest of the patches is fine, 
please let me know if re-sending is needed or you'll correct the comment in 
place while applying.

> GPIO-driver probe is getting deferred, which happens after introducing
> dependency on PINCTRL-driver for the GPIO-driver by defining "gpio-ranges"
> property in device-tree. The bug in the drivers core is old (more than 4
> years now) and is well known, unfortunately there is no easy fix for it.
> The good news is that we can workaround the deferred probe issue by
> changing GPIO / PINCTRL drivers registration order and hence by moving
> PINCTRL driver registration to the arch_init level and GPIO to the
> subsys_init.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>


