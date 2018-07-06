Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72C2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A010321A0E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/g6ygj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A010321A0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933139AbeGFO4S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:56:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35131 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932718AbeGFO4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:56:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id b10-v6so8869715edi.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GttLIemeI2nPurE2NXR1+et1rzsGkcmdqctI+f3shNY=;
        b=J/g6ygj0FjV/r0n4qgrsuORsWU7ttUUCfUqRVQf9qFLz49BQZuL01yR33XWvQSeZd3
         pGa/sQB/lUr2kfxRT+nSEb7DCvR73kR6P4g0hEb6I+QVhEaKtI7DlhWjxAW/NEOAo6Xn
         4QoMKWa7JAZ7bBF2iLUWbBru5LObl6jgynvYWBsQQ8SBeLr72UAlm+QJ1SVQiIqoDheu
         cbAmmdECPeY1IA1f3Bo7VDqFe6ayjWcyoYfsJUlLBL6wg+cgeJXqmm/gzyLb8ymoFnYv
         3c8oyfGzp62jcudTBvm4xYjYe20iC+r51MhLjcgzfcyBaSzG51WE5LbT9lQ2K065jl4S
         RM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GttLIemeI2nPurE2NXR1+et1rzsGkcmdqctI+f3shNY=;
        b=VOGrtLdP0EoR1QHaTivivqNmmc9wX4urDWe+Nsp8HXihKoa9SvCDKKXz/pDCJFoQEN
         m4v9j72Y2HKmLRyunV4OzawVwU56r0+DUh/VE70AQ6QH9+cZgWWeM2GzScLhaARQh7xK
         JsNk/0dCEU0pOy6IGPext/uts9tBDJt+d5k6oqGSqsPp05Km7ZKYq8qRbyM1JUqtCN1e
         iZp/YLNkoKZRBz0ccF9wWtIy1kAyJsmaQ99iDUOI2l9RjPi5BodkfWS69swgJs1I0lJR
         uJMlqFHXTzjvSy6DOg64sLQ47dmTr3Y40eCvFhAroSab5j4qFLulvCVu/vrjvJeNvpBr
         +aAw==
X-Gm-Message-State: APt69E25TEFhbgIKYGr01NmyzcoYfFZk2yLP97PV7VriahWW28b4Nbo5
        zPuggdLrAj0/iGzvJH9xQoU=
X-Google-Smtp-Source: AAOMgpeYnEWVzzvpKkQ7nDH9yZNBaO7EGdyWitLRS9V7vhbn1bQCEBItB5t9pO6aqmHyTnjhLkXKQw==
X-Received: by 2002:a50:8607:: with SMTP id o7-v6mr10949219edo.243.1530888976062;
        Fri, 06 Jul 2018 07:56:16 -0700 (PDT)
Received: from arch.localdomain (x590d0918.dyn.telefonica.de. [89.13.9.24])
        by smtp.gmail.com with ESMTPSA id r26-v6sm2746238edb.25.2018.07.06.07.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 07:56:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove rtl8192c_rf.h
Date:   Fri,  6 Jul 2018 16:56:01 +0200
Message-Id: <20180706145601.9770-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All functions declared in rtl8192c_rf.h have no definition/are not used
in any other file/anywhere. Checked with 'git grep <function_name>'.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/include/rtl8192c_rf.h   | 28 -------------------
 .../staging/rtl8723bs/include/rtl8723b_rf.h   |  1 -
 2 files changed, 29 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/rtl8192c_rf.h

diff --git a/drivers/staging/rtl8723bs/include/rtl8192c_rf.h b/drivers/staging/rtl8723bs/include/rtl8192c_rf.h
deleted file mode 100644
index ad684add8dd6..000000000000
--- a/drivers/staging/rtl8723bs/include/rtl8192c_rf.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef _RTL8192C_RF_H_
-#define _RTL8192C_RF_H_
-
-
-/*  */
-/*  RF RL6052 Series API */
-/*  */
-void rtl8192c_RF_ChangeTxPath(struct adapter *Adapter,
-			      u16 DataRate);
-void rtl8192c_PHY_RF6052SetBandwidth(struct adapter *Adapter,
-				     enum CHANNEL_WIDTH Bandwidth);
-void rtl8192c_PHY_RF6052SetCckTxPower(struct adapter *Adapter,
-				      u8 *pPowerlevel);
-void rtl8192c_PHY_RF6052SetOFDMTxPower(struct adapter *Adapter,
-				       u8 *pPowerLevel,
-				       u8 Channel);
-int PHY_RF6052_Config8192C(struct adapter *Adapter);
-
-/*--------------------------Exported Function prototype---------------------*/
-
-
-#endif/* End of HalRf.h */
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_rf.h b/drivers/staging/rtl8723bs/include/rtl8723b_rf.h
index 1c16183caf9b..987b9f12a4f4 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_rf.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_rf.h
@@ -7,7 +7,6 @@
 #ifndef __RTL8723B_RF_H__
 #define __RTL8723B_RF_H__
 
-#include "rtl8192c_rf.h"
 
 int	PHY_RF6052_Config8723B(struct adapter *Adapter	);
 
-- 
2.18.0

