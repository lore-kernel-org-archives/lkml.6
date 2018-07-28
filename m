Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EFEC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F47F20899
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCkjQvUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F47F20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeG2AnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:43:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43339 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731694AbeG2AnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:43:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so8710641wrv.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XsEOM3WYlBborInlGr0m9vtOOwA+QgE79gd6EbFytIg=;
        b=UCkjQvULgdhPXnIC7h4pDBTYBeCA9Lm4tPoz2Ivcwj0GO3WL4P+jhG10FOyhCMGBiu
         Gkl9aZEpWEddVCGfNjeYRHwet/k1kK21ZHq0lsoYr6dzIzLM2dhvGAPVgm9Li+F2gSb7
         18nfQDlLcRLyE1VChYbR4buosZES10r/88+3uBTVetJdpgom0jS2eC5L/DjLjke9LZTV
         lqupdyh2A+9hMszCHqhl3kLCko7kllM7dbmsFwiZ1jSiwiDb+Zk7EXT1pFlu8BZRROdK
         M8xltDQvT8av5mpo58ce81zT01fEHf5YJFx3m7ThekQ7dprcqM2JbTnTTRhMVpfjSGm3
         mF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XsEOM3WYlBborInlGr0m9vtOOwA+QgE79gd6EbFytIg=;
        b=ew0TCJgMLrFavJRN9ZjjyE9Ca3bEmaFF2beEx5IjG5XRSO87VIciec9GQ/sCRtuqEz
         2/GkBq2NG54rKt253Uk8wZwFFFFxfRWQkcYYXWE4Ly7CsyqHVBDmG48fdi52hYj+CTez
         0b7UkTy74eGR17mI/lBkSxN6MpjiRr97AS5jA5UgIHAjmDdrHiLQrBbjEVL0Igq2Qi7Y
         Y39DoKFF9SrFKWMjm9rqODt9LE15vWsofvDiaqquPPl1ehi2bx8QGYL2c8oxLSXzOG2g
         68fspg3dtHJkKtRy99Qa6jkuO76SmBXiG5vS/vyUzUxHkebdLEDDvZUAm7pjLFIcJOCs
         5sIA==
X-Gm-Message-State: AOUpUlGR+B0yqMpB6TjnbY7IuIRhKI4drzl1dlNfYRuyvrFb2PGjbwS/
        IdDDgQbyVUMTdplbzTUY9Wb+JLeV
X-Google-Smtp-Source: AAOMgpfTf9jKW/rZ0GUf6NYSLjGveXKGP8qNh9scHNehapX/jmGEYqJy0yIXcXqwWPTftDQ1tS+brQ==
X-Received: by 2002:a5d:550a:: with SMTP id b10-v6mr11330297wrv.228.1532819710328;
        Sat, 28 Jul 2018 16:15:10 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id j131-v6sm8909745wmb.25.2018.07.28.16.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:15:09 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 08/08] staging:rtl8192u: Remove unused constants - Style
Date:   Sun, 29 Jul 2018 00:14:52 +0100
Message-Id: <20180728231452.20107-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728231452.20107-1-johnfwhitmore@gmail.com>
References: <20180728231452.20107-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove defined constants from code, since they are never actually
used in code. This is a simple coding style change which should have
no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 17b676b0ed8b..810d81addcf6 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -2,13 +2,6 @@
 #ifndef __INC_QOS_TYPE_H
 #define __INC_QOS_TYPE_H
 
-#define	MAX_WMMELE_LENGTH	64
-
-#define AC_PARAM_SIZE	4
-#define WMM_PARAM_ELE_BODY_LEN	18
-
-#define WMM_PARAM_ELEMENT_SIZE	(8 + (4 * AC_PARAM_SIZE))
-
 //
 // ACI/AIFSN Field.
 // Ref: WMM spec 2.2.2: WME Parameter Element, p.12.
-- 
2.18.0

