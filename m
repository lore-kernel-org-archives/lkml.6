Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49OexMZXIhF1mhS8MnrTmVfq4ztwoSUgGxltQy0I1LoWMe/y8tRFLtLRCfQa5oBRLQVQu4o
ARC-Seal: i=1; a=rsa-sha256; t=1523473148; cv=none;
        d=google.com; s=arc-20160816;
        b=B5ugUJpNAkLoVpy3smc2FrmVZNF5N/iAl0FIUbXdIxTLJUEjX+snnfTQ5bq6/Ams3o
         u3J+HuL/SDxlkg1XuDn0uLYpj6rJclVEW6QBMqMk/j3czp2R52xX5DsGf1ARAAGseg68
         vHZwfQKKDL9FWcIQWEP4JcIRPC4pwr5YE9yvR8M+OLCU6nVZQKkCn1cj1qnocoHeKYzE
         037ia+Bo+X9J89kGX10Pwaw+VpcdvoX618ckCwrByjxYneqnVNpfPkFOJo4ppm6w+/6D
         kw3w8EIhb2/Li+4K+uf4GXCxg0Ipgs1PTJh2mzWMZFuijNe6Z/b4FFyFeTx87Bq0MkU/
         UIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=97wsgHlIBlTmRd+HmzCCm7Elw0KTBWvDjm5fyFzl9Zw=;
        b=jhFyEr/ExnTA9tzG8NI2VgCJmQ6EkucZZX8QUcj2pHQMqfpUoFNBgYKrnb6yysLPOP
         3+nwWnizjgM7sjAMzVS3LboQqxgsJLGx80dsScJtI6q2Jlk8O0Edpe/UDko3bNK7Wqid
         ui5GC6cEvkK6+evkx4tD56h+KdNcnJ8cv7DYXEL+yscMAQ+rvVIR+itABW2JBTZzq+DH
         kMHwWbCPnGXQ5/nVj4P5zoj+9jahN87LyjFCpznXuFn9H+FSRd2MkNGQExcdOarfBzki
         RxpNuYN9IAnywk2pJuwOtxSembGlO/Lbn0GDxdBuKxNh0jhbYlR3Svd2wi4PD8E9dvi3
         j3+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Milian Wolff <milian.wolff@kdab.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	David Ahern <dsahern@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jiri Olsa <jolsa@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yao Jin <yao.jin@linux.intel.com>,
	kernel-team@lge.com,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 101/310] perf report: Fix off-by-one for non-activation frames
Date: Wed, 11 Apr 2018 20:34:00 +0200
Message-Id: <20180411183626.574856488@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477380526629308?=
X-GMAIL-MSGID: =?utf-8?q?1597477380526629308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Milian Wolff <milian.wolff@kdab.com>


[ Upstream commit 1982ad48fc82c284a5cc55697a012d3357e84d01 ]

As the documentation for dwfl_frame_pc says, frames that
are no activation frames need to have their program counter
decremented by one to properly find the function of the caller.

This fixes many cases where perf report currently attributes
the cost to the next line. I.e. I have code like this:

~~~~~~~~~~~~~~~
  #include <thread>
  #include <chrono>

  using namespace std;

  int main()
  {
    this_thread::sleep_for(chrono::milliseconds(1000));
    this_thread::sleep_for(chrono::milliseconds(100));
    this_thread::sleep_for(chrono::milliseconds(10));

    return 0;
  }
~~~~~~~~~~~~~~~

Now compile and record it:

~~~~~~~~~~~~~~~
  g++ -std=c++11 -g -O2 test.cpp
  echo 1 | sudo tee /proc/sys/kernel/sched_schedstats
  perf record \
    --event sched:sched_stat_sleep \
    --event sched:sched_process_exit \
    --event sched:sched_switch --call-graph=dwarf \
    --output perf.data.raw \
    ./a.out
  echo 0 | sudo tee /proc/sys/kernel/sched_schedstats
  perf inject --sched-stat --input perf.data.raw --output perf.data
~~~~~~~~~~~~~~~

Before this patch, the report clearly shows the off-by-one issue.
Most notably, the last sleep invocation is incorrectly attributed
to the "return 0;" line:

