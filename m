Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8142AC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3976F20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bsT6xS1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3976F20819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbeKFFjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:39:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40554 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730109AbeKFFjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:39:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id q19-v6so1996346pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 12:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+4+xrKqcCnzzEGa97yidlIN9VxNjgsG971WTiE2U09o=;
        b=bsT6xS1eF+TBKCO6uMQSYsGzUdElb/830fFPpNBbg7AmPDQuG+IQx6RYS/7zNMnhc0
         6PU61H8Y5I2yOuM/57zJpzo01b6uPnXUWVLkYN7FS4FJvRqJM2l9nxqSxA7beL9/404x
         HdnenMT/l3Mr9JEeltlEipd4ZQvDUXD4s2LGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+4+xrKqcCnzzEGa97yidlIN9VxNjgsG971WTiE2U09o=;
        b=YEW0nwTKhZhQ2E7rndeH5eNvdgDydIJ2aNlh/VKjQdX+SRd4v9/5oczD8JQfC6vMWw
         FNpu4g+uTSFYaGZpJ5bA9jKTVP6ljOxlIZikZD4B29PZbOqGzKF6NBZIjlpxR4RZlQPg
         wE/fWF5xqgHPF3DsYsArJHAMR8Tljciq5ylbpUMZF4C3ckGfoR0XWOLJGh35QPpl8Y9k
         JSf83hcojjUZU+qP+2a+cOSsam03CvK1v5RmkUuuhzX4OJE3XeqmU6oRWLqJpniVNmFl
         4bTFWbympAh+AjbvJZaw7HunNga/De6ywCtuVOj9PK/QT0BdczTONu6+PtX9dTRY6AH4
         Q27w==
X-Gm-Message-State: AGRZ1gIiWy+7NFCr+DnQcbXLt2P4RoczTnaLypSN1/w++fVKGNaKEUH/
        pDoILZTCexohU9tNTnt9v9DuNw==
X-Google-Smtp-Source: AJdET5c1PIeAtrh2vLETbJ81GooRuIiXoW0KGpxq2iOnvvyo40fNVfYKjcRt1GXMSn4fuvUxLDy7Nw==
X-Received: by 2002:a17:902:2:: with SMTP id 2-v6mr23958956pla.178.1541449062980;
        Mon, 05 Nov 2018 12:17:42 -0800 (PST)
Received: from zsm-linux.mtv.corp.google.com ([2620:15c:202:201:1b7c:8280:c835:b226])
        by smtp.googlemail.com with ESMTPSA id e2-v6sm45972561pgv.25.2018.11.05.12.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:17:42 -0800 (PST)
From:   Zubin Mithra <zsm@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     groeck@chromium.org, keescook@chromium.org, zsm@chromium.org
Subject: [PATCH] x86/pci: Annotate 'pci_root_ops' with __ro_after_init
Date:   Mon,  5 Nov 2018 12:17:35 -0800
Message-Id: <20181105201735.72026-1-zsm@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_X86_INTEL_MID is set pci_root_ops is written to inside
intel_mid_pci_init(which is marked __init) and not modified after. This
makes pci_root_ops a suitable candidate for annotating as
__ro_after_init.

Signed-off-by: Zubin Mithra <zsm@chromium.org>
---
 arch/x86/pci/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index d4ec117c1142..204ee80cfa63 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -67,7 +67,7 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int siz
 				  devfn, where, size, value);
 }
 
-struct pci_ops pci_root_ops = {
+struct pci_ops pci_root_ops __ro_after_init = {
 	.read = pci_read,
 	.write = pci_write,
 };
-- 
2.19.1.930.g4563a0d9d0-goog

