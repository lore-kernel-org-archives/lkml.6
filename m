Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2673ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4A220843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aWfdTV2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4A220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeKDIvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:51:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32832 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeKDIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:51:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id x6-v6so2675745pln.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U8o0tN24oPbvYpDeR9zET4b2yQXaEBXQtdSJUt1G4os=;
        b=aWfdTV2m5ebIjdLaCbzsnWp/wp/ISyLs4sESu1VSrpeheck0hapXrwVrqBsNvI7iIF
         aLlKJNQr0HTAqPUSNXdcs7cOlf5Vx8vGw6G7ai+r2IhfNQdD3I1Gbl2hs9xJJe54LB21
         J+TSy9deRARAdpncq5Y/unhOxxw3DRjZzQ5HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U8o0tN24oPbvYpDeR9zET4b2yQXaEBXQtdSJUt1G4os=;
        b=O8RQfGFVZuVuGMfo5IhbGV+8N3FxGD93GVyIKcy6tSauXbW3CR7c5xX7JecwESrwZR
         MMKXLnqRF9+kGJV0Dx07RjpSUC7atwz3m05q86IDPEhxqu8ZQQkI/XwiyrLaboaDFy5C
         IA56EDZ+inv1t76nPTl+xCxJ/womcocsHkSlzdQ5dFzhyGLmmr1drcGyHaockK5M+A0U
         0in47+7XSsyaYsinlKv9/mfr8pNum2ZwoL2h8AfCMeRSdgdN0AYlyCZ+/fAf7RM0huZt
         r/OYXbuB4q2unln3ZPi4FqKXr653/6yGOF3eQ4lXRK3je2jYFyb4cYbZKhZ6jl3bmA90
         fNnQ==
X-Gm-Message-State: AGRZ1gI5f+2IM5NRpE/v+33DKkXVgrYPG1qeS/sh1Y/qrd7XQBsJR0AV
        sPSEWTihUX8ue2I7zCsxO7VDm54fyi4=
X-Google-Smtp-Source: AJdET5doJLx1tLSASB5nVhzKwxqmjtQth/okTmqKwbqytoNtWmwYppvTQAlf0JGhW4hvTgqIwo9Xug==
X-Received: by 2002:a17:902:d907:: with SMTP id c7-v6mr16586290plz.198.1541288309064;
        Sat, 03 Nov 2018 16:38:29 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id e8-v6sm9056385pfi.61.2018.11.03.16.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 16:38:27 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH RFC v2 1/3] pstore: map pstore types to names
Date:   Sat,  3 Nov 2018 16:38:16 -0700
Message-Id: <20181103233818.44615-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181103233818.44615-1-joel@joelfernandes.org>
References: <20181103233818.44615-1-joel@joelfernandes.org>
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
 fs/pstore/inode.c          | 53 +++++---------------------------------
 fs/pstore/ram.c            |  4 ++-
 include/linux/pstore.h     | 37 ++++++++++++++++++++++++++
 include/linux/pstore_ram.h |  2 ++
 4 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 8cf2218b46a7..c5c6b8b4b70a 100644
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
@@ -335,53 +336,11 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 		goto fail_alloc;
 	private->record = record;
 
