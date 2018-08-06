Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEAAC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2B821A5A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6m4ApkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2B821A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbeHFXaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:30:35 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:55853 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbeHFXaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:30:35 -0400
Received: by mail-io0-f202.google.com with SMTP id p2-v6so1558597iom.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 14:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=z1YkuEhJSa76Eh6u3qIGx1kWICWudnLuyFUEwJXWRR8=;
        b=X6m4ApkCej0KtfXj0K/xomJcEVwyvE3BUab/zxolddebuNo9pmkQ+yQJ9pybskcQV5
         bUcREjvkgaih/xa7OkJp6eDqCC4+CzkuQDe1HTXbBEJ5DW0lzSWMfC9vUoFkFnZW0KN1
         7A1XjyznOIZmvLREqoLFoaMnBRyNTrJAX814t0Xrdh/y+evhFMVRX7SwJjRithodK/9i
         JTJb3luhVs1lxFtw6ez0g+55isRrxNhbm1+OpuiLcezd2UrB0V4RyX1ReYsWpaHMSpmj
         Co8A87JMnxy2q/MsNwJwSmzdmTePJjE7XlKrQmahLWC0JRP0Bv6OZztDPPOsTdA5La5b
         LeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=z1YkuEhJSa76Eh6u3qIGx1kWICWudnLuyFUEwJXWRR8=;
        b=mfI+eQhM+v7H4ZlzrwedMGNunzzKsuNwTcvZi97wH1yMOJBePg7BNVBwq2xgt47p1g
         gf7a1gpzww0UijYlBKBSU1QCpUrtbjqE1jeTqP15mXZJBxcKqEFfI6sc26nXWcyuXMSZ
         Bvth3ed9UNnPNDUD+TwWelplhdROYTx8HCfaeu8c5PsTa2TLOuAepyiH7jA6jbUs5j0S
         g/stnmhI7O9rQdmD51t5HfjCP0Cii4J4/64CAqCw85NoRYH9BpDlVW7D6UKek/kzE3Lh
         RRd0wnqhWYE8XSJOExKCu3kpUK7BMyKm0yvqvAQDz5RVg5S0fM5AxwtHP+FWtzseYo+C
         I2zA==
X-Gm-Message-State: AOUpUlGQq/p59ObNQx881Co0bqlsNkYtliMR5lqNMe3Yd5EXp8YULzUd
        Av6jw684EQGRmamZ97GVMc5EV/8CdQ==
X-Google-Smtp-Source: AA+uWPw3+e8RGAdyw6tf8Pah9CMPbjOwRpDCivdq588qJ4+zclQU0zS0rI2HkgtYsMRzwueN2QDwtoJ8eg==
X-Received: by 2002:a6b:b251:: with SMTP id b78-v6mr8303163iof.128.1533590378252;
 Mon, 06 Aug 2018 14:19:38 -0700 (PDT)
Date:   Mon,  6 Aug 2018 23:19:32 +0200
Message-Id: <20180806211932.198488-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] selinux: refactor mls_context_to_sid() and make it stricter
From:   Jann Horn <jannh@google.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        jannh@google.com
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intended behavior change for this patch is to reject any MLS strings
that contain (trailing) garbage if p->mls_enabled is true.

As suggested by Paul Moore, change mls_context_to_sid() so that the two
parts of the range are extracted before the rest of the parsing. Because
now we don't have to scan for two different separators simultaneously
everywhere, we can actually switch to strchr() everywhere instead of the
open-coded loops that scan for two separators at once.

mls_context_to_sid() used to signal how much of the input string was parsed
by updating `*scontext`. However, there is actually no case in which
mls_context_to_sid() only parses a subset of the input and still returns
a success (other than the buggy case with a second '-' in which it
incorrectly claims to have consumed the entire string). Turn `scontext`
into a simple pointer argument and stop redundantly checking whether the
entire input was consumed in string_to_context_struct(). This also lets us
remove the `scontext_len` argument from `string_to_context_struct()`.

