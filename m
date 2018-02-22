Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeBVBpM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 20:45:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:35851 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751732AbeBVBpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 20:45:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,376,1515484800";
   d="scan'208";a="19499276"
Date: Wed, 21 Feb 2018 17:45:06 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: [PATCH] efivarfs: Limit the rate for non-root to read files
Message-ID: <20180222014505.2l76ccrrs36y3b26@agluck-desk>
References: <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37DE1B@ORSMSX110.amr.corp.intel.com>
 <CA+55aFwKsa6bq5SUD6wKv8znGcxqjLCPh33a3DkbnUkSfd68Yw@mail.gmail.com>
 <CAKv+Gu--iHii9SxE7RMZKdVdLvQPPGo0wdCzG30xW0+7dakbmw@mail.gmail.com>
 <CA+55aFx4Q7AzCM5mDwga6_LteNUBWQsT6nKJMjn8JcriS3ExuQ@mail.gmail.com>
 <20180221182104.GI3231@tassilo.jf.intel.com>
 <20180221194731.t7jowrmicvaggu3x@agluck-desk>
 <CA+55aFzy89V13rSxGQy77Bb08qpUpH+J=trcjooKQhsAFbgrVw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37F130@ORSMSX110.amr.corp.intel.com>
 <CA+55aFx3WKAL7e3TAs-2okggW6Z+DHANdmcsr+WTDh3N-Mx+Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFx3WKAL7e3TAs-2okggW6Z+DHANdmcsr+WTDh3N-Mx+Xw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each read from a file in efivarfs results in two calls to EFI
(one to get the file size, another to get the actual data).

On X86 these EFI calls result in broadcast system management
interrupts (SMI) which affect performance of the whole system.
A malicious user can loop performing reads from efivarfs bringing
the system to its knees.

Linus suggested per-user rate limit to solve this.

So we add a ratelimit structure to "user_struct" and initialize
it for the root user for no limit. When allocating user_struct for
other users we set the limit to 100 per second. This could be used
for other places that want to limit the rate of some detrimental
user action.

In efivarfs if the limit is exceeded when reading, we sleep for 10ms.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/efivarfs/file.c         | 4 ++++
 include/linux/sched/user.h | 4 ++++
 kernel/user.c              | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 5f22e74bbade..7bcf5b041028 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/efi.h>
+#include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/mount.h>
@@ -74,6 +75,9 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 	ssize_t size = 0;
 	int err;
 
+	if (!__ratelimit(&file->f_cred->user->ratelimit))
+		usleep_range(10000, 10000);
+
 	err = efivar_entry_size(var, &datasize);
 
 	/*
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 0dcf4e480ef7..96fe289c4c6e 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -4,6 +4,7 @@
 
 #include <linux/uidgid.h>
 #include <linux/atomic.h>
+#include <linux/ratelimit.h>
 
 struct key;
 
@@ -41,6 +42,9 @@ struct user_struct {
     defined(CONFIG_NET)
 	atomic_long_t locked_vm;
 #endif
+
+	/* Miscellaneous per-user rate limit */
+	struct ratelimit_state ratelimit;
 };
 
 extern int uids_sysfs_init(void);
diff --git a/kernel/user.c b/kernel/user.c
index 9a20acce460d..36288d840675 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -101,6 +101,7 @@ struct user_struct root_user = {
 	.sigpending	= ATOMIC_INIT(0),
 	.locked_shm     = 0,
 	.uid		= GLOBAL_ROOT_UID,
+	.ratelimit	= RATELIMIT_STATE_INIT(root_user.ratelimit, 0, 0),
 };
 
 /*
@@ -191,6 +192,8 @@ struct user_struct *alloc_uid(kuid_t uid)
 
 		new->uid = uid;
 		atomic_set(&new->__count, 1);
+		ratelimit_state_init(&new->ratelimit, HZ, 100);
+		ratelimit_set_flags(&new->ratelimit, RATELIMIT_MSG_ON_RELEASE);
 
 		/*
 		 * Before adding this, check whether we raced
-- 
2.14.1
