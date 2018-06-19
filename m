Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CDBC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25A920661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25A920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967284AbeFSVli (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:41:38 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:46142 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755490AbeFSVlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:41:37 -0400
Received: by mail-yw0-f196.google.com with SMTP id v197-v6so433359ywc.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KBDgrFD+UKT4o/0FIiF9qSMpuwUhTvwU/R2u1sd9GSY=;
        b=HbZQFJEYRvvHN9SkG79KZ9r+Mg8buNiFmaPV4Ez6V4DmWIcF4iWP//7tqpx98i3VhD
         sXXP+MWFsIa9+HveUaa4pQX85xXgJ6hfYTFWjOzESrvx4EBKvfUKGN9V/kKdFEsuXTIy
         nfvOzSdazc//4bfU95sZEt/aqExmlslar1SOmlC/m0JvMFIwvvYvoSSTXcMhZU5Eo1Yp
         Yv+cfmuoOlUqr/1F4cJWQpyUJLA9Bf/nPyX30PdcUN5jP7Z5Cau18W4FdbwWfxMWLnBy
         2iXU9kTIkjDtjcYWi5jm93Oi9HS1M0knt8RGIXHt3YWIHbu2372WLzS5tDydCI4FoQGS
         xO+w==
X-Gm-Message-State: APt69E1MZGyCvu+fOn97rIzsIZhX0Q7uprAO2Z6t8HR1QEX9AfxwhlOs
        scF4R3VUTgB3LD1PKCc1AQ==
X-Google-Smtp-Source: ADUXVKJ7bYqPaymeaRmw2/KtLAXoJa6j3L/7wzH15MQ4TmoS+0z4vU1awQDOLlL6gvIDG82QiQdLEA==
X-Received: by 2002:a81:af55:: with SMTP id x21-v6mr8838308ywj.428.1529444496272;
        Tue, 19 Jun 2018 14:41:36 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id z123-v6sm291281ywd.85.2018.06.19.14.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:41:35 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: remove unnecessary of_platform_populate call
Date:   Tue, 19 Jun 2018 15:41:34 -0600
Message-Id: <20180619214134.20130-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT core will call of_platform_default_populate, so it is not
necessary for arch specific code to call it unless there are custom
match entries, auxdata or parent device. Neither of those apply here, so
remove the call.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/riscv/kernel/setup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index ee44a48faf79..f0d2070866d4 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -220,8 +220,3 @@ void __init setup_arch(char **cmdline_p)
 	riscv_fill_hwcap();
 }
 
-static int __init riscv_device_init(void)
-{
-	return of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-subsys_initcall_sync(riscv_device_init);
-- 
2.17.1

