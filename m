Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E11AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A150F24076
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZkXXSwP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A150F24076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754026AbeGETlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 15:41:36 -0400
Received: from mail-he1eur01on0063.outbound.protection.outlook.com ([104.47.0.63]:17248
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753752AbeGETle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 15:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8d62Oi3zm+sPGB6eUqtWBr5Vfjg4c925YvJBsNYNyg=;
 b=ZkXXSwP9zs7xsn9AW+gGGIp7lXpqdWlS7i5bICH6wSQei7XzsRAif+Dv7Pb8MfTwm9XkeQ01oSuJdJLnXLoj/eW0EA1lHfRwnJVN5xkrRdKiAZGSzfxN9xUI1S6rGiMYPC5dHHQ6NIjAd1kk6BfGMAL+Y1z+GhBJFK7masDMe3A=
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM0PR04MB4482.eurprd04.prod.outlook.com (2603:10a6:208:73::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Thu, 5 Jul 2018 19:41:29 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, ruxandra.radulescu@nxp.com,
        horia.geanta@nxp.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH 0/2] staging/fsl-mc/bus: Move DPIO from staging to drivers/soc/fsl
Date:   Thu,  5 Jul 2018 14:41:11 -0500
Message-Id: <20180705194113.16256-1-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.8.3
Reply-to: roy.pledge@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN4PR0501CA0057.namprd05.prod.outlook.com
 (2603:10b6:803:41::34) To AM0PR04MB4482.eurprd04.prod.outlook.com
 (2603:10a6:208:73::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59369696-7684-476a-82fe-08d5e2af4eb0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4482;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4482;3:bZO2816k6On3B49pUtQQIAvNfY58kn4cVIGDJCM0rtl4VXd6uJgHnX4GkIyDXoOsDfCdYrL1rvbZpBdPahHw9iM4J6aGQFOnMIqamuwczs9TxRczkyC4i51tEJB2GvWErYNTN0c7PSGzb/7HaQ+DWaUb842WcOJp6Ynx1X47D0p/HTEauo3powu5YmIRW0Eu9HE9RvfgpVULuNHnZBiQUi39JaatbMn0cz6wzGxNYRMcYX0yvcwUeMyxZssHER7I;25:b6pis5TuimvLVI7qUh4VSu6kHqi/RfmLdc3AxTFqMGXPpAShrLGlfMFUTLFcANlrfU1KOyEt4FqfhVHx234KBn6S1b4+dFn+JgghsIkWynlCQeSIh59xt9daNZdN/YLvsKuHfa/udtwr46rQrpFLy7zmNNjt2u4zJ625DKSCjoQQUb48V4HFCZL1Zj6Snh9xf5qQa/bRFc4L2ssdp4mUTwEoc7ceqVgffQKGj2QF+HFZluTlWNol9yXcWFf4WVvx1Prdlpl3cgaTBBQsI+SN1a54vZW+cKS7+FX+BV0rQ/T4Ntzpja9fhNnv+ooVOTQCIPjhDO4NbwtAX/FG3sRYiQ==;31:Zi95QiYHxBf2P7ipavV4MgdFW9jCz1mgLJAp9bwsyExYmTaMBCjk2fDUSEEaEifppRHDyhiWLc22xGZpRvGcaUrSl0rQQL52pwYNoc56iXNTQzo7FLzqu4x4ICCVNDFfiLQk//FtpN9eUWTVVdPhlMIZKNhbrqGYdFYJx9RLFzvGGCMs0oG8knEd/l0CH6vgh8MYEsCzPpuBZ8QEBjAYFRKNhUUAui8li3Fd9IX5KrQ=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4482:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4482;20:YFXJDeb2qRGgwibX/RhsFI8ncNBHcNnr+HOt/C8G6jwmWsKb0RDUcETlVndI6q/Ot7h0uV759raAwnEz4YWUr5LMBX8X26oJ9A0LeGQoF/2/jzxq8Yi8eRi59g1jtXjXtIi/M6Ec6X2Ieqy0RFNe/vWBJnSTzHFzId9K8vVFA8of+vRdZepgzugEGJu4EHPp9OQVqLuQ9yiSx+TsFddEI6rf9nt5lm32mTUA8GCDLpCxq5nt8W8wdvRNWxr4rmDtdImqhmM0F3vTN5QDNAqwXiQgJxXVHbxiH76RM853upkpw1ZbJow2PO6CE56M8xYDE4Xk9wzdMjQZ4RJIfodpy6DcGwOuzA1B73iDMLixCeXnVsfWpJXi43K4TVLx4BxTXwwWRBIiQxN/VpB4jvLAetVdLankbgsRDdgJ3gZ8snpCCdpbq6oA63r0zC531EO/o2JQgVnIF5nHktD/gbldlThh2egkC90XHktcDl5qNfvvmKXKRzaOgscTjVdWnFWr;4:LxERM29Ozka8fwLZ/p1BQ6U+mFSNkF5/SlcATYFqQYxZ+5ZVoUNt0UOsyezO1Cd6fcQl2f5bvonLV5jbsfPOoayh2/EGAvQowMA9bgyuEG1uyzMcYmH32IOGPPQDinGEPwknPwRusZ6Va9S//WOoXpPAOQ0BgkBrfh3ERm52fS9csQhRHA6MYdW+HAczFz37UXREmMPDQzxCABmCdlfGpvjq1+zz1XkuyFzRAF6H3u7Tgu1t5O/7Q0SDHROVEr8SwRvBY0vUHOOFlKKpSWEUhQ==
X-Microsoft-Antispam-PRVS: <AM0PR04MB44826C00B371FCC5D98B497386400@AM0PR04MB4482.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4482;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4482;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(51416003)(52116002)(3450700001)(6512007)(386003)(6506007)(48376002)(1076002)(66066001)(2906002)(47776003)(5660300001)(26005)(97736004)(36756003)(68736007)(316002)(86362001)(16586007)(50226002)(6666003)(3846002)(6636002)(6116002)(106356001)(105586002)(4326008)(486006)(53936002)(14444005)(305945005)(43066004)(6486002)(50466002)(7736002)(16526019)(186003)(44832011)(476003)(81156014)(478600001)(8936002)(81166006)(8676002)(956004)(2616005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4482;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4482;23:yAskXwhBAdjSjXvPm7cvEIBWjUlUz6PhLYsvEZfgY?=
 =?us-ascii?Q?E7wP/0tw0d/Kca8M16axw1CvZ9Jj5R891vS3sNlMaEkpBx5dPrIdc0PD0Vg8?=
 =?us-ascii?Q?HFvHEnmAlhJdM2NvOxG9tkATkDHgKNQVCpHZA5qqzhbXUJJJm23eLzGYtjua?=
 =?us-ascii?Q?VzNbfULo26lZfZHSr0c3nGJyuo+TKtryHWUVRrnbu0cosLNh8bzcy5pN4Fam?=
 =?us-ascii?Q?Lv+HTdoVXqcFlzU+e10sFHkqrsJcRzNGQf9h/ntZ8cQBlwKPmVIkZR6MtiIn?=
 =?us-ascii?Q?SNBmptWFe3L+HNHCuYKD32YOJdbTT7gXJEFPKCl5qqDI/aT2eCEmsHNclmQS?=
 =?us-ascii?Q?cRqREuZHeI5di0BCCm5N7MrONcAyVB2DeGP3Cpti3z/5tElZ3qi3uXysfHC2?=
 =?us-ascii?Q?YRUGOMyaO4caODwzXDKpgjH5WVLdK1mQh10DlwHTcLUw2IvZjH0mc84yZwyD?=
 =?us-ascii?Q?gqCu+Jvon8bQhnfJu+WbQyQE16okhmSR3peKzTshcnlUW6Ur9McMSgWZRNjJ?=
 =?us-ascii?Q?CdNn4xxdrVSyU01Cd6Z+2WPSSSDwO47ApI2I06YentTCOtmjSN6GD+I7xJjG?=
 =?us-ascii?Q?yl3hGzLGmPaKpVeYAAFv9NAXQEl16jPS3ZYkxRkBGYnXzd7flAcqVqWG1dr+?=
 =?us-ascii?Q?UNt1u4Dn5utjBggiE6uAl5rgzhz5tu5Z4oZIZjBulySQfdcsTQjK5y/Eo2Lc?=
 =?us-ascii?Q?jf3yWlN233pOt7BiBAzzalAwdJ6QphWjwILBMhlvmtycLC0wi8aF7qm89W92?=
 =?us-ascii?Q?Zsnhg8VLVxVOfqCme/aZBBp+zCEYt6s/I50c6sUOp/5HuP1rN+CRqvsc2fcQ?=
 =?us-ascii?Q?7IGPOjcFNE5S0vmw6MOPP8vtSYUDOAg95GU1sMTHqEw9WhPo2H9gL3Ow7bpF?=
 =?us-ascii?Q?oPUbNn9I3TkprdxZu3oeFV+R04voy5WlfOslgZSM068gFAMFNwkFEf80xSKc?=
 =?us-ascii?Q?vHIwyrXFnjnSlw05upxEFRO/87aXxlO4XBbn8LVFtE6gfzidgDw7+E1Foi4n?=
 =?us-ascii?Q?kyEm3pP6i+dOhbNOLNujJFpBVaVdeQKr0nDSy7SMe0GDiKkfPZx9fNfKG3Se?=
 =?us-ascii?Q?lphSlGbfZcXxpGFhyt+ochv+L7hBVBZyu7Z2jzjYYMY7UGwr792YWTjD2YqB?=
 =?us-ascii?Q?A0MuCGe12Vievl+EI0zmjkBbBKAQFTRzkbGYyl1J2sQ0+FGbH+zCW8h4i3tH?=
 =?us-ascii?Q?DkEcPvBG5I1qMi4/f0ULdQBptEg4I88wEGt?=
X-Microsoft-Antispam-Message-Info: Kkw11bCe9d0nBcD/fO03MqXCedKYh232P/JdBXE6hAJCxP60UNEOG5PK7mGsqZtJGOm1PBIzAB/Y24U+qkEgTLDMwfN3NY0CTHps/OG2/vgy9Bmu+ueGkGITabLtqrvF7mMa5QISaFpp3EygJp4D+XWc7188MEtVnQqQyuS0Hy9weGEjmzFDKO98n/O8/UXFvVr2T2fMvUMlL4ddEo+dflMxt7oJJl+NOswXiU7EKWRhQD68vdzRaTz/nBWAgdyfUw6qOVf4sngi5M8lJy1NLjjCvrP4p5+Vw20eQE7R5Gl9VJgg6T7POz8AFEGXFncHYCzYLNV9dB52kHDUuDjxYEbT5/j2sX4/HaahjskXYwY=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4482;6:SodeEBad0EodTJZc9emLymjS0mZ4lcXHhJUkPunS6FRN4CW4zv1Pj8asGjYp4j5eSMu0qVmewplZhLfkmUkMsNDltPu4YWk7Ki/GlobA9wdXuHXCuXEP+JbVOzhGJMsFnFc+h2CAprsxVzX9mZMfGvB0rhs1JKytfy4H3a4ho//xiuBvwzUsFfCqP5Id7KjC54glr2U+8ixuoCVgsUN+W6f16HO8VrWbhp8xlXREHDzPogvyiicBE2cLRM0dg6fVbjVRnVf/ILE6BLSrQu6QA7UDQTbMEJ9TIoEvI4P8+uveZLylZShnJDPp5y/KiWZ/k1tgVAECM7Wh2Cad+IOAcigScwESau0S5BOd/dS2y1Clj7AE8LKWr5olUbk22m17Bqqu+NZfWR8ZerarzHcHIKtT/NONKiV9lkzINPd9fO8k7oa7Y9f5VsZXlPnHsUdfeNcVm5mtITmbSrqh5kfs8Q==;5:G2wPFQih4R879vEz89lgMEQGEkZ1g74x0vYhqumkvghjuJWgdQtFL1dsKAHQXPleC2WlrrQsZErrFrvlMxIkgfB1gl0sQ2Ko8NRxvIZT9dBpI07E4DjNKI52VhNYUbT/Xgkioq8geeXp2tx926SgfY5Tf54s+ekQpwaCzVkuumw=;24:fhvgfZTue3RLm8wIm41Af/hdDRCUdmgDZVC9wJfmcpJfRe0zCPGJYlo2kyaVEzLmZCv54hSu316u4YC0ai5s2puukv7O4aGV46KpAvLGuYM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4482;7:bnMEp5B/GW0oW5P3etsLCNJw5ptLql3xttiwMrETMZ9s78Sx4IzAXJEEUR8CKMFRiBrfrmbjxBW8TtlnW+PzBOgMmp9BRofwMZBQXtn6t0yY04RAmXiV72Cd8qnaflSaLvtPYKHq6j5OHXo8VIMyewuOw2NIt1Pp2yaJrWvRulV1eYOeHERM6Ozq4W/tW85d5uZaRPgtO/KM56b/7BriiaqKLYLYNk8AmNJ4NTQ+dIJNk7HPgdla2gkWzDfOIXqz
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 19:41:29.1044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59369696-7684-476a-82fe-08d5e2af4eb0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4482
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the NXP DPIO (Datapath I/O driver) from the staging/fsl-mc/bus/dpio
directory to the drivers/soc/fsl directory.

The DPIO driver enables access to the Queue and Buffer Managemer (QBMAN)
hardware of NXP DPAA2 devices. This is a prerequiste for moving the DPAA2
Ethernet device driver from the staging directory.

Roy Pledge (2):
  staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl
  drivers/staging: Remove fsl-mc driver from staging

 MAINTAINERS                                              |  2 +-
 drivers/crypto/caam/sg_sw_qm2.h                          |  2 +-
 drivers/crypto/caam/sg_sw_sec4.h                         |  2 +-
 drivers/soc/fsl/Kconfig                                  | 10 ++++++++++
 drivers/soc/fsl/Makefile                                 |  1 +
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile    |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h  |  0
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c   |  2 +-
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt |  0
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c  |  2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c      |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h      |  0
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c  |  2 +-
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h  |  2 +-
 drivers/staging/Kconfig                                  |  2 --
 drivers/staging/Makefile                                 |  1 -
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h           |  4 ++--
 drivers/staging/fsl-mc/Kconfig                           |  2 --
 drivers/staging/fsl-mc/Makefile                          |  3 ---
 drivers/staging/fsl-mc/bus/Kconfig                       | 16 ----------------
 drivers/staging/fsl-mc/bus/Makefile                      |  9 ---------
 .../fsl-mc/include => include/soc/fsl}/dpaa2-fd.h        |  0
 .../fsl-mc/include => include/soc/fsl}/dpaa2-global.h    |  0
 .../fsl-mc/include => include/soc/fsl}/dpaa2-io.h        |  0
 24 files changed, 20 insertions(+), 42 deletions(-)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
 delete mode 100644 drivers/staging/fsl-mc/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/bus/Makefile
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (100%)

--
2.7.4

