Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B963FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB1D2082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="bYQ9gw32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB1D2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeLDOQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:16:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40114 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeLDOPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:15:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so8365066plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 06:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HzGxbD6sosRISQ+eh8syC+Tz0nZncrfSJXVFQ0T2nG8=;
        b=bYQ9gw32+zrc0bROpFbTjCjXOCC/NIP9j1GxOR+TY5jeqopAsek1xWhCGqmjtzIwmX
         6jr2GG5TpkWwVSfGuHz2ewCuIsB0LMdCSbY3r7+RkmW8BhxnAbcV3RcTzoUSM2Ws8azp
         qeAHM0QSZS2IBk32Bp1C8MGBkTrSqrUhkVmzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HzGxbD6sosRISQ+eh8syC+Tz0nZncrfSJXVFQ0T2nG8=;
        b=Dr/UK1JFXP4p9VFz4ezW/MVxnbnlAVwbbJwFqw2pSmns+GSn/BEWNkvBqSqB6SAJBo
         Xqn84Mi/yCUqof8iQfOMFRJnUSGwdU9BQm9GmzLJl76+AcUhvckIgb6PjBXidP8ymuCh
         qmiu4/1p8pq7aumhGWcTX0JyM4EOnVZXrCz8wDR69dAk0g47btga3F8KssNerVuEapUY
         FbTwogTos2KlCDx/OTnaHsOVXCJT1lgaPEh+vMrH8QDfQzW5zXR49EdMM6s3tko1GrE2
         ztQSL/9iX8hKizYnc9yb4GmVkSbxTt7gSmZIhWoTa5rMhJ9jOiWqsY8iKbcnahhhr5/z
         mkSg==
X-Gm-Message-State: AA+aEWa3LP+lq7hskFtVXKjLoKLsca94PA6EfOOA+5A+pPMgqB6QNz6a
        pk2KUm8JoY1KMCpeNw1TJ2uMng==
X-Google-Smtp-Source: AFSGD/XOHMF1t5neI3N7YV/WT7PHO2q3ESDR4HSoqspPkTaIuLFH5c1PesUQf4GIlp4lmKY98PB49w==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr20356290plo.257.1543932946091;
        Tue, 04 Dec 2018 06:15:46 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
        by smtp.gmail.com with ESMTPSA id n66sm36975863pfk.19.2018.12.04.06.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 06:15:45 -0800 (PST)
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
Subject: [PATCH V4 6/6] net: lorawan: List LORAWAN in menuconfig
Date:   Tue,  4 Dec 2018 22:13:43 +0800
Message-Id: <20181204141341.4353-7-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
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
2.19.2

