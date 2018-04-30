Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpT6aq9HDcLfhzcwwyZkPWtL4yd0NecCvDQlubj2cSr0Ryn1JK6JyWqVrimGsxRIyTt27ab
ARC-Seal: i=1; a=rsa-sha256; t=1525116458; cv=none;
        d=google.com; s=arc-20160816;
        b=Y4TjTlWgzknxIutPNEAYMvJHag3uH+iaHfVS5VNwM+oB/sBC9earuJJqKqA+75UY/n
         cygfArH7pq3ednNmO6/DCkca0A1NyKXE5fsHmwZeVJ9YoWRNLKZhF4kRYrzMo1HHKP9f
         eFVGIOofaYMvyJ/U7smta9U3lKAsebDqVAcv+h7G52pzN1QOMZ6NY431AaRH0edPegbM
         Bwrsnj0wsYObpO4SzZ6rsZy4n+sxdQUJHqk7U23PXY+h19RHi/2mOPLvYn6NFPEHw5px
         5IO1XY5F5MNaI1Yz79YXkuYUqNm5bPD7WObMZftDO4QO0ugjDPulWqdiHdwoCZS1QQkH
         hpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=2EsYEnfJ/jzQxP/h1cIAngSys+WrYaKvvycIXh1nBDI=;
        b=d6GYUc7dEQMxLTAut5oFghshOL+LtwMcatmJSRY4FdP+Ol/HUtp2izqCWQwAtK1sWV
         blMQuie7+0v9CLzPyhB0ysWoWe1RPnOIfKwdpm09gQ9UWfRebfRaR5Vd21c76YzFdLob
         lzw/cX0Dii7xMt26ZjLijBQqcT31xGYK4Z/2gQh/FS5WcXAZBZZO71+6WfEEL23WGKqt
         zpAJ1LFQaCDELvOWPZPNLJCm5ZF6uq7UfeNXgY9Jy7w4FrTZx5UXN2LqANc9mrbXQp93
         0MHVGdSWlEY5VdDi4vOR5lM9G8UxZO/UKMZ+qlRn49DWzInnpwiHg3i/xG4SqXpuiPEc
         jZzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30FE22DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>,
	Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 78/91] cpufreq: powernv: Fix hardlockup due to synchronous smp_call in timer interrupt
Date: Mon, 30 Apr 2018 12:25:00 -0700
Message-Id: <20180430184008.361858596@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200457710271097?=
X-GMAIL-MSGID: =?utf-8?q?1599200515516509234?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

commit c0f7f5b6c69107ca92909512533e70258ee19188 upstream.

gpstate_timer_handler() uses synchronous smp_call to set the pstate
on the requested core. This causes the below hard lockup:

  smp_call_function_single+0x110/0x180 (unreliable)
  smp_call_function_any+0x180/0x250
  gpstate_timer_handler+0x1e8/0x580
  call_timer_fn+0x50/0x1c0
  expire_timers+0x138/0x1f0
  run_timer_softirq+0x1e8/0x270
  __do_softirq+0x158/0x3e4
  irq_exit+0xe8/0x120
  timer_interrupt+0x9c/0xe0
  decrementer_common+0x114/0x120
  -- interrupt: 901 at doorbell_global_ipi+0x34/0x50
  LR = arch_send_call_function_ipi_mask+0x120/0x130
  arch_send_call_function_ipi_mask+0x4c/0x130
  smp_call_function_many+0x340/0x450
  pmdp_invalidate+0x98/0xe0
  change_huge_pmd+0xe0/0x270
  change_protection_range+0xb88/0xe40
  mprotect_fixup+0x140/0x340
  SyS_mprotect+0x1b4/0x350
  system_call+0x58/0x6c

One way to avoid this is removing the smp-call. We can ensure that the
timer always runs on one of the policy-cpus. If the timer gets
migrated to a cpu outside the policy then re-queue it back on the
policy->cpus. This way we can get rid of the smp-call which was being
used to set the pstate on the policy->cpus.

Fixes: 7bc54b652f13 ("timers, cpufreq/powernv: Initialize the gpstate timer as pinned")
Cc: stable@vger.kernel.org # v4.8+
Reported-by: Nicholas Piggin <npiggin@gmail.com>
Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/powernv-cpufreq.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -646,6 +646,16 @@ void gpstate_timer_handler(unsigned long
 
 	if (!spin_trylock(&gpstates->gpstate_lock))
 		return;
+	/*
+	 * If the timer has migrated to the different cpu then bring
+	 * it back to one of the policy->cpus
+	 */
+	if (!cpumask_test_cpu(raw_smp_processor_id(), policy->cpus)) {
+		gpstates->timer.expires = jiffies + msecs_to_jiffies(1);
+		add_timer_on(&gpstates->timer, cpumask_first(policy->cpus));
+		spin_unlock(&gpstates->gpstate_lock);
+		return;
+	}
 
 	/*
 	 * If PMCR was last updated was using fast_swtich then
@@ -685,10 +695,8 @@ void gpstate_timer_handler(unsigned long
 	if (gpstate_idx != gpstates->last_lpstate_idx)
 		queue_gpstate_timer(gpstates);
 
+	set_pstate(&freq_data);
 	spin_unlock(&gpstates->gpstate_lock);
-
-	/* Timer may get migrated to a different cpu on cpu hot unplug */
-	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
 }
 
 /*