Signed-off-by: Jann Horn <jannh@google.com>
---
Refactored version of
"[PATCH] selinux: stricter parsing in mls_context_to_sid()" based on
Paul's comments. WDYT?
I've thrown some inputs at it, and it seems to work.

 security/selinux/ss/mls.c      | 178 ++++++++++++++-------------------
 security/selinux/ss/mls.h      |   2 +-
 security/selinux/ss/services.c |  12 +--
 3 files changed, 82 insertions(+), 110 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 39475fb455bc..2fe459df3c85 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -218,9 +218,7 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
 /*
  * Set the MLS fields in the security context structure
  * `context' based on the string representation in
- * the string `*scontext'.  Update `*scontext' to
- * point to the end of the string representation of
- * the MLS fields.
+ * the string `scontext'.
  *
  * This function modifies the string in place, inserting
  * NULL characters to terminate the MLS fields.
@@ -235,22 +233,21 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
  */
 int mls_context_to_sid(struct policydb *pol,
 		       char oldc,
-		       char **scontext,
+		       char *scontext,
 		       struct context *context,
 		       struct sidtab *s,
 		       u32 def_sid)
 {
-
-	char delim;
-	char *scontextp, *p, *rngptr;
+	char *sensitivity, *cur_cat, *next_cat, *rngptr;
 	struct level_datum *levdatum;
 	struct cat_datum *catdatum, *rngdatum;
-	int l, rc = -EINVAL;
+	int l, rc, i;
+	char *rangep[2];
 
 	if (!pol->mls_enabled) {
-		if (def_sid != SECSID_NULL && oldc)
-			*scontext += strlen(*scontext) + 1;
-		return 0;
+		if ((def_sid != SECSID_NULL && oldc) || (*scontext) == '\0')
+			return 0;
+		return -EINVAL;
 	}
 
 	/*
@@ -261,113 +258,94 @@ int mls_context_to_sid(struct policydb *pol,
 		struct context *defcon;
 
 		if (def_sid == SECSID_NULL)
-			goto out;
+			return -EINVAL;
 
 		defcon = sidtab_search(s, def_sid);
 		if (!defcon)
-			goto out;
+			return -EINVAL;
 
-		rc = mls_context_cpy(context, defcon);
-		goto out;
+		return mls_context_cpy(context, defcon);
 	}
 
-	/* Extract low sensitivity. */
-	scontextp = p = *scontext;
-	while (*p && *p != ':' && *p != '-')
-		p++;
-
-	delim = *p;
-	if (delim != '\0')
-		*p++ = '\0';
+	/*
+	 * If we're dealing with a range, figure out where the two parts
+	 * of the range begin.
+	 */
+	rangep[0] = scontext;
+	rangep[1] = strchr(scontext, '-');
+	if (rangep[1]) {
+		rangep[1][0] = '\0';
+		rangep[1]++;
+	}
 
+	/* For each part of the range: */
 	for (l = 0; l < 2; l++) {
-		levdatum = hashtab_search(pol->p_levels.table, scontextp);
-		if (!levdatum) {
-			rc = -EINVAL;
-			goto out;
-		}
+		/* Split sensitivity and category set. */
+		sensitivity = rangep[l];
+		if (sensitivity == NULL)
+			break;
+		next_cat = strchr(sensitivity, ':');
+		if (next_cat)
+			*(next_cat++) = '\0';
 
+		/* Parse sensitivity. */
+		levdatum = hashtab_search(pol->p_levels.table, sensitivity);
+		if (!levdatum)
+			return -EINVAL;
 		context->range.level[l].sens = levdatum->level->sens;
 
-		if (delim == ':') {
-			/* Extract category set. */
-			while (1) {
-				scontextp = p;
-				while (*p && *p != ',' && *p != '-')
-					p++;
-				delim = *p;
-				if (delim != '\0')
-					*p++ = '\0';
-
-				/* Separate into range if exists */
-				rngptr = strchr(scontextp, '.');
-				if (rngptr != NULL) {
-					/* Remove '.' */
-					*rngptr++ = '\0';
-				}
+		/* Extract category set. */
+		while (next_cat != NULL) {
+			cur_cat = next_cat;
+			next_cat = strchr(next_cat, ',');
+			if (next_cat != NULL)
+				*(next_cat++) = '\0';
+
+			/* Separate into range if exists */
+			rngptr = strchr(cur_cat, '.');
+			if (rngptr != NULL) {
+				/* Remove '.' */
+				*rngptr++ = '\0';
+			}
 
-				catdatum = hashtab_search(pol->p_cats.table,
-							  scontextp);
-				if (!catdatum) {
-					rc = -EINVAL;
-					goto out;
-				}
+			catdatum = hashtab_search(pol->p_cats.table, cur_cat);
+			if (!catdatum)
+				return -EINVAL;
 
-				rc = ebitmap_set_bit(&context->range.level[l].cat,
-						     catdatum->value - 1, 1);
-				if (rc)
-					goto out;
-
-				/* If range, set all categories in range */
-				if (rngptr) {
-					int i;
-
-					rngdatum = hashtab_search(pol->p_cats.table, rngptr);
-					if (!rngdatum) {
-						rc = -EINVAL;
-						goto out;
-					}
-
-					if (catdatum->value >= rngdatum->value) {
-						rc = -EINVAL;
-						goto out;
-					}
-
-					for (i = catdatum->value; i < rngdatum->value; i++) {
-						rc = ebitmap_set_bit(&context->range.level[l].cat, i, 1);
-						if (rc)
-							goto out;
-					}
-				}
+			rc = ebitmap_set_bit(&context->range.level[l].cat,
+					     catdatum->value - 1, 1);
+			if (rc)
+				return rc;
+
+			/* If range, set all categories in range */
+			if (rngptr == NULL)
+				continue;
+
+			rngdatum = hashtab_search(pol->p_cats.table, rngptr);
+			if (!rngdatum)
+				return -EINVAL;
+
+			if (catdatum->value >= rngdatum->value)
+				return -EINVAL;
 
-				if (delim != ',')
-					break;
+			for (i = catdatum->value; i < rngdatum->value; i++) {
+				rc = ebitmap_set_bit(&context->range.level[l].cat, i, 1);
+				if (rc)
+					return rc;
 			}
 		}
-		if (delim == '-') {
-			/* Extract high sensitivity. */
-			scontextp = p;
-			while (*p && *p != ':')
-				p++;
-
-			delim = *p;
-			if (delim != '\0')
-				*p++ = '\0';
-		} else
-			break;
 	}
 
-	if (l == 0) {
+	/* If we didn't see a '-', the range start is also the range end. */
+	if (rangep[1] == NULL) {
 		context->range.level[1].sens = context->range.level[0].sens;
 		rc = ebitmap_cpy(&context->range.level[1].cat,
 				 &context->range.level[0].cat);
 		if (rc)
-			goto out;
+			return rc;
 	}
-	*scontext = ++p;
-	rc = 0;
-out:
-	return rc;
+
+	return 0;
 }
 
 /*
@@ -379,21 +357,19 @@ int mls_context_to_sid(struct policydb *pol,
 int mls_from_string(struct policydb *p, char *str, struct context *context,
 		    gfp_t gfp_mask)
 {
-	char *tmpstr, *freestr;
+	char *tmpstr;
 	int rc;
 
 	if (!p->mls_enabled)
 		return -EINVAL;
 
-	/* we need freestr because mls_context_to_sid will change
-	   the value of tmpstr */
-	tmpstr = freestr = kstrdup(str, gfp_mask);
+	tmpstr = kstrdup(str, gfp_mask);
 	if (!tmpstr) {
 		rc = -ENOMEM;
 	} else {
-		rc = mls_context_to_sid(p, ':', &tmpstr, context,
+		rc = mls_context_to_sid(p, ':', tmpstr, context,
 					NULL, SECSID_NULL);
-		kfree(freestr);
+		kfree(tmpstr);
 	}
 
 	return rc;
diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index 9a3ff7af70ad..67093647576d 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -34,7 +34,7 @@ int mls_level_isvalid(struct policydb *p, struct mls_level *l);
 
 int mls_context_to_sid(struct policydb *p,
 		       char oldc,
-		       char **scontext,
+		       char *scontext,
 		       struct context *context,
 		       struct sidtab *s,
 		       u32 def_sid);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index dd2ceec06fef..9212d4dd817a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1367,7 +1367,6 @@ int security_sid_to_context_force(struct selinux_state *state, u32 sid,
 static int string_to_context_struct(struct policydb *pol,
 				    struct sidtab *sidtabp,
 				    char *scontext,
-				    u32 scontext_len,
 				    struct context *ctx,
 				    u32 def_sid)
 {
@@ -1428,15 +1427,12 @@ static int string_to_context_struct(struct policydb *pol,
 
 	ctx->type = typdatum->value;
 
-	rc = mls_context_to_sid(pol, oldc, &p, ctx, sidtabp, def_sid);
+	rc = mls_context_to_sid(pol, oldc, p, ctx, sidtabp, def_sid);
 	if (rc)
 		goto out;
 
-	rc = -EINVAL;
-	if ((p - scontext) < scontext_len)
-		goto out;
-
 	/* Check the validity of the new context. */
+	rc = -EINVAL;
 	if (!policydb_context_isvalid(pol, ctx))
 		goto out;
 	rc = 0;
@@ -1491,7 +1487,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 	policydb = &state->ss->policydb;
 	sidtab = &state->ss->sidtab;
 	rc = string_to_context_struct(policydb, sidtab, scontext2,
-				      scontext_len, &context, def_sid);
+				      &context, def_sid);
 	if (rc == -EINVAL && force) {
 		context.str = str;
 		context.len = strlen(str) + 1;
@@ -1959,7 +1955,7 @@ static int convert_context(u32 key,
 			goto out;
 
 		rc = string_to_context_struct(args->newp, NULL, s,
-					      c->len, &ctx, SECSID_NULL);
+					      &ctx, SECSID_NULL);
 		kfree(s);
 		if (!rc) {
 			printk(KERN_INFO "SELinux:  Context %s became valid (mapped).\n",
-- 
2.18.0.597.ga71716f1ad-goog

