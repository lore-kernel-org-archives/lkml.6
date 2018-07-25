Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B9EC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C95E205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny5d4M6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C95E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbeGYUvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:51:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56244 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbeGYUvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:51:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so7170870wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 12:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/BnhClijkwxWnWhvk5aLJpjetMs3zVrGz4OEvvw5lVs=;
        b=Ny5d4M6xdKUAXVo7RZPr5ymAxG6Dhl64GvvMy78bd1Xh/XoutR/vu76UTIGkDJ037j
         gBXPNZJRQlbNfJGRxx6M4x2wpodD86xZclltSnrFtQ4FK2CJV+n6rvZGwJcPsT01IweG
         IIg1wIW05KV2w5DRFDgDsf5j8LqpHeNgLqK2WK5yDCMnxjNqhtu/gs+JDoN0KdVL6KNG
         ETVPI9QaRhJbIMVqqjL2QepdRPE/0Slq8vDQl+79J6wPSE/8BpfQJM5nonWIkWgxYjjk
         Uy8x6Hn/2thJRC6ijymNLI5WxloChKDB6sA4OrKgYc4gKX33zj3NaSNtnplt4BHCFDaw
         pRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/BnhClijkwxWnWhvk5aLJpjetMs3zVrGz4OEvvw5lVs=;
        b=A31dMvjlAl5NCG8poc29c8UY/g59hfAvBeXqdTZLei+1Tf/utAY2TJzWoUlWvzUa0L
         Sm3WANEWL7i4fkjANXL4cTXo9+Dt3oKf66THgEqJibaCD7WeRmzo68JI5wSrEVfQLCyn
         MYqy8ovVi4tggLYlfYdzS4KVHEE2Ms4sx0x0K+Nns1tBCQ9yhcWeuSPVcy4egz5MbDdn
         wAa5Q0G65BjJYKP07YKYHmjFfR0y1R+UYiSYILTq4nEyUIWxx0sDs34fe/v55BoNTOq+
         cg5EGaffEd93/KcT6RycrXsSoEuVUMRwxB/al0cDjs5qTTuACyQjsVxi2901QZQ+Ac/L
         irDA==
X-Gm-Message-State: AOUpUlEPp9NeCTn3rMX3M0WNez6qN0BFQ1L4I1ARF3rXdu9fc5o7ztEr
        E5QCcBNC7m+FuqAZu8i8dA8=
X-Google-Smtp-Source: AAOMgpeI2rO82UcNyIMLEjZkRx8gr2h5DoIeKvbP3p/Kfv1oR4peHLZw3+27gFvWCdbnCkCNprtIKA==
X-Received: by 2002:a1c:be13:: with SMTP id o19-v6mr5128889wmf.1.1532547503653;
        Wed, 25 Jul 2018 12:38:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id t186-v6sm3752729wmf.14.2018.07.25.12.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 12:38:23 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: rtl8188eu: remove unused rtw_get_oper_bw()
Date:   Wed, 25 Jul 2018 21:37:57 +0200
Message-Id: <20180725193758.1219-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725193758.1219-1-straube.linux@gmail.com>
References: <20180725193758.1219-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_get_oper_bw() is never used, so remove it.
Discovered by cppcheck.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c   | 5 -----
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 474aa9dcf39d..ab97fcdd6481 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -298,11 +298,6 @@ inline void rtw_set_oper_ch(struct adapter *adapter, u8 ch)
 	adapter->mlmeextpriv.oper_channel = ch;
 }
 
-inline u8 rtw_get_oper_bw(struct adapter *adapter)
-{
-	return adapter->mlmeextpriv.oper_bwmode;
-}
-
 inline void rtw_set_oper_bw(struct adapter *adapter, u8 bw)
 {
 	adapter->mlmeextpriv.oper_bwmode = bw;
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 43a3c5009ad0..50051a1b0655 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -470,7 +470,6 @@ void Set_MSR(struct adapter *padapter, u8 type);
 
 u8 rtw_get_oper_ch(struct adapter *adapter);
 void rtw_set_oper_ch(struct adapter *adapter, u8 ch);
-u8 rtw_get_oper_bw(struct adapter *adapter);
 void rtw_set_oper_bw(struct adapter *adapter, u8 bw);
 u8 rtw_get_oper_choffset(struct adapter *adapter);
 void rtw_set_oper_choffset(struct adapter *adapter, u8 offset);
-- 
2.18.0

