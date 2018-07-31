Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DD5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF26208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ibdi7l8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF26208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbeGaNOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:14:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54119 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732199AbeGaNOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:14:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so2687455wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 04:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oD5ZgkLtdVJEND/j3ZAXjWjLfUD/ZSZrDT/jOBxydpE=;
        b=Ibdi7l8HpIXpXVJqM249DbOY0dlNHIUArsr3Mtiy2dPUWVWOMmsAJOGG52FYvObALw
         E734qZBrpz1P0obqxYEB8lTpdNokQXvntw1Q3g/hd79V3rhcA8TTWstcToElqYXZj6Fo
         /nlgEAeNgT+TeANbx3Jo3R04zRAKb6bU2Dc23A8tt2R2MGzwxXtGmASWKJQ1ymOpQm1o
         jnaiFilPjdRSteOd0svrZ+uV1SUBudPqGT9f3N6MqzN8ezEdPz0kuf86SNDCypb0AzHc
         3Mu2Rcqz7X9owde5gXnvZfPnNtDTXNQAUH7bjy6lcmjs3theSXpPZ9P1amn9OLqeMj+y
         J2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oD5ZgkLtdVJEND/j3ZAXjWjLfUD/ZSZrDT/jOBxydpE=;
        b=nrHDlNQScymxu3h41ZfpemXDFwiMg0C+dR8ZvBM4HTIojUimucJdxz/E+DFFfRhczC
         1qkPHfd5MnqkL7RPWAuFTBPnsSp6b41iCQlUSUyI/mHr4GX2AEOzYwcbakhbyKltDZx9
         apyhUbwYUGtMqhPzc3m0nK2eu5aTaL+G99wFJxF9FpZ/RnT0DqcHJRa56cdqk+YphfMm
         d9QHyXHibQf49XF/j14kmmVzhjGD5ACRhakT/2ASKD5hNr68gXcHzgOoxw1EGky7+LF+
         H+uPjyVTB4jGUT9D9aMErddNwuCGWmRZBosJglqbyBk54EdkcjILqWi8vXaHFvErH8MJ
         UXOQ==
X-Gm-Message-State: AOUpUlGd8xOiiJn5WpeNssxCoBOymBnMTT6r0RmsRj7lrEahzbHx+Gpe
        s9hzxhyYgVzwah8HgxlsQX0=
X-Google-Smtp-Source: AAOMgpciKlriAiH7aDs5SUYugKi/0DbusjgaZazJjNqePKAIZwd7nuVn6qyOb4uhvOKilRIT/YaacQ==
X-Received: by 2002:a1c:1ad0:: with SMTP id a199-v6mr2024960wma.131.1533036874797;
        Tue, 31 Jul 2018 04:34:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id f17-v6sm16513137wrs.1.2018.07.31.04.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 04:34:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/7] staging: rtl8188eu: remove unused rtw_remove_bcn_ie()
Date:   Tue, 31 Jul 2018 13:34:14 +0200
Message-Id: <20180731113415.1500-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731113415.1500-1-straube.linux@gmail.com>
References: <20180731113415.1500-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_remove_bcn_ie() is never used, so remove it.
Discovered by cppcheck.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c    | 40 ----------------------
 drivers/staging/rtl8188eu/include/rtw_ap.h |  2 --
 2 files changed, 42 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 82fb1b028fa0..676d549ef786 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -145,46 +145,6 @@ static void update_BCNTIM(struct adapter *padapter)
 	set_tx_beacon_cmd(padapter);
 }
 
-void rtw_remove_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork,
-		       u8 index)
-{
-	u8 *p, *dst_ie = NULL, *premainder_ie = NULL;
-	u8 *pbackup_remainder_ie = NULL;
-	uint offset, ielen, ie_offset, remainder_ielen = 0;
-	u8	*pie = pnetwork->ies;
-
-	p = rtw_get_ie(pie + _FIXED_IE_LENGTH_, index, &ielen,
-		       pnetwork->ie_length - _FIXED_IE_LENGTH_);
-	if (p && ielen > 0) {
-		ielen += 2;
-
-		premainder_ie = p + ielen;
-
-		ie_offset = (int)(p - pie);
-
-		remainder_ielen = pnetwork->ie_length - ie_offset - ielen;
-
-		dst_ie = p;
-	}
-
-	if (remainder_ielen > 0) {
-		pbackup_remainder_ie = rtw_malloc(remainder_ielen);
-		if (pbackup_remainder_ie && premainder_ie)
-			memcpy(pbackup_remainder_ie, premainder_ie,
-			       remainder_ielen);
-	}
-
-	/* copy remainder IE */
-	if (pbackup_remainder_ie) {
-		memcpy(dst_ie, pbackup_remainder_ie, remainder_ielen);
-
-		kfree(pbackup_remainder_ie);
-	}
-
-	offset =  (uint)(dst_ie - pie);
-	pnetwork->ie_length = offset + remainder_ielen;
-}
-
 static u8 chk_sta_is_alive(struct sta_info *psta)
 {
 	u8 ret = false;
diff --git a/drivers/staging/rtl8188eu/include/rtw_ap.h b/drivers/staging/rtl8188eu/include/rtw_ap.h
index f8f07257976c..7a4203bce473 100644
--- a/drivers/staging/rtl8188eu/include/rtw_ap.h
+++ b/drivers/staging/rtl8188eu/include/rtw_ap.h
@@ -19,8 +19,6 @@ void rtw_indicate_sta_disassoc_event(struct adapter *padapter,
 				     struct sta_info *psta);
 void init_mlme_ap_info(struct adapter *padapter);
 void free_mlme_ap_info(struct adapter *padapter);
-void rtw_remove_bcn_ie(struct adapter *padapter,
-		       struct wlan_bssid_ex *pnetwork, u8 index);
 void update_beacon(struct adapter *padapter, u8 ie_id,
 		   u8 *oui, u8 tx);
 void add_RATid(struct adapter *padapter, struct sta_info *psta,
-- 
2.18.0

