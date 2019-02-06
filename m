Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A49C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B8F2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NkvOJJO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfBFALn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:43 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33381 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbfBFALk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:40 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so4518416eds.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=miXDyTkaSPpC9go/A5cINAcxSQXOEnI3TLjPTECs36M=;
        b=NkvOJJO/t7+LS8VTTgDzWs1SFIJJFO5HxvvxMR3d4TPnQ6AbZls8yoLkUNy6Q1bvMs
         20prZzgxROOMJDBiDv7k+IUt7FxPAEZ2Xd/IjzjD0T4N+K3x/+Gi2CUJRNEaEJidnMj7
         qVLc2NTkYhOCZ3ejBsl9vqO4w3HJ0/PHh0cWcvMvEMVOfcMlUIa2HRFjeX3q5euBqKcm
         EzUDY/Z0nZK3fiJUhO+Oybc3mRFkVIzJO/kJIQF0LHyXJ1Xr2FNtQbynL6yc47CdbA3e
         FM/nm/Nu5Zdx+mpQFq/NVGWmZWseKI9Kbbz+eGR4jLcpvnxxgBH5gMTtt+suOkLi3ydg
         jraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miXDyTkaSPpC9go/A5cINAcxSQXOEnI3TLjPTECs36M=;
        b=g2RWpRp0yY7u6AVhxNabIV1nbSb2l9+fzqnVairJd3FLKalWx+wZfwycKR4pqVY6N9
         Fh/XfkClxzCJFgqLCCicbiLqvT8XllzSj5O9CLsk/IxE20UvLxy/7kc19G7aRzXM2XM6
         M80GjC2Ku9o9uKmR15FNNnQWtLPq4nrZ8Cb+0usFnKrumA2ZwPlKWB/aKpn0rLm/LoDW
         raIoN+H7NAdAjqlzurgcOgycN3yJ6i1jbnH8nF0GupK0utW0us0mV7Rxi+jx+EEwPWBj
         3bADjYfO6c8gLnrcs8EX94jvT6LtN5Sk7a8WnrmmNgri9j7mzkRYNYyU4nCmABVfVMF3
         DkpA==
X-Gm-Message-State: AHQUAuZTBjlKYBwMCaTDTtYkmaC0OferqIYCWyqA7g+V622+gg6qcc64
        HKGEFz+3gPM4XhNZRyQQJs3wTQAarUQ=
X-Google-Smtp-Source: AHgI3IZ/s0OBHnwxlJ6b0XkVIaw3NdlMNFhic6JWMTKyh2y8Ca9/Szz/8P7whPXP6+0hv36e8z1d3w==
X-Received: by 2002:a50:fe15:: with SMTP id f21mr5768049edt.116.1549411897797;
        Tue, 05 Feb 2019 16:11:37 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:37 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 21/32] x86/vdso: Switch image on setns()/unshare()/clone()
Date:   Wed,  6 Feb 2019 00:10:55 +0000
Message-Id: <20190206001107.16488-22-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it has been discussed on timens RFC, adding a new conditional branch
`if (inside_time_ns)` on VDSO for all processes is undesirable.
It will add a penalty for everybody as branch predictor may mispredict
the jump. Also there are instruction cache lines wasted on cmp/jmp.

Those effects of introducing time namespace are very much unwanted
having in mind how much work have been spent on micro-optimisation
vdso code.

Addressing those problems, there are two versions of VDSO's .so:
for host tasks (without any penalty) and for processes inside of time
namespace with clk_to_ns() that subtracts offsets from host's time.

Whenever a user does setns()/unshare() or clone() with CLONE_TIMENS,
change VDSO image in mm and zap existing VVAR/VDSO page tables.
They will be re-faulted with corresponding image and VVAR offsets.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c   | 81 +++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/vdso.h |  1 +
 kernel/time_namespace.c     | 11 +++++
 3 files changed, 93 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 56a62076a320..52c1e4c24455 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -25,6 +25,7 @@
 #include <asm/cpufeature.h>
 #include <asm/mshyperv.h>
 #include <asm/page.h>
