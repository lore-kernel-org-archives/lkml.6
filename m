Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53651C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0398E208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo3y8YNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0398E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbeGaNOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:14:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38407 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732177AbeGaNOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:14:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so2753627wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vaActZtHgB//vz1E8JbfgbXbhGUZKzGQWZ64+DGjbPI=;
        b=Oo3y8YNf2jyXGNO+rvI7jMVnjuxTSq+uCSIBFoV37K8IRG8J0v9X8sWqN7qvx6E72A
         847CEM+ee7aS9hWfquHWFXlHe/UTPrpE4r2RTaio6obOExAYyUOFgEAiak+tJWIkR69k
         MTs7XQuBf/zPUupKx+GJq0XR7yXglpYBLoFdeFD8luNryY+oZep0+72zTkEdBgP4g235
         y+EYVk+SSV2uruH9+fwrHaUrN0otwYvs/8NBD0SAF5Uns+r6TT2VC2agguKQoehR86BH
         MhDF0ycs39mi+xaE0ihDuy0Rh9QSo4jqXXnHx9/7qakzDDikCGdYoE16bxc8HCY1z7mB
         FVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vaActZtHgB//vz1E8JbfgbXbhGUZKzGQWZ64+DGjbPI=;
        b=R45vc7A1rPq1UOkgCmdD/mPC0aoLYdXX9MMxWit6WtzcP96qy9aZewcwJnTKPFu7ud
         9lvAyhqChEGV8R+iVMLGF301dbWZm71l8j8sxFy1A9o0TenSacMuhyJsTtkrfo1zIlOs
         NIrk+mzPWpF9JPd3Z3lZcC1Bdown1WT6tBNI6KZJaQyanRDsLTPsfgtu2J33wBK4Cni6
         f3arWjWCMJm5B9Cj4ueoynwnMq05Tn02W1LdakgNNYzodLW4510H4kH5e5D1pSgwFO+U
         d3xzev+2iBr4IagUcCrhrD73fBpMmD7IViVrbukja/XTY96vxm7tFd7YCqYVA7KDt9PJ
         6k+g==
X-Gm-Message-State: AOUpUlH0MebO5xIVB9u41BRhgiwAH3kPQrvRN++7BCJLXn8+DYpnwrHZ
        V11/JdXHFMSX9c/ygUkq4hvlQI36
X-Google-Smtp-Source: AAOMgpcQjZV7ps7TV0JD9JwuaBVKHw2ICOJOduQLoThiKDbi2KGe+Z5HmgTgY96N3ClArchRkEWyZA==
X-Received: by 2002:a1c:93d3:: with SMTP id v202-v6mr2049343wmd.57.1533036876464;
        Tue, 31 Jul 2018 04:34:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id f17-v6sm16513137wrs.1.2018.07.31.04.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 04:34:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/7] staging: rtl8188eu: rename odm_RTL8188E - style
Date:   Tue, 31 Jul 2018 13:34:15 +0200
Message-Id: <20180731113415.1500-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731113415.1500-1-straube.linux@gmail.com>
References: <20180731113415.1500-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename source and header file to avoid CamelCase.
odm_RTL8188E.c -> odm_rtl8188e.c
odm_RTL8188E.h -> odm_rtl8188e.h

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/Makefile                              | 2 +-
 .../staging/rtl8188eu/hal/{odm_RTL8188E.c => odm_rtl8188e.c}    | 0
 drivers/staging/rtl8188eu/include/odm_precomp.h                 | 2 +-
 .../rtl8188eu/include/{odm_RTL8188E.h => odm_rtl8188e.h}        | 0
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/staging/rtl8188eu/hal/{odm_RTL8188E.c => odm_rtl8188e.c} (100%)
 rename drivers/staging/rtl8188eu/include/{odm_RTL8188E.h => odm_rtl8188e.h} (100%)

diff --git a/drivers/staging/rtl8188eu/Makefile b/drivers/staging/rtl8188eu/Makefile
index aa6ea65d05fe..4e606b03ec03 100644
--- a/drivers/staging/rtl8188eu/Makefile
+++ b/drivers/staging/rtl8188eu/Makefile
@@ -29,7 +29,7 @@ r8188eu-y :=				\
 		hal/hal_com.o		\
 		hal/odm.o		\
 		hal/odm_HWConfig.o	\
-		hal/odm_RTL8188E.o	\
+		hal/odm_rtl8188e.o	\
 		hal/rtl8188e_cmd.o	\
 		hal/rtl8188e_dm.o	\
 		hal/rtl8188e_hal_init.o	\
diff --git a/drivers/staging/rtl8188eu/hal/odm_RTL8188E.c b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
similarity index 100%
rename from drivers/staging/rtl8188eu/hal/odm_RTL8188E.c
rename to drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
diff --git a/drivers/staging/rtl8188eu/include/odm_precomp.h b/drivers/staging/rtl8188eu/include/odm_precomp.h
index f00967fd9599..4d0dd12645bd 100644
--- a/drivers/staging/rtl8188eu/include/odm_precomp.h
+++ b/drivers/staging/rtl8188eu/include/odm_precomp.h
@@ -31,7 +31,7 @@
 
 #include "odm_reg.h"
 
-#include "odm_RTL8188E.h"
+#include "odm_rtl8188e.h"
 
 void odm_CmnInfoHook_Debug(struct odm_dm_struct *pDM_Odm);
 void odm_CmnInfoInit_Debug(struct odm_dm_struct *pDM_Odm);
diff --git a/drivers/staging/rtl8188eu/include/odm_RTL8188E.h b/drivers/staging/rtl8188eu/include/odm_rtl8188e.h
similarity index 100%
rename from drivers/staging/rtl8188eu/include/odm_RTL8188E.h
rename to drivers/staging/rtl8188eu/include/odm_rtl8188e.h
-- 
2.18.0

