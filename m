Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13358C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87F021019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f2VvQ6U5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87F021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeK3KQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:16:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36725 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeK3KQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so1792103pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+JQqIj0MWw1IOuLilZFiGQD/V3MoY0tOs8CoVXHsrw8=;
        b=f2VvQ6U5t1ZD3A4bekXjX1Iyx9MHggAberhIeJvuEAr9qApcf4D5vRRqMPonf6ns8j
         IyMcXSsg74w9oirV1zgC+OE2vxHWh2CZy/DdLsHCS9HhGY5g/nbuZIazeW7TVnOgpI81
         lCEnRtxaEitTMvlir/0nyVZAYFYSUtnBTw9Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+JQqIj0MWw1IOuLilZFiGQD/V3MoY0tOs8CoVXHsrw8=;
        b=h5N0bG/pzIt144MxPsizjnmRec8gfeBVopJLuRflFeX0gIf/4/3/yXnEEjVRRuiVR1
         JPSfzoCA2znfXweo5ZBvKV+E4bSJxIQ2pYKLLNwQT4DARunwu2dP9eLOodC/5yG0DDCy
         Kl7/65MI+OTT+e2JfStVIPzfX3y7u7sEMdCMOB9Zm9BiDe9843+FKlLGhaM215scme/2
         1K1Lm5RV029S0C/DcGgd7htPsyBZ9w4LJLQ02zyThzccfeMzEcYsFS6THafLERPwnR1M
         SyyQI+NsAJfbh1szV++hZDCIc8Mc+DKWXkOqJa6WYuOvktmU30bvh99Xh4WGCGnUtGqT
         g8uw==
X-Gm-Message-State: AA+aEWb1gfZbvgx+kwDEBhv1gsrX2uQQvF5TGf/C/JRBwpyd5LoK/9pG
        eVCIHv1ycJe7Z0kpcpvtujENSw==
X-Google-Smtp-Source: AFSGD/XmCdHEzA8I8e8vlMKxRPjp8mlHaYtvRq10aEKlvsojzbse7xqMSYSG/xz2TtMcvm26dWu68Q==
X-Received: by 2002:a63:4d0e:: with SMTP id a14mr2912026pgb.408.1543532941250;
        Thu, 29 Nov 2018 15:09:01 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g15sm15150026pfj.131.2018.11.29.15.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:08:56 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -next v2 11/12] pstore/ram: Simplify ramoops_get_next_prz() arguments
Date:   Thu, 29 Nov 2018 15:08:40 -0800
Message-Id: <20181129230841.29955-12-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129230841.29955-1-keescook@chromium.org>
References: <20181129230841.29955-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

(1) remove type argument from ramoops_get_next_prz()

Since we store the type of the prz when we initialize it, we no longer
need to pass it again in ramoops_get_next_prz() since we can just use
that to setup the pstore record. So lets remove it from the argument list.

(2) remove max argument from ramoops_get_next_prz()

Looking at the code flow, the 'max' checks are already being done on
the prz passed to ramoops_get_next_prz(). Lets remove it to simplify
this function and reduce its arguments.

(3) further reduce ramoops_get_next_prz() arguments by passing record

Both the id and type fields of a pstore_record are set by
ramoops_get_next_prz(). So we can just pass a pointer to the pstore_record
instead of passing individual elements. This results in cleaner more
readable code and fewer lines.

In addition lets also remove the 'update' argument since we can detect
that. Changes are squashed into a single patch to reduce fixup conflicts.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram.c | 48 ++++++++++++++++++------------------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index b174d0fc009f..202eaa82bcc6 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -124,19 +124,17 @@ static int ramoops_pstore_open(struct pstore_info *psi)
 }
 
 static struct persistent_ram_zone *
-ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c, uint max,
-		     u64 *id,
-		     enum pstore_type_id *typep, enum pstore_type_id type,
-		     bool update)
+ramoops_get_next_prz(struct persistent_ram_zone *przs[], int id,
+		     struct pstore_record *record)
 {
 	struct persistent_ram_zone *prz;
-	int i = (*c)++;
+	bool update = (record->type == PSTORE_TYPE_DMESG);
 
 	/* Give up if we never existed or have hit the end. */
-	if (!przs || i >= max)
+	if (!przs)
 		return NULL;
 
-	prz = przs[i];
+	prz = przs[id];
 	if (!prz)
 		return NULL;
 
@@ -147,8 +145,8 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c, uint max,
 	if (!persistent_ram_old_size(prz))
 		return NULL;
 
-	*typep = type;
-	*id = i;
+	record->type = prz->type;
+	record->id = id;
 
 	return prz;
 }
@@ -255,10 +253,8 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 
 	/* Find the next valid persistent_ram_zone for DMESG */
 	while (cxt->dump_read_cnt < cxt->max_dump_cnt && !prz) {
-		prz = ramoops_get_next_prz(cxt->dprzs, &cxt->dump_read_cnt,
-					   cxt->max_dump_cnt, &record->id,
-					   &record->type,
-					   PSTORE_TYPE_DMESG, 1);
+		prz = ramoops_get_next_prz(cxt->dprzs, cxt->dump_read_cnt++,
+					   record);
 		if (!prz_ok(prz))
 			continue;
 		header_length = ramoops_read_kmsg_hdr(persistent_ram_old(prz),
@@ -272,22 +268,18 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 		}
 	}
 
-	if (!prz_ok(prz))
-		prz = ramoops_get_next_prz(&cxt->cprz, &cxt->console_read_cnt,
-					   1, &record->id, &record->type,
-					   PSTORE_TYPE_CONSOLE, 0);
+	if (!prz_ok(prz) && !cxt->console_read_cnt++)
+		prz = ramoops_get_next_prz(&cxt->cprz, 0 /* single */, record);
 
-	if (!prz_ok(prz))
-		prz = ramoops_get_next_prz(&cxt->mprz, &cxt->pmsg_read_cnt,
-					   1, &record->id, &record->type,
-					   PSTORE_TYPE_PMSG, 0);
+	if (!prz_ok(prz) && !cxt->pmsg_read_cnt++)
+		prz = ramoops_get_next_prz(&cxt->mprz, 0 /* single */, record);
 
 	/* ftrace is last since it may want to dynamically allocate memory. */
 	if (!prz_ok(prz)) {
-		if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)) {
-			prz = ramoops_get_next_prz(cxt->fprzs,
-					&cxt->ftrace_read_cnt, 1, &record->id,
-					&record->type, PSTORE_TYPE_FTRACE, 0);
+		if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU) &&
+		    !cxt->ftrace_read_cnt++) {
+			prz = ramoops_get_next_prz(cxt->fprzs, 0 /* single */,
+						   record);
 		} else {
 			/*
 			 * Build a new dummy record which combines all the
@@ -303,11 +295,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 
 			while (cxt->ftrace_read_cnt < cxt->max_ftrace_cnt) {
 				prz_next = ramoops_get_next_prz(cxt->fprzs,
-						&cxt->ftrace_read_cnt,
-						cxt->max_ftrace_cnt,
-						&record->id,
-						&record->type,
-						PSTORE_TYPE_FTRACE, 0);
+						cxt->ftrace_read_cnt++, record);
 
 				if (!prz_ok(prz_next))
 					continue;
-- 
2.17.1

