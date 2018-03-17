Return-Path: <jlayton@kernel.org>
X-Google-Smtp-Source: AG47ELskevkSrqZzdD9SegM4X7rvdxUnai5tQRwJLHqVCmGQ+Mjo4hH1OKqFYq8g7gj1U3OyH3fQ
ARC-Seal: i=1; a=rsa-sha256; t=1521305942; cv=none;
        d=google.com; s=arc-20160816;
        b=Yj40pkk6QGKtMxuH1Mb6/4BLQjuB58Qx+bU2w123bU+rK1PwET6kULcyv0pTnG7RCu
         sBVMRKEp3H7ccfq5O8dxD0HyBY5Dbhy+UjiTnkh7ryY0zrHcWSk6OmtMf+VU4eqBVvJm
         l0vm1bGzQQvbMMBhYCOtJ5R7wQr4o+LsCi9Q1/A5I+jXS2PEjugQh+i80/ZBQZJDgO6a
         IdiTN5+lBkUQGSpCmyIMfOHCdwoUPMBrdB1sVzQj1gHYyLjbXoRcXurb2Emz/ZiELvpH
         mn+Izp9EN1/RdMZ3cFkJdlSBXZiGzFLumLYphMuGFtOIbWsHcNHF/+Bjx45bE73qggVB
         j55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dmarc-filter
         :arc-authentication-results;
        bh=CL8VUMxmGau3NN2b1Vozqm1WB6N2RwDt3rfEZPARyFw=;
        b=0FDks3wlVdiFnbw8smtIJguWvBTP+itLIYMbv57tHao3qUf3lbk2a+8EiMCljj36kD
         bazFD7iOipPACZir/jEkKqlDgThoW81ru4t3KeZpQocixk0GEMSR7zQPq00YCYhz7t4Y
         PERC1Gf6Jui3Zzmz37NNBAmpK49ULgFL7BF8tG7zrkJlCRCgUqpTAc6Jzb9VahzyLCBB
         s+FtDVNQb2LsspkPzzG+n4Ip8uueEHXQ7/6D9/52GTLSgi6juKImFIEfzpLhP6O8njIg
         vbmpry3wfhEiT3wMYsO5K/cgKC/Y5S2g0iaSwDmNfvaHeOSuI8MLEq97J07nhBW81EcD
         vStg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jlayton@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jlayton@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jlayton@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jlayton@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C8921737
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
Subject: [PATCH v2] locks: change POSIX lock ownership on execve when files_struct is displaced
Date: Sat, 17 Mar 2018 12:58:59 -0400
Message-Id: <20180317165859.26200-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180317142520.30520-1-jlayton@kernel.org>
References: <20180317142520.30520-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595195233416759536?=
X-GMAIL-MSGID: =?utf-8?q?1595204900024165744?=
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
 fs/exec.c          |  4 +++-
 fs/locks.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  8 ++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7eb8d21bcab9..35b05376bf78 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1812,8 +1812,10 @@ static int do_execveat_common(int fd, struct filename *filename,
 	free_bprm(bprm);
 	kfree(pathbuf);
 	putname(filename);
-	if (displaced)
+	if (displaced) {
+		posix_change_lock_owners(current->files, displaced);
 		put_files_struct(displaced);
+	}
 	return retval;
 
 out:
diff --git a/fs/locks.c b/fs/locks.c
index d6ff4beb70ce..ab428ca8bb11 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -993,6 +993,66 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 	return error;
 }
 
+struct posix_change_lock_owners_arg {
+	fl_owner_t old;
+	fl_owner_t new;
+};
+
+static int posix_change_lock_owners_cb(const void *varg, struct file *file,
+					  unsigned int fd)
+{
+	const struct posix_change_lock_owners_arg *arg = varg;
+	struct inode *inode = file_inode(file);
+	struct file_lock_context *ctx;
+	struct file_lock *fl, *tmp;
+
+	/* If there is no context, then no locks need to be changed */
+	ctx = locks_get_lock_context(inode, F_UNLCK);
+	if (!ctx)
+		return 0;
+
+	percpu_down_read_preempt_disable(&file_rwsem);
+	spin_lock(&ctx->flc_lock);
+	/* Find the first lock with the old owner */
+	list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
+		if (fl->fl_owner == arg->old)
+			break;
+	}
+
+	list_for_each_entry_safe_from(fl, tmp, &ctx->flc_posix, fl_list) {
+		if (fl->fl_owner != arg->old)
+			break;
+
+		/* This should only be used for normal userland lockmanager */
+		if (fl->fl_lmops) {
+			WARN_ON_ONCE(1);
+			break;
+		}
+		fl->fl_owner = arg->new;
+	}
+	spin_unlock(&ctx->flc_lock);
+	percpu_up_read_preempt_enable(&file_rwsem);
+	return 0;
+}
+
+/**
+ * posix_change_lock_owners - change lock owners from old files_struct to new
+ * @files: new files struct to own locks
+ * @old: old files struct that previously held locks
+ *
+ * On execve, a process may end up with a new files_struct. In that case, we
+ * must change all of the locks that were owned by the previous files_struct
+ * to the new one.
+ */
+void posix_change_lock_owners(struct files_struct *new,
+			      struct files_struct *old)
+{
+	struct posix_change_lock_owners_arg arg = { .old = old,
+						    .new = new };
+
+	iterate_fd(new, 0, posix_change_lock_owners_cb, &arg);
+}
+
 static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			    struct file_lock *conflock)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 79c413985305..65fa99707bf9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1098,6 +1098,8 @@ extern int lease_modify(struct file_lock *, int, struct list_head *);
 struct files_struct;
 extern void show_fd_locks(struct seq_file *f,
 			 struct file *filp, struct files_struct *files);
+extern void posix_change_lock_owners(struct files_struct *new,
+				     struct files_struct *old);
 #else /* !CONFIG_FILE_LOCKING */
 static inline int fcntl_getlk(struct file *file, unsigned int cmd,
 			      struct flock __user *user)
@@ -1232,6 +1234,12 @@ static inline int lease_modify(struct file_lock *fl, int arg,
 struct files_struct;
 static inline void show_fd_locks(struct seq_file *f,
 			struct file *filp, struct files_struct *files) {}
+
+static inline void posix_change_lock_owners(struct files_struct *new,
+					    struct files_struct *old)
+{
+}
+
 #endif /* !CONFIG_FILE_LOCKING */
 
 static inline struct inode *file_inode(const struct file *f)
-- 
2.14.3
