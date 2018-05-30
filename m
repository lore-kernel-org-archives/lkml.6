Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753667AbeE3ROc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:14:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40536 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752982AbeE3ROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:14:31 -0400
From: Colin King <colin.king@canonical.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Al Stone <ahs3@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mailbox: PCC: check for negative count for parse failure checking
Date: Wed, 30 May 2018 18:14:29 +0100
Message-Id: <20180530171429.3172-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function acpi_table_parse_enties_array can potentially return a
negative value if parsing fails. Currently the check on the return
is not checking for errors, so fix this by adding a -ve check too.

Detected by CoverityScan, CID#1469477 ("Improper use of negative value")

Fixes: 8f8027c5f935 ("mailbox: PCC: erroneous error message when parsing ACPI PCCT")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mailbox/pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index fc3c237daef2..87d67922020d 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -461,7 +461,7 @@ static int __init acpi_pcc_probe(void)
 	count = acpi_table_parse_entries_array(ACPI_SIG_PCCT,
 			sizeof(struct acpi_table_pcct), proc,
 			ACPI_PCCT_TYPE_RESERVED, MAX_PCC_SUBSPACES);
-	if (count == 0 || count > MAX_PCC_SUBSPACES) {
+	if (count <= 0 || count > MAX_PCC_SUBSPACES) {
 		pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
 		return -EINVAL;
 	}
-- 
2.17.0
