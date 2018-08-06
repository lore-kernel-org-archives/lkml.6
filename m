Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C888C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA7A21A0C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="SD4ojhiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA7A21A0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbeHFOPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:15:16 -0400
Received: from mail-cys01nam02on0073.outbound.protection.outlook.com ([104.47.37.73]:24215
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732150AbeHFOPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP7+9wxnwQZcsSWY6AaRkPidNFShvSQdTCkoPg6D1Q8=;
 b=SD4ojhiw+fpEIpjIJteGvLaYaKJhNtUNFRtIDcUZTlL2eEoSGJkVNGN7I+pXXAC/sOzAj0FygFzMriGBFUjgp9L7lGbGRNMQQ+ZC07/eABzBNRuVD2qcfb65pw7eHYkS+4mtetdeGgg6ua2vFXaiqe054pe/Zc+PvjR+LFj/vtU=
Received: from BN3PR03CA0077.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::37) by BY2PR03MB553.namprd03.prod.outlook.com
 (2a01:111:e400:2c38::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Mon, 6 Aug
 2018 12:06:25 +0000
Received: from BN1AFFO11FD013.protection.gbl (2a01:111:f400:7c10::168) by
 BN3PR03CA0077.outlook.office365.com (2a01:111:e400:7a4d::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.14 via Frontend Transport; Mon, 6 Aug 2018 12:06:24 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1AFFO11FD013.mail.protection.outlook.com (10.58.52.73) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Mon, 6 Aug 2018 12:06:24 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w76C6O8j012795
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 6 Aug 2018 05:06:24 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Mon, 6 Aug 2018
 08:06:23 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Crestez Dan Leonard" <leonard.crestez@intel.com>
Subject: [PATCH v4 3/6] regmap: Add regmap_noinc_read API
Date:   Mon, 6 Aug 2018 15:04:44 +0300
Message-ID: <1533557087-10401-4-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(438002)(189003)(199004)(72206003)(478600001)(336012)(48376002)(7696005)(4326008)(476003)(2616005)(50226002)(11346002)(446003)(316002)(44832011)(486006)(7416002)(51416003)(8936002)(426003)(186003)(26005)(77096007)(5660300001)(126002)(16586007)(2906002)(305945005)(110136005)(54906003)(246002)(6666003)(76176011)(7636002)(356003)(8676002)(106002)(36756003)(50466002)(47776003)(53416004)(14444005)(106466001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB553;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD013;1:w/GF5PnO3IXfyikbXje2IusulNJ1n9HwqnijV52mgHB9mcFwTlPR+Wqdg9mGcgOxl4N9u5sNpHpRvgZwSnwyDopt+boKpOsO9NoSfEq36WoV8849NpgGSm68AAYpFtt8
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79159893-1782-469e-cf0f-08d5fb950834
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;3:DMkBdDvKx5H7fnQ6hyyOuOvxkY1qB4M8h102qBSV5sPryVf/QgHk3psS9vrAqHjkh7xZKA9t44dFOZFvYLE3rB3+kuvwhAnjKFUYVibaVmtc3+iYj/GnOYNmhG9mIyZ9RTp4d58VylVfesZxnNnVv3CkSnTlIBnO3EPTgm5vvWSBUWc9IuKE2BGn6bLi1wLOLZY15L5W3Xro7COxUN14Y5l+AANogTJvW+gF34Psjy7AcNIEZ20DYB+J9aDoIrpPhKknmFVp2ZgKDhzAaoJoTrLbXEAQqsCmR3NYAIY9Y4XVJ9ieDsPewMmyRu8uNVvxL6AV3jh2TMuGhS+9ELL+Cm+34MkSFAf09fJ3wUifJdo=;25:3u8D7XXf7VwJtJcYZN5fs+803qgN/wvK/Q/u7biirw+7Iwdyui/uAqP/CXjadV77P7N74f5R/2fbKhOY85ZJ9i2w/luxtkpTc2e4loZKYTkYGrpy3qGQW2cJgyQujea8HW+GAgAHjaoH1dvS2BPSPUlpwwp7Q+6Z0hZGu+vY0hysMWrirkP7xboHrvmyAJ9Eaq6yynTRU9GmLbky/4NlPtzxp4vDGrCmBQo2TMaC1pLGlrE12ICytajM7Bow/h8ay4+gHR+syJb42QLHv2AngOGHC+sYV18TbdpbNVsluVh6oWeOMzyrkXXhQ1QKfgembfCoKqn5+LmL6wfARn+sDA==
X-MS-TrafficTypeDiagnostic: BY2PR03MB553:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;31:z57DOCdKakpHRqFH+fmSg81GGA4sBR1laoprV2Y+ylnS0BBhG5XGPmwgDOITqfVCCJNfDoUs3Vt2/2er7UbgxhBBHb55SVmbw0RBZQVHj4RyThJRdck14r7zLzXVZ0bggWWal08hPYdvn8cCh1tAAFN2ti2V6iatbTwPvtX2Ps8yo5MD/8UkOYej0mzATPXt678TLGOsimJc2A8rZlcP8/66f9afl8a+L7OSeAMFBbI=;20:NYXwVyhagdHzGIfpq5m6q8JdKcBy71TP4OYHmG0/sF8UqBkCgvf1zYTUpjqPJlDCkxwgRU5qyecYwWeVYab0a35lTOEnPdeHMMAeVT8iqlzeT0Oird5X2eX2wDOyNMCbDgAwfzDD12xmfeYmL8eAb4/rPra5IkGTW18JSQjDq3qNdihEfgm9ZRR8zTeJ0Lg6KmAjDm/ad0BQwAFkFmqCNftJ73QTpz/q7ufVKXDCHK4U+QAjUvApYrtgi9vNEdNw+UGOEWVoKT+DZTBRJYp1ZUOKtmCLm1wKJ42NuXwzKZXq87SiWUqH2nlJmWmTZ4r6mRYj9e8TTYM6HzP3yhcwmWqqM5PNUOuxgPZYocvDRYVhDDymNkgr86PJzzYuwJLTjzzOW0k5wbH8kIFowBpaZI313GGSj87ziCmmp0b9eLMIM1l6pr0O7JqoqOTZTqRvaDZyEO8mqoW71QNRgbukx0pU6wo2ZGL7M/rHgYEZBBWicW4u6D5rX71G8l6QChIj
X-Microsoft-Antispam-PRVS: <BY2PR03MB5534C0DE33E9DBD19FCBA769D200@BY2PR03MB553.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR03MB553;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;4:cFmoIzc1PyIv/RkeCGrB1r3vnaZMdint0CCsjs662CNPsk2Sy3+ohrP+0xepwkEfyjIyawZHylXtYw8lLoQ59pjlW/IHwTXCl2weV4GRQ8/a7ECJ4moLGfSgQjASrctyIWONPXnzz7kP1FUKsoK/vv5RCRFGROgLBfLlDQ1GlJizo3ZSfm/EP1o+MaquRHrKgkSp0I4WhpzWzoyekRQQ3GmsAA3DMGOM75by5ZbDNOvjGFnFzzIauTpS1r/uoy9Sv80uLj+msCBdzgRnDHz05TyJFnt8NULqsnlUtRZshowAehI499v0oP/5DxQbD9vpziaDNerxRuipJjUKIcbpRDRE1wcHtDHyBUEniA2lczo=
X-Forefront-PRVS: 07562C22DA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR03MB553;23:rGU7dtZDrNUh6/tTXav67RiBSbCpkT2tSXDJfuFEPm?=
 =?us-ascii?Q?4KG3AkkpmxXqaC/ji+P7CJyNCE5k/8Cirq8+D0E4VmZhMuZqn2/PstnMI4Ia?=
 =?us-ascii?Q?7jEu4bKTVglbg5YRpZ68735N74zc1OAFLXBJXCrd544TDcnBdIo6n237Ins2?=
 =?us-ascii?Q?wNI5TiqMb5O5JVKObuQReDKijnIqIjfyyChxfP04rhVoE9MMCmx2iGpgXGjN?=
 =?us-ascii?Q?s8a8YwPPwfQTMaNaE3Orx9IaQ3tGBuavgFy7KWUuIcwlgRwQTWHOgUpcEdx2?=
 =?us-ascii?Q?QtT8ljHnz8tEiNhiNm48qmk/amjFSBppqDIrJGM/b1Qd7/2hiYhizzn6TSDA?=
 =?us-ascii?Q?p1xa4lWyEOftJRV0o8mAv3IasvcM1YbrHmjqa+ex6RotfbYzzdg1bGzwwh4o?=
 =?us-ascii?Q?livbbM3n1i5pyQw2o9MFznf62+WKMhMowW7xgZPw7tyPevO145nbW/nSWAts?=
 =?us-ascii?Q?oX+VTmSrawczTCBwaNN0IkUjNm7b90KAujXz6TOl66uO06f4ZHnB0ZbJ8NU9?=
 =?us-ascii?Q?BpRlfXLhDHOPBVrm/NeWpAsYbVOqUmTEzP5dz1ULdgXU5QEg9ywbKDeRyIz+?=
 =?us-ascii?Q?FEXzN/Y0KtJGib82eYeJ5LnnJ7A3J2kg5URcEZN1xbJPBMS4njjdGVzrRZSe?=
 =?us-ascii?Q?2hhvZmE2W5+wcwiBXKyGtAQ4YY4IaSWucWelbkr1FBKEnkbk+h8C5L1+K327?=
 =?us-ascii?Q?iOeqkesV0FyfwERC2xT7PJS++D8dqgxahj9Lcwiz5HInwgR9rnEiPwqhFw0T?=
 =?us-ascii?Q?RHOllgYDybD5fOYJ1K/B7h5npPQfCjAvNAAS9WL56+plQmBiomiBxIJf10uO?=
 =?us-ascii?Q?VBYgtcsZBMU6cYFELHNCw5qP8lyc4UV0MdnIkRDDJQudI/7VUQ6UWybuI1iy?=
 =?us-ascii?Q?fikpKVoxHkTR1m+HK94cAHrd0mqBMAzjpbcGudv/d6CPLxNNdUMo5Iv9C3/K?=
 =?us-ascii?Q?LsSLGeWkNhWbuHugZiv8uuAgVc9Jbx6gN67TLgTFb+uhAU+qKbf1+4Azi1RL?=
 =?us-ascii?Q?mo7qlVpuDH9JtgF7CDUJz2TEHsy2T0T85gqyge0Bo6xFWL/I88/69OLAg2Hs?=
 =?us-ascii?Q?WBD1PF17+DZ/Nww/0O26bNXNm4569G+r70VKpsZFX+DUk1ketezdSYTHy7O2?=
 =?us-ascii?Q?aHg+9YYGw=3D?=
X-Microsoft-Antispam-Message-Info: qL0f6jYXTYaxx9W7z3U0S1JEDS1IsJBXwnrtAH6FhmxlTLMrQAJCUhiFECCooN8qJ/o5aks4R0+6p/XCgcMDoFCp6IvpNkzJDB4bkQ94AjqeCadHhAFd8fyAxsTVOb45SGlclcnQBUpzRMq9AEcTybNmeUgxjFDS02/8rBGltg/YHSmlwgWdp7ggnwPNAzWQr7s+kghGuoxnWGESunE+EEpd/XhRlEtOe86uRAuc50uv4oBIkGxP2qUC/sqVUtyZ8yC29Mc/XVGoXJ4dtGjoEzwuwKWYldT2Df+xhGM7fHwi1qUpMmpSp/VKK0CkeYCgZk1Ad9Vw/4oeJHqPqAWK99ejrwZdwNFf3n0pUf1tvwI=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;6:I7PDYWmlkGz7ydxD/53keD9GwnWfirUALthJwwCyaduzsypcKPIh2jlFbBs1BqG4N7rAA1fzd4IFl2iIh6ji4RteLeminklYzKHBPUdYH+bfROvCO5H6NdrrlzGaBdz2TztfqSswqQ0aPlUh7UVATrd/HYHDKujUHXlYt79NlAJqEfckcaFpp+Zk/QiMbuY3KfZHirOu1VK/Ga0lHq0GgjNF/hpLAt/ONri/fB1iy3b9jNNlAtax3NMn6ieBjcCfBNYn9jMf0w7G5gfCd/zSwnKy2bcEIO6RIFgcQ8Wwj/RcMA/JxflgiKGzBMuXIXUx4gvn6YlDvdVKNLL2nUFn/G5/iB58e0GONIDBstvijpGdqizTCnA8i10rl8iyBgv6QnD3Kn/hUzvTdoIbLeyGYG7xxkWr20J6dlg3vW7cDzW6mKC+gwr7HBcviWIlk60JlRoACVt//pLOG404oIDTig==;5:cD1DL4edO1xy5Kza19ya2WtMBPJF53iU0y4/gqA07JPkIO5sbK+czSJAT3BfcMrpOXriCg3MmL0KXuxLA2xYvJMgoX6BBcKNm8FkODipgvGG+PC77mm0KNHRLKng1p7aAMRSIXzHyaQ0NYs99jbowYWktRagD8ANwWG4pCmnqgM=;7:JPwO44nNTB+uennaorgMGcmgzhZ0fZsJJ0qmL5gMBLwNHmpQUspiFQADJ93aWBXAasicsrj+2IMuDHzgothEW1iy7oN44pHcX9hmZ1KCAWY8udZfqXapAu0loTVi8l8Ru75XQhgSAVxphNj2k75cR8ASSMtSOMiigUc5AidHxzAGEYmLWi3I+xZu57nDuu3Y/Lufsjl2pPmihDoUbvbmMQfyNfKc7bXAFPtHvD/N9yWOtX+dInEBS/zgcmccxeaF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 12:06:24.7139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79159893-1782-469e-cf0f-08d5fb950834
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB553
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crestez Dan Leonard <leonard.crestez@intel.com>

The regmap API usually assumes that bulk read operations will read a
range of registers but some I2C/SPI devices have certain registers for
which a such a read operation will return data from an internal FIFO
instead. Add an explicit API to support bulk read without range semantics.

Some linux drivers use regmap_bulk_read or regmap_raw_read for such
registers, for example mpu6050 or bmi150 from IIO. This only happens to
work because when caching is disabled a single regmap read op will map
to a single bus read op (as desired). This breaks if caching is enabled and
reg+1 happens to be a cacheable register.

Without regmap support refactoring a driver to enable regmap caching
requires separate I2C and SPI paths. This is exactly what regmap is
supposed to help avoid.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/base/regmap/regmap.c | 65 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/regmap.h       |  9 ++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 3bc8488..e632503 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2564,7 +2564,70 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 EXPORT_SYMBOL_GPL(regmap_raw_read);
 
 /**
- * regmap_field_read() - Read a value to a single register field
+ * regmap_noinc_read(): Read data from a register without incrementing the
+ *			register number
+ *
+ * @map: Register map to read from
+ * @reg: Register to read from
+ * @val: Pointer to data buffer
+ * @val_len: Length of output buffer in bytes.
+ *
+ * The regmap API usually assumes that bulk bus read operations will read a
+ * range of registers. Some devices have certain registers for which a read
+ * operation read will read from an internal FIFO.
+ *
+ * The target register must be volatile but registers after it can be
+ * completely unrelated cacheable registers.
+ *
+ * This will attempt multiple reads as required to read val_len bytes.
+ *
+ * A value of zero will be returned on success, a negative errno will be
+ * returned in error cases.
+ */
+int regmap_noinc_read(struct regmap *map, unsigned int reg,
+		      void *val, size_t val_len)
+{
+	size_t read_len;
+	int ret;
+
+	if (!map->bus)
+		return -EINVAL;
+	if (!map->bus->read)
+		return -ENOTSUPP;
+	if (val_len % map->format.val_bytes)
+		return -EINVAL;
+	if (!IS_ALIGNED(reg, map->reg_stride))
+		return -EINVAL;
+	if (val_len == 0)
+		return -EINVAL;
+
+	map->lock(map->lock_arg);
+
+	if (!regmap_volatile(map, reg) || !regmap_readable(map, reg)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	while (val_len) {
+		if (map->max_raw_read && map->max_raw_read < val_len)
+			read_len = map->max_raw_read;
+		else
+			read_len = val_len;
+		ret = _regmap_raw_read(map, reg, val, read_len);
+		if (ret)
+			goto out_unlock;
+		val = ((u8 *)val) + read_len;
+		val_len -= read_len;
+	}
+
+out_unlock:
+	map->unlock(map->lock_arg);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regmap_noinc_read);
+
+/**
+ * regmap_field_read(): Read a value to a single register field
  *
  * @field: Register field to read from
  * @val: Pointer to store read value
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4f38068..ddaa5e6 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -946,6 +946,8 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
 int regmap_raw_read(struct regmap *map, unsigned int reg,
 		    void *val, size_t val_len);
+int regmap_noinc_read(struct regmap *map, unsigned int reg,
+		      void *val, size_t val_len);
 int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		     size_t val_count);
 int regmap_update_bits_base(struct regmap *map, unsigned int reg,
@@ -1196,6 +1198,13 @@ static inline int regmap_raw_read(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_noinc_read(struct regmap *map, unsigned int reg,
+				    void *val, size_t val_len)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_bulk_read(struct regmap *map, unsigned int reg,
 				   void *val, size_t val_count)
 {
-- 
2.7.4

