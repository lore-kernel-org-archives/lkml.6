Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F307ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6C92075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mBWEcuER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6C92075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbeGRBYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:24:25 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35363 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbeGRBYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:24:25 -0400
Received: by mail-it0-f66.google.com with SMTP id q20-v6so1800721ith.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 17:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bM3W6AOZgZW+t4m8CxthwGZ3FkiPNgsBFi6fJY73FEA=;
        b=mBWEcuERx7wVUcoKDycSakTczwWv14gimgR/jmIDHQYVBtJcWcOZTfAqXen2iGwc2W
         /OEeJMg5KUmf0ElcTr0rij7SgduLQ3bK3is2Lkac6Q5Bmsyjpxw8gTDvzE0BZt3ufhDq
         SwKydMhTRAj3XEi/WA3Lz0unqyQCU4kyIgd0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bM3W6AOZgZW+t4m8CxthwGZ3FkiPNgsBFi6fJY73FEA=;
        b=Va5xamJo4xblh14JxVcIRmFu2z3zwbk3IFY122lCmfQpYTS8IfMtXwp6pQlAWQ+5fR
         EdfkDNq2+pyu1P9RHG7YwM8v9kc9fSgdTrabg6KFH54AuEr39IgFS69ml1SDX7ierv16
         UzHBQxt3nAKhiRrNaJJNE5SDvOzZDIfkDQUWVNVTkQlzAsB+RVAaHSLe0IL/pgzFxY0Q
         Miq60duCltHuHVjAuk2jLONt+unyQSbC0YXACONddjeM07trcJMJBkWc7bW+Z1msIkoG
         nbWXdYPO93mhiTpXToLSelphgf47tkrPMz66O+nIa1dc+LwDLri80KIFsBC16z5nfKWO
         e9ng==
X-Gm-Message-State: AOUpUlF0FR/AxdiNRBQtiEHFAaASkX91Go/khJi97iyPVR7ZR30wLNYn
        UvILOCls/leXm0zcxqTAyZfE8u52HQg=
X-Google-Smtp-Source: AAOMgpeNzhMZ4HQBLhTGORfibmWcLBJSqBAa9dX1xIFv4TGrrYdNQo/hZMtnT4objtTDdbjgbbyMoA==
X-Received: by 2002:a24:f949:: with SMTP id l70-v6mr331071ith.66.1531874953500;
        Tue, 17 Jul 2018 17:49:13 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id z71-v6sm3275425ioz.34.2018.07.17.17.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 17:49:13 -0700 (PDT)
From:   Daniel Kurtz <djkurtz@chromium.org>
Cc:     Dylan Reid <dgreid@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR
        FRAMEWORK)
Subject: [PATCH 1/2] regulator: allow drivers in modules to register fixed regulators
Date:   Tue, 17 Jul 2018 18:49:08 -0600
Message-Id: <20180718004909.213735-2-djkurtz@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180718004909.213735-1-djkurtz@chromium.org>
References: <20180718004909.213735-1-djkurtz@chromium.org>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sound machine drivers tend to live in modules. Sometimes such a machine
driver needs to register a fixed regulator to provide to a codec.

Export regulator_register_always_on() such that this is possible.

Change-Id: I2906f96df278b5fa65d40d3a777bf6d3d91841d2
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/regulator/fixed-helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/fixed-helper.c b/drivers/regulator/fixed-helper.c
index 777fac6fb4cb0a..f53fbda043f525 100644
--- a/drivers/regulator/fixed-helper.c
+++ b/drivers/regulator/fixed-helper.c
@@ -60,3 +60,4 @@ struct platform_device *regulator_register_always_on(int id, const char *name,
 
 	return &data->pdev;
 }
+EXPORT_SYMBOL_GPL(regulator_register_always_on);
-- 
2.18.0.203.gfac676dfb9-goog

