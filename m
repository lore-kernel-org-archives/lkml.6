Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeDLSXr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 14:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752763AbeDLSXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 14:23:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963D0217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Subject: [PATCH v1 2/2] kexec: Remove "weak" from arch_kexec_walk_mem()
 declaration
From: Bjorn Helgaas <helgaas@kernel.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Apr 2018 13:23:43 -0500
Message-ID: <152355742351.36693.10357998251441779301.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Weak header file declarations are error-prone because they make every
definition weak, and the linker chooses one based on link order (see
10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_node
decl")).

kernel/kexec_file.c contains a weak definition of arch_kexec_walk_mem() and
arch/powerpc/kernel/machine_kexec_file_64.c contains a definition intended
to be non-weak.  But the annotation in the header file makes *both*
definitions weak, so it's unclear which one will be used.

Remove the "weak" attribute from the declaration so we always prefer a
non-weak definition over the weak one.

Fixes: 60fe3910bb02 ("kexec_file: Allow arch-specific memory walking for kexec_add_buffer")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org      # v4.10+
---
 include/linux/kexec.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8bf0ff90885c..e7db550c5fb6 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -159,8 +159,8 @@ struct kexec_buf {
 	bool top_down;
 };
 
-int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
-			       int (*func)(struct resource *, void *));
+int arch_kexec_walk_mem(struct kexec_buf *kbuf,
+			int (*func)(struct resource *, void *));
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 #endif /* CONFIG_KEXEC_FILE */
