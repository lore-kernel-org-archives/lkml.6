Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeDHCsA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 22:48:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752572AbeDHCr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 22:47:57 -0400
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org
Subject: [PATCH v2 3/3] kexec_file: Load kernel at top of system RAM if required
Date: Sun,  8 Apr 2018 10:47:24 +0800
Message-Id: <20180408024724.16812-4-bhe@redhat.com>
In-Reply-To: <20180408024724.16812-1-bhe@redhat.com>
References: <20180408024724.16812-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kexec_file loading, if kexec_buf.top_down is 'true', the memory which
is used to load kernel/initrd/purgatory is supposed to be allocated from
top to down. This is what we have been doing all along in the old kexec
loading interface and the kexec loading is still default setting in some
distributions. However, the current kexec_file loading interface doesn't
do likt this. The function arch_kexec_walk_mem() it calls ignores checking
kexec_buf.top_down, but calls walk_system_ram_res() directly to go through
all resources of System RAM from bottom to up, to try to find memory region
which can contain the specific kexec buffer, then call locate_mem_hole_callback()
to allocate memory in that found memory region from top to down. This brings
confusion. These two interfaces need be unified on behaviour.

Here add checking if kexec_buf.top_down is 'true' in arch_kexec_walk_mem(),
if yes, call the newly added walk_system_ram_res_rev() to find memory region
from top to down to load kernel.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: kexec@lists.infradead.org

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
