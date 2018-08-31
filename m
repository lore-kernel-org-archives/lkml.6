Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA55C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45A12083D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45A12083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeHaM0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:26:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727229AbeHaM0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:26:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B43A04021CC3;
        Fri, 31 Aug 2018 08:20:14 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B554E112D169;
        Fri, 31 Aug 2018 08:20:07 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhe@redhat.com
Subject: [PATCH 3/5 V6] kexec: allocate unencrypted control pages for kdump in case SME is enabled
Date:   Fri, 31 Aug 2018 16:19:28 +0800
Message-Id: <20180831081930.31561-4-lijiang@redhat.com>
In-Reply-To: <20180831081930.31561-1-lijiang@redhat.com>
References: <20180831081930.31561-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 31 Aug 2018 08:20:14 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 31 Aug 2018 08:20:14 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SME is enabled in the first kernel, we will allocate unencrypted pages
for kdump in order to be able to boot the kdump kernel like kexec.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 kernel/kexec_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 23a83a4da38a..e7efcd1a977b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -471,6 +471,16 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 		}
 	}
 
+	if (pages) {
+		/*
+		 * For kdump, we need to ensure that these pages are
+		 * unencrypted pages if SME is enabled.
+		 * By the way, it is unnecessary to call the arch_
+		 * kexec_pre_free_pages(), which will make the code
+		 * become more simple.
+		 */
+		arch_kexec_post_alloc_pages(page_address(pages), 1 << order, 0);
+	}
 	return pages;
 }
 
@@ -867,6 +877,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			result  = -ENOMEM;
 			goto out;
 		}
+		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
 		ptr = kmap(page);
 		ptr += maddr & ~PAGE_MASK;
 		mchunk = min_t(size_t, mbytes,
@@ -884,6 +895,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			result = copy_from_user(ptr, buf, uchunk);
 		kexec_flush_icache_page(page);
 		kunmap(page);
+		arch_kexec_pre_free_pages(page_address(page), 1);
 		if (result) {
 			result = -EFAULT;
 			goto out;
-- 
2.17.1