-	switch (record->type) {
-	case PSTORE_TYPE_DMESG:
-		scnprintf(name, sizeof(name), "dmesg-%s-%llu%s",
-			  record->psi->name, record->id,
-			  record->compressed ? ".enc.z" : "");
-		break;
-	case PSTORE_TYPE_CONSOLE:
-		scnprintf(name, sizeof(name), "console-%s-%llu",
-			  record->psi->name, record->id);
-		break;
-	case PSTORE_TYPE_FTRACE:
-		scnprintf(name, sizeof(name), "ftrace-%s-%llu",
-			  record->psi->name, record->id);
-		break;
-	case PSTORE_TYPE_MCE:
-		scnprintf(name, sizeof(name), "mce-%s-%llu",
-			  record->psi->name, record->id);
-		break;
-	case PSTORE_TYPE_PPC_RTAS:
-		scnprintf(name, sizeof(name), "rtas-%s-%llu",
-			  record->psi->name, record->id);
-		break;
-	case PSTORE_TYPE_PPC_OF:
-		scnprintf(name, sizeof(name), "powerpc-ofw-%s-%llu",
-			  record->psi->name, record->id);
-		break;
-	case PSTORE_TYPE_PPC_COMMON:
-		scnprintf(name, sizeof(name), "powerpc-common-%s-%llu",
-			  record->psi->name, record->id);
-		break;
-	case PSTORE_TYPE_PMSG:
-		scnprintf(name, sizeof(name), "pmsg-%s-%llu",
-			  record->psi->name, record->id);
-		break;
-	case PSTORE_TYPE_PPC_OPAL:
-		scnprintf(name, sizeof(name), "powerpc-opal-%s-%llu",
-			  record->psi->name, record->id);
-		break;
-	case PSTORE_TYPE_UNKNOWN:
-		scnprintf(name, sizeof(name), "unknown-%s-%llu",
-			  record->psi->name, record->id);
-		break;
-	default:
-		scnprintf(name, sizeof(name), "type%d-%s-%llu",
-			  record->type, record->psi->name, record->id);
-		break;
-	}
+	scnprintf(name, sizeof(name), "%s-%s-%llu%s",
+			pstore_type_to_name(record->type),
+			record->psi->name, record->id,
+			(record->type == PSTORE_TYPE_DMESG
+			 && record->compressed) ? ".enc.z" : "");
 
 	dentry = d_alloc_name(root, name);
 	if (!dentry)
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 10ac4d23c423..b174d0fc009f 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -611,6 +611,7 @@ static int ramoops_init_przs(const char *name,
 			goto fail;
 		}
 		*paddr += zone_sz;
+		prz_ar[i]->type = pstore_name_to_type(name);
 	}
 
 	*przs = prz_ar;
@@ -650,6 +651,7 @@ static int ramoops_init_prz(const char *name,
 	}
 
 	*paddr += sz;
+	(*prz)->type = pstore_name_to_type(name);
 
 	return 0;
 }
@@ -785,7 +787,7 @@ static int ramoops_probe(struct platform_device *pdev)
 
 	dump_mem_sz = cxt->size - cxt->console_size - cxt->ftrace_size
 			- cxt->pmsg_size;
-	err = ramoops_init_przs("dump", dev, cxt, &cxt->dprzs, &paddr,
+	err = ramoops_init_przs("dmesg", dev, cxt, &cxt->dprzs, &paddr,
 				dump_mem_sz, cxt->record_size,
 				&cxt->max_dump_cnt, 0, 0);
 	if (err)
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index f46e5df76b58..caeeda0bbab3 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -44,9 +44,46 @@ enum pstore_type_id {
 	PSTORE_TYPE_PPC_COMMON	= 6,
 	PSTORE_TYPE_PMSG	= 7,
 	PSTORE_TYPE_PPC_OPAL	= 8,
+	PSTORE_TYPE_MAX		= 9,
+	/* UNKNOWN returned from pstore_name_to_type if no type found */
 	PSTORE_TYPE_UNKNOWN	= 255
 };
 
+/* names should be in the same order as the above table */
+static const char __maybe_unused *__pstore_type_names[] = {
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
+};
+
+static const char *pstore_type_to_name(enum pstore_type_id type)
+{
+	if (WARN_ON_ONCE(type >= PSTORE_TYPE_MAX))
+		return "unknown";
+
+	return __pstore_type_names[type];
+}
+
+static inline enum pstore_type_id pstore_name_to_type(const char *name)
+{
+	int i;
+
+	for (i = 0; i < PSTORE_TYPE_MAX; i++) {
+		const char *str = pstore_type_to_name(i);
+		if (!strcmp(str, name))
+			return i;
+	}
+
+	return PSTORE_TYPE_UNKNOWN;
+}
+
 struct pstore_info;
 /**
  * struct pstore_record - details of a pstore record entry
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 5d10ad51c1c4..5af72b155ad8 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/pstore.h>
 #include <linux/types.h>
 
 /*
@@ -92,6 +93,7 @@ struct persistent_ram_zone {
 
 	raw_spinlock_t buffer_lock;
 	struct persistent_ram_buffer *buffer;
+	enum pstore_type_id type;
 	size_t buffer_size;
 
 	char *par_buffer;
-- 
2.19.1.930.g4563a0d9d0-goog

