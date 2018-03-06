Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753923AbeCFUM0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 15:12:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41112 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753466AbeCFUMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 15:12:25 -0500
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v1] xen: acpi: upload _PSD info for offline CPUs too
Date: Tue,  6 Mar 2018 20:12:09 +0000
Message-Id: <20180306201209.21890-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8824 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060218
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All uploaded PM data from offline CPUs takes the info from vCPU 0 and
changing only the acpi_id. For processors which P-state coordination type
is HW_ALL (0xFD) it is OK to upload bogus P-state dependency information
(_PSD), because Xen will ignore cpufreq domains existence.

Albeit for hardware exposing Px coordination types as SW_ANY or SW_ALL,
this will have some unintended side effects. Effectively, it will look at
the P-state domain existence and *if it already exists* it will skip the
acpi-cpufreq initialization and thus inherit the policy from the first CPU
in the cpufreq domain. This will finally lead to the original cpu not
changing target freq to P0 other than the first in the domain. Which will
make turbo boost not getting enabled (e.g. for 'performance' governor) for
all cpus.

This patch fixes that, by also evaluating _PSD when enumerating all ACPI
procesors (online and offline) and always uploading the correct P-State
dependency up to Xen.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
xen_processor_get_psd() is taken from acpi_processor_get_psd()
(drivers/acpi/processor_perflib.c) simply because only Xen Dom0 needs
to handle vcpus != pcpus. If preferred I could try exporting that API
instead and use it here.
---
 drivers/xen/xen-acpi-processor.c | 101 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi-processor.c
index 23e391d3ec01..63b3d005a1bb 100644
--- a/drivers/xen/xen-acpi-processor.c
+++ b/drivers/xen/xen-acpi-processor.c
@@ -53,6 +53,10 @@ static unsigned long *acpi_ids_done;
 static unsigned long *acpi_id_present;
 /* And if there is an _CST definition (or a PBLK) for the ACPI IDs */
 static unsigned long *acpi_id_cst_present;
+/* And if there is an _PSD definition for the ACPI IDs */
+static unsigned long *acpi_id_psd_present;
+/* Which ACPI P-State dependencies for a enumerated processor */
+static struct acpi_psd_package *acpi_psd;
 
 static int push_cxx_to_hypervisor(struct acpi_processor *_pr)
 {
@@ -319,6 +323,69 @@ static unsigned int __init get_max_acpi_id(void)
 	pr_debug("Max ACPI ID: %u\n", max_acpi_id);
 	return max_acpi_id;
 }
+
+static int xen_processor_get_psd(acpi_handle handle,
+				 struct acpi_psd_package *pdomain)
+{
+	int result = 0;
+	acpi_status status = AE_OK;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_buffer format = {sizeof("NNNNN"), "NNNNN"};
+	struct acpi_buffer state = {0, NULL};
+	union acpi_object  *psd = NULL;
+
+	status = acpi_evaluate_object(handle, "_PSD", NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	psd = buffer.pointer;
+	if (!psd || (psd->type != ACPI_TYPE_PACKAGE)) {
+		pr_err("Invalid _PSD data\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	if (psd->package.count != 1) {
+		pr_err("Invalid _PSD data\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	state.length = sizeof(struct acpi_psd_package);
+	state.pointer = pdomain;
+
+	status = acpi_extract_package(&(psd->package.elements[0]),
+		&format, &state);
+	if (ACPI_FAILURE(status)) {
+		pr_err("Invalid _PSD data\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	if (pdomain->num_entries != ACPI_PSD_REV0_ENTRIES) {
+		pr_err("Unknown _PSD:num_entries\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	if (pdomain->revision != ACPI_PSD_REV0_REVISION) {
+		pr_err("Unknown _PSD:revision\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	if (pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ALL &&
+	    pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ANY &&
+	    pdomain->coord_type != DOMAIN_COORD_TYPE_HW_ALL) {
+		pr_err("Invalid _PSD:coord_type\n");
+		result = -EFAULT;
+		goto end;
+	}
+end:
+	kfree(buffer.pointer);
+	return result;
+}
+
 /*
  * The read_acpi_id and check_acpi_ids are there to support the Xen
  * oddity of virtual CPUs != physical CPUs in the initial domain.
@@ -372,6 +439,15 @@ read_acpi_id(acpi_handle handle, u32 lvl, void *context, void **rv)
 
 	pr_debug("ACPI CPU%u w/ PBLK:0x%lx\n", acpi_id, (unsigned long)pblk);
 
+	/* It has P-state dependencies */
+	if (!xen_processor_get_psd(handle, &acpi_psd[acpi_id])) {
+		__set_bit(acpi_id, acpi_id_psd_present);
+
+		pr_debug("ACPI CPU%u w/ PST:coord_type = %llu domain = %llu\n",
+			 acpi_id, acpi_psd[acpi_id].coord_type,
+			 acpi_psd[acpi_id].domain);
+	}
+
 	status = acpi_evaluate_object(handle, "_CST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		if (!pblk)
@@ -382,6 +458,7 @@ read_acpi_id(acpi_handle handle, u32 lvl, void *context, void **rv)
 
 	return AE_OK;
 }
+
 static int check_acpi_ids(struct acpi_processor *pr_backup)
 {
 
@@ -405,6 +482,23 @@ static int check_acpi_ids(struct acpi_processor *pr_backup)
 		return -ENOMEM;
 	}
 
+	acpi_id_psd_present = kcalloc(BITS_TO_LONGS(nr_acpi_bits),
+				      sizeof(unsigned long), GFP_KERNEL);
+	if (!acpi_id_psd_present) {
+		kfree(acpi_id_present);
+		kfree(acpi_id_cst_present);
+		return -ENOMEM;
+	}
+
+	acpi_psd = kcalloc(nr_acpi_bits, sizeof(struct acpi_psd_package),
+			   GFP_KERNEL);
+	if (!acpi_psd) {
+		kfree(acpi_id_present);
+		kfree(acpi_id_cst_present);
+		kfree(acpi_id_psd_present);
+		return -ENOMEM;
+	}
+
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
 			    read_acpi_id, NULL, NULL, NULL);
@@ -417,6 +511,11 @@ static int check_acpi_ids(struct acpi_processor *pr_backup)
 			pr_backup->acpi_id = i;
 			/* Mask out C-states if there are no _CST or PBLK */
 			pr_backup->flags.power = test_bit(i, acpi_id_cst_present);
+			if (test_bit(i, acpi_id_psd_present)) {
+				memcpy(&pr_backup->performance->domain_info,
+				       &acpi_psd[i],
+				       sizeof(struct acpi_psd_package));
+			}
 			(void)upload_pm_data(pr_backup);
 		}
 	}
@@ -566,6 +665,8 @@ static void __exit xen_acpi_processor_exit(void)
 	kfree(acpi_ids_done);
 	kfree(acpi_id_present);
 	kfree(acpi_id_cst_present);
+	kfree(acpi_id_psd_present);
+	kfree(acpi_psd);
 	for_each_possible_cpu(i)
 		acpi_processor_unregister_performance(i);
 
-- 
2.11.0
