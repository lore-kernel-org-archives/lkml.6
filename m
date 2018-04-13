Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754886AbeDMOC1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:02:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754858AbeDMOCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:02:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08FF21836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 16/17] perf annotate: Allow setting the offset level in .perfconfig
Date: Fri, 13 Apr 2018 11:01:10 -0300
Message-Id: <20180413140111.25313-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413140111.25313-1-acme@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The default is 1 (jump_target):

  # perf annotate --ignore-vmlinux --stdio2 _raw_spin_lock_irqsave
  Samples: 3K of event 'cycles:ppp', 3000 Hz, Event count (approx.): 2766398574
  _raw_spin_lock_irqsave() /proc/kcore
    0.26        nop
    4.61        push   %rbx
   19.33        pushfq
    7.97        pop    %rax
    0.32        nop
    0.06        mov    %rax,%rbx
   14.63        cli
    0.06        nop
                xor    %eax,%eax
                mov    $0x1,%edx
   49.94        lock   cmpxchg %edx,(%rdi)
    0.16        test   %eax,%eax
              ↓ jne    2b
    2.66        mov    %rbx,%rax
                pop    %rbx
              ← retq
          2b:   mov    %eax,%esi
              → callq  *ffffffffb30eaed0
                mov    %rbx,%rax
                pop    %rbx
              ← retq
  #

But one can ask for showing offsets for call instructions by setting
this:

  # perf annotate --ignore-vmlinux --stdio2 _raw_spin_lock_irqsave
  Samples: 3K of event 'cycles:ppp', 3000 Hz, Event count (approx.): 2766398574
  _raw_spin_lock_irqsave() /proc/kcore
    0.26        nop
    4.61        push   %rbx
   19.33        pushfq
    7.97        pop    %rax
    0.32        nop
    0.06        mov    %rax,%rbx
   14.63        cli
    0.06        nop
                xor    %eax,%eax
                mov    $0x1,%edx
   49.94        lock   cmpxchg %edx,(%rdi)
    0.16        test   %eax,%eax
              ↓ jne    2b
    2.66        mov    %rbx,%rax
                pop    %rbx
              ← retq
          2b:   mov    %eax,%esi
          2d: → callq  *ffffffffb30eaed0
                mov    %rbx,%rax
                pop    %rbx
              ← retq
  #

Or using a big value to ask for all offsets to be shown:

  # cat ~/.perfconfig
  [annotate]

	offset_level = 100

	hide_src_code = true
  # perf annotate --ignore-vmlinux --stdio2 _raw_spin_lock_irqsave
  Samples: 3K of event 'cycles:ppp', 3000 Hz, Event count (approx.): 2766398574
  _raw_spin_lock_irqsave() /proc/kcore
    0.26   0:   nop
    4.61   5:   push   %rbx
   19.33   6:   pushfq
    7.97   7:   pop    %rax
    0.32   8:   nop
    0.06   d:   mov    %rax,%rbx
   14.63  10:   cli
    0.06  11:   nop
          17:   xor    %eax,%eax
          19:   mov    $0x1,%edx
   49.94  1e:   lock   cmpxchg %edx,(%rdi)
    0.16  22:   test   %eax,%eax
          24: ↓ jne    2b
    2.66  26:   mov    %rbx,%rax
          29:   pop    %rbx
          2a: ← retq
          2b:   mov    %eax,%esi
          2d: → callq  *ffffffffb30eaed0
          32:   mov    %rbx,%rax
          35:   pop    %rbx
          36: ← retq
   #

This also affects the TUI, i.e. the default 'perf annotate' and 'perf
top/report' -> A hotkey -> annotate interfaces, when slang-devel is present
in the build, i.e.:

  # perf version --build-options | grep slang
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-venm6x5zrt40eu8hxdsmqxz6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt |  5 +++++
 tools/perf/util/annotate.c               | 15 ++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 5b4fff3adc4b..32f4a898e3f2 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -334,6 +334,11 @@ annotate.*::
 
 		99.93 │      mov    %eax,%eax
 
+	annotate.offset_level::
+		Default is '1', meaning just jump targets will have offsets show right beside
+		the instruction. When set to '2' 'call' instructions will also have its offsets
+		shown, 3 or higher will show offsets for all instructions.
+
 hist.*::
 	hist.percentage::
 		This option control the way to calculate overhead of filtered entries -
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5edc565d86c4..536ee148bff8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2649,10 +2649,11 @@ int __annotation__scnprintf_samples_period(struct annotation *notes,
  */
 static struct annotation_config {
 	const char *name;
-	bool *value;
+	void *value;
 } annotation__configs[] = {
 	ANNOTATION__CFG(hide_src_code),
 	ANNOTATION__CFG(jump_arrows),
+	ANNOTATION__CFG(offset_level),
 	ANNOTATION__CFG(show_linenr),
 	ANNOTATION__CFG(show_nr_jumps),
 	ANNOTATION__CFG(show_nr_samples),
@@ -2684,8 +2685,16 @@ static int annotation__config(const char *var, const char *value,
 
 	if (cfg == NULL)
 		pr_debug("%s variable unknown, ignoring...", var);
-	else
-		*cfg->value = perf_config_bool(name, value);
+	else if (strcmp(var, "annotate.offset_level") == 0) {
+		perf_config_int(cfg->value, name, value);
+
+		if (*(int *)cfg->value > ANNOTATION__MAX_OFFSET_LEVEL)
+			*(int *)cfg->value = ANNOTATION__MAX_OFFSET_LEVEL;
+		else if (*(int *)cfg->value < ANNOTATION__MIN_OFFSET_LEVEL)
+			*(int *)cfg->value = ANNOTATION__MIN_OFFSET_LEVEL;
+	} else {
+		*(bool *)cfg->value = perf_config_bool(name, value);
+	}
 	return 0;
 }
 
-- 
2.14.3
