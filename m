Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1D7C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEA52133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmbU61X9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbeLQNTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:19:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33282 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732708AbeLQNTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:19:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so12267214wrr.0;
        Mon, 17 Dec 2018 05:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DcCHDP0Ar8dnx0qjE9yzkLfW1BdnK8DhCYtJcblvtHQ=;
        b=SmbU61X97RFAq194kUrzsOyz2IuTeZgcq3C3dz1uYhrxfZ26zEtjeyTaWlPl1Tnzz2
         fICuGaQepAK9JV2dB/4d5QAdJwdQeTG4aFGE4Zap/uFgGyOiSLm2DXmnvv5meQDmSsOj
         bCiotStL69NBvWe1d+SmC3ZJ5yEztynAiZI2/fPYuxNX6UOety/BQMoV4KuDIdirpjun
         tBX9f6JFIt0c5wNZ/kAsLBkLFRIlSF816Ia8ZNXWj+97vBmDVvPZpwHJYKQPpmc6k5QF
         fc1P3t1arHw7bzuldx+bQmK8pMuT84TBJFMQAoGwOKmhxHje4uZ5rfKFN76hSWVRVLks
         O0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DcCHDP0Ar8dnx0qjE9yzkLfW1BdnK8DhCYtJcblvtHQ=;
        b=cFbbKEAerr3APf24Jsulhy3gp4aKJpTcpth6kSVCyeJXreISR8PtDEIJamrXy8Asb4
         BLSOfSgGyc/t0OGj55Gy4p59eg3wWip5C4wYpZJv+IYegtLbW6n+9jz+vtP9+854WvzP
         enXTkSLk4mPgCbLzByM8lJpRg2xI5vLhnZbCtQ41wPaDXuUyzQecyKlMGhsxf/IV4qpB
         QaI4oFiU+03ogBxEhmErEa277ZEZcWA5QLwTTYVVvM+eitnaN46ga65xgsSeeR5VMshO
         KQxkiH3/KddaAIPT1iDrLKsq3++rnavzIrVmXtvJroVImqsszqCy4vbIGuxHCcX7atSr
         ejUg==
X-Gm-Message-State: AA+aEWbwboi4++DlBiHVb1i8nTEne2IhjROxioX3NpFM4gKhptYfisnU
        3GCFrrSONEYpkledejLzXg==
X-Google-Smtp-Source: AFSGD/XEr/YBYSzdyL+AuvO0gI5Ph0elMflDfkTPmi1smmn+IZUF/HDpGW0fbIhQ6lsPnbkfkfZKuA==
X-Received: by 2002:a05:6000:10d1:: with SMTP id b17mr10537181wrx.306.1545052782182;
        Mon, 17 Dec 2018 05:19:42 -0800 (PST)
Received: from kmo-pixel.syslink.intern ([93.240.4.121])
        by smtp.gmail.com with ESMTPSA id x20sm20406120wme.6.2018.12.17.05.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 05:19:41 -0800 (PST)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH 3/7] selinux: convert to kvmalloc
Date:   Mon, 17 Dec 2018 08:19:25 -0500
Message-Id: <20181217131929.11727-4-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181217131929.11727-1-kent.overstreet@gmail.com>
References: <20181217131929.11727-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flex arrays were being used for constant sized arrays, so there's no
benefit to using flex_arrays over something simpler.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-security-module@vger.kernel.org
---
 security/selinux/ss/avtab.c       |  40 +++++-----
 security/selinux/ss/avtab.h       |   4 +-
 security/selinux/ss/conditional.c |   6 +-
 security/selinux/ss/policydb.c    | 122 ++++++++----------------------
 security/selinux/ss/policydb.h    |  12 +--
 security/selinux/ss/services.c    |  22 ++----
 6 files changed, 62 insertions(+), 144 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index c0417cf17f..8c5800750f 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -93,12 +93,10 @@ avtab_insert_node(struct avtab *h, int hvalue,
 		newnode->next = prev->next;
 		prev->next = newnode;
 	} else {
-		newnode->next = flex_array_get_ptr(h->htable, hvalue);
-		if (flex_array_put_ptr(h->htable, hvalue, newnode,
-				       GFP_KERNEL|__GFP_ZERO)) {
-			kmem_cache_free(avtab_node_cachep, newnode);
-			return NULL;
-		}
+		struct avtab_node **n = &h->htable[hvalue];
+
+		newnode->next = *n;
+		*n = newnode;
 	}
 
 	h->nel++;
