Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932843AbeCMKg1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:36:27 -0400
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:42658 "EHLO
        prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932687AbeCMKgV (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 13 Mar 2018 06:36:21 -0400
From: "Lee, Chun-Yi" <jlee@suse.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-fs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] MODSIGN: do not load mok when secure boot disabled
Date: Tue, 13 Mar 2018 18:35:55 +0800
Message-Id: <20180313103559.13032-2-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180313103559.13032-1-jlee@suse.com>
References: <20180313103559.13032-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mok can not be trusted when the secure boot is disabled. Which
means that the kernel embedded certificate is the only trusted key.

Due to db/dbx are authenticated variables, they needs manufacturer's
KEK for update. So db/dbx are secure when secureboot disabled.

Cc: David Howells <dhowells@redhat.com>
Cc: Josh Boyer <jwboyer@fedoraproject.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
---
 certs/load_uefi.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/certs/load_uefi.c b/certs/load_uefi.c
index 3d88459..d6de4d0 100644
--- a/certs/load_uefi.c
+++ b/certs/load_uefi.c
@@ -164,17 +164,6 @@ static int __init load_uefi_certs(void)
 		}
 	}
 
-	mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
-	if (!mok) {
-		pr_info("MODSIGN: Couldn't get UEFI MokListRT\n");
-	} else {
-		rc = parse_efi_signature_list("UEFI:MokListRT",
-					      mok, moksize, get_handler_for_db);
-		if (rc)
-			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
-		kfree(mok);
-	}
-
 	dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
 	if (!dbx) {
 		pr_info("MODSIGN: Couldn't get UEFI dbx list\n");
@@ -187,6 +176,21 @@ static int __init load_uefi_certs(void)
 		kfree(dbx);
 	}
 
+	/* the MOK can not be trusted when secure boot is disabled */
+	if (!efi_enabled(EFI_SECURE_BOOT))
+		return 0;
+
+	mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
+	if (!mok) {
+		pr_info("MODSIGN: Couldn't get UEFI MokListRT\n");
+	} else {
+		rc = parse_efi_signature_list("UEFI:MokListRT",
+					      mok, moksize, get_handler_for_db);
+		if (rc)
+			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
+		kfree(mok);
+	}
+
 	return rc;
 }
 late_initcall(load_uefi_certs);
-- 
2.10.2
