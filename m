Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CBBC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E154B20672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E154B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeLLAM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:12:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:56050 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbeLLAMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:12:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 16:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="282839406"
Received: from rpedgeco-desk5.jf.intel.com ([10.54.75.141])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2018 16:12:07 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, luto@kernel.org, will.deacon@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        naveen.n.rao@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        jeyu@kernel.org, namit@vmware.com, netdev@vger.kernel.org,
        ard.biesheuvel@linaro.org, jannh@google.com
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2 3/4] bpf: switch to new vmalloc vfree flags
Date:   Tue, 11 Dec 2018 16:03:53 -0800
Message-Id: <20181212000354.31955-4-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181212000354.31955-1-rick.p.edgecombe@intel.com>
References: <20181212000354.31955-1-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches to use the new vmalloc flags to control freeing memory with
special permissions.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/filter.h | 26 ++++++++++++--------------
 kernel/bpf/core.c      |  1 -
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 795ff0b869bb..2aeb93d3337d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -20,6 +20,7 @@
 #include <linux/set_memory.h>
 #include <linux/kallsyms.h>
 #include <linux/if_vlan.h>
+#include <linux/vmalloc.h>
 
 #include <net/sch_generic.h>
 
@@ -487,7 +488,6 @@ struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
 	u16			jited:1,	/* Is our filter JIT'ed? */
 				jit_requested:1,/* archs need to JIT the prog */
-				undo_set_mem:1,	/* Passed set_memory_ro() checkpoint */
 				gpl_compatible:1, /* Is filter GPL compatible? */
 				cb_access:1,	/* Is control block accessed? */
 				dst_needed:1,	/* Do we need dst entry? */
@@ -699,24 +699,23 @@ bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 size_default)
 
 static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
 {
-	fp->undo_set_mem = 1;
-	set_memory_ro((unsigned long)fp, fp->pages);
-}
+	struct vm_struct *vm = find_vm_area(fp);
 
-static inline void bpf_prog_unlock_ro(struct bpf_prog *fp)
-{
-	if (fp->undo_set_mem)
-		set_memory_rw((unsigned long)fp, fp->pages);
+	if (vm)
+		vm->flags |= VM_HAS_SPECIAL_PERMS;
+	set_memory_ro((unsigned long)fp, fp->pages);
 }
 
 static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
 {
-	set_memory_ro((unsigned long)hdr, hdr->pages);
-}
+	struct vm_struct *vm = find_vm_area(hdr);
 
-static inline void bpf_jit_binary_unlock_ro(struct bpf_binary_header *hdr)
-{
-	set_memory_rw((unsigned long)hdr, hdr->pages);
+	if (vm) {
+		vm->flags |= VM_HAS_SPECIAL_PERMS;
+		vm->flags |= VM_IMMEDIATE_UNMAP;
+	}
+
+	set_memory_ro((unsigned long)hdr, hdr->pages);
 }
 
 static inline struct bpf_binary_header *
@@ -746,7 +745,6 @@ void __bpf_prog_free(struct bpf_prog *fp);
 
 static inline void bpf_prog_unlock_free(struct bpf_prog *fp)
 {
-	bpf_prog_unlock_ro(fp);
 	__bpf_prog_free(fp);
 }
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b1a3545d0ec8..bd3efd7ce526 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -663,7 +663,6 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
 	if (fp->jited) {
 		struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
 
-		bpf_jit_binary_unlock_ro(hdr);
 		bpf_jit_binary_free(hdr);
 
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
-- 
2.17.1

