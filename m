Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178B1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF734218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diC6X9P5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeLRSfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:35:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33225 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeLRSfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so7788780wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TLvbAJwsL1SGaa5sLoL5l2AUwM5lz24/baawCNaliHo=;
        b=diC6X9P5LXcqOW0UrmUsjUPK+SLTxP79Jinmlh0MHFpLAvEzCus+HzJY+38x1S4rk3
         8F6a14J0ebOW9clxKe8OBOHgAaaRA2N6EzevwtwJHQhpBfqN26FTosuiJS1ytilo350k
         r2TfEovckfDHjjJmOSQhbuWl7VISrHgXtQSfr8D8Nx+1bvOufUL7fTZCjk3qdxcDJnuk
         DeryM+tIHp5kQED4xtVgeVtJT2qUcRL6ReDXRqmetVddz3K2nf0xvhS0C3UIvlKuU2vA
         6doWa8eOeuanMkTx6MYC9D5jtVDjnZJgex7ejaS4EFzuzilCNtvQw9uvrc6xakaZxU6W
         aIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TLvbAJwsL1SGaa5sLoL5l2AUwM5lz24/baawCNaliHo=;
        b=YZ2Sk+IWaQEhjDKhCjtQwyOtmItYXUHmu8N0TxWLcG+brFnqFNs3daTR/42QYfRh8k
         1r7bgstqiYgiWzrpUgeKmxoGq6rFGKl3sudwKPfLMbt6iz6PTaC/ayszUzeZzPcqpPcs
         D/fu1NEccwaAq/hBvod7h8y9yAfZaFnu3d1lyReEzniJgrmG9gUXE1gkgqnftK9PldRt
         U95OBB+wy07xJmDdF0BWoSpHT1TKaboO9CFcnHOqGG7xksRgVIv4DAgOTODBiaXjqiND
         m7YAuHz5HvejrbL8SxIGjVz4V6jh/Cw1Kebb8c+pnEpLPDwy+1g4Y1ZiQIACs5DOElyb
         wefA==
X-Gm-Message-State: AA+aEWbJzMsbomDcELflw4QUDgvcIOqxJUJ3ToYDwiyXp5qT95oc9CN3
        gbOwX7xdalRaNCqxqSmm8lU=
X-Google-Smtp-Source: AFSGD/XjdeKl06Wr/gE9uzwfeG6LxCPmS1VAXl9xZGJ1la0aAXeWJoO13kBDbfvBq8AQ7f0VamRnlQ==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr4254534wmc.138.1545158116565;
        Tue, 18 Dec 2018 10:35:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:15 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 09/17] staging: rtl8188eu: remove redundant declaration in rtw_mlme_ext.c
Date:   Tue, 18 Dec 2018 19:34:43 +0100
Message-Id: <20181218183451.18692-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The array REALTEK_96B_IE is already declared in rtw_mlme.h,
so remove the declaration in rtw_mlme_ext.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index ca818887cbc6..30ebec6c32be 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -32,8 +32,6 @@ unsigned char WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 unsigned char WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
 unsigned char RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};
 
-extern unsigned char REALTEK_96B_IE[];
-
 /********************************************************
 MCS rate definitions
 *********************************************************/
-- 
2.20.1

