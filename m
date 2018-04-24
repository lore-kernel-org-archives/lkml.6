Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeDXTfX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:35:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751110AbeDXTfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:35:17 -0400
From: Al Stone <ahs3@redhat.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Al Stone <ahs3@redhat.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Subject: [PATCH v2 3/3] mailbox: ACPI: erroneous error message when parsing the ACPI PCCT
Date: Tue, 24 Apr 2018 13:35:05 -0600
Message-Id: <20180424193505.6934-4-ahs3@redhat.com>
In-Reply-To: <20180424193505.6934-1-ahs3@redhat.com>
References: <20180424193505.6934-1-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been multiple reports of the following error message:

[    0.068293] Error parsing PCC subspaces from PCCT

This error message is not correct.  In multiple cases examined, the PCCT
(Platform Communications Channel Table) concerned is actually properly
constructed; the problem is that acpi_pcc_probe() which reads the PCCT
is making the assumption that the only valid PCCT is one that contains
subtables of one of two types: ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE or
ACPI_PCCT_TYPE_HW_REDUCED_TYPE2.  The number of subtables of these
types are counted and as long as there is at least one of the desired
types, the acpi_pcc_probe() succeeds.  When no subtables of these types
are found, regardless of whether or not any other subtable types are
present, the error mentioned above is reported.

In the cases reported to me personally, the PCCT contains exactly one
subtable of type ACPI_PCCT_TYPE_GENERIC_SUBSPACE.  The function
acpi_pcc_probe() does not count it as a valid subtable, so believes
there to be no valid subtables, and hence outputs the error message.

An example of the PCCT being reported as erroneous yet perfectly fine
is the following:

                    Signature : "PCCT"
                 Table Length : 0000006E
                     Revision : 05
                     Checksum : A9
                       Oem ID : "XXXXXX"
                 Oem Table ID : "XXXXX   "
                 Oem Revision : 00002280
              Asl Compiler ID : "XXXX"
        Asl Compiler Revision : 00000002

        Flags (decoded below) : 00000001
                     Platform : 1
                     Reserved : 0000000000000000

                Subtable Type : 00 [Generic Communications Subspace]
                       Length : 3E

                     Reserved : 000000000000
                 Base Address : 00000000DCE43018
               Address Length : 0000000000001000

            Doorbell Register : [Generic Address Structure]
                     Space ID : 01 [SystemIO]
                    Bit Width : 08
                   Bit Offset : 00
         Encoded Access Width : 01 [Byte Access:8]
                      Address : 0000000000001842

                Preserve Mask : 00000000000000FD
                   Write Mask : 0000000000000002
              Command Latency : 00001388
          Maximum Access Rate : 00000000
      Minimum Turnaround Time : 0000

To fix this, we count up all of the possible subtable types for the
PCCT, and only report an error when there are none (which could mean
either no subtables, or no valid subtables), or there are too many.
We also change the logic so that if there is a valid subtable, we
do try to initialize it per the PCCT subtable contents.  This is a
change in functionality; previously, the probe would have returned
right after the error message and would not have tried to use any
other subtable definition.

Tested on my personal laptop which showed the error previously; the
error message no longer appears and the laptop appears to operate
normally.

Signed-off-by: Al Stone <ahs3@redhat.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/mailbox/pcc.c | 99 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 26 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 3ef7f036ceea..cc77a2f1694f 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -372,6 +372,35 @@ static const struct mbox_chan_ops pcc_chan_ops = {
 	.send_data = pcc_send_data,
 };
 
+/*
+ *
+ * count_pcc_subspaces -- Count the PCC subspaces that are not used in
+ *		reduced hardware systems.
+ * @header: Pointer to the ACPI subtable header under the PCCT.
+ * @end: End of subtable entry.
+ *
+ * Return: 0 for Success, else errno.
+ *
+ * This gets called for each entry in the PCC table.
+ */
+static int count_pcc_subspaces(struct acpi_subtable_header *header,
+		const unsigned long end)
+{
+	struct acpi_pcct_subspace *pcct_ss =
+				(struct acpi_pcct_subspace *) header;
+
+	if ((pcct_ss->header.type <= ACPI_PCCT_TYPE_RESERVED) &&
+	    (pcct_ss->header.type != ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE) &&
+	    (pcct_ss->header.type !=
+				ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)) {
+		pr_warn("PCCT count: useful subtype = %d\n",
+			pcct_ss->header.type);
+		return 0;
+	}
+	pr_warn("PCCT count: unwanted subtype = %d\n", pcct_ss->header.type);
+	return -EINVAL;
+}
+
 /**
  * parse_pcc_subspace - Parse the PCC table and verify PCC subspace
  *		entries. There should be one entry per PCC client.
@@ -395,10 +424,14 @@ static int parse_pcc_subspace(struct acpi_subtable_header *header,
 		    && (pcct_ss->header.type !=
 				ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)) {
 			pr_err("Incorrect PCC Subspace type detected\n");
+			pr_warn("PCCT parse: unwanted subtype = %d\n",
+				pcct_ss->header.type);
 			return -EINVAL;
 		}
 	}
 
+	pcct_ss = (struct acpi_pcct_hw_reduced *) header;
+	pr_warn("PCCT parse: useful subtype = %d\n", pcct_ss->header.type);
 	return 0;
 }
 
@@ -449,8 +482,8 @@ static int __init acpi_pcc_probe(void)
 	struct acpi_table_header *pcct_tbl;
 	struct acpi_subtable_header *pcct_entry;
 	struct acpi_table_pcct *acpi_pcct_tbl;
+	struct acpi_subtable_proc proc[ACPI_PCCT_TYPE_RESERVED];
 	int count, i, rc;
-	int sum = 0;
 	acpi_status status = AE_OK;
 
 	/* Search for PCCT */
