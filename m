Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D27C46470
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B6C22429
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B6C22429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeHKDwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 23:52:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46050 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeHKDwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 23:52:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so5108706pgq.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 18:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D63r0xiGiaiLw2jT3WA/5l6edqPcX4ejpQkanUWiva4=;
        b=ujKmc0CjknfpVmc1ANiAdHKh70VBfhvsTBKhITzQM5j0AL05uxUOecfDY4A8W2t62e
         mM/D5JfkhD9YkiS91G9UfHvvPfjy+Za/leBjLB0+c0lrZCGzNz/HzN55jSagGPn5GOtI
         X+ODhM4GYyB9CiaEuuZzSfOKmVBVGAx3OwUaBr5qDX0oTHZLwNaSkA24O3NLJVZAXU7M
         ddtJxCkG0nfJVDDHqFiIdHR5R74cqnuZrzkp4KXDUpqqK4w5PJ7RtbyO7Q94GVGaJule
         9eQtZ0obFl5nQ71ifDtNIL8P/A19TqPFpncI5lBjq9J/SzoL/kWaz/S2DTEjZJA/re9K
         1Sxg==
X-Gm-Message-State: AOUpUlG3dFsY5ipOe8+xoyz6DXFAtCOw6NAOqHZof6TnB4V3PJlGE4xT
        FQhCDCmZUvPoiyTFImzvJJOFmprOzus=
X-Google-Smtp-Source: AA+uWPyEoBToYUoPBOlVdLzRwZSEurqoCenS5Xloxa32wQjh+4SXSDD5tu3rsIuu7+613l/Qs4eZIg==
X-Received: by 2002:a62:5984:: with SMTP id k4-v6mr9272709pfj.116.1533950399675;
        Fri, 10 Aug 2018 18:19:59 -0700 (PDT)
Received: from localhost (c-107-3-165-230.hsd1.ca.comcast.net. [107.3.165.230])
        by smtp.gmail.com with ESMTPSA id f6-v6sm21071384pgf.52.2018.08.10.18.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 18:19:59 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     davem@davemloft.net
Cc:     keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williams@ni.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 2/2] net: nixge: Don't store skb in app4 field of descriptor
Date:   Fri, 10 Aug 2018 18:19:41 -0700
Message-Id: <20180811011941.6187-3-mdf@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180811011941.6187-1-mdf@kernel.org>
References: <20180811011941.6187-1-mdf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't store skb in app4 field of descriptor since it is
not being used anywhere (including hardware).

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/net/ethernet/ni/nixge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index ac31b0d30415..76efed058f33 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -503,7 +503,6 @@ static int nixge_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	tx_skb->skb = skb;
 
 	cur_p->cntrl |= XAXIDMA_BD_CTRL_TXEOF_MASK;
-	cur_p->app4 = (unsigned long)skb;
 
 	tail_p = priv->tx_bd_p + sizeof(*priv->tx_bd_v) * priv->tx_bd_tail;
 	/* Start the transfer */
-- 
2.18.0

