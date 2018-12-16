Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C3EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630D6217FB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="db+8z3LR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbeLPKUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 05:20:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46283 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbeLPKUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 05:20:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so4706866pgp.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 02:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82RhJXIBdJ7MYvT5pjrgXE/E0NBcF8SsKLl+aim65ww=;
        b=db+8z3LRHTPiga9TfEaCCMR8RAMeLwGuz0obEwYlcHh8VTnhKB4h0jTM4afUHvc1nQ
         d8AVVQY2LtaNtcrOOp1KxQO9mbRfIKTcQT48fYiQ5nINDFZZ7GHpjcReS7yIU8og/lEQ
         OXVCW1jxhi5Gsq+UCubM7xfwLk9RDbF6amPFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82RhJXIBdJ7MYvT5pjrgXE/E0NBcF8SsKLl+aim65ww=;
        b=gmYvH5ANiCssqzIZ7ZFeJCs6R+zgYOBXoKpU99Q+LMgWPOV3lKlnPfpVrBB+sasu5G
         NQXUbwb+fGuIQv9XBCZd0oROB+Ij/nJx5Y8bBH3dvhZhT/1xII2H+24GtWDowPRHEl+B
         qXfcoXoAD8r+Rq+z500H6MtvgQT0BVf3zwaOo8sh0AxqN8Ojn2PWOJJRus2dqeVEx0Ow
         XfyTl7GxWAzNZtGOClNaVgugpx3QjEYRbGijKfihlr2EsjtH3qNhr31b/iEvO/j5V+5u
         6A5Mk+Pe/bM4Ow/Y+mj2kZFdmnYDWYm0hUpellcgkq7pNHYeDKLFsH/6PtRCxQzuX7GW
         Mp5Q==
X-Gm-Message-State: AA+aEWYfepo6zM+EKFkEn61yxf3LqlcITYBU8peLmWwD7v4wCqkGpEN0
        1JMuW+O3FVy+BolIWI08N28hGg==
X-Google-Smtp-Source: AFSGD/XhDM30aVy8KhOZVy4E0arItRb1YnjuXAujc4CWq1ao4W0HxkH/CR9Q88W2WXLTCzwwu4v1UQ==
X-Received: by 2002:a63:1204:: with SMTP id h4mr8605799pgl.51.1544955616208;
        Sun, 16 Dec 2018 02:20:16 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
        by smtp.gmail.com with ESMTPSA id d21sm14964454pgv.37.2018.12.16.02.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 02:20:15 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
Date:   Sun, 16 Dec 2018 18:19:00 +0800
Message-Id: <20181216101858.9585-7-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List LORAWAN and MACLORAWAN in menuconfig and make they can be built.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
V2:
- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
  LoRaWAN Soft MAC modules

 net/Kconfig  | 2 ++
 net/Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/Kconfig b/net/Kconfig
index cf2e651ee31d..03b3ff306778 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -224,6 +224,8 @@ source "net/6lowpan/Kconfig"
 source "net/ieee802154/Kconfig"
 source "net/mac802154/Kconfig"
 source "net/lora/Kconfig"
+source "net/lorawan/Kconfig"
+source "net/maclorawan/Kconfig"
 source "net/sched/Kconfig"
 source "net/dcb/Kconfig"
 source "net/dns_resolver/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index e80b84313851..9d5515965a8f 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -63,6 +63,8 @@ obj-$(CONFIG_6LOWPAN)		+= 6lowpan/
 obj-$(CONFIG_IEEE802154)	+= ieee802154/
 obj-$(CONFIG_MAC802154)		+= mac802154/
 obj-$(CONFIG_LORA)		+= lora/
+obj-$(CONFIG_LORAWAN)		+= lorawan/
+obj-$(CONFIG_MACLORAWAN)	+= maclorawan/
 
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_SYSCTL)		+= sysctl_net.o
-- 
2.20.0

