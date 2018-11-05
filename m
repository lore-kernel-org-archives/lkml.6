Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93ACC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8DA20866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="JYEIx2Q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8DA20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbeKFCS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:18:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41052 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387921AbeKFCS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:18:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id p16-v6so4737867plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mSxcJ+NqUwwsDva2pIi4AZ2HPVWuV9mkjnC/RXmq2wk=;
        b=JYEIx2Q7cXi2hk0D/Ee6F/5wwEzR94WovjwJaIwXSIlY57n1HcB8qp8WmyKRF4KmPZ
         JZGWaJrIzkc3qmAc9Qx2HoF8ewtf0gkLH/A5qBjs/8TFwA0gR/kdzl2po8vLba6PR03t
         G8m95rCtmrz8/rhpI3bCqTHCWheOyNbFlHOeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSxcJ+NqUwwsDva2pIi4AZ2HPVWuV9mkjnC/RXmq2wk=;
        b=d2X/rNInV5UxvwTJRXvGXkNsYyJIFZ9vMDc45sIK6nSsbT+mILDt7AVmdOP5ABPFi1
         p/O6X4Qym22JzjdJoq37NlVysFY0R4oSzGiM18XOaGL5bCwBzhPprb8MZIj5RZt4FpKR
         QPH+wEoO6k5kq5vkpXkPc2KdjjtiHkxsHeBdBcnPQp3l288irdIsEuRb5Z2gIg0McNuf
         4AH9oTdpY7VQCVgY/B528ptZb5Dn4TrbLeZcGZ8wM8zVJVejX0xyvicmEXZUn/p11Fw8
         twJVEShL69mYxHg62jHvbnoA3c39U7zQRdX26z3HD8GC+U5IO+T0NV2uzwm5GtpamDXR
         0HKg==
X-Gm-Message-State: AGRZ1gLPFtHCq1qb8eShEbBhf0HLCTvXjWQ3rrNZm+quM7mGdvY63H1S
        1xrsuzN2wLWjrMupFkWcAtMnvw==
X-Google-Smtp-Source: AJdET5dzRpilVyXatJ8OXLK+w7bWGn37bT6HDjck+62jGvSCQMz4pJZ+eSimiAkTuDfJKWgAbIYjSw==
X-Received: by 2002:a17:902:a418:: with SMTP id p24-v6mr22029953plq.29.1541437072012;
        Mon, 05 Nov 2018 08:57:52 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
        by smtp.gmail.com with ESMTPSA id l16-v6sm58445129pfj.179.2018.11.05.08.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 08:57:51 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH V2 7/7] net: lorawan: List LORAWAN in menuconfig
Date:   Tue,  6 Nov 2018 00:55:45 +0800
Message-Id: <20181105165544.5215-8-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
References: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List LORAWAN and MACLORAWAN in menuconfig and enable them to be built.

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

