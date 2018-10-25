Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38224ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE27A2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SrQiVam+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE27A2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeJYJ6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:58:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40298 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeJYJ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:58:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id z9-v6so8004516qto.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 18:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ti4MDF9979DMD/586tRYIueeMdaiFl0KtuS7MeNcMD0=;
        b=SrQiVam+Gqw4blhB2ENKcEf/DqjBBJYyiJSpd+OJEidU44Quqj5377QkoWaUuO/Ia9
         vHGO8wmj13eOS0WP6JkoDi82FOVWqTfV1anRYlvpiTyt6KzlWjFPWl6S7hOVQxMAiN1Z
         0BSlrO+fGRTrqWVcGpTfcXXaAWPmir14beqoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ti4MDF9979DMD/586tRYIueeMdaiFl0KtuS7MeNcMD0=;
        b=kG3VMG2AuInksR43RVoe+45iEOaCdrutDgs9URLQf1M9QZBTVHBSx5ENjx6K502OT2
         YglWea/rNY1iRLksh89WL11xjCWdTYyKTsbjcbBtp2ILeA+HqT6TJ28RIWK6C4BUJFNx
         pQnPQIaJ6rGXh/Di+4M+ebl6k5dA1bjF9LS7oxOGYvYqp47lKC5qWUDaEdJ2eLcQ5ca7
         H5EOGZ2KHOI0oZbnsDp8LccQHrwZPLEGv+5Q8j9Rf5dwjfid+Kr8tjCCimV3k/R0docr
         fzUcvCqkDMiQuJWxyu53rGp8fJdHpeN8HMnopEK6SNOEnksOuKtghxi0mjNQ0pY7rZgZ
         46Vg==
X-Gm-Message-State: AGRZ1gLHIfk+FwS/uNwKn4j29Lq0plcCda7hhqC062g14j0SIaKWqsAK
        WrGLaIOuCgb80X/S+J969W/QY1/ULXQM8w==
X-Google-Smtp-Source: AJdET5cdiofEiy4gc+9VWRrh1nG2NFbH5dHruvbYqxulJBP1r0A3tJ9/ryM+D0XpfoPbSZYSX9crAw==
X-Received: by 2002:a0c:fcca:: with SMTP id i10mr4580914qvq.69.1540430872434;
        Wed, 24 Oct 2018 18:27:52 -0700 (PDT)
Received: from workstation.celeiro.br ([138.204.25.17])
        by smtp.gmail.com with ESMTPSA id m6-v6sm5338994qta.50.2018.10.24.18.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 18:27:51 -0700 (PDT)
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 1/2] mm/zsmalloc.c: check encoded object value overflow for PAE
Date:   Wed, 24 Oct 2018 22:27:44 -0300
Message-Id: <20181025012745.20884-1-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit systems, zsmalloc uses HIGHMEM and, when PAE is enabled, the
physical frame number might be so big that zsmalloc obj encoding (to
location) will break IF architecture does not re-define
MAX_PHYSMEM_BITS, causing:

