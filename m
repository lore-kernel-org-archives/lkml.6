Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx49xCGCJ/vefTfvST2oMOaGA4FbhEF3xKTHCZUZ/69qNIuGWYNrQAXCq+WORLmeH/HL6dj8N
ARC-Seal: i=1; a=rsa-sha256; t=1522924310; cv=none;
        d=google.com; s=arc-20160816;
        b=p3p7389u69gRJyK6qd78JjyM17DROyR3cOmNJwqezhyGeU69dX5peEDf1gGEVPy5iu
         hB6xN5GiX8VYqFkHhW0yJXWXKGuLAQe1LpH2LbxYLS4ZZttfUSFRHY9Nsf6ojcHQe0Uo
         JULhDIVaJM2H8e05i1W5EjprNATYgcPCCz1TPf/jcTFAfGJaoti44VruVOJiNZLy67FC
         3ZSDTFL/hnjp4LQe8vY93Rr/U7VCd9iEB6epdzSwnUmXEy722dCCPIzrWB2EoS6AVt4Q
         MtJEGKnVwrt+pncrb7cki0/hZ7PXRgULmCxyohcZhZhPJKSpXPIF2DTWvEfdcBVHOiCe
         tQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:from:references:to:subject
         :arc-authentication-results;
        bh=VBZgm9Cfd/Jxy4wJ6aJz6fRZiNI/gTYK7NcdSqisIdc=;
        b=czdQb0zj1vVPkAYJSi3+CPkpdAvYvGuk2/jXxjiUh0Ny8fnYHuCdcK8BGrqpJRiNbR
         HwO9nHusbbhxLW71wCTaaK318Fy/CaExPZrieVDgyT2S0OtingrNOhKFNYlGZnuyHwyV
         XAroxo1b3b1OrgniNW03n1w1HNnBpxdH2dhFL13VVp01+0tBfK21+tUWWLKnnnKko2xn
         jAfqwr2chLpDly+jAru5NtabeWyVxrwgAIDEd76d5a4cOdhzwCY8qGOabnqWQjqywswT
         XQAc/KghPNUUMcmOtyGMk4duTr74Og9tJpoH8LzuSIgFhmCWjAKzzl0/9TRzxnP+gR+0
         WCOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: KASAN: user-memory-access Write in n_tty_set_termios
To: gregkh@linuxfoundation.org, jslaby@suse.com
References: <001a113ed31a122ced0568cc6be1@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Message-ID: <db45a090-593d-23d2-e6b2-ede5b308f02f@I-love.SAKURA.ne.jp>
Date: Thu, 5 Apr 2018 19:31:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <001a113ed31a122ced0568cc6be1@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596563981043488445?=
X-GMAIL-MSGID: =?utf-8?q?1596901881682269226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello.

I manually simplified the reproducer. Since the bug is timing dependent,
this reproducer might fail to reproducer the bug. Anyway, I guess that
there is a race condition between

	vfree(ldata);
	tty->disc_data = NULL;

at n_tty_close() by something (ioctl(TIOCVHANGUP) ?) and

	struct n_tty_data *ldata = tty->disc_data;

	if (!old || (old->c_lflag ^ tty->termios.c_lflag) & (ICANON | EXTPROC)) {
		bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);

at n_tty_set_termios() by ioctl(TCSETS), for the report says that ldata == NULL
("Write of size 512 at addr 0000000000001060").

----------------------------------------
#include <fcntl.h>
#include <linux/futex.h>
#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <termios.h>
#define TIOCGPTPEER     _IO('T', 0x41) 

static const int zero = 0;
static int master_fd = EOF;
static int slave_fd = EOF;
static void execute_call(int call)
{
	struct termios term;
	char buf[128];
	int ptyno = 0;
	switch (call) {
	case 0:
		master_fd = open("/dev/ptmx", O_RDONLY);
		ioctl(master_fd, TIOCSPTLCK, &zero);
		if (ioctl(master_fd, TIOCGPTN, &ptyno))
			break;
		sprintf(buf, "/dev/pts/%d", ptyno);
		slave_fd = open(buf, O_RDONLY, 0);
		usleep(5 * 1000);
		ioctl(slave_fd, TIOCVHANGUP, 0);
		break;
	case 5:
		memset(&term, 0, sizeof(term));
		ioctl(master_fd, TCSETS, &term);
		break;
	case 6:
		ioctl(master_fd, TIOCGPTPEER, 0);
		break;
	}
}

struct thread_t {
	int created, running, call;
	pthread_t th;
};

static struct thread_t threads[16];
static int running;
static int collide;

static void* thr(void* arg)
{
	struct thread_t* th = (struct thread_t*)arg;
	for (;;) {
		while (!__atomic_load_n(&th->running, __ATOMIC_ACQUIRE))
			syscall(SYS_futex, &th->running, FUTEX_WAIT, 0, 0);
		execute_call(th->call);
		__atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
		__atomic_store_n(&th->running, 0, __ATOMIC_RELEASE);
		syscall(SYS_futex, &th->running, FUTEX_WAKE);
	}
	return 0;
}

static void execute(int num_calls)
{
	int call, thread;
	running = 0;
	for (call = 0; call < num_calls; call++) {
		for (thread = 0; thread < sizeof(threads) / sizeof(threads[0]); thread++) {
			struct thread_t* th = &threads[thread];
			if (!th->created) {
				th->created = 1;
				pthread_attr_t attr;
				pthread_attr_init(&attr);
				pthread_attr_setstacksize(&attr, 128 << 10);
				pthread_create(&th->th, &attr, thr, th);
			}
			if (!__atomic_load_n(&th->running, __ATOMIC_ACQUIRE)) {
				th->call = call;
				__atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
				__atomic_store_n(&th->running, 1, __ATOMIC_RELEASE);
				syscall(SYS_futex, &th->running, FUTEX_WAKE);
				if (collide && call % 2)
					break;
				struct timespec ts;
				ts.tv_sec = 0;
				ts.tv_nsec = 20 * 1000 * 1000;
				syscall(SYS_futex, &th->running, FUTEX_WAIT, 1, &ts);
				if (running)
					usleep((call == num_calls - 1) ? 10000 : 1000);
				break;
			}
		}
	}
}

int main(int argc, char *argv[])
{
	while (1) {
		execute(7);
		collide = 1;
		execute(7);
	}
	return 0;
}
----------------------------------------
