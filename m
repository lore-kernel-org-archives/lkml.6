Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20BAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6869A22503
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="Q3IQm3rP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6869A22503
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbeKMCzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:55:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40718 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeKMCzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:55:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so1010965wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 09:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gwiH4XNPeedEWQwSD3oXt7LL0JMYqmj9B9mAwTpqeMc=;
        b=Q3IQm3rPlBp8TVUba6mYr/QIDE+TfijiIEfa4+ZBane96TTiFIrUKDhxHMWPCDuVLv
         l2MywuL29YxDP8oV3ts1/MzfiZBL1kf6zUAmya5ecaZtDDoLJDG+rT0QSDF5uxjhYKzj
         nz2IBE6afxv+GpH5GZj4pOMtuAj+NYm+H4GrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gwiH4XNPeedEWQwSD3oXt7LL0JMYqmj9B9mAwTpqeMc=;
        b=LIqvDJXX4GMKhc1mxuoGHc+Z4d4DY588M0HL4VGEe1GSPBqll63nkLadYHRsPkvEkE
         KPJH2RDuZLIjyrZBpZcCayHqS0XBfyIbuLQPPx2m71I2BHFbtLiIbTE+9cKKRbTnUCEA
         F0omc/PDJqi8bseM+y++2FAynAAl1jEqJU+zKUcXIn++xdg/Zmepfp7yRgsq3iLYLH/n
         nomY7CkGapNL1kVkVpgLzgTP+lBh/5QOLSepmvmo3NuV3/TS3nKZcCc0zhByvfVTAQUR
         eqtFOJFgYuPrN3Y/uDw9nUl+YMtBTECXOgQdAaKrEifgpeHO1MChc/jmGH8kLxIKo18k
         0l3g==
X-Gm-Message-State: AGRZ1gJHB4IsUqFt+xmbVbnNYctYx7oZ6D+TXPwLfGk7t62k+DKihja+
        WMkZ5yPh0bp0HRl0WUce1QPbguIlqEsaVw==
X-Google-Smtp-Source: AJdET5cB5OobM5l1tNop9qMQ0LpNiVUMrU5rxuz9gu1Sc6EPSxFaMv1OOhmFAIZ+eyAs0KpH0ZpLsw==
X-Received: by 2002:adf:b6a8:: with SMTP id j40-v6mr1614696wre.55.1542042067032;
        Mon, 12 Nov 2018 09:01:07 -0800 (PST)
Received: from max-pc.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id u13-v6sm11835344wrn.11.2018.11.12.09.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 09:01:06 -0800 (PST)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Andrii Bordunov <andrew.bordunov@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Maksym Kokhan <maksym.kokhan@globallogic.com>
Subject: [PATCH v2 1/2] mips: delete duplicated BUILTIN_DTB and LIBFDT configs
Date:   Mon, 12 Nov 2018 19:00:58 +0200
Message-Id: <20181112170059.7199-1-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BUILTIN_DTB and CONFIG_LIBFDT selection is duplicated
in menu "Machine selection" under MIPS_MALTA.

Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>
---
 arch/mips/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8272ea4c7264..fe4c28275271 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -539,8 +539,6 @@ config MIPS_MALTA
 	select USE_OF
 	select LIBFDT
 	select ZONE_DMA32 if 64BIT
-	select BUILTIN_DTB
-	select LIBFDT
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
-- 
2.19.1