~~~~~~~~~~~~~~~
  Overhead  Source:Line
  ........  ...........

   100.00%  core.c:0
            |
            ---__schedule core.c:0
               schedule
               do_nanosleep hrtimer.c:0
               hrtimer_nanosleep
               sys_nanosleep
               entry_SYSCALL_64_fastpath .tmp_entry_64.o:0
               __nanosleep_nocancel .:0
               std::this_thread::sleep_for<long, std::ratio<1l, 1000l> > thread:323
               |
               |--90.08%--main test.cpp:9
               |          __libc_start_main
               |          _start
               |
               |--9.01%--main test.cpp:10
               |          __libc_start_main
               |          _start
               |
                --0.91%--main test.cpp:13
                          __libc_start_main
                          _start
~~~~~~~~~~~~~~~

With this patch here applied, the issue is fixed. The report becomes
much more usable:

~~~~~~~~~~~~~~~
  Overhead  Source:Line
  ........  ...........

   100.00%  core.c:0
            |
            ---__schedule core.c:0
               schedule
               do_nanosleep hrtimer.c:0
               hrtimer_nanosleep
               sys_nanosleep
               entry_SYSCALL_64_fastpath .tmp_entry_64.o:0
               __nanosleep_nocancel .:0
               std::this_thread::sleep_for<long, std::ratio<1l, 1000l> > thread:323
               |
               |--90.08%--main test.cpp:8
               |          __libc_start_main
               |          _start
               |
               |--9.01%--main test.cpp:9
               |          __libc_start_main
               |          _start
               |
                --0.91%--main test.cpp:10
                          __libc_start_main
                          _start
~~~~~~~~~~~~~~~

Similarly it works for signal frames:

~~~~~~~~~~~~~~~
  __noinline void bar(void)
  {
    volatile long cnt = 0;

    for (cnt = 0; cnt < 100000000; cnt++);
  }

  __noinline void foo(void)
  {
    bar();
  }

  void sig_handler(int sig)
  {
    foo();
  }

  int main(void)
  {
    signal(SIGUSR1, sig_handler);
    raise(SIGUSR1);

    foo();
    return 0;
  }
~~~~~~~~~~~~~~~~

Before, the report wrongly points to `signal.c:29` after raise():

~~~~~~~~~~~~~~~~
  $ perf report --stdio --no-children -g srcline -s srcline
  ...
   100.00%  signal.c:11
            |
            ---bar signal.c:11
               |
               |--50.49%--main signal.c:29
               |          __libc_start_main
               |          _start
               |
                --49.51%--0x33a8f
                          raise .:0
                          main signal.c:29
                          __libc_start_main
                          _start
~~~~~~~~~~~~~~~~

With this patch in, the issue is fixed and we instead get:

~~~~~~~~~~~~~~~~
   100.00%  signal   signal            [.] bar
            |
            ---bar signal.c:11
               |
               |--50.49%--main signal.c:29
               |          __libc_start_main
               |          _start
               |
                --49.51%--0x33a8f
                          raise .:0
                          main signal.c:27
                          __libc_start_main
                          _start
~~~~~~~~~~~~~~~~

Note how this patch fixes this issue for both unwinding methods, i.e.
both dwfl and libunwind. The former case is straight-forward thanks
to dwfl_frame_pc(). For libunwind, we replace the functionality via
unw_is_signal_frame() for any but the very first frame.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yao Jin <yao.jin@linux.intel.com>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20170524062129.32529-4-namhyung@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/unwind-libdw.c           |    6 +++++-
 tools/perf/util/unwind-libunwind-local.c |   11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -167,12 +167,16 @@ frame_callback(Dwfl_Frame *state, void *
 {
 	struct unwind_info *ui = arg;
 	Dwarf_Addr pc;
+	bool isactivation;
 
-	if (!dwfl_frame_pc(state, &pc, NULL)) {
+	if (!dwfl_frame_pc(state, &pc, &isactivation)) {
 		pr_err("%s", dwfl_errmsg(-1));
 		return DWARF_CB_ABORT;
 	}
 
+	if (!isactivation)
+		--pc;
+
 	return entry(pc, ui) || !(--ui->max_stack) ?
 	       DWARF_CB_ABORT : DWARF_CB_OK;
 }
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -646,6 +646,17 @@ static int get_entries(struct unwind_inf
 
 		while (!ret && (unw_step(&c) > 0) && i < max_stack) {
 			unw_get_reg(&c, UNW_REG_IP, &ips[i]);
+
+			/*
+			 * Decrement the IP for any non-activation frames.
+			 * this is required to properly find the srcline
+			 * for caller frames.
+			 * See also the documentation for dwfl_frame_pc(),
+			 * which this code tries to replicate.
+			 */
+			if (unw_is_signal_frame(&c) <= 0)
+				--ips[i];
+
 			++i;
 		}
 
