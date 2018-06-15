Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7FB25C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221B3208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="vpyDW3+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221B3208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965638AbeFOKPs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:15:48 -0400
Received: from mail-db5eur01on0122.outbound.protection.outlook.com ([104.47.2.122]:4422
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936200AbeFOKPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc/Ij307McYNnnPTMfV7aW5xaTXhjoq3iSvfr48+vFM=;
 b=vpyDW3+UjiKWkW3f5lq1nFDsU7cBr1bHkLJtllxJH/8GXhaOVPcY3GVDmQROgcCdf7CD8JQ5P4164CjZPSeGPY6yGMwqGjefRlzxF12apj0/RuEq3Inw3w2u/A3Vizfs6kgTESl52A11OfKWIM96NasK+cFqISR5bMf8YE2bhcU=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 10:15:35 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-integrity@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 01/11] i2c: add helpers for locking the I2C segment
Date:   Fri, 15 Jun 2018 12:14:56 +0200
Message-Id: <20180615101506.8012-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180615101506.8012-1-peda@axentia.se>
References: <20180615101506.8012-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0248.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::24) To HE1PR0201MB2460.eurprd02.prod.outlook.com
 (2603:10a6:3:82::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cff5233f-799d-4daa-9cd7-08d5d2a8f025
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:TieJXHXZMysRsQQEVq0JaCdyzudLA3Bb/Oq9vZRLqiShKxztXAtG0702IN7eNud0vzMNGxKo3P+5scblH+IBhc3pVBESAqp/0EiIZC7iVuQiuC44cQzrfuFvNqlEEBamCT/3rxJeJwTT7AVigex7DjWPGCM/lOHSuDOcdq8/w393zP9qu7e66ELC10cM3LTGg2C+C+y1Q5YIFzkfX6yuUY0xF3HBE5KBPWgzMtiMa5RQUAOlfaygdSXC/Xrpcmqn;25:nHzDB2QoPQQiHEH6u8eNM90QP2PP0/yE1G6uN94bDhC9nWkHIvZkbiQMu2D7XqxLbg58b2BhXu3jKHBhat2hLOd9VG5NRmsHapUodE7EcQVRBygLuTmWkc/3jXFmmJTAyywxhCOncwRBgCIE7NIeZ5DtPXNU42+tBbqN14RcvQHtMZA4bd90fQLz/iyyoWae3ezDJAXO4jykUzLSWcYAKCnr63hc4nbWt0totoGIG40Kq1/mdw0bMqN8D1YPHVcdXtOvsCsPItOhjIdOHgAqYPNGLv3zrWUM1AC13ZG5PePARLMWoKoKoh83Cq9HsHrJQ94n15KGalZpDqduH/hhVQ==;31:1UEUdOX4QVjaawqka1YuSDAfijDed50Pkb+v8JiCDz+/b/6VRQqMFovemlhUFMZojaAiG7uNQ/hvF971ftCIBN1IHHGiChutYnX6yQvjg5D+GBe44VXxMCU6ycYhmmt4uuIfD4NV2f9tmjkf9VpNT2GylYbh2jD4FSVcblVlSFA+kv1TmrXaoPkSPWk60tyZTckRkCVmQZCE13xGPFRjmvmDSrKU722Pys3t63FP/JY=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2460A3A7CDCA84E302B32DF4BC7C0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:XYESamtUUWyXNfQWuSrCcEUnoOQ6ojJG87Tlfiys+zaCj1+XhXHEqTGcKKKhH0foIMyB4L8PmE85nHcyIMmiPwm0oSYTHI2OBcO4AVFfTf5uY3orHJUWCfwyFil85WdrbE3j5vZeVcxr6x6wbieahmBFd4voxEY2Rfj1NlDrcgZzXmPeULNzF07xYDkttbapc88e9/MLIDjnFVwUbmmNLcd9TKjhgvc2HcQuzSAgKQZjnYtZw4KZrKWzHRnYz3Wo2IaeCLXwpQGr3CLjG8/i+g==
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39830400003)(39380400002)(199004)(189003)(186003)(16526019)(97736004)(50466002)(386003)(50226002)(68736007)(81166006)(8676002)(74482002)(26005)(52116002)(6666003)(478600001)(51416003)(2351001)(81156014)(59450400001)(8936002)(6506007)(2906002)(76176011)(6116002)(3846002)(1076002)(6916009)(48376002)(86362001)(7416002)(7406005)(106356001)(66066001)(2361001)(8666007)(305945005)(4326008)(39060400002)(53936002)(36756003)(316002)(5660300001)(446003)(476003)(7736002)(105586002)(6486002)(6512007)(11346002)(54906003)(956004)(47776003)(25786009)(2616005)(486006)(16586007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:J58i3nDi3MlrpNP0i7W5E8+occVZa8cr3d5MKXW?=
 =?us-ascii?Q?3+g4Kv9kjVG3srykQ8qlycEo86yJz7vFFJOSjTkV7AwYp9hu4b1kuMkTZkVX?=
 =?us-ascii?Q?SniDrs5hglIpI/2c6xnNI12ci8DgZDEWaaWAPjNpSFnF5pv/s4+67ydx2xwN?=
 =?us-ascii?Q?2UXSe0WvAXJ/TWj7oSuSm4gP9OjrK5NMJXE14jeBJ2AiTXnLW3ej7Ub8H/nr?=
 =?us-ascii?Q?8qc/uSlX63DeUoOe1aOCpf4KJAXwVyWTEgcDeOAKzKldrYnhHxVZZh9u30Ri?=
 =?us-ascii?Q?U+xndrjf9nT5ZHgLcoFJbBf5ynIWLdgnJlfFqFVunchvdZDUZDn9nvW2ocju?=
 =?us-ascii?Q?Tq03/tF7YNto66it5VROKGrdUoKzHUneqgomSvhqrO7diu9B5IW6Vf6zRCkb?=
 =?us-ascii?Q?3oba2Wug6KZOAqe0UAmlVKGW4yraU74NLDfxAjA+0PbNbVtPi13mNOPOyQ3Q?=
 =?us-ascii?Q?lF41WSL9HimkR02yHXv3iuhcECeyIwItnvV0ZGhJOUWaJZuKgMXnTZA/41q3?=
 =?us-ascii?Q?pLZI1n7qPHveFcTvJ/gnTKAD4HtFPhQ1PK5HtCZQ71Ag1N/HxKLQ8JndMkv2?=
 =?us-ascii?Q?ZhhSDpVAFrloyjMI7RNudQeBgMYw/r0jOX4YRMnjpAugnoCmr8AFUPORpJfa?=
 =?us-ascii?Q?WCd7clnqZfAn/Sc3Xyb5Y0RZTMRJluevy3kmsIYo23/Kw02pyV5swn4T/+na?=
 =?us-ascii?Q?wjG9M35i0J+lv/ANC5g6Dxca7sEP9mDzLPQWIMi5+71l4/xhWNsTMgpnxntp?=
 =?us-ascii?Q?9eAx+rrYNznf9KZlI3TX1OGCEy78cQwcRGuYtOUs0csZMsAVwo+3ttRR0MCw?=
 =?us-ascii?Q?fjjta73kXk3WG81Km21nSdb4eLT2CC/MxuSxxd3zXrrphBcABOYZhojPZS8h?=
 =?us-ascii?Q?jJ8Dxfckcf/LTL5d1X8kqXGgRmeEnhGA+lvfxdnpwoezTSUv7HN+Qkqk+JJd?=
 =?us-ascii?Q?3zorpFCu+Hd71BF1xBzNZiBNuAL8AvpaOG4TSmI9q6d7+YXRSbpaUtpv0DdX?=
 =?us-ascii?Q?KFHYwshaleVLsQgSuwrI8EoXxRVRFWGB5NYoG2FY+IoYET3SOSl0t9phV/66?=
 =?us-ascii?Q?dqr5vO+dH0tnmyCC8kMCrAa7AeThnaWANpd3/Y3vcjawNdmrgcKHIHApIyt+?=
 =?us-ascii?Q?ZMJExl+1hBqcTgZwf3kXUmverXBhBeW7IpsGackSQpHij/jy1Erw1Yk9iGfU?=
 =?us-ascii?Q?sxcayFLm5m2UwWkAHfVgC+2jYgIHcbF4QMlK6tKxNTc8ct4SAyAFNxr8mwNl?=
 =?us-ascii?Q?qwb1nlQZuMkCoXtaEXM7sshE6i+tw9I7YWPBD3xAE7+cWWeuCD6AQ68bmCJe?=
 =?us-ascii?Q?ln5EsvWL5zYDJemLrAb2QelPJ92odrJUQbidZ/6gi4eldEdCTbvSBtu2SuIz?=
 =?us-ascii?Q?jJz/EcG+5pfDVYbQ1q9gFmFhIPOpVn2nRgwgTXGb9jRPdz/gc?=
X-Microsoft-Antispam-Message-Info: 8MQY/qhtYSInYqXe+mPTLFg4Un7ENvQrzo7o6mPdnVx250K87P9AgYundkxiX+6aBzzNGwEh58dZeBd6t2TBRh9y1RrMnQ0VKUPJSKMNCjib1muUHFwjoG5jwulIJLP0QRoJrea0zS/SG3XQVf+Eu9RwgWApiHybnAqMsuolo0mIfLG5tMpTXT/xrz3QmtOi
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:udcT7QWbH70TFCtnxxsF4beMUwWo7xKBKDutyfGjfBqYCSoOWsCFKS/YUEZDGVmZaUcOQ1ygIZqAf1n5/cKoSLf5a8TQcqRsXawTP3AQ5GVLKEXnV6FwxCQCpjzToqm7vFPxDhr9TnIgtfd3RjI15wotZ04rP2Xe5SAIX+trVCKkE37fENxLUYcorkcgvhSc2SAqJIlVgoUUG5jeIz/ZKjdp+4LkH5Tp9F/JbmQrEJtVCgQMy8/729cKGwTUyVCG2b8/hp28CjYvo99gDpKcGHJPs4vaT273hm3lfx+0PVGl6NayEaGzlqQcUv0i8lUupmuhFTWExGTp7YsAbCQkOHqkXvFwa3/0PXQDFrO/VIVS1g10K6Quw3FiiumlhYFQEVZ4sjALatklG3d1e+8zqVBip7CZv/DRZck2MRCCilpVlzyHuVLBDricBBBDcuBtOd1zYOfCU7gu1+9QCHi+tQ==;5:plyutoOjPagwmx1TsamGx2jdFxH0SRNKy4r6q4kZdV5W3cCLlQbr+/0QPMHT+Tiicuf+8eXDoPIel7V6/iJiUiy1cwkEh/Izm5tg5QGCWSXYdoun87T8lfOc3z+tZaG/hA/QZISjPOVD485I9tIe1NMgurpnuDn5T4GoF5i2X64=;24:683mjBIlRE+4aEouieRO+k0/HGaXBgCE2Jcqk3caU9EsGC29Nbcx8s0IC7CtzbiVSzQhPdt/ggR39z/lYs3YwST+eMfODHERkThAMyWys9g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:CaLRqAmWRoSbVHNoC9YX+sMD1RXqarRlAm6tlPWViAW9TGoe/X2uZWI4a+UDXdAqYxo88VLAW08ubs3phMxaOPwu7gI0gtQevAWyqqWvsG2sohCGj6LXUVlRwVnowfgkeUmidQLgMKcxq0+yOgU2WEUJgNMDEv9zL4VIngMkrWW8D62N4ky526ho6pmTwoeh01GbJgaFIszSa2BX9wY3U/D1IEdxtx8RKfkCpn0AvySVcVMWtAUzBaJ6oWu7a0+N
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 10:15:35.8441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff5233f-799d-4daa-9cd7-08d5d2a8f025
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is what almost all drivers want to do. By only advertising
i2c_lock_adapter, they are tricked into locking the root adapter
which is too big of a hammer in most cases.

While at it, convert all open-coded locking of the I2C segment.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-core-base.c  |  6 +++---
 drivers/i2c/i2c-core-smbus.c |  4 ++--
 include/linux/i2c.h          | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 1ba40bb2b966..3eb09dc20573 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1932,16 +1932,16 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 #endif
 
 		if (in_atomic() || irqs_disabled()) {
-			ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
+			ret = i2c_trylock_segment(adap);
 			if (!ret)
 				/* I2C activity is ongoing. */
 				return -EAGAIN;
 		} else {
-			i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
+			i2c_lock_segment(adap);
 		}
 
 		ret = __i2c_transfer(adap, msgs, num);
-		i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
+		i2c_unlock_segment(adap);
 
 		return ret;
 	} else {
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index b5aec33002c3..8a820fdef3e0 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -537,7 +537,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
 	flags &= I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB;
 
 	if (adapter->algo->smbus_xfer) {
-		i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
+		i2c_lock_segment(adapter);
 
 		/* Retry automatically on arbitration loss */
 		orig_jiffies = jiffies;
@@ -551,7 +551,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
 				       orig_jiffies + adapter->timeout))
 				break;
 		}
-		i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
+		i2c_unlock_segment(adapter);
 
 		if (res != -EOPNOTSUPP || !adapter->algo->master_xfer)
 			goto trace;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 44ad14e016b5..c9080d49e988 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -768,6 +768,24 @@ i2c_unlock_adapter(struct i2c_adapter *adapter)
 	i2c_unlock_bus(adapter, I2C_LOCK_ROOT_ADAPTER);
 }
 
+static inline void
+i2c_lock_segment(struct i2c_adapter *adapter)
+{
+	i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
+}
+
+static inline int
+i2c_trylock_segment(struct i2c_adapter *adapter)
+{
+	return i2c_trylock_bus(adapter, I2C_LOCK_SEGMENT);
+}
+
+static inline void
+i2c_unlock_segment(struct i2c_adapter *adapter)
+{
+	i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
+}
+
 /*flags for the client struct: */
 #define I2C_CLIENT_PEC		0x04	/* Use Packet Error Checking */
 #define I2C_CLIENT_TEN		0x10	/* we have a ten bit chip address */
-- 
2.11.0

