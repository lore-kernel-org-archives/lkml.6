Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB2AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C88720657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfAOLTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 06:19:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43879 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbfAOLTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 06:19:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0FBIwZe2491256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Jan 2019 03:18:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0FBItiI2491250;
        Tue, 15 Jan 2019 03:18:55 -0800
Date:   Tue, 15 Jan 2019 03:18:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Young <tipbot@zytor.com>
Message-ID: <tip-993a110319a4a60aadbd02f6defdebe048f7773b@git.kernel.org>
Cc:     tglx@linutronix.de, x86@kernel.org, vgoyal@redhat.com,
        akpm@linux-foundation.org, hpa@zytor.com, wang.yi59@zte.com.cn,
        schwidefsky@de.ibm.com, bhe@redhat.com, bp@suse.de,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        ebiederm@xmission.com, mingo@kernel.org, yannik@sembritzki.me,
        dyoung@redhat.com, prudo@linux.vnet.ibm.com,
        takahiro.akashi@linaro.org
Reply-To: dyoung@redhat.com, yannik@sembritzki.me,
          prudo@linux.vnet.ibm.com, takahiro.akashi@linaro.org,
          ebiederm@xmission.com, mingo@kernel.org, bhe@redhat.com,
          schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, bp@suse.de,
          mingo@redhat.com, x86@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, akpm@linux-foundation.org, vgoyal@redhat.com,
          wang.yi59@zte.com.cn
In-Reply-To: <20181228011247.GA9999@dhcp-128-65.nay.redhat.com>
References: <20181228011247.GA9999@dhcp-128-65.nay.redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/kexec: Fix a kexec_file_load() failure
Git-Commit-ID: 993a110319a4a60aadbd02f6defdebe048f7773b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  993a110319a4a60aadbd02f6defdebe048f7773b
Gitweb:     https://git.kernel.org/tip/993a110319a4a60aadbd02f6defdebe048f7773b
Author:     Dave Young <dyoung@redhat.com>
AuthorDate: Fri, 28 Dec 2018 09:12:47 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 15 Jan 2019 12:12:50 +0100

x86/kexec: Fix a kexec_file_load() failure

Commit

  b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")

changed the behavior of kexec_locate_mem_hole(): it will try to allocate
free memory only when kbuf.mem is initialized to zero.

However, x86's kexec_file_load() implementation reuses a struct
kexec_buf allocated on the stack and its kbuf.mem member gets set by
each kexec_add_buffer() invocation.

The second kexec_add_buffer() will reuse the same kbuf but not
reinitialize kbuf.mem.

Therefore, explictily reset kbuf.mem each time in order for
kexec_locate_mem_hole() to locate a free memory region each time.

 [ bp: massage commit message. ]

Fixes: b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")
Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Yannik Sembritzki <yannik@sembritzki.me>
Cc: Yi Wang <wang.yi59@zte.com.cn>
Cc: kexec@lists.infradead.org
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181228011247.GA9999@dhcp-128-65.nay.redhat.com
---
 arch/x86/kernel/crash.c           | 1 +
 arch/x86/kernel/kexec-bzimage64.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c8b07d8ea5a2..17ffc869cab8 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -470,6 +470,7 @@ int crash_load_segments(struct kimage *image)
 
 	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		vfree((void *)image->arch.elf_headers);
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 278cd07228dd..0d5efa34f359 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -434,6 +434,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	kbuf.memsz = PAGE_ALIGN(header->init_size);
 	kbuf.buf_align = header->kernel_alignment;
 	kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret)
 		goto out_free_params;
@@ -448,6 +449,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		kbuf.bufsz = kbuf.memsz = initrd_len;
 		kbuf.buf_align = PAGE_SIZE;
 		kbuf.buf_min = MIN_INITRD_LOAD_ADDR;
+		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 		ret = kexec_add_buffer(&kbuf);
 		if (ret)
 			goto out_free_params;
