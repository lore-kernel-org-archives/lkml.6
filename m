Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeBBNTa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:19:30 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:62784 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeBBNTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:19:20 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        QLogic-Storage-Upstream@cavium.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Saurav Kashyap <saurav.kashyap@cavium.com>,
        "Dupuis, Chad" <chad.dupuis@cavium.com>,
        Arun Easi <arun.easi@cavium.com>,
        Nilesh Javali <nilesh.javali@cavium.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] scsi: qedf: use correct strncpy() size
Date: Fri,  2 Feb 2018 14:12:20 +0100
Message-Id: <20180202131225.1658853-7-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202131225.1658853-1-arnd@arndb.de>
References: <20180202131225.1658853-1-arnd@arndb.de>
X-Provags-ID: V03:K0:+08KeQYkcmg6YFv+BV2i7zTvTI63paVPXItNfcWmGRcY8V0r0nQ
 u87dufChhWViRUHUnpCcSgKbRZAo83uhIDSeq+ISur782Yp4dVQONU4yLcNVqYMlkkkvDdL
 /VmtB0twYi1o91at6DVRjHhHuYjJO4sIBg+6JlV0bBH3YAk/F5x28jWrP/0lfwp5UpgzBtx
 7/j5pSE2Vl7IIA/ztapCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SQV6o8aQpmg=:aSUoySMBcSFw7S4d8Fn5S4
 owrQKGQU1l6FagNPVob/wxdgz/yvOR5Rqpv06YTqT1wOULGkzLofIr8TFgl7jxnmYyWzGqqJE
 HPP4wA874zSnACKg9icOZAAERZyHHOGTloFbF5UGj6VElP9mb1KfzyizXBJSgPoxo0OHF+/h8
 yJnp588nRYrLEXA6n96w/KpW8n5vVOJheccJFcaiSbK2jhBeuB2e/7eGkaejRkBtH57yyQ8Z6
 4rFMP1egg9S84sab229lBOWFtqzyqizkt4AIDgfvClCIfsPLT0dZ6VL1l7ex7vKYKHSF5xr81
 n1BJDaz1nrXdPyUkC4rvTkivSZGpcmxqTzcWDVQWRWakZRfuABivgYf10Tr2WcR3120tihC7y
 vkw0ElR7faQ/py6sW8eqXDwfP6rA7UYpYScCVoXyjMTd9D4B21mrdY4XW3+Aeucn6Oqor9pxV
 n+UNdBzmujGCUvg5En6xmhVRk26KspAt5HfxK5SyHPGL+YiwZ44wQUfRSb6p5rkZlHwc2XO/W
 WEAYCsvkoBOK6xOjkOQB7rHyOFTWZ2xDrH97svyHauPoERPiw76XR+HgsvNhk5UhzfS8QyYfu
 K2y77xYnCFTCc+NfgeE58qGkl7Fq1FLtIkfb75nONoAnbiTWE4oYzBF4GWGS5/Ur85tjXeEGx
 yrCVYh+v6ksuflD81UcD3UzBl6RFMUMMs2xGipI/SfH6mjisYIBbkNJyIoF4+bV5tBEDn2I3H
 u5/uLMWjRvEguAi2EZALhdZs4wmopo5yuuC/rA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-8 warns during link-time optimization that the strncpy() call
passes the size of the source buffer rather than the destination:

drivers/scsi/qedf/qedf_dbg.c: In function 'qedf_uevent_emit':
include/linux/string.h:253: error: 'strncpy' specified bound depends on the length of the source argument [-Werror=stringop-overflow=]

This changes it to strscpy() with the correct length, guaranteeing
a properly nul-terminated string of the right size.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/qedf/qedf_dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedf/qedf_dbg.c b/drivers/scsi/qedf/qedf_dbg.c
index e023f5d0dc12..bd1cef25a900 100644
--- a/drivers/scsi/qedf/qedf_dbg.c
+++ b/drivers/scsi/qedf/qedf_dbg.c
@@ -160,7 +160,7 @@ qedf_uevent_emit(struct Scsi_Host *shost, u32 code, char *msg)
 	switch (code) {
 	case QEDF_UEVENT_CODE_GRCDUMP:
 		if (msg)
-			strncpy(event_string, msg, strlen(msg));
+			strscpy(event_string, msg, sizeof(event_string));
 		else
 			sprintf(event_string, "GRCDUMP=%u", shost->host_no);
 		break;
-- 
2.9.0
