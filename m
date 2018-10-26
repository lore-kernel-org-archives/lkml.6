Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684B3ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3197E20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="doISts0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3197E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeJ0Ciz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:38:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38768 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeJ0Ciy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:38:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so887376pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JkvI2LtU4+bmcOxnBCaikgOqV8jjRu/1r93M6avwadE=;
        b=doISts0CKX/MCMl+/IfiI938vbjKqjaK6FSbvcc/d/n70+d8dSNDROrp227SdScJ+z
         Pxub8BR6+fFTW8MgBA6WvuRpq54Yh3Yw0z3HmbicvFd5S7grjLeIteuHfII1CNUJMTe6
         W2zk9KOiLTkjD5LpjzFkZIwiZNaoZWr3oJbRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JkvI2LtU4+bmcOxnBCaikgOqV8jjRu/1r93M6avwadE=;
        b=AWBj0BWd3dqC4zGr5pTy4zN46JRWlqbLsqHOjyAnTQl+inS2FWKcU1MtMwV8TNAYrU
         gi+Hx456fXP9J2kRd8wBjFFq+Z3Fpwy2deLZsLHcbtBWlLH39aSbtyPrFndJvRrsUTaP
         Xe7k4srRZP02Ppm7a6vGt6ojHwoKENL6GbFQxYOMxAHZLfR/b5dFMXsV/nqUHI7NIDh+
         QqGS/3s+qhuY3A3lh9a9u8HaPZ4EEd4ubBEy165k10Q/S9BnjrA4nEYIUeuFJx5/yrdJ
         CFwMyZntlkaiUZrqJ0rgvR9FL84fG9bui5OHNnOD2sThgqLSnySxujKS4d60VZkoSkWk
         F0ww==
X-Gm-Message-State: AGRZ1gKDevhCvntl/DNDR+M7XC39WddrXcvVcQ4npYem1YF9MKzV326X
        Cs+wBXG/FFsDJrhe+CpnSNs06obsgHM=
X-Google-Smtp-Source: AJdET5d91tTQN6sjK7l2wK2bcHBSO3FfqMjchT2aE48F7Z2KqMZn96luk46RFpkEELkXr0WCAi4dUg==
X-Received: by 2002:a63:cb03:: with SMTP id p3-v6mr682862pgg.47.1540576855151;
        Fri, 26 Oct 2018 11:00:55 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id v5-v6sm17521243pfd.64.2018.10.26.11.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 11:00:53 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [RFC 4/6] pstore: further reduce ramoops_get_next_prz arguments by passing record
Date:   Fri, 26 Oct 2018 11:00:40 -0700
Message-Id: <20181026180042.52199-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181026180042.52199-1-joel@joelfernandes.org>
References: <20181026180042.52199-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the id and type fields of a pstore_record are set by
ramoops_get_next_prz. So we can just pass a pointer to the pstore_record
instead of passing individual elements. This results in cleaner more
readable code and fewer lines.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/pstore/ram.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 3055e05acab1..710c3d30bac0 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -125,7 +125,7 @@ static int ramoops_pstore_open(struct pstore_info *psi)
 
 static struct persistent_ram_zone *
 ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c,
-		     u64 *id, enum pstore_type_id *typep, bool update)
+		     struct pstore_record *record, bool update)
 {
 	struct persistent_ram_zone *prz;
 	int i = (*c)++;
@@ -145,8 +145,8 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c,
 	if (!persistent_ram_old_size(prz))
 		return NULL;
 
-	*typep = prz->type;
-	*id = i;
+	record->type = prz->type;
+	record->id = i;
 
 	return prz;
 }
@@ -254,7 +254,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 	/* Find the next valid persistent_ram_zone for DMESG */
 	while (cxt->dump_read_cnt < cxt->max_dump_cnt && !prz) {
 		prz = ramoops_get_next_prz(cxt->dprzs, &cxt->dump_read_cnt,
-					   &record->id, &record->type, 1);
+					   record, 1);
 		if (!prz_ok(prz))
 			continue;
 		header_length = ramoops_read_kmsg_hdr(persistent_ram_old(prz),
@@ -270,18 +270,17 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 
 	if (!prz_ok(prz))
 		prz = ramoops_get_next_prz(&cxt->cprz, &cxt->console_read_cnt,
-					   &record->id, &record->type, 0);
+					   record, 0);
 
 	if (!prz_ok(prz))
 		prz = ramoops_get_next_prz(&cxt->mprz, &cxt->pmsg_read_cnt,
-					   &record->id, &record->type, 0);
+					   record, 0);
 
 	/* ftrace is last since it may want to dynamically allocate memory. */
 	if (!prz_ok(prz)) {
 		if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)) {
 			prz = ramoops_get_next_prz(cxt->fprzs,
-					&cxt->ftrace_read_cnt, &record->id,
-					&record->type, 0);
+					&cxt->ftrace_read_cnt, record, 0);
 		} else {
 			/*
 			 * Build a new dummy record which combines all the
@@ -298,8 +297,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 			while (cxt->ftrace_read_cnt < cxt->max_ftrace_cnt) {
 				prz_next = ramoops_get_next_prz(cxt->fprzs,
 						&cxt->ftrace_read_cnt,
-						&record->id,
-						&record->type, 0);
+						record, 0);
 
 				if (!prz_ok(prz_next))
 					continue;
-- 
2.19.1.568.g152ad8e336-goog

