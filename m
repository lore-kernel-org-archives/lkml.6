Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeBDKu4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 05:50:56 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33193 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeBDKuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 05:50:18 -0500
X-Google-Smtp-Source: AH8x225n9hWqhuO1CK3ANtQ6eJPZOwi6jLoUMBwP3EV1ypLhKI48H11h2x+ftxriUP+arRKJAhDdKg==
From: Tycho Andersen <tycho@tycho.ws>
To: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Cc: Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [RFC 3/3] seccomp: add a way to get a listener fd from ptrace
Date: Sun,  4 Feb 2018 11:49:46 +0100
Message-Id: <20180204104946.25559-4-tycho@tycho.ws>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180204104946.25559-1-tycho@tycho.ws>
References: <20180204104946.25559-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
version which can acquire filters is useful. There are at least two reasons
this is preferable, even though it uses ptrace:

1. You can control tasks that aren't cooperating with you
2. You can control tasks whose filters block sendmsg() and socket(); if the
   task installs a filter which blocks these calls, there's no way with
   SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Kees Cook <keescook@chromium.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Oleg Nesterov <oleg@redhat.com>
CC: Eric W. Biederman <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Christian Brauner <christian.brauner@ubuntu.com>
CC: Tyler Hicks <tyhicks@canonical.com>
CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
---
 include/linux/seccomp.h                       | 11 +++++
 include/uapi/linux/ptrace.h                   |  1 +
 kernel/ptrace.c                               |  4 ++
 kernel/seccomp.c                              | 24 ++++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 66 +++++++++++++++++++++++++++
 5 files changed, 106 insertions(+)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index ce07da2ffd53..0d4750e04bb1 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -103,4 +103,15 @@ static inline long seccomp_get_filter(struct task_struct *task,
 	return -EINVAL;
 }
 #endif /* CONFIG_SECCOMP_FILTER && CONFIG_CHECKPOINT_RESTORE */
+
+#ifdef CONFIG_SECCOMP_USER_NOTIFICATION
+extern long seccomp_get_listener(struct task_struct *task,
+				 unsigned long filter_off);
+#else
+static inline long seccomp_get_listener(struct task_struct *task,
+					unsigned long filter_off)
+{
+	return -EINVAL;
+}
+#endif/* CONFIG_SECCOMP_USER_NOTIFICATION */
 #endif /* _LINUX_SECCOMP_H */
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index e3939e00980b..60113de59b04 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -66,6 +66,7 @@ struct ptrace_peeksiginfo_args {
 #define PTRACE_SETSIGMASK	0x420b
 
 #define PTRACE_SECCOMP_GET_FILTER	0x420c
+#define PTRACE_SECCOMP_GET_LISTENER	0x420d
 
 /* Read signals from a shared (process wide) queue */
 #define PTRACE_PEEKSIGINFO_SHARED	(1 << 0)
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 84b1367935e4..50d8cc8be054 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1092,6 +1092,10 @@ int ptrace_request(struct task_struct *child, long request,
 		ret = seccomp_get_filter(child, addr, datavp);
 		break;
 
+	case PTRACE_SECCOMP_GET_LISTENER:
+		ret = seccomp_get_listener(child, addr);
+		break;
+
 	default:
 		break;
 	}
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 800db3f2866f..0b1f65273d2a 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1605,4 +1605,28 @@ static struct file *init_listener(struct seccomp_filter *filter)
 	mutex_unlock(&filter->notify_lock);
 	return ret;
 }
+
+long seccomp_get_listener(struct task_struct *task,
+			  unsigned long filter_off)
+{
+	struct seccomp_filter *filter;
+	struct file *listener;
+	int fd;
+
+	filter = get_nth_filter(task, filter_off);
+	if (IS_ERR(filter))
+		return PTR_ERR(filter);
+
+	listener = init_listener(filter);
+	if (IS_ERR(listener))
+		return PTR_ERR(listener);
+
+	fd = get_unused_fd_flags(O_RDWR);
+	if (fd < 0)
+		put_filp(listener);
+	else
+		fd_install(fd, listener);
+
+	return fd;
+}
 #endif
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index b43e2a70b08c..80f89a766895 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -168,6 +168,10 @@ int seccomp(unsigned int op, unsigned int flags, void *args)
 }
 #endif
 
+#ifndef PTRACE_SECCOMP_GET_LISTENER
+#define PTRACE_SECCOMP_GET_LISTENER 0x420d
+#endif
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]))
 #elif __BYTE_ORDER == __BIG_ENDIAN
@@ -2957,6 +2961,68 @@ TEST(get_user_notification_syscall)
 	close(listener);
 }
 
+TEST(get_user_notification_ptrace)
+{
+	pid_t pid;
+	int status, listener;
+	int sk_pair[2];
+	char c;
+	struct seccomp_notif req;
+	struct seccomp_notif_resp resp;
+
+	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ASSERT_EQ(user_trap_syscall(__NR_getpid, 0), 0);
+
+		/* Test that we get ENOSYS while not attached */
+		ASSERT_EQ(syscall(__NR_getpid), -1);
+		ASSERT_EQ(errno, ENOSYS);
+
+		/* Signal we're ready and have installed the filter. */
+		ASSERT_EQ(write(sk_pair[1], "J", 1), 1);
+
+		ASSERT_EQ(read(sk_pair[1], &c, 1), 1);
+		ASSERT_EQ(c, 'H');
+
+		exit(syscall(__NR_getpid) != USER_NOTIF_MAGIC);
+	}
+
+	ASSERT_EQ(read(sk_pair[0], &c, 1), 1);
+	ASSERT_EQ(c, 'J');
+
+	ASSERT_EQ(ptrace(PTRACE_ATTACH, pid), 0);
+	ASSERT_EQ(waitpid(pid, NULL, 0), pid);
+	listener = ptrace(PTRACE_SECCOMP_GET_LISTENER, pid, 0);
+	ASSERT_GE(listener, 0);
+
+	/* EBUSY for second listener */
+	ASSERT_EQ(ptrace(PTRACE_SECCOMP_GET_LISTENER, pid, 0), -1);
+	ASSERT_EQ(errno, EBUSY);
+
+	ASSERT_EQ(ptrace(PTRACE_DETACH, pid, NULL, 0), 0);
+
+	/* Now signal we are done and respond with magic */
+	ASSERT_EQ(write(sk_pair[0], "H", 1), 1);
+
+	ASSERT_EQ(read(listener, &req, sizeof(req)), sizeof(req));
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+
+	ASSERT_EQ(write(listener, &resp, sizeof(resp)), sizeof(resp));
+
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_EQ(true, WIFEXITED(status));
+	ASSERT_EQ(0, WEXITSTATUS(status));
+
+	close(listener);
+}
+
 /*
  * TODO:
  * - add microbenchmarks
-- 
2.14.1
