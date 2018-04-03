Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbeDCVPI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:15:08 -0400
Received: from gateway21.websitewelcome.com ([192.185.46.109]:30954 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752246AbeDCVPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:15:07 -0400
Date: Tue, 3 Apr 2018 16:15:05 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Zhichang Yuan <yuanzhichang@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddeodr.com>
Subject: [PATCH] lib: logic_pio: Fix potential NULL pointer dereference
Message-ID: <20180403211505.GA29612@embeddedor.com>
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
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f3TGk-000W7v-7B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.54.187]:53752
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

new_range is being dereferenced before it is null checked, hence
there is a potential null pointer dereference.

Fix this by moving the pointer dereference after new_range has
been properly null checked.

Addresses-Coverity-ID: 1466163 ("Dereference before null check")
Fixes: 0a7198426259 ("lib: Add generic PIO mapping method")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 lib/logic_pio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 29cedea..30dfdce 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -33,8 +33,8 @@ static DEFINE_MUTEX(io_range_mutex);
 int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 {
 	struct logic_pio_hwaddr *range;
-	resource_size_t start = new_range->hw_start;
-	resource_size_t end = new_range->hw_start + new_range->size;
+	resource_size_t start;
+	resource_size_t end;
 	resource_size_t mmio_sz = 0;
 	resource_size_t iio_sz = MMIO_UPPER_LIMIT;
 	int ret = 0;
@@ -42,6 +42,9 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 	if (!new_range || !new_range->fwnode || !new_range->size)
 		return -EINVAL;
 
+	start = new_range->hw_start;
+	end = new_range->hw_start + new_range->size;
+
 	mutex_lock(&io_range_mutex);
 	list_for_each_entry_rcu(range, &io_range_list, list) {
 		if (range->fwnode == new_range->fwnode) {
-- 
2.7.4
