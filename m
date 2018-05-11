Return-Path: <gladkov.alexey@gmail.com>
X-Google-Smtp-Source: AB8JxZq88RMcB6YBs5zI5RRzGaUDtwDErldloSaU2RixjiYjO1htFx0Dj/By75+JwlS+jglwPU8A
ARC-Seal: i=1; a=rsa-sha256; t=1526031906; cv=none;
        d=google.com; s=arc-20160816;
        b=LxvU7NXRJIe7DLaep9p5jrmiLp9aeuEWVJ5wRCqJuOnZNTl9CgSNqvg9ugvVQCdlEY
         SDOZbc5dlRjZTN5vyCRw/A/krrYAJHsRfy3T8Ghmv/zSNDjj1niyAjA0xn8Re7//rZ7V
         iiRXlatPNUTrVh8xZFGXTTHjO9lV/m1J/KqO0PmlicKS9Hl1kZx6LPN/8H7qpCpmJ1Et
         0XU7fwb3P2x47FJTa6ER64tubEd9Lze9Tbp0NwX/+wxOMrtjwBfH1StlPbZkgxmnlFhb
         Z+dFRZJNsePIcHaeQhMBJiLiT+6j07TViiF/Bk0mQV59uL32kSfnlpvI6kJmQ7tZWP2n
         suOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=y+wglGTRmkq6wNFgTQEL3gL6VCKmlF12aktH9CyRLj4=;
        b=NmKR4ONLzjLdJX067YCPBnpDDkilePLdlA3JsqJtKb3qsDX22rD3hjmoGBI4x9KD2r
         JqttH7V8pjgSSTylxVJNLZ1Gqn0UcLCRwHWsoyjDsnVNIz5YqHmDi/VHKDahOlKCh+Gt
         mHYQ8H5TXR3+l6un3MqPN88woOKNpGTgQ198B8OjqtAWoEbLOlPdBQnC59gJTYjv6CE7
         jRsU9KPkLl6FwIdQzXzg6z0AUwX8Xyyfzrp5DZUIdxgrbnzh6tqar3Cvg9fILvLL6UV5
         PsH732lm/IDzpV+bE23JnMk6va4S0j40Rb+6izt+ST8FRSAvPpE3Z+Bq9eToIgGugQQE
         3jTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gladkov.alexey@gmail.com does not designate 5.9.28.80 as permitted sender) smtp.mailfrom=gladkov.alexey@gmail.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gladkov.alexey@gmail.com does not designate 5.9.28.80 as permitted sender) smtp.mailfrom=gladkov.alexey@gmail.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Fri, 11 May 2018 11:35:08 +0200
From: Alexey Gladkov <gladkov.alexey@gmail.com>
To: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Jeff Layton <jlayton@poochiereds.net>,
	Ingo Molnar <mingo@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	aniel Micay <danielmicay@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, bfields@fieldses.org,
	Stephen Rothwell <sfr@canb.auug.org.au>, solar@openwall.com,
	"Dmitry V. Levin" <ldv@altlinux.org>,
	Djalal Harouni <tixxdz@gmail.com>
Subject: [PATCH v5 2/7] proc: move /proc/{self|thread-self} dentries to
 proc_fs_info
Message-ID: <20180511093508.GA1107@comp-core-i7-2640m-0182e6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600160432330336597?=
X-GMAIL-MSGID: =?utf-8?q?1600160432330336597?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Djalal Harouni <tixxdz@gmail.com>

