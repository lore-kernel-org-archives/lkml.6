Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5501C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B6022360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="veWJFzSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B6022360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeKNCOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:14:00 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51580 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKNCOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:14:00 -0500
Received: by mail-it1-f194.google.com with SMTP id m34-v6so19039577iti.1;
        Tue, 13 Nov 2018 08:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S8QvpyH6vUJ9Ri9ju8TQWAdaKiouWlPS/lDPTbT+PcM=;
        b=veWJFzSi7zzDYP0N5gGrgN7RHJVNkh5OOr1GAGdadeBo4Plj9spouhqgI5C7QZ2QQ1
         h1FyL33F7EVxmTffcbFOL9ena0HckX60qJmU6EOSWwXeKh23GSjzFtpDYG7B5BmFv+dU
         hr/sx7PT/plkwOoiR+XGEi4YCvcr9jushw34XuhC/3qYSP5W3JIdKlc0SQ0XYhnB1ai0
         yjBYVpNvoNFgR3Q1Hu8JyYS0vNp1Jt1VjWVmN//2PDpckk4zZVctpjLM4z4rLG6Gs5A1
         v+beOO1a10kQFYCU5CO5pzwymoBJYvv+bPoYSTODXotiNIQfcqIEz/oQQ3YnqvEaKuGt
         +oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S8QvpyH6vUJ9Ri9ju8TQWAdaKiouWlPS/lDPTbT+PcM=;
        b=ZJdEN1GpeNoG/PVsU+Vimfqye0hKM1aAMCJPhTYITQ//grj12USdvXqLzED9Mr+HBs
         SrQgZfRpWh9hamfpCM7TmrEfr2bNOmTGvI8Bq5CrP949PDqTX3VFaj9NcMAHQVg4t9q6
         IKtG/3r4PMt8eUyLkgjoJxwr9M/bH81SKRy1v3tisD5PeX66KD7tAxaLGeIlfAnBSwm4
         fGPB2pEubxfiKPNfFxUxD0L/oH5DrmDMGg3VqSGN3EFME9MLELyAJT04m/NN7c/k4J4k
         cQnass4E78GpaRogVjpnFuAIEw4imxIvKhZ8SAhYBj/pgsH80XP4vkMHDWpKGeKmb3kb
         Hu1Q==
X-Gm-Message-State: AGRZ1gJGuSPDsIiEr6VOFt3X+PRXX8fLtX2bki7vScfYbFAS4ZUHAk7r
        zhPsvoR75I0SJcl+aDd3AKI=
X-Google-Smtp-Source: AJdET5fKTBjO1eTziipn6RtGKaHtAE7d59Ga1pWalOmv7ec6P3Xq+l82/TB9thK6h8MQA4SGPvPGQA==
X-Received: by 2002:a24:fd09:: with SMTP id m9mr4170118ith.81.1542125714330;
        Tue, 13 Nov 2018 08:15:14 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id q16sm2316495iog.62.2018.11.13.08.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 08:15:13 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, arnd@arndb.de
Subject: [PATCH v1] tg3: optionally get mac address from devicetree
Date:   Tue, 13 Nov 2018 11:15:08 -0500
Message-Id: <20181113161508.7427-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the tg3 has a device node, and that node contains a valid
mac address property, use that as the tg3's mac address.

This behaviour was previously only present on SPARC, using a
conditional compile (#ifdef CONFIG_SPARC), presumably because
at the time, devicetree nodes for pci devices only worked on
SPARC. However, this has recently been made universal, see
commit 98d9f30c820d ("pci/of: Match PCI devices to OF nodes dynamically")

Devicetree example:
(see Documentation/devicetree/bindings/pci/pci.txt)

&pcie {
	host@0 {
		#address-cells = <3>;
		#size-cells = <2>;
		reg = <0 0 0 0 0>;
		bcm5778: bcm5778@0 {
			reg = <0 0 0 0 0>;
			mac-address = [CA 11 AB 1E 10 01];
		};
	};
};

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 89295306f161..b60381a70454 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -55,6 +55,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/crc32poly.h>
+#include <linux/of_net.h>
 
 #include <net/checksum.h>
 #include <net/ip.h>
@@ -16959,23 +16960,21 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
 	return err;
 }
 
-#ifdef CONFIG_SPARC
-static int tg3_get_macaddr_sparc(struct tg3 *tp)
+static int tg3_of_get_macaddr(struct tg3 *tp)
 {
-	struct net_device *dev = tp->dev;
-	struct pci_dev *pdev = tp->pdev;
-	struct device_node *dp = pci_device_to_OF_node(pdev);
-	const unsigned char *addr;
-	int len;
+	struct device_node *np = pci_device_to_OF_node(tp->pdev);
+	const void *mac;
 
-	addr = of_get_property(dp, "local-mac-address", &len);
-	if (addr && len == ETH_ALEN) {
-		memcpy(dev->dev_addr, addr, ETH_ALEN);
-		return 0;
-	}
-	return -ENODEV;
+	if (!np)
+		return -ENODEV;
+	mac = of_get_mac_address(np);
+	if (!mac || !is_valid_ether_addr(mac))
+		return -EINVAL;
+	memcpy(tp->dev->dev_addr, mac, ETH_ALEN);
+	return 0;
 }
 
+#ifdef CONFIG_SPARC
 static int tg3_get_default_macaddr_sparc(struct tg3 *tp)
 {
 	struct net_device *dev = tp->dev;
@@ -16992,10 +16991,8 @@ static int tg3_get_device_address(struct tg3 *tp)
 	int addr_ok = 0;
 	int err;
 
-#ifdef CONFIG_SPARC
-	if (!tg3_get_macaddr_sparc(tp))
+	if (!tg3_of_get_macaddr(tp))
 		return 0;
-#endif
 
 	if (tg3_flag(tp, IS_SSB_CORE)) {
 		err = ssb_gige_get_macaddr(tp->pdev, &dev->dev_addr[0]);
-- 
2.17.1

