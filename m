Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03387ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2B120684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UekZQAF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2B120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbeGSNV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:21:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46080 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730191AbeGSNV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:21:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JCYB2F162888;
        Thu, 19 Jul 2018 12:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=++fiZEgIB1TGMQQmcdpOKsGFpvgH20TecVNYGoJQWAI=;
 b=UekZQAF8u5ECnKXR34lqdIudEZIGJHXrYP6axT0+nDY/oXKk9rNxWKFDba2iI2voa8ZF
 p2ezOJvHCn3lX5KqJ2iiS4IagtN+vvgKh08CcQp81/tceQ4IZqZWrTkguMdzLyjijcv1
 Etfl5burZHvXakLLwWYMZXbvP7PbwH6+zh49I8U/ldWbZKCjE+7bP7jMlqgsnQdivENb
 oU1KAsIJjV5DJqL5aEsrxYU8TPsTsEqED5yEN8GUkgPViOtSsMYsUDkBUlO78L8Yr47I
 7FGvxYO17KknlouarD93Fi9WPsv5fyt5zPdoyVg4WaIWDHlURuxP5YCJr1CavCGw6wPG /A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2k9ykc6w96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 12:37:37 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6JCbZoh010331
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 12:37:36 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6JCbXGj026171;
        Thu, 19 Jul 2018 12:37:34 GMT
Received: from mwanda (/197.179.115.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 05:37:33 -0700
Date:   Thu, 19 Jul 2018 15:37:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/3] net: add support for nvmem to
 eth_platform_get_mac_address()
Message-ID: <20180719123722.sk5fcih6pufy4wpd@mwanda>
References: <20180719082028.26116-1-brgl@bgdev.pl>
 <20180719082028.26116-3-brgl@bgdev.pl>
 <20180719084503.tfv6jllsukk2zv3f@mwanda>
 <CAMpxmJUgyB1hYi-G3KVxMsm0P+aKGuHOB8LSuH+bJbYfjengJA@mail.gmail.com>
 <20180719090929.arbysqo2bk3esoar@mwanda>
 <CAMRc=Mdu5CLA99p48nNFZBSFHBKiERzp-m59vKDDe5STjjKZNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mdu5CLA99p48nNFZBSFHBKiERzp-m59vKDDe5STjjKZNA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8958 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 12:06:51PM +0200, Bartosz Golaszewski wrote:
> It looks simpler as long as you don't add all the new routines
> resulting from this approach. I've just tried to quickly implement
> this solution and it resulted in much bigger and duplicated code
> (checking the validity of mac_addr, copying it etc.). I would prefer
> the current approach and would like to read someone else's opinion on
> that.

It's not too bad.  There is two extra ether_addr_copy() calls and one
extra is_valid_ether_addr().  There are two extra alen declarations and
one extra addr declaration.  The functions don't share *that* much code.

regards,
dan carpenter

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index fd8faa0dfa61..8ab7289a5069 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -54,6 +54,8 @@
 #include <linux/if_ether.h>
 #include <linux/of_net.h>
 #include <linux/pci.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/mtd/mtd.h>
 #include <net/dst.h>
 #include <net/arp.h>
 #include <net/sock.h>
@@ -525,7 +527,7 @@ unsigned char * __weak arch_get_platform_mac_address(void)
 	return NULL;
 }
 
-int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
+static int of_eth_get_mac_address(struct device *dev, u8 *mac_addr)
 {
 	const unsigned char *addr;
 	struct device_node *dp;
@@ -547,4 +549,82 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	ether_addr_copy(mac_addr, addr);
 	return 0;
 }
+
+static int nvmem_eth_get_mac_address(struct device *dev, u8 *mac_addr)
+{
+	struct nvmem_cell *nvmem;
+	unsigned char *addr;
+	size_t alen;
+	int ret = 0;
+
+	nvmem = nvmem_cell_get(dev, "mac-address");
+	if (PTR_ERR(nvmem) == -EPROBE_DEFER)
+		/* We may have a lookup registered for MAC address but the
+		 * corresponding nvmem provider hasn't been registered yet.
+		 */
+		return -EPROBE_DEFER;
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+	addr = nvmem_cell_read(nvmem, &alen);
+	if (IS_ERR(addr)) {
+		ret = PTR_ERR(addr);
+		goto put_nvmem;
+	}
+	if (alen != ETH_ALEN || !is_valid_ether_addr(addr)) {
+		ret = -EINVAL;
+		goto free_addr;
+	}
+	ether_addr_copy(mac_addr, addr);
+free_addr:
+	kfree(addr);
+put_nvmem:
+	nvmem_cell_put(nvmem);
+	return ret;
+}
+
+static int mtd_eth_get_mac_address(struct device *dev, u8 *mac_addr)
+{
+	struct mtd_info *mtd;
+	u8 addrbuf[ETH_ALEN];
+	size_t alen;
+	int ret;
+
+	/* This function should go away as soon as MTD gets nvmem support. */
+	if (!IS_ENABLED(CONFIG_MTD))
+		return -ENODEV;
+
+	mtd = get_mtd_device_nm("MAC-Address");
+	if (IS_ERR(mtd))
+		return PTR_ERR(mtd);
+	ret = mtd_read(mtd, 0, ETH_ALEN, &alen, addrbuf);
+	if (ret)
+		goto put_mtd;
+	if (!is_valid_ether_addr(addrbuf)) {
+		ret = -EINVAL;
+		goto put_mtd;
+	}
+	ether_addr_copy(mac_addr, addrbuf);
+put_mtd:
+	put_mtd_device(mtd);
+	return ret;
+}
+
+int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
+{
+	int ret;
+
+	ret = of_eth_get_mac_address(dev, mac_addr);
+	if (!ret)
+		return 0;
+	ret = nvmem_eth_get_mac_address(dev, mac_addr);
+	if (ret == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (!ret)
+		return 0;
+	ret = mtd_eth_get_mac_address(dev, mac_addr);
+	if (!ret)
+		return 0;
+
+	return -ENODEV;
+}
 EXPORT_SYMBOL(eth_platform_get_mac_address);
