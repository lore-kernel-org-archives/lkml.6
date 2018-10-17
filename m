Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA64ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08E62145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DKoVWE4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08E62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeJRGba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:31:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43977 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeJRGb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:31:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so26397870eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hJH8zlpeNWMQv2b0tNlyLAKd8efPcHo1GwNJ0NhdY8s=;
        b=DKoVWE4x9z5BIeMr9lWuBBpLTNCR7dOB8eF6KveQ224UTgSlBsFv8FvV6bFrbNbTa6
         H1TqKcDkgIcL/dUPbpbaZqDcCXW0XqNisFkVSoSE+68GXjmx/qIFcNec0G5eQlVKr3a6
         bYFRw/Jqkvg1v3q1895Mhxkv+8x5qNW+HHgfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hJH8zlpeNWMQv2b0tNlyLAKd8efPcHo1GwNJ0NhdY8s=;
        b=hb0xBrLEsA//rbdActyQviZgZDmnb4ev6p9EWgckmEVzoPZXLWn3kOjt7vGNxE97FV
         CCEREMSv5pmiCGWAAOscIcWnoYnNbhjH+swnZTGn8fw0RoPuHSXzAFt6HFIEde+lU1OY
         C+T2bhgRX8zuziJFbq7uGWFgwLSWDHcraE3efL4DAsbCpkRNRVR5NTDHRiyZXgoYxb8e
         9ezKbp+Y8aeLiTuWS/POP3G2tNJ6kqOWiN+CyrEvxHr6UFZ60NzW9yYUYI9DATZ08Uqb
         hVs5RCtcp426P0COE9AMPdRKBQ/qPh3KBamfB/sIIZ1jlbL5LJGZ8zaxxc9MyOx65jWj
         TTfA==
X-Gm-Message-State: ABuFfojeUC5/FUcPeZGp4pWBmYnxp5k2n9YOx5vizQrGs1cemRbmXg2O
        IAGOZqUXblpNzPUIKMQ0N+FJT5fMHp8=
X-Google-Smtp-Source: ACcGV60HTHgcgoj62LS1SwSrEacIA95rEEtRXwns9FsbHp01sHpnf/7ACJQRHO4xAdqC3RO9bnLQ5A==
X-Received: by 2002:a50:b64f:: with SMTP id c15-v6mr1760300ede.288.1539815620648;
        Wed, 17 Oct 2018 15:33:40 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id e30-v6sm7001555edd.25.2018.10.17.15.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 15:33:40 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [POC 02/12] init/main.c: call update_rai_access()
Date:   Thu, 18 Oct 2018 00:33:22 +0200
Message-Id: <20181017223332.11964-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
References: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hope that one can actually interchange the order of these calls a bit
so that they read

	mark_readonly();
	update_rai_access();
	free_initmem();

because there will be some metadata associated to each rai_* macro
invocation that might as well live in __initdata. But for now, we will
live with that wasted space.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 init/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/init/main.c b/init/main.c
index a664246450d1..39709ca33316 100644
--- a/init/main.c
+++ b/init/main.c
@@ -92,6 +92,7 @@
 #include <linux/rodata_test.h>
 #include <linux/jump_label.h>
 #include <linux/mem_encrypt.h>
+#include <linux/rai.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -1066,6 +1067,7 @@ static int __ref kernel_init(void *unused)
 	ftrace_free_init_mem();
 	free_initmem();
 	mark_readonly();
+	update_rai_access();
 
 	/*
 	 * Kernel mappings are now finalized - update the userspace page-table
-- 
2.19.1.6.gbde171bbf5