+#include <asm/tlb.h>
 
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
@@ -150,6 +151,84 @@ static const struct vm_special_mapping vvar_mapping = {
 	.fault = vvar_fault,
 };
 
+#ifdef CONFIG_TIME_NS
+static const struct vdso_image *timens_vdso(const struct vdso_image *old_img,
+					    bool in_ns)
+{
+#ifdef CONFIG_X86_X32_ABI
+	if (old_img == &vdso_image_x32)
+		return NULL;
+#endif
+#if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
+	if (old_img == &vdso_image_32 || old_img == &vdso_image_32_timens)
+		return in_ns ? &vdso_image_32_timens : &vdso_image_32;
+#endif
+#ifdef CONFIG_X86_64
+	if (old_img == &vdso_image_64 || old_img == &vdso_image_64_timens)
+		return in_ns ? &vdso_image_64_timens : &vdso_image_64;
+#endif
+	return NULL;
+}
+
+static const struct vdso_image *image_to_timens(const struct vdso_image *img)
+{
+	bool in_ns = (current->nsproxy->time_ns != &init_time_ns);
+	const struct vdso_image *ns;
+
+	ns = timens_vdso(img, in_ns);
+
+	return ns ?: img;
+}
+
+int vdso_join_timens(struct task_struct *task, bool inside_ns)
+{
+	const struct vdso_image *new_image, *old_image;
+	struct mm_struct *mm = task->mm;
+	struct vm_area_struct *vma;
+	int ret = 0;
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	old_image = mm->context.vdso_image;
+	new_image = timens_vdso(old_image, inside_ns);
+	if (!new_image) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	/* Sanity checks, shouldn't happen */
+	if (unlikely(old_image->size != new_image->size)) {
+		ret = -ENXIO;
+		goto out;
+	}
+
+	mm->context.vdso_image = new_image;
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		unsigned long size = vma->vm_end - vma->vm_start;
+
+		if (vma_is_special_mapping(vma, &vvar_mapping))
+			zap_page_range(vma, vma->vm_start, size);
+		if (vma_is_special_mapping(vma, &vdso_mapping))
+			zap_page_range(vma, vma->vm_start, size);
+	}
+
+out:
+	up_write(&mm->mmap_sem);
+	return ret;
+}
+#else /* CONFIG_TIME_NS */
+static const struct vdso_image *image_to_timens(const struct vdso_image *img)
+{
+	return img;
+}
+int vdso_join_timens(struct task_struct *task, bool inside_ns)
+{
+	return -ENXIO;
+}
+#endif
+
 /*
  * Add vdso and vvar mappings to current process.
  * @image          - blob to map
@@ -165,6 +244,8 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
 
+	image = image_to_timens(image);
+
 	addr = get_unmapped_area(NULL, addr,
 				 image->size - image->sym_vvar_start, 0, 0);
 	if (IS_ERR_VALUE(addr)) {
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index b6a1a028ac62..c8db853344a0 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -51,6 +51,7 @@ extern const struct vdso_image vdso_image_32_timens;
 extern void __init init_vdso_image(const struct vdso_image *image);
 
 extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
+extern int vdso_join_timens(struct task_struct *task, bool inside_ns);
 
 #endif /* __ASSEMBLER__ */
 
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index 36b31f234472..1d1d1c023ec1 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -14,6 +14,7 @@
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
 #include <linux/mm.h>
+#include <asm/vdso.h>
 
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
@@ -155,11 +156,16 @@ static void timens_put(struct ns_common *ns)
 static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 {
 	struct time_namespace *ns = to_time_ns(new);
+	int ret;
 
 	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
+	ret = vdso_join_timens(current, ns != &init_time_ns);
+	if (ret)
+		return ret;
+
 	get_time_ns(ns);
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
@@ -174,10 +180,15 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 {
 	struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
 	struct time_namespace *ns = to_time_ns(nsc);
+	int ret;
 
 	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
 		return 0;
 
+	ret = vdso_join_timens(tsk, ns != &init_time_ns);
+	if (ret)
+		return ret;
+
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
-- 
2.20.1

