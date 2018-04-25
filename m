Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+bdnoZ+UpYULbqx0riPDqz5NwoAUDzZlKbXZanVx/mOGLTnyd5o2O1beIv7pzoVCNHglSH
ARC-Seal: i=1; a=rsa-sha256; t=1524652953; cv=none;
        d=google.com; s=arc-20160816;
        b=u0t3wm6eduoJp2Q3KZGNuG8jKCl23cDlqH+A6ocA0PQoBti3xkQ9Q3aFolAHTp9Z2c
         1HGx4V6XbxKyXpGaA1Dww3pKyhJs6bd5ZdU0LmNgh9Ihu9Cy4dGd2r6RyP9pHGJ7Gj7o
         t0gMl2Hzh5JINrXVvO+atlzOL4STOZLX65hf5XciEZmmVziEVs9hzyGq4Ztt9zJFI7o8
         BMq2Ohe0/hlQ4WMGx2qKUhJ3uGR2brL4PCqmWVm2ORQ6twjPIVlMLb7CfhU6MCSWogZa
         bbaIAFczT2V5anaPpN+EmGHNWf/HAqTVGSJLcK0vN4DH+e3vGDWKbQsXwgB25sQUr2/P
         kYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FthugtqeSDkUWIZWERLquK8SG8xG6lctxEA3HQ7Dhog=;
        b=ejnrxHIpvs2gHCwRO25NM2wU6ruQvT5tGUDDITDXYfKg51Wf7cgCt5IBfSPBu1+x/u
         bMRCM/sVLHdhlqNbmRD4c1E49XOYEradDQtg7OvllEHW6+y7JvqZ4GEpWVp5IV9Hk0Ji
         +V32q2cvTjZZYbtyGCoLrM4y4g5OXNnI6/UvvH6Ybt6glYYoPcLGZkDI3hFPmf9DlqEh
         Tvfm2flWTDxHCX21s+agJGlpYPpkDScUjIWtWDIAcjC0Sey1vIoo6VlStmsuL+Bf374H
         akTDAFvHpux0oeXyc9RfWRcvq55kOOtPUUJIwARkLuRqqvHLr00HdFARL2EIjt/oKxsT
         oy7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Doug Smythies <dsmythies@telus.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Yu Chen <yu.c.chen@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 130/183] ACPI: processor_perflib: Do not send _PPC change notification if not ready
Date: Wed, 25 Apr 2018 12:35:50 +0200
Message-Id: <20180425103247.654330414@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714495578856348?=
X-GMAIL-MSGID: =?utf-8?q?1598714495578856348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Yu <yu.c.chen@intel.com>


[ Upstream commit ba1edb9a5125a617d612f98eead14b9b84e75c3a ]

The following warning was triggered after resumed from S3 -
if all the nonboot CPUs were put offline before suspend:

