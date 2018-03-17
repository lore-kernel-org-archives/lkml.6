Return-Path: <jlayton@kernel.org>
X-Google-Smtp-Source: AG47ELvUHw3deI9YemWy0YvUQU9oBupc+mLZy8l5GaHyCqzL3QkR2UkI25+ldnhq26s2iOT8i9xa
ARC-Seal: i=1; a=rsa-sha256; t=1521296723; cv=none;
        d=google.com; s=arc-20160816;
        b=Imf42lCO+DIMyTb9dyKI78qiiRrvszo9hcHxg+IyuJgGaMimTIFSCdf3cG/mUCzJv8
         Um/FEDxpu1aZXlIWaQxOXZgbF+FVL8TjKhsWdLVQr1+J4wQ5EapMj+r8AY9nn98xq/in
         cj7yI+ZGWYisFpX6C9wBRC6lO4ngyURnsJZ+G8uQs97xxPUVD+qMa8TCKCb01bvQp/U8
         WcQWBqfiN96ie/8snbWkdsffUjzpk8/cwQyf7jP0xagLJ3qXlHoANft4xSLMu9mltdRL
         7VDJOCbSl91+rFQtB0krJObjOKc2dh1twsAc3Wc/Hc4694oFCVC8bBrYo6ZVL4r9JtzN
         syRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dmarc-filter:arc-authentication-results;
        bh=V4WFXze4/WNai1UWm1Qf2YyedMryBT+qTpm5CpFNZ04=;
        b=e5F6Bi1nHuAGU+7AMBEpZDIsKbG/7fzAT2bYsl1/PGR0PlQdUWZ0wy00Nrsi41j/6E
         fWKNhfzOraCaOYbP9pp8NIiQ0sO3ONZeZT+j2QrqPOFUXPO34qo0QordnCRpYwSlbY1u
         CoQPgDuujfbLz8i5484K0Rcjb/GOjyxcryokvtL+ujkjpm/lGJ5hjtk3+vQn8mAkyCqf
         4O8cytqCGNvnCCJM5hRChJoxEmjMrAlT2vbtTV8rJ/1B5eZXc+ZO9511ZOdPTiDTXwH8
         EAKDogbEcSE1hAH3CJCKxBoaA5+rf82SU/yTA3PF+cVksLBr9z4VK9DrL5Mks+tonHae
         xdEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jlayton@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jlayton@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jlayton@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jlayton@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67B320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jlayton@kernel.org
From: Jeff Layton <jlayton@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] locks: change POSIX lock ownership on execve when files_struct is displaced
Date: Sat, 17 Mar 2018 10:25:20 -0400
Message-Id: <20180317142520.30520-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595195233416759536?=
X-GMAIL-MSGID: =?utf-8?q?1595195233416759536?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeff Layton <jlayton@redhat.com>

POSIX mandates that open fds and their associated file locks should be
preserved across an execve. This works, unless the process is
multithreaded at the time that execve is called.

In that case, we'll end up unsharing the files_struct but the locks will
still have their fl_owner set to the address of the old one. Eventually,
when the other threads die and the last reference to the old
files_struct is put, any POSIX locks get torn down since it looks like
a close occurred on them.

The result is that all of your open files will be intact with none of
the locks you held before execve. The simple answer to this is "use OFD
locks", but this is a nasty surprise and it violates the spec.

On a successful execve, change ownership of any POSIX file_locks
associated with the old files_struct to the new one, if we ended up
swapping it out.

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/exec.c               |  4 +++-
 fs/file.c               | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/locks.c              | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fdtable.h |  1 +
 include/linux/fs.h      |  6 ++++++
 5 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7eb8d21bcab9..e9f154f9bad9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1812,8 +1812,10 @@ static int do_execveat_common(int fd, struct filename *filename,
 	free_bprm(bprm);
 	kfree(pathbuf);
 	putname(filename);
-	if (displaced)
+	if (displaced) {
+		change_lock_owners(current->files, displaced);
 		put_files_struct(displaced);
+	}
 	return retval;
 
 out:
diff --git a/fs/file.c b/fs/file.c
index 42f0db4bd0fb..18065fcc045a 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -365,6 +365,52 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 	return NULL;
 }
 
