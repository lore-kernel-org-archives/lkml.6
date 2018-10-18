Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0017FC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1468208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxcsho/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1468208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeJSDz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:55:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39743 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeJSDz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:55:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id y144-v6so1506164wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bVg4Oj1RZN3P3J3RyQ03c1fVqC9M7d31lYwEisvIv/0=;
        b=dxcsho/qP9JTRCHS4MDjBhtr6QmQy4rYvYG2bWshfMtK05eoLlCEtxVLo36q90NceN
         f5YgS2H5oG9u5gl76sbK/1uWvpryoqb7TaXvy4fgeY8KtGpyprZIY79VRP633eCKfw7l
         4NdJZp5iW0B3dwtw0pc3KnRwTAP+mQ1P7CBOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bVg4Oj1RZN3P3J3RyQ03c1fVqC9M7d31lYwEisvIv/0=;
        b=oy/tNKfMP1K848P9mZm62q6eTjwQMX32OaH3qQ79kHbDNmbreN/jD2oGR4PtT3KvHz
         XdiDU9K1UOnGvVBxPj3X9Srk6j98G+/eDA12WgIXWw9zwjTE8jEKMKk3zBl56zPy1EhV
         hXJJzfl4tWRedtp76Lw3Ss1DcTXgXKy/TXLevbbo3dlhOmmnnovZbiTzmQ3ByNwNb8cL
         en1222UJtt31UtZHpz0yK3SzXitYtKZTk3Lzqgi3h4hr/PaKskM488n93i9HE5sd/xtT
         pYb7T3uuHO79Fl3Ydk4NXuOHq1QO3SNBIF8bYpobkUaVK+6mzUQJOw3aQAvEBW4SMHg5
         NiUQ==
X-Gm-Message-State: ABuFfogYcNB5+mjfaGip5vKHTQKhc8rTWkbxGUFx7WpfhQlyM/wJ3rLp
        Wn9WS7YDDuyDKyADHEKhxS5CcA==
X-Google-Smtp-Source: ACcGV620xSgbUD0GCBHf41sr8h7TP2SruolxSCFZsM2IoH+DHgt2jazGOvajes/yD73/RiqAre2kww==
X-Received: by 2002:a1c:d4b:: with SMTP id 72-v6mr1890142wmn.102.1539892372474;
        Thu, 18 Oct 2018 12:52:52 -0700 (PDT)
Received: from localhost.localdomain (77.65.136.77.rev.sfr.net. [77.136.65.77])
        by smtp.gmail.com with ESMTPSA id z8-v6sm19011265wrp.63.2018.10.18.12.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 12:52:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 1/2] Linux 4.19-rc8
Date:   Thu, 18 Oct 2018 21:52:18 +0200
Message-Id: <1539892357-16810-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e8b599b..bf3786e 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 4
 PATCHLEVEL = 19
 SUBLEVEL = 0
-EXTRAVERSION = -rc7
+EXTRAVERSION = -rc8
 NAME = Merciless Moray
 
 # *DOCUMENTATION*
-- 
2.7.4

