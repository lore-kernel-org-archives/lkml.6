Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EE4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB65820864
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BEJT5Hoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB65820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeGUWkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 18:40:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33374 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbeGUWkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 18:40:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id u14-v6so3985996lfu.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 14:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RhQTP/e/DcOTc3xFyu/54r0ruORcNYJLBtZlqSp+B8s=;
        b=BEJT5Hohu9Z4Dn7idV2io0VwcjUeq5uz/uysvji6lnFycw1Uwz1U4/866AM3VG0M4K
         J6UFt/Rcejq0n9UcejjfC7Hr5kNtYO6aIAyzF7MlkbtXxGvWRFos907dObRzeuxTHQjP
         2li/pK/IRMeW6kF8ppqYGjVNMKJir/n8kKno8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RhQTP/e/DcOTc3xFyu/54r0ruORcNYJLBtZlqSp+B8s=;
        b=uDeKZ+kuDYjZDmacHiGsjcNwiqpAlJp/xecwaumJRiI/7mnlIZy6PN2p/NIFjbCLqz
         gZyKQM+26kDpSizjKRHl/98CTnTHEfojk8ZquEMJYOUusCvEYjZE8v6y+vkGma7Q/3OF
         k9PPI6Pqml/b5AzGkvh1OwSf364VDWy//NrSfNf6m6exlO+MscIq/aBp4vB6NES15Fak
         RSmuY1EzAF5paHML31CThB7yLPWm6SrkoC/PJpNDcye2T3i5VwFPDtOu2Pu86sqYMYQA
         R72/KFILit4UdGp7HxfA03RyxW/6r6pg/wyyK3+Q5bmGnvnhUGFVC2tGKuV3KShQNxKl
         dPZw==
X-Gm-Message-State: AOUpUlE5kDXcA1buir6I/8PLC+sz08w4CrDZUqZLxkqCvEPziy5QNsAF
        sWEi2a6EzlXJV74U9jkEGe2upg==
X-Google-Smtp-Source: AAOMgpcd6Nkzou5rJnhtprKjqg0EzlkvX28/KS2Rk2rCDffyxC3HrdLyPkM84RlxjdGOc38g8tlqOA==
X-Received: by 2002:a19:9cca:: with SMTP id f193-v6mr4005314lfe.60.1532209561945;
        Sat, 21 Jul 2018 14:46:01 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id i125-v6sm794432lfg.25.2018.07.21.14.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 14:46:01 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] drivers/pci/probe: Move variable bridge inside ifdef
Date:   Sat, 21 Jul 2018 23:45:56 +0200
Message-Id: <20180721214556.25651-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PCI_QUIRKS isn't enabled we get the warning below:
drivers/pci/probe.c: In function ‘pci_bus_read_dev_vendor_id’:
drivers/pci/probe.c:2221:18: warning: unused variable ‘bridge’ [-Wunused-variable]
  struct pci_dev *bridge = bus->self;
                  ^~~~~~

Move the declaration of variable bridge to inside the ifdef
CONFIG_PCI_QUIRKS.

Fixes: ac5ea104a279 ("PCI: Workaround IDT switch ACS Source Validation erratum")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1c581346c5b9..7a5323798312 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2218,9 +2218,9 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 				int timeout)
 {
+#ifdef CONFIG_PCI_QUIRKS
 	struct pci_dev *bridge = bus->self;
 
-#ifdef CONFIG_PCI_QUIRKS
 	/*
 	 * Certain IDT switches have an issue where they improperly trigger
 	 * ACS Source Validation errors on completions for config reads.
-- 
2.18.0

