Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeCUBFb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:05:31 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.108]:36913 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751405AbeCUBF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:05:29 -0400
Date: Tue, 20 Mar 2018 20:05:27 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] Bluetooth: Remove VLA usage in aes_cmac
Message-ID: <20180321010527.GA16616@embeddedor.com>
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
X-Source-IP: 187.162.24.133
X-Source-L: No
X-Exim-ID: 1eySC0-001gCM-Hd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-24-133.static.axtel.net (embeddedor) [187.162.24.133]:24189
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLA and replace it
with dynamic memory allocation instead.

The use of stack Variable Length Arrays needs to be avoided, as they
can be a vector for stack exhaustion, which can be both a runtime bug
or a security flaw. Also, in general, as code evolves it is easy to
lose track of how big a VLA can get. Thus, we can end up having runtime
failures that are hard to debug.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
Changes in v2:
 - Fix memory leak in previous patch.

 net/bluetooth/smp.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a2ddae2..0fa7035 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -173,7 +173,7 @@ static int aes_cmac(struct crypto_shash *tfm, const u8 k[16], const u8 *m,
 		    size_t len, u8 mac[16])
 {
 	uint8_t tmp[16], mac_msb[16], msg_msb[CMAC_MSG_MAX];
-	SHASH_DESC_ON_STACK(desc, tfm);
+	struct shash_desc *shash;
 	int err;
 
 	if (len > CMAC_MSG_MAX)
@@ -184,8 +184,13 @@ static int aes_cmac(struct crypto_shash *tfm, const u8 k[16], const u8 *m,
 		return -EINVAL;
 	}
 
-	desc->tfm = tfm;
-	desc->flags = 0;
+	shash = kzalloc(sizeof(*shash) + crypto_shash_descsize(tfm),
+			GFP_KERNEL);
+	if (!shash)
+		return -ENOMEM;
+
+	shash->tfm = tfm;
+	shash->flags = 0;
 
 	/* Swap key and message from LSB to MSB */
 	swap_buf(k, tmp, 16);
@@ -197,11 +202,13 @@ static int aes_cmac(struct crypto_shash *tfm, const u8 k[16], const u8 *m,
 	err = crypto_shash_setkey(tfm, tmp, 16);
 	if (err) {
 		BT_ERR("cipher setkey failed: %d", err);
+		kfree(shash);
 		return err;
 	}
 
-	err = crypto_shash_digest(desc, msg_msb, len, mac_msb);
-	shash_desc_zero(desc);
+	err = crypto_shash_digest(shash, msg_msb, len, mac_msb);
+	shash_desc_zero(shash);
+	kfree(shash);
 	if (err) {
 		BT_ERR("Hash computation error %d", err);
 		return err;
-- 
2.7.4
