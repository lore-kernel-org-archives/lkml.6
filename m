Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F18ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD00620874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="by28rvdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD00620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388597AbeGXP2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:28:51 -0400
Received: from mail-he1eur01on0046.outbound.protection.outlook.com ([104.47.0.46]:13408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388430AbeGXP2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LsalBKgUJZq44g9mzRM7yamMsL8K21LyTWwijZcFmM=;
 b=by28rvdpw427qjMHFcDrsLLXfaBHGr4vpAyyrFwKhf2hTbSDx4LZcTRyAqfD8De1N0bnwaURSgoXXDkMP1tXLA8fiozzgSrssr5KsIP98pBM6xLy23IQG9CFeZ3ZgG2Jqav2kQZ64cdKDU+EivhLO7F4yqtGzqQ2byuweX5EwUY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:35::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 14:21:55 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, ruxandra.radulescu@nxp.com,
        horia.geanta@nxp.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v3 2/4] staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl
Date:   Tue, 24 Jul 2018 09:21:29 -0500
Message-Id: <20180724142131.28970-3-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180724142131.28970-1-roy.pledge@nxp.com>
References: <20180724142131.28970-1-roy.pledge@nxp.com>
Reply-to: roy.pledge@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR0102CA0006.prod.exchangelabs.com (2603:10b6:805:1::19)
 To DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:35::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83d099d7-c832-4464-207e-08d5f170cff4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4490;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;3:1JGKwmhrI1SH2lEoggnaOttjJOQ5rZPU/XwtJ9PedCDnHyXj1dL2rkpCfhTdPJWdbELt/Q1iz4JaPioyNyEj6bofr0xMaziVIQhGT4QclLwCaLDqiWEJ/sTOOW1yg6t/XSrmXjgOXvXKx1VYYVlPXK8BuoSkZOREaECvn1bUOSCJxoo5BW12ojlP7pPhVEuG8YN3qevAe+GsBySs+5yDKekvlc41nxyEuv6WI3D51sd8RzJ4MnCszixwFLtU/HIA;25:t4iBvDndq2OTWZnPYYv3F5ckNmvvisQPVeGDUhSQweOtbVmJA9sriPOawwSFLZenzwAmc+O0PfexmMbrJITM8qq6S8yfbFqXGgCfDN2b6tkebeBIYksdjo94vlQK8q7YL3L59fuc1INhTEwmdbzi7hu0bJWJa5sHsSDEBpw66lQ+Kh3TJDK7RXXxxMd/LA+kHxVGFsE7i0okiIe1EuO14ColGNYGjPDLqF2m20qPj3rvciYwGBwVwepdf505HfLorHxFRN+FDzAZadYikrQzfTP2wYsI7clVvuM3IA2rzJWhqB3MI6Nm4vPgRH0BoyB8hCl7mk9i2BVh/QaIvcuvKQ==;31:ab8MXcSGEYR7EBW873RG6EK1KjSwY96oRNJ7xWha2sfhDrOskMCwHkOPeZ7mD388lug0Y68u7tGRUNmA9t4C4BwTmqJsI1tLKF6RdQioUEmTBE0jpVILcjl/fv1ZZrgYJMyjDIvJ4c6AwblKTK1z/PdgPMARqelT/D4V1Hoq7WFhP68J9OApSaix285KVmMrS62tR7gEQ0qWAPfL392P0zH6eJN7EXFSQsUdd33q2TA=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4490:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;20:/JbaNriTxGFxJwUmgaGzzTAY58FL9vkubDoKS7tIJNdxWZyAxsyAQdCNLkusFo5vYJBRVsB+WZfJdvYjntHaN093ghiKnSgKyVBVVQx3xbMBxTbJU92YTYs6On8AmhYVuEkEzbBH3HfU7txofzsRBaCIsmVhf9SgawHjf88K7K7OGQmyyaVcGaz9VCNuIRX5HIfLLYkYBRC0bX8ur4GP5vUfuABLw/s4xHV8nL6wz559NksBnb5CINdWab4WCtcM/Emzg4kxF6X9gCljavhgk7t3Ke3ruwqWUvQRQay08Lqd8zIevWxtSjLw6qmZbtLlSQqdD1GylauYAMlCHb5vqH0r8BfCxEF7Ost8NwwYagUvX19MIJXGJfXsbkPe6gr8DjG2+GXHFPa2BAn7gIWJKSHi6ySuMweC3p/Go1yyKrnOUvhrTdUENlM7z+aG1ky6lDmUyWPYtpDzEQ6FgEMAeyxirLYKa1fr+etYkzBLFYVVvbSZc0McUvGRqMHbYmom;4:E7IoLdJMLlNziTMCIzv6dMehDhuLYhp55gmjwMw0oV6wFHQ57gknG8rffFZeSTIPMIxhAfcnBSD45d9eGvtTK3JY+ey4F+OOiEmYXA9SAtXTICKTSSlpy6Zhz1zU6IK6i4K8y80qDmMqD298MwGoR0j5V2fNSPzm9ohWOc9XPKBs4v+FPKt1758oQOSFVKUmHEsxkDb2fxmQ2dBYG/0nmJxdJKuPEyBeih1lPR/Z69AqyUwC98R4eFfCk3xrglLWVUmqWA1JCayc32GWZtmY4o4JWXpr+VvC7tVGgKuFWswVCwbH+4QAUnv0ZXVhCrhs18mKrCPgwQlUi3/5eCxcIRIDDKRUN6mewnDwLjD5UpFlqFPuBKVb+gTYoPKFJbmK
