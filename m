Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA76113C628
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFE320893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzIji8+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFE320893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeG2U0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 16:26:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34681 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbeG2U0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 16:26:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so10372723wrt.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 11:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ngYOJ0Tn2jKhxi9AO1x9qWlpQzm35rcPdJLaex2Ijzc=;
        b=YzIji8+HCwZdWg3hY9WDwkBEgvugTixSVOD2Fs67e7+ztvtyeGgfy8UwOOplkOXJAV
         p3f4Q/tpYOt73+Vw8iJ4KyacI2b2HrHTq684Ci2xF4kXRz3VJTE3MIQzFPQvR+OY/Gvi
         M3SlkklSe34Aj2edjF8rEmkMqqio+DOASgtYKFh3OZGDT9ekDDm/qAXpjjz43GvDh20u
         8eWG1AxorZJvNdQJRuGHZbgor9P0Nq0NiPBpmlWeFm1mS3iA68Qi27Fkz8FXiBzwYMFv
         6D7cweOoEGf727fEmp1FExFkG5R0JK8fLW00dFznRX8DLap9vJMLQygdbK6rXIfdY/9P
         ABGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ngYOJ0Tn2jKhxi9AO1x9qWlpQzm35rcPdJLaex2Ijzc=;
        b=UZ90JCS0q5YfLZvn0cLEDlx401gZ2wb5YYUl+KZmWQOXudDqGg0Oz6qKlKNZthOMSQ
         EY992pLp7NiKrbEeRWGuFphp4rp6lZJGRza6jAYQqnD5nN6kTnGh3ow87vYuf4pi4cwv
         wBcKtol7DYVrLYym5Lcatvo1TUCWkTnfIFjO/bmGDvTU7WgSd4t5MJG+v2/mt+AFOOrZ
         l7dZ5VzcMZwI1eM3LZPG7OUW30Fiiax+deC4LdujGx9SEecfLumWUWkq57cjLROy8kmz
         2bDrIq+0DMHR9a8geDdgcE0hC2u0fbagcBpGVaPowozvV6FHGAVsi2BoMcUliqUrjXuI
         arFw==
X-Gm-Message-State: AOUpUlHsIKIG/EK6970aiNrc/s6UKPUvr5Sd3N3ul2TVImki4jhnrgJ8
        GTXJpfSpEbElXTlqcYluyV4=
X-Google-Smtp-Source: AAOMgpeJ82iLqjYfdt00oiNOK5wh/Ik9JOh1z5dvUY2ez6ZUc4IOtH30QYPEIPUyhlQQZHud2+j/XA==
X-Received: by 2002:adf:db41:: with SMTP id f1-v6mr15318065wrj.212.1532890511517;
        Sun, 29 Jul 2018 11:55:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id g125-v6sm8674247wmf.16.2018.07.29.11.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 11:55:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 6/7] staging: rtl8188eu: fix comparsion to true
Date:   Sun, 29 Jul 2018 20:54:46 +0200
Message-Id: <20180729185447.19903-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729185447.19903-1-straube.linux@gmail.com>
References: <20180729185447.19903-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if(x) instead of if(x == true).

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_intf.c b/drivers/staging/rtl8188eu/hal/hal_intf.c
index c43e7b438058..b21ba01abc57 100644
--- a/drivers/staging/rtl8188eu/hal/hal_intf.c
+++ b/drivers/staging/rtl8188eu/hal/hal_intf.c
@@ -50,7 +50,7 @@ void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 {
 	struct mlme_priv *pmlmepriv = &(adapt->mlmepriv);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 #ifdef CONFIG_88EU_AP_MODE
 		struct sta_info *psta = NULL;
 		struct sta_priv *pstapriv = &adapt->stapriv;
-- 
2.18.0