@@ -111,11 +109,11 @@ static int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_dat
 	struct avtab_node *prev, *cur, *newnode;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
-	if (!h || !h->htable)
+	if (!h)
 		return -EINVAL;
 
 	hvalue = avtab_hash(key, h->mask);
-	for (prev = NULL, cur = flex_array_get_ptr(h->htable, hvalue);
+	for (prev = NULL, cur = h->htable[hvalue];
 	     cur;
 	     prev = cur, cur = cur->next) {
 		if (key->source_type == cur->key.source_type &&
@@ -156,10 +154,10 @@ avtab_insert_nonunique(struct avtab *h, struct avtab_key *key, struct avtab_datu
 	struct avtab_node *prev, *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
-	if (!h || !h->htable)
+	if (!h)
 		return NULL;
 	hvalue = avtab_hash(key, h->mask);
-	for (prev = NULL, cur = flex_array_get_ptr(h->htable, hvalue);
+	for (prev = NULL, cur = h->htable[hvalue];
 	     cur;
 	     prev = cur, cur = cur->next) {
 		if (key->source_type == cur->key.source_type &&
@@ -186,11 +184,11 @@ struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *key)
 	struct avtab_node *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
-	if (!h || !h->htable)
+	if (!h)
 		return NULL;
 
 	hvalue = avtab_hash(key, h->mask);
-	for (cur = flex_array_get_ptr(h->htable, hvalue); cur;
+	for (cur = h->htable[hvalue]; cur;
 	     cur = cur->next) {
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
@@ -222,11 +220,11 @@ avtab_search_node(struct avtab *h, struct avtab_key *key)
 	struct avtab_node *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
-	if (!h || !h->htable)
+	if (!h)
 		return NULL;
 
 	hvalue = avtab_hash(key, h->mask);
-	for (cur = flex_array_get_ptr(h->htable, hvalue); cur;
+	for (cur = h->htable[hvalue]; cur;
 	     cur = cur->next) {
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
@@ -281,11 +279,11 @@ void avtab_destroy(struct avtab *h)
 	int i;
 	struct avtab_node *cur, *temp;
 
-	if (!h || !h->htable)
+	if (!h)
 		return;
 
 	for (i = 0; i < h->nslot; i++) {
-		cur = flex_array_get_ptr(h->htable, i);
+		cur = h->htable[i];
 		while (cur) {
 			temp = cur;
 			cur = cur->next;
@@ -295,7 +293,7 @@ void avtab_destroy(struct avtab *h)
 			kmem_cache_free(avtab_node_cachep, temp);
 		}
 	}
-	flex_array_free(h->htable);
+	kvfree(h->htable);
 	h->htable = NULL;
 	h->nslot = 0;
 	h->mask = 0;
@@ -303,6 +301,7 @@ void avtab_destroy(struct avtab *h)
 
 int avtab_init(struct avtab *h)
 {
+	kvfree(h->htable);
 	h->htable = NULL;
 	h->nel = 0;
 	return 0;
@@ -329,8 +328,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 		nslot = MAX_AVTAB_HASH_BUCKETS;
 	mask = nslot - 1;
 
-	h->htable = flex_array_alloc(sizeof(struct avtab_node *), nslot,
-				     GFP_KERNEL | __GFP_ZERO);
+	h->htable = kvcalloc(nslot, sizeof(void *), GFP_KERNEL);
 	if (!h->htable)
 		return -ENOMEM;
 
@@ -353,7 +351,7 @@ void avtab_hash_eval(struct avtab *h, char *tag)
 	max_chain_len = 0;
 	chain2_len_sum = 0;
 	for (i = 0; i < h->nslot; i++) {
-		cur = flex_array_get_ptr(h->htable, i);
+		cur = h->htable[i];
 		if (cur) {
 			slots_used++;
 			chain_len = 0;
@@ -646,7 +644,7 @@ int avtab_write(struct policydb *p, struct avtab *a, void *fp)
 		return rc;
 
 	for (i = 0; i < a->nslot; i++) {
-		for (cur = flex_array_get_ptr(a->htable, i); cur;
+		for (cur = a->htable[i]; cur;
 		     cur = cur->next) {
 			rc = avtab_write_item(p, cur, fp);
 			if (rc)
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 0d652fad53..de16673b23 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -24,7 +24,6 @@
 #define _SS_AVTAB_H_
 
 #include "security.h"
-#include <linux/flex_array.h>
 
 struct avtab_key {
 	u16 source_type;	/* source type */
@@ -84,11 +83,10 @@ struct avtab_node {
 };
 
 struct avtab {
-	struct flex_array *htable;
+	struct avtab_node **htable;
 	u32 nel;	/* number of elements */
 	u32 nslot;      /* number of hash slots */
 	u32 mask;       /* mask to compute hash func */
-
 };
 
 int avtab_init(struct avtab *);
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index f49e522e93..3bbb603452 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -195,7 +195,6 @@ int cond_index_bool(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct cond_bool_datum *booldatum;
-	struct flex_array *fa;
 
 	booldatum = datum;
 	p = datap;
@@ -203,10 +202,7 @@ int cond_index_bool(void *key, void *datum, void *datap)
 	if (!booldatum->value || booldatum->value > p->p_bools.nprim)
 		return -EINVAL;
 
-	fa = p->sym_val_to_name[SYM_BOOLS];
-	if (flex_array_put_ptr(fa, booldatum->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
-		BUG();
+	p->sym_val_to_name[SYM_BOOLS][booldatum->value - 1] = key;
 	p->bool_val_to_struct[booldatum->value - 1] = booldatum;
 
 	return 0;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index f4eadd3f73..16b7027bb7 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -36,7 +36,6 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/audit.h>
-#include <linux/flex_array.h>
 #include "security.h"
 
 #include "policydb.h"
@@ -341,17 +340,14 @@ static int common_index(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct common_datum *comdatum;
-	struct flex_array *fa;
 
 	comdatum = datum;
 	p = datap;
 	if (!comdatum->value || comdatum->value > p->p_commons.nprim)
 		return -EINVAL;
 
-	fa = p->sym_val_to_name[SYM_COMMONS];
-	if (flex_array_put_ptr(fa, comdatum->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
-		BUG();
+	p->sym_val_to_name[SYM_COMMONS][comdatum->value - 1] = key;
+
 	return 0;
 }
 
@@ -359,16 +355,13 @@ static int class_index(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct class_datum *cladatum;
-	struct flex_array *fa;
 
 	cladatum = datum;
 	p = datap;
 	if (!cladatum->value || cladatum->value > p->p_classes.nprim)
 		return -EINVAL;
-	fa = p->sym_val_to_name[SYM_CLASSES];
-	if (flex_array_put_ptr(fa, cladatum->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
-		BUG();
+
+	p->sym_val_to_name[SYM_CLASSES][cladatum->value - 1] = key;
 	p->class_val_to_struct[cladatum->value - 1] = cladatum;
 	return 0;
 }
@@ -377,7 +370,6 @@ static int role_index(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct role_datum *role;
-	struct flex_array *fa;
 
 	role = datum;
 	p = datap;
@@ -386,10 +378,7 @@ static int role_index(void *key, void *datum, void *datap)
 	    || role->bounds > p->p_roles.nprim)
 		return -EINVAL;
 
-	fa = p->sym_val_to_name[SYM_ROLES];
-	if (flex_array_put_ptr(fa, role->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
-		BUG();
+	p->sym_val_to_name[SYM_ROLES][role->value - 1] = key;
 	p->role_val_to_struct[role->value - 1] = role;
 	return 0;
 }
@@ -398,7 +387,6 @@ static int type_index(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct type_datum *typdatum;
-	struct flex_array *fa;
 
 	typdatum = datum;
 	p = datap;
@@ -408,15 +396,8 @@ static int type_index(void *key, void *datum, void *datap)
 		    || typdatum->value > p->p_types.nprim
 		    || typdatum->bounds > p->p_types.nprim)
 			return -EINVAL;
-		fa = p->sym_val_to_name[SYM_TYPES];
-		if (flex_array_put_ptr(fa, typdatum->value - 1, key,
-				       GFP_KERNEL | __GFP_ZERO))
-			BUG();
-
-		fa = p->type_val_to_struct_array;
-		if (flex_array_put_ptr(fa, typdatum->value - 1, typdatum,
-				       GFP_KERNEL | __GFP_ZERO))
-			BUG();
+		p->sym_val_to_name[SYM_TYPES][typdatum->value - 1] = key;
+		p->type_val_to_struct_array[typdatum->value - 1] = typdatum;
 	}
 
 	return 0;
@@ -426,7 +407,6 @@ static int user_index(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct user_datum *usrdatum;
-	struct flex_array *fa;
 
 	usrdatum = datum;
 	p = datap;
@@ -435,10 +415,7 @@ static int user_index(void *key, void *datum, void *datap)
 	    || usrdatum->bounds > p->p_users.nprim)
 		return -EINVAL;
 
-	fa = p->sym_val_to_name[SYM_USERS];
-	if (flex_array_put_ptr(fa, usrdatum->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
-		BUG();
+	p->sym_val_to_name[SYM_USERS][usrdatum->value - 1] = key;
 	p->user_val_to_struct[usrdatum->value - 1] = usrdatum;
 	return 0;
 }
@@ -447,7 +424,6 @@ static int sens_index(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct level_datum *levdatum;
-	struct flex_array *fa;
 
 	levdatum = datum;
 	p = datap;
@@ -456,10 +432,8 @@ static int sens_index(void *key, void *datum, void *datap)
 		if (!levdatum->level->sens ||
 		    levdatum->level->sens > p->p_levels.nprim)
 			return -EINVAL;
-		fa = p->sym_val_to_name[SYM_LEVELS];
-		if (flex_array_put_ptr(fa, levdatum->level->sens - 1, key,
-				       GFP_KERNEL | __GFP_ZERO))
-			BUG();
+
+		p->sym_val_to_name[SYM_LEVELS][levdatum->level->sens - 1] = key;
 	}
 
 	return 0;
@@ -469,7 +443,6 @@ static int cat_index(void *key, void *datum, void *datap)
 {
 	struct policydb *p;
 	struct cat_datum *catdatum;
-	struct flex_array *fa;
 
 	catdatum = datum;
 	p = datap;
@@ -477,10 +450,8 @@ static int cat_index(void *key, void *datum, void *datap)
 	if (!catdatum->isalias) {
 		if (!catdatum->value || catdatum->value > p->p_cats.nprim)
 			return -EINVAL;
-		fa = p->sym_val_to_name[SYM_CATS];
-		if (flex_array_put_ptr(fa, catdatum->value - 1, key,
-				       GFP_KERNEL | __GFP_ZERO))
-			BUG();
+
+		p->sym_val_to_name[SYM_CATS][catdatum->value - 1] = key;
 	}
 
 	return 0;
@@ -568,35 +539,23 @@ static int policydb_index(struct policydb *p)
 	if (!p->user_val_to_struct)
 		return -ENOMEM;
 
-	/* Yes, I want the sizeof the pointer, not the structure */
-	p->type_val_to_struct_array = flex_array_alloc(sizeof(struct type_datum *),
-						       p->p_types.nprim,
-						       GFP_KERNEL | __GFP_ZERO);
+	p->type_val_to_struct_array = kvcalloc(p->p_types.nprim,
+					       sizeof(*p->type_val_to_struct_array),
+					       GFP_KERNEL);
 	if (!p->type_val_to_struct_array)
 		return -ENOMEM;
 
-	rc = flex_array_prealloc(p->type_val_to_struct_array, 0,
-				 p->p_types.nprim, GFP_KERNEL | __GFP_ZERO);
-	if (rc)
-		goto out;
-
 	rc = cond_init_bool_indexes(p);
 	if (rc)
 		goto out;
 
 	for (i = 0; i < SYM_NUM; i++) {
-		p->sym_val_to_name[i] = flex_array_alloc(sizeof(char *),
-							 p->symtab[i].nprim,
-							 GFP_KERNEL | __GFP_ZERO);
+		p->sym_val_to_name[i] = kvcalloc(p->symtab[i].nprim,
+						 sizeof(char *),
+						 GFP_KERNEL);
 		if (!p->sym_val_to_name[i])
 			return -ENOMEM;
 
-		rc = flex_array_prealloc(p->sym_val_to_name[i],
-					 0, p->symtab[i].nprim,
-					 GFP_KERNEL | __GFP_ZERO);
-		if (rc)
-			goto out;
-
 		rc = hashtab_map(p->symtab[i].table, index_f[i], p);
 		if (rc)
 			goto out;
@@ -809,16 +768,13 @@ void policydb_destroy(struct policydb *p)
 		hashtab_destroy(p->symtab[i].table);
 	}
 
-	for (i = 0; i < SYM_NUM; i++) {
-		if (p->sym_val_to_name[i])
-			flex_array_free(p->sym_val_to_name[i]);
-	}
+	for (i = 0; i < SYM_NUM; i++)
+		kvfree(p->sym_val_to_name[i]);
 
 	kfree(p->class_val_to_struct);
 	kfree(p->role_val_to_struct);
 	kfree(p->user_val_to_struct);
-	if (p->type_val_to_struct_array)
-		flex_array_free(p->type_val_to_struct_array);
+	kvfree(p->type_val_to_struct_array);
 
 	avtab_destroy(&p->te_avtab);
 
@@ -871,17 +827,9 @@ void policydb_destroy(struct policydb *p)
 	hashtab_map(p->range_tr, range_tr_destroy, NULL);
 	hashtab_destroy(p->range_tr);
 
-	if (p->type_attr_map_array) {
-		for (i = 0; i < p->p_types.nprim; i++) {
-			struct ebitmap *e;
-
-			e = flex_array_get(p->type_attr_map_array, i);
-			if (!e)
-				continue;
-			ebitmap_destroy(e);
-		}
-		flex_array_free(p->type_attr_map_array);
-	}
+	for (i = 0; i < p->p_types.nprim; i++)
+		ebitmap_destroy(&p->type_attr_map_array[i]);
+	kvfree(p->type_attr_map_array);
 
 	ebitmap_destroy(&p->filename_trans_ttypes);
 	ebitmap_destroy(&p->policycaps);
@@ -1761,8 +1709,7 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
 			return -EINVAL;
 		}
 
-		upper = flex_array_get_ptr(p->type_val_to_struct_array,
-					   upper->bounds - 1);
+		upper = p->type_val_to_struct_array[upper->bounds - 1];
 		BUG_ON(!upper);
 
 		if (upper->attribute) {
@@ -2519,23 +2466,15 @@ int policydb_read(struct policydb *p, void *fp)
 	if (rc)
 		goto bad;
 
-	rc = -ENOMEM;
-	p->type_attr_map_array = flex_array_alloc(sizeof(struct ebitmap),
-						  p->p_types.nprim,
-						  GFP_KERNEL | __GFP_ZERO);
+	p->type_attr_map_array = kvcalloc(p->p_types.nprim,
+					  sizeof(*p->type_attr_map_array),
+					  GFP_KERNEL);
 	if (!p->type_attr_map_array)
 		goto bad;
 
-	/* preallocate so we don't have to worry about the put ever failing */
-	rc = flex_array_prealloc(p->type_attr_map_array, 0, p->p_types.nprim,
-				 GFP_KERNEL | __GFP_ZERO);
-	if (rc)
-		goto bad;
-
 	for (i = 0; i < p->p_types.nprim; i++) {
-		struct ebitmap *e = flex_array_get(p->type_attr_map_array, i);
+		struct ebitmap *e = &p->type_attr_map_array[i];
 
-		BUG_ON(!e);
 		ebitmap_init(e);
 		if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
 			rc = ebitmap_read(e, fp);
@@ -3524,9 +3463,8 @@ int policydb_write(struct policydb *p, void *fp)
 		return rc;
 
 	for (i = 0; i < p->p_types.nprim; i++) {
-		struct ebitmap *e = flex_array_get(p->type_attr_map_array, i);
+		struct ebitmap *e = &p->type_attr_map_array[i];
 
-		BUG_ON(!e);
 		rc = ebitmap_write(e, fp);
 		if (rc)
 			return rc;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 215f8f30ac..27039149ff 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -24,8 +24,6 @@
 #ifndef _SS_POLICYDB_H_
 #define _SS_POLICYDB_H_
 
-#include <linux/flex_array.h>
-
 #include "symtab.h"
 #include "avtab.h"
 #include "sidtab.h"
@@ -251,13 +249,13 @@ struct policydb {
 #define p_cats symtab[SYM_CATS]
 
 	/* symbol names indexed by (value - 1) */
-	struct flex_array *sym_val_to_name[SYM_NUM];
+	char		**sym_val_to_name[SYM_NUM];
 
 	/* class, role, and user attributes indexed by (value - 1) */
 	struct class_datum **class_val_to_struct;
 	struct role_datum **role_val_to_struct;
 	struct user_datum **user_val_to_struct;
-	struct flex_array *type_val_to_struct_array;
+	struct type_datum **type_val_to_struct_array;
 
 	/* type enforcement access vectors and transitions */
 	struct avtab te_avtab;
@@ -294,7 +292,7 @@ struct policydb {
 	struct hashtab *range_tr;
 
 	/* type -> attribute reverse mapping */
-	struct flex_array *type_attr_map_array;
+	struct ebitmap *type_attr_map_array;
 
 	struct ebitmap policycaps;
 
@@ -369,9 +367,7 @@ static inline int put_entry(const void *buf, size_t bytes, int num, struct polic
 
 static inline char *sym_name(struct policydb *p, unsigned int sym_num, unsigned int element_nr)
 {
-	struct flex_array *fa = p->sym_val_to_name[sym_num];
-
-	return flex_array_get_ptr(fa, element_nr);
+	return p->sym_val_to_name[sym_num][element_nr];
 }
 
 extern u16 string_to_security_class(struct policydb *p, const char *name);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 12e4143945..24b59a7e6a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -50,7 +50,6 @@
 #include <linux/audit.h>
 #include <linux/mutex.h>
 #include <linux/selinux.h>
-#include <linux/flex_array.h>
 #include <linux/vmalloc.h>
 #include <net/netlabel.h>
 
@@ -546,15 +545,13 @@ static void type_attribute_bounds_av(struct policydb *policydb,
 	struct type_datum *target;
 	u32 masked = 0;
 
-	source = flex_array_get_ptr(policydb->type_val_to_struct_array,
-				    scontext->type - 1);
+	source = policydb->type_val_to_struct_array[scontext->type - 1];
 	BUG_ON(!source);
 
 	if (!source->bounds)
 		return;
 
-	target = flex_array_get_ptr(policydb->type_val_to_struct_array,
-				    tcontext->type - 1);
+	target = policydb->type_val_to_struct_array[tcontext->type - 1];
 	BUG_ON(!target);
 
 	memset(&lo_avd, 0, sizeof(lo_avd));
@@ -654,11 +651,9 @@ static void context_struct_compute_av(struct policydb *policydb,
 	 */
 	avkey.target_class = tclass;
 	avkey.specified = AVTAB_AV | AVTAB_XPERMS;
-	sattr = flex_array_get(policydb->type_attr_map_array,
-			       scontext->type - 1);
+	sattr = &policydb->type_attr_map_array[scontext->type - 1];
 	BUG_ON(!sattr);
-	tattr = flex_array_get(policydb->type_attr_map_array,
-			       tcontext->type - 1);
+	tattr = &policydb->type_attr_map_array[tcontext->type - 1];
 	BUG_ON(!tattr);
 	ebitmap_for_each_positive_bit(sattr, snode, i) {
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
@@ -901,8 +896,7 @@ int security_bounded_transition(struct selinux_state *state,
 
 	index = new_context->type;
 	while (true) {
-		type = flex_array_get_ptr(policydb->type_val_to_struct_array,
-					  index - 1);
+		type = policydb->type_val_to_struct_array[index - 1];
 		BUG_ON(!type);
 
 		/* not bounded anymore */
@@ -1065,11 +1059,9 @@ void security_compute_xperms_decision(struct selinux_state *state,
 
 	avkey.target_class = tclass;
 	avkey.specified = AVTAB_XPERMS;
-	sattr = flex_array_get(policydb->type_attr_map_array,
-				scontext->type - 1);
+	sattr = &policydb->type_attr_map_array[scontext->type - 1];
 	BUG_ON(!sattr);
-	tattr = flex_array_get(policydb->type_attr_map_array,
-				tcontext->type - 1);
+	tattr = &policydb->type_attr_map_array[tcontext->type - 1];
 	BUG_ON(!tattr);
 	ebitmap_for_each_positive_bit(sattr, snode, i) {
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
-- 
2.20.1

