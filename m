Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B3BECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F720208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FVYX7AFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F720208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeJRI1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:27:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38851 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRI1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:27:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so13312847pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 17:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rPFHxFk4mPW7FWIaPD3tahDvarHk0+RFbX/QhbVt4k4=;
        b=FVYX7AFaQSN1D0uGR5ANjrmwM2/IVJdmMYZFFusdUlF3/rObs3RZl8vet43ei+TD0J
         d5hqH9AqLopsWOFKBsnzmcAaQHz1JlY36budf++c8rwfg4i7pxEi3eKmSy7cDvf/HsPR
         32bX0b86L0YT59o+9GgszraFkDqJsg+4SOUlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rPFHxFk4mPW7FWIaPD3tahDvarHk0+RFbX/QhbVt4k4=;
        b=LUgv/WYqXgEqpW6ZwX4HdymfNJsn5u8glAhSG+PMJMClAtK/2ZruwVVhIwBww1N/iX
         PjntSBYjLSwsyx24TfJelOBHaBx0K3ygvFMKL34itZdOUXPiBVafcQgKFT96OHOdwmye
         0UX576v5T/JUPkZtOMzz60DosELcycb8ezzutPT8780nbu5yv7SQ4bJ9+HlyYVTMbTDh
         wrn6K1PXUYAKtWg7uXEbQdTjmTK7OcF9joc/k1hqBu4nlR2GZdRketNhJscZ1KOXZmN+
         kbS6UEn1rjx7vPX5kcGVqzUx9dNIMvZELcHWVHGso0RpEpf8eEmAlvNO93DeAkxw2YLY
         mh7A==
X-Gm-Message-State: ABuFfoiYMdwRqfbuGzCpVOOAAlpJvyv2TiiwEHp7vFEgHDcxsq4KEZRE
        YcOlyLG45Z3GBP/qp8uZynK2Ng==
X-Google-Smtp-Source: ACcGV61QrG1+fQlewBi96P89Z0w2l+DyG0AXmI7Bb+tt/toCFk8IOuOgASQOe6XEmXqFJgAN6+IUkg==
X-Received: by 2002:a63:3642:: with SMTP id d63-v6mr26068721pga.404.1539822567036;
        Wed, 17 Oct 2018 17:29:27 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s2-v6sm18977102pgo.90.2018.10.17.17.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 17:29:25 -0700 (PDT)
Date:   Wed, 17 Oct 2018 17:29:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH] pstore/ram: Clarify resource reservation labels
Message-ID: <20181018002924.GA42803@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


-- 
Kees Cook
Pixel Security
