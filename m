Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198C520867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPBwrt58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198C520867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeIDAbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:31:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39547 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbeIDAbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:31:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so2149248wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mV0gO/hIWeCsj9GNznG0mzUh5uANsZqWCaUNXlQD08w=;
        b=uPBwrt585Hkx3TGQCsL4BJE8e7qnsWgHPVcDBNq7No0xbWIvEfbxYVRmwceKEsfDSh
         E7VUnWFEjMyBjPs//w6EQQmMs0VAaG/G6CgJXq84ZAZXZrLHHUneNObeW69Lvtc1E3bf
         r3Bu20WViVqVzJvIXakmUXmBWO+b1W1hUYqYpjC8gERoQCPzAmNz7iKtnFpQUddUqN1v
         1KNeC57tp3zkyhnRewbEJJ7PGxU+xvDzaMlNT+UYUjvwpLkuMy67sTDQ2jTvJmM33Ycg
         +2+3XeM+xKdsOlBNYMZjFsgTw88K9u2PMNpSfU6LoRlrwa9NiNKLvKOl0ls0tWEsJTlv
         94OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mV0gO/hIWeCsj9GNznG0mzUh5uANsZqWCaUNXlQD08w=;
        b=ZoH1zReXMDRmV37rzfZd3iVQ/qEE0bwxtabAlIoRi92xMw14aQRcoNJV6MmKM0NraT
         uxvxURHeoUtwwLCbTYoq5kKGMA4r5HN59SMwCwI6moqX4Pshe49hVwom6P7sDJWIDPSs
         j6EqM9dLkCyDQajSqiwgPR6y9RCgAQmJTK2i6mCToATPG03cXg8NoQPh3QJVFM33M5ot
         E+C+2Cu2kqtWqbYbXQWfTsfvgQY01FYB5LXXfDrFrwX0Mp8o9fFAuO4qk0Ws9NHs/fqe
         emsJbC5zz8PUR/VO2y6uJGkYYT6zQakvr4j+8QVYBPuicGMY0y5oVWDhO2fBK0pTymWn
         mP6g==
X-Gm-Message-State: APzg51Bza+g4QN7MseyR3meiDlsTzafvR40MbTF989Cw4GpSL+96uY2h
        zD4ay7NkXX5XbtIT+avxbCI=
X-Google-Smtp-Source: ANB0Vdayl74v5wdOZobPlqfVAOfKpKXQ4F7IpCFtvYAqIMgLi2VplnMGhw1L0L6wD5849FfxIOoogg==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr6353991wmd.79.1536005396721;
        Mon, 03 Sep 2018 13:09:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id t9-v6sm46792663wra.91.2018.09.03.13.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 13:09:56 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove pointless comment
Date:   Mon,  3 Sep 2018 22:09:52 +0200
Message-Id: <20180903200952.14824-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This comment adds no useful information to the code,
so remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 59039211dad2..157c79c8bb23 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -745,7 +745,6 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue)
 		kfree(setChannelPlan_param);
 	}
 
-	/* do something based on res... */
 	if (res == _SUCCESS)
 		padapter->mlmepriv.ChannelPlan = chplan;
 
-- 
2.18.0