+/**
+ * change_lock_owners - change lock ownership from old files struct to new
+ * @files: new files struct to own locks
+ * @old: old files struct that previously held locks
+ *
+ * On execve, a process may end up with a new files_struct. In that case, we
+ * must change all of the locks that were owned by the previous files_struct
+ * to the new one.
+ */
+void change_lock_owners(struct files_struct *new, struct files_struct *old)
+{
+	struct fdtable *fdt = rcu_dereference_raw(new->fdt);
+	unsigned int i, j = 0;
+
+	/*
+	 * It is safe to dereference the fd table without RCU or ->file_lock
+	 * because this is the only reference to the files structure. If that's
+	 * ever not the case, just warn and don't change anything.
+	 */
+	if (unlikely(atomic_read(&new->count) != 1)) {
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	for (;;) {
+		unsigned long set;
+		i = j * BITS_PER_LONG;
+		if (i >= fdt->max_fds)
+			break;
+		set = fdt->open_fds[j++];
+		while (set) {
+			if (set & 1) {
+				struct file *file =
+					rcu_dereference_protected(fdt->fd[i],
+								  true);
+				if (file) {
+					posix_chown_locks(file, old, new);
+					cond_resched();
+				}
+			}
+			i++;
+			set >>= 1;
+		}
+	}
+}
+
 static struct fdtable *close_files(struct files_struct * files)
 {
 	/*
diff --git a/fs/locks.c b/fs/locks.c
index d6ff4beb70ce..f7d4eb147a4d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -993,6 +993,49 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 	return error;
 }
 
+/**
+ * posix_chown_locks - change all locks on inode owned by old fl_owner to new
+ * @file: struct file on which to change the locks
+ * @old: old fl_owner value to change from
+ * @new: new fl_owner value to change to
+ *
+ * This function changes all of the file locks in an inode owned by an old
+ * fl_owner to be owned by a new fl_owner.
+ */
+void posix_chown_locks(struct file *file, fl_owner_t old, fl_owner_t new)
+{
+	struct inode *inode = file_inode(file);
+	struct file_lock_context *ctx;
+	struct file_lock *fl, *tmp;
+
+	/* Don't want to allocate a context in this case */
+	ctx = locks_get_lock_context(inode, F_UNLCK);
+	if (!ctx)
+		return;
+
+	percpu_down_read_preempt_disable(&file_rwsem);
+	spin_lock(&ctx->flc_lock);
+	/* Find the first old lock with the same owner as the new lock */
+	list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
+		if (fl->fl_owner == old)
+			break;
+	}
+
+	list_for_each_entry_safe_from(fl, tmp, &ctx->flc_posix, fl_list) {
+		if (fl->fl_owner != old)
+			break;
+
+		/* This should only be used for normal userland lockmanager */
+		if (fl->fl_lmops) {
+			WARN_ON_ONCE(1);
+			break;
+		}
+		fl->fl_owner = new;
+	}
+	spin_unlock(&ctx->flc_lock);
+	percpu_up_read_preempt_enable(&file_rwsem);
+}
+
 static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			    struct file_lock *conflock)
 {
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 41615f38bcff..228dfb059d69 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -114,6 +114,7 @@ void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
+void change_lock_owners(struct files_struct *, struct files_struct *);
 
 extern int __alloc_fd(struct files_struct *files,
 		      unsigned start, unsigned end, unsigned flags);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 79c413985305..1928fb3db6a0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1084,6 +1084,7 @@ extern void locks_remove_posix(struct file *, fl_owner_t);
 extern void locks_remove_file(struct file *);
 extern void locks_release_private(struct file_lock *);
 extern void posix_test_lock(struct file *, struct file_lock *);
+extern void posix_chown_locks(struct file *, fl_owner_t old, fl_owner_t new);
 extern int posix_lock_file(struct file *, struct file_lock *, struct file_lock *);
 extern int posix_unblock_lock(struct file_lock *);
 extern int vfs_test_lock(struct file *, struct file_lock *);
@@ -1169,6 +1170,11 @@ static inline void posix_test_lock(struct file *filp, struct file_lock *fl)
 	return;
 }
 
+static void posix_chown_locks(struct file *, fl_owner_t old, fl_owner_t new)
+{
+	return;
+}
+
 static inline int posix_lock_file(struct file *filp, struct file_lock *fl,
 				  struct file_lock *conflock)
 {
-- 
2.14.3
