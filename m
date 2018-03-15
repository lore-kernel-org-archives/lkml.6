Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbeCOOWl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:22:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42310 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbeCOOWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:22:37 -0400
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH v3] xen/acpi: upload _PSD info for non Dom0 CPUs too
Date: Thu, 15 Mar 2018 14:22:05 +0000
Message-Id: <20180315142205.15839-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150162
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All uploaded PM data from non-dom0 CPUs takes the info from vCPU 0 and
changing only the acpi_id. For processors which P-state coordination type
is HW_ALL (0xFD) it is OK to upload bogus P-state dependency information
(_PSD), because Xen will ignore any cpufreq domains created for past CPUs.

Albeit for platforms which expose coordination types as SW_ANY or SW_ALL,
this will have some unintended side effects. Effectively, it will look at
the P-state domain existence and *if it already exists* it will skip the
acpi-cpufreq initialization and thus inherit the policy from the first CPU
in the cpufreq domain. This will finally lead to the original cpu not
changing target freq to P0 other than the first in the domain. Which will
make turbo boost not getting enabled (e.g. for 'performance' governor) for
all cpus.

This patch fixes that, by also evaluating _PSD when we enumerate all ACPI
processors and thus always uploading the correct info to Xen. We export
acpi_processor_get_psd() for that this purpose, but change signature
to not assume an existent of acpi_processor given that ACPI isn't creating
an acpi_processor for non-dom0 CPUs.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
Changes since v2:
 * Remove acpi_id_psd_present and instead use acpi_psd#num_entries non zero

Changes since v1:
 (Comments from Boris)
 * Refactor acpi_processor_get_psd(), export and use that instead.
 * s/offline/non-dom0/
---
 drivers/acpi/processor_perflib.c | 11 +++++------
 drivers/xen/xen-acpi-processor.c | 24 ++++++++++++++++++++++++
 include/acpi/processor.h         |  2 ++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index c7cf48ad5cb9..a651ab3490d8 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -533,7 +533,7 @@ int acpi_processor_notify_smm(struct module *calling_module)
 
 EXPORT_SYMBOL(acpi_processor_notify_smm);
 
-static int acpi_processor_get_psd(struct acpi_processor	*pr)
+int acpi_processor_get_psd(acpi_handle handle, struct acpi_psd_package *pdomain)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
@@ -541,9 +541,8 @@ static int acpi_processor_get_psd(struct acpi_processor	*pr)
 	struct acpi_buffer format = {sizeof("NNNNN"), "NNNNN"};
 	struct acpi_buffer state = {0, NULL};
 	union acpi_object  *psd = NULL;
-	struct acpi_psd_package *pdomain;
 
-	status = acpi_evaluate_object(pr->handle, "_PSD", NULL, &buffer);
+	status = acpi_evaluate_object(handle, "_PSD", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		return -ENODEV;
 	}
@@ -561,8 +560,6 @@ static int acpi_processor_get_psd(struct acpi_processor	*pr)
 		goto end;
 	}
 
-	pdomain = &(pr->performance->domain_info);
-
 	state.length = sizeof(struct acpi_psd_package);
 	state.pointer = pdomain;
 
@@ -597,6 +594,7 @@ static int acpi_processor_get_psd(struct acpi_processor	*pr)
 	kfree(buffer.pointer);
 	return result;
 }
+EXPORT_SYMBOL(acpi_processor_get_psd);
 
 int acpi_processor_preregister_performance(
 		struct acpi_processor_performance __percpu *performance)
@@ -645,7 +643,8 @@ int acpi_processor_preregister_performance(
 
 		pr->performance = per_cpu_ptr(performance, i);
 		cpumask_set_cpu(i, pr->performance->shared_cpu_map);
-		if (acpi_processor_get_psd(pr)) {
+		pdomain = &(pr->performance->domain_info);
+		if (acpi_processor_get_psd(pr->handle, pdomain)) {
 			retval = -EINVAL;
 			continue;
 		}
diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi-processor.c
index 23e391d3ec01..c80195e8fbd1 100644
--- a/drivers/xen/xen-acpi-processor.c
+++ b/drivers/xen/xen-acpi-processor.c
@@ -53,6 +53,8 @@ static unsigned long *acpi_ids_done;
 static unsigned long *acpi_id_present;
 /* And if there is an _CST definition (or a PBLK) for the ACPI IDs */
 static unsigned long *acpi_id_cst_present;
+/* Which ACPI P-State dependencies for a enumerated processor */
+static struct acpi_psd_package *acpi_psd;
 
 static int push_cxx_to_hypervisor(struct acpi_processor *_pr)
 {
@@ -372,6 +374,13 @@ read_acpi_id(acpi_handle handle, u32 lvl, void *context, void **rv)
 
 	pr_debug("ACPI CPU%u w/ PBLK:0x%lx\n", acpi_id, (unsigned long)pblk);
 
+	/* It has P-state dependencies */
+	if (!acpi_processor_get_psd(handle, &acpi_psd[acpi_id])) {
+		pr_debug("ACPI CPU%u w/ PST:coord_type = %llu domain = %llu\n",
+			 acpi_id, acpi_psd[acpi_id].coord_type,
+			 acpi_psd[acpi_id].domain);
+	}
+
 	status = acpi_evaluate_object(handle, "_CST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		if (!pblk)
@@ -405,6 +414,14 @@ static int check_acpi_ids(struct acpi_processor *pr_backup)
 		return -ENOMEM;
 	}
 
+	acpi_psd = kcalloc(nr_acpi_bits, sizeof(struct acpi_psd_package),
+			   GFP_KERNEL);
+	if (!acpi_psd) {
+		kfree(acpi_id_present);
+		kfree(acpi_id_cst_present);
+		return -ENOMEM;
+	}
+
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
 			    read_acpi_id, NULL, NULL, NULL);
@@ -417,6 +434,12 @@ static int check_acpi_ids(struct acpi_processor *pr_backup)
 			pr_backup->acpi_id = i;
 			/* Mask out C-states if there are no _CST or PBLK */
 			pr_backup->flags.power = test_bit(i, acpi_id_cst_present);
+			/* num_entries is non-zero if we evaluated _PSD */
+			if (acpi_psd[i].num_entries) {
+				memcpy(&pr_backup->performance->domain_info,
+				       &acpi_psd[i],
+				       sizeof(struct acpi_psd_package));
+			}
 			(void)upload_pm_data(pr_backup);
 		}
 	}
@@ -566,6 +589,7 @@ static void __exit xen_acpi_processor_exit(void)
 	kfree(acpi_ids_done);
 	kfree(acpi_id_present);
 	kfree(acpi_id_cst_present);
+	kfree(acpi_psd);
 	for_each_possible_cpu(i)
 		acpi_processor_unregister_performance(i);
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index d591bb77f592..40a916efd7c0 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -254,6 +254,8 @@ int acpi_processor_pstate_control(void);
 /* note: this locks both the calling module and the processor module
          if a _PPC object exists, rmmod is disallowed then */
 int acpi_processor_notify_smm(struct module *calling_module);
+int acpi_processor_get_psd(acpi_handle handle,
+			   struct acpi_psd_package *pdomain);
 
 /* parsing the _P* objects. */
 extern int acpi_processor_get_performance_info(struct acpi_processor *pr);
-- 
2.11.0
