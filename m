Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC8CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD49120661
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP91ump/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD49120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeH0A7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:59:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36498 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeH0A7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:59:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so6421386edq.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s8X5yXqzJC8EY89qxnJduD/Gd6RgrEX0jPzGjnJu/aM=;
        b=BP91ump/Ylgn1TgjstfCm6E8hkKWbhNyvhVAi7Dw1aRbsV2F4PwjWL0Re3tOxA79cL
         L1LTRb9ZsD1KCPZogXfVsdnLy6q/E4mDD5gt1cDgs5Y4BaSJ7QiPQLhb1TAaYmDSV92N
         Fugoqy/lSlcQ+oLAljypE0VpmTyhLTN+Fn3er07HfQGtmEulM4yU512CPLXpQ5nDTtIe
         XMs5ywawjQ3weWB0XDxYYiLc/pVJgODLUFEhr/luvs1w2IYRbzTT955uVUULPvJZgebA
         93zUM/9pZpy8J5b7dfYbOBe3wZEenHigfGudDJcBz5SqabGTjkpYZMWJIz/2eLFr5nG0
         WFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s8X5yXqzJC8EY89qxnJduD/Gd6RgrEX0jPzGjnJu/aM=;
        b=lnwO3PLFlaQLbAV/T1ebm46Uz0K5TG180ESfTN9JJuUV5DTCl3teJ3THEdK5q8Qh4a
         osEEMYL3eexczi30kZcCxWvobp934RtkS+LKmlriORERggodWVDY3lNCmdgOJlIJT5gW
         bpIAlN8L/kurWWqMYcDNV4daVOJz7Xr2L7zNWQda9GSf7BQm9YWc62kCIAXrf9lT6wed
         4VXhH+XJPf7BDzvBG4f5otpOdmL0oHXLFU7AK3U3tdFdx5+kLQ+cWikSXd3KTHncZGtC
         1GZiIBBbwFezhelTMYYMaud2iROJNgZBMJbE+/EOFFyBWqeJ1p220fXflIJj4uO7daXW
         3kLg==
X-Gm-Message-State: APzg51BGJieW1RtEGKHGCI72yfjXg8JdFcg++1RYuPiaseZ3ZA+q0DCi
        wTX+Z1r2KMOrkZaV6HfYF67wefq1
X-Google-Smtp-Source: ANB0VdYifCsO4ZN06Lwc16xLvOISdGYODTHLvfiBMGimBfqnrp7jFElbKrBeAzjy9KPa5uFQw9DZ+w==
X-Received: by 2002:aa7:d307:: with SMTP id p7-v6mr14046679edq.143.1535318116154;
        Sun, 26 Aug 2018 14:15:16 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:15 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 15/21] staging:rtl8192u: rename EEPROM_TxPwIndex_Ver - Style
Date:   Sun, 26 Aug 2018 22:14:33 +0100
Message-Id: <20180826211439.14326-16-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the constant EEPROM_TxPwIndex_Ver to
EEPROM_TX_PW_INDEX_VER, this clears the checkpatch issue with
CamelCase naming.

This is purely a coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 67b4597d351e..836be2a0b330 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2463,7 +2463,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 		RT_TRACE(COMP_EPROM, "CrystalCap = %d\n", priv->EEPROMCrystalCap);
 		/* get per-channel Tx power level */
 		if (bLoad_From_EEPOM) {
-			ret = eprom_read(dev, (EEPROM_TxPwIndex_Ver >> 1));
+			ret = eprom_read(dev, (EEPROM_TX_PW_INDEX_VER >> 1));
 			if (ret < 0)
 				return ret;
 			priv->EEPROM_Def_Ver = ((u16)ret & 0xff00) >> 8;
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index d7f830bf9e94..f98e6c2cf414 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -46,7 +46,7 @@
 #define EEPROM_TX_PW_INDEX_OFDM_24G	0x24	//0x24~0x26
 #define EEPROM_TX_PW_INDEX_CCK_V1	0x29	//0x29~0x2B
 #define EEPROM_TX_PW_INDEX_OFDM_24G_V1	0x2C	//0x2C~0x2E
-#define EEPROM_TxPwIndex_Ver		0x27	//0x27
+#define EEPROM_TX_PW_INDEX_VER		0x27	//0x27
 
 #define EEPROM_Default_ThermalMeter		0x7
 #define EEPROM_Default_PwDiff			0x4
-- 
2.18.0

