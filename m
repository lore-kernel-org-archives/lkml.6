Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48646C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0664C20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFZ79Zf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0664C20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeJBPlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:41:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45066 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbeJBPlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:41:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id y15-v6so656912plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ul55wigUjE4to1TohXKcjf7rrHR2DeP0tn9CFO87rmQ=;
        b=CFZ79Zf5+QQIBEmidjs8YCnEk8VVl5EER/mq2IdYiihjfwOqs8PoUXrLk++YZ5KCTH
         0xK17rZQDNZC2uw1vyK6rjj2iE6h1zayIGilsMGg7ua3pNjWkp2CAz468nPPUmr435U6
         Yv+ctcTJdUqL5m/E0sguEl8s98xRNZgq3ZORkX1FLyKlc9qDLd5Sf2UqtiLGkzqWsW98
         +rK2uhyy/UoDjSdPxYwszBGUQ4tt+NZ5T/v3X4J/KerziPCTK2D5eNG9XYHbUVuplxpy
         djTQC9s07el73yTec6nOrrVEOOnSQQZzcujX490m5tKjBXAsehBdPN0hMvPgQBsjrnfI
         WZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ul55wigUjE4to1TohXKcjf7rrHR2DeP0tn9CFO87rmQ=;
        b=QnvFvgqT2TsB/iEWttBmigg254nCeoozR9gdYMGG0DXcUqdefJ8HpKTTHtlqP3uF3I
         uBRaGw67ASp9hCmjPAEhIOlPGtg0S6fP8a85539MU6LyqkirolHqvPt66ItpYXmrOYOR
         BkKgHFm92lNauiZGqzu0C+V8O99T1xZY69d90lSVFBwMmcceHZICyhN68e5VVIWVHlbb
         dbsSa7O0t29LpQAywJDMIXHhBYqRrvJd12YixcHnjpv05eaAD14HBYbzUrM9CQlrfBLL
         d6Rg3sxcMS803UFqmS9aiHWI9WuOSHkz6jmuDAnfiom19BAgaJI6ore98VGGXd9MWh6x
         Accg==
X-Gm-Message-State: ABuFfog/ZAxn7mtuHEenEsQZ4yAG6VyTB07cExV49Aw/vdZcW+0ZCndg
        luTowOfUTtAQ8dNAFdQWaYavOalTIds=
X-Google-Smtp-Source: ACcGV60V1W4uzTZGH81onWdCT6XeGCO25NucCnwHU3i3nFP6GxsnaxLfMiSaLTyONTvCwSB8y6APYQ==
X-Received: by 2002:a63:fa4e:: with SMTP id g14-v6mr13732739pgk.18.1538470763770;
        Tue, 02 Oct 2018 01:59:23 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id 62-v6sm5057927pgc.58.2018.10.02.01.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 01:59:23 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v3 1/5] RISC-V: Build tishift only on 64-bit
Date:   Tue,  2 Oct 2018 16:52:27 +0800
Message-Id: <40c77db9ee2d23479ff90f2658539d29d7a30896.1538470103.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1538470103.git.zongbox@gmail.com>
References: <cover.1538470103.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only RV64 supports 128 integer size.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/lib/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 445ec84..5739bd0 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -2,6 +2,7 @@ lib-y	+= delay.o
 lib-y	+= memcpy.o
 lib-y	+= memset.o
 lib-y	+= uaccess.o
-lib-y	+= tishift.o
+
+lib-(CONFIG_64BIT) += tishift.o
 
 lib-$(CONFIG_32BIT) += udivdi3.o
-- 
2.7.4

