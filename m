Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67938C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2237F20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4g9KuqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfANRJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:09:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41777 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANRJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:09:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so23746202wrs.8;
        Mon, 14 Jan 2019 09:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:mime-version:content-transfer-encoding;
        bh=fiw728OUHMk0wX3f6zetOgIFTW1FyAS1Ff6l1N1F5KM=;
        b=d4g9KuqAQLKxnIZB0VUXV/ib0ZCwVIffMkC9DI/p13/LQej5b5RVpAzHME1S6sbz4G
         PSAKenZ7Zz1+psSFSMpSwtEFgr8T1ZZyHpHr83GXlK0psrLfYXaREDMLFsro3IWsPAu1
         q0yR7dbJlfuuWuC9hkAHym6IETZJFAr6/jopl0FvJtoCYvIOlKT41bf3faembveMN2Y2
         YAYR69vYhp9VIaHq144+T3vFCdPH9K7A11GnLLOKrLo8O8mLIrRQgfQNIW9iVLtYcTMN
         riaIEqCxC5rys2SMNr2VpH3cYt1Kzly91Zk7xi/VV1W0LObaaFglALf6D7IDYU4CB47r
         oFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:mime-version
         :content-transfer-encoding;
        bh=fiw728OUHMk0wX3f6zetOgIFTW1FyAS1Ff6l1N1F5KM=;
        b=thTj7QZu0v+mj30vLOtspzdJ6Dvo58rJ/kPUeUsLFWN1aiO13H8FFmgsFB4nmR8B8W
         +5nnHZ3qdtYYR4ThD+jLBTtVEF6U/6tATlMJYhbq/gJppgf6pFx0nS+xKjOkGItmiugR
         w7MuAA5S8AVloh7GExXww5sg0hxa4jgZMYDi8/V00uxfh5sa7hVMyEP90r6IuxT0w3B+
         7CWedwAIMR37j+MzyGwZoFyoXAoikm4jCF3zFCazn1iUXUfldC2kv30udXPeKjpFPdYF
         GDDjzqpYkjUdZBfJB8r7uP97z1aIjanZZXUhPtB2fZS+R/dA5zVUGuvcsONKHicZv/zz
         AW9Q==
X-Gm-Message-State: AJcUukcXiL+bLd0PFVKvdbLhuioLKlkb9W5b3Zcwe0y3QMnywKXvHPxO
        SBFl9d5zuRltqvh3w6eIoAw=
X-Google-Smtp-Source: ALg8bN7Y4bb/fQB9hJeqjrsQ9f6Pjj86C4dx+p6SvrUcqFK45Pz7YsRKcaOVUEYC1XntkCKWQ+8R8w==
X-Received: by 2002:adf:de91:: with SMTP id w17mr26808957wrl.320.1547485762666;
        Mon, 14 Jan 2019 09:09:22 -0800 (PST)
Received: from planxty.redhat.com ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id q9sm103717562wrp.0.2019.01.14.09.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 09:09:22 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     Joe Korty <Joe.Korty@concurrent-rt.com>
Cc:     Clark Williams <williams@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "julia @ ni . com" <julia@ni.com>,
        "tglx @ linutronix . de" <tglx@linutronix.de>,
        "oleg @ redhat . com" <oleg@redhat.com>,
        "linux-rt-users @ vger . kernel . org" 
        <linux-rt-users@vger.kernel.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        Joe Korty <joe.korty@concurrent-rt.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] Add ssdd test to the rt-tests suite
Date:   Mon, 14 Jan 2019 18:09:08 +0100
Message-Id: <20190114170908.5287-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114170908.5287-1-jkacur@redhat.com>
References: <20190114170908.5287-1-jkacur@redhat.com>
Reply-To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Korty <joe.korty@concurrent-rt.com>

The following program might make a good addition to the rt
test suite.  It tests the reliability of PTRACE_SINGLESTEP.
It does by default 10,000 ssteps against a simple,
spinner tracee.  Also by default, it spins off ten of these
tracer/tracee pairs, all of which are to run concurrently.

