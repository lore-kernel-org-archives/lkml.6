Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E525C43143
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 12:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580992086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 12:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3Cv4cli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580992086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeIHQ7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 12:59:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33181 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeIHQ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 12:59:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id r1-v6so1577194wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zvfjwKrHenYo1r840moM/BeFarxBi7ZPVK1QnalOfOY=;
        b=Z3Cv4cli64O29mgXp3JXuyvdoaLeoFZ6ad2wSSmUap0H5gfu2Z7MehSEVmBgncmlS8
         iVxhjTgQMR/i3/gPcatsY3C0/5HoN2OnskzPelIDkMLwPMJkGSpnaehjAX7ARZlmZcq0
         yp/enQruJoC3UKf3Kg3d4VWOckPKiAkeD6fI9m8KLowePViKcZkd5mA0cj7BQRgOFNjD
         L3DaoU4ZlyAMmyzs6g0wv1YBL/tllOfW+YubtdHkdg68Sa/5uTTt8g9hZLhGqTCcqVhX
         Ymuzv6tN4ywQztt3e8bfQcLsy7xAZX4Rk1SNIAe+O9IlRKRcq6T9Hbp/Qd1U8JjeeZHj
         XyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zvfjwKrHenYo1r840moM/BeFarxBi7ZPVK1QnalOfOY=;
        b=lBUyk58bq/qo5Gz12D96niOLvSWXiibMFSRV6VR89XHeqEY/pqho24KNf3L8D8ljyZ
         ycKBLIrgeInNynIFbBdOuowGTNdmTP4/48uu6VoZbq9Fsi66fNHEx+TDVIzpYRt9EN9Y
         6iX94nECqWaipzQQp4jwynaoRxDu1rnyp5Q77N2HuT2d2nzXxJpIPW0gObutv3PWZmmL
         xiipPLS+dzSWNu4CZxlV2/LuK0SSb3LOc1oAJ/HuxXOsmgHN/lVf/CzEhhha/YayvZcz
         yNEd7njq7FgddOenqpU0PWrTWwBkMHhJr6YwsUpjQt1Rg/rTMzsSVyEVFrQ6XBW5z+Zk
         XLZg==
X-Gm-Message-State: APzg51DMo85T82CFhS9+6AOaVwICMzVxzdpTOEmV3BQ91SHV+s4wObUs
        8rWPRh7jLMFeNY04n+VjrY7LT9js
X-Google-Smtp-Source: ANB0VdZ+f+fsAFeTyU1/0WmdGe1J28lWS19Sea3suu7j80CTwtMbUBBqUALjiDHjZxmvFUH6gIqbGg==
X-Received: by 2002:a1c:8153:: with SMTP id c80-v6mr8413194wmd.123.1536408846678;
        Sat, 08 Sep 2018 05:14:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id z4-v6sm9096458wrt.89.2018.09.08.05.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 05:14:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8188eu: remove unnecessary parentheses in rtw_led.c
Date:   Sat,  8 Sep 2018 14:13:52 +0200
Message-Id: <20180908121353.16137-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908121353.16137-1-straube.linux@gmail.com>
References: <20180908121353.16137-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses from conditionals.
Also clears 'Alignment should match open parenthesis'
checkpatch issue.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_led.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index 217a1aaab8a1..d51494eb11ab 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -18,7 +18,7 @@ static void BlinkTimerCallback(struct timer_list *t)
 	struct LED_871x *pLed = from_timer(pLed, t, BlinkTimer);
 	struct adapter *padapter = pLed->padapter;
 
-	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped))
+	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return;
 
 	schedule_work(&pLed->BlinkWorkItem);
@@ -460,7 +460,7 @@ void BlinkHandler(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
 
-	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped))
+	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return;
 
 	SwLedBlink1(pLed);
@@ -468,8 +468,8 @@ void BlinkHandler(struct LED_871x *pLed)
 
 void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
-	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped) ||
-	   (!padapter->hw_init_completed))
+	if (padapter->bSurpriseRemoved || padapter->bDriverStopped ||
+	    !padapter->hw_init_completed)
 		return;
 
 	if ((padapter->pwrctrlpriv.rf_pwrstate != rf_on &&
-- 
2.18.0

