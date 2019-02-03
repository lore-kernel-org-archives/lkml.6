Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3ECC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38832082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGo2hz6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfBCObc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:31:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34418 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbfBCOUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id d9so1631017pgl.1;
        Sun, 03 Feb 2019 06:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=966p1MVp6tJaG2Ln1Fe/+HCybTB/+xrkwjt0MUevD9w=;
        b=nGo2hz6PA4GEuAmiS+ynRDI4cjaE52H6dTxwlRuK5yjjUw3+p1G0J4IknK2k5EFjw5
         Sk4jt02ZDkZYhvYyYz+0HhALRSHLMogOKoRc3+95l0z7zOQZDLKZuaM+uXVRZxymM+nj
         l7Wv6z6vPoderYE7serl/B2j1izPRZ4M6uQHAI9ZI3kYdQQX0XuggROKnvphQQqRqWjI
         iRT6xpghKglSAjFIAbEoKsMNfE4cogCdem7b46NoR5QY5BvjqWZP1w2iiwIC17cv5PxP
         thegPP4/qqQ1KXnqig5ZIg6sueo9RTeeq8aXNC9a0BrXVnnh8w9RM8ukbeyGO1FOwznF
         EzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=966p1MVp6tJaG2Ln1Fe/+HCybTB/+xrkwjt0MUevD9w=;
        b=fkxJ1xPmWPlFTTEXZMXDPGQH6eXroxxdzzVQb2+I8YVl9ZI1H8QIv1yGC7RwYTICxC
         6m486E6220YbLix8Uvona8j24SYRonly9lor4/E2pThTf2yWto3OsJwWf3w8uAizRogF
         PftyRWsnJJoeqLn6MOVYPxtoENL9K8USYZ4Yhqn+8C4K14J6wKOZckqi1qGA9iL56X1i
         sWNILkMvHcuIIOSKZpbKCIbhitju+iMsbB7IrszvMbp8jnmeCOgkcb28aotvmbNb6hKC
         VETWlFILkAu8dndV/wFV5HyiVwRkj0B0RuFm87DziICzLYjV7/bUl3BmSsDZbIsP5RMi
         bJog==
X-Gm-Message-State: AJcUukfxrGAly5AhnpIF2O6pP4TqKIMiJx9ldvpQ/7kivV/HgmAJwxxZ
        yvGOTvJ8Or0JepuaZcSNj7FU/dmT
X-Google-Smtp-Source: ALg8bN6jAZ2Kex7oc9SZ8G+klUPY0tWIOcxEwoRYkO3ttoLn7vVsP4C29IXMdYPKOPGsKO2Ds96j1Q==
X-Received: by 2002:a65:5bc4:: with SMTP id o4mr43496289pgr.426.1549203601480;
        Sun, 03 Feb 2019 06:20:01 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id i184sm17961915pfc.41.2019.02.03.06.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 06:20:00 -0800 (PST)
Subject: Re: [PATCH V9 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <41d1a992-5772-b0b0-af97-c995701ee1f3@gmail.com>
Date:   Sun, 3 Feb 2019 17:19:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.02.2019 20:07, Sowjanya Komatineni пишет:
> This patch adds DMA support for Tegra I2C.
> 
> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
> transfer size of the max FIFO depth and DMA mode is used for
> transfer size higher than max FIFO depth to save CPU overhead.
> 
> PIO mode needs full intervention of CPU to fill or empty FIFO's
> and also need to service multiple data requests interrupt for the
> same transaction. This adds delay between data bytes of the same
> transfer when CPU is fully loaded and some slave devices has
> internal timeout for no bus activity and stops transaction to
> avoid bus hang. DMA mode is helpful in such cases.
> 
> DMA mode is also helpful for Large transfers during downloading or
> uploading FW over I2C to some external devices.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---

Good news! I tested patches on T20 and T30, everything works perfect this time. Please address the review comments and prepare the new version.

BTW, I noticed that there are more deferred probes in the KMSG log with this patch. That is unsurprising because Tegra I2C driver is registered from the subsys level and APB DMA driver from the module level, hence I2C device can probe successfully only after the APB DMA.

The small change helps to reduce the amount of deferring during boot, please consider including it into this patch:

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 32d5744bce45..e2049d5b0c00 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1651,19 +1651,7 @@ static struct platform_driver tegra_i2c_driver = {
                .pm    = TEGRA_I2C_PM,
        },
 };
-
-static int __init tegra_i2c_init_driver(void)
-{
-       return platform_driver_register(&tegra_i2c_driver);
-}
-
-static void __exit tegra_i2c_exit_driver(void)
-{
-       platform_driver_unregister(&tegra_i2c_driver);
-}
-
-subsys_initcall(tegra_i2c_init_driver);
-module_exit(tegra_i2c_exit_driver);
+module_platform_driver(tegra_i2c_driver);
 
 MODULE_DESCRIPTION("nVidia Tegra2 I2C Bus Controller driver");
 MODULE_AUTHOR("Colin Cross");
