Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744AEECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D58820890
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvbbSQpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D58820890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeGNNMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 09:12:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45900 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeGNNMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 09:12:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id i20-v6so13566343eds.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PeT31eBZNm/KkYDhsG8gyeay4UG4yaI91wSfr4X1xBs=;
        b=UvbbSQpUURvDmDgQtVQyVcuMwbubHIOePSOU6eyJUtXeXuBjTFk2ssk4IRU9Sr+zP/
         MF7m5H/W0gAvmSNkZJAjAeWOiiFnt5dPH0BqljkHCbnYWfvj0OO5XS/WXs5o4k4lUxmj
         oFRpwRoCaxt6vMLXlYQgJJuKsXRs4wVjbTQx58RPWNRkh7W3LrBqPWTWJ2oGq1yJmzmg
         6IySMyIHTPEiawIsZ8/rlXHlLEDAO0+R1ADZM9FKbd7g9cGlaF/Lxwqe5I+cMRScGaqT
         zGUjcJjx/FC9++qrODWdIIFHCDhWlEf+YLKAlEchfWvdWrrBdNjokuwmYcZyq3Wt+2uR
         WDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PeT31eBZNm/KkYDhsG8gyeay4UG4yaI91wSfr4X1xBs=;
        b=tv8yb+/T9BKjNQmf75p0euHIRjAH/24ri3bmBrbaKGXlpaJr+mKCKmN8jV7KQmkojd
         o768t4QKaV/1hYGTiN6FT1qm5FH8I4GUukd7vwS2ivNlA2cMF81n2GjPbdTLj/FDz8ER
         HmnYwSeQ2Zy32/LhuAns59iXk4A0yifpThx809GcNkrt7qb8TXcXl7J+WbJ39qCRy7n1
         8drJ29RDRfWxpJFDlMyCu9iKgYaFz8G6eEfcHbYLe3rdPqcMjml+yc4xbishj9Z9kqBg
         1Z3Q5JpPgzF+C2fb4VF1s4dkcYjhKRoTesXBWM/1dMomCcVEtOl6oTioIMNMwbd9DIiG
         CJFQ==
X-Gm-Message-State: AOUpUlE2MWvTByH3bg0D6FklgXB22m/XyYudx3Ir8nzBwtWt4EwwHClO
        oXXJzUh0aL/jXKEnvkQ2tJI=
X-Google-Smtp-Source: AAOMgpfZJ8jhkuaFsqEZnn8YxAoGp4X6FV3U+RHbHjFmIZ8ehiegMuov+OX++iThs3pJ7qHLVgHZkw==
X-Received: by 2002:a50:976d:: with SMTP id d42-v6mr10593683edb.153.1531572786372;
        Sat, 14 Jul 2018 05:53:06 -0700 (PDT)
Received: from arch.localdomain (x4db2bd54.dyn.telefonica.de. [77.178.189.84])
        by smtp.gmail.com with ESMTPSA id n10-v6sm16577396edr.59.2018.07.14.05.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 05:53:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/6] staging: rtl8188eu: do not line break function definition
Date:   Sat, 14 Jul 2018 14:52:36 +0200
Message-Id: <20180714125241.15509-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not line break function definition of Efuse_PowerSwitch().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 3ac3dd796ec9..367cb2cf8ad1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -29,10 +29,7 @@ enum{
  *				and disable LDO 2.5V.
  */
 
-void Efuse_PowerSwitch(
-		struct adapter *pAdapter,
-		u8 bWrite,
-		u8 PwrState)
+void Efuse_PowerSwitch(struct adapter *pAdapter, u8 bWrite, u8 PwrState)
 {
 	u8 tempval;
 	u16	tmpV16;
-- 
2.18.0