Starting with 4.13-rt, this test occasionally encounters a
sstep whose waitpid returns a WIFSIGNALED (signal SIGTRAP)
rather than a WIFSTOPPED.  This usually happens after
thousands of ssteps have executed.  Having multiple
tracer/tracee pairs running dramatically increases the
chances of failure.

The is what the test output looks like for a good run:

forktest#0/22872: STARTING
forktest#7/22879: STARTING
forktest#8/22880: STARTING
forktest#6/22878: STARTING
forktest#5/22877: STARTING
forktest#3/22875: STARTING
forktest#4/22876: STARTING
forktest#9/22882: STARTING
forktest#2/22874: STARTING
forktest#1/22873: STARTING
forktest#0/22872: EXITING, no error
forktest#8/22880: EXITING, no error
forktest#3/22875: EXITING, no error
forktest#7/22879: EXITING, no error
forktest#6/22878: EXITING, no error
forktest#5/22877: EXITING, no error
forktest#2/22874: EXITING, no error
forktest#4/22876: EXITING, no error
forktest#9/22882: EXITING, no error
forktest#1/22873: EXITING, no error
All tests PASSED.

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/ssdd/ssdd.c | 315 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 315 insertions(+)
 create mode 100644 src/ssdd/ssdd.c

diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
new file mode 100644
index 000000000000..6d09d54e34e1
--- /dev/null
+++ b/src/ssdd/ssdd.c
@@ -0,0 +1,315 @@
+/*
+ * Have a tracer do a bunch of PTRACE_SINGLESTEPs against
+ * a tracee as fast as possible.  Create several of these
+ * tracer/tracee pairs and see if they can be made to
+ * interfere with each other.
+ *
+ * Usage:
+ *   ssdd nforks niters
+ * Where:
+ *   nforks - number of tracer/tracee pairs to fork off.
+ *            default 10.
+ *   niters - number of PTRACE_SINGLESTEP iterations to
+ *            do before declaring success, for each tracer/
+ *            tracee pair set up.  Default 10,000.
+ *
+ * The tracer waits on each PTRACE_SINGLESTEP with a waitpid(2)
+ * and checks that waitpid's return values for correctness.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <stddef.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <errno.h>
+
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/ptrace.h>
+
+/* do_wait return values */
+#define STATE_EXITED	1
+#define STATE_STOPPED	2
+#define STATE_SIGNALED	3
+#define STATE_UNKNOWN	4
+#define STATE_ECHILD	5
+#define STATE_EXITED_TSIG	6	/* exited with termination signal */
+#define STATE_EXITED_ERRSTAT	7	/* exited with non-zero status */
+
+char *state_name[] = {
+	[STATE_EXITED] = "STATE_EXITED",
+	[STATE_STOPPED] = "STATE_STOPPED",
+	[STATE_SIGNALED] = "STATE_SIGNALED",
+	[STATE_UNKNOWN] = "STATE_UNKNOWN",
+	[STATE_ECHILD] = "STATE_ECHILD",
+	[STATE_EXITED_TSIG] = "STATE_EXITED_TSIG",
+	[STATE_EXITED_ERRSTAT] = "STATE_EXITED_ERRSTAT"
+};
+
+const char *get_state_name(int state)
+{
+	if (state < STATE_EXITED || state > STATE_EXITED_ERRSTAT)
+		return "?";
+	return state_name[state];
+}
+
+#define unused __attribute__((unused))
+
+static int got_sigchld;
+
+static int do_wait(pid_t *wait_pid, int *ret_sig)
+{
+	int status, child_status;
+
+	*ret_sig = -1; /* initially mark 'nothing returned' */
+
+	while (1) {
+		status = waitpid(-1, &child_status, WUNTRACED | __WALL);
+		if (status == -1) {
+			if (errno == EINTR)
+				continue;
+			if (errno == ECHILD) {
+				*wait_pid = (pid_t)0;
+				return STATE_ECHILD;
+			}
+			printf("do_wait/%d: EXITING, ERROR: "
+			       "waitpid() returned errno %d\n",
+			       getpid(), errno);
+			exit(1);
+		}
+		break;
+	}
+	*wait_pid = (pid_t)status;
+
+	if (WIFEXITED(child_status)) {
+		if (WIFSIGNALED(child_status))
+			return STATE_EXITED_TSIG;
+		if (WEXITSTATUS(child_status))
+			return STATE_EXITED_ERRSTAT;
+		return STATE_EXITED;
+	}
+	if (WIFSTOPPED(child_status)) {
+		*ret_sig = WSTOPSIG(child_status);
+		return STATE_STOPPED;
+	}
+	if (WIFSIGNALED(child_status)) {
+		*ret_sig = WTERMSIG(child_status);
+		return STATE_SIGNALED;
+	}
+	return STATE_UNKNOWN;
+}
+
+int check_sigchld(void)
+{
+	int i;
+	/*
+	 * The signal is asynchronous so give it some
+	 * time to arrive.
+	 */
+	for (i = 0; i < 10 && !got_sigchld; i++)
+		usleep(1000); /* 10 msecs */
+	for (i = 0; i < 10 && !got_sigchld; i++)
+		usleep(2000); /* 20 + 10 = 30 msecs */
+	for (i = 0; i < 10 && !got_sigchld; i++)
+		usleep(4000); /* 40 + 30 = 70 msecs */
+	for (i = 0; i < 10 && !got_sigchld; i++)
+		usleep(8000); /* 80 + 70 = 150 msecs */
+	for (i = 0; i < 10 && !got_sigchld; i++)
+		usleep(16000); /* 160 + 150 = 310 msecs */
+
+	return got_sigchld;
+}
+
+pid_t parent;
+int nforks = 10;
+int nsteps = 10000;
+
+static void sigchld(int sig, unused siginfo_t * info, unused void *arg)
+{
+	got_sigchld = 1;
+}
+
+static void child_process(void)
+{
+	unused volatile int i;
+
+	/* wait for ptrace attach */
+	usleep(100000);
+	while (1)
+		i = 0;
+}
+
+static int forktests(int testid)
+{
+	int i, status, ret_sig;
+	long pstatus;
+	pid_t child, wait_pid;
+	struct sigaction act, oact;
+
+	parent = getpid();
+	printf("forktest#%d/%d: STARTING\n", testid, parent);
+
+	child = fork();
+	if (child == -1) {
+		printf("forktest#%d/%d: EXITING, ERROR: "
+		       "fork returned errno %d\n", testid, parent, errno);
+		exit(1);
+	}
+	if (!child)
+		child_process();
+
+	act.sa_sigaction = sigchld;
+	sigemptyset(&act.sa_mask);
+	act.sa_flags = SA_SIGINFO;
+	status = sigaction(SIGCHLD, &act, &oact);
+	if (status) {
+		printf("forktest#%d/%d: EXITING, ERROR: "
+		       "sigaction returned %d, errno %d\n",
+		       testid, parent, status, errno);
+		exit(1);
+	}
+
+	/* give both our child and parent time to set things up */
+	usleep(125000);
+
+	/*
+	 * Attach to the child.
+	 */
+	pstatus = ptrace(PTRACE_ATTACH, child, NULL, NULL);
+	if (pstatus == ~0l) {
+		printf("forktest#%d/%d: EXITING, ERROR: "
+		       "attach failed.  errno %d\n",
+		       testid, getpid(), errno);
+		exit(1);
+	}
+
+	/*
+	 * The attach should cause the child to receive a signal.
+	 */
+	status = do_wait(&wait_pid, &ret_sig);
+	if (wait_pid != child) {
+		printf("forktest#%d/%d: EXITING, ERROR: "
+		       "attach: Unexpected wait pid %d\n",
+		       testid, getpid(), wait_pid);
+		exit(1);
+	}
+	if (status != STATE_STOPPED) {
+		printf("forktest#%d/%d: EXITING, ERROR: "
+		       "attach: wait on PTRACE_ATTACH returned %d "
+		       "[%s, wanted STATE_STOPPED], signo %d\n",
+		       testid, getpid(), status, get_state_name(status),
+		       ret_sig);
+		exit(1);
+	}
+	else if (!check_sigchld()) {
+		printf("forktest#%d/%d: EXITING, ERROR: "
+		       "wait on PTRACE_ATTACH saw a SIGCHLD count of %d, should be 1\n",
+		       testid, getpid(), got_sigchld);
+		exit(1);
+	}
+	got_sigchld = 0;
+
+
+	/*
+	 * Generate 'nsteps' PTRACE_SINGLESTEPs, make sure they all actually
+	 * step the tracee.
+	 */
+	for (i = 0; i < nsteps; i++) {
+		pstatus = ptrace(PTRACE_SINGLESTEP, child, NULL, NULL);
+
+		if (pstatus) {
+			printf("forktest#%d/%d: EXITING, ERROR: "
+			       "PTRACE_SINGLESTEP #%d: returned status %ld, "
+			       "errno %d, signo %d\n",
+			       testid, getpid(), i, pstatus, errno, ret_sig);
+			exit(1);
+		}
+
+		status = do_wait(&wait_pid, &ret_sig);
+		if (wait_pid != child) {
+			printf("forktest#%d/%d: EXITING, ERROR: "
+			       "wait on PTRACE_SINGLESTEP #%d: returned wrong pid %d, "
+			       "expected %d\n",
+			       testid, getpid(), i, wait_pid, child);
+			exit(1);
+		}
+		if (status != STATE_STOPPED) {
+			printf("forktest#%d/%d: EXITING, ERROR: "
+			       "wait on PTRACE_SINGLESTEP #%d: wanted STATE_STOPPED, "
+			       "saw %s instead (and saw signo %d too)\n",
+			       testid, getpid(), i,
+			       get_state_name(status), ret_sig);
+			exit(1);
+		}
+		if (ret_sig != SIGTRAP) {
+			printf("forktest#%d/%d: EXITING, ERROR: "
+			       "wait on PTRACE_SINGLESTEP #%d: returned signal %d, "
+			       "wanted SIGTRAP\n",
+			       testid, getpid(), i, ret_sig);
+			exit(1);
+		}
+		if (!check_sigchld()) {
+			printf("forktest#%d/%d: EXITING, ERROR: "
+			       "wait on PTRACE_SINGLESTEP #%d: no SIGCHLD seen "
+			       "(signal count == 0), signo %d\n",
+			       testid, getpid(), i, ret_sig);
+			exit(1);
+		}
+		got_sigchld = 0;
+	}
+
+	/* There is no need for the tracer to kill the tracee. It will
+	 * automatically exit when its owner, ie, us, exits.
+	 */
+
+	printf("forktest#%d/%d: EXITING, no error\n", testid, parent);
+	exit(0);
+}
+
+int main(int argc, char **argv)
+{
+	int i, ret_sig, status;
+	pid_t child = 0, wait_pid;
+	int error = 0;
+
+	setbuf(stdout, NULL);
+
+	argc--, argv++;
+	if (argc) {
+		nforks = atoi(*argv);
+		argc--, argv++;
+		if (argc)
+			nsteps = atoi(*argv);
+	}
+	printf("#forks: %d\n", nforks);
+	printf("#steps: %d\n", nsteps);
+	printf("\n");
+
+	for (i = 0; i < nforks; i++) {
+		child = fork();
+		if (child == -1) {
+			printf("main: fork returned errno %d\n", errno);
+			exit(1);
+		}
+		if (!child)
+			forktests(i);
+	}
+
+	for (i = 0; i < nforks; i++) {
+		status = do_wait(&wait_pid, &ret_sig);
+		if (status != STATE_EXITED) {
+			if (0) printf("main/%d: ERROR: "
+			       "forktest#%d unexpected do_wait status %d "
+			       "[%s, wanted STATE_EXITED]\n",
+			       getpid(), wait_pid, status,
+			       get_state_name(status));
+			error = 1;
+		}
+	}
+
+	printf("%s.\n", error ?
+		"One or more tests FAILED" :
+		"All tests PASSED");
+	exit(error);
+}
-- 
2.20.1

