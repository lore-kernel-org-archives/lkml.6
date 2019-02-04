Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D68C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770A420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jr5UNm7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfBDVBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:01:23 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34590 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfBDVBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:01:23 -0500
Received: by mail-qt1-f195.google.com with SMTP id b8so1606686qtj.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 13:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T3Ys7VOnltP2a92n8XrCqTE/JoJ/1GY/pFMcr6i+aVc=;
        b=jr5UNm7udbPsK7X2HBv3bya2lI6o5UNA47MXIgl0xKeF0kvsisYLqMRx25z6WdRlId
         WRZ7O/MTwVi4P2mGpZJEK8T8ANXOMmV97WX43AJ9z/2En2jozPiXV5klrLmFUQOCWDJY
         l8RqZzHKmG5xogWYMBQo3wrbCAS7GASGTrZSJIAAvaWs++G+vl9vVJSdybP9aAI1ovEM
         39kxoUkFpbZcqw4vQxOmhvccmfvVbmbmCWWru72TAfN2rTDps13njV5be4HbL/T7Ztl2
         iXBXrSivxlA3DE3AwtZJenfV/p6u1+H/LjtkRp4pzP9XZJCBhKHlQVc7+X/424HkIUHL
         ZvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T3Ys7VOnltP2a92n8XrCqTE/JoJ/1GY/pFMcr6i+aVc=;
        b=g4P5keJFzOiH1nd027uE8hQDVhbZkr5aifYt9nHVFGjUeEu/t4pgUdvbsMKg6Dj44w
         UjiAY4ne44xTWnClISXqK5njhsmyKCVrfvLYBK+JUcejfmtoAp8R8Ufp8XF4dxGQK7aS
         utDED8gHqQLHu59pLmIWgVPPbznY7IwPxJJSvsJl1wc0wK/PYp22kMey2U6rMRu4S1nU
         JaMJBsxBlfCMFXlc8Kg+lYLznj7HPWyK7kzM8kL4IjetJAVXeQG2nCflGJO29iI3UzWg
         QCPBA/5gRh138w7ZsOjkJWrg/VeEScZorsSQCH+pFuqLdemBlQ8iXr65Fuq3YcCJ4LCh
         qqRA==
X-Gm-Message-State: AHQUAub98bm0FRlpqXXJJRzvAEAsKiac786OHJ3VJ1ZRuKhTTAVH1fOM
        EJAaP/Ik6S+U1ImNbgI/t18EZ4dd7CU=
X-Google-Smtp-Source: AHgI3IYBZXv/bMka86aGD8KyE/igOclsC0by8j3tPKanIkmgFlh6h17VpI+F/RgAmV4Zza/F/GijHg==
X-Received: by 2002:aed:314b:: with SMTP id 69mr1043922qtg.247.1549314082281;
        Mon, 04 Feb 2019 13:01:22 -0800 (PST)
Received: from Qians-MBP.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c49sm30268094qtc.94.2019.02.04.13.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 13:01:21 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     ard.biesheuvel@linaro.org
Cc:     gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] efi/arm64: return zero from ptdump_init()
Date:   Mon,  4 Feb 2019 16:01:01 -0500
Message-Id: <20190204210101.61733-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e2a2e56e4082 ("arm64: dump: no need to check return value of
debugfs_create functions") converted ptdump_debugfs_register() from
void, but forgot to fix the efi version of ptdump_init().

drivers/firmware/efi/arm-runtime.c: In function 'ptdump_init':
drivers/firmware/efi/arm-runtime.c:52:9: error: void value not ignored as it ought to be
   52 |  return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/firmware/efi/arm-runtime.c:53:1: warning: control reaches end of non-void function [-Wreturn-type]

Fixes: e2a2e56e4082 ("arm64: dump: no need to check return value of debugfs_create functions")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/firmware/efi/arm-runtime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 352bd2473162..b308f5bb3737 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -46,10 +46,10 @@ static struct ptdump_info efi_ptdump_info = {
 
 static int __init ptdump_init(void)
 {
-	if (!efi_enabled(EFI_RUNTIME_SERVICES))
-		return 0;
+	if (efi_enabled(EFI_RUNTIME_SERVICES))
+		ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
 
-	return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
+	return 0;
 }
 device_initcall(ptdump_init);
 
-- 
2.17.2 (Apple Git-113)

