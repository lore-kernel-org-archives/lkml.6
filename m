Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DDCC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984FB2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMNhHGfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984FB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeIYC7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:59:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36155 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbeIYC7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:59:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id b7-v6so2207179pfo.3;
        Mon, 24 Sep 2018 13:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7EjcO8AOqi6wmrlm1Wfclavax7VPrDQSsrxmfbBlQM4=;
        b=BMNhHGfjyMpfPnVB4NPMxPMfq8GyUSyf7K9S2IVIfJWHKkLDfT6/3g8/It8txQHNqH
         gaMlzShryDVNtVZolNa3ba4Xk+pAJxWcrGM8/MiRk+bqkmFJM5ONnX6O560lIJ+zeo4A
         4iVLEJIm7AsAZrZEym1PgE8AmNIEkyrDi78VHBq3U9Y2cRwCwBuJv1yaP9Up1/talU4z
         uOUN1ZYpxv+FtGtYjffdBTJg6UP3wp9wXwlx4baF0ltD3ySXJ1Ai0kiC6HUXIW19PjvQ
         aEThn6BaCRu6URkejr4K733GkD18DFODNWdonbXBB21135Cy0D+L+mMIxw3oaXwAKlhH
         FAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7EjcO8AOqi6wmrlm1Wfclavax7VPrDQSsrxmfbBlQM4=;
        b=oXntBmuVfCyzqS8wTK2y3UgSG/t65t61J6szr2lvHRHnUS28oQiK9ZY+Dd/OXuUaSL
         PdOfq+2KEFFE/W6UZEPKnrzK97OvDR4tbo3sjkoME31nftBjVSx0vUAK60TbLvgU4XpT
         Dw3TrJdAERkR/tH/EU9i3ZVr9lpF1DeOLJReSeuYLSgZdQ9H0YZw844tY9PD9Qn9jVCG
         +nhER3jKMWXC7NPjEHhElTSQ/PfbwS/Sf0NbuQhGi4RRDFjJZNYSVWptZIqK6o/POt8G
         GdRK0OvdQMfxFhUbfnO+FCp/AluR/CIbiiumMcXEZ4FyytJLjM5ZJq287P5wwjNaZU2p
         oLXw==
X-Gm-Message-State: ABuFfogHzr9DVn3VJMefhKojSymx/8T0KH7H//nHo530XJZqKmYqDob3
        Pdtl/eXLmbcNzJV1mq61EA6ODL+k
X-Google-Smtp-Source: ACcGV62fD592iKwpKQILluMfsD84ON8edF1sn5LMDlHekRMme+Vqj1WCJCbzveo7HxJgidAVWp9xNg==
X-Received: by 2002:a62:9586:: with SMTP id c6-v6mr481404pfk.234.1537822531245;
        Mon, 24 Sep 2018 13:55:31 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b62-v6sm260160pfm.183.2018.09.24.13.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:55:30 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Kees Cook <keescook@chromium.org>,
        Alexander Kurz <akurz@blala.de>,
        Hayes Wang <hayeswang@realtek.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Grant Grundler <grundler@chromium.org>,
        zhong jiang <zhongjiang@huawei.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ran Wang <ran.wang_1@nxp.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 7/7] smsc95xx: Check for Wake-on-LAN modes
Date:   Mon, 24 Sep 2018 13:54:20 -0700
Message-Id: <20180924205420.31309-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924205420.31309-1-f.fainelli@gmail.com>
References: <20180924205420.31309-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not check for Wake-on-LAN modes specified by an user,
but will conditionally set the device as wake-up enabled or not based on
that, which could be a very confusing user experience.

Fixes: e0e474a83c18 ("smsc95xx: add wol magic packet support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/usb/smsc95xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 06b4d290784d..262e7a3c23cb 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -774,6 +774,9 @@ static int smsc95xx_ethtool_set_wol(struct net_device *net,
 	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
 	int ret;
 
+	if (wolinfo->wolopts & ~SUPPORTED_WAKE)
+		return -EINVAL;
+
 	pdata->wolopts = wolinfo->wolopts & SUPPORTED_WAKE;
 
 	ret = device_set_wakeup_enable(&dev->udev->dev, pdata->wolopts);
-- 
2.17.1

