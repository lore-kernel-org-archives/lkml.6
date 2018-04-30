Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrCRJzI5ZzImkZdG4OwxVr5RFQw6ZTuqx6jDoZ9chBc3F1jlzZl6yPjrn1QMAqvT905vSjc
ARC-Seal: i=1; a=rsa-sha256; t=1525116406; cv=none;
        d=google.com; s=arc-20160816;
        b=TptaX4ckYylYn+1xCWqZh57ORs2sdA7y07sk3SXWtoRm5v8vTuGbdWwPijtBkwDEut
         6ibknvBDN6NMRI5zp/go7FuI5p399JWD4/iwBmKsfUOT/PdBUi6n8r/R6RheLnVEV30u
         j7xVaRwPiPCmsrD2hoz/KS9xCGkUb0ZY8FgwlojBBPB4gZ15GqgWCCAb1MuYjJJmyf79
         OhvGyZl2CWqY46Ee+AuIIBHoGT0b6fxBiQHPVE3TdXHsloyW7+KRf1iKj+gCVBa3SbEM
         FxYgrBq6+q9oRdzV6Dl2dRIjNWLfmFcWu6OFun6YRQ6XyOBXNQQWcwKtMFlZisxWJB4q
         rTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=kOIdh2eCzQq5jn7nxWyjzsiADp36PFFMXEfRhqM4aWY=;
        b=Z+Q3AB8/1XSDpE6d9GHn/GZnmfn4CqBt2R2JWTf7wxXi6hGAcTxG38eaaydTASggJo
         Jia12trRHP7gkaraCRWpaRaQnmsUhwEooyLN3sudDdkSPMPA1JGXph+LGcAmjd+32LLl
         nNKi4kch8SURcRoXNBfywNMzA3UVwpvhN++A/eE8VWSyxyCP7JiN2mQsJZaviEjUADeZ
         J3vNvyKEbOQJGkAhti/aP6gnRM5RmkVvvpQwxWjpNmOLeplr13a7mEqZY9rpu+tWfzBx
         6/6cvQYt/7/wW/JoENwMpRb7ujGLPpdI1g4crf6kVZMjrl9rsERfQTHYWbwGrnql2y82
         7spA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8C622DC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H . J . Lu" <hjl.tools@gmail.com>,
	Jeffrey Walton <noloader@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 4.9 58/61] x86/ipc: Fix x32 version of shmid64_ds and msqid64_ds
Date: Mon, 30 Apr 2018 12:25:01 -0700
Message-Id: <20180430183956.206685084@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200461344232814?=
X-GMAIL-MSGID: =?utf-8?q?1599200461344232814?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1a512c0882bd311c5b5561840fcfbe4c25b8f319 upstream.

A bugfix broke the x32 shmid64_ds and msqid64_ds data structure layout
(as seen from user space)  a few years ago: Originally, __BITS_PER_LONG
was defined as 64 on x32, so we did not have padding after the 64-bit
__kernel_time_t fields, After __BITS_PER_LONG got changed to 32,
applications would observe extra padding.

In other parts of the uapi headers we seem to have a mix of those
expecting either 32 or 64 on x32 applications, so we can't easily revert
the path that broke these two structures.

Instead, this patch decouples x32 from the other architectures and moves
it back into arch specific headers, partially reverting the even older
commit 73a2d096fdf2 ("x86: remove all now-duplicate header files").

It's not clear whether this ever made any difference, since at least
glibc carries its own (correct) copy of both of these header files,
so possibly no application has ever observed the definitions here.

Based on a suggestion from H.J. Lu, I tried out the tool from
https://github.com/hjl-tools/linux-header to find other such
bugs, which pointed out the same bug in statfs(), which also has
a separate (correct) copy in glibc.

Fixes: f4b4aae18288 ("x86/headers/uapi: Fix __BITS_PER_LONG value for x32 builds")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H . J . Lu" <hjl.tools@gmail.com>
Cc: Jeffrey Walton <noloader@gmail.com>
Cc: stable@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180424212013.3967461-1-arnd@arndb.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/uapi/asm/msgbuf.h |   31 +++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/shmbuf.h |   42 +++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

--- a/arch/x86/include/uapi/asm/msgbuf.h
+++ b/arch/x86/include/uapi/asm/msgbuf.h
@@ -1 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_X64_MSGBUF_H
+#define __ASM_X64_MSGBUF_H
+
+#if !defined(__x86_64__) || !defined(__ILP32__)
 #include <asm-generic/msgbuf.h>
+#else
+/*
+ * The msqid64_ds structure for x86 architecture with x32 ABI.
+ *
+ * On x86-32 and x86-64 we can just use the generic definition, but
+ * x32 uses the same binary layout as x86_64, which is differnet
+ * from other 32-bit architectures.
+ */
+
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	__kernel_time_t msg_stime;	/* last msgsnd time */
+	__kernel_time_t msg_rtime;	/* last msgrcv time */
+	__kernel_time_t msg_ctime;	/* last change time */
+	__kernel_ulong_t msg_cbytes;	/* current number of bytes on queue */
+	__kernel_ulong_t msg_qnum;	/* number of messages in queue */
+	__kernel_ulong_t msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	__kernel_ulong_t __unused4;
+	__kernel_ulong_t __unused5;
+};
+
+#endif
+
+#endif /* __ASM_GENERIC_MSGBUF_H */
--- a/arch/x86/include/uapi/asm/shmbuf.h
+++ b/arch/x86/include/uapi/asm/shmbuf.h
@@ -1 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_X86_SHMBUF_H
+#define __ASM_X86_SHMBUF_H
+
+#if !defined(__x86_64__) || !defined(__ILP32__)
 #include <asm-generic/shmbuf.h>
+#else
+/*
+ * The shmid64_ds structure for x86 architecture with x32 ABI.
+ *
+ * On x86-32 and x86-64 we can just use the generic definition, but
+ * x32 uses the same binary layout as x86_64, which is differnet
+ * from other 32-bit architectures.
+ */
+
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_time_t		shm_atime;	/* last attach time */
+	__kernel_time_t		shm_dtime;	/* last detach time */
+	__kernel_time_t		shm_ctime;	/* last change time */
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	__kernel_ulong_t	shm_nattch;	/* no. of current attaches */
+	__kernel_ulong_t	__unused4;
+	__kernel_ulong_t	__unused5;
+};
+
+struct shminfo64 {
+	__kernel_ulong_t	shmmax;
+	__kernel_ulong_t	shmmin;
+	__kernel_ulong_t	shmmni;
+	__kernel_ulong_t	shmseg;
+	__kernel_ulong_t	shmall;
+	__kernel_ulong_t	__unused1;
+	__kernel_ulong_t	__unused2;
+	__kernel_ulong_t	__unused3;
+	__kernel_ulong_t	__unused4;
+};
+
+#endif
+
+#endif /* __ASM_X86_SHMBUF_H */
