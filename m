Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984B6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508B92147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="jm/Kj8pL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508B92147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeHWUuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:50:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44378 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeHWUuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:50:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so3099643pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qM4bfQI8FDxafRkVjuVvbtoBuUYvtbCyI38hFWp0XFo=;
        b=jm/Kj8pL3nY6pz4lezeQa+9HEpgZz6sqq0ZEr3iZkJwCSKuNdoA1PDrTcp3JJa60qT
         gKyCEiY0OazaZI3D2lJcYodhvwByDWjgvdO21swbO0D8NgEVEoZXktZfmsUnaIXjieS9
         LqPmeOCzETZOyTt7GHMmbRT+fN6rttnF+ZdcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qM4bfQI8FDxafRkVjuVvbtoBuUYvtbCyI38hFWp0XFo=;
        b=MN+4fqpJuprTUrRhVBDDIsYFF0mfdg/Eqnhn7Vm8RrhB+LmEsOY6/IMHEOcrBWuF35
         5+vSZfMLfplyE1DsJ3tkTNJuCs2vyMPPm0eFxLJ595Fjgt5OkVkAW+ee+w+ydUHNYZfM
         ev7WsfryYt9nFg38zpyQQWW9r+2WMsetzCwTpLUcSddQzQGkPij6/hsM/tSD3lkYvDt9
         awMKfE0+xI9enN3/Dry1DYTsXOwmIervfAF9WJ9IJLVWGIjtidg+dtvfifyvCHTWhoM1
         6LrI3eQwkKGDtgppHTw3WOo1hdo/KCkxukh0wZTrP+OS3sVYiRxlwVyIH4tB50wTaGar
         emrw==
X-Gm-Message-State: AOUpUlFy5IcItQrKAR9CyjgFeGruDA1Pi0z8Dff4N307lyAkpRitZDg0
        GZoEPtBtp9y0NHNVa9n1Q1B5AA==
X-Google-Smtp-Source: AA+uWPzQanu9q6tYzJcKg07pMRNdu9dBcOOYq9f1jEmyaFeT7KjwRkDVntwve9CjpYxZtV7TzwuyiQ==
X-Received: by 2002:a17:902:9f86:: with SMTP id g6-v6mr27431746plq.304.1535044771794;
        Thu, 23 Aug 2018 10:19:31 -0700 (PDT)
Received: from starnight.local ([150.116.244.148])
        by smtp.gmail.com with ESMTPSA id n9-v6sm7483404pfg.21.2018.08.23.10.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 10:19:31 -0700 (PDT)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?q?Michael=20R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?q?Konstantin=20B=C3=B6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        "contact@snootlab.com" <contact@snootlab.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        Alexander Graf <agraf@suse.de>,
        =?UTF-8?q?Michal=20Kube=C4=8Dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Pieter ROBYNS <pieter.robyns@uhasselt.be>,
        Hasnain Virk <Hasnain.Virk@arm.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Daniele Comel <dcomel@mipot.com>, shess@hessware.de,
        Xue Liu <liuxuenetmail@gmail.com>
Cc:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [RFC 3/3 net] lorawan: List LORAWAN in menuconfig
Date:   Fri, 24 Aug 2018 01:15:43 +0800
Message-Id: <cd021897a590ee57605a497b23e7ea9341889aef.1535039998.git.starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1535039998.git.starnight@g.ncu.edu.tw>
References: <cover.1535039998.git.starnight@g.ncu.edu.tw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List LORAWAN in menuconfig and enable it to be built.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
 net/Kconfig  | 1 +
 net/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/Kconfig b/net/Kconfig
index 053b36998c18..499c931ba0fa 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -224,6 +224,7 @@ source "net/6lowpan/Kconfig"
 source "net/ieee802154/Kconfig"
 source "net/mac802154/Kconfig"
 source "net/lora/Kconfig"
+source "net/maclorawan/Kconfig"
 source "net/sched/Kconfig"
 source "net/dcb/Kconfig"
 source "net/dns_resolver/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index e80b84313851..5341d0e23586 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_6LOWPAN)		+= 6lowpan/
 obj-$(CONFIG_IEEE802154)	+= ieee802154/
 obj-$(CONFIG_MAC802154)		+= mac802154/
 obj-$(CONFIG_LORA)		+= lora/
+obj-$(CONFIG_LORAWAN)		+= maclorawan/
 
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_SYSCTL)		+= sysctl_net.o
-- 
2.18.0

