Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC35CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 05:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A8421741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 05:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeL0FHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 00:07:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbeL0FHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 00:07:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02A4F1390C;
        Thu, 27 Dec 2018 05:07:01 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72EC05D781;
        Thu, 27 Dec 2018 05:06:56 +0000 (UTC)
Date:   Thu, 27 Dec 2018 13:06:52 +0800
From:   Dave Young <dyoung@redhat.com>
To:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] x86/kexec: fix a kexec_file_load failure
Message-ID: <20181227050652.GA2960@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 27 Dec 2018 05:07:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code cleanup mentioned in Fixes tag changed the behavior of
kexec_locate_mem_hole.  The kexec_locate_mem_hole will try to
allocate free memory only when kbuf.mem is initialized as zero.

But in x86 kexec_file_load implementation there are a few places
the kbuf.mem is reused like below:
  /* kbuf initialized, kbuf.mem = 0 */
  ...
  kexec_add_buffer()
  ...
  kexec_add_buffer()

  The second kexec_add_buffer will reuse previous kbuf but not
  reinitialize the kbuf.mem.

Thus kexec_file_load failed because the sanity check failed.

So explictily reset mem = 0 to fix the issue.

Fixes: b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")
Signed-off-by: Dave Young <dyoung@redhat.com>
Cc: <stable@vger.kernel.org>
---
 arch/x86/kernel/crash.c           | 1 +
 arch/x86/kernel/kexec-bzimage64.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index f631a3f15587..37147509d2c8 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -469,6 +469,7 @@ int crash_load_segments(struct kimage *image)
 
 	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.mem = 0;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		vfree((void *)image->arch.elf_headers);
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 278cd07228dd..558204bdf412 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -434,6 +434,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	kbuf.memsz = PAGE_ALIGN(header->init_size);
 	kbuf.buf_align = header->kernel_alignment;
 	kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
+	kbuf.mem = 0;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret)
 		goto out_free_params;
@@ -448,6 +449,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		kbuf.bufsz = kbuf.memsz = initrd_len;
 		kbuf.buf_align = PAGE_SIZE;
 		kbuf.buf_min = MIN_INITRD_LOAD_ADDR;
+		kbuf.mem = 0;
 		ret = kexec_add_buffer(&kbuf);
 		if (ret)
 			goto out_free_params;
-- 
2.17.0

