Return-Path: <Matt.Redfearn@mips.com>
X-Google-Smtp-Source: AB8JxZpa75HvEtU9aa9pJ6G24PKrkYKTQVib7lQRjPoLdE4ZdINNREZKI6fuuqTd3bmGoBtRGKcA
ARC-Seal: i=1; a=rsa-sha256; t=1524219829; cv=none;
        d=google.com; s=arc-20160816;
        b=OdxqzjN6yWDFh1SnEmA/PxgZP+MQAywbCGN6L7eTBeu8UKRFZOJ6gkImtjgZEBJ41n
         sP8jTdco2JLsFeXfOz8AhWWJlYx1Fcq4dB67qKGETG5hsX6r26RCwP2qDj/uP/gN422X
         QCO39F1UL6DhRuz4uxdd1/rnV8+9e8O/f/1chuEnJSBvVTK2KAXNkkYo+HvBqvP95Yua
         kZQxZogWKRE6QSl7l7k6/T5js4I6Q0ltT9dITy2aIi9ozC0Fd5cNg710+SwneHZyX7i3
         pO8cLixf3u9Z5YHK6yNM/oZ9Q6tKbjGPNhvISPLDSbDVVTKoDCbwRQ/kB+E5LEtyGtyY
         L7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8RvqzZ4VuSqAiPIoQ3XpIuZkaRxH0csiOx4NTreaW2s=;
        b=ZSq0TgVdwMVf4ZT3TcSEegq1GGlGO/LMCAlv8WEpQ4CAUSBvBf7Exa/3hDFyPRgzVq
         8J4lbhN0qg1gB1s3q4+ptu/Ho5aj+jWyaIGHPEUB2yORCMzXDJBbaYpSxnbNz2yhhczt
         Tzw3BuUuYR0tv3BI43DJBN1Nbsld0RzvJBWWj+SblKNNBvJDWeUoksPPIuFtonQ+4ntW
         A33hcvh+VYuwc+GUHFlaXIwiSHMdtpYNFZGOVIyCEGuoxmd/27ylxc/P8ErwijL7TI8h
         P4gsvvBODQ45WwMP6HjHZGOOyqBhcvcrQVsnO8OP8O1g2vxlW9PPclHEBXimkZteZAtF
         JoOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.150.224 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.150.224 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
	Florian Fainelli <f.fainelli@gmail.com>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>, Peter
 Zijlstra <peterz@infradead.org>, <oprofile-list@lists.sf.net>, Huacai Chen
	<chenhc@lemote.com>, <linux-kernel@vger.kernel.org>, Paul Burton
	<paul.burton@mips.com>, Robert Richter <rric@kernel.org>, Jiri Olsa
	<jolsa@redhat.com>, Kate Stewart <kstewart@linuxfoundation.org>, Ingo Molnar
	<mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Maciej
 W. Rozycki" <macro@mips.com>, Namhyung Kim <namhyung@kernel.org>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>
Subject: [PATCH v3 0/7] MIPS: perf: MT fixes and improvements
Date: Fri, 20 Apr 2018 11:23:02 +0100
Message-ID: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1524219780-298555-31454-28399-1
X-BESS-VER: 2018.5-r1804181636
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192194
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598260332468885189?=
X-GMAIL-MSGID: =?utf-8?q?1598260332468885189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series addresses a few issues with how the MIPS performance
counters code supports the hardware multithreading MT ASE.

Firstly, implementations of the MT ASE may implement performance
counters
per core or per thread(TC). MIPS Techologies implementations signal this
via a bit in the implmentation specific CONFIG7 register. Since this
register is implementation specific, checking it should be guarded by a
PRID check. This also replaces a bit defined by a magic number.

Secondly, the code currently uses vpe_id(), defined as
smp_processor_id(), divided by 2, to share core performance counters
between VPEs. This relies on a couple of assumptions of the hardware
implementation to function correctly (always 2 VPEs per core, and the
hardware reading only the least significant bit).

Finally, the method of sharing core performance counters between VPEs is
suboptimal since it does not allow one process running on a VPE to use
all of the performance counters available to it, because the kernel will
reserve half of the coutners for the other VPE even if it may never use
them. This reservation at counter probe is replaced with an allocation
on use strategy.

Tested on a MIPS Creator CI40 (2C2T MIPS InterAptiv with per-TC
counters, though for the purposes of testing the per-TC availability was
hardcoded to allow testing both paths).

Series applies to v4.16


Changes in v3:
New patch to detect feature presence in cpu-probe.c
Use flag in cpu_data set by cpu_probe.c to indicate feature presence.
- rebase on new feature detection

Changes in v2:
Fix mipsxx_pmu_enable_event for !#ifdef CONFIG_MIPS_MT_SMP
- Fix !#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS build
- re-use cpuc variable in mipsxx_pmu_alloc_counter,
  mipsxx_pmu_free_counter rather than having sibling_ version.
Since BMIPS5000 does not implement per TC counters, we can remove the
check on cpu_has_mipsmt_pertccounters.
New patch to fix BMIPS5000 system mode perf.

Matt Redfearn (7):
  MIPS: Probe for MIPS MT perf counters per TC
  MIPS: perf: More robustly probe for the presence of per-tc counters
  MIPS: perf: Use correct VPE ID when setting up VPE tracing
  MIPS: perf: Fix perf with MT counting other threads
  MIPS: perf: Allocate per-core counters on demand
  MIPS: perf: Fold vpe_id() macro into it's one last usage
  MIPS: perf: Fix BMIPS5000 system mode counting

 arch/mips/include/asm/cpu-features.h |   7 ++
 arch/mips/include/asm/cpu.h          |   2 +
 arch/mips/include/asm/mipsregs.h     |   6 +
 arch/mips/kernel/cpu-probe.c         |  12 ++
 arch/mips/kernel/perf_event_mipsxx.c | 232 +++++++++++++++++++----------------
 arch/mips/oprofile/op_model_mipsxx.c |   2 -
 6 files changed, 150 insertions(+), 111 deletions(-)

-- 
2.7.4
