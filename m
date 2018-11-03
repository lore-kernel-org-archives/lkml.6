Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2F9C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EDD2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="u4oG6H2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EDD2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbeKDIvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:51:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44503 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbeKDIvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:51:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so2649848plq.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 16:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=inZA+MuDZ9YgenieRz6U26ufuohCQn/O6yrZMmod3jE=;
        b=u4oG6H2Lei8QFa3YB8n1sksMt7d0Qsppxsr+MEIh0mNgCYnJEJVVINnTFl2GCIUFtx
         XVGmv6gnSmjolNqr7+b+J7Q+fgYNjXqCTWvH48eucWp/d4+0/Uglcxd91w7eb3qpZQW8
         OGlYaH77cptV8PkWZ/7ixfWhZr3PFpUPSlGJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=inZA+MuDZ9YgenieRz6U26ufuohCQn/O6yrZMmod3jE=;
        b=ExRGCNv8tEgOlotabJXJ4GWTv7t5DxHmu9uxsjlAGv6X++6r02JTDl6PUVl6Dx3UrC
         k7lttBX3zDUCIMbXf5toShC8FDFamAlNtkUs9imnpuh7qAH41B+H/mX3kvCNkOnX33tp
         DUSpUAa4CkIlnBQOMBJdOqfoERjR/sigNMrz7tvVZUc0W/Vt6R/PKIUWCI0DjQmaI6UF
         GYkVXRqX3oYIetS9BINOYKVifbYB7CoTv/V//rI30oVTnhM8oEci52FNoateToL+T8ZE
         nkKOTDtUKBZFcXFIVQbJxO4f4JHbOOiofKrw0KmpOKAh/H1xmHpWW/XzJSI4lXMDCY1f
         Zemg==
X-Gm-Message-State: AGRZ1gLUiNGnQRFK2aEiUzBlp9AGCOGsBSxMTyNbFeCOnmTaDUg3qtkT
        l5R8plaRJu1N8TGpwdCEeQRMbjOW77w=
X-Google-Smtp-Source: AJdET5er0RWOka+GaRjZ8GNHwv02it8fLEkZRVkCm06m66nr5pv65zBM4BOpyhb40rNfK2EMMjeDUA==
X-Received: by 2002:a17:902:5590:: with SMTP id g16-v6mr16821683pli.56.1541288312431;
        Sat, 03 Nov 2018 16:38:32 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id e8-v6sm9056385pfi.61.2018.11.03.16.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 16:38:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH RFC v2 3/3] pstore: donot treat empty buffers as valid
Date:   Sat,  3 Nov 2018 16:38:18 -0700
Message-Id: <20181103233818.44615-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181103233818.44615-1-joel@joelfernandes.org>
References: <20181103233818.44615-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pstore currently calls persistent_ram_save_old even if a buffer is
empty. While this appears to work, it is does not seem like the right
thing to do and could lead to future bugs so lets avoid that. It also
prevent misleading prints in the logs which claim the buffer is valid.

I got something like:
found existing buffer, size 0, start 0

When I was expecting:
no valid data in buffer (sig = ...)

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
Note that if you feel this patch is not necessary, then feel free to
drop it. I would say it is harmless and is a good clean up.

 fs/pstore/ram_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index e6375439c5ac..196e4fd7ba8c 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -510,7 +510,7 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 
 	sig ^= PERSISTENT_RAM_SIG;
 
-	if (prz->buffer->sig == sig) {
+	if (prz->buffer->sig == sig && buffer_size(prz)) {
 		if (buffer_size(prz) > prz->buffer_size ||
 		    buffer_start(prz) > buffer_size(prz)) {
 			pr_info("found existing invalid buffer, size %zu, start %zu\n",
-- 
2.19.1.930.g4563a0d9d0-goog
