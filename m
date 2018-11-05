Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1B7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 04:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED2620685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 04:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="X9/3vIrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED2620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbeKEOEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:04:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43954 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeKEOEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:04:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id g7-v6so1520396pfo.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 20:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fQ7YdYkICjPw/2C5B5+8AEZdoq1+WJdi0oi3C0cY4D8=;
        b=X9/3vIrKZ1o7bvpl/+NR/OYg8bafDPcc+H0EcPwL6U9tvqxxgGlAg7ac+SweB+lTzs
         vRMgxFK4hXPOQQUtkpWa5CoxOFos2ICZvM+4uB10T7irhP2e3js1qsosWpdSa/luFT2N
         U4lXWrC9GSWpewzA4xiRevGv9M5m7kg4iv7Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fQ7YdYkICjPw/2C5B5+8AEZdoq1+WJdi0oi3C0cY4D8=;
        b=CTdcDHgyiabznEH+Rn9BZr72G3kuWRV7oiS+bk5+dXvfpJbVlPm0FKgDjBRlEF77jB
         oqQovr4IsPtuMlVoheNbPG/VEdA0+o9UPQ0zyHFf25hFznWbHn3rivHjPHi69/HkEpBI
         sQiPBtz/2Mw/vAudHaYM4Gc1dNHwXpmSU1W6//WlJb08+yFsrngEknT6s/+Prt9Va62p
         eAPKkfqC20qxshm6dM3UCqFF95oQZen991vlbf67ELpeHu4d8VCdUf1ueE5oFbSfyW+T
         lQNdlAtvbOMLf/e036CGaAbmOAgBI/XpociLTYYTzUmiFYOp40EP/GlYJci7+pst7Dpf
         FCug==
X-Gm-Message-State: AGRZ1gI5/SDTqTcJTLpl8q2RZ2LhUAxymJHVTGgyJ8hkCTxFAJWmzhyl
        duNOzKUm87kDhnT0gQfizXUp2vCopiY=
X-Google-Smtp-Source: AJdET5fdvfkuE4K3xg4aJ3kb2uLIxlWo4fHmbjPj05bTMGLSzjjA09FD5+M21xtNXLX5aRDUmNIdBQ==
X-Received: by 2002:a63:1412:: with SMTP id u18mr18434302pgl.247.1541393206026;
        Sun, 04 Nov 2018 20:46:46 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id u13-v6sm39841611pgp.18.2018.11.04.20.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 20:46:44 -0800 (PST)
Date:   Sun, 4 Nov 2018 20:46:43 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH RFC v2 1/3] pstore: map pstore types to names
Message-ID: <20181105044643.GD56850@google.com>
References: <20181103233818.44615-1-joel@joelfernandes.org>
 <20181103233818.44615-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181103233818.44615-2-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 04:38:16PM -0700, Joel Fernandes (Google) wrote:
> In later patches we will need to map types to names, so create a table
> for that which can also be used and reused in different parts of old and
> new code. Also use it to save the type in the PRZ which will be useful
> in later patches.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  fs/pstore/inode.c          | 53 +++++---------------------------------
>  fs/pstore/ram.c            |  4 ++-
>  include/linux/pstore.h     | 37 ++++++++++++++++++++++++++
>  include/linux/pstore_ram.h |  2 ++
>  4 files changed, 48 insertions(+), 48 deletions(-)

The original patch had an unused variable warning, below is the updated one.
Sorry about that and thanks!

---8<-----------------------

From de981d893c5c09c62c7c6d5fc9fe73cfd99ffa48 Mon Sep 17 00:00:00 2001
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date: Sat, 3 Nov 2018 16:10:12 -0700
Subject: [PATCH RFC v3 1/3] pstore: map pstore types to names

In later patches we will need to map types to names, so create a table
for that which can also be used and reused in different parts of old and
new code. Also use it to save the type in the PRZ which will be useful
in later patches.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/pstore/inode.c          | 52 ++++----------------------------------
 fs/pstore/ram.c            |  4 ++-
 include/linux/pstore.h     | 37 +++++++++++++++++++++++++++
 include/linux/pstore_ram.h |  2 ++
 4 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 8cf2218b46a7..4a259fd22df0 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -335,53 +335,11 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
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

