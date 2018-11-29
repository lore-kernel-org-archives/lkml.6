Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E8FC64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2402020673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jRCZPc8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2402020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeK3KRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:17:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33013 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbeK3KQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so1793780pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ND6k4ouTg4IDxqilUc081KI8dVfG8RVX8Ga+YXLF9/I=;
        b=jRCZPc8ifxc6K1k3WCdEZPPJyLPjXqT7G4TtWxiAtBc28KaQ+Kk39evPYWGLODQ58F
         nz1RMUVwjpqN90qPdoVt0yX2jyF5xkTAhdHlyHEeHNVce23N6qIma5mqVlRk2R2jWy+P
         qOPcguYBVhmOJ8TOT4GI3r06FeCbvhO1WHDV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ND6k4ouTg4IDxqilUc081KI8dVfG8RVX8Ga+YXLF9/I=;
        b=HB37vc0ltPe7WcudenFC58BvqCo0jEWK6C4T71VBR1ttDbBdSMylDivQQd9Cef8spq
         VYRfFxSHXyxuogUSkwLtL7+/ji+7QcaZ1NECdBRhU0W4EF+5PRZfqhII9YzjG989hHsk
         p0UPHVIc9CHHZr1AEzP7hgQFjXFJl5lVXkAKoHItfg8ZBsmJC/p3252ShqH3XdpZbsoa
         d9TzHwJy3P4huMUjIHkT9rgvPj2/83xjxh9tYjUpDkUOxnKaoB02VlpD5+9atdvkQQzo
         pWLffFCvrJ5UqElPYTueoasP8aOXuL6W8ze6/G4vueJQS7DfE1W39jRXm5kZ1X27Dvqu
         Lfmg==
X-Gm-Message-State: AA+aEWYzsj+zuoGHQUcT9qUOesspNLun5VDkNRt3qwps3pzkS47bL0hY
        ozgdG5KZz8bQySkAtRJVDmGZSw==
X-Google-Smtp-Source: AFSGD/WzShcPbcCng0JwiY/YMozJjjIi1voV3BEcv6HeLujZfpGJluROj/XxPLUOJH697EOckNIdow==
X-Received: by 2002:a63:be4d:: with SMTP id g13mr2906773pgo.378.1543532939248;
        Thu, 29 Nov 2018 15:08:59 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r66sm4513532pfk.157.2018.11.29.15.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:08:56 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -next v2 08/12] pstore: Improve and update some comments and status output
Date:   Thu, 29 Nov 2018 15:08:37 -0800
Message-Id: <20181129230841.29955-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129230841.29955-1-keescook@chromium.org>
References: <20181129230841.29955-1-keescook@chromium.org>
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
index a75756c48e10..32340e7dd6a5 100644
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
index 3e9e3ba4fb07..e6375439c5ac 100644
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
index 30fcec375a3a..81669aa80027 100644
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

