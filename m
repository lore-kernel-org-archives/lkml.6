Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D22C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6F32082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KSnGguZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6F32082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbeKDIvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:51:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34798 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeKDIvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:51:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id f12-v6so1482496plo.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 16:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j8GikLZx2YqH0kMZEzvEE/qzgrdQ/oyX8KYxF7cV5Xg=;
        b=KSnGguZdFZrfSKhILu6wrxBP3LoQaS5ZvDfEDuweCpFK7H9QKA7Ou8IsWEX6i6kqYD
         IohcnVCP7cs43ckvTFryIOcTdBn6hF3lUlp/+Kjpug/Ih3in/ibEyq/9X7YanTCQmIcV
         OHvbEtuZ1QiaQ6M/z0kX50Kitll2VVOC5ivRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j8GikLZx2YqH0kMZEzvEE/qzgrdQ/oyX8KYxF7cV5Xg=;
        b=b20cN4cDdac1AG2P4kTjemDKm7hMyXJ5TmiB6IU1V4Paet9+eYC6VGJNXOv/X4k75S
         ULcx54CGlEYG0emra7rcSwI9tYioxaw9f5p6dUXwXLe/foDglvOgn4r285xiiAYdeY7u
         kAu/8htHATAH1H+NeuKTQFhFWm07csURV93DcJtXCbTADcV8/ZJ5DnioL0zTIXE3+cCe
         2ewVrkM4q9T9bEMgve83RTBKPkHrbhHzATX3WAqgpLV2+/PkNauXCGTBP+NKG3gTNZ/d
         PXd0XSbjC071fvgjeKbQP6Th5vDI3ft3Vuzj+K089G+V/F3zjloAgSgAT8LVLtBg2N9E
         3d9Q==
X-Gm-Message-State: AGRZ1gIacYuBqMmj/em4t+69nyd8XMFSzGGcw9QcxqQZBMkje4MRt6xU
        HI/yTZWbduke0QuMBFQ/cAxcQ67zyDg=
X-Google-Smtp-Source: AJdET5csbEyeLfdEUEW212n6ns7LFlqEnJr58BL1utUn0u5iA9P2cy9fGFisnTrtjV8qkJoKsaQbvw==
X-Received: by 2002:a17:902:e081:: with SMTP id cb1-v6mr16764703plb.206.1541288310824;
        Sat, 03 Nov 2018 16:38:30 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id e8-v6sm9056385pfi.61.2018.11.03.16.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 16:38:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH RFC v2 2/3] pstore: simplify ramoops_get_next_prz arguments
Date:   Sat,  3 Nov 2018 16:38:17 -0700
Message-Id: <20181103233818.44615-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181103233818.44615-1-joel@joelfernandes.org>
References: <20181103233818.44615-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(1) remove type argument from ramoops_get_next_prz

Since we store the type of the prz when we initialize it, we no longer
need to pass it again in ramoops_get_next_prz since we can just use that
to setup the pstore record. So lets remove it from the argument list.

(2) remove max argument from ramoops_get_next_prz

From the code flow, the 'max' checks are already being done on the prz
passed to ramoops_get_next_prz. Lets remove it to simplify this function
and reduce its arguments.

(3) further reduce ramoops_get_next_prz arguments by passing record

Both the id and type fields of a pstore_record are set by
ramoops_get_next_prz. So we can just pass a pointer to the pstore_record
instead of passing individual elements. This results in cleaner more
readable code and fewer lines.

In addition lets also remove the 'update' argument since we can detect
that. Changes are squashed into a single patch to reduce fixup conflicts.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
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
2.19.1.930.g4563a0d9d0-goog

