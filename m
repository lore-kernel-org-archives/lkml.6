Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBF2ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C7A208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eXMdlmZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C7A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeJSC6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:58:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39465 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbeJSC6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:58:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id e67-v6so5737674plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 11:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WKqeTf6VlgBnUdMaRcxH13Q5bLcshqjvikwwJeKr8AE=;
        b=eXMdlmZNpPXFIvLJ97ofjCoO/AeG6d/3sLDqR3DL5clrggo2cRFtK0jtPOysPivCbR
         ZJujy3AdfaDg8s8bB+ovvIZMlNdU2CWLIiyMbx2F+R0Z2KxtpXzZqW0KaG0vXN2EzFGW
         gdtQuaCIln1eCCNsl0Kvp50vDnkvQEdFFrTAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WKqeTf6VlgBnUdMaRcxH13Q5bLcshqjvikwwJeKr8AE=;
        b=oVJdO6P7j2oGUZr4fY5fr4TV+AKgzvDQM5rI1Gaa1ko4Wc6HRkdX9dLkT/+2gN8Lf9
         t2po6iWD/tC9dhFEe5OtSRnAwgL5j8YkYT8hH0aBQn2cn6BgYYr08CrSGbi30KkPcWYC
         o5g9PVZOfhALgwG6SqUxdPR5sdluMr5r//2DAgu1Yeej/1IwB1ntTcH28Qta21r3x0Hd
         5G74smiNqMRWTQQovq9ylvHcGSD+4Ow68/GxN6hv1U+wdGg6Klz+ogCxGsmT32aohcAp
         2lhNaQC6a2+MIjhYKgbqOM7frI+MNA0nrsgRTBxEFbMgfOM4GzK2HPicm8dCiIjPrATO
         MsdA==
X-Gm-Message-State: ABuFfojehAM65oK2i0wr4cEqAI+fKKF7gggRfqYMCpVazGlQ3MVlPNll
        RueqWsfKMfGh4kFJ5oxO1u82lA==
X-Google-Smtp-Source: ACcGV63K3Vhy9Oa3htr7I9rkp06AQi6NCA8uLduXeynvGFNNYomzjiIQBvSvucljl0xwoAAyAxwJVA==
X-Received: by 2002:a17:902:7285:: with SMTP id d5-v6mr26733139pll.145.1539888983404;
        Thu, 18 Oct 2018 11:56:23 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g3-v6sm24221864pgn.37.2018.10.18.11.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 11:56:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH pstore-next v2 4/4] pstore/ram: Clarify resource reservation labels
Date:   Thu, 18 Oct 2018 11:56:16 -0700
Message-Id: <20181018185616.14768-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018185616.14768-1-keescook@chromium.org>
References: <20181018185616.14768-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ramoops reserved a memory region in the kernel, it had an unhelpful
label of "persistent_memory". When reading /proc/iomem, it would be
repeated many times, did not hint that it was ramoops in particular,
and didn't clarify very much about what each was used for:

400000000-407ffffff : Persistent Memory (legacy)
  400000000-400000fff : persistent_memory
  400001000-400001fff : persistent_memory
...
  4000ff000-4000fffff : persistent_memory

Instead, this adds meaningful labels for how the various regions are
being used:

400000000-407ffffff : Persistent Memory (legacy)
  400000000-400000fff : ramoops:dump(0/252)
  400001000-400001fff : ramoops:dump(1/252)
