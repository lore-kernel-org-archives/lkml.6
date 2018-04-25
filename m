Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/mRnT0AnYatSF3SUbMo60fSEjT7vZqSC62JJY/PrnEAQEeNdlM0yqb/NLPtKtUjIX4VZnI
ARC-Seal: i=1; a=rsa-sha256; t=1524653056; cv=none;
        d=google.com; s=arc-20160816;
        b=0nI5NA+BAzunT0Gk2Jp9Ax7uLqmSPvFqxho5T5ceZNlWhYtXC95wZuYjPa76TlOqDW
         8s1lNDkgKWGXd/3VKo93hoEflHPc3pdYrD9JWqkZ7O6kAYEnxclx+LpdFcdYHmaLZEHV
         /wx8L9v4xNBvI8M5eoSk1I2xkEDf2Pc70ovKIbYW1r/cu3QYAtsIk0Y+46O9TdMdCfPW
         XlTnsdhfj7M6esEqZ3fjRjcQLwIVLtsDGXgj9wT8pN/N5t4c37ef7zlcsHKiUjjeBIqq
         LMUChCP7xVR7WFvT5vYsebPmVZumpo17waIpgwj89jNXE4JMyu7xPIoePp3UzqrzWXW5
         HWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=O1L9L08nU3utsZYGkcVlggU81WpPVN3Rjv18EUZDKN8=;
        b=zpnsdxM5mK/BeLSqdmAvI59XtJU81Rl2pBBOrlPNd7YQChqQ5b6hPAvwTB0GeA4M8B
         jJJ4LJpdYuUndsyKangYbrqd+jUbRIiIBLoRU8ITLIL2eoo2xLeJgAiH5cLIFkm+vxZm
         pCuYtWej4yhedz1xpiMPD0/IAkF7jX8FjDUCmFDYVUc8ezwaRGPVCIAYJpKLXWfMX/nA
         xzjQBP82sgImjZwG/K7rNIyQvIt3wpIM5hTloZ/ZpFcvrN01BpHmp4yrPeUfOgRBMISI
         vQy5FgldJp/WxtdbYwPP11Vz5unNHrubZ9TqMiQoHopq4zP6brWdDfBWpUqjJ6h0KSYR
         eWjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 167/183] powerpc/powernv: IMC fix out of bounds memory access at shutdown
Date: Wed, 25 Apr 2018 12:36:27 +0200
Message-Id: <20180425103249.233448123@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714603737884691?=
X-GMAIL-MSGID: =?utf-8?q?1598714603737884691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>


[ Upstream commit e7bde88cdb4f0e432398a7d29ca2a15d2c18952a ]

The OPAL IMC driver's shutdown handler disables nest PMU counters by
walking nodes and taking the first CPU out of their cpumask, which is
used to index into the paca (get_hard_smp_processor_id()). This does
not always do the right thing, and in particular for CPU-less nodes it
returns NR_CPUS and that overruns the paca and dereferences random
memory.

Fix it by being more careful about checking returned CPU, and only
using online CPUs. It's not clear this shutdown code makes sense after
commit 885dcd709b ("powerpc/perf: Add nest IMC PMU support"), but this
should not make things worse

Currently the bug causes us to call OPAL with a junk CPU number. A
separate patch in development to change the way pacas are allocated
escalates this bug into a crash:

  Unable to handle kernel paging request for data at address 0x2a21af1eeb000076
  Faulting instruction address: 0xc0000000000a5468
  Oops: Kernel access of bad area, sig: 11 [#1]
  ...
  NIP opal_imc_counters_shutdown+0x148/0x1d0
  LR  opal_imc_counters_shutdown+0x134/0x1d0
  Call Trace:
   opal_imc_counters_shutdown+0x134/0x1d0 (unreliable)
   platform_drv_shutdown+0x44/0x60
   device_shutdown+0x1f8/0x350
   kernel_restart_prepare+0x54/0x70
   kernel_restart+0x28/0xc0
   SyS_reboot+0x1d0/0x2c0
   system_call+0x58/0x6c

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powernv/opal-imc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -126,9 +126,11 @@ static void disable_nest_pmu_counters(vo
 	const struct cpumask *l_cpumask;
 
 	get_online_cpus();
-	for_each_online_node(nid) {
+	for_each_node_with_cpus(nid) {
 		l_cpumask = cpumask_of_node(nid);
-		cpu = cpumask_first(l_cpumask);
+		cpu = cpumask_first_and(l_cpumask, cpu_online_mask);
+		if (cpu >= nr_cpu_ids)
+			continue;
 		opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST,
 				       get_hard_smp_processor_id(cpu));
 	}
