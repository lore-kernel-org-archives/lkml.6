Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C34C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04C920834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZXvRdEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04C920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeK2QXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 11:23:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45333 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeK2QXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 11:23:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id v6so488482wrr.12;
        Wed, 28 Nov 2018 21:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ZdpE7dkW/esKVLRUSp7JVB/TU1KEaTJ5l3wXcbA+go=;
        b=kZXvRdEwUVrw2BRr1J7hoebammNHZzLDkraAFAAdGvjN8JSe8BPRFjlr1pEBdf528r
         2jSdV6Thn2PxYmV9fm9Xs3EcGIOHirdBe5LPCQeETIdOGUlzL6x3ywaXdiHVqoD7srej
         QVYKqSV7M9cB56nmPB3zSIa/hF9RHG5q5MxyxVsgPg6Ff6E4getucwrjK+EcIY71Owat
         RGTOLdyPJ2Ncumtq5/DVfzGe9idOPprSQfz1oMgQrgKZPC72oga6DJNWT3ihFxAped3A
         bhboBxOFrDw8S03rHpdfoDNDvq0VgyKtq1YCrbTGvVsSRh83LRP6gT8Nl3ZxvSZ2Fp6k
         G66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ZdpE7dkW/esKVLRUSp7JVB/TU1KEaTJ5l3wXcbA+go=;
        b=X67Kia23vYYhyrc6Gnbj4BgcLP4L0G8+T8TeCR2KeaF145qbvjTj+4WXg0S0DaEyUQ
         yq9uxcXoYM1y2edSyfrxBcXyLnqRMdyjzOlma/Cvvp2lM2LOqRypLEYMjywbVK1cF3WQ
         UjCyTcV/rSWiA87A48dV3hjTDOetam20f/K/W4TM77LiVc9BWjiPMjn2T2dRqL0k2/VA
         1k1vfs4rU/lbtVu6hmeyyO0A5O14Smq4Ea+ROjxtupRjUThGKYMtqFmXfd9JSg2lvpqF
         JWcrPRt5ngnGhJkgqPNI50iCwFlY42PsaagKr9SVWEKI+kMwzyXuLF77NTNYVW42Zi2M
         26rg==
X-Gm-Message-State: AA+aEWbmE3HMUnzm75ihVc2QduZd+AsfvdayShJjDqYpEgeeWtjs1vSB
        gIZ0BMu+pWaEQbwj309yylk=
X-Google-Smtp-Source: AFSGD/Xlb4QPHIXvuy/RRSUxGALAx4CXlZDfheycpSFuuqHbSHhcUBHs3oo9faaWWzPXmbFlXaSHjQ==
X-Received: by 2002:adf:8b83:: with SMTP id o3mr69071wra.81.1543468781703;
        Wed, 28 Nov 2018 21:19:41 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id w9sm756205wme.47.2018.11.28.21.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 21:19:41 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Dmitry Bezrukov <dmitry.bezrukov@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] net: usb: aqc111: Properly initialize wol_cfg in aqc111_suspend
Date:   Wed, 28 Nov 2018 22:18:09 -0700
Message-Id: <20181129051808.30015-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/net/usb/aqc111.c:1326:37: warning: suggest braces around
initialization of subobject [-Wmissing-braces]
                struct aqc111_wol_cfg wol_cfg = { 0 };
                                                  ^
                                                  {}
1 warning generated.

Add another set of braces to initialize the char subobjects as well.

Fixes: e58ba4544c77 ("net: usb: aqc111: Add support for wake on LAN by MAGIC packet")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/usb/aqc111.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index f69d566bd523..1c2db1191073 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -1323,7 +1323,7 @@ static int aqc111_suspend(struct usb_interface *intf, pm_message_t message)
 			      1, 1, &reg8);
 
 	if (aqc111_data->wol_flags) {
-		struct aqc111_wol_cfg wol_cfg = { 0 };
+		struct aqc111_wol_cfg wol_cfg = { { 0 } };
 
 		aqc111_data->phy_cfg |= AQ_WOL;
 		ether_addr_copy(wol_cfg.hw_addr, dev->net->dev_addr);
-- 
2.20.0.rc1

