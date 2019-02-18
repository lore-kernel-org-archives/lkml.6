Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689FBC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2BC21916
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLmUlr+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390802AbfBROHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:07:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43218 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390775AbfBROHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:07:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so8531064pgk.10;
        Mon, 18 Feb 2019 06:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PisuCsbsZQqZsteqlrj+Hrg8SVtmV9wCxHlGU46TSE=;
        b=TLmUlr+mKExBYEQR3ZxR27nhgi8iRMp9QXmvgL2OrsEO6paZYto5fqT8FVJq9bmHxB
         3ZuAydFrpMaQuH+cxQaKOUhwCCbwXdJsT8ZpbAx9Rl4uP0QAbehYf86N2Qo6j68PZdNT
         5KicE743DwrABYYeXg97VaZqxKIVpgVyi8V98eRHmhFkAKYpQXI+mImnKCgNHVORLw/d
         GBYhvy5GSmVX6xONp+x3flSgQ56q0Hb496IgAeGVF5XEx7vgUjydW3TTIofvgwh/BFJ4
         HUA+XHitdv276EGM3ujDPRJppdTO4QvRpghA+/5ZuV1G9AG0uZ6JOZbTOk3P8zypqSsw
         esYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PisuCsbsZQqZsteqlrj+Hrg8SVtmV9wCxHlGU46TSE=;
        b=Dja6QA9URQzCd8OuO1hC5C0kbtT+qd1T+R+DEOdGLBl5xvk52pFTXIL3ayZWk9U5HY
         u7GYTtaC+oHs+aQymD9j+cGns/2p0CT1I6VA+WyPBP4jmdc7vVS/XB89GBkVg4zZaM9p
         n0G0gzReDL6aDTN8RZ/3Lv0B8/AUAf0D2JQp4TzTcucUl89dsgKCwbKh+98woYf8T5r1
         eqSOyotLmsN1AgLra9mv4re8EzrN+ImzNSVYZsCO7UQoauxP7t8z0w6yoSnIViGtp/zb
         SakMOG3N6VXWmiDFQaTLkjNbrRgu0PB4YBrVf84qShpvFLruJvFMeHL/r/veljFyEHRk
         y3Zw==
X-Gm-Message-State: AHQUAuZjetvMRjewy2Z8bSfUEuUb9brRdc/McjFssXo2yYr+AfYeH50H
        XTyY5mNA3m7d7m3dDHuqRcwIrnSQDTc=
X-Google-Smtp-Source: AHgI3IYEE1qQwAZY5ACvRlCg179LacNY1UWosAQY2uE67PvFKIdg7JoNxfWIS3rzi/yZHxdWgtqodQ==
X-Received: by 2002:a62:6f49:: with SMTP id k70mr24164522pfc.7.1550498864435;
        Mon, 18 Feb 2019 06:07:44 -0800 (PST)
Received: from localhost.localdomain (2001-b011-1004-3ad8-7167-dbfd-33d1-77de.dynamic-ip6.hinet.net. [2001:b011:1004:3ad8:7167:dbfd:33d1:77de])
        by smtp.gmail.com with ESMTPSA id y6sm23118671pfd.104.2019.02.18.06.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 06:07:43 -0800 (PST)
From:   David Chen <david0813@gmail.com>
To:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, hayeswang@realtek.com,
        mario.limonciello@dell.com, bigeasy@linutronix.de,
        edumazet@google.com, jslaby@suse.cz, f.fainelli@gmail.com,
        david.chen7@dell.com, kai.heng.feng@canonical.com,
        zhongjiang@huawei.com
Subject: [PATCH] [V2]r8152: Add support for MAC address pass through on RTL8153-BD
Date:   Mon, 18 Feb 2019 22:00:57 +0800
Message-Id: <20190218140057.17030-1-david0813@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Chen <david.chen7@dell.com>

RTL8153-BD is used in Dell DA300 type-C dongle.
It should be added to the whitelist of devices to activate MAC address
pass through.

Per confirming with Realtek all devices containing RTL8153-BD should
activate MAC pass through and there won't use pass through bit on efuse
like in RTL8153-AD.

Signed-off-by: David Chen <david.chen7@dell.com>
---
 drivers/net/usb/r8152.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 60dd1ec1665f..86c8c64fbb0f 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -557,6 +557,7 @@ enum spd_duplex {
 /* MAC PASSTHRU */
 #define AD_MASK			0xfee0
 #define BND_MASK		0x0004
+#define BD_MASK			0x0001
 #define EFUSE			0xcfdb
 #define PASS_THRU_MASK		0x1
 
@@ -1176,9 +1177,9 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
 			return -ENODEV;
 		}
 	} else {
-		/* test for RTL8153-BND */
+		/* test for RTL8153-BND and RTL8153-BD */
 		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_1);
-		if ((ocp_data & BND_MASK) == 0) {
+		if ((ocp_data & BND_MASK) == 0 && (ocp_data & BD_MASK) == 0) {
 			netif_dbg(tp, probe, tp->netdev,
 				  "Invalid variant for MAC pass through\n");
 			return -ENODEV;
-- 
2.19.1

