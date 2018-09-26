Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB4DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996662083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKADOI2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996662083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeIZOot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:44:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43776 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeIZOot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:44:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so2940598plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xILCKLGDFjBBorarrUyjhtvIupooeyobvhfedOgKiyw=;
        b=eKADOI2i6nQICaHFJh3wmyCW+X+ZHYMLQaRN3PDajAUf6fPpb0Mtm2d1gWZx19RkoJ
         DsXhnuLL7njhs9H2WZbPtggcWsDcTHKoh+T53trD+5yozNttKdhwxRcI16VlRz7cstzw
         iIfmtT2DGc7uIT07IGvmfePn1ntx8sy7DmlRG6EPRjKPz0Yk1A5cfUYrOFvHoUhTk5S7
         0IC3lHPQxjP29QZocR95TNOhxwOt/4ZAB3uC6B6S8+NnYlMq4Bn5MEfvi8K2C7QbbeCM
         kiMSHZVRZAyS22nkzM8WyxEPhTw27NOvDYt1fhrxGzRdxPDMoubhcZmL7wwqp3QJYAqP
         d2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xILCKLGDFjBBorarrUyjhtvIupooeyobvhfedOgKiyw=;
        b=s2LI5MU0wuQ3c76pE+xp8z/ve61/3iumgjIyerZw/iRGy6VcbWLlQJGj0fIwrEvVTk
         LrVRGbDxqA05tMk2pi24tw/30UVDPtmJeU9QBXGpzfOmtjMMYDmEIt2PdZm47h6jUh7v
         aohM+y7EXjNDAJXVbdGo6ZO8v5bW5Xgy5ThixD/utGA1p7cxEbPvpREqpeEwXjDTKyo0
         4itpTJ3LclISQDNVV8/aj9PLE7bkuF/jZTU8fy7OOl//qrC8QOkWoRf/nNqLC156dKCz
         VxkJ9ELmxiaxs7v/LW2DINIyjf9Czg9/9reig3Egs81W45clQXXdzrIPbVP6jE8O8GM4
         +xSQ==
X-Gm-Message-State: ABuFfoiAeAI3/YOnElmZG51TZeFQkY87LoUtWiw4Ka+805VGhnINoyBZ
        GnXXNDsQpbHFHedeUJgRZac=
X-Google-Smtp-Source: ACcGV63mbL34umtDMJrqtvm67IJYgUXLwpTOdCowKFQDok+Q5wZK66EtkFlM+v0JYkbXA6yBHBpGjA==
X-Received: by 2002:a17:902:5e3:: with SMTP id f90-v6mr5088400plf.286.1537950781300;
        Wed, 26 Sep 2018 01:33:01 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id f15-v6sm5530764pgv.66.2018.09.26.01.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 01:33:00 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com, vincentc@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v2 2/5] RISC-V: Use swiotlb on RV64 only
Date:   Wed, 26 Sep 2018 16:31:11 +0800
Message-Id: <b9b943c21725db9822a787a1e985010012fc33b2.1537949825.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1537949825.git.zongbox@gmail.com>
References: <cover.1537949825.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only RV64 supports swiotlb.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index aee6031..872a280 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -227,7 +227,10 @@ void __init setup_arch(char **cmdline_p)
 	setup_bootmem();
 	paging_init();
 	unflatten_device_tree();
+
+#ifdef CONFIG_64bit
 	swiotlb_init(1);
+#endif
 
 #ifdef CONFIG_SMP
 	setup_smp();
-- 
2.7.4

