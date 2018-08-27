Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FC1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AA72174E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="qsSTXArL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AA72174E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeH0MKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:10:23 -0400
Received: from mail-sn1nam02on0067.outbound.protection.outlook.com ([104.47.36.67]:23753
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbeH0MKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yvprez3azRSi1qUZTkuWZTzIjc29OUayx4JB5SrF0mI=;
 b=qsSTXArLzFiEQMs8TXi6Be+X3lm6XVc+9b49vWK7o91k9JXjg94w1qbDOYRFx2fW+14havvtz0t+zWj6E5dLhJKg0DCw3/Ywcp7AgyItVXaOeefLHpTHBa6dKYYYUtJbTvShXCm1rAKenvnHhuwzvvfkTtbwuXt70eSPNtP1CSA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1576.namprd03.prod.outlook.com (2a01:111:e400:526e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Mon, 27 Aug
 2018 08:24:38 +0000
Date:   Mon, 27 Aug 2018 16:21:35 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 1/3] mmc: sdhci: add adma_table_cnt member to struct
 sdhci_host
Message-ID: <20180827162135.46285a72@xhacker.debian>
In-Reply-To: <20180827162026.3901de27@xhacker.debian>
References: <20180827162026.3901de27@xhacker.debian>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR0101CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::24) To BY2PR0301MB1576.namprd03.prod.outlook.com
 (2a01:111:e400:526e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e0d59fb-6936-4f9b-7aa3-08d60bf6886d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1576;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;3:vbQn9cG/t1Ibfkup3B+bLEK7XvWPA0uHATLw7BlYtfs8JUnx66g2aGkg4SkLANG6zaIjU26/NR2GOSwUt2iN0ALNUm6gojP8tCE+Ti6cYpImRggfQcZJp/PDnC72AnFDg6tG+D3heHkw6nO7qZ3CbD79yf/wN7TRZ0yn9StnfH3BRUNQsq1Ll+pAaK3p2NuqDcSWo72xpJ3dcWBBtFxYM4BfSXrwTE/f27qvkaQvbvnoBLepbW9Lul+u1X/hN3nk;25:eRihxTRPRoF/F4/x+e53O1j+EuO+BroIFZgfddD+auTz1s8A6uG+wGMzVpkRd4XzMdN0c6VTZVRJqJzMirHLtYW/n9tfnTt2hj3vgVz3mC9kj2Vi3kyokebtxp1trDVTEK/RNKb3C+MuQYpDK0MlZlmmBQAlq/xWtdZgjvhvVQ4Yq140sKbLSbwWZAnB/zT+DeB1cwOd3ku3hDKsbNrWuXgVdtiV9NkOBxpuXUSpUomec77G63WOQrHOgiTVDNznDgtmjHqUdKShQEa2WFW/cTcb39P9Yd1hEfW5cWoii9IjKh3cU33w9SN4QahP9Suz9E35RtajmSplmOaTFaZsmg==;31:4uDgECUJSyyjqvBc6LMeBuUSmluilGs3fFDyDj89n0Zkt1h2gumpeNtGVTKnQNuN+Jr9/PLaRrsTa/yLtCj6Q7wJmzX6tYz0KULCWcCs+E5/SCJSJSTNfqpG7ct9SAo0JwBfD/HnDIVxKfxtJf6odVAwKgDw/ZEzZ+UHQnc/1NelKhIhqXtYv7MhME6KbYzPZ9r+qM0KHY/VGVj8WUAuOLeYy4H/P2JEoP+nmcuzldk=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1576:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;20:/l/ZD4bmYOdLehqnj0jSedE1nqKh1W8gGwD+ejwswndJT7++djXTS4Go8lhMWao+ljzIEnYu9rIqtxTOHeyDuxp0Yr3XZEpV07YZZRQC7aWrj5q9rEbrS0FpINiypclgd5U9dyPA0pmq0hVTuAxiqK/fVqif9FcLFqY8wXzRFUu62oYyQfnYwcTA1E3aDLuLwKkQtR5Xu+uFLwmkMufMxchhY8U77YFC6t7NDKvs1mp7ffJG3UsCfQ1Oa6SpzDDRxTzJgwAN+FcOZtWnnddQAYPXchl/LLI1zyi7kEr1BGSifz57jMEV4rl5tRrou/aARDHac3xTbldM9Hs1OAWVTf5vRIMtyFKSUr1ADTLCEXcyh+JKjRWnJmWZ9fyHNx0ntaJ5zjAnY7EKUKHxIt9PvfNTgM1pocHJ3wIxdIl4G4tUcneF2jIiu3ic1uH/kTZ9t1Apl2yTQKd/kOuakrx95M3LdTgW8Lum0nalP7D7SLdbXQjeNlbYRPgKlzPJIxkS;4:HCQl7JCpaVYYG28pppDrtrrm/1Vz4SbFP+FbaYU3ZfpQU3GU22Zw3a6J2aiExM9x2sVX0+ppCgEWpZlTH6kqQK+0LsDLhQ5xb/8kToj2c10G1ObMb6SA5/MOnhaEvPYow8HSy/E8epZ0PfcK0sd3sbKjlQLajI58HcJG3TBsBNGEVhd6v1GTK04uxjuMb5IxQ4Ee/TM+WqghTVNvrZ0YNGr7FPZAEdr0R66vk5Iai5RxB6x9O847XAjjvWxjJF5DYn/ppBsbuDUbTCESUPFLSnRlJ+khBG0+lHR84FA3itzCNs1EkksQDs5zP5kom9fx
X-Microsoft-Antispam-PRVS: <BY2PR0301MB157648968889AD20D3926272ED0B0@BY2PR0301MB1576.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BY2PR0301MB1576;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1576;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(189003)(956004)(50226002)(8936002)(66066001)(476003)(11346002)(446003)(76176011)(5660300001)(6506007)(386003)(33896004)(7736002)(305945005)(81166006)(81156014)(8676002)(575784001)(26005)(7696005)(52116002)(2906002)(68736007)(16526019)(186003)(86362001)(23726003)(1076002)(230700001)(3846002)(6116002)(4326008)(25786009)(6666003)(110136005)(72206003)(54906003)(55016002)(50466002)(53936002)(486006)(47776003)(9686003)(478600001)(97736004)(105586002)(106356001)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1576;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1576;23:6bZFRffa1HNdiz+Bt6VXBtmM11MaE+7HvJfnMAk?=
 =?us-ascii?Q?3H6jlfDMxUIRsSRmXCITz1jHEg9YubRY4wuzwR6QzAcCuKLjfZixgXVBa1wM?=
 =?us-ascii?Q?YFJ6CLKBMv6IHWrz8Eyn7laV6QYAhgifUMEha6xroTEH/UJx2zB+x6mIa8uQ?=
 =?us-ascii?Q?Tif/nsV5zWXHnxq+/JXxvP7ydHEqWELb/Px53BmMdktQ+0g3iYCRZxwFM4pA?=
 =?us-ascii?Q?/z9Ghg8uWHx5ae8NUv5PBh1Oo9RnAEoSMebN2OQjwpLyilGdctMC/yFEiwle?=
 =?us-ascii?Q?HZPRtgfLMRbVBCVLSj2/AvjGBmKAswWNkjbPod4SgfbYokwWNdL+0Ah1lOIn?=
 =?us-ascii?Q?dG2hQBelynfLTg0Z25xLpInCBb8uVqVdXYJbW26Ro3Kft2Ks01xNDJIbW+e2?=
 =?us-ascii?Q?k5W+rYNmMaNX72ReSXpByHnjSoYBgw3EJA0gBFBxmvax5RXEzp9XqRuo71jd?=
 =?us-ascii?Q?piMUMtFUaR/W24hEhnoETZ8/T7VrsHjcwPKeeXd629SJZ/6e/ZtDN6IsBNce?=
 =?us-ascii?Q?iFZqFCyqh3iQ0+86JUzqW7VaYYJ2g3fQPX582KLXtIteWs6S/Xs4KoYz+77g?=
 =?us-ascii?Q?gN57G4+qHxgEW/hJq62CxXUgLn1eY4DvmWexoFgJR3ol1c7D/jvlohT64baU?=
 =?us-ascii?Q?03f30X5colNla0OFGgqw2cqXFjZqu2wgo8NPvrIAUUjIvD5fafdcox6zewpk?=
 =?us-ascii?Q?aEJOhiTPj7RfNg8nM+grvKx0k2PL6V3SM6DnD9inx/rJvJCsQjqIIudzDG3g?=
 =?us-ascii?Q?im7bba1EQNmEdhgpYzNoFma0umdxh5lID3uAu12ITA6ltjhMudOLhJb4WRVe?=
 =?us-ascii?Q?tut+HYznWTHv57Pvhn1C8XQqqYVXAYF9h7dWbSHVTykWbCS/eZ5EOAeZkIhq?=
 =?us-ascii?Q?gfS+asrVAIdqUU+aqEOUMtThMvODVc2rrnxSk0fFdYHx4idh0nd3HZ5XB5IO?=
 =?us-ascii?Q?NweLzat3qrwkUxVOE7/GbOBfjGX0tWILXMXe/1pCew/qyya/WSofh/uVtCs7?=
 =?us-ascii?Q?8yquUsIXFgM1tAB3fFS58VFRCzQNL1kBEvWPzsROpoDwtZ5F1eZgRbkULA54?=
 =?us-ascii?Q?EiZsWCiujk9M841yasR3IYdegfjCMtPgXOQuGeT8pbK+nyoC3or/kklnXdIV?=
 =?us-ascii?Q?7DK39lyUoj9CO/Cf4vI9ybxrHmVaxFdD7oWiRQ0dmytrD0VDxc8fgDF28CXv?=
 =?us-ascii?Q?L9vk01+/1ZiyMvqq7YWHDZXrdHatyWMRGhp0Jjbc3AJWyXRFkbyQ6Dq1Vip8?=
 =?us-ascii?Q?N41KDGTWI9k62lbP6d/4AUq4P/+Wov7Z/kA8Anenh?=
X-Microsoft-Antispam-Message-Info: nMfYY467iNs6h8FfE9mrgrZDJjHV8m9asNH2oUZifUz+wd9h0heHapTAzQZqUMzl9JrZKuYrlwqRkHNQMnr6X7ZA7flC5T+wpQnaM1cqtzh0T10GDj6TRaUQFDC7yAJg+jB/T8CeME4ev8MV0KMj66fodGQoiSSR7mYUnsey1akyA5EWv/OZnulU+qVcaPUFhvd2/Xq3HYVf82YuQkktl+lIvgNByjC00HG4aSA/W0QE3eUYqXFMJ1XwzNyJTsFvMEoOUjx620wHZDFkjPkdarx/tJTz0Ec2Y5/fqjqV2G/usyriwctVgIO2vVsc8p8o/i/6T4cML0RqDoXRqUhyhvXOzKAStDV9LTIog+a4+As=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;6:ji/YnkC5tOP9vVhkmxF0L7X4KH7rSZ7WY7KA46gZPKsH+TwjvL0wuNifM0Qy8k3T+6ZMtCNzG2QlVfbXkmfrOOMe2bV3KXb+WpJmJFvcDbn3EZYtCiuCaHZZ+6KYQ868TVKRVCkwf+LrHVZHnBqKy/lHhyCa04NVZ75uSuuBy+xWfFcX1+VnBPj+8kGTXghkYHDxlQXLeDv6PF0zvxUbJZvHcWCMbXbtDaL9d2KuNEUr+QVkkLzdcTgsqEMRUUu9ckXknLreME7ZSX8Za8xUIgEHyYwHr81iGjP9UPSyimMFc7bL+FbBSNYSyQQfuPwUavGOiPVuLIVQ2HN0ULe64QvojUnTNqUPG8PziL60b3gdxdWdTQzRuJFZyxgpmlo7SUu6SnJEEvGygSznQYd+pDBP3LNyRW9yhWv4uX0KNqe+YOQPCDV1nMJtxm9rhQ2WYJhR8qmKveKCy/ZAIYx8Ew==;5:wRfAOp9Hj88L+Ixi+sqf2HGkHfih/gKoSmfLg1eNgFIqG2yr/XS2QMVdw+mdKjB+yZ537++zVivIZz//ZEjoUSoQj1MF5ZfWy34DHuRvzQkS8hngIWuLXgcuydmij2hvyON3CqIauZctmmGM5GnOsmeF+jTuytHgjM3Uti/dalc=;7:QvkPqZecM4koT3ouTbPjgngJdVdhOWsMPJIJ9++y+Kn2v8XycRX/WUCMdPxSx7SVMeWJvl2rbXy77P2otQx55kynFY5DjyGpwZXqxVPeg8+9yzM1ygluRO1Eg3UP5fw8Y7Ax11fOMnz6k4wWeaiF4ztmYQM5rcG+KopBFIpi7E8LcSKYFqbvxcrDr64R96mKlODk/LRDjB/1Tkc0wpeQUracYutxZfz+YVaJzh0AUEgn47CsB7cEWglkaCqmiVeU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 08:24:38.1347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0d59fb-6936-4f9b-7aa3-08d60bf6886d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1576
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds adma_table_cnt member to struct sdhci_host to give more
flexibility to drivers to control the ADMA table count.

Default value of adma_table_cnt is set to (SDHCI_MAX_SEGS * 2 + 1).

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 17 +++++++++--------
 drivers/mmc/host/sdhci.h |  3 +++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1b3fbd9bd5c5..52ccf4644384 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3322,6 +3322,13 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->sdma_boundary = SDHCI_DEFAULT_BOUNDARY_ARG;
 
+	/*
+	 * The DMA table descriptor count is calculated as the maximum
+	 * number of segments times 2, to allow for an alignment
+	 * descriptor for each segment, plus 1 for a nop end descriptor.
+	 */
+	host->adma_table_cnt = SDHCI_MAX_SEGS * 2 + 1;
+
 	return host;
 }
 
@@ -3567,18 +3574,12 @@ int sdhci_setup_host(struct sdhci_host *host)
 		dma_addr_t dma;
 		void *buf;
 
-		/*
-		 * The DMA descriptor table size is calculated as the maximum
-		 * number of segments times 2, to allow for an alignment
-		 * descriptor for each segment, plus 1 for a nop end descriptor,
-		 * all multipled by the descriptor size.
-		 */
 		if (host->flags & SDHCI_USE_64_BIT_DMA) {
-			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
+			host->adma_table_sz = host->adma_table_cnt *
 					      SDHCI_ADMA2_64_DESC_SZ;
 			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ;
 		} else {
-			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
+			host->adma_table_sz = host->adma_table_cnt *
 					      SDHCI_ADMA2_32_DESC_SZ;
 			host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
 		}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f0bd36ce3817..25bddd21de31 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -563,6 +563,9 @@ struct sdhci_host {
 	/* Host SDMA buffer boundary. */
 	u32			sdma_boundary;
 
+	/* Host ADMA table count */
+	u32			adma_table_cnt;
+
 	u64			data_timeout;
 
 	unsigned long private[0] ____cacheline_aligned;
-- 
2.18.0

