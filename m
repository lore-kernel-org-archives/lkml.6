Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeBBNND (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:13:03 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:52581 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbeBBNMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:12:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Johannes Thumshirn <jth@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] scsi: fc_encode: work around strncpy size warnings
Date: Fri,  2 Feb 2018 14:12:15 +0100
Message-Id: <20180202131225.1658853-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202131225.1658853-1-arnd@arndb.de>
References: <20180202131225.1658853-1-arnd@arndb.de>
X-Provags-ID: V03:K0:dz8PWAnrvHGNo9daKGFlUcYqCoVYuoWYUOMtFcbnMQBPU9c86Jo
 w0fkQ/pjpPOF/DX85KYhKQhESxyxv3BA2FFIvE+MAY8umP/7CPXtXXLeRyfU4VOeovpExOs
 NJqpUDcYA04h4QhZltCYvbUnMrSt8zh3vPI5Ery/HfzDIh0+wluegoIWQ35fPkO//Dlw7NH
 boKEZYnZjk+RYsHVnMmtw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FhCeIQgWm3I=:tQgb50UJ3E7LBP/syMLpXp
 3TktEnVx67yolLqPNlrtaUq97y2cAD7yaigo4j760XiaPMemiAz9QDMQKTsU5aapE/GMbdQZp
 5LYFKf2VgjD7qT8Ol7vZpWVZA+F1cybUGeTuSI83axwgyEp8zSu8DLjkiSCUhrNeiBRyuE10v
 BWeWOFocvlGhnQ7XXJhmLQIW+cvhqRMcVO6DkXLHRyhzEgLLT4RL0HIvELK98MIPfwYr+OETt
 6VGtstnbojD32hptGpABemxv579qmGRbE0c3a4riGl2oCooPANjcsQFEX4xRMQaO93mBcPrY+
 Pz/m+IqoMnHV5pr50FiBRos/F4jyp8xsfcVdAsCJ2TMJQJEaZnx04Py0O7NlRY3WVw8hbh8+4
 1vkzSrtuWEszs/5O+0wuWcEbtQaBxVBNtRR1Ss9Bkr76rfg0jdM9ER60GZ1GqbDMOh/7CJDtZ
 TxBUeY9mG7udsIMLtdxvvDgtYcYjYGJo1mHOwjrIuDwB9c9avNRPNEWFpH8HqMUGahd5zOy0y
 eSohg5Sm4EMvEIHjMSMsBocdndWyvhwcXJYcx/J9+U8kwsGGUxWOnWduIggF1/B3K0Wbjdtkn
 cBAWq2+zbueDLqikYAer37MDEZAko6+zPizZT0Q53mykExIqvpwthOsmao2kxFNKTOPNWuhAx
 ALCA7bRj6baO56SOERIJ5g66p7+wKhKYEPv7X/nKMOLUEbRXVWQagY9fZgB1a18FI6BjPG3n4
 BVMHDFln6pCNO7Q6qx5vPAhunUosnvnBmvqIMA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct fc_fdmi_attr_entry contains a variable-length string at
the end, which is encoded as a one-byte array.  gcc-8 notices that
we copy strings into it that obviously go beyond that one byte:

In function 'fc_ct_ms_fill',
    inlined from 'fc_elsct_send' at include/scsi/fc_encode.h:518:8:
include/scsi/fc_encode.h:275:3: error: 'strncpy' writing 64 bytes into a region of size 1 overflows the destination [-Werror=stringop-overflow=]
   strncpy((char *)&entry->value,
   ^
include/scsi/fc_encode.h:287:3: error: 'strncpy' writing 64 bytes into a region of size 1 overflows the destination [-Werror=stringop-overflow=]
   strncpy((char *)&entry->value,
   ^

No idea what the right fix is.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/scsi/fc/fc_ms.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/scsi/fc/fc_ms.h b/include/scsi/fc/fc_ms.h
index f52b921b5c70..c5614e725a0e 100644
--- a/include/scsi/fc/fc_ms.h
+++ b/include/scsi/fc/fc_ms.h
@@ -128,7 +128,7 @@ struct fc_fdmi_port_name {
 struct fc_fdmi_attr_entry {
 	__be16		type;
 	__be16		len;
-	__u8		value[1];
+	__u8		value[];
 } __attribute__((__packed__));
 
 /*
-- 
2.9.0
