Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D429C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56ABA21479
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g5uP2ofi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56ABA21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeJQBfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:35:46 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39304 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeJQBfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:35:46 -0400
Received: by mail-lf1-f68.google.com with SMTP id n14-v6so5794494lfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mEkDkq8SSZbY2c+Iu2qL96meHyq3EfhnFHqS9BV+RyA=;
        b=g5uP2ofiPqj7kaR3JdlcXzMjwPGUOxnbP9LuWSWLU0jBtolgmcyY2aQ2VLEoB41F+v
         2X+hTlP/n3gPiZBmCKytkBl8NeRQifio25fWMbV91vATKtctT2Qe2uRVQXw1tcNWbPG8
         FZiWaF+cbzXqE0dKTSXyU7vBKNdzHz9/FpeSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEkDkq8SSZbY2c+Iu2qL96meHyq3EfhnFHqS9BV+RyA=;
        b=srWDpCbBaPAQbVyaMB91MtC5JMvC507IQjCl9CCITFnzR3+LVJNm6OIEgWwcpxLCOh
         9VnKdCnRfaYp9XqM7BobUaTItsSLPe+0DO7Isyid9fFo/zcqQSxVufUtjSxdUqI012uC
         fXY1u2PbBwoybXpDRNhgZe/BDMu5ARU3nzg9DYxznMq5sV4L7mA9tT9e3hH8iO9UJCOk
         qZ4k2IJOImdw+6AN4tJTKzwyRAH0HVFQjoN/apAkuSwTa9z8r5x1JWwS4yqeYVasY+Yl
         S4hmSaFfjS3bcebAJRJjE69DzReq62rd4TPh83oiMbBylg3mIBh5M1PQP0T6uMz/4d+m
         hf4w==
X-Gm-Message-State: ABuFfog8B8wcYROu3q33rOhK5io2mv4LqFBm2mUOhy6vcrOhrdrHWy22
        QGEVfNc6egk0SvLrGxNnva4DBjmWopYY
X-Google-Smtp-Source: ACcGV60nFbvwikFVXSESF2pguXxrdXPNIzbYkIPGv8k7PlEXBKDFDkUR+r0nBXDDysEQ1HlkaJEG/g==
X-Received: by 2002:a19:6803:: with SMTP id d3-v6mr1916502lfc.45.1539711852067;
        Tue, 16 Oct 2018 10:44:12 -0700 (PDT)
Received: from vovoy-z840.tpe.corp.google.com ([2401:fa00:1:b:d89e:cfa6:3c8:e61b])
        by smtp.gmail.com with ESMTPSA id r4-v6sm3358752ljg.12.2018.10.16.10.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 10:44:11 -0700 (PDT)
From:   Kuo-Hsin Yang <vovoy@chromium.org>
To:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org
Cc:     mhocko@suse.com, akpm@linux-foundation.org,
        chris@chris-wilson.co.uk, peterz@infradead.org,
        dave.hansen@intel.com, corbet@lwn.net, hughd@google.com,
        joonas.lahtinen@linux.intel.com, marcheu@chromium.org,
        hoegsberg@chromium.org, Kuo-Hsin Yang <vovoy@chromium.org>
Subject: [PATCH 1/2] shmem: export shmem_unlock_mapping
Date:   Wed, 17 Oct 2018 01:42:59 +0800
Message-Id: <20181016174300.197906-2-vovoy@chromium.org>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
In-Reply-To: <20181016174300.197906-1-vovoy@chromium.org>
References: <20181016174300.197906-1-vovoy@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By exporting this function, drivers can mark/unmark a shmemfs address
space as unevictable in the following way: 1. mark an address space as
unevictable with mapping_set_unevictable(), pages in the address space
will be moved to unevictable list in vmscan. 2. mark an address space
evictable with mapping_clear_unevictable(), and move these pages back to
evictable list with shmem_unlock_mapping().

Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
---
 Documentation/vm/unevictable-lru.rst | 4 +++-
 mm/shmem.c                           | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/vm/unevictable-lru.rst b/Documentation/vm/unevictable-lru.rst
index fdd84cb8d511..a812fb55136d 100644
--- a/Documentation/vm/unevictable-lru.rst
+++ b/Documentation/vm/unevictable-lru.rst
@@ -143,7 +143,7 @@ using a number of wrapper functions:
 	Query the address space, and return true if it is completely
 	unevictable.
 
-These are currently used in two places in the kernel:
+These are currently used in three places in the kernel:
 
  (1) By ramfs to mark the address spaces of its inodes when they are created,
      and this mark remains for the life of the inode.
@@ -154,6 +154,8 @@ These are currently used in two places in the kernel:
      swapped out; the application must touch the pages manually if it wants to
      ensure they're in memory.
 
+ (3) By the i915 driver to mark pinned address space until it's unpinned.
+
 
 Detecting Unevictable Pages
 ---------------------------
diff --git a/mm/shmem.c b/mm/shmem.c
index 446942677cd4..d1ce34c09df6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -786,6 +786,7 @@ void shmem_unlock_mapping(struct address_space *mapping)
 		cond_resched();
 	}
 }
+EXPORT_SYMBOL_GPL(shmem_unlock_mapping);
 
 /*
  * Remove range of pages and swap entries from radix tree, and free them.
@@ -3874,6 +3875,7 @@ int shmem_lock(struct file *file, int lock, struct user_struct *user)
 void shmem_unlock_mapping(struct address_space *mapping)
 {
 }
+EXPORT_SYMBOL_GPL(shmem_unlock_mapping);
 
 #ifdef CONFIG_MMU
 unsigned long shmem_get_unmapped_area(struct file *file,
-- 
2.19.1.331.ge82ca0e54c-goog

