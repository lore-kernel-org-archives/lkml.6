Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZruzHL+WoNB+tBHPjm8UUgWzBCE24niwm0JUpzIGAEmL95cbedFkL7gONSuZn0vy8oP7PyJ
ARC-Seal: i=1; a=rsa-sha256; t=1527155091; cv=none;
        d=google.com; s=arc-20160816;
        b=k16iebLWi+Gk0HUK4yOIawErMbMspwBc27uAOK3vCBll2/aEx9qcMzk35WAkNGdAE/
         TJXzzu+xfx99sD+JaO5cek4j8naLcLPqU3X7LchJp6vc/HBNkNr+3q+taHS/K45vSe+l
         PKPE7cd42s8YAwMVzY1aL71YSrBNDeSMtXFnqRt1X5tU5Tae7Bzgygyvw2z4ZlfR9sAX
         itpfx1AWmWK6ebown3W/S+2cKrj48efB8K7U/R55DijvnWApWaQKuDAuHZhjiSFIp1HS
         vmVdq8E3AftcNe2OqPk74D2eQSxuyk9u3Xbut8yqFhILSlPqcH2IaD+JtCS+lJDIu1IP
         VDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=QX5PnBgPGd0k20vFNtlp6IO/ei1+W0v1bZYUfDSro40=;
        b=yfuZD5oMAkLX7iVzAtrF5m609EyLw0lklpC5wVr4zlxIf/CCYouTs40hR+PqfbJXtC
         zmniNFPtMx1OXy8W/azWV4Y6JfiqXgCAStjtNZhNiPgg1T0Xe92U/Dodk/YzDp0YGG9l
         Cdo8azYMq6EVhmJ8w4JuB2rv+PhCzNiWcJxou2TZ3z58Dnrjr2yPNTrhgOOCPJEV+ASy
         7IS19j3vbIV2o0v+dKi6Oglzb5y95OTSYNIaWinlohAI/jFs1HPN7CKKk6C4Yi6D2cEY
         /MVgXnb5cC4PcyX3dMVrYlo/qg20kHBaz9ttbDl87XwNQtjdnjw/4NQlfIqlqKn5/S8W
         z8Ag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=B8VGGCb+;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=B8VGGCb+;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Thomas Renninger <trenn@suse.de>
Subject: [PATCH 4.4 52/92] cpufreq: intel_pstate: Enable HWP by default
Date: Thu, 24 May 2018 11:38:29 +0200
Message-Id: <20180524093204.382965198@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338177618929689?=
X-GMAIL-MSGID: =?utf-8?q?1601338177618929689?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit 7791e4aa59ad724e0b4c8b4dea547a5735108972 upstream.

If the processor supports HWP, enable it by default without checking
for the cpu model. This will allow to enable HWP in all supported
processors without driver change.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/intel_pstate.c |   34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1361,6 +1361,11 @@ static inline bool intel_pstate_platform
 static inline bool intel_pstate_has_acpi_ppc(void) { return false; }
 #endif /* CONFIG_ACPI */
 
+static const struct x86_cpu_id hwp_support_ids[] __initconst = {
+	{ X86_VENDOR_INTEL, 6, X86_MODEL_ANY, X86_FEATURE_HWP },
+	{}
+};
+
 static int __init intel_pstate_init(void)
 {
 	int cpu, rc = 0;
@@ -1370,17 +1375,16 @@ static int __init intel_pstate_init(void
 	if (no_load)
 		return -ENODEV;
 
+	if (x86_match_cpu(hwp_support_ids) && !no_hwp) {
+		copy_cpu_funcs(&core_params.funcs);
+		hwp_active++;
+		goto hwp_cpu_matched;
+	}
+
 	id = x86_match_cpu(intel_pstate_cpu_ids);
 	if (!id)
 		return -ENODEV;
 
-	/*
-	 * The Intel pstate driver will be ignored if the platform
-	 * firmware has its own power management modes.
-	 */
-	if (intel_pstate_platform_pwr_mgmt_exists())
-		return -ENODEV;
-
 	cpu_def = (struct cpu_defaults *)id->driver_data;
 
 	copy_pid_params(&cpu_def->pid_policy);
@@ -1389,17 +1393,20 @@ static int __init intel_pstate_init(void
 	if (intel_pstate_msrs_not_valid())
 		return -ENODEV;
 
+hwp_cpu_matched:
+	/*
+	 * The Intel pstate driver will be ignored if the platform
+	 * firmware has its own power management modes.
+	 */
+	if (intel_pstate_platform_pwr_mgmt_exists())
+		return -ENODEV;
+
 	pr_info("Intel P-state driver initializing.\n");
 
 	all_cpu_data = vzalloc(sizeof(void *) * num_possible_cpus());
 	if (!all_cpu_data)
 		return -ENOMEM;
 
-	if (static_cpu_has_safe(X86_FEATURE_HWP) && !no_hwp) {
-		pr_info("intel_pstate: HWP enabled\n");
-		hwp_active++;
-	}
-
 	if (!hwp_active && hwp_only)
 		goto out;
 
@@ -1410,6 +1417,9 @@ static int __init intel_pstate_init(void
 	intel_pstate_debug_expose_params();
 	intel_pstate_sysfs_expose_params();
 
+	if (hwp_active)
+		pr_info("intel_pstate: HWP enabled\n");
+
 	return rc;
 out:
 	get_online_cpus();
