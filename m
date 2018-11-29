Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FA4C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F0421019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ReGQZKRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F0421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeK3KQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:16:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33636 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeK3KQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so1800859plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v4j+2+rUVxw2Rh6ibxHa+kTUkpK+VUTlvG5j1I65xSE=;
        b=ReGQZKRZQXrMxy/S+X8L+/E48J70NLto9yccWuS00MotPgZxZsw2GegpFo8QvvoDD6
         IxUoEn1k1mMpIoTAuu3QWbXxNEgBB1Go+84XgSNpG0IJifGYfb4ArhyltludysOI9YhN
         xgn2r3uQJVUC6GqV0GBOQGWuCWI8vEHQBIA8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v4j+2+rUVxw2Rh6ibxHa+kTUkpK+VUTlvG5j1I65xSE=;
        b=X6fcj0jYd5LkhKuuj2i0ODnJnASpUjZgKarvlOCRimFfbHdmD3LUKkaXYe4D7j53JM
         QFyqZt5wpaDAi0Zpp3B9srsWFQPRk6hjd80hFuMUWVhaJs3kcfVak0vQ3kJ1S3N5HjHX
         OXQNMHy1Efia6813+SF1mmtZvEWkdmcStT1V+mb0GLa6kwK5w9bN1mXpjU0o2/rpK65A
         3EDUAJ2cWysA9YDZR1hVri4esYrmgC3rYAGlyJX9SUnxQaUSC6Smpuozp1G8Ji0yA38v
         fiLUmdc4uzuBVvxvUiNOuZ4DHtvK9xsWnXlUsoAR8NM0g6iVRRXsIHIHORh4szsbMrVb
         M2xQ==
X-Gm-Message-State: AA+aEWa8xQ6ubDzwcI3jJhACIshQ3au4OMYSinnH8XR3sSoYVXqa+RIj
        dpsSmQq57yZcYeBznJ5eHXs8WqJAnYvzDw==
X-Google-Smtp-Source: AFSGD/WmVRWDp2+aoz8eAo7Zq6DGuVxHQe29sOEWfRrbLtvkGlM/PeUXZ7pqxWsBNSV1riWpeg1rWg==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr3267587pls.322.1543532940692;
        Thu, 29 Nov 2018 15:09:00 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d21sm3558287pgv.37.2018.11.29.15.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:08:56 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -next v2 10/12] pstore: Map PSTORE_TYPE_* to strings
Date:   Thu, 29 Nov 2018 15:08:39 -0800
Message-Id: <20181129230841.29955-11-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129230841.29955-1-keescook@chromium.org>
References: <20181129230841.29955-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

In later patches we will need to map types to names, so create a
constant table for that which can also be used in different parts of
old and new code. This saves the type in the PRZ which will be useful
in later patches.

Instead of having an explicit PSTORE_TYPE_UNKNOWN, just use ..._MAX.

This includes removing the now redundant filename templates which can use
a single format string. Also, there's no reason to limit the "is it still
compressed?" test to only PSTORE_TYPE_DMESG when building the pstorefs
filename. Records are zero-initialized, so a backend would need to have
explicitly set compressed=1.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/acpi/apei/erst.c   |  2 +-
 fs/pstore/inode.c          | 51 +++-----------------------------------
 fs/pstore/platform.c       | 37 +++++++++++++++++++++++++++
 fs/pstore/ram.c            |  4 ++-
 include/linux/pstore.h     | 17 ++++++++++---
 include/linux/pstore_ram.h |  3 +++
 6 files changed, 62 insertions(+), 52 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 3c5ea7cb693e..a5e1d963208e 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -1035,7 +1035,7 @@ static ssize_t erst_reader(struct pstore_record *record)
 			     CPER_SECTION_TYPE_MCE) == 0)
 		record->type = PSTORE_TYPE_MCE;
 	else
