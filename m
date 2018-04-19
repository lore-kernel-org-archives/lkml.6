Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeDSEEm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 00:04:42 -0400
Received: from complete.lackof.org ([198.49.126.79]:35384 "EHLO
        complete.lackof.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeDSEEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 00:04:41 -0400
From: dann frazier <dann.frazier@canonical.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lin Yun Sheng <linyunsheng@huawei.com>
Subject: [PATCH] net: hns: Avoid action name truncation
Date: Wed, 18 Apr 2018 21:55:41 -0600
Message-Id: <20180419035541.6318-1-dann.frazier@canonical.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When longer interface names are used, the action names exposed in
/proc/interrupts and /proc/irq/* maybe truncated. For example, when
using the predictable name algorithm in systemd on a HiSilicon D05,
I see:

  ubuntu@d05-3:~$  grep enahisic2i0-tx /proc/interrupts | sed 's/.* //'
  enahisic2i0-tx0
  enahisic2i0-tx1
  [...]
  enahisic2i0-tx8
  enahisic2i0-tx9
  enahisic2i0-tx1
  enahisic2i0-tx1
  enahisic2i0-tx1
  enahisic2i0-tx1
  enahisic2i0-tx1
  enahisic2i0-tx1

Increase the max ring name length to allow for an interface name
of IFNAMSIZE. After this change, I now see:

  $ grep enahisic2i0-tx /proc/interrupts | sed 's/.* //'
  enahisic2i0-tx0
  enahisic2i0-tx1
  enahisic2i0-tx2
  [...]
  enahisic2i0-tx8
  enahisic2i0-tx9
  enahisic2i0-tx10
  enahisic2i0-tx11
  enahisic2i0-tx12
  enahisic2i0-tx13
  enahisic2i0-tx14
  enahisic2i0-tx15

Signed-off-by: dann frazier <dann.frazier@canonical.com>
---
 drivers/net/ethernet/hisilicon/hns/hnae.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.h b/drivers/net/ethernet/hisilicon/hns/hnae.h
index 3e62692af011..fa5b30f547f6 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.h
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
@@ -87,7 +87,7 @@ do { \
 
 #define HNAE_AE_REGISTER 0x1
 
-#define RCB_RING_NAME_LEN 16
+#define RCB_RING_NAME_LEN (IFNAMSIZ + 4)
 
 #define HNAE_LOWEST_LATENCY_COAL_PARAM	30
 #define HNAE_LOW_LATENCY_COAL_PARAM	80
-- 
2.17.0
