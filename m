Return-Path: <anjiandi@codeaurora.org>
X-Google-Smtp-Source: AG47ELt9OxJyU7uMrjUMU3boqhfhrWmkOCSefV+v7eKfGiK7SQm/rlC2BIF0tOq64f2RNk8Firso
ARC-Seal: i=1; a=rsa-sha256; t=1520401748; cv=none;
        d=google.com; s=arc-20160816;
        b=CXZ5lQ+rAMnFtUl9IBMjdmmSSWLOu5warGo+4QhkGLq9iVKlZMkylndRclb/AsWi6O
         u96e8U/DfioCdVzZdScyGSyDRYm0hFp7aZECfJnwIOm20twYe8CGWhGD8JAhTmEdwwq8
         4J/y8+RT7wuYk22spJ8n2U/8v8sh60S8hC4a7SL2tK0ocLr6DZOGFfmYXX3Iv69Z5cWd
         E4dvCJk1n/2vw4zFpIuDI8Hhk7Il7IlSaSsrGyMcPDJV/Q0EPV89GNTjoSCE47AXJfF+
         L3kQN2WhQWZUGioWZTo6pnmCB7R/B9FRtX6Nr8v1d/sUy1Gr1XcqkbFSAY3/C+ZfuFRd
         5t0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=bsim7KXbsKr2PBWRXvz8XCO3xDOzUhuycrvZQjRLZ+U=;
        b=BhKCMY9W69l40e1yiJcmHPoZpA5YlKIK5yJu/sutMa6VEYZ2uRQjuQ2gLksx+Vrb/D
         vDcyunsHAOAcNQontAoW7CieoTxgYPEqTk6+Ahaihsl/uRHIfEApFz3g7HIoov0erbOc
         KI7Z7icplklauNkmcODJw1uOUCG9npaR3xvX7HHs3LtBtLkRaX32JdOEvpwfq2YCN2Xl
         Qm97t+Pv5XY84snJjpX0RKWUQJDbM0CHup6B0s5A/yvSiqvZnUXJ4QCpw6nWj/1BK3Lz
         Z/1m1R+8grDVz9y3GmPTYmsVvoXDs7Ugo8IEPLFNoC3TBlP1muJkhgJRTOPgUr8ocVwA
         uctQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=mon+Z4XU;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jP9a5kpA;
       spf=pass (google.com: domain of anjiandi@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=anjiandi@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=mon+Z4XU;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jP9a5kpA;
       spf=pass (google.com: domain of anjiandi@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=anjiandi@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50B606043F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anjiandi@codeaurora.org
From: Jiandi An <anjiandi@codeaurora.org>
To: minyard@acm.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	anjiandi@codeaurora.org
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi:ssif: Fix double probe from tryacpi and trydmi
Date: Tue,  6 Mar 2018 23:49:02 -0600
Message-Id: <1520401742-29371-1-git-send-email-anjiandi@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594256783530173798?=
X-GMAIL-MSGID: =?utf-8?q?1594256783530173798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

IPMI SSIF driver's parameter tryacpi and trydmi both
are set to true.  The addition of IPMI DMI driver to
create platform device for each IPMI device causes
SSIF probe to be done twice on the same SMB I2C address
for BMC.  Fix is to not call trydmi if tryacpi is able
to find I2C address for BMC from SPMI ACPI table and
probe successfully.

Signed-off-by: Jiandi An <anjiandi@codeaurora.org>
---
 drivers/char/ipmi/ipmi_ssif.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 9d3b0fa..5c57363 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1981,29 +1981,41 @@ static int try_init_spmi(struct SPMITable *spmi)
 	return new_ssif_client(myaddr, NULL, 0, 0, SI_SPMI, NULL);
 }
 
-static void spmi_find_bmc(void)
+static int spmi_find_bmc(void)
 {
 	acpi_status      status;
 	struct SPMITable *spmi;
 	int              i;
+	int              rc = 0;
 
 	if (acpi_disabled)
-		return;
+		return -EPERM;
 
 	if (acpi_failure)
-		return;
+		return -ENODEV;
 
 	for (i = 0; ; i++) {
 		status = acpi_get_table(ACPI_SIG_SPMI, i+1,
 					(struct acpi_table_header **)&spmi);
-		if (status != AE_OK)
-			return;
+		if (status != AE_OK) {
+			if (i == 0)
+				return -ENODEV;
+			else
+				return 0;
+		}
 
-		try_init_spmi(spmi);
+		rc = try_init_spmi(spmi);
+		if (rc)
+			return rc;
 	}
+
+	return 0;
 }
 #else
-static void spmi_find_bmc(void) { }
+static int spmi_find_bmc(void)
+{
+	return -ENODEV;
+}
 #endif
 
 #ifdef CONFIG_DMI
@@ -2104,12 +2116,13 @@ static int init_ipmi_ssif(void)
 			       addr[i]);
 	}
 
-	if (ssif_tryacpi)
+	if (ssif_tryacpi) {
 		ssif_i2c_driver.driver.acpi_match_table	=
 			ACPI_PTR(ssif_acpi_match);
-
-	if (ssif_tryacpi)
-		spmi_find_bmc();
+		rv = spmi_find_bmc();
+		if (!rv)
+			ssif_trydmi = false;
+	}
 
 	if (ssif_trydmi) {
 		rv = platform_driver_register(&ipmi_driver);
-- 
Jiandi An
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
