Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754196AbeBGAAK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 19:00:10 -0500
Received: from gateway36.websitewelcome.com ([192.185.188.18]:34431 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754148AbeBGAAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 19:00:09 -0500
Date: Tue, 6 Feb 2018 17:36:17 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ACPI / CPPC: Use 64-bit arithmetic instead of 32-bit
Message-ID: <20180206233617.GA30829@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1ejCmg-002f50-CM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.4.238]:36844
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix ULL to constant 500 in order to give the compiler complete
information about the proper arithmetic to use. Notice that this
constant is used in a context that expects an expression of type
u64 (64 bits, unsigned).

The expression NUM_RETRIES * cppc_ss->latency at line 578, which at
preprocessing time translates to 500 * cppc_ss->latency is currently
being evaluated using 32-bit arithmetic.

Addresses-Coverity-ID: 1382602
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Notice that another option is to cast NUM_RETRIES to u64 at line 578,
but as there is only one instace in which this macro is being used I
think adding the ULL is just enough.

 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 06ea474..0afbb26 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -119,7 +119,7 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
  * to PCC commands. Keeping it high enough to cover emulators where
  * the processors run painfully slow.
  */
-#define NUM_RETRIES 500
+#define NUM_RETRIES 500ULL
 
 struct cppc_attr {
 	struct attribute attr;
-- 
2.7.4
