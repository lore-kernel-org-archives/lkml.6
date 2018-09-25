Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95790C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207BA20843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=sehro.org header.i=@sehro.org header.b="brAdF1KQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207BA20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sehro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeIYM0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:26:17 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54577 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeIYM0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:26:16 -0400
Received: by mail-it1-f196.google.com with SMTP id f14-v6so13952693ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 23:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sehro.org; s=dotorg;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=db7qewj4tmPHpiTNm8smKskfztQrVxr5sDRgW3D8BAQ=;
        b=brAdF1KQMWn1VzhEpBeIgx0CR9+PAz/k9reYdm05nG/Cq1lZoQ/UKiGeHg8lww1AJF
         PDkzCqaF9YTTzLNTlLbxEToh8ANNU+VME9KNzMg8l8dN1HHIal6eQYDB95SSZ337iR/v
         +aeT7pqN/M/hQyD0WyNfzo0U1ypFaJgaKaUmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=db7qewj4tmPHpiTNm8smKskfztQrVxr5sDRgW3D8BAQ=;
        b=XmydRBAV1L5O4OXLiSfGen92CWjlVo3y9/18IgLBa0JW21wtNqg27rQzZlYcKC2DI+
         WVqcwPbkpSY9ZpT4Wwk+GnixzTcNKrtd4JdrGmBTaZgLfh1MehqDhHVJtYYlISBglf7z
         9ogS1+/77VM3h8FRfraFHLukkvUNDfJoP6auuiLRiiLDV+OjMC8kU4MNuAPHeC/W7T7L
         EDBfQF9jxq1JYOAsMDG8pNOqOiBZe4Z5SEjMXhxwt4SUO2rjIyZkInJbysiRgrkT1Vvf
         RHzgqwh5hoBefCsAiGNOE++zpMkwRHJsJWlEutZ9N1ZeeDIjD8Bn4oyVRN/xK4T6yjbN
         VqAg==
X-Gm-Message-State: ABuFfohuDXzgFHPof57U0pYrDK2djps7FY8lVZYLMMQKQ5iAue6pKtCu
        xR0ciDqoQgSUovLGr2Zm0byPHQ==
X-Google-Smtp-Source: ACcGV61wWcxdnLf8YbXYOU31V/2HhknF5iOoiJD2uEumKHoesyeVtBjiikArHDGk1sXHzG7pdD5K5w==
X-Received: by 2002:a02:982:: with SMTP id 2-v6mr2086172jam.78.1537856418632;
        Mon, 24 Sep 2018 23:20:18 -0700 (PDT)
Received: from goro.horizons.sehro.org ([2601:280:4400:56c:731e:1a85:7df8:2d5b])
        by smtp.gmail.com with ESMTPSA id w126-v6sm572182ith.40.2018.09.24.23.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 23:20:17 -0700 (PDT)
From:   sehro rautenkranz <sehro@sehro.org>
To:     lidza-louina@gmail.com
Cc:     markh@compro.net, driverdev-devel@linuxdriverproject.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        sehro rautenkranz <sehro@sehro.org>
Subject: [PATCH] staging: dgnc: Fix Kconfig help header and text
Date:   Tue, 25 Sep 2018 00:20:01 -0600
Message-Id: <20180925062001.12273-1-sehro@sehro.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace Kconfig help header and text to match other modules. Issue found
by checkpatch.

Signed-off-by: sehro rautenkranz <sehro@sehro.org>
---
 drivers/staging/dgnc/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/dgnc/Kconfig b/drivers/staging/dgnc/Kconfig
index 032c2a795238..c845b357b53d 100644
--- a/drivers/staging/dgnc/Kconfig
+++ b/drivers/staging/dgnc/Kconfig
@@ -2,5 +2,9 @@ config DGNC
        tristate "Digi Neo and Classic PCI Products"
        default n
        depends on TTY && PCI
-       ---help---
-       Driver for the Digi International Neo and Classic PCI based product line.
+       help
+            Say Y here to enable support for the Digi International Neo and
+            Classic PCI based product line.
+
+            To compile this driver as a module, say M here: the module will be
+            called dgnc
-- 
2.19.0

