Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A73C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4374D2157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4374D2157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeI0Nhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:37:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbeI0Nhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:37:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C5343356C9;
        Thu, 27 Sep 2018 07:20:44 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96616600C7;
        Thu, 27 Sep 2018 07:20:30 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        bp@suse.de, brijesh.singh@amd.com, dyoung@redhat.com,
        bhe@redhat.com, jroedel@suse.de
Subject: [PATCH v7 RESEND 2/4] kexec: allocate unencrypted control pages for kdump in case SME is enabled
Date:   Thu, 27 Sep 2018 15:19:52 +0800
Message-Id: <20180927071954.29615-3-lijiang@redhat.com>
In-Reply-To: <20180927071954.29615-1-lijiang@redhat.com>
References: <20180927071954.29615-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 27 Sep 2018 07:20:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SME is enabled in the first kernel, we will allocate unencrypted pages
for kdump in order to be able to boot the kdump kernel like kexec.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
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