-		record->type = PSTORE_TYPE_UNKNOWN;
+		record->type = PSTORE_TYPE_MAX;
 
 	if (rcd->hdr.validation_bits & CPER_VALID_TIMESTAMP)
 		record->time.tv_sec = rcd->hdr.timestamp;
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 8cf2218b46a7..c60ee46f3e39 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -335,53 +335,10 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
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
+			record->compressed ? ".enc.z" : "");
 
 	dentry = d_alloc_name(root, name);
 	if (!dentry)
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 32340e7dd6a5..2387cb74f729 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -59,6 +59,19 @@ MODULE_PARM_DESC(update_ms, "milliseconds before pstore updates its content "
 		 "enabling this option is not safe, it may lead to further "
 		 "corruption on Oopses)");
 
+/* Names should be in the same order as the enum pstore_type_id */
+static const char * const pstore_type_names[] = {
+	"dmesg",
+	"mce",
+	"console",
+	"ftrace",
+	"rtas",
+	"powerpc-ofw",
+	"powerpc-common",
+	"pmsg",
+	"powerpc-opal",
+};
+
 static int pstore_new_entry;
 
 static void pstore_timefunc(struct timer_list *);
@@ -104,6 +117,30 @@ void pstore_set_kmsg_bytes(int bytes)
 /* Tag each group of saved records with a sequence number */
 static int	oopscount;
 
+const char *pstore_type_to_name(enum pstore_type_id type)
+{
+	BUILD_BUG_ON(ARRAY_SIZE(pstore_type_names) != PSTORE_TYPE_MAX);
+
+	if (WARN_ON_ONCE(type >= PSTORE_TYPE_MAX))
+		return "unknown";
+
+	return pstore_type_names[type];
+}
+EXPORT_SYMBOL_GPL(pstore_type_to_name);
+
+enum pstore_type_id pstore_name_to_type(const char *name)
+{
+	int i;
+
+	for (i = 0; i < PSTORE_TYPE_MAX; i++) {
+		if (!strcmp(pstore_type_names[i], name))
+			return i;
+	}
+
+	return PSTORE_TYPE_MAX;
+}
+EXPORT_SYMBOL_GPL(pstore_name_to_type);
+
 static const char *get_reason_str(enum kmsg_dump_reason reason)
 {
 	switch (reason) {
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
index f46e5df76b58..a9ec285d85d1 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -32,21 +32,32 @@
 
 struct module;
 
-/* pstore record types (see fs/pstore/inode.c for filename templates) */
+/*
+ * pstore record types (see fs/pstore/platform.c for pstore_type_names[])
+ * These values may be written to storage (see EFI vars backend), so
+ * they are kind of an ABI. Be careful changing the mappings.
+ */
 enum pstore_type_id {
+	/* Frontend storage types */
 	PSTORE_TYPE_DMESG	= 0,
 	PSTORE_TYPE_MCE		= 1,
 	PSTORE_TYPE_CONSOLE	= 2,
 	PSTORE_TYPE_FTRACE	= 3,
-	/* PPC64 partition types */
+
+	/* PPC64-specific partition types */
 	PSTORE_TYPE_PPC_RTAS	= 4,
 	PSTORE_TYPE_PPC_OF	= 5,
 	PSTORE_TYPE_PPC_COMMON	= 6,
 	PSTORE_TYPE_PMSG	= 7,
 	PSTORE_TYPE_PPC_OPAL	= 8,
-	PSTORE_TYPE_UNKNOWN	= 255
+
+	/* End of the list */
+	PSTORE_TYPE_MAX
 };
 
+const char *pstore_type_to_name(enum pstore_type_id type);
+enum pstore_type_id pstore_name_to_type(const char *name);
+
 struct pstore_info;
 /**
  * struct pstore_record - details of a pstore record entry
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 5d10ad51c1c4..337971c41980 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/pstore.h>
 #include <linux/types.h>
 
 /*
@@ -54,6 +55,7 @@ struct persistent_ram_ecc_info {
  * @paddr:	physical address of the mapped RAM area
  * @size:	size of mapping
  * @label:	unique name of this PRZ
+ * @type:	frontend type for this PRZ
  * @flags:	holds PRZ_FLAGS_* bits
  *
  * @buffer_lock:
@@ -88,6 +90,7 @@ struct persistent_ram_zone {
 	size_t size;
 	void *vaddr;
 	char *label;
+	enum pstore_type_id type;
 	u32 flags;
 
 	raw_spinlock_t buffer_lock;
-- 
2.17.1

