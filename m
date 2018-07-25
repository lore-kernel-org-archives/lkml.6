Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30044C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEC020844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWe3f8te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEC020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbeGYUve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:51:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53211 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbeGYUvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:51:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so7140584wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0OgM9TKvElmrUkoCowceIsQvVrdAh7fLPGxhEmy/En0=;
        b=PWe3f8teYQ4YvWorPRc5CmJplPC+ApnhgZeszdMCRBcsWSL6I+dw+SSS6dKGxSwLPq
         eIWDz9tl3RJEfTZLEFXLQBEqDZ6hYf9ipKNfUck0hYNHemAZqYm9bhgpqeghRYZMsnAO
         Gd9FKp3wrCKL9DUjIvKhre2SK2Eutqa/r4LclBipRLoklHD7LZO79TldzSBZj4RidzdL
         ExYesD7+Yv/hBaSig6jeeRheBJBIaum2VfJyGUXOG1yaKCW4rHJmBaJOtDWyJHbyqRuG
         GKIlkAIm2r0WVRZl+pmHd2jkV9qKO0WRr/FBwStCxLFDwam05T7AguwvQmlZ4PfF8vwI
         1m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0OgM9TKvElmrUkoCowceIsQvVrdAh7fLPGxhEmy/En0=;
        b=ZO+LktIV2YTeB3jgbQxfOMaObC9OopURDQ/c0aIPIoXqLbqxm36W4qW5wG2v5NDrsX
         6MbyjJuCLvRtu4wcNL/Kd43p2BtvPmtt4q8CcfidnpStXMCB04sbCmC/VFI3KKnXf5qD
         Vca9a4susXYc+Ma77EZV+eavJzdQ95BSWyH002YjByHtWG/RUJlWiZHRaVj/yiI7oLrJ
         RLyoVRqIDxPeh++DeSMhZUz4/X0V7wu847NWDZi+I+Kp+Non/puw61ZOA3BtZNgHvYRC
         VxkVaqY0VB8JcKXcQxP3TdpKouq8Xje+3ORnHl8qSoSrV0M0qNORua56duDM4PmNuYNl
         HIpw==
X-Gm-Message-State: AOUpUlG7dy+3p1Dc1t6yde6tTk/S5+3NChd4cNNDsTI1PtVEOaUmpvsP
        G+4WCmQEbTQxN1kZo9k9mMs=
X-Google-Smtp-Source: AAOMgpeXiCra310i10GE2XWKAzkqwM4FdMPcZY+TkzerpjXfgtcSOXfyojkC+bB7ZqkwY90sugDEdg==
X-Received: by 2002:a1c:9290:: with SMTP id u138-v6mr5804262wmd.52.1532547505848;
        Wed, 25 Jul 2018 12:38:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id t186-v6sm3752729wmf.14.2018.07.25.12.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 12:38:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: rtl8188eu: remove unused rtw_get_oper_choffset()
Date:   Wed, 25 Jul 2018 21:37:58 +0200
Message-Id: <20180725193758.1219-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725193758.1219-1-straube.linux@gmail.com>
References: <20180725193758.1219-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_get_oper_choffset() is never used, so remove it.
Discovered by cppcheck.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c   | 5 -----
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index ab97fcdd6481..0fe35e141926 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -303,11 +303,6 @@ inline void rtw_set_oper_bw(struct adapter *adapter, u8 bw)
 	adapter->mlmeextpriv.oper_bwmode = bw;
 }
 
-inline u8 rtw_get_oper_choffset(struct adapter *adapter)
-{
-	return adapter->mlmeextpriv.oper_ch_offset;
-}
-
 inline void rtw_set_oper_choffset(struct adapter *adapter, u8 offset)
 {
 	adapter->mlmeextpriv.oper_ch_offset = offset;
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 50051a1b0655..c072e1e25d61 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -471,7 +471,6 @@ void Set_MSR(struct adapter *padapter, u8 type);
 u8 rtw_get_oper_ch(struct adapter *adapter);
 void rtw_set_oper_ch(struct adapter *adapter, u8 ch);
 void rtw_set_oper_bw(struct adapter *adapter, u8 bw);
-u8 rtw_get_oper_choffset(struct adapter *adapter);
 void rtw_set_oper_choffset(struct adapter *adapter, u8 offset);
 
 void set_channel_bwmode(struct adapter *padapter, unsigned char channel,
-- 
2.18.0

