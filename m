Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89223C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F30205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l2K1q5Yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F30205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeKBI5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:57:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35885 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbeKBI5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:57:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24-v6so114633plq.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BhxUm2Mb9r4YH/NX06UHGIlCxe0Ic7nvXZn+3t+XI8g=;
        b=l2K1q5YtruR9w7EOd/bMV4+xfzTpbOdbGYStQQCIEAzTT9wAnIibPjG2A/Wzw9ksvM
         RHNYoz5LHSJ6aNd9U/5lw0HzxaZkc7cAsKITNvb8xRLCmyvdZvXH06FBcQ1V0FsVc2h1
         6TNDdBNcssW6KakdL5egGlrNORRN1hQFsF8Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BhxUm2Mb9r4YH/NX06UHGIlCxe0Ic7nvXZn+3t+XI8g=;
        b=PAO+Vo53cH2SnbyrexDp7baViD9eSZiQ18ThAfWWIXFKBRvKJu3nESRou8kCzL5s5B
         fSp6twyPHqsZzJEy3qzltlj24drSKLUYhHLrdNPmQPRp+dhEKZKg13qj77//NsG83kN1
         PIVG1WplNnxDZm5naAEVxXs2ruNBvcI3B7iALfCuPH/vF+9zq+hGsS8k0FkqTfWI5RO+
         BwEerYO2QPMR3goPfnLxIJYZMUqIh2tDAWsg49NIMe/TgFB+5VC1vKGy3xjti69pfOfe
         OobfMgp3Sk/trxg5jKZylRyDPloUWwsmFeFrGeQVhPMgC6EJdOhcfMEXXzw4brz6FrAV
         mOVQ==
X-Gm-Message-State: AGRZ1gIHyjnyIcFbOeVGb664NRQAm2NG50pvsEo4Y88A2trd7XlcYG+E
        YpYvik/so/8K/sQYT2P+lqYvLQ==
X-Google-Smtp-Source: AJdET5fNB2qBaqu/EZR7JhsOLJdykEFGijBm1uy//+/DNcycK+GuEESFOZ78BCdkGjsbtEZzvOn5gg==
X-Received: by 2002:a17:902:a50e:: with SMTP id s14-v6mr9577680plq.78.1541116324702;
        Thu, 01 Nov 2018 16:52:04 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z7-v6sm20511337pgi.42.2018.11.01.16.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 16:52:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 4/8] pstore/ram: Add kern-doc for struct persistent_ram_zone
Date:   Thu,  1 Nov 2018 16:51:56 -0700
Message-Id: <20181101235200.28584-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181101235200.28584-1-keescook@chromium.org>
References: <20181101235200.28584-1-keescook@chromium.org>
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
index d5bf9be82545..1cda5922b4b4 100644
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

