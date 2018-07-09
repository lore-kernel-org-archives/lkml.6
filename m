Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276F4C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69C920881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69C920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeGIMXT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:23:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35691 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbeGIMXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:23:17 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fcVCD-00073J-O7; Mon, 09 Jul 2018 12:23:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        linux-wimax@intel.com, "David S . Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wimax/i2400m: remove redundant variables ack_status, bcf and protocol
Date:   Mon,  9 Jul 2018 13:23:13 +0100
Message-Id: <20180709122313.14483-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables ack_status, bcf and protocol are being assigned but are
never used hence they are redundant and can be removed.

Also declare ack_type as unsigned int rather than unsigned to clean
up a checkpatch warning.

Cleans up clang warnings:
warning: variable 'ack_status' set but not used [-Wunused-but-set-variable]
warning: variable 'bcf' set but not used [-Wunused-but-set-variable]
warning: variable 'protocol' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wimax/i2400m/control.c | 3 +--
 drivers/net/wimax/i2400m/fw.c      | 3 +--
 drivers/net/wimax/i2400m/netdev.c  | 2 --
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wimax/i2400m/control.c b/drivers/net/wimax/i2400m/control.c
index 4c417903e9be..cfb0bf3b4426 100644
--- a/drivers/net/wimax/i2400m/control.c
+++ b/drivers/net/wimax/i2400m/control.c
@@ -566,13 +566,12 @@ static void i2400m_msg_ack_hook(struct i2400m *i2400m,
 {
 	int result;
 	struct device *dev = i2400m_dev(i2400m);
-	unsigned ack_type, ack_status;
+	unsigned int ack_type;
 	char strerr[32];
 
 	/* Chew on the message, we might need some information from
 	 * here */
 	ack_type = le16_to_cpu(l3l4_hdr->type);
-	ack_status = le16_to_cpu(l3l4_hdr->status);
 	switch (ack_type) {
 	case I2400M_MT_CMD_ENTER_POWERSAVE:
 		/* This is just left here for the sake of example, as
diff --git a/drivers/net/wimax/i2400m/fw.c b/drivers/net/wimax/i2400m/fw.c
index a89b5685e68b..e9fc168bb734 100644
--- a/drivers/net/wimax/i2400m/fw.c
+++ b/drivers/net/wimax/i2400m/fw.c
@@ -1552,7 +1552,6 @@ int i2400m_dev_bootstrap(struct i2400m *i2400m, enum i2400m_bri flags)
 	int ret, itr;
 	struct device *dev = i2400m_dev(i2400m);
 	struct i2400m_fw *i2400m_fw;
-	const struct i2400m_bcf_hdr *bcf;	/* Firmware data */
 	const struct firmware *fw;
 	const char *fw_name;
 
@@ -1574,7 +1573,7 @@ int i2400m_dev_bootstrap(struct i2400m *i2400m, enum i2400m_bri flags)
 	}
 
 	/* Load firmware files to memory. */
-	for (itr = 0, bcf = NULL, ret = -ENOENT; ; itr++) {
+	for (itr = 0, ret = -ENOENT; ; itr++) {
 		fw_name = i2400m->bus_fw_names[itr];
 		if (fw_name == NULL) {
 			dev_err(dev, "Could not find a usable firmware image\n");
diff --git a/drivers/net/wimax/i2400m/netdev.c b/drivers/net/wimax/i2400m/netdev.c
index a654687b5fa2..9ab3f0fdfea4 100644
--- a/drivers/net/wimax/i2400m/netdev.c
+++ b/drivers/net/wimax/i2400m/netdev.c
@@ -535,14 +535,12 @@ void i2400m_net_erx(struct i2400m *i2400m, struct sk_buff *skb,
 {
 	struct net_device *net_dev = i2400m->wimax_dev.net_dev;
 	struct device *dev = i2400m_dev(i2400m);
-	int protocol;
 
 	d_fnstart(2, dev, "(i2400m %p skb %p [%u] cs %d)\n",
 		  i2400m, skb, skb->len, cs);
 	switch(cs) {
 	case I2400M_CS_IPV4_0:
 	case I2400M_CS_IPV4:
-		protocol = ETH_P_IP;
 		i2400m_rx_fake_eth_header(i2400m->wimax_dev.net_dev,
 					  skb->data - ETH_HLEN,
 					  cpu_to_be16(ETH_P_IP));
-- 
2.17.1

