Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs1vjohs7ad9oeRlNmebd6iNR2ywoa+Td5MPI4xGQHd+H57tAarzCAgd3sL1p0olX33A+/u
ARC-Seal: i=1; a=rsa-sha256; t=1521800298; cv=none;
        d=google.com; s=arc-20160816;
        b=vKP6nXFXFDc6krXPOArLHJVmlR4qe/F8hQjJIDAgOoeMxbFWJAlHlvmuZB3HyLteYt
         z9ss4Rd1fvB/2qGnMuWWAhGGdeEd686ah7UjmCZFRBm5/lDZkJS3lL7kUuqipWSPt7HQ
         /2UsWL+0Vxol2tbBEhYFn190DYLLPnwKzFuJ5WDwjZ50Cm7ARohuf9V5lmzxEAzkgvm+
         MeBqY4akoOKalgrJbvvVDPogDjjcNXoOZlQyAoXnOr5/1Z3O8aDV6qf0TXRQqWgFPkMe
         adAr3Jt2Bbep4Laev0/BWTrkKI73c73l0/1378H0qZw8i83M12uELpEza6zmkCI9I3BH
         H0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WFdn2ljVVIt+c8nl4sE+Fw6WRa7AtfBCZmFSCHPjMAU=;
        b=k4cH4r44XDZuyqdn6K3wPYsOdirwjAzCrBp6f29sIvHchEMJfgI9DdM/B9Fj/Qn3yC
         nJ+9gco8wvU6V3LKPN7vhlRsxO9YPFtAduYKrS7Yn396dxDy5+TgB+KAsDPyAuzJNh9/
         m+9YjqZ/nSxHP/HQomss47wMLJMm9QWTlIaWGtQH+2MSpaFltsWLxEtNznBrCsxHCe0Q
         Pfw7+2BcqmWmxXFjsNxAfvm1lgDXJhTyxUbMnOwOsc7izXWiEGhxrXjZlnTg4tZvzf04
         2N8ttI01iEjbRFVwq1fsqPeDALHbswm3Q7NW+L+v0cwbiIGYkbPPtS1Bn7N2rVqo+Q8W
         IGJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	linux-pm@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Tejun Heo <tj@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Len Brown <lenb@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 05/47] cpufreq/sh: Replace racy task affinity logic
Date: Fri, 23 Mar 2018 10:54:56 +0100
Message-Id: <20180323094248.347689835@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722445513393814?=
X-GMAIL-MSGID: =?utf-8?q?1595723269971198382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>


[ Upstream commit 205dcc1ecbc566cbc20acf246e68de3b080b3ecf ]

The target() callback must run on the affected cpu. This is achieved by
temporarily setting the affinity of the calling thread to the requested CPU
and reset it to the original affinity afterwards.

That's racy vs. concurrent affinity settings for that thread resulting in
code executing on the wrong CPU.

Replace it by work_on_cpu(). All call pathes which invoke the callbacks are
already protected against CPU hotplug.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: linux-pm@vger.kernel.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Len Brown <lenb@kernel.org>
Link: http://lkml.kernel.org/r/20170412201042.958216363@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/sh-cpufreq.c |   45 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -30,54 +30,63 @@
 
 static DEFINE_PER_CPU(struct clk, sh_cpuclk);
 
+struct cpufreq_target {
+	struct cpufreq_policy	*policy;
+	unsigned int		freq;
+};
+
 static unsigned int sh_cpufreq_get(unsigned int cpu)
 {
 	return (clk_get_rate(&per_cpu(sh_cpuclk, cpu)) + 500) / 1000;
 }
 
-/*
- * Here we notify other drivers of the proposed change and the final change.
- */
-static int sh_cpufreq_target(struct cpufreq_policy *policy,
-			     unsigned int target_freq,
-			     unsigned int relation)
+static long __sh_cpufreq_target(void *arg)
 {
-	unsigned int cpu = policy->cpu;
+	struct cpufreq_target *target = arg;
+	struct cpufreq_policy *policy = target->policy;
+	int cpu = policy->cpu;
 	struct clk *cpuclk = &per_cpu(sh_cpuclk, cpu);
-	cpumask_t cpus_allowed;
 	struct cpufreq_freqs freqs;
 	struct device *dev;
 	long freq;
 
-	cpus_allowed = current->cpus_allowed;
-	set_cpus_allowed_ptr(current, cpumask_of(cpu));
-
-	BUG_ON(smp_processor_id() != cpu);
+	if (smp_processor_id() != cpu)
+		return -ENODEV;
 
 	dev = get_cpu_device(cpu);
 
 	/* Convert target_freq from kHz to Hz */
-	freq = clk_round_rate(cpuclk, target_freq * 1000);
+	freq = clk_round_rate(cpuclk, target->freq * 1000);
 
 	if (freq < (policy->min * 1000) || freq > (policy->max * 1000))
 		return -EINVAL;
 
-	dev_dbg(dev, "requested frequency %u Hz\n", target_freq * 1000);
+	dev_dbg(dev, "requested frequency %u Hz\n", target->freq * 1000);
 
 	freqs.old	= sh_cpufreq_get(cpu);
 	freqs.new	= (freq + 500) / 1000;
 	freqs.flags	= 0;
 
-	cpufreq_freq_transition_begin(policy, &freqs);
-	set_cpus_allowed_ptr(current, &cpus_allowed);
+	cpufreq_freq_transition_begin(target->policy, &freqs);
 	clk_set_rate(cpuclk, freq);
-	cpufreq_freq_transition_end(policy, &freqs, 0);
+	cpufreq_freq_transition_end(target->policy, &freqs, 0);
 
 	dev_dbg(dev, "set frequency %lu Hz\n", freq);
-
 	return 0;
 }
 
+/*
+ * Here we notify other drivers of the proposed change and the final change.
+ */
+static int sh_cpufreq_target(struct cpufreq_policy *policy,
+			     unsigned int target_freq,
+			     unsigned int relation)
+{
+	struct cpufreq_target data = { .policy = policy, .freq = target_freq };
+
+	return work_on_cpu(policy->cpu, __sh_cpufreq_target, &data);
+}
+
 static int sh_cpufreq_verify(struct cpufreq_policy *policy)
 {
 	struct clk *cpuclk = &per_cpu(sh_cpuclk, policy->cpu);