This is a preparation patch that moves /proc/{self|thread-self} dentries
to be stored inside procfs fs_info struct instead of making them per pid
namespace. Since we want to support multiple procfs instances we need to
make sure that these dentries are also per-superblock instead of
per-pidns, unmounting a private procfs won't clash with other procfs
mounts.

Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
---
 fs/proc/base.c                | 4 ++--
 fs/proc/root.c                | 8 ++++----
 fs/proc/self.c                | 3 +--
 fs/proc/thread_self.c         | 5 ++---
 include/linux/pid_namespace.h | 4 +---
 include/linux/proc_fs.h       | 2 ++
 6 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 99a0f24..e0c2afc 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3252,13 +3252,13 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 		return 0;
 
 	if (pos == TGID_OFFSET - 2) {
-		struct inode *inode = d_inode(ns->proc_self);
+		struct inode *inode = d_inode(fs_info->proc_self);
 		if (!dir_emit(ctx, "self", 4, inode->i_ino, DT_LNK))
 			return 0;
 		ctx->pos = pos = pos + 1;
 	}
 	if (pos == TGID_OFFSET - 1) {
-		struct inode *inode = d_inode(ns->proc_thread_self);
+		struct inode *inode = d_inode(fs_info->proc_thread_self);
 		if (!dir_emit(ctx, "thread-self", 11, inode->i_ino, DT_LNK))
 			return 0;
 		ctx->pos = pos = pos + 1;
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 5d4c454..184c42b 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -162,10 +162,10 @@ static void proc_kill_sb(struct super_block *sb)
 	struct proc_fs_info *fs_info = proc_sb(sb);
 	struct pid_namespace *ns = (struct pid_namespace *)fs_info->pid_ns;
 
-	if (ns->proc_self)
-		dput(ns->proc_self);
-	if (ns->proc_thread_self)
-		dput(ns->proc_thread_self);
+	if (fs_info->proc_self)
+		dput(fs_info->proc_self);
+	if (fs_info->proc_thread_self)
+		dput(fs_info->proc_thread_self);
 	kill_anon_super(sb);
 	put_pid_ns(ns);
 	kfree(fs_info);
diff --git a/fs/proc/self.c b/fs/proc/self.c
index 3f2a88f..9ad3c55 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -38,7 +38,6 @@ int proc_setup_self(struct super_block *s)
 {
 	struct inode *root_inode = d_inode(s->s_root);
 	struct proc_fs_info *fs_info = proc_sb(s);
-	struct pid_namespace *ns = fs_info->pid_ns;
 	struct dentry *self;
 
 	inode_lock(root_inode);
@@ -65,7 +64,7 @@ int proc_setup_self(struct super_block *s)
 		pr_err("proc_fill_super: can't allocate /proc/self\n");
 		return PTR_ERR(self);
 	}
-	ns->proc_self = self;
+	fs_info->proc_self = self;
 	return 0;
 }
 
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index e80dd79..8db3503 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -37,7 +37,6 @@ static unsigned thread_self_inum __ro_after_init;
 int proc_setup_thread_self(struct super_block *s)
 {
 	struct proc_fs_info *fs_info = proc_sb(s);
-	struct pid_namespace *ns = fs_info->pid_ns;
 	struct inode *root_inode = d_inode(s->s_root);
 	struct dentry *thread_self;
 
@@ -62,10 +61,10 @@ int proc_setup_thread_self(struct super_block *s)
 	}
 	inode_unlock(root_inode);
 	if (IS_ERR(thread_self)) {
-		pr_err("proc_fill_super: can't allocate /proc/thread_self\n");
+		pr_err("proc_fill_super: can't allocate /proc/thread-self\n");
 		return PTR_ERR(thread_self);
 	}
-	ns->proc_thread_self = thread_self;
+	fs_info->proc_thread_self = thread_self;
 	return 0;
 }
 
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 49538b1..f91a8bf 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -31,9 +31,7 @@ struct pid_namespace {
 	unsigned int level;
 	struct pid_namespace *parent;
 #ifdef CONFIG_PROC_FS
-	struct vfsmount *proc_mnt;
-	struct dentry *proc_self;
-	struct dentry *proc_thread_self;
+	struct vfsmount *proc_mnt; /* Internal proc mounted during each new pidns */
 #endif
 #ifdef CONFIG_BSD_PROCESS_ACCT
 	struct fs_pin *bacct;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 7c8cf3c..5e461f6 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -11,6 +11,8 @@
 
 struct proc_fs_info {
 	struct pid_namespace *pid_ns;
+	struct dentry *proc_self; /* For /proc/self */
+	struct dentry *proc_thread_self; /* For /proc/thread-self/ */
 };
 
 struct proc_dir_entry;
-- 
2.10.5
