Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65163C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EFC20840
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CwdFLqdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EFC20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbeKBI5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:57:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34356 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbeKBI5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:57:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id f78-v6so122930pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mqw98XGB8bn4x1touZDy0unH5+VzgCsjZeXRPi8iglQ=;
        b=CwdFLqdO7FjBssdkxX0cPc3aYhEDbddhNQau3q2f6db7bzz1lV3fZGPbiPCJD8WHBX
         OEYys0m3a369j8V61jEOR8KJhd2gI3VOZjM9QUBXf1j/ZeEOCGt5w4JfbF4ua7ZpZIyk
         fl70jYFzyAqWGzqcnD+ujBSbT1CQPuTZFgu4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mqw98XGB8bn4x1touZDy0unH5+VzgCsjZeXRPi8iglQ=;
        b=D5NQEHtgCAeawPsPwHG/6wz8DtM+9vCEtlLQ0W+aWU9vqrslO7DZmTTo4UVuQFGruI
         rn69s8bJVCRUx8X3QmAi+4m3A9YEVPjM3vsq54C0HRpYxuFTK8xsGxlC2/bSjqLfYx1a
         vFyRE19NIxiIaj1KL1kUbIP12SoL59L84LxVijoW4zvT+SETySVte/yQ3RVZWTU9yHXU
         3IODIqCTWahy6aCrOa0+n3czPmRyD3bR9rDobT4zdSfj1G/Ut7dKYg8OJZxTxDgUHABz
         +v1DbzpBIFqbSLxdRSBnONsq9OnQ+G2zEIK8+rZEdFOK3sMFp92mkoIfVz+O6CxZMdA1
         H2zQ==
X-Gm-Message-State: AGRZ1gJkq27j7zAGKT3KA2t6IlV7jJHzwWgiyFIsfT2qybnmr+gEiKcf
        TGMfchzmLtS8sCksFzobcWeHYCKPVYVJ+A==
X-Google-Smtp-Source: AJdET5f7SO5o2H9OKS6QWFL2MJhvOwtOoyaqrsahdNPWrwio6mleP1eCym1eQ4ZUMf8BR94JSz1OuQ==
X-Received: by 2002:a63:e04d:: with SMTP id n13-v6mr9119040pgj.426.1541116330529;
        Thu, 01 Nov 2018 16:52:10 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s4-v6sm14821071pfh.168.2018.11.01.16.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 16:52:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 5/8] pstore: Improve and update some comments and status output
Date:   Thu,  1 Nov 2018 16:51:57 -0700
Message-Id: <20181101235200.28584-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181101235200.28584-1-keescook@chromium.org>
References: <20181101235200.28584-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This improves and updates some comments:
 - dump handler comment out of sync from calling convention
 - fix kern-doc typo

and improves status output:
 - reminder that only kernel crash dumps are compressed
 - do not be silent about ECC infrastructure failures

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c   | 7 +++----
 fs/pstore/ram_core.c   | 4 +++-
 include/linux/pstore.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 8b6028948cf3..a956c7bc3f67 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -304,7 +304,7 @@ static void allocate_buf_for_compression(void)
 	big_oops_buf_sz = size;
 	big_oops_buf = buf;
 
-	pr_info("Using compression: %s\n", zbackend->name);
+	pr_info("Using crash dump compression: %s\n", zbackend->name);
 }
 
 static void free_buf_for_compression(void)
@@ -354,9 +354,8 @@ void pstore_record_init(struct pstore_record *record,
 }
 
 /*
- * callback from kmsg_dump. (s2,l2) has the most recently
- * written bytes, older bytes are in (s1,l1). Save as much
- * as we can from the end of the buffer.
+ * callback from kmsg_dump. Save as much as we can (up to kmsg_bytes) from the
+ * end of the buffer.
  */
 static void pstore_dump(struct kmsg_dumper *dumper,
 			enum kmsg_dump_reason reason)
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 1cda5922b4b4..e859e02f67a8 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -503,8 +503,10 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 	bool zap = !!(prz->flags & PRZ_FLAG_ZAP_OLD);
 
 	ret = persistent_ram_init_ecc(prz, ecc_info);
-	if (ret)
+	if (ret) {
+		pr_warn("ECC failed %s\n", prz->label);
 		return ret;
+	}
 
 	sig ^= PERSISTENT_RAM_SIG;
 
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index a15bc4d48752..877ed81de346 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -85,7 +85,7 @@ struct pstore_record {
 /**
  * struct pstore_info - backend pstore driver structure
  *
- * @owner:	module which is repsonsible for this backend driver
+ * @owner:	module which is responsible for this backend driver
  * @name:	name of the backend driver
  *
  * @buf_lock:	spinlock to serialize access to @buf
-- 
2.17.1

