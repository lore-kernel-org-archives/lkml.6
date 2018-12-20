Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193A0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7EE206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aFgzY/WX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbeLTQK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:10:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35873 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732757AbeLTQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:10:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so2801503wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CnhknRkRJgND+GstRyz0VxGv13ceIvrslPcHLDVtb5g=;
        b=aFgzY/WXD9RhJymFKKqTTtuw3aH0Ve+4JMENOj8emUjMjwMXjloneezG0tjss3EdI4
         CKZXzqy3v3mlJWE8XKBqzNpLqWlC0d1BbXxIDwezl0IWCUIpjMc8B/yVpWB48jrCw0ZC
         /g22pqv/LpthC4UfeMuOQOeun/qzm4E1KA5+sIIjppJCXr5Wfxc+tQD6vVV6Ya2YN+jJ
         B4w6jo8z7uHd2OMz1tCVXx6yFl9kgRDSzno45oWqYkBGqHQwlqJf9nxKINueVjzX2sH+
         YPyT8enK+6MkRiga1Iz4EjTw8R7MpkKNin6FPtDFj2uSK/G9HNg1y/xn5AiY8JdYChLx
         5TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CnhknRkRJgND+GstRyz0VxGv13ceIvrslPcHLDVtb5g=;
        b=e9hGeuJcw8FV5dZZEc9jHFWks0P1Ysir9pxyjMTWjTmLG6YSwIqtpTW8vUcOJ9g6Jd
         ELKyNno40hzMPLtqEG5BP2xqv04F4LwElI8erle8x8vZkmEMtC5smoX1FwdNqz//de5r
         dxRcd91uiyOBFU94ryrRJ3UdH5kyZPVDpuQ1lYPI4m0EEJ+hY3XMOSF8TzpgkKJGMIHY
         xeBcPrzWiAyaNj/GaL3fWF7OXAvUzz5vsXslD4g3pwiNTTjECPgf84OFm7pmR7qjg9q9
         XO2OaTw4bdUdMY3ElLV4EmaKXdtS9TQEU/W7kBNAkhdvE0MiRWUnwXIcu+LSaR5ZbwEC
         bo7w==
X-Gm-Message-State: AA+aEWZnk0ZQSggP1tQh6pwQWcF/zWGbJDaSt2cXHpnUYEFSZvRXvYnn
        5K++4dvMuUqdUR9+TZDKORhElQ==
X-Google-Smtp-Source: AFSGD/V4/m3InhsVVUa024rnI0uZJh864DHPgw5rA968fKZ2BerjzAwNGYRsEZ1+NSC80hu6GmQSMQ==
X-Received: by 2002:a1c:67c2:: with SMTP id b185mr11210412wmc.96.1545322244547;
        Thu, 20 Dec 2018 08:10:44 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id x10sm10941186wrn.29.2018.12.20.08.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 08:10:43 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: meson: libretech-cc: set eMMC as removable
Date:   Thu, 20 Dec 2018 17:10:36 +0100
Message-Id: <20181220161037.23756-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181220161037.23756-1-jbrunet@baylibre.com>
References: <20181220161037.23756-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eMMC on this board is add-on module which is not mandatory. Removing
'non-removable' property should prevent some errors when booting a board
w/o an eMMC module present.

Fixes: 72fb2c852188 ("ARM64: dts: meson-gxl-s905x-libretech-cc: fixup board definition")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index db293440e4ca..daad007fac1f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -256,7 +256,6 @@
 	cap-mmc-highspeed;
 	mmc-ddr-3_3v;
 	max-frequency = <50000000>;
-	non-removable;
 	disable-wp;
 
 	mmc-pwrseq = <&emmc_pwrseq>;
-- 
2.19.2

