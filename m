Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30814C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E755922419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="bodb2Kbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E755922419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbeKOCHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:07:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40957 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387814AbeKOCHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:07:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22-v6so2541556pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 08:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kzJ7XC6wtdrDpUUWZKeXw5i7kpwhAlXC/BrXonSslMQ=;
        b=bodb2KbqrSNPMZTFQ1cIqCB1pocQ000yBssTgUUld+aHd5DDtpksnDbCSeQ3NUt2XJ
         ZD4YLoGZfJhSn8DGaCxKhzGc3cJVFNpp7bhzfzyFql+n2d3Xb0uhw1oQQWMOahXFVFtL
         qv3oA1zZvtHy6uum+cwQI6PDope29msMMN6hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kzJ7XC6wtdrDpUUWZKeXw5i7kpwhAlXC/BrXonSslMQ=;
        b=TNimmK4ofAyQCeQknK0y9HFnW3wXYrUor7ljS9Ycw+wuE8nRlCHTIIB7/FB+SxKA8Z
         xR7FORhR68hPCjZyELtOhqZ0DABVyfmd3lDdE4yYH3487wo2ptY+fEq9cMWz8dugA9Ez
         sJ2rCU67Fs+bcbPBChw1h/OHs89Xk4++4PEGZRxUIX7kJ2bD01ZrdXqNGldfzvg7UUtM
         u6o0On/ykdPE4ZPkSJMY/wOJjxlK+6e5u3CIFMMF7EwS/nAZqHhAecTLKc7ih1Xs64Gd
         +bHSRbdIELTpuQLueDzxuDUHuqcURz7NsDEYFjcyRgFmVKsESeEGn1LnwLTf/HUH+11n
         MUbg==
X-Gm-Message-State: AGRZ1gLDI+KoqAUTpheA8Zy1liBjS++c5bHjnn+5AAs/09DwMZSS6Wao
        kMiroZEx0L78y/1Qs5+1+UuNSQ==
X-Google-Smtp-Source: AJdET5cBQTGNChAKvN6+sE3sRq7hspEbYH/BRWWQx02bU7MYpx7drFCKNcTCoVhol101s3LBI+QtUA==
X-Received: by 2002:a17:902:8210:: with SMTP id x16-v6mr2497666pln.129.1542211420218;
        Wed, 14 Nov 2018 08:03:40 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
        by smtp.gmail.com with ESMTPSA id s2-v6sm53449854pfk.133.2018.11.14.08.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:03:39 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH V3 7/7] net: lorawan: List LORAWAN in menuconfig
Date:   Thu, 15 Nov 2018 00:01:28 +0800
Message-Id: <20181114160126.4445-8-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105.101610.1437737564548154497.davem@davemloft.net>
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
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
index 053b36998c18..b12b8bed6abb 100644
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
2.19.1