@@ -459,43 +492,50 @@ static int __init acpi_pcc_probe(void)
 	if (ACPI_FAILURE(status) || !pcct_tbl)
 		return -ENODEV;
 
-	count = acpi_table_parse_entries(ACPI_SIG_PCCT,
-			sizeof(struct acpi_table_pcct),
-			ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE,
-			parse_pcc_subspace, MAX_PCC_SUBSPACES);
-	sum += (count > 0) ? count : 0;
-
-	count = acpi_table_parse_entries(ACPI_SIG_PCCT,
-			sizeof(struct acpi_table_pcct),
-			ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2,
-			parse_pcc_subspace, MAX_PCC_SUBSPACES);
-	sum += (count > 0) ? count : 0;
+	/* Set up the subtable handlers */
+	for (i = ACPI_PCCT_TYPE_GENERIC_SUBSPACE;
+	     i < ACPI_PCCT_TYPE_RESERVED;
+	     i++) {
+		proc[i].id = i;
+		if (i == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE ||
+		    i == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)
+			proc[i].handler = parse_pcc_subspace;
+		else
+			proc[i].handler = count_pcc_subspaces;
+		proc[i].count = 0;
+	}
 
-	if (sum == 0 || sum >= MAX_PCC_SUBSPACES) {
-		pr_err("Error parsing PCC subspaces from PCCT\n");
+	count = acpi_table_parse_entries_array(ACPI_SIG_PCCT,
+			sizeof(struct acpi_table_pcct), proc,
+			ACPI_PCCT_TYPE_RESERVED, MAX_PCC_SUBSPACES);
+	if (count == 0) {
+		pr_warn("PCCT provided but has no subspaces defined\n");
+		return -EINVAL;
+	} else if (count > MAX_PCC_SUBSPACES) {
+		pr_warn("Too many PCC subspaces defined in PCCT\n");
 		return -EINVAL;
 	}
 
 	pcc_mbox_channels = kzalloc(sizeof(struct mbox_chan) *
-			sum, GFP_KERNEL);
+			count, GFP_KERNEL);
 	if (!pcc_mbox_channels) {
 		pr_err("Could not allocate space for PCC mbox channels\n");
 		return -ENOMEM;
 	}
 
-	pcc_doorbell_vaddr = kcalloc(sum, sizeof(void *), GFP_KERNEL);
+	pcc_doorbell_vaddr = kcalloc(count, sizeof(void *), GFP_KERNEL);
 	if (!pcc_doorbell_vaddr) {
 		rc = -ENOMEM;
 		goto err_free_mbox;
 	}
 
-	pcc_doorbell_ack_vaddr = kcalloc(sum, sizeof(void *), GFP_KERNEL);
+	pcc_doorbell_ack_vaddr = kcalloc(count, sizeof(void *), GFP_KERNEL);
 	if (!pcc_doorbell_ack_vaddr) {
 		rc = -ENOMEM;
 		goto err_free_db_vaddr;
 	}
 
-	pcc_doorbell_irq = kcalloc(sum, sizeof(int), GFP_KERNEL);
+	pcc_doorbell_irq = kcalloc(count, sizeof(int), GFP_KERNEL);
 	if (!pcc_doorbell_irq) {
 		rc = -ENOMEM;
 		goto err_free_db_ack_vaddr;
@@ -509,18 +549,25 @@ static int __init acpi_pcc_probe(void)
 	if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL)
 		pcc_mbox_ctrl.txdone_irq = true;
 
-	for (i = 0; i < sum; i++) {
+	for (i = 0; i < count; i++) {
 		struct acpi_generic_address *db_reg;
-		struct acpi_pcct_hw_reduced *pcct_ss;
+		struct acpi_pcct_subspace *pcct_ss;
 		pcc_mbox_channels[i].con_priv = pcct_entry;
 
-		pcct_ss = (struct acpi_pcct_hw_reduced *) pcct_entry;
+		if (pcct_entry->type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE ||
+		    pcct_entry->type ==
+				ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
+			struct acpi_pcct_hw_reduced *pcct_hrss;
+
+			pcct_hrss = (struct acpi_pcct_hw_reduced *) pcct_entry;
 
-		if (pcc_mbox_ctrl.txdone_irq) {
-			rc = pcc_parse_subspace_irq(i, pcct_ss);
-			if (rc < 0)
-				goto err;
+			if (pcc_mbox_ctrl.txdone_irq) {
+				rc = pcc_parse_subspace_irq(i, pcct_hrss);
+				if (rc < 0)
+					goto err;
+			}
 		}
+		pcct_ss = (struct acpi_pcct_subspace *) pcct_entry;
 
 		/* If doorbell is in system memory cache the virt address */
 		db_reg = &pcct_ss->doorbell_register;
@@ -531,7 +578,7 @@ static int __init acpi_pcc_probe(void)
 			((unsigned long) pcct_entry + pcct_entry->length);
 	}
 
-	pcc_mbox_ctrl.num_chans = sum;
+	pcc_mbox_ctrl.num_chans = count;
 
 	pr_info("Detected %d PCC Subspaces\n", pcc_mbox_ctrl.num_chans);
 
-- 
2.14.3
