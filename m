Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88CCECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CB620868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FnDG0ytI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CB620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeJ0Cit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:38:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33226 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeJ0Cit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:38:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id z2-v6so902419pgp.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17iK/sJVf/B3S6fpAzFzWsuvWf14Au+vRXpbyFr1nig=;
        b=FnDG0ytIFejiaMSXN7xKgN6kMRZU9/UDAJ+ZKQzDDmTHPKiDQtAxhPZL4QAe5I6Xng
         hFH9/sHR2o/044gEcxNMLGvgWo5mQdHXGM7ILUUvvPouenk6PNTI/uZtpqvZBA6O4ZPX
         JC0Y1bQlk/SMkLFCgFpFp90btdi4GBb4yvZLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17iK/sJVf/B3S6fpAzFzWsuvWf14Au+vRXpbyFr1nig=;
        b=UiAHJFg26oeSQJBJkXrEh/NEkXq4czNCreSYTgjWLwMPRTFNRmNZHgef1C6L5nSOe/
         96FxeFWdrPllxpXaXI1Vyh6k01hAuzgHCLJQXttcoPa6b1cm7vU9NeIIAz7mEU94KnPB
         u/RokMHCciWvxIJO7Bq5qN4+RxE0VK9Jio65eMJjiM2635/0vkAXAj1PBV7mg0W4ynad
         00IAnYJF7A+SRSJUTvQQ9Bnrx0d5B4SEIMP6d5dwCSidIGKUi08bnuApDSodgOtJ3J4d
         gYPgy6nytA/sFJ6DhSDpu//3TqPKFbMFoP/vOZpts/xqRLva6RNvPT55NeZ4Zs+KLOnd
         aDqQ==
X-Gm-Message-State: AGRZ1gJQVvZJDk+IiLuD8WRHtt2zKpx4APafRnVkdXvNQMcgNMzynuaN
        ZFwiECMJYYToG5SHgSUfPvLhdoLN6as=
X-Google-Smtp-Source: AJdET5cHdJA8/tUmxKJhRbUX0lqLsLnxvOe6qYG2yde2sK867KFd0eZnQyOF7vONMrfJp4fov4KiHw==
X-Received: by 2002:a63:450b:: with SMTP id s11-v6mr4491342pga.301.1540576849692;
        Fri, 26 Oct 2018 11:00:49 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id v5-v6sm17521243pfd.64.2018.10.26.11.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 11:00:48 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [RFC 1/6] pstore: map pstore types to names
Date:   Fri, 26 Oct 2018 11:00:37 -0700
Message-Id: <20181026180042.52199-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In later patches we will need to map types to names, so create a table
for that which can also be used and reused in different parts of old and
new code. Also use it to save the type in the PRZ which will be useful
in later patches.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/pstore/inode.c          | 44 ++++++++++++++++++++------------------
 fs/pstore/ram.c            |  4 +++-
 include/linux/pstore.h     | 29 +++++++++++++++++++++++++
 include/linux/pstore_ram.h |  2 ++
 4 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 5fcb845b9fec..43757049d384 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -304,6 +304,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	struct dentry		*dentry;
 	struct inode		*inode;
 	int			rc = 0;
+	enum pstore_type_id	type;
 	char			name[PSTORE_NAMELEN];
 	struct pstore_private	*private, *pos;
 	unsigned long		flags;
@@ -335,43 +336,44 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 		goto fail_alloc;
 	private->record = record;
 
