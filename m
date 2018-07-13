Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6BEECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E75E2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I1/Pnq5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E75E2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeGMFXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 01:23:07 -0400
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:59952
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbeGMFXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 01:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGGokYgRGgbaJ0X9+1uQqY1X7hA46Qf3aOrNaIl46+s=;
 b=I1/Pnq5jmFOYmCzHmmX7mBnG+HkY9+UYZOEvvwYPO/4tXH4ot88019NEgqEU1mG//ik7asbco0uSsUMDuEKWnlburSirSWAT9Q6SaxPvvo3+WWtDLRnbRRt2ObP1JzmuEe3L2SIgkb59pTC1uvYqkFTN7MYH64x5baQ2jUz6+pQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3230.eurprd04.prod.outlook.com (2603:10a6:802:6::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Fri, 13 Jul 2018 05:10:04 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v2 0/3] add memcpy support for sdma
Date:   Fri, 13 Jul 2018 21:08:44 +0800
Message-Id: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0039.apcprd03.prod.outlook.com
 (2603:1096:203:2f::27) To VI1PR04MB3230.eurprd04.prod.outlook.com
 (2603:10a6:802:6::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a6d9264-506d-4fb5-1f5c-08d5e87ee6d5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3230;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;3:T4/bx7dkS5tlJO+/lTL3Gp+JqerfMpAz34FtNouqfBlu1lesLeSvP9ygW90dmP1bGZiP9v2cg61oyNKN/CUOp5Z1zEdA/Sq4EeszPF0He46bqsunPTFP1LFsS9H0BbGBs1Bl3xoTox6DRhoERdgE7mziVqfUpgg0S7qDW9rKv0sTbIRmw+kTUVLZf+1gSax860zlOMUkrYGtIEtKPp9jMbSV+krBOdcZ5tV25huoO5utfGIM5AnRFbrAQK5xi6IE;25:x1s2lFgkXaq+UrVJeD8WF12G3KBJ/kYOQtB3FiWmrb7CXJnrTQwaRdA24YfxrpiQuBGhGqsGcAdPVHnBQ1WI4pgVzLtuw5gEWj8eAzlkzB0G8odcJUejWSOW4WS3iVwo8vou1Eh/x7ZTDcimM/X6qTjsQveEltezRo1PquUVqE5jqN/6z1yesHIi8mCZTmF0odtDE2Be9qnGEIdaVsGCnX/shG06esKxlka5YvCTtqSE0v6HtnqyUF4vYAT95DjB4/J38PvokLsQzPEkUemNsYDFZraoKvsCyVkrkbBXoyyBfj7NuzBzMN2Fe1mIKI1eMCKoaAR1WvdEYnn0wrPeEw==;31:/1BMI2KknFYgJZyuoHjerAVsRX4/NhF0qGet2s6BRh81HAnlg3ee/AmErVnNj10hPvM1wZcLU49cXNJB7qUQhqSGzdxvO5p2LDIowX5cl6lH2Hdb4VIkbeTAyzf6KSb/LdpJ5FBnVUELPtz0vL5LoNzNjDdC6QpOI/ry4qQJRAd1PuQtqA4gW07MrD2BoEl6f2mgO2SgzfulpelOlf2u+1hFea74NGRg4o2MTiAPy5g=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3230:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;20:IedgX857srJe9NVRiGHNqKsMSFstawdF74lkasrFDU4kpPN1Fr2vMuL0nSSzz9tQDIXSpo5R67sUMENCU3dNXk7WDALGu2tT17QOuyU+KNLSA1gvAAYaFCKN1DCqPwxU6bmZUNDuRDgi6/GXfFhzTni2n9bqvmtFq83KuFzmU/KO4cQFn5kq7k+7GVKrvJJzbK6EG+V5fUwyquDrld/0d4FZMoG57ZiJp6WL7ApYuf8fFBqYtneyPChFXiGVgAeVm+MIkOoErP210EFmRknEMThp+NsF+BJnp4tSPEsQpziBOJVgvyerXxcMQBcOLbKIcStJEs6omW9146EZ2vSDEEL1gFfKfCM6cgq/EnASdojGZpR9X6tN0cbXmZT5jVAdBrxDRMWj1oxglMMhATE3VDx7GTz8REKU8LW/8BCYWlYVNJXS60cSGW5KylmiEX63/t1GypfdajPZwRDY1QvSfMDTOqwcKXx6J7uZkXd5Qam9kKT5lPNfcSRe3cigUBde;4:qvECSKbSlLqSWrgROsw++/AErBONrDFXy32Fa4jAnXUqyDQbaK5BtqLf3f5JzoMpUY/0XUf0Pewmt4P9Z2ReFV5Zlprz85vJWWNWJWlrJRYqZ6hrMO9KYs0PA5FmaOrHR4inLpWXbrEdSqMjC1fV/GH59fReTjE2o8GziyiCis6XTdEQFGvsKF9XLvMZcl5nKEaha+1LjLByU+MmdLIhXogqUj+DW0BXeiskpdGLYsYcdAg4+38QtK45mfTqVSfm4Shz5wPsMecRONYvNbfqawcea09PZjeHu7M+TNnBUY9ByNnSZ56fwsZoGwgdOoAu
X-Microsoft-Antispam-PRVS: <VI1PR04MB323061FF012746A141920E6C89580@VI1PR04MB3230.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3230;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3230;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(6506007)(47776003)(6486002)(4326008)(51416003)(386003)(66066001)(8676002)(52116002)(478600001)(48376002)(68736007)(36756003)(106356001)(6666003)(6512007)(2906002)(16526019)(105586002)(186003)(26005)(25786009)(3846002)(2616005)(476003)(305945005)(7736002)(81156014)(86362001)(956004)(53936002)(81166006)(50466002)(8936002)(486006)(16586007)(50226002)(97736004)(5660300001)(6116002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3230;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3230;23:judtN7L/suAfb8CPAewIuvnBS3G1BYqCrLnJn0lEt?=
 =?us-ascii?Q?a+eWaidZNn0VS2N3uCDbEP1ELLmIaZCDFh4JG2RbXIYAx4PwxqN2S1qxk4ij?=
 =?us-ascii?Q?F/saGEWKWLFg5ZZY4+Z25lTa+xxMmwxnZ2yd11WmXNe6f1rgsf+3QZfYTJHd?=
 =?us-ascii?Q?0tuPzd3YvHZhKhla//08MxK4OtweicV34wS5zLWMYmpHeG6ZINgyjx8dHP3m?=
 =?us-ascii?Q?vBwQ19foLjs6v2F1uFipra3h/3qL0E/o9Zt3RYveqecE+LMwPiJ/QGGiw1xL?=
 =?us-ascii?Q?FHUyfdzqohS1Z2jhmW5gZsy1+YJF0Ue6mpZGt2y9F3EtIxQ0kQ1WXtEMG6UA?=
 =?us-ascii?Q?PXWKdhxn1Lp9n8k4o9XzkhSyPsRT5zhhD0PNrQ2QBe8HIftByN1FUFvsHawk?=
 =?us-ascii?Q?/RNE/KvWljQXFOrAGBs2V0Z08srcH2cydqtMIETRU7x/5O4R0AVUZnsDd/nn?=
 =?us-ascii?Q?j8Pw4V2CVDgn+arJzbuHgW5G4BY2VAD2c5ilqO1b9x8CtNLOtmy8GZclXHrl?=
 =?us-ascii?Q?sG+HKjNvZeZj2rgpXNqiQkKZNPqkieSRSZj5rGfGEcXqMB7jD42H38PoSgEe?=
 =?us-ascii?Q?hvhu8c7Ac026Q+/UfFeqEV6nof5S6Bq4GdwgBMTcYMr19IH+3lYFDYG3NVzj?=
 =?us-ascii?Q?iKEszIOpNvuoUR6tJeeaZ2foCzg+qN7opteAvg93Yj0PGi8mUQUe3cLBCxcH?=
 =?us-ascii?Q?9mw3xHLvzCn7rK2Cc7ZgUyMqEYymeJ8rFRLWmK1Afhr/fLweq/+CvWDmXGMJ?=
 =?us-ascii?Q?pEyu3FQmaPuwBb5EJOtw7c+c71oRO7YQMDgJlltNI+OnATqxygbqTyxV07wZ?=
 =?us-ascii?Q?lNM0R8J0daKdu+e/1NoGstZ+WuZSHuzKYLTDOXQZcWv+qAkrPUyTE/NBFBCu?=
 =?us-ascii?Q?HNO7+34VzVzduvVq3E60Lded9c3ohAD5fcnwRB6vxUtOlE03IxasQ4vNy9NG?=
 =?us-ascii?Q?/muBIpL2GGh2QG2QZ/MwSJAgf4F6IUupFgWVvEBS/weQ6KoXTaEiNdK1wEEf?=
 =?us-ascii?Q?ZCaVznKf2g+HiHVVk+sHEYDYPn5aaragcIII6+o5A11mqHi7cfRoMp6pTjXK?=
 =?us-ascii?Q?QielqU3rBBVwfyOTuJaqLFhF/cpMlTa+6PkeMjiF5j+s/MHQg=3D=3D?=
X-Microsoft-Antispam-Message-Info: PsZ7Ku/T5echtwFdD2TlasOv1owzmGD41XohPcUD6RwacZe8GbLSsKC+vm0FslU+9Jvi+w2K57bgE8J+5i6NlbywzkRVaotzyEJDJz2fsJnKV6g3duCJaZL0vjpMSF+ZMIKQ8AGeYMEw9YKkwD9LQBDNIzFsA/M6YtwXW+J2Yab1ZIIEydN4FNIfD6ZRQDfogkTFwnS0z2XkfdP4yx6Q3nh6RGUBegagTSD+prARtE5mgWK8e0T94EVsVhrpLpBjtyzU3pCi4rhTPglx0aJvwbU9l8nSMBRE4pE431n+SeM7AXnmDPowU9Q5IGSVTNG4PMjxo9sbDhFsJEv9chLnA6b33MpDH9SsuZ4G1MKqrLc=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;6:C/D8R1q/4X8JQMl78Aqe8ScvXIbw7RKjj43+vYiGrOcqxKuQGa6EF0GN329JNSZ0UO3uuzQ0pLJ1izN1EA0O2dPdMvk2N0fV7+7k63wZUXnLBca9v2B5G70hAdEctr2lmWnuvlwCUaJEB6G+r4N9tEu4Wqu/C5PpvMPl+QAjIWRi2z+gfPR9s/KEhGZOJg9kNRUKWyWQ9qO+RPhkN1TVeZnpBUN/7ayw54GgbPiP9CGfEO0Q9p+OonQPpiMVq0NsMZwnfXZLVonZiEu+VFPfrDGeLtBtnfSc4qfU73K40nePRhdIvhoAULFCHg6kXX3GVWN4PvTG/ymMbI7z95uA6TXXt2G7nTERQ/4hSGccxnHnYSF+zT55QLXXQaZgmS9W52a+VZsyYt7WuOE0n0EMlxlUs/egNkeceMD3krZE89mx6/c5t4Xp+gEWvyy+9DqEbHqRZJE24emltq2eW5BORQ==;5:tBpVCQekn6BHfcom6J8DQkWnTMOn/Ao9iDRQ1cXKC8YfbzoWEcNZGhjreAgNfYf+LkIuwJgMb1Pu1cSZ3c0WqWY0qQ72AWy1eCRPWUWx1JuwBcAbVbZ+2s70b7xdgqEXSeAqVCguU/S3ENoPixPkqIQonDEX/QoYONFsmGBhay8=;24:pQcoqc5HTCdlW05adGTHQAtURkEWRyz0wYD2gvVssReg0SRVZKq1oxTwcYZ27gFIRhGw6dNyNnXqkLEplZAJufncU5QEtyBNu0E6EwErP1Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;7:ec0xE27UcPQWJuk/nol2qjngQmXvyvXcHHGM6x1k0AC8UWV16/5foZ536Qubimrfp+JkRtXbhtqrClu8DEFJ6dj3N5q5JKUvrK3Wd4y9fkoXkNS8T2hUyQsxWTEzQXAMsGKEJg81GiLNmIvspeqcvKWXVrCjXhMvI9ETnx6CeulqHEl11kV40VbA15alTaxGGAGC24BUWgPIP2x84VUWINnwBw/yeg51fWIH7OWW8iR8iVypAaR4ITAOkG9N3MkS
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 05:10:04.6380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6d9264-506d-4fb5-1f5c-08d5e87ee6d5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is to add memcpy interface for imx-sdma, besides,to
support dmatest and enable config by default, so that could test dma
easily without any other device support such as uart/audio/spi...

Change from v1:
  1. remove bus_width check for memcpy since only max bus width needed for
     memcpy case to speedup copy.
  2. remove DMATEST support patch, since DMATEST is a common memcpy case.
  3. split to single patch for SDMA_BD_MAX_CNT instead of '0xffff'
  4. move sdma_config_ownership() from alloc_chan into sdma_prep_memcpy.
  5. address some minor review comments.

Robin Gong (3):
  dmaengine: imx-sdma: add SDMA_BD_MAX_CNT to replace '0xffff'
  dmaengine: imx-sdma: add memcpy interface
  ARM: configs: imx_v6_v7_defconfig: add DMATEST support

 arch/arm/configs/imx_v6_v7_defconfig |   3 +-
 drivers/dma/imx-sdma.c               | 106 ++++++++++++++++++++++++++++++++---
 2 files changed, 99 insertions(+), 10 deletions(-)

-- 
2.7.4

