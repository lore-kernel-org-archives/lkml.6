Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3318C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FD8204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hl8GGoeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FD8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeKBWBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:01:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36581 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBWBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:01:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id z17-v6so969235pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xwF4fMsi99EK3nUkfVmEyk17v4TQ2k8YoQxt13VJzTw=;
        b=hl8GGoeIktJIHQ3+/RO7qdwCCmY6rqE+3WGIdjqmjG0zBLvgLhcp5pWkxhFc9pgoBu
         BArtV5MCaQeF8Wdy7KoNHoiPF8koYB/0tKV3TSLxAfxj1SMAGUiNzHLpJ67jbK92UAOh
         EmETjUmErFMyPcrkf3L3AJjfTuhDyghblSp+6JO3y3xPRMsNueeYGeA7+8UbyR2uwKRY
         XgxpucSvXfFuUXwhrmU1nzQJSuAdZlHAmcau134Giad9/+kbcN8LiuFnFxj2l8v2v+eZ
         Q696LSZ0cO0/zmPi4Yb6Uxh9iXaIH59i4iaswOKxYgt5imp9SsftQ7PrM/xEvSQwPzRO
         grzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xwF4fMsi99EK3nUkfVmEyk17v4TQ2k8YoQxt13VJzTw=;
        b=lEHz9nzuJYw/W4lvChlcu6ATvQVQdpeBMsgj2Lmn52fATFIbM/uP6ufj2iVYNY9v0U
         cijDRgSlxej6+L5qWMz9mOuY6lF8+yos6QRMYVk6aCN113PqARlh2WRw4T+83MEn7fMq
         mfKyNncKmOMXZidkKgzdD7u+/tj6/9FxTc3Zm9ggsbkKkROhzbFzqxlRJIFwJo/s49No
         klDdOkm0BN0dqJqHWHQAKLGhprSt0z8vFfhfyptV/ZNvc5D0QH+ji5Edu2HDzjKchRN2
         c4fTjeJG/CnNA52zolkc14zEmwAc34T8ScTOQR9WXIuTdF5tp8YHhc69C6E+Km3Yljbh
         orVg==
X-Gm-Message-State: AGRZ1gJaOk7DIozZZksmejq5Ultu9JIqKecpW03mWy0cftnwo3mRTQ0M
        6csavcjJnDpzlMmddhUQoW0=
X-Google-Smtp-Source: AJdET5dhSjkifn7yrNvzWZIynPJCvbnTlTl2llBRkBZb24PkwtlBPWP4rq4BtiOeLTLqWft2tyA3FA==
X-Received: by 2002:a63:ec4b:: with SMTP id r11mr9704883pgj.44.1541163235285;
        Fri, 02 Nov 2018 05:53:55 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id g8-v6sm14620224pfh.57.2018.11.02.05.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 05:53:54 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, natechancellor@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] staging: fix some typo
Date:   Fri,  2 Nov 2018 08:53:32 -0400
Message-Id: <20181102125332.24421-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ture->true

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Change in v2:
-add changelog
---
 drivers/staging/rtl8712/rtl871x_cmd.h       | 2 +-
 drivers/staging/rtl8723bs/include/rtw_cmd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8712/rtl871x_cmd.h
index 24da2ccea04f..37960b04beee 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.h
+++ b/drivers/staging/rtl8712/rtl871x_cmd.h
@@ -434,7 +434,7 @@ struct getrfintfs_parm {
  *
  *	mac[0] == 0
  *	==> CMD mode, return H2C_SUCCESS.
- *	The following condition must be ture under CMD mode
+ *	The following condition must be true under CMD mode
  *		mac[1] == mac[4], mac[2] == mac[3], mac[0]=mac[5]= 0;
  *		s0 == 0x1234, s1 == 0xabcd, w0 == 0x78563412, w1 == 0x5aa5def7;
  *		s2 == (b1 << 8 | b0);
diff --git a/drivers/staging/rtl8723bs/include/rtw_cmd.h b/drivers/staging/rtl8723bs/include/rtw_cmd.h
index 1530d0ea1d51..7dc5bf050839 100644
--- a/drivers/staging/rtl8723bs/include/rtw_cmd.h
+++ b/drivers/staging/rtl8723bs/include/rtw_cmd.h
@@ -543,7 +543,7 @@ struct Tx_Beacon_param
 
 	mac[0] == 0
 	==> CMD mode, return H2C_SUCCESS.
-	The following condition must be ture under CMD mode
+	The following condition must be true under CMD mode
 		mac[1] == mac[4], mac[2] == mac[3], mac[0]=mac[5]= 0;
 		s0 == 0x1234, s1 == 0xabcd, w0 == 0x78563412, w1 == 0x5aa5def7;
 		s2 == (b1 << 8 | b0);
-- 
2.17.0