-	switch (record->type) {
+	type = record->type;
+	switch (type) {
 	case PSTORE_TYPE_DMESG:
-		scnprintf(name, sizeof(name), "dmesg-%s-%llu%s",
-			  record->psi->name, record->id,
-			  record->compressed ? ".enc.z" : "");
+		scnprintf(name, sizeof(name), "%s-%s-%llu%s",
+			 pstore_names[type], record->psi->name, record->id,
+			 record->compressed ? ".enc.z" : "");
 		break;
 	case PSTORE_TYPE_CONSOLE:
-		scnprintf(name, sizeof(name), "console-%s-%llu",
-			  record->psi->name, record->id);
+		scnprintf(name, sizeof(name), "%s-%s-%llu",
+			  pstore_names[type], record->psi->name, record->id);
 		break;
 	case PSTORE_TYPE_FTRACE:
-		scnprintf(name, sizeof(name), "ftrace-%s-%llu",
-			  record->psi->name, record->id);
+		scnprintf(name, sizeof(name), "%s-%s-%llu",
+			  pstore_names[type], record->psi->name, record->id);
 		break;
 	case PSTORE_TYPE_MCE:
-		scnprintf(name, sizeof(name), "mce-%s-%llu",
-			  record->psi->name, record->id);
+		scnprintf(name, sizeof(name), "%s-%s-%llu",
+			  pstore_names[type], record->psi->name, record->id);
 		break;
 	case PSTORE_TYPE_PPC_RTAS:
-		scnprintf(name, sizeof(name), "rtas-%s-%llu",
-			  record->psi->name, record->id);
+		scnprintf(name, sizeof(name), "%s-%s-%llu",
+			  pstore_names[type], record->psi->name, record->id);
 		break;
 	case PSTORE_TYPE_PPC_OF:
-		scnprintf(name, sizeof(name), "powerpc-ofw-%s-%llu",
-			  record->psi->name, record->id);
+		scnprintf(name, sizeof(name), "%s-%s-%llu",
+			  pstore_names[type], record->psi->name, record->id);
 		break;
 	case PSTORE_TYPE_PPC_COMMON:
-		scnprintf(name, sizeof(name), "powerpc-common-%s-%llu",
-			  record->psi->name, record->id);
+		scnprintf(name, sizeof(name), "%s-%s-%llu",
+			  pstore_names[type], record->psi->name, record->id);
 		break;
 	case PSTORE_TYPE_PMSG:
-		scnprintf(name, sizeof(name), "pmsg-%s-%llu",
-			  record->psi->name, record->id);
+		scnprintf(name, sizeof(name), "%s-%s-%llu",
+			  pstore_names[type], record->psi->name, record->id);
 		break;
 	case PSTORE_TYPE_PPC_OPAL:
-		scnprintf(name, sizeof(name), "powerpc-opal-%s-%llu",
-			  record->psi->name, record->id);
+		scnprintf(name, sizeof(name), "%s-%s-%llu",
+			  pstore_names[type], record->psi->name, record->id);
 		break;
 	case PSTORE_TYPE_UNKNOWN:
 		scnprintf(name, sizeof(name), "unknown-%s-%llu",
@@ -379,7 +381,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 		break;
 	default:
 		scnprintf(name, sizeof(name), "type%d-%s-%llu",
-			  record->type, record->psi->name, record->id);
+			  type, record->psi->name, record->id);
 		break;
 	}
 
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index f4fd2e72add4..c7cd858adce7 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -604,6 +604,7 @@ static int ramoops_init_przs(const char *name,
 			goto fail;
 		}
 		*paddr += zone_sz;
+		prz_ar[i]->type = pstore_name_to_type(name);
 	}
 
 	*przs = prz_ar;
@@ -642,6 +643,7 @@ static int ramoops_init_prz(const char *name,
 	persistent_ram_zap(*prz);
 
 	*paddr += sz;
+	(*prz)->type = pstore_name_to_type(name);
 
 	return 0;
 }
@@ -777,7 +779,7 @@ static int ramoops_probe(struct platform_device *pdev)
 
 	dump_mem_sz = cxt->size - cxt->console_size - cxt->ftrace_size
 			- cxt->pmsg_size;
-	err = ramoops_init_przs("dump", dev, cxt, &cxt->dprzs, &paddr,
+	err = ramoops_init_przs("dmesg", dev, cxt, &cxt->dprzs, &paddr,
 				dump_mem_sz, cxt->record_size,
 				&cxt->max_dump_cnt, 0, 0);
 	if (err)
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index a15bc4d48752..4a3dbdffd8d3 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -47,6 +47,21 @@ enum pstore_type_id {
 	PSTORE_TYPE_UNKNOWN	= 255
 };
 
+/* names should be in the same order as the above table */
+static char __maybe_unused *pstore_names[] = {
+	"dmesg",
+	"mce",
+	"console",
+	"ftrace",
+	"rtas",
+	"powerpc-ofw",
+	"powerpc-common",
+	"pmsg",
+	"powerpc-opal",
+	"event",
+	"unknown", /* unknown should be the last string */
+};
+
 struct pstore_info;
 /**
  * struct pstore_record - details of a pstore record entry
@@ -274,4 +289,18 @@ pstore_ftrace_write_timestamp(struct pstore_ftrace_record *rec, u64 val)
 }
 #endif
 
+static inline enum pstore_type_id pstore_name_to_type(const char *name)
+{
+	char *str;
+	int i = 0;
+
+	for (; strncmp(pstore_names[i], "unknown", 7); i++) {
+		str = pstore_names[i];
+		if (!strncmp(name, str, strlen(str)))
+			return (enum pstore_type_id)i;
+	}
+
+	return PSTORE_TYPE_UNKNOWN;
+}
+
 #endif /*_LINUX_PSTORE_H*/
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index e6d226464838..ee0f493254dd 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/pstore.h>
 #include <linux/types.h>
 
 /*
@@ -47,6 +48,7 @@ struct persistent_ram_zone {
 	size_t size;
 	void *vaddr;
 	struct persistent_ram_buffer *buffer;
+	enum pstore_type_id type;
 	size_t buffer_size;
 	u32 flags;
 	raw_spinlock_t buffer_lock;
-- 
2.19.1.568.g152ad8e336-goog

