Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE5FC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15E02146E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BSiENkum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15E02146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeKBI53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:57:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45137 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbeKBI5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:57:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id o19-v6so93516pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gkebQX8ZhFr9PQSx9bfOcE0V+2Bc8HeqM0sduXA/rPU=;
        b=BSiENkumH02ZKa9mgxe36PDhL+/GUoKyxSxp8C0m/iYyPWqr8VaHmhpSlrA7lwV1/Y
         zI3+PJeREg6zqudvtTDuBt+3gHYK1AhPbZh2o8upcCVlum342cIVziUgI2lP7/6ED17c
         D52awj6ZU2eW61GKUZejszzs+nGim3Wuj+bdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gkebQX8ZhFr9PQSx9bfOcE0V+2Bc8HeqM0sduXA/rPU=;
        b=QvM8OEhmGf7WmdQArwjnGzBUnQLq6CVlY6fMDLvzPKjwDeLCqSd4tuzdO0gV14dF1+
         3GVCkrR8M28APT/JFJ+BvLyQadH+2UKufPmbq9NpH5NQaiFDQ2eFo7HAj52TUgM7R1ls
         9QaOlHXLarJxtRs3iDRx+9fk3y0xFciim7F6LcOXzcI/hzuhyFc5AfCqSJVHn8i53HRU
         YJrsjU2MPxyihiwherjk117AglQok2mhyRt5Cd6EgI6DHXrRANCAT7zaTahFKpi/UeUW
         InvScwux+JCfANThHi2W5JkbGOtwlvVoe2cpJ/Z4CVg3Idrn5i3VJcDjcmr/TJY+zfPc
         rVwA==
X-Gm-Message-State: AGRZ1gJkGT0TjS9Fdg7W0ZBasDbwg+2QiaD3Hjh32DbL8PZS9G1k0KIK
        NWXJNTC4K+4F+YLJIgG4nGSAtQ==
X-Google-Smtp-Source: AJdET5cu14Gaeu4VkwpAzZnxGgNQrZFQN/vOC/Nstzt9Wl8VO4ESRt6nUN17oXdNXM/WwgMKsKoUew==
X-Received: by 2002:a17:902:5066:: with SMTP id f35-v6mr9371062plh.145.1541116331371;
        Thu, 01 Nov 2018 16:52:11 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b77-v6sm28297879pfm.3.2018.11.01.16.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 16:52:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 7/8] pstore: Remove needless lock during console writes
Date:   Thu,  1 Nov 2018 16:51:59 -0700
Message-Id: <20181101235200.28584-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181101235200.28584-1-keescook@chromium.org>
References: <20181101235200.28584-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 70ad35db3321 ("pstore: Convert console write to use
->write_buf"), the console writer does not use the preallocated crash
dump buffer any more, so there is no reason to perform locking around it.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index a956c7bc3f67..32340e7dd6a5 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -461,31 +461,14 @@ static void pstore_unregister_kmsg(void)
 #ifdef CONFIG_PSTORE_CONSOLE
 static void pstore_console_write(struct console *con, const char *s, unsigned c)
 {
-	const char *e = s + c;
+	struct pstore_record record;
 
-	while (s < e) {
-		struct pstore_record record;
-		unsigned long flags;
-
-		pstore_record_init(&record, psinfo);
-		record.type = PSTORE_TYPE_CONSOLE;
-
-		if (c > psinfo->bufsize)
-			c = psinfo->bufsize;
+	pstore_record_init(&record, psinfo);
+	record.type = PSTORE_TYPE_CONSOLE;
 
-		if (oops_in_progress) {
-			if (!spin_trylock_irqsave(&psinfo->buf_lock, flags))
-				break;
-		} else {
-			spin_lock_irqsave(&psinfo->buf_lock, flags);
-		}
-		record.buf = (char *)s;
-		record.size = c;
-		psinfo->write(&record);
-		spin_unlock_irqrestore(&psinfo->buf_lock, flags);
-		s += c;
-		c = e - s;
-	}
+	record.buf = (char *)s;
+	record.size = c;
+	psinfo->write(&record);
 }
 
 static struct console pstore_console = {
-- 
2.17.1