[  497.097843] ==================================================================
[  497.102365] BUG: KASAN: null-ptr-deref in zs_map_object+0xa4/0x2bc
[  497.105933] Read of size 4 at addr 00000000 by task mkfs.ext4/623
[  497.109684]
[  497.110722] CPU: 2 PID: 623 Comm: mkfs.ext4 Not tainted 4.19.0-rc8-00017-g8239bc6d3307-dirty #15
[  497.116098] Hardware name: Generic DT based system
[  497.119094] [<c0418f7c>] (unwind_backtrace) from [<c0410ca4>] (show_stack+0x20/0x24)
[  497.123819] [<c0410ca4>] (show_stack) from [<c16bd540>] (dump_stack+0xbc/0xe8)
[  497.128299] [<c16bd540>] (dump_stack) from [<c06cab74>] (kasan_report+0x248/0x390)
[  497.132928] [<c06cab74>] (kasan_report) from [<c06c94e8>] (__asan_load4+0x78/0xb4)
[  497.137530] [<c06c94e8>] (__asan_load4) from [<c06ddc24>] (zs_map_object+0xa4/0x2bc)
[  497.142335] [<c06ddc24>] (zs_map_object) from [<bf0bbbd8>] (zram_bvec_rw.constprop.2+0x324/0x8e4 [zram])
[  497.148294] [<bf0bbbd8>] (zram_bvec_rw.constprop.2 [zram]) from [<bf0bc3cc>] (zram_make_request+0x234/0x46c [zram])
[  497.154653] [<bf0bc3cc>] (zram_make_request [zram]) from [<c09aff9c>] (generic_make_request+0x304/0x63c)
[  497.160413] [<c09aff9c>] (generic_make_request) from [<c09b0320>] (submit_bio+0x4c/0x1c8)
[  497.165379] [<c09b0320>] (submit_bio) from [<c0743570>] (submit_bh_wbc.constprop.15+0x238/0x26c)
[  497.170775] [<c0743570>] (submit_bh_wbc.constprop.15) from [<c0746cf8>] (__block_write_full_page+0x524/0x76c)
[  497.176776] [<c0746cf8>] (__block_write_full_page) from [<c07472c4>] (block_write_full_page+0x1bc/0x1d4)
[  497.182549] [<c07472c4>] (block_write_full_page) from [<c0748eb4>] (blkdev_writepage+0x24/0x28)
[  497.187849] [<c0748eb4>] (blkdev_writepage) from [<c064a780>] (__writepage+0x44/0x78)
[  497.192633] [<c064a780>] (__writepage) from [<c064b50c>] (write_cache_pages+0x3b8/0x800)
[  497.197616] [<c064b50c>] (write_cache_pages) from [<c064dd78>] (generic_writepages+0x74/0xa0)
[  497.202807] [<c064dd78>] (generic_writepages) from [<c0748e64>] (blkdev_writepages+0x18/0x1c)
[  497.208022] [<c0748e64>] (blkdev_writepages) from [<c064e890>] (do_writepages+0x68/0x134)
[  497.213002] [<c064e890>] (do_writepages) from [<c06368a4>] (__filemap_fdatawrite_range+0xb0/0xf4)
[  497.218447] [<c06368a4>] (__filemap_fdatawrite_range) from [<c0636b68>] (file_write_and_wait_range+0x64/0xd0)
[  497.224416] [<c0636b68>] (file_write_and_wait_range) from [<c0747af8>] (blkdev_fsync+0x54/0x84)
[  497.229749] [<c0747af8>] (blkdev_fsync) from [<c0739dac>] (vfs_fsync_range+0x70/0xd4)
[  497.234549] [<c0739dac>] (vfs_fsync_range) from [<c0739e98>] (do_fsync+0x4c/0x80)
[  497.239159] [<c0739e98>] (do_fsync) from [<c073a26c>] (sys_fsync+0x1c/0x20)
[  497.243407] [<c073a26c>] (sys_fsync) from [<c0401000>] (ret_fast_syscall+0x0/0x2c)

like in this ARM 32-bit (LPAE enabled), example.

That occurs because, if not set, MAX_POSSIBLE_PHYSMEM_BITS will default
to BITS_PER_LONG (32) in most cases, and, for PAE, _PFN_BITS will be
wrong: which may cause obj variable to overflow if PFN is HIGHMEM and
referencing any page above the 4GB watermark.

This commit exposes the BUG IF the architecture supports PAE AND does
not explicitly set MAX_POSSIBLE_PHYSMEM_BITS to supported value.

Link: https://bugs.linaro.org/show_bug.cgi?id=3765#c17
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 mm/zsmalloc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 9da65552e7ca..9c3ff8c2ccbc 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -119,6 +119,15 @@
 #define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
 #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
 
+/*
+ * When using PAE, the obj encoding might overflow if arch does
+ * not re-define MAX_PHYSMEM_BITS, since zsmalloc uses HIGHMEM.
+ * This checks for a future bad page access, when de-coding obj.
+ */
+#define OBJ_OVERFLOW(_pfn) \
+	(((unsigned long long) _pfn << (OBJ_INDEX_BITS + OBJ_TAG_BITS)) >= \
+	((_AC(1, ULL)) << MAX_POSSIBLE_PHYSMEM_BITS) ? 1 : 0)
+
 #define FULLNESS_BITS	2
 #define CLASS_BITS	8
 #define ISOLATED_BITS	3
@@ -871,9 +880,14 @@ static void obj_to_location(unsigned long obj, struct page **page,
  */
 static unsigned long location_to_obj(struct page *page, unsigned int obj_idx)
 {
-	unsigned long obj;
+	unsigned long obj, pfn;
+
+	pfn = page_to_pfn(page);
+
+	if (unlikely(OBJ_OVERFLOW(pfn)))
+		BUG();
 
-	obj = page_to_pfn(page) << OBJ_INDEX_BITS;
+	obj = pfn << OBJ_INDEX_BITS;
 	obj |= obj_idx & OBJ_INDEX_MASK;
 	obj <<= OBJ_TAG_BITS;
 
-- 
2.19.1