...
  4000fc000-4000fcfff : ramoops:dump(252/252)
  4000fd000-4000fdfff : ramoops:console
  4000fe000-4000fe3ff : ramoops:ftrace(0/3)
  4000fe400-4000fe7ff : ramoops:ftrace(1/3)
  4000fe800-4000febff : ramoops:ftrace(2/3)
  4000fec00-4000fefff : ramoops:ftrace(3/3)
  4000ff000-4000fffff : ramoops:pmsg

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 fs/pstore/ram.c            | 16 +++++++++++++---
 fs/pstore/ram_core.c       | 11 +++++++----
 include/linux/pstore_ram.h |  3 ++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 6ea9cd801044..ffcff6516e89 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -587,9 +587,16 @@ static int ramoops_init_przs(const char *name,
 		goto fail;
 
 	for (i = 0; i < *cnt; i++) {
+		char *label;
+
+		if (*cnt == 1)
+			label = kasprintf(GFP_KERNEL, "ramoops:%s", name);
+		else
+			label = kasprintf(GFP_KERNEL, "ramoops:%s(%d/%d)",
+					  name, i, *cnt - 1);
 		prz_ar[i] = persistent_ram_new(*paddr, zone_sz, sig,
-						  &cxt->ecc_info,
-						  cxt->memtype, flags);
+					       &cxt->ecc_info,
+					       cxt->memtype, flags, label);
 		if (IS_ERR(prz_ar[i])) {
 			err = PTR_ERR(prz_ar[i]);
 			dev_err(dev, "failed to request %s mem region (0x%zx@0x%llx): %d\n",
@@ -619,6 +626,8 @@ static int ramoops_init_prz(const char *name,
 			    struct persistent_ram_zone **prz,
 			    phys_addr_t *paddr, size_t sz, u32 sig)
 {
+	char *label;
+
 	if (!sz)
 		return 0;
 
@@ -629,8 +638,9 @@ static int ramoops_init_prz(const char *name,
 		return -ENOMEM;
 	}
 
+	label = kasprintf(GFP_KERNEL, "ramoops:%s", name);
 	*prz = persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
-				  cxt->memtype, 0);
+				  cxt->memtype, 0, label);
 	if (IS_ERR(*prz)) {
 		int err = PTR_ERR(*prz);
 
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 0792595ebcfb..12e21f789194 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -438,11 +438,11 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size,
 }
 
 static void *persistent_ram_iomap(phys_addr_t start, size_t size,
-		unsigned int memtype)
+		unsigned int memtype, char *label)
 {
 	void *va;
 
-	if (!request_mem_region(start, size, "persistent_ram")) {
+	if (!request_mem_region(start, size, label ?: "ramoops")) {
 		pr_err("request mem region (0x%llx@0x%llx) failed\n",
 			(unsigned long long)size, (unsigned long long)start);
 		return NULL;
@@ -470,7 +470,8 @@ static int persistent_ram_buffer_map(phys_addr_t start, phys_addr_t size,
 	if (pfn_valid(start >> PAGE_SHIFT))
 		prz->vaddr = persistent_ram_vmap(start, size, memtype);
 	else
-		prz->vaddr = persistent_ram_iomap(start, size, memtype);
+		prz->vaddr = persistent_ram_iomap(start, size, memtype,
+						  prz->label);
 
 	if (!prz->vaddr) {
 		pr_err("%s: Failed to map 0x%llx pages at 0x%llx\n", __func__,
@@ -541,12 +542,13 @@ void persistent_ram_free(struct persistent_ram_zone *prz)
 	prz->ecc_info.par = NULL;
 
 	persistent_ram_free_old(prz);
+	kfree(prz->label);
 	kfree(prz);
 }
 
 struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 			u32 sig, struct persistent_ram_ecc_info *ecc_info,
-			unsigned int memtype, u32 flags)
+			unsigned int memtype, u32 flags, char *label)
 {
 	struct persistent_ram_zone *prz;
 	int ret = -ENOMEM;
@@ -560,6 +562,7 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 	/* Initialize general buffer state. */
 	raw_spin_lock_init(&prz->buffer_lock);
 	prz->flags = flags;
+	prz->label = label;
 
 	ret = persistent_ram_buffer_map(start, size, prz, memtype);
 	if (ret)
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index e6d226464838..602d64725222 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -46,6 +46,7 @@ struct persistent_ram_zone {
 	phys_addr_t paddr;
 	size_t size;
 	void *vaddr;
+	char *label;
 	struct persistent_ram_buffer *buffer;
 	size_t buffer_size;
 	u32 flags;
@@ -65,7 +66,7 @@ struct persistent_ram_zone {
 
 struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 			u32 sig, struct persistent_ram_ecc_info *ecc_info,
-			unsigned int memtype, u32 flags);
+			unsigned int memtype, u32 flags, char *label);
 void persistent_ram_free(struct persistent_ram_zone *prz);
 void persistent_ram_zap(struct persistent_ram_zone *prz);
 
-- 
2.17.1

