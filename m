Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00603C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF07D20890
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF07D20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934741AbeGCSYg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:24:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:2755 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934400AbeGCSYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:24:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 11:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,304,1526367600"; 
   d="scan'208";a="242708430"
Received: from cdikicix-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.69])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jul 2018 11:24:28 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 12/13] platform/x86: ptrace() support for the SGX driver
Date:   Tue,  3 Jul 2018 21:19:57 +0300
Message-Id: <20180703182118.15024-13-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implemented VMA callbacks in order to ptrace() debug enclaves. With
debug enclaves data can be read and write the memory word at a time by
using ENCLS(EDBGRD) and ENCLS(EDBGWR) leaf instructions.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/platform/x86/intel_sgx/sgx_encl.c |   2 +-
 drivers/platform/x86/intel_sgx/sgx_vma.c  | 116 ++++++++++++++++++++++
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_sgx/sgx_encl.c b/drivers/platform/x86/intel_sgx/sgx_encl.c
index e3d7fa885489..20cd9ff7dd75 100644
--- a/drivers/platform/x86/intel_sgx/sgx_encl.c
+++ b/drivers/platform/x86/intel_sgx/sgx_encl.c
@@ -954,7 +954,7 @@ int sgx_encl_load_page(struct sgx_encl_page *encl_page,
 	ret = __eldu(&pginfo, epc_ptr, va_ptr + va_offset);
 	if (ret) {
 		sgx_err(encl, "ELDU returned %d\n", ret);
-		ret = -EFAULT;
+		ret = ENCLS_TO_ERR(ret);
 	}
 
 	kunmap_atomic((void *)(unsigned long)(pginfo.pcmd - pcmd_offset));
diff --git a/drivers/platform/x86/intel_sgx/sgx_vma.c b/drivers/platform/x86/intel_sgx/sgx_vma.c
index cc0993b4fd40..3a856e40c82c 100644
--- a/drivers/platform/x86/intel_sgx/sgx_vma.c
+++ b/drivers/platform/x86/intel_sgx/sgx_vma.c
@@ -51,8 +51,124 @@ static int sgx_vma_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 }
 
+static int sgx_edbgrd(struct sgx_encl *encl, struct sgx_encl_page *page,
+		      unsigned long addr, void *data)
+{
+	unsigned long offset;
+	void *ptr;
+	int ret;
+
+	offset = addr & ~PAGE_MASK;
+
+	if ((page->desc & SGX_ENCL_PAGE_TCS) &&
+            offset > offsetof(struct sgx_tcs, gslimit))
+		return -ECANCELED;
+
+	ptr = sgx_get_page(page->epc_page);
+	ret = __edbgrd((unsigned long)ptr + offset, data);
+	sgx_put_page(ptr);
+	if (ret) {
+		sgx_dbg(encl, "EDBGRD returned %d\n", ret);
+		return ENCLS_TO_ERR(ret);
+	}
+
+	return 0;
+}
+
+static int sgx_edbgwr(struct sgx_encl *encl, struct sgx_encl_page *page,
+		      unsigned long addr, void *data)
+{
+	unsigned long offset;
+	void *ptr;
+	int ret;
+
+	offset = addr & ~PAGE_MASK;
+
+	/* Writing anything else than flags will cause #GP */
+	if ((page->desc & SGX_ENCL_PAGE_TCS) &&
+	    offset != offsetof(struct sgx_tcs, flags))
+		return -ECANCELED;
+
+	ptr = sgx_get_page(page->epc_page);
+	ret = __edbgwr((unsigned long)ptr + offset, data);
+	sgx_put_page(ptr);
+	if (ret) {
+		sgx_dbg(encl, "EDBGWR returned %d\n", ret);
+		return ENCLS_TO_ERR(ret);
+	}
+
+	return 0;
+}
+
+static int sgx_vma_access(struct vm_area_struct *vma, unsigned long addr,
+			  void *buf, int len, int write)
+{
+	struct sgx_encl *encl = vma->vm_private_data;
+	struct sgx_encl_page *entry = NULL;
+	unsigned long align;
+	char data[sizeof(unsigned long)];
+	int offset;
+	int cnt;
+	int ret = 0;
+	int i;
+
+	/* If process was forked, VMA is still there but vm_private_data is set
+	 * to NULL.
+	 */
+	if (!encl)
+		return -EFAULT;
+
+	if (!(encl->flags & SGX_ENCL_DEBUG) ||
+	    !(encl->flags & SGX_ENCL_INITIALIZED) ||
+	    (encl->flags & SGX_ENCL_DEAD))
+		return -EFAULT;
+
+	for (i = 0; i < len; i += cnt) {
+		if (!entry || !((addr + i) & (PAGE_SIZE - 1))) {
+			if (entry)
+				entry->desc &= ~SGX_ENCL_PAGE_RESERVED;
+
+			entry = sgx_fault_page(vma, (addr + i) & PAGE_MASK,
+					       true);
+			if (IS_ERR(entry)) {
+				ret = PTR_ERR(entry);
+				entry = NULL;
+				break;
+			}
+		}
+
+		/* Locking is not needed because only immutable fields of the
+		 * page are accessed and page itself is reserved so that it
+		 * cannot be swapped out in the middle.
+		 */
+
+		align = ALIGN_DOWN(addr + i, sizeof(unsigned long));
+		offset = (addr + i) & (sizeof(unsigned long) - 1);
+		cnt = sizeof(unsigned long) - offset;
+		cnt = min(cnt, len - i);
+
+		ret = sgx_edbgrd(encl, entry, align, data);
+		if (ret)
+			break;
+		if (write) {
+			memcpy(data + offset, buf + i, cnt);
+			ret = sgx_edbgwr(encl, entry, align, data);
+			if (ret)
+				break;
+		}
+		else
+			memcpy(buf + i,data + offset, cnt);
+	}
+
+	if (entry)
+		entry->desc &= ~SGX_ENCL_PAGE_RESERVED;
+
+	return (ret < 0 && ret != -ECANCELED) ? ret : i;
+}
+
 const struct vm_operations_struct sgx_vm_ops = {
 	.close = sgx_vma_close,
 	.open = sgx_vma_open,
 	.fault = sgx_vma_fault,
+	.access = sgx_vma_access,
 };
-- 
2.17.1

