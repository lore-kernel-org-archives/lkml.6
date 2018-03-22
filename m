Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeCVDhv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 23:37:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751728AbeCVDhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 23:37:47 -0400
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, akpm@linux-foundation.org,
        takahiro.akashi@linaro.org, ebiederm@xmission.com, vgoyal@redhat.com,
        dyoung@redhat.com, prudo@linux.vnet.ibm.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/2] kexec_file: Load kernel at top of system RAM if required
Date: Thu, 22 Mar 2018 11:37:22 +0800
Message-Id: <20180322033722.9279-3-bhe@redhat.com>
In-Reply-To: <20180322033722.9279-1-bhe@redhat.com>
References: <20180322033722.9279-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kexec_file loading, if kexec_buf.top_down is 'true', the memory which
is used to load kernel/initrd/purgatory is supposed to be allocated from
top to down. This is also consistent with the old kexec loading interface.

However, the current arch_kexec_walk_mem() doesn't do like this. It ignores
checking kexec_buf.top_down, bug calls walk_system_ram_res() directly to go
through all resources of System RAM, to try to find memory region which can
contain the specific kexec buffer, then call locate_mem_hole_callback() to
allocate memory in that found memory region from top to down. This is not
right.

Here add checking if kexec_buf.top_down is 'true' in arch_kexec_walk_mem(),
if yes, call the newly added walk_system_ram_res_rev() to find memory region
from top to down to load kernel.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 57ec39995b23..76e6307f8971 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -445,6 +445,8 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
 					   crashk_res.start, crashk_res.end,
 					   kbuf, func);
+	else if (kbuf->top_down)
+		return walk_system_ram_res_rev(0, ULONG_MAX, kbuf, func);
 	else
 		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
 }
-- 
2.13.6
