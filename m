Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C8EECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 06:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66C420881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 06:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElvWEd1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66C420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeIOMBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 08:01:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37294 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeIOMBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 08:01:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so12461106wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=54VwC8o66TdBolbtspXxKQw4dyZqvDGx+dB1c4OXNGk=;
        b=ElvWEd1aJeFb1DxsT/OEwAOf1CkROPITq9Ui6v1ErWgWWJ/j9rOTeVPtncruO4Bac4
         L9wukmrLynNdGtLQRfjqtYEaOVLu+LbzXLOmVH0/EBseCveP94ySpv94+t4yaUxWItUc
         ath+MGO4Lk7Mkx5BIWxzHJcTuHYmINJVlV+AgzDIVOgrg0AYAe9vyRooewDUXXaCRbIz
         BkubAS5YO5fPwH8Wk9p/b9p4NMFsiPulITJPSRndhj2xcu0sQdbsKr9mCqhT81gNi8fn
         G2noh8fJ8e5gfB0Q6CKOkwzZkirwr3JCb2uZmady86MA4rl32f2iOGN9McJabq0UPuHq
         sGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=54VwC8o66TdBolbtspXxKQw4dyZqvDGx+dB1c4OXNGk=;
        b=XHIPxjnj5+VfdmxJxrQ4r6WLEKNLR0TdV5yllQpqwBIRptgMrrUSHBk4WzAcaB57Z4
         khpdDynwHviL2zCITPrf5ccZNdKbB+gGrNzmWFhAw9+X9ie0EY8xuzB4aVEhb3H2xIpf
         JyoDzQ5+GMq6WOdWTQ9VcwClNPaj7/2cp4jKiZIvBxp/AvCQ+LgUpN+yoF5Gw3+MxVM0
         qlTPnP5ZPCfp9+2qNQbpA7kS8PejsoBhHzxxaFWlcCX36FbIGYNC92DKxlQm917yaUFP
         qxY4O4+dGgHJfaXiQiae19KyY4vc2drbwty4SEXRItDokZCsn2AuQk40z/taiEf8dXQY
         p5nQ==
X-Gm-Message-State: APzg51B8SV8Ftu8fWniZcpm7KavcRSCHTylnn1OJRzMyWcAJdePROQNI
        /GIl3CkJPBKekAbwe3fZa9w=
X-Google-Smtp-Source: ANB0VdYCePw5EgA1EfMyOTcGnONCVSjZQ+GNiCE3F60XcyeD4b/DBXXATTCzyD1HEV1MujdgRuOg6w==
X-Received: by 2002:a05:6000:1291:: with SMTP id f17mr12230980wrx.215.1536993832593;
        Fri, 14 Sep 2018 23:43:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t9-v6sm2131042wmf.1.2018.09.14.23.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 23:43:51 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] misc: echo: Remove unnecessary parentheses and simplify check for zero
Date:   Fri, 14 Sep 2018 23:43:37 -0700
Message-Id: <20180915064337.845-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

drivers/misc/echo/echo.c:384:27: warning: equality comparison with
extraneous parentheses [-Wparentheses-equality]
        if ((ec->nonupdate_dwell == 0)) {
             ~~~~~~~~~~~~~~~~~~~~^~~~
drivers/misc/echo/echo.c:384:27: note: remove extraneous parentheses
around the comparison to silence this warning
        if ((ec->nonupdate_dwell == 0)) {
            ~                    ^   ~
drivers/misc/echo/echo.c:384:27: note: use '=' to turn this equality
comparison into an assignment
        if ((ec->nonupdate_dwell == 0)) {
                                 ^~
                                 =
1 warning generated.

Remove them and while we're at it, simplify the zero check as '!var' is
used more than 'var == 0'.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/misc/echo/echo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/echo/echo.c b/drivers/misc/echo/echo.c
index 8a5adc0d2e88..3ebe5d75ad6a 100644
--- a/drivers/misc/echo/echo.c
+++ b/drivers/misc/echo/echo.c
@@ -381,7 +381,7 @@ int16_t oslec_update(struct oslec_state *ec, int16_t tx, int16_t rx)
 	 */
 	ec->factor = 0;
 	ec->shift = 0;
-	if ((ec->nonupdate_dwell == 0)) {
+	if (!ec->nonupdate_dwell) {
 		int p, logp, shift;
 
 		/* Determine:
-- 
2.18.0

