Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E3BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B967B2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUpTuqTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B967B2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJCUku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:40:50 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:46622 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbeJCUkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:40:49 -0400
Received: by mail-pl1-f175.google.com with SMTP id v5-v6so3517924plz.13;
        Wed, 03 Oct 2018 06:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=xf1diMsDU7S5RDV2E4iPoPvrscEAvyH+XqECqIiN0KE=;
        b=NUpTuqTc9rAn3OMYgX/EB290/NXeZyxVZFu69OLmVmLj20VARZXtPotcFnevpfJRQr
         4GHJw5YcL/2KQuCSTKV/RRT2Y7dZv0m4QXVgSU9F705YGDfFqw8OaxMdiqUwwoouWYzI
         6DylNRhYRq2VBQ1Ko8mYJoC995+gLnxg/U1Z0Nh5mUD6wlvURe5Q0wDE+BT2TypzeLig
         r6drEvEi4hvYN9BpkRmcHdnL6ShEI7Jwpg7E7qv+nlVFywKfS/Ch6ermFToVDDHMPbAq
         LhifSvrpivmO+E1CyaJXFujR0iBcu0KGM7MxmwcmPlXBNKqxCNKBS0i9Gmc5XbWeYo/n
         LDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=xf1diMsDU7S5RDV2E4iPoPvrscEAvyH+XqECqIiN0KE=;
        b=WZoZs1bIKPPrmgOJa0LGgxy6jamlh4SK17L2xIjqyvkRtcxCHAI8j5IMJRrCOlNrrv
         fq1wbyhJYHwBcmoZ5YHPDt9/1hm1yeq4ORCGReBl+8kY2hcq5xMmSqNu488IOeRCgIrC
         gtnIPdmdhsNJwghEkMQ3QsyxGTkI9F/qQsMxyOQy0w/xdxDMqEFpVtGaP6IGKgLLWINz
         1r0j8FJgKmLZzB313HnZlwcfSZikNmcGIHVvTTkae8lniD5iXDcUzP/TdvDzETWVjoDT
         mWXgHRkpLpxzouDttW7DCRKQxKpXBAtfwTkcO+HXnM+V6N8swwT7ig2JTijVmLwxsmSI
         fihA==
X-Gm-Message-State: ABuFfogvaZjjNIDRCXbS2f7XREQkxqncvDyUEB+eQEjGdmr62fUnmeLh
        jjN6twxRPepRYlUs/rM7cZm2ghyl
X-Google-Smtp-Source: ACcGV61csnOpUCL7MaNKNca3yuTo1BBulWJZ3VqyK++ToKRAFexczcSI3slJk05FHe1g+wocTI/dxQ==
X-Received: by 2002:a17:902:bd4b:: with SMTP id b11-v6mr1818445plx.0.1538574739482;
        Wed, 03 Oct 2018 06:52:19 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.3? ([2402:f000:1:1501:200:5efe:a66f:4703])
        by smtp.gmail.com with ESMTPSA id h130-v6sm2350103pgc.88.2018.10.03.06.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 06:52:18 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [REPORT] net: 3com: 3c59x: Possible data races
To:     klassert@kernel.org, davem@davemloft.net, anna-maria@linutronix.de,
        bigeasy@linutronix.de, nhorman@tuxdriver.com, keescook@chromium.org
Cc:     netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <412162cd-8fab-104b-ce73-6f70f108218f@gmail.com>
Date:   Wed, 3 Oct 2018 21:52:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

****** Possible race0 ******
CPU0:
vortex_boomerang_interrupt
     line 2510: spin_lock_irqsave()
     _boomerang_interrupt
         line 2432: vp->tx_skbuff[entry] [READ]
         line 2433: vp->tx_skbuff[entry] [READ]
         line 2453: vp->tx_skbuff[entry] = NULL [WRITE]

CPU1:
boomerang_start_xmit
     line 2145: vp->tx_skbuff[entry] = skb [WRITE]

As for vp->tx_skbuff[entry], the WRITE and READ operations in CPU0
are performed with holding a spinlock, but the WRITE operation in CPU1
is performed without holding this spinlock, so there may exist data races.

****** Possible race1 ******
CPU0:
vortex_boomerang_interrupt
     line 2510: spin_lock_irqsave()
     _boomerang_interrupt
         line 2421: vp->dirty_tx = dirty_tx [WRITE]

CPU1:
boomerang_start_xmit
     line 2137: vp->dirty_tx [READ]

As for vp->dirty_tx, the WRITE operation in CPU0 is performed
with holding a spinlock, but the READ operation in CPU1 is performed
without holding this spinlock, so there may exist a data race.

****** Possible race2 ******
CPU0:
vortex_boomerang_interrupt
     line 2510: spin_lock_irqsave()
     _boomerang_interrupt
         line 2381: vp->handling_irq = 1 [WRITE]
         line 2498: vp->handling_irq = 0 [WRITE]

CPU1:
boomerang_start_xmit
     line 2134: vp->handling_irq [READ]

As for vp->handling_irq, the WRITE operations in CPU0 are performed
with holding a spinlock, but the READ operation in CPU1 is performed
without holding this spinlock, so there may exist data races.

****** Possible race3 ******
CPU0:
vortex_boomerang_interrupt
     line 2510: spin_lock_irqsave()
     _boomerang_interrupt
         boomerang_rx
             line 2669: skb->ip_summed = ... [WRITE]

CPU1:
boomerang_start_xmit
     line 2149: skb->ip_summed [READ]

As for skb->ip_summed, the WRITE operation in CPU0 is performed
with holding a spinlock, but the READ operation in CPU1 is performed
without holding this spinlock, so there may exist data races.


These possible races are detected by a runtime testing.
A possible fix of these races is protecting the code in 
boomerang_start_xmit()
using the spinlock in vortex_boomerang_interrupt().
But I am not sure whether this fix is correct, so I only report these races.


Best wishes,
Jia-Ju Bai
