Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELsAd8z54uLkVsHQ5iru2vhpuHpIesfetHzi1vs6QO0JYmCPGpU6Jnx7QZHV66zZdaG41ddq
ARC-Seal: i=1; a=rsa-sha256; t=1521215341; cv=none;
        d=google.com; s=arc-20160816;
        b=FGnR9q86FdMuDpYKzwUbi3kB5lLXG0UpgPZ8AKy38HdkWBd0bmJTjIJdlTcQfRJEgO
         9gtBwa9OiMuY2kche/pWEQ7j5beFnB+dxV4qIwvEch3czJTcXwcovDxWeUfgsQsDy58W
         X9AEJ47plZm+BzyX5ZmmZvGsZE6ixxXjdtH4AV/15CQrJ4arNoDE1uh12mvRkCtubWgo
         zeCgUS8/ZAQMhsseB5NykGdvY+5L0uE2SpTrTwxkjcWhf7vyLt8/n2fhZEJZ4Jw1N9JE
         60qftHr9P37Ct0D+oEUOvYmKOEcBm5GuB0QtUiA42cKaXqw/sb4lngUnO5H+/h98tSrp
         C7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=lZVuHHhC+13V9POSc1MvwQ6pVMrqydkL5QxEgOrODn4=;
        b=FQ97A/i/ruEbf0/mv9t+MY6CQEYht24nYNgsahDT9bbtDVI3nHvRI75cwwQqKf/45C
         zaR0QjJq9RdaPxRRMfFebswNwPoTyoxVlewHrF7N7li5VrQi9qdtKWcV/qQzP1YjGgCd
         roNnUFXsw9wtS9+X5OQjuzXCzZf4CQTNoT/AEqI+W63ND+Z5W58v3jLxJt9WVc3UW1OP
         apC6jWca5RvZxJ5Em1TRsWzkd8u81hzRrR0pzMCYDFFRDClt9C++a+ZBxZ8y4umBE9MJ
         ja2+D2uaBn4tXUFO8J25W3wp4YvauouGWGd8aB0ghAdcJoZ6sgi1vGONqFwMlx6FEcyf
         dWHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-ntb@googlegroups.com,
	linux-crypto@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jon Mason <jdmason@kudzu.us>
Date: Fri, 16 Mar 2018 09:48:52 -0600
Message-Id: <20180316154852.13206-10-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180316154852.13206-1-logang@deltatee.com>
References: <20180316154852.13206-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, jdmason@kudzu.us
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v12 9/9] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines to use the common header
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109897682706061?=
X-GMAIL-MSGID: =?utf-8?q?1595109897682706061?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clean up the ifdefs which conditionally defined the io{read|write}64
functions in favour of the new common io-64-nonatomic-lo-hi header.

Per a nit from Andy Shevchenko, the include list is also made
alphabetical.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 36 ++++------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index f624ae27eabe..f403da24b833 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -13,12 +13,13 @@
  *
  */
 
-#include <linux/switchtec.h>
-#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
-#include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/ntb.h>
+#include <linux/switchtec.h>
 
 MODULE_DESCRIPTION("Microsemi Switchtec(tm) NTB Driver");
 MODULE_VERSION("0.1");
@@ -35,35 +36,6 @@ module_param(use_lut_mws, bool, 0644);
 MODULE_PARM_DESC(use_lut_mws,
 		 "Enable the use of the LUT based memory windows");
 
-#ifndef ioread64
-#ifdef readq
-#define ioread64 readq
-#else
-#define ioread64 _ioread64
-static inline u64 _ioread64(void __iomem *mmio)
-{
-	u64 low, high;
-
-	low = ioread32(mmio);
-	high = ioread32(mmio + sizeof(u32));
-	return low | (high << 32);
-}
-#endif
-#endif
-
-#ifndef iowrite64
-#ifdef writeq
-#define iowrite64 writeq
-#else
-#define iowrite64 _iowrite64
-static inline void _iowrite64(u64 val, void __iomem *mmio)
-{
-	iowrite32(val, mmio);
-	iowrite32(val >> 32, mmio + sizeof(u32));
-}
-#endif
-#endif
-
 #define SWITCHTEC_NTB_MAGIC 0x45CC0001
 #define MAX_MWS     128
 
-- 
2.11.0
