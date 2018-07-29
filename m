Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB92C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34B220857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATCEUp48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34B220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeG2Skb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 14:40:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52554 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbeG2Ska (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 14:40:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so10518753wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 10:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rB4/hg8RO73toEiKmPlnSrntqLStIoWKWrMoDa0XxwY=;
        b=ATCEUp48bR9BJ9dczXbH3Yt7pKC+hn8LP2ZhNrH9JeUn2nFtXXHYT8ecbCj8Xcvgom
         qKFMHf/jHUyX1I6PxHvSjiFE+domE9E6q8o6yNl153VSczyglB62Hb5p4NPFKyL46A2Z
         M6DZd8iDFvYVlrD1+zOcVozXTfkiKnKYbc9P2r4h5x8pjkOoDA0nKEaIwoHbQeqsQWy1
         pIMK0hOU/icqzyaIy9wbSKx9g9H6sXWJkbTdegFFIJV5nWxlhGkL0v6/husMI7kex+Pq
         y2JrAxJ+ZSpM+ClhX40zuehS3j47s2UoCHaj6MOC/oWXuKUop/Se36z11D/ucZA1tOCr
         AJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rB4/hg8RO73toEiKmPlnSrntqLStIoWKWrMoDa0XxwY=;
        b=U3/XGb02WNvzos6HfqAflfqbJsLFbJcyubZFGFYJ0rcCl0glfhd0U08oqE/sqQ8J/u
         FUHJChrrAbAJLmNhEedBUGq06MHRM6wahGFUPCIAyXgbmpmCx109fekitk3XOoaom42p
         EFHFwDYzxP3871aZ2jBfiQTjB2eb9tLk0WwBVAC3O+djD1vDQZEntap7oLnG+RjPVFI4
         yOYcKP3TKSMgY+qQeXOJ1yfks0boZAI7EaT7v1azboHO+97bFL8dwGvMMMEKlcjc2CdX
         +VN7AOO3DpqQu5hGRQ9SOqPZEfcYIc870KJ7N3LQ1KcS/yLz3xrBwMXulxr3Cwsh4GUh
         jufQ==
X-Gm-Message-State: AOUpUlFi6cdEllP6TLLwCPEj7ve9L2mgVWfcRyyxGoeZlcU5W/l0Xh67
        SLUYulpDkQ9XUwg9DbRk+RQ=
X-Google-Smtp-Source: AAOMgpfZQRbgtLn/WXuYnHZVv9+EEQiOxaHJUcvoBvJIzIMry+K7n/elil3B3zUKv+SUHrax44IMRQ==
X-Received: by 2002:a1c:910f:: with SMTP id t15-v6mr12692958wmd.51.1532884164328;
        Sun, 29 Jul 2018 10:09:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id v1-v6sm19916360wrs.34.2018.07.29.10.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 10:09:23 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/8] staging: rtl8188eu: remove unnecessary parentheses
Date:   Sun, 29 Jul 2018 19:08:50 +0200
Message-Id: <20180729170851.2581-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729170851.2581-1-straube.linux@gmail.com>
References: <20180729170851.2581-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses, also clears checkpatch issues about
missing spaces around '-'.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_intf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_intf.c b/drivers/staging/rtl8188eu/hal/hal_intf.c
index b21ba01abc57..b8fecc952cfc 100644
--- a/drivers/staging/rtl8188eu/hal/hal_intf.c
+++ b/drivers/staging/rtl8188eu/hal/hal_intf.c
@@ -48,15 +48,15 @@ uint rtw_hal_deinit(struct adapter *adapt)
 
 void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 {
-	struct mlme_priv *pmlmepriv = &(adapt->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapt->mlmepriv;
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 #ifdef CONFIG_88EU_AP_MODE
 		struct sta_info *psta = NULL;
 		struct sta_priv *pstapriv = &adapt->stapriv;
 
-		if ((mac_id-1) > 0)
-			psta = pstapriv->sta_aid[(mac_id-1) - 1];
+		if (mac_id - 1 > 0)
+			psta = pstapriv->sta_aid[mac_id - 2];
 		if (psta)
 			add_RATid(adapt, psta, 0);/* todo: based on rssi_level*/
 #endif
-- 
2.18.0

