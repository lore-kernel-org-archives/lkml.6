Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06121C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C155E21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mg9oizDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C155E21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbeJKXRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731654AbeJKXQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:16:59 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D68D21470;
        Thu, 11 Oct 2018 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272953;
        bh=w4USIVj4yFPuT9efkULQOV1Uj+cMAUKat8XGb/CKTlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mg9oizDCLsYdZnfZ9kZX0flSI1rISPg5Izc6T9ENdHOjp00E2jXDYOmNELyPryDp9
         io4iwr/4Iw+uhl3XRfdq37FaKUexv28DtpTLtTl4oOcP+SBXgD8cxcoe8yu7rBn/wz
         AK4VrW7b/5KCp2I3VdgP/kWW957hdXXbP94BpPP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 36/44] powerpc: Avoid code patching freed init sections
Date:   Thu, 11 Oct 2018 17:40:14 +0200
Message-Id: <20181011152454.025915380@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

commit 51c3c62b58b357e8d35e4cc32f7b4ec907426fe3 upstream.

This stops us from doing code patching in init sections after they've
been freed.

In this chain:
  kvm_guest_init() ->
    kvm_use_magic_page() ->
      fault_in_pages_readable() ->
	 __get_user() ->
	   __get_user_nocheck() ->
	     barrier_nospec();

We have a code patching location at barrier_nospec() and
kvm_guest_init() is an init function. This whole chain gets inlined,
so when we free the init section (hence kvm_guest_init()), this code
goes away and hence should no longer be patched.

We seen this as userspace memory corruption when using a memory
checker while doing partition migration testing on powervm (this
starts the code patching post migration via
/sys/kernel/mobility/migration). In theory, it could also happen when
using /sys/kernel/debug/powerpc/barrier_nospec.

Cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/setup.h |    1 +
 arch/powerpc/lib/code-patching.c |    6 ++++++
 arch/powerpc/mm/mem.c            |    2 ++
 3 files changed, 9 insertions(+)

--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -9,6 +9,7 @@ extern void ppc_printk_progress(char *s,
 
 extern unsigned int rtas_data;
 extern unsigned long long memory_limit;
+extern bool init_mem_is_free;
 extern unsigned long klimit;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -28,6 +28,12 @@ static int __patch_instruction(unsigned
 {
 	int err;
 
+	/* Make sure we aren't patching a freed init section */
+	if (init_mem_is_free && init_section_contains(exec_addr, 4)) {
+		pr_debug("Skipping init section patching addr: 0x%px\n", exec_addr);
+		return 0;
+	}
+
 	__put_user_size(instr, patch_addr, 4, err);
 	if (err)
 		return err;
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -63,6 +63,7 @@
 #endif
 
 unsigned long long memory_limit;
+bool init_mem_is_free;
 
 #ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
@@ -396,6 +397,7 @@ void free_initmem(void)
 {
 	ppc_md.progress = ppc_printk_progress;
 	mark_initmem_nx();
+	init_mem_is_free = true;
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 


