Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8563C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC89206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC89206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbeKUD7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:59:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbeKUD7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:59:19 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D506920685;
        Tue, 20 Nov 2018 17:29:01 +0000 (UTC)
Date:   Tue, 20 Nov 2018 12:29:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Korty <Joe.Korty@concurrent-rt.com>
Cc:     "julia@ni.com" <julia@ni.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: Re: [ptrace, rt] erratic behaviour in PTRACE_SINGLESET on 4.13-rt
 and later.
Message-ID: <20181120122900.625b1d98@gandalf.local.home>
In-Reply-To: <20181119194619.GA32121@zipoli.concurrent-rt.com>
References: <20181119194619.GA32121@zipoli.concurrent-rt.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Adding Clark and John who manage the rt-tests repo ]

-- Steve

On Mon, 19 Nov 2018 19:46:23 +0000
Joe Korty <Joe.Korty@concurrent-rt.com> wrote:

> Hi Julia & the RT team,
> 
> The following program might make a good addition to the rt
> test suite.  It tests the reliability of PTRACE_SINGLESTEP.
> It does by default 10,000 ssteps against a simple,
> spinner tracee.  Also by default, it spins off ten of these
> tracer/tracee pairs, all of which are to run concurrently.
> 
> Starting with 4.13-rt, this test occasionally encounters a
> sstep whose waitpid returns a WIFSIGNALED (signal SIGTRAP)
> rather than a WIFSTOPPED.  This usually happens after
> thousands of ssteps have executed.  Having multiple
> tracer/tracee pairs running dramatically increases the
> chances of failure.
> 
> The is what the test output looks like for a good run:
> 
>   #forks: 10
>   #steps: 10000
>   
>   forktest#0/22872: STARTING
>   forktest#7/22879: STARTING
>   forktest#8/22880: STARTING
>   forktest#6/22878: STARTING
>   forktest#5/22877: STARTING
>   forktest#3/22875: STARTING
>   forktest#4/22876: STARTING
>   forktest#9/22882: STARTING
>   forktest#2/22874: STARTING
>   forktest#1/22873: STARTING
>   forktest#0/22872: EXITING, no error
>   forktest#8/22880: EXITING, no error
>   forktest#3/22875: EXITING, no error
>   forktest#7/22879: EXITING, no error
>   forktest#6/22878: EXITING, no error
>   forktest#5/22877: EXITING, no error
>   forktest#2/22874: EXITING, no error
>   forktest#4/22876: EXITING, no error
>   forktest#9/22882: EXITING, no error
>   forktest#1/22873: EXITING, no error
>   All tests PASSED.
> 
> This is what the test output looks like for a failing run:
> 
>   #forks: 10
>   #steps: 10000
>   
>   forktest#0/22906: STARTING
>   forktest#1/22907: STARTING
>   forktest#2/22909: STARTING
>   forktest#3/22911: STARTING
>   forktest#4/22912: STARTING
>   forktest#5/22915: STARTING
>   forktest#6/22916: STARTING
>   forktest#7/22919: STARTING
>   forktest#8/22920: STARTING
>   forktest#9/22923: STARTING
>   forktest#2/22909: EXITING, ERROR: wait on PTRACE_SINGLESTEP #9: wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
>   forktest#5/22915: EXITING, no error
>   forktest#3/22911: EXITING, ERROR: wait on PTRACE_SINGLESTEP #7953: wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
>   forktest#0/22906: EXITING, ERROR: wait on PTRACE_SINGLESTEP #5072: wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
>   forktest#9/22923: EXITING, ERROR: wait on PTRACE_SINGLESTEP #7992: wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
>   forktest#4/22912: EXITING, ERROR: wait on PTRACE_SINGLESTEP #9923: wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
>   forktest#1/22907: EXITING, ERROR: wait on PTRACE_SINGLESTEP #7723: wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
>   forktest#7/22919: EXITING, ERROR: wait on PTRACE_SINGLESTEP #5036: wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
>   forktest#8/22920: EXITING, ERROR: wait on PTRACE_SINGLESTEP #4943: wanted STATE_STOPPED, saw STATE_SIGNALED instead (and saw signo 5 too)
>   forktest#6/22916: EXITING, no error
>   One or more tests FAILED.
> 
> Here are the observations from my testing so far:
> 
>   - It has never failed when confined to a single cpu.
>   - It has never failed on !rt kernels.
>   - It has never failed on any kernel prior to 4.13.
>   - More failures than what chance would dictate happen
>     near the end of a test run (ie, if a test of 10,000 
>     steps is run, the failure will be at the 9,xxx'th step,
>     if 100,000 steps are run, the failure will be at
>     the 9x,xxx'th step).
> 
> The above results are from kernels 4.{4,9,11,13,14,19}-rt
> and some !rt's of these as well.
> 
> I have yet to see or hear of this bug, if it is a bug,
> giving anyone a problem in a debug session.  It might not
> even be a bug but merely expected behaviour. And of course
> there is the possibility of a misuse of ptrace/waitpid in
> my test program. Its API, after all, is rather convoluted.
> 
> Regards,
> Joe
> 
> 
> 
> 
> /*
>  * Have a tracer do a bunch of PTRACE_SINGLESTEPs against
>  * a tracee as fast as possible.  Create several of these
>  * tracer/tracee pairs and see if they can be made to
>  * interfere with each other.
>  *
>  * Usage:
>  *   ssdd nforks niters
>  * Where:
>  *   nforks - number of tracer/tracee pairs to fork off.
>  *            default 10.
>  *   niters - number of PTRACE_SINGLESTEP iterations to
>  *            do before declaring success, for each tracer/
>  *            tracee pair set up.  Default 10,000.
>  *
>  * The tracee waits on each PTRACE_SINGLESTEP with a waitpid(2)
>  * and checks that waitpid's return values for correctness.
>  */
> #include <stdio.h>
> #include <stdlib.h>
> #include <stddef.h>
> #include <unistd.h>
> #include <string.h>
> #include <signal.h>
> #include <errno.h>
> 
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <sys/ptrace.h>
> 
> /* do_wait return values */
> #define STATE_EXITED	1
> #define STATE_STOPPED	2
> #define STATE_SIGNALED	3
> #define STATE_UNKNOWN	4
> #define STATE_ECHILD	5
> #define STATE_EXITED_TSIG	6	/* exited with termination signal */
> #define STATE_EXITED_ERRSTAT	7	/* exited with non-zero status */
> 
> char *state_name[] = {
> 	[STATE_EXITED] = "STATE_EXITED",
> 	[STATE_STOPPED] = "STATE_STOPPED",
> 	[STATE_SIGNALED] = "STATE_SIGNALED",
> 	[STATE_UNKNOWN] = "STATE_UNKNOWN",
> 	[STATE_ECHILD] = "STATE_ECHILD",
> 	[STATE_EXITED_TSIG] = "STATE_EXITED_TSIG",
> 	[STATE_EXITED_ERRSTAT] = "STATE_EXITED_ERRSTAT"
> };
> 
> const char *get_state_name(int state)
> {
> 	if (state < STATE_EXITED || state > STATE_EXITED_ERRSTAT)
> 		return "?";
> 	return state_name[state];
> }
> 
> #define unused __attribute__((unused))
> 
> static int got_sigchld;
> 
> static int do_wait(pid_t *wait_pid, int *ret_sig)
> {
> 	int status, child_status;
> 
> 	*ret_sig = -1; /* initially mark 'nothing returned' */
> 
> 	while (1) {
> 		status = waitpid(-1, &child_status, WUNTRACED | __WALL);
> 		if (status == -1) {
> 			if (errno == EINTR)
> 				continue;
> 			if (errno == ECHILD) {
> 				*wait_pid = (pid_t)0;
> 				return STATE_ECHILD;
> 			}
> 			printf("do_wait/%d: EXITING, ERROR: "
> 			       "waitpid() returned errno %d\n",
> 			       getpid(), errno);
> 			exit(1);
> 		}
> 		break;
> 	}
> 	*wait_pid = (pid_t)status;
> 
> 	if (WIFEXITED(child_status)) {
> 		if (WIFSIGNALED(child_status))
> 			return STATE_EXITED_TSIG;
> 		if (WEXITSTATUS(child_status))
> 			return STATE_EXITED_ERRSTAT;
> 		return STATE_EXITED;
> 	}
> 	if (WIFSTOPPED(child_status)) {
> 		*ret_sig = WSTOPSIG(child_status);
> 		return STATE_STOPPED;
> 	}
> 	if (WIFSIGNALED(child_status)) {
> 		*ret_sig = WTERMSIG(child_status);
> 		return STATE_SIGNALED;
> 	}
> 	return STATE_UNKNOWN;
> }
> 
> int check_sigchld(void)
> {
> 	int i;
> 	/*
> 	 * The signal is asynchronous so give it some
> 	 * time to arrive.
> 	 */
> 	for (i = 0; i < 10 && !got_sigchld; i++)
> 		usleep(1000); /* 10 msecs */
> 	for (i = 0; i < 10 && !got_sigchld; i++)
> 		usleep(2000); /* 20 + 10 = 30 msecs */
> 	for (i = 0; i < 10 && !got_sigchld; i++)
> 		usleep(4000); /* 40 + 30 = 70 msecs */
> 	for (i = 0; i < 10 && !got_sigchld; i++)
> 		usleep(8000); /* 80 + 40 = 150 msecs */
> 	for (i = 0; i < 10 && !got_sigchld; i++)
> 		usleep(16000); /* 160 + 150 = 310 msecs */
> 	for (i = 0; i < 10 && !got_sigchld; i++)
> 		usleep(32000); /* 320 + 310 = 630 msecs */
> 
> 	return got_sigchld;
> }
> 
> pid_t parent;
> int nforks = 10;
> int nsteps = 10000;
> 
> static void sigchld(int sig, unused siginfo_t * info, unused void *arg)
> {
> 	got_sigchld = 1;
> }
> 
> static void child_process(void)
> {
> 	unused volatile int i;
> 
> 	/* wait for ptrace attach */
> 	usleep(100000);
> 	while (1)
> 		i = 0;
> }
> 
> static int forktests(int testid)
> {
> 	int i, status, ret_sig;
> 	long pstatus;
> 	pid_t child, wait_pid;
> 	struct sigaction act, oact;
> 
> 	parent = getpid();
> 	printf("forktest#%d/%d: STARTING\n", testid, parent);
> 
> 	child = fork();
> 	if (child == -1) {
> 		printf("forktest#%d/%d: EXITING, ERROR: "
> 		       "fork returned errno %d\n", testid, parent, errno);
> 		exit(1);
> 	}
> 	if (!child)
> 		child_process();
> 
> 	act.sa_sigaction = sigchld;
> 	sigemptyset(&act.sa_mask);
> 	act.sa_flags = SA_SIGINFO;
> 	status = sigaction(SIGCHLD, &act, &oact);
> 	if (status) {
> 		printf("forktest#%d/%d: EXITING, ERROR: "
> 		       "sigaction returned %d, errno %d\n",
> 		       testid, parent, status, errno);
> 		exit(1);
> 	}
> 
> 	/* give both our child and parent time to set things up */
> 	usleep(125000);
> 
> 	/*
> 	 * Attach to the child.
> 	 */
> 	pstatus = ptrace(PTRACE_ATTACH, child, NULL, NULL);
> 	if (pstatus == ~0l) {
> 		printf("forktest#%d/%d: EXITING, ERROR: "
> 		       "attach failed.  errno %d\n",
> 		       testid, getpid(), errno);
> 		exit(1);
> 	}
> 
> 	/*
> 	 * The attach should cause the child to receive a signal.
> 	 */
> 	status = do_wait(&wait_pid, &ret_sig);
> 	if (wait_pid != child) {
> 		printf("forktest#%d/%d: EXITING, ERROR: "
> 		       "attach: Unexpected wait pid %d\n",
> 		       testid, getpid(), wait_pid);
> 		exit(1);
> 	}
> 	if (status != STATE_STOPPED) {
> 		printf("forktest#%d/%d: EXITING, ERROR: "
> 		       "attach: wait on PTRACE_ATTACH returned %d "
> 		       "[%s, wanted STATE_STOPPED], signo %d\n",
> 		       testid, getpid(), status, get_state_name(status),
> 		       ret_sig);
> 		exit(1);
> 	}
> 	else if (!check_sigchld()) {
> 		printf("forktest#%d/%d: EXITING, ERROR: "
> 		       "wait on PTRACE_ATTACH saw a SIGCHLD count of %d, should be 1\n",
> 		       testid, getpid(), got_sigchld);
> 		exit(1);
> 	}
> 	got_sigchld = 0;
> 
> 
> 	/*
> 	 * Generate 'nsteps' PTRACE_SINGLESTEPs, make sure they all actually step
> 	 * the tracee.
> 	 */
> 	for (i = 0; i < nsteps; i++) {
> 		pstatus = ptrace(PTRACE_SINGLESTEP, child, NULL, NULL);
> 
> 		if (pstatus) {
> 			printf("forktest#%d/%d: EXITING, ERROR: "
> 			       "PTRACE_SINGLESTEP #%d: returned status %ld, "
> 			       "errno %d, signo %d\n",
> 			       testid, getpid(), i, pstatus, errno, ret_sig);
> 			exit(1);
> 		}
> 
> 		status = do_wait(&wait_pid, &ret_sig);
> 		if (wait_pid != child) {
> 			printf("forktest#%d/%d: EXITING, ERROR: "
> 			       "wait on PTRACE_SINGLESTEP #%d: returned wrong pid %d, "
> 			       "expected %d\n",
> 			       testid, getpid(), i, wait_pid, child);
> 			exit(1);
> 		}
> 		if (status != STATE_STOPPED) {
> 			printf("forktest#%d/%d: EXITING, ERROR: "
> 			       "wait on PTRACE_SINGLESTEP #%d: wanted STATE_STOPPED, "
> 			       "saw %s instead (and saw signo %d too)\n",
> 			       testid, getpid(), i,
> 			       get_state_name(status), ret_sig);
> 			exit(1);
> 		}
> 		if (ret_sig != SIGTRAP) {
> 			printf("forktest#%d/%d: EXITING, ERROR: "
> 			       "wait on PTRACE_SINGLESTEP #%d: returned signal %d, "
> 			       "wanted SIGTRAP\n",
> 			       testid, getpid(), i, ret_sig);
> 			exit(1);
> 		}
> 		if (!check_sigchld()) {
> 			printf("forktest#%d/%d: EXITING, ERROR: "
> 			       "wait on PTRACE_SINGLESTEP #%d: no SIGCHLD seen "
> 			       "(signal count == 0), signo %d\n",
> 			       testid, getpid(), i, ret_sig);
> 			exit(1);
> 		}
> 		got_sigchld = 0;
> 	}
> 
> 	/*
> 	 * We are all done, kill the tracee and wait for it to die.  We test
> 	 * the killing results as much as the above attach and sstep results,
> 	 * though failure here really isn't the point of this test.
> 	 */
> 	status = kill(child, SIGKILL);
> 
> 	if (status) {
> 		printf("forktest#%d/%d: EXITING, ERROR: "
> 		       "kill of child %d returned %d\n",
> 		       testid, getpid(), child, errno);
> 		exit(1);
> 	}
> 
> 	status = do_wait(&wait_pid, &ret_sig);
> 	if (wait_pid != child) {
> 		printf("forktest#%d/%d: EXITING, ERROR: "
> 		       "kill: Unexpected wait pid %d\n",
> 		       testid, getpid(), wait_pid);
> 		exit(1);
> 	}
> 	if (status != STATE_SIGNALED) {
> 		printf("forktest#%d/%d: EXITING, ERROR: "
> 		       "kill: Unexpected child, do_wait status %d "
> 		       "[%s, wanted STATE_SIGNALED]\n",
> 		       testid, getpid(), status, get_state_name(status));
> 		exit(1);
> 	}
> 	if (ret_sig != SIGKILL) {
> 		printf("forktest#%d/%d: EXITING, ERROR: "
> 		       "kill: Unexpected child signal %d\n",
> 		       testid, getpid(), ret_sig);
> 		exit(1);
> 	}
> 
> 	printf("forktest#%d/%d: EXITING, no error\n", testid, parent);
> 	exit(0);
> }
> 
> int main(int argc, char **argv)
> {
> 	int i, ret_sig, status;
> 	pid_t child = 0, wait_pid;
> 	int error = 0;
> 
> 	setbuf(stdout, NULL);
> 
> 	argc--, argv++;
> 	if (argc) {
> 		nforks = atoi(*argv);
> 		argc--, argv++;
> 		if (argc)
> 			nsteps = atoi(*argv);
> 	}
> 	printf("#forks: %d\n", nforks);
> 	printf("#steps: %d\n", nsteps);
> 	printf("\n");
> 
> 	for (i = 0; i < nforks; i++) {
> 		child = fork();
> 		if (child == -1) {
> 			printf("main: fork returned errno %d\n", errno);
> 			exit(1);
> 		}
> 		if (!child)
> 			forktests(i);
> 	}
> 
> 	for (i = 0; i < nforks; i++) {
> 		status = do_wait(&wait_pid, &ret_sig);
> 		if (status != STATE_EXITED) {
> 			if (0) printf("main/%d: ERROR: "
> 			       "forktest#%d unexpected do_wait status %d "
> 			       "[%s, wanted STATE_EXITED]\n",
> 			       getpid(), wait_pid, status,
> 			       get_state_name(status));
> 			error = 1;
> 		}
> 	}
> 
> 	printf("%s.\n", error ?
> 		"One or more tests FAILED" :
> 		"All tests PASSED");
> 	exit(error);
> }

