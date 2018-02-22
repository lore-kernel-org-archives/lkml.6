Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933397AbeBVRPY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:15:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:57965 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933148AbeBVRPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:15:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,378,1515484800";
   d="scan'208";a="203004051"
Date: Thu, 22 Feb 2018 09:15:06 -0800
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
Subject: [PATCH v2] efivarfs: Limit the rate for non-root to read files
Message-ID: <20180222171506.wwsichkiyc5f74pr@agluck-desk>
References: <20180221194731.t7jowrmicvaggu3x@agluck-desk>
 <CA+55aFzy89V13rSxGQy77Bb08qpUpH+J=trcjooKQhsAFbgrVw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37F130@ORSMSX110.amr.corp.intel.com>
 <CA+55aFx3WKAL7e3TAs-2okggW6Z+DHANdmcsr+WTDh3N-Mx+Xw@mail.gmail.com>
 <20180222014505.2l76ccrrs36y3b26@agluck-desk>
 <CA+55aFzJXsPcsJ5MtsxTp2n+43xC0yGzANLNcDm1mFbZKR75FQ@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37FE28@ORSMSX110.amr.corp.intel.com>
 <CA+55aFy0hRexJkLbN7t31LjfGr4Ae0W5g6sBMqHHJi8aYuGKeA@mail.gmail.com>
 <612E894E-62C8-4155-AED8-D53702EDC8DC@intel.com>
 <CA+55aFxeBaTbwvbWqx1MKYjKKzLUs=1O43Bx2=JaO8qrnY-8HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxeBaTbwvbWqx1MKYjKKzLUs=1O43Bx2=JaO8qrnY-8HA@mail.gmail.com>
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

In efivarfs if the limit is exceeded when reading, we take an
interruptible nap for 50ms and check the rate limit again.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Does this look better? User processes above the rate limit will
sleep and check the limit again.

 fs/efivarfs/file.c         | 6 ++++++
 include/linux/sched/user.h | 4 ++++
 kernel/user.c              | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 5f22e74bbade..8e568428c88b 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/efi.h>
+#include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/mount.h>
@@ -74,6 +75,11 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 	ssize_t size = 0;
 	int err;
 
+	while (!__ratelimit(&file->f_cred->user->ratelimit)) {
+		if (!msleep_interruptible(50))
+			return -EINTR;
+	}
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
