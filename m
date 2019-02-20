Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D16C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21C320C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7UwG7JX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfBTFrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:47:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45433 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfBTFra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:47:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id v21so8355571pfm.12;
        Tue, 19 Feb 2019 21:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nFOWIgn7JkUI+78AqNNYseRdqciD+uz9YgwkRaKp/1M=;
        b=d7UwG7JXiYoyA5tfWWOr/7GV5e/TitN4G9xwughJin4aI3qm8mg9qKh+sWkGtvqCXs
         TVyYwpa8EDAMpf06EBRFe/4B1l8dvH4HK8LRsV29rX0Wo0jYEfZKGPyyq7IxHi4lvI2x
         pTWE/4yNLRDW1nqL4PT7haE2d+DIW68TJLTi66PuMD3KtQVjsRT1iVEn+rvq/b70wBX5
         ZJf3Mi/XvIKKCt3XOmNSO2XGNg73DLYMaRVpV4ZuTHsZ4AKYDUdPNp2bui3bXHXKyWt7
         PL9sjkT+hu6OmIDCsJ9e/1Hp9uSaIUTEbU+bOvKylvsX4hiBRBqkUXYgCqz0Txd8R1uO
         HMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nFOWIgn7JkUI+78AqNNYseRdqciD+uz9YgwkRaKp/1M=;
        b=sjpd3x39MZg36RJXupbtMh396XlVrHgWMVLk0ToH7ACZ56vmnrFPfFfEGexoqF6reD
         3uxw8dvfKVtG2YD69PrKFOy6onwg879ps+7CoL+XTF7lW8JLvbvc3pjb6hCkjJJ166L9
         EeMP9iayj+9HKlDyGuBuT9nnVfUZsyM8ur1mlyhy1Sbpp7tGitCdVgFivq2qL/bW/RW2
         92zGqNIhkZVDgzeACyfgY6JfQBm/MatS5wfnKrvH5NqbEeC/VhJGKxPxPGox8y6RXjgX
         htqoLJA6IoiftWooHlX2jiHraGHynUKN11dY01kQ0H+bIW62Jryu9T+iNPjSV/bAaPsY
         1OmA==
X-Gm-Message-State: AHQUAuaOU04KftAiSoKHDNoMkjcgI3CID0gYi5TMszgdRM0w3pDV3umn
        YjlsCPQyvDYuDWuDjGPHHZQ5ne5AlTg=
X-Google-Smtp-Source: AHgI3IZNKIW+tfl07K9lullBzchiZ39GJpSrprbgG4z8Nbhn4IiJyMmaW7EERYzj/vre5SOf/9Upxw==
X-Received: by 2002:a62:3a92:: with SMTP id v18mr33482219pfj.43.1550641649506;
        Tue, 19 Feb 2019 21:47:29 -0800 (PST)
Received: from localhost.localdomain (2001-b011-1004-3ad8-944c-6988-1c44-7cab.dynamic-ip6.hinet.net. [2001:b011:1004:3ad8:944c:6988:1c44:7cab])
        by smtp.gmail.com with ESMTPSA id n27sm35494256pfb.8.2019.02.19.21.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 21:47:28 -0800 (PST)
From:   David Chen <david0813@gmail.com>
To:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, hayeswang@realtek.com,
        mario.limonciello@dell.com, bigeasy@linutronix.de,
        edumazet@google.com, jslaby@suse.cz, f.fainelli@gmail.com,
        david.chen7@dell.com, kai.heng.feng@canonical.com,
        zhongjiang@huawei.com
Subject: [PATCH] r8152: Fix an error on RTL8153-BD MAC Address Passthrough support
Date:   Wed, 20 Feb 2019 13:47:19 +0800
Message-Id: <20190220054719.7280-1-david0813@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Chen <david.chen7@dell.com>

RTL8153-BD is used in Dell DA300 type-C dongle.
Added RTL8153-BD support to activate MAC address pass through on DA300.
Apply correction on previously submitted patch in net.git tree.

Signed-off-by: David Chen <david.chen7@dell.com>
---
 drivers/net/usb/r8152.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index ada6baf8847a..86c8c64fbb0f 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1179,7 +1179,7 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
 	} else {
 		/* test for RTL8153-BND and RTL8153-BD */
 		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_1);
-		if ((ocp_data & BND_MASK) == 0 && (ocp_data & BD_MASK)) {
+		if ((ocp_data & BND_MASK) == 0 && (ocp_data & BD_MASK) == 0) {
 			netif_dbg(tp, probe, tp->netdev,
 				  "Invalid variant for MAC pass through\n");
 			return -ENODEV;
-- 
2.19.1

