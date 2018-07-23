Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856FFECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3792120854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3792120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbeGWN36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:29:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45758 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387998AbeGWN35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:29:57 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0C5AABB3;
        Mon, 23 Jul 2018 12:28:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Herrmann <aherrmann@suse.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 16/44] cpufreq: intel_pstate: Register when ACPI PCCH is present
Date:   Mon, 23 Jul 2018 14:24:52 +0200
Message-Id: <20180723122438.216981809@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122437.447870153@linuxfoundation.org>
References: <20180723122437.447870153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 95d6c0857e54b788982746071130d822a795026b upstream.

Currently, intel_pstate doesn't register if _PSS is not present on
HP Proliant systems, because it expects the firmware to take over
CPU performance scaling in that case.  However, if ACPI PCCH is
present, the firmware expects the kernel to use it for CPU
performance scaling and the pcc-cpufreq driver is loaded for that.

Unfortunately, the firmware interface used by that driver is not
scalable for fundamental reasons, so pcc-cpufreq is way suboptimal
on systems with more than just a few CPUs.  In fact, it is better to
avoid using it at all.

For this reason, modify intel_pstate to look for ACPI PCCH if _PSS
is not present and register if it is there.  Also prevent the
pcc-cpufreq driver from trying to initialize itself if intel_pstate
has been registered already.

Fixes: fbbcdc0744da (intel_pstate: skip the driver if ACPI has power mgmt option)
Reported-by: Andreas Herrmann <aherrmann@suse.com>
Reviewed-by: Andreas Herrmann <aherrmann@suse.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Tested-by: Andreas Herrmann <aherrmann@suse.com>
Cc: 4.16+ <stable@vger.kernel.org> # 4.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/intel_pstate.c |   17 ++++++++++++++++-
 drivers/cpufreq/pcc-cpufreq.c  |    4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2188,6 +2188,18 @@ static bool __init intel_pstate_no_acpi_
 	return true;
 }
 
+static bool __init intel_pstate_no_acpi_pcch(void)
+{
+	acpi_status status;
+	acpi_handle handle;
+
+	status = acpi_get_handle(NULL, "\\_SB", &handle);
+	if (ACPI_FAILURE(status))
+		return true;
+
+	return !acpi_has_method(handle, "PCCH");
+}
+
 static bool __init intel_pstate_has_acpi_ppc(void)
 {
 	int i;
@@ -2247,7 +2259,10 @@ static bool __init intel_pstate_platform
 
 	switch (plat_info[idx].data) {
 	case PSS:
-		return intel_pstate_no_acpi_pss();
+		if (!intel_pstate_no_acpi_pss())
+			return false;
+
+		return intel_pstate_no_acpi_pcch();
 	case PPC:
 		return intel_pstate_has_acpi_ppc() && !force_load;
 	}
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -580,6 +580,10 @@ static int __init pcc_cpufreq_init(void)
 {
 	int ret;
 
+	/* Skip initialization if another cpufreq driver is there. */
+	if (cpufreq_get_current_driver())
+		return 0;
+
 	if (acpi_disabled)
 		return 0;
 


