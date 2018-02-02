Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbeBBO7E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:59:04 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:53657 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbeBBO65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:58:57 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Len Brown <len.brown@intel.com>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bart.vanassche@wdc.com>, linux-pm@vger.kernel.org
Subject: [PATCH 2/3] x86: fix swsusp_arch_resume prototype
Date: Fri,  2 Feb 2018 15:56:18 +0100
Message-Id: <20180202145634.200291-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202145634.200291-1-arnd@arndb.de>
References: <20180202145434.100626-1-arnd@arndb.de>
 <20180202145634.200291-1-arnd@arndb.de>
X-Provags-ID: V03:K0:ky5wMEXrnMiWObgBA5KeDBRDcJHbRB63cOR62Dk9Joh5+1tRJC5
 CjM86WptwuuIxieB4rxjpSZrBk4iT9feA8Ncizh81R03TOV7sTarb2I1VubutQYQmZ/ZaPG
 IAXGsKFNLB1yBUkDOZbzx94RHHiX8evSkiWCUQmFW+P8BTi3ouGqkHIUbGbURli/HKwXBS6
 ycE1m4L7Z1AQKdtC6kcrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SOG8ZtnVteE=:N2Ou79kS+dqCc0gWQYsaDU
 XKvkJH98YLzjTmVW5Ed5hIFcSWwyVZRIeYbhupqeEJUsgclX0zbqT8GxEB8gj+QaU4KTu47Nb
 vFO9yGVJToocmhXNlX4kNsAHjnWEpTK7S1ssF/hQeZufRDQWlWWEMaJlKfnrouVHulRzXDJxq
 6+ZdM1OrOZ0kaVrPPAGqWtD3dp4DE2w0jD6KQ1JzSeaTIX5XgmztKTWJRjMGOwsmI+AYvM4xf
 pJNFQjWAAXckblzYf6wXFo5lnhqELhvnxJHeM0+ApJlYp4dW3iugB523KBDObmz/Mo9d2O5dZ
 vl4zH/kTRBRvBhqFk6Libwz5GIYwWHgfiZO6aIgFxALqiZ0vUNYmCWIt6PFcSQiRGoISzmxTL
 PvRNntWbUrDaHbnimh1LorNjS50190WtaM1+RBpuL9U8GKbkmcjU3pntzq9om+fKvAlaNuGvm
 gLg3MmF7S9TAjjfZjyqvr2KyjGDmV0pFTdae3bALnKW1hPojyvHtfn06HFkDFl3O0CaIRSUKJ
 eaeN+QEcMIxXgvoMr85XkUTwtBzpnPYzMeQlb63yuKUbXxuF6Dwl6k1njPh9w8OwGb62AMPzH
 6YsMqK80FB9HnPuKtsmGCfobHMo1t/rlQeXTAVgKz/JQfdpURE0sBQGelUWke+p2nPw9F8uFK
 UnB6Jd2OVS8YQIy1P7Y7fxAJuFv7ZPkA71vuPAiuyHF2r1FEOPeaYbqz5QDCmkAUQ3DvHDOUh
 5lr6KZB51m/oaZ9fhZsqB+4PeAwGsGviaFqvsw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The declaration for swsusp_arch_resume marks it as 'asmlinkage',
but the definition in x86-32 does not, and it fails to include
the header with the declaration. This leads to a warning when
building with link-time-optimizations:

kernel/power/power.h:108:23: error: type of 'swsusp_arch_resume' does not match original declaration [-Werror=lto-type-mismatch]
 extern asmlinkage int swsusp_arch_resume(void);
                       ^
arch/x86/power/hibernate_32.c:148:0: note: 'swsusp_arch_resume' was previously declared here
 int swsusp_arch_resume(void)

This moves the declaration into a globally visible header file
and fixes up both x86 definitions to match it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/power/hibernate_32.c | 2 +-
 arch/x86/power/hibernate_64.c | 2 +-
 include/linux/suspend.h       | 2 ++
 kernel/power/power.h          | 3 ---
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index c35fdb585c68..afc4ed7b1578 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -145,7 +145,7 @@ static inline void resume_init_first_level_page_table(pgd_t *pg_dir)
 #endif
 }
 
-int swsusp_arch_resume(void)
+asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
 
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index f910c514438f..0ef5e5204968 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -174,7 +174,7 @@ static int relocate_restore_code(void)
 	return 0;
 }
 
-int swsusp_arch_resume(void)
+asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
 
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index cc22a24516d6..440b62f7502e 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -384,6 +384,8 @@ extern int swsusp_page_is_forbidden(struct page *);
 extern void swsusp_set_page_free(struct page *);
 extern void swsusp_unset_page_free(struct page *);
 extern unsigned long get_safe_page(gfp_t gfp_mask);
+extern asmlinkage int swsusp_arch_suspend(void);
+extern asmlinkage int swsusp_arch_resume(void);
 
 extern void hibernation_set_ops(const struct platform_hibernation_ops *ops);
 extern int hibernate(void);
diff --git a/kernel/power/power.h b/kernel/power/power.h
index f29cd178df90..9e58bdc8a562 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -104,9 +104,6 @@ extern int in_suspend;
 extern dev_t swsusp_resume_device;
 extern sector_t swsusp_resume_block;
 
-extern asmlinkage int swsusp_arch_suspend(void);
-extern asmlinkage int swsusp_arch_resume(void);
-
 extern int create_basic_memory_bitmaps(void);
 extern void free_basic_memory_bitmaps(void);
 extern int hibernate_preallocate_memory(void);
-- 
2.9.0
