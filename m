Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeBBWjo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:39:44 -0500
Received: from terminus.zytor.com ([65.50.211.136]:37535 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeBBWjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:39:37 -0500
Date: Fri, 2 Feb 2018 14:37:15 -0800
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-328008a72d38b5bde6491e463405c34a81a65d3e@git.kernel.org>
Cc: len.brown@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de, rjw@rjwysocki.net, nico@linaro.org,
        ak@linux.intel.com, bart.vanassche@wdc.com, mingo@kernel.org,
        pavel@ucw.cz
Reply-To: pavel@ucw.cz, mingo@kernel.org, ak@linux.intel.com, nico@linaro.org,
        bart.vanassche@wdc.com, rjw@rjwysocki.net, len.brown@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        arnd@arndb.de
In-Reply-To: <20180202145634.200291-2-arnd@arndb.de>
References: <20180202145634.200291-2-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/power: Fix swsusp_arch_resume prototype
Git-Commit-ID: 328008a72d38b5bde6491e463405c34a81a65d3e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  328008a72d38b5bde6491e463405c34a81a65d3e
Gitweb:     https://git.kernel.org/tip/328008a72d38b5bde6491e463405c34a81a65d3e
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri, 2 Feb 2018 15:56:18 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 2 Feb 2018 23:33:50 +0100

x86/power: Fix swsusp_arch_resume prototype

The declaration for swsusp_arch_resume marks it as 'asmlinkage', but the
definition in x86-32 does not, and it fails to include the header with the
declaration. This leads to a warning when building with
link-time-optimizations:

kernel/power/power.h:108:23: error: type of 'swsusp_arch_resume' does not match original declaration [-Werror=lto-type-mismatch]
 extern asmlinkage int swsusp_arch_resume(void);
                       ^
arch/x86/power/hibernate_32.c:148:0: note: 'swsusp_arch_resume' was previously declared here
 int swsusp_arch_resume(void)

This moves the declaration into a globally visible header file and fixes up
both x86 definitions to match it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <len.brown@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Link: https://lkml.kernel.org/r/20180202145634.200291-2-arnd@arndb.de

---
 arch/x86/power/hibernate_32.c | 2 +-
 arch/x86/power/hibernate_64.c | 2 +-
 include/linux/suspend.h       | 2 ++
 kernel/power/power.h          | 3 ---
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index c35fdb5..afc4ed7 100644
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
index f910c51..0ef5e520 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -174,7 +174,7 @@ out:
 	return 0;
 }
 
-int swsusp_arch_resume(void)
+asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
 
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index cc22a24..440b62f 100644
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
index f29cd17..9e58bdc 100644
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
