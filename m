Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbeC1N65 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:58:57 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33189 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeC1N6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:58:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Arnd Bergmann <arnd@arndb.de>, Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: use upper_32_bits() instead of bit shift
Date: Wed, 28 Mar 2018 15:57:47 +0200
Message-Id: <20180328135817.2419127-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:uhTqNyD2djmP1hvlgj9jPl37qyystXsGJq8fU5qfj6Wjcv3lw+5
 iVzw4Avz/51weBVUd9jeySFRKuyaDwhhiqJNtlDEycCeXI/rj4htRPMyxrdle0brjHB4cQv
 6gCDMuDR80lRS4auz/ismvxgsX61Kce63yLaxwK8l3VcP6ettcURWKet1MheSFJKzn+PYqX
 ScwW/wxJU3pzt5lpL9Ybg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2hayUn1pZfM=:QBkPu+zZ2ix2RbO+9JLcVc
 Nbu+eX+ujkjqvaoiYq62VKevVeI6nVyfKOPwpcSfbLv60SIXMybtVvw83M2uybRZjh3Edn09u
 Jq3RLtnAdH5Lbj887P02Kf0SG8XRPL0D2GWekZvdF8GZGwyyxt43Atgt2uMzvyEAQSWQYmIUD
 5OqYT8wn9c6XEx7GiM5ASJW3yHHfwNjF4Aegf+yMu7/OekYtKEqRWYO8tLzo2YlTwZ4yKSMzM
 FgBL/PHLvHGj5IstdwOP7N+G14xk6whNv9nBSw8rkre2XTQYyB/HDYkZR0MjRK1X0HtWNjWPH
 r9+SYncp8dclE5b6We+BBDfNCsSY96n8Ko27seuT90KNSeWsWUsiPxGJE4T+J/Xd2gb3i2ReC
 vxgIbJgCB8+fnVzI9AZG2l18L2bKns57Qt2EmcZWZhuNO/V+lEeJG2TqfawyvIhjGXaRoRtaq
 SXIMWKnjIMh2tPE6rmBGhLoAqud7DE9isn2+vOvJ9XR2mnQLlqz6PPxd4O77/KAH0qkwXD1fz
 oFvD92EaQMQKxu/lzjfzZn+A31i0tduEwhksNU9hrhqgqizGqR+bEAgXfSdB9whG0mER/uEoL
 DiiJ/75NWt42Lq4K5KJ6LwyvDk+gaCdCev1cMPwCyi3QlLPGxFMPM8E3+Qofgav+b9tI+oqNz
 JTQZ+vPEQxS0uESChl0lJAuz3Saq768CEEIE1potLmAB9tmnolci9ozftCCIkuYdnnyYzot7G
 07gTEhfa//yLUcQgo1ZHAF+UeQvYeZr6+XMvRw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit architectures, we cannot shift a size_t by 32 bits to the right
without a compiler warning:

drivers/nvme/host/core.c: In function 'nvme_get_log_ext':
drivers/nvme/host/core.c:2237:43: error: right shift count >= width of type [-Werror=shift-count-overflow]
  c.get_log_page.lpou = cpu_to_le32(offset >> 32ULL);
                                           ^~
include/uapi/linux/byteorder/little_endian.h:33:51: note: in definition of macro '__cpu_to_le32'
 #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                   ^
drivers/nvme/host/core.c:2237:24: note: in expansion of macro 'cpu_to_le32'
  c.get_log_page.lpou = cpu_to_le32(offset >> 32ULL);

The code is correct, but using the upper_32_bits() and lower_32_bits()
macros that were introduced for this operation makes it easier to read
and avoids the warning.

Fixes: 70da6094a646 ("nvme: implement log page low/high offset and dwords")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4e4136bfc37f..0a81704b763f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2233,8 +2233,8 @@ int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.get_log_page.lid = log_page;
 	c.get_log_page.numdl = cpu_to_le16(dwlen & ((1 << 16) - 1));
 	c.get_log_page.numdu = cpu_to_le16(dwlen >> 16);
-	c.get_log_page.lpol = cpu_to_le32(offset & ((1ULL << 32) - 1));
-	c.get_log_page.lpou = cpu_to_le32(offset >> 32ULL);
+	c.get_log_page.lpol = cpu_to_le32(lower_32_bits(offset));
+	c.get_log_page.lpou = cpu_to_le32(upper_32_bits(offset));
 
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
-- 
2.9.0