[ 1840.329515] unchecked MSR access error: RDMSR from 0x771 at rIP: 0xffffffff86061e3a (native_read_msr+0xa/0x30)
[ 1840.329516] Call Trace:
[ 1840.329521]  __rdmsr_on_cpu+0x33/0x50
[ 1840.329525]  generic_exec_single+0x81/0xb0
[ 1840.329527]  smp_call_function_single+0xd2/0x100
[ 1840.329530]  ? acpi_ds_result_pop+0xdd/0xf2
[ 1840.329532]  ? acpi_ds_create_operand+0x215/0x23c
[ 1840.329534]  rdmsrl_on_cpu+0x57/0x80
[ 1840.329536]  ? cpumask_next+0x1b/0x20
[ 1840.329538]  ? rdmsrl_on_cpu+0x57/0x80
[ 1840.329541]  intel_pstate_update_perf_limits+0xf3/0x220
[ 1840.329544]  ? notifier_call_chain+0x4a/0x70
[ 1840.329546]  intel_pstate_set_policy+0x4e/0x150
[ 1840.329548]  cpufreq_set_policy+0xcd/0x2f0
[ 1840.329550]  cpufreq_update_policy+0xb2/0x130
[ 1840.329552]  ? cpufreq_update_policy+0x130/0x130
[ 1840.329556]  acpi_processor_ppc_has_changed+0x65/0x80
[ 1840.329558]  acpi_processor_notify+0x80/0x100
[ 1840.329561]  acpi_ev_notify_dispatch+0x44/0x5c
[ 1840.329563]  acpi_os_execute_deferred+0x14/0x20
[ 1840.329565]  process_one_work+0x193/0x3c0
[ 1840.329567]  worker_thread+0x35/0x3b0
[ 1840.329569]  kthread+0x125/0x140
[ 1840.329571]  ? process_one_work+0x3c0/0x3c0
[ 1840.329572]  ? kthread_park+0x60/0x60
[ 1840.329575]  ? do_syscall_64+0x67/0x180
[ 1840.329577]  ret_from_fork+0x25/0x30
[ 1840.329585] unchecked MSR access error: WRMSR to 0x774 (tried to write 0x0000000000000000) at rIP: 0xffffffff86061f78 (native_write_msr+0x8/0x30)
[ 1840.329586] Call Trace:
[ 1840.329587]  __wrmsr_on_cpu+0x37/0x40
[ 1840.329589]  generic_exec_single+0x81/0xb0
[ 1840.329592]  smp_call_function_single+0xd2/0x100
[ 1840.329594]  ? acpi_ds_create_operand+0x215/0x23c
[ 1840.329595]  ? cpumask_next+0x1b/0x20
[ 1840.329597]  wrmsrl_on_cpu+0x57/0x70
[ 1840.329598]  ? rdmsrl_on_cpu+0x57/0x80
[ 1840.329599]  ? wrmsrl_on_cpu+0x57/0x70
[ 1840.329602]  intel_pstate_hwp_set+0xd3/0x150
[ 1840.329604]  intel_pstate_set_policy+0x119/0x150
[ 1840.329606]  cpufreq_set_policy+0xcd/0x2f0
[ 1840.329607]  cpufreq_update_policy+0xb2/0x130
[ 1840.329610]  ? cpufreq_update_policy+0x130/0x130
[ 1840.329613]  acpi_processor_ppc_has_changed+0x65/0x80
[ 1840.329615]  acpi_processor_notify+0x80/0x100
[ 1840.329617]  acpi_ev_notify_dispatch+0x44/0x5c
[ 1840.329619]  acpi_os_execute_deferred+0x14/0x20
[ 1840.329620]  process_one_work+0x193/0x3c0
[ 1840.329622]  worker_thread+0x35/0x3b0
[ 1840.329624]  kthread+0x125/0x140
[ 1840.329625]  ? process_one_work+0x3c0/0x3c0
[ 1840.329626]  ? kthread_park+0x60/0x60
[ 1840.329628]  ? do_syscall_64+0x67/0x180
[ 1840.329631]  ret_from_fork+0x25/0x30

This is because if there's only one online CPU, the MSR_PM_ENABLE
(package wide)can not be enabled after resumed, due to
intel_pstate_hwp_enable() will only be invoked on AP's online
process after resumed - if there's no AP online, the HWP remains
disabled after resumed (BIOS has disabled it in S3). Then if
there comes a _PPC change notification which touches HWP register
during this stage, the warning is triggered.

Since we don't call acpi_processor_register_performance() when
HWP is enabled, the pr->performance will be NULL. When this is
NULL we don't need to do _PPC change notification.

Reported-by: Doug Smythies <dsmythies@telus.net>
Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Yu Chen <yu.c.chen@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/processor_perflib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -159,7 +159,7 @@ void acpi_processor_ppc_has_changed(stru
 {
 	int ret;
 
-	if (ignore_ppc) {
+	if (ignore_ppc || !pr->performance) {
 		/*
 		 * Only when it is notification event, the _OST object
 		 * will be evaluated. Otherwise it is skipped.