X-Microsoft-Antispam-PRVS: <DB7PR04MB4490CA6E00C0DF67F050375986550@DB7PR04MB4490.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(35073007944872)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4490;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4490;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(1076002)(2616005)(105586002)(44832011)(66066001)(446003)(11346002)(486006)(2906002)(3450700001)(47776003)(478600001)(6486002)(36756003)(53936002)(106356001)(956004)(86362001)(6512007)(476003)(386003)(81156014)(5660300001)(6506007)(16526019)(68736007)(6636002)(97736004)(8936002)(6666003)(305945005)(76176011)(52116002)(186003)(50226002)(26005)(81166006)(7736002)(316002)(48376002)(14444005)(3846002)(6116002)(16586007)(25786009)(4326008)(43066004)(51416003)(8676002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4490;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4490;23:/8Usb30psQf+znAPNgkSQrg81qxG+woWZtV0r/9W+?=
 =?us-ascii?Q?vU6GFa08AvWW7ViwfJJ7jKxaPO0chrREERhRuAJwNzvUnFUI8NuUqJqE3jbG?=
 =?us-ascii?Q?VF4PEFsKqpMDEc5qciosXVxoCPRNWExp3ueuEwJ83aOtJIUAjPECu3vZboKK?=
 =?us-ascii?Q?0sWzHQLrVyntP/GNlUlQLbL/rev73CmC5z4bqKee5s5APndxCD0VJHKPgLmq?=
 =?us-ascii?Q?eXemPxwlt2N7U0339V2Lyc4lsmgI8oyXuQcaJ0ceBGxGxyyXAbfqRUKk5o3k?=
 =?us-ascii?Q?WSaWT7GDEi9+2xYcGIg+T9Wwa/7SHe0mLg08LRd1caf+tYxlroPVtyKtY5Yi?=
 =?us-ascii?Q?DJ4TXyebNF2Et/pk6lNwDijYGH7gmlBmZwlFGrREFrXw3U88+xRm6so0tlNT?=
 =?us-ascii?Q?mZ0fwWhV/nk7MZ3Mc4lyREgsSiaTYn2rYDJTtM58uUagRTM2VXvapJI5UsdT?=
 =?us-ascii?Q?32YqcxOttGWJqq7sNq8vznTkyMZ+WIRG8fAsT2iu4/Fbn2DD3QZOwZWv4bEH?=
 =?us-ascii?Q?9fSgaCWhqUDE3Nf4NRrOWSh002VwX/JXuE+dTUb2g1h+pMdnyrSul/VHAYic?=
 =?us-ascii?Q?nV779g3ojEjFPLIvbAHXYm3tyR72zPFKNBZw7Hi84+1LgKJ5XgFzAArv7MD9?=
 =?us-ascii?Q?b69v+W8LPMk/Ye11GiTE4BwgmVZRwJ50oR80nSTEjCm0c3eWRmxUtxT1xtGh?=
 =?us-ascii?Q?hFia3IzkTvPxmG2umqovxgWhVzDpSCrI0sxRqNQOIH/LINXS19DwqjgWG9p2?=
 =?us-ascii?Q?LJ0zmsiLg58xL+5kW0lbySKlHhQvo3LyATWE3rsw+MRipNZUt623ZrEXhXou?=
 =?us-ascii?Q?h8yXYjs1T9hLm17tLJ6SAus8bf557+t5WT97kCvU9FqYT5YkQzHiS24MlAgk?=
 =?us-ascii?Q?6zVV+QQEbJZ9G00GfTe+h028jr/0f4cjj0WD+2+NOjIZVNDIpjqPjQ+i6weW?=
 =?us-ascii?Q?XrEtYwm7UyJhHX5NOnqWdMJj6Y5Q+Q8D9PyItiTlQXi2rm78yKBhVq2OIogn?=
 =?us-ascii?Q?iu/63IPpsGcsleZNR5LyINusO6lKo48vHyKxHlZ7bmUf7vHVZgI5/B76wNO8?=
 =?us-ascii?Q?mOeUCZcF06qeGco7LsquUHVhtrnldL9QdcyXyKxJEbRvm3qLTDdacnUahk50?=
 =?us-ascii?Q?Gf4QEavZ296aaR6YpagVcrGiVcWM8sbLES0WE+LPruKI9LCDgKbFy1ZZ3cc2?=
 =?us-ascii?Q?tBRH4Wud64bRfnMNHfW+ZAAfVtToyUwFINU9dDfNkbNyQA8AgA9a+IhdMsfD?=
 =?us-ascii?Q?1E/XGWOngxyvRdIemIpyJ+pQxvtXbS/gdHHbvOr?=
X-Microsoft-Antispam-Message-Info: iAMCSUHA4dNJMiizqy531wLgJPv+Ea7wVgERqBz8N2YD9OqNtmw6ZHjQiwAR+IDy1/hgewETxGML/TZ6HAmNKCKx5GK3Ue8pmklK/WWGBXPPRsnaJmvfppSQx5qW1/c/cD1hMJrbO/yWfagYFYqLKDlNQ+uza8ufyVN0JLC6xiRGqy69JVgNnQdLMiU9v23I/0ed2qh+JrxZMI2E52wmFgMPdHYWHEIoTicKVyyK1Tj9LVsAHETx620r4hZyDRdOae/QVgD2ZsMJG1wfNQr4Z8brvR+PvwITgluzqWUhXMDO9O1IxCQY2hfhW2BIo02WhSLqXeQ2/RKLdNB97zt6lF37gL53bwaQkYa1SduLrHU=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;6:vAeycOLC/34z56U9OYII699PBF+phWsHSC3lRftBASEgjjqhjxwKrfR7ynSk696nzRPPf8ZTHrBJ+MytZ5q4FK7m6twGRpUINP8J5A0Fe145vI4bf/nJBbJxPAWXZI8qRskyDD5+a331mL3Pd/HWPRHj/SgcGfNiMcXnHYUZKEhbQwRARkXlYNRYVsKSnBVU0xsMle4bh3L8PsI50XqwFWKqVovH9eldA4Bok6UaTvysmd2Qa+9P3cyQxnBbldQhygub1Zk4nW4X8UmV9daWF+Ad1a9ugbC7T4UxE0Jnraj5pX4QjlCeidSejkyJYagZqA7BlPJvHaTqaPyJIextHNJ0mE3QCeSZVmXECBCXCr9CqM42swLAnuiV4tc2j14FMGWH/JhhTEpB+FjXZmgfXK2nkprLVXHfCvpRDmmCpHNFFpDE7kBisloZlShDgpWs5vO7rAi5Iz5s2F6QzdzCPw==;5:SYAHqgJ4uc0ZhFfdnkmgkuld0eQfJAzaO8godnczgMjD3uCPO8RxJ/tTxA/rE5447TmxeB1AOYh8azkmo30IIg9QwKVNsUdXnQ808WCgOLehxn1Uvjr+gTN7CEkEagRPqWxX1ZCPudtqQOr0+I1N4au/S6Qi/Me/JP+abWJXz34=;7:U37/QAmqsbwNG3HBTMkSu0tmTVxyH8wf6CF2GSAVlFQ9ZyobHfNNkxeGV7XdZ9fjdQ56R7zKiZ4qYfMCSH1LJOjaRkFmgc4MT3oWJqzgk5ZkK/m2OmhWY/PE7KXCScrllwEO8Vz0vSY//eMpz99/QMbmE3kNiQJj84Xp2WByQpmNNxwGH5Hz5CX2a/PLgng+mZXhao+HDD/7gdfpVBxLV//q7GR5d+O4+29gThjmjN+RZ5ZBCrT+Xwi5X8IIhloW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 14:21:55.0993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d099d7-c832-4464-207e-08d5f170cff4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the NXP DPIO (Datapath I/O Driver) out of the
drivers/staging directory and into the drivers/soc/fsl directory.

The DPIO driver enables access to Queue and Buffer Manager (QBMAN)
hardware on NXP DPAA2 devices. This is a prerequisite to moving the
DPAA2 Ethernet driver out of staging.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 MAINTAINERS                                                    |  2 +-
 drivers/crypto/caam/sg_sw_qm2.h                                |  2 +-
 drivers/crypto/caam/sg_sw_sec4.h                               |  2 +-
 drivers/soc/fsl/Kconfig                                        | 10 ++++++++++
 drivers/soc/fsl/Makefile                                       |  1 +
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile          |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h        |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c     |  2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt   |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c    |  2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c            |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h            |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c    |  2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h    |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h                 |  4 ++--
 drivers/staging/fsl-mc/bus/Kconfig                             |  9 ---------
 drivers/staging/fsl-mc/bus/Makefile                            |  2 --
 {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h |  0
 .../staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h  |  0
 {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h |  0
 20 files changed, 20 insertions(+), 20 deletions(-)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fe4228..34ce842 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4418,7 +4418,7 @@ DPAA2 DATAPATH I/O (DPIO) DRIVER
 M:	Roy Pledge <Roy.Pledge@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	drivers/staging/fsl-mc/bus/dpio
+F:	drivers/soc/fsl/dpio
 
 DPAA2 ETHERNET DRIVER
 M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
diff --git a/drivers/crypto/caam/sg_sw_qm2.h b/drivers/crypto/caam/sg_sw_qm2.h
index 31b4407..b5b4c12 100644
--- a/drivers/crypto/caam/sg_sw_qm2.h
+++ b/drivers/crypto/caam/sg_sw_qm2.h
@@ -35,7 +35,7 @@
 #ifndef _SG_SW_QM2_H_
 #define _SG_SW_QM2_H_
 
-#include "../../../drivers/staging/fsl-mc/include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-fd.h>
 
 static inline void dma_to_qm_sg_one(struct dpaa2_sg_entry *qm_sg_ptr,
 				    dma_addr_t dma, u32 len, u16 offset)
diff --git a/drivers/crypto/caam/sg_sw_sec4.h b/drivers/crypto/caam/sg_sw_sec4.h
index e586ffa..dbfa9fc 100644
--- a/drivers/crypto/caam/sg_sw_sec4.h
+++ b/drivers/crypto/caam/sg_sw_sec4.h
@@ -12,7 +12,7 @@
 #include "ctrl.h"
 #include "regs.h"
 #include "sg_sw_qm2.h"
-#include "../../../drivers/staging/fsl-mc/include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-fd.h>
 
 struct sec4_sg_entry {
 	u64 ptr;
diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 7a9fb9b..c17bf38 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -16,3 +16,13 @@ config FSL_GUTS
 	  Initially only reading SVR and registering soc device are supported.
 	  Other guts accesses, such as reading RCW, should eventually be moved
 	  into this driver as well.
+
+config FSL_MC_DPIO
+        tristate "QorIQ DPAA2 DPIO driver"
+        depends on FSL_MC_BUS
+        help
+	  Driver for the DPAA2 DPIO object.  A DPIO provides queue and
+	  buffer management facilities for software to interact with
+	  other DPAA2 objects. This driver does not expose the DPIO
+	  objects individually, but groups them under a service layer
+	  API.
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 44b3beb..803ef1b 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
+obj-$(CONFIG_FSL_MC_DPIO) 		+= dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpio/Makefile b/drivers/soc/fsl/dpio/Makefile
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/Makefile
rename to drivers/soc/fsl/dpio/Makefile
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h b/drivers/soc/fsl/dpio/dpio-cmd.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h
rename to drivers/soc/fsl/dpio/dpio-cmd.h
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
rename to drivers/soc/fsl/dpio/dpio-driver.c
index 11a90a9..b60b77b 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -16,7 +16,7 @@
 #include <linux/io.h>
 
 #include <linux/fsl/mc.h>
-#include "../../include/dpaa2-io.h"
+#include <soc/fsl/dpaa2-io.h>
 
 #include "qbman-portal.h"
 #include "dpio.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt b/drivers/soc/fsl/dpio/dpio-driver.txt
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt
rename to drivers/soc/fsl/dpio/dpio-driver.txt
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-service.c
rename to drivers/soc/fsl/dpio/dpio-service.c
index 14ed2be..9b17f72 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -6,7 +6,7 @@
  */
 #include <linux/types.h>
 #include <linux/fsl/mc.h>
-#include "../../include/dpaa2-io.h"
+#include <soc/fsl/dpaa2-io.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.c b/drivers/soc/fsl/dpio/dpio.c
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio.c
rename to drivers/soc/fsl/dpio/dpio.c
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.h b/drivers/soc/fsl/dpio/dpio.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio.h
rename to drivers/soc/fsl/dpio/dpio.h
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
rename to drivers/soc/fsl/dpio/qbman-portal.c
index 116fafb..cf1d448 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -8,7 +8,7 @@
 #include <asm/cacheflush.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-#include "../../include/dpaa2-global.h"
+#include <soc/fsl/dpaa2-global.h>
 
 #include "qbman-portal.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h b/drivers/soc/fsl/dpio/qbman-portal.h
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
rename to drivers/soc/fsl/dpio/qbman-portal.h
index 69db3c8..89d1dd9 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
+++ b/drivers/soc/fsl/dpio/qbman-portal.h
@@ -7,7 +7,7 @@
 #ifndef __FSL_QBMAN_PORTAL_H
 #define __FSL_QBMAN_PORTAL_H
 
-#include "../../include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-fd.h>
 
 struct dpaa2_dq;
 struct qbman_swp;
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 9269cb0..f2917b5 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -37,8 +37,8 @@
 #include <linux/if_vlan.h>
 #include <linux/fsl/mc.h>
 
-#include "../../fsl-mc/include/dpaa2-io.h"
-#include "../../fsl-mc/include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-io.h>
+#include <soc/fsl/dpaa2-fd.h>
 #include "dpni.h"
 #include "dpni-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
index 3424530..90f234d 100644
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -5,12 +5,3 @@
 # Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
 #
 
-config FSL_MC_DPIO
-        tristate "QorIQ DPAA2 DPIO driver"
-        depends on FSL_MC_BUS
-        help
-	  Driver for the DPAA2 DPIO object.  A DPIO provides queue and
-	  buffer management facilities for software to interact with
-	  other DPAA2 objects. This driver does not expose the DPIO
-	  objects individually, but groups them under a service layer
-	  API.
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index 21d8ebc..2141e4b 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -5,5 +5,3 @@
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
 
-# MC DPIO driver
-obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/include/soc/fsl/dpaa2-fd.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-fd.h
rename to include/soc/fsl/dpaa2-fd.h
diff --git a/drivers/staging/fsl-mc/include/dpaa2-global.h b/include/soc/fsl/dpaa2-global.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-global.h
rename to include/soc/fsl/dpaa2-global.h
diff --git a/drivers/staging/fsl-mc/include/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-io.h
rename to include/soc/fsl/dpaa2-io.h
-- 
2.7.4

