Return-Path: <jrdr.linux@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524631731; cv=none;
        d=google.com; s=arc-20160816;
        b=o5VV9mu/Ikmo3FzQLLSQYq9jPwWYr/wxyhO4ItVApL16aA4hXBygjuXXgZYSloX2Lk
         qI7KYQ8WdhBZ7mHB4fPcIG33mZlu2BGjYlPNEehTGOm+DsaGpAuKoz207ihr3WN2HId8
         Hsgf/Yd7k67kcyuhTeVWRiIT7647WnZs2rtb+WZBEHDDML2viEl23k3LoqO6OsJXFPgT
         fxhbAiGmwF3NyDLJSjPE5WhIEFryO+zFGRx/7Xye/vdZ38J/fQu4u09uiUl6cFfaIDuq
         DlcuzpqS2kBnp5zDz6jUn4Fzt6NqXhvmEqPAuO2dMe4d0fly8hSh1T+fJUTolszt2P5e
         QMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=bjbkzWQZNzYhxgLiFBaaU5a/GW/BIIw8m42zxj7DS6Y=;
        b=xGqKaIIYnGKqUwtafZaoApm4me1PL6KVaiOxmSqkJhcil+NY53CKNG8GeQVknyXtih
         UMRD8BVTtHclq77AXsZyD7QqGljsw8B72EyQoDM1EHujCvokmhnd4aK75El1TWiCNsRH
         jJA8J3d5mftzgVEFF3+Lml8w/aC+RQydocTvN/S2lE9jp0e544nNga12+RTj5fI2PJYB
         yTvatGLpTMpnTmsUcLamsfaLhvXPyTe0XbMHbNHpkzqrB/5uWrOw7AGhXR8Y7QYnDabF
         ExJEbUwfTPCNBpOzL7OyDmJ/CUlp6KfijBkEeEuIExtW3/GcTv3sdmLros398SOCRr+m
         YZHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LPGajR3n;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LPGajR3n;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/sKONSKh7oRSxsGJo3lhFxkL5AGuxtEUoDw38NeEZ1l8xxw95RSSqoblQPfm5f6rwLqqVHCQ==
Date: Wed, 25 Apr 2018 10:20:44 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: sivanich@sgi.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] misc: sgi-gru: Change return type to vm_fault_t
Message-ID: <20180425045044.GA21558@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598692241975703394?=
X-GMAIL-MSGID: =?utf-8?q?1598692241975703394?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

Commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
Acked-by: Dimitri Sivanich <sivanich@hpe.com>
---
v2: Updated the change log

 drivers/misc/sgi-gru/grumain.c   | 2 +-
 drivers/misc/sgi-gru/grutables.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index 3641f13..ab174f28 100644
--- a/drivers/misc/sgi-gru/grumain.c
+++ b/drivers/misc/sgi-gru/grumain.c
@@ -926,7 +926,7 @@ struct gru_state *gru_assign_gru_context(struct gru_thread_state *gts)
  *
  * 	Note: gru segments alway mmaped on GRU_GSEG_PAGESIZE boundaries.
  */
-int gru_fault(struct vm_fault *vmf)
+vm_fault_t gru_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct gru_thread_state *gts;
diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
index b5e308b..3e041b6 100644
--- a/drivers/misc/sgi-gru/grutables.h
+++ b/drivers/misc/sgi-gru/grutables.h
@@ -147,6 +147,7 @@
 #include <linux/mutex.h>
 #include <linux/wait.h>
 #include <linux/mmu_notifier.h>
+#include <linux/mm_types.h>
 #include "gru.h"
 #include "grulib.h"
 #include "gruhandles.h"
@@ -665,7 +666,7 @@ extern unsigned long gru_reserve_cb_resources(struct gru_state *gru,
 		int cbr_au_count, char *cbmap);
 extern unsigned long gru_reserve_ds_resources(struct gru_state *gru,
 		int dsr_au_count, char *dsmap);
-extern int gru_fault(struct vm_fault *vmf);
+extern vm_fault_t gru_fault(struct vm_fault *vmf);
 extern struct gru_mm_struct *gru_register_mmu_notifier(void);
 extern void gru_drop_mmu_notifier(struct gru_mm_struct *gms);
 
-- 
1.9.1
