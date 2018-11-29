Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FA2C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E3521019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e68V9t82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E3521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeK3KQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:16:08 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:43021 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeK3KQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:06 -0500
Received: by mail-pf1-f181.google.com with SMTP id w73so1772589pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QE/d1SglKB6BEphQmG1RUCKjXY2bFBx7+L1y7X5yarg=;
        b=e68V9t82T9Cn3AJp5PtGeX7oCoDi/2zQ+AilegNVaqhOciKrKZQY/kLqpAJvEPWDZV
         9SIv/tuJJPCMgOleW06f9NryTJ2GSsDnXmohU0woJ9aP0Z2maGix4KffJGePm7E8idp5
         9HN//l/eElmfNJecfMSIbjGzMF7oHWek0dAxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QE/d1SglKB6BEphQmG1RUCKjXY2bFBx7+L1y7X5yarg=;
        b=HerEvH6h7xgo4uyjSm3K2DSB5IUlY7LI9+guOd7jdHf387uDLwrPwdBOry80nKhOdN
         sfzLQ7zvGriK33hmQp2ThBRhtTcpwJVwlPc4fMey6a4ESFmHj71AUn53DRCnhDNE7kv2
         XMK70Dpwo+sPFTTI2FmCFJq/7b9ihTgP1DLRckkevKyoIpxKgAdNgCIaE5AtsA3JRKJH
         lS7s7RMOFJqrY/lovndpdwB1Cpa0Er7Px5wYf5N+YEbNrgEZASqVw3/0YKHfh1/c+yNA
         CXF8jI5bCDLfg1b6JkLlfI8UcyVqgmDKSFwlOxTHLHlrmOW9GMwUpp2p8u9CTeAQLnyN
         u5pg==
X-Gm-Message-State: AA+aEWbuxkW2QtspF3rpeQiuiNwvbPMaZtkAlFF1UglgLx9pcjvF7m+c
        8I2eoO0IEVXKG+wKHhlxtjEnxw==
X-Google-Smtp-Source: AFSGD/Uplf9gU37JRIIwVJcd9gQ9m1Los8vPcacOpviUK61rZqq1ZfyO54kduK9f4CM2gs8khkPfTA==
X-Received: by 2002:a65:4946:: with SMTP id q6mr2792295pgs.201.1543532937568;
        Thu, 29 Nov 2018 15:08:57 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v15sm4614282pfn.94.2018.11.29.15.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:08:56 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -next v2 07/12] pstore/ram: Add kern-doc for struct persistent_ram_zone
Date:   Thu, 29 Nov 2018 15:08:36 -0800
Message-Id: <20181129230841.29955-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129230841.29955-1-keescook@chromium.org>
References: <20181129230841.29955-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct persistent_ram_zone wasn't well documented. This adds kern-doc
for it.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram_core.c       | 10 +++++++++
 include/linux/pstore_ram.h | 46 +++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 62830734deee..3e9e3ba4fb07 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -29,6 +29,16 @@
 #include <linux/vmalloc.h>
 #include <asm/page.h>
 
+/**
+ * struct persistent_ram_buffer - persistent circular RAM buffer
+ *
+ * @sig:
+ *	signature to indicate header (PERSISTENT_RAM_SIG xor PRZ-type value)
+ * @start:
+ *	offset into @data where the beginning of the stored bytes begin
+ * @size:
+ *	number of valid bytes stored in @data
+ */
 struct persistent_ram_buffer {
 	uint32_t    sig;
 	atomic_t    start;
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 6e94980357d2..5d10ad51c1c4 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -30,6 +30,10 @@
  * PRZ_FLAG_NO_LOCK is used. For all other cases, locking is required.
  */
 #define PRZ_FLAG_NO_LOCK	BIT(0)
+/*
+ * If a PRZ should only have a single-boot lifetime, this marks it as
+ * getting wiped after its contents get copied out after boot.
+ */
 #define PRZ_FLAG_ZAP_OLD	BIT(1)
 
 struct persistent_ram_buffer;
@@ -43,17 +47,53 @@ struct persistent_ram_ecc_info {
 	uint16_t *par;
 };
 
+/**
+ * struct persistent_ram_zone - Details of a persistent RAM zone (PRZ)
+ *                              used as a pstore backend
+ *
+ * @paddr:	physical address of the mapped RAM area
+ * @size:	size of mapping
+ * @label:	unique name of this PRZ
+ * @flags:	holds PRZ_FLAGS_* bits
+ *
+ * @buffer_lock:
+ *	locks access to @buffer "size" bytes and "start" offset
+ * @buffer:
+ *	pointer to actual RAM area managed by this PRZ
+ * @buffer_size:
+ *	bytes in @buffer->data (not including any trailing ECC bytes)
+ *
+ * @par_buffer:
+ *	pointer into @buffer->data containing ECC bytes for @buffer->data
+ * @par_header:
+ *	pointer into @buffer->data containing ECC bytes for @buffer header
+ *	(i.e. all fields up to @data)
+ * @rs_decoder:
+ *	RSLIB instance for doing ECC calculations
+ * @corrected_bytes:
+ *	ECC corrected bytes accounting since boot
+ * @bad_blocks:
+ *	ECC uncorrectable bytes accounting since boot
+ * @ecc_info:
+ *	ECC configuration details
+ *
+ * @old_log:
+ *	saved copy of @buffer->data prior to most recent wipe
+ * @old_log_size:
+ *	bytes contained in @old_log
+ *
+ */
 struct persistent_ram_zone {
 	phys_addr_t paddr;
 	size_t size;
 	void *vaddr;
 	char *label;
-	struct persistent_ram_buffer *buffer;
-	size_t buffer_size;
 	u32 flags;
+
 	raw_spinlock_t buffer_lock;
+	struct persistent_ram_buffer *buffer;
+	size_t buffer_size;
 
-	/* ECC correction */
 	char *par_buffer;
 	char *par_header;
 	struct rs_control *rs_decoder;
-- 
2.17.1

