Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6481CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF9D20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H685RFvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF9D20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbeGWKps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:45:48 -0400
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:38992
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388190AbeGWKps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmP3Eigrzgp9rSUg3O5w7T2T+/e3nMfSU1tujveJGAE=;
 b=H685RFvJ47L39dWZqN23WAApuTLJFi0+GqUkSCAzcxbdC1iyOW3dnzhy5VZLbjhbdBQDwI7EfcIubBUJZitbrUncOfOnGQMKJBveY+jgRdpmR2xkV6aVZi/FYpOBDfDN0gG2IYW8mB4c3Is3TGCeL6Sxd01UV2bLsbXAKl1Zb1s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3232.eurprd04.prod.outlook.com (2603:10a6:802:6::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Mon, 23 Jul 2018 09:45:17 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, s.hauer@pengutronix.de,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v3 0/3] add memcpy support for sdma
Date:   Tue, 24 Jul 2018 01:46:09 +0800
Message-Id: <1532367972-29707-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:203:72::26) To VI1PR04MB3232.eurprd04.prod.outlook.com
 (2603:10a6:802:6::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cf81228-7001-45f3-a8f9-08d5f081017c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3232;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;3:bgoWJ3ivk3vTw3Ftux8hRCF++777sRDznaKAhMkij6CqGxiSYTAFWheAXmg9KRkotoJJNWRsMBLHW1MqTdnT9RiWTQc/bj2t1X4UkrfTAhaBRN9H2w0lhFSp225CNIkgGEc6zQ925L+iIK37TVtxuj1OFEvYj9Sh4hkpxaPSW09m73ysACH8cGCtNaLQQdMeFIkqkfg6nfD+pMj3bcAMspL+2PYHXT1oYy2kyHGj+ZsX6Td9fgEIgDo+UuwoQuEm;25:eKbNvjddUTKsxbnmFEmgOexiWXvdD+m8shAHsU/SVrswycgpzh4Wto8DrkgR2gCsbhxqQsKAFb2FyFHMwHfEQBs6znNbTOCkEWHSzfjv34f2frAVjYhvlM1Col8MP3+FYGVo2eNIc3HUYlFl+3pbLdDvg7gtYp0nwfb7iJUEavvhfjwst9smHFBo39WhoM7jhlngASDDp0OKC+sQlcZaKLslMRS2Z65PVuNOCPEzo8CfBCvRtW0ajTMyCsaoQbrDTICDZnJBw0VxfnRNLprvl7D6Dy3B1B7EtJvDpNTOA64ck2FZnjHUgvpDfZe2bRLUkkeKypzk0wpsAibMmYaR0w==;31:03gLdwKe0i7V2Splz1yb2Tov3boZuigCrtlU8zSSuScsj7RQnnCOYp1QSfpugBrm1ijfV36PCitCN2ZKgHIDmPOCM83IMKCoMeOe9ERx76AiZYazp9sjOg3+ccpFCt2ADZ4tdlPSxxRynfRi3gQTZQIZXrXnU5V6GsLia2Wo9YDdLjDifnOtRoHx5yXVUORCT1qau5y/GtevMl62Y/QA9lyyWGqUww8q98tktPGy80o=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3232:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;20:vz6W7JUWVUa3JyvDNSl9RSWXkUZLuIoaJOThJ6jpY2/hfIhTVt9Kdaau7X1umw7rhDNaJIEOL2pzoaAkp0zZVrPixAGNbP8zoUHhJlyk/wWzA5yhEhTfk9vBdhd1aDLskJ+lIjgQy/SUftfJ2ybPrjHvPbgplTjFKtQBSn6xcjN4Ugvrn7iXNUY/d1U2icpDanrkOecn2YlyJqKukL8m8HtVSbAy5cumhrFoGNKAPgCDsDhvhRQBbgL5CRth5eUd5qGXc/kubFdI6QjE0hLoBe0LuDsGH2v3qOi6KYF+RWEBF4V1IXk6AbTUu/ssY24Il4qcgO1by/wVD5aXAi0Zj+l3xVdeHi9RMxyActIjE3P7XH5KLslbjFF668rRghiGlgIKbV44xKTK6BQZ46uD0n8oZFjxuIqpzOx7jlxslIB0+WEFqRjj6bIdXT/X8+FsSZmpv2I12Z5dBaSqPT8wYyE/UtLrtXbrapVRYezJwyXHjVEWSVlHr3UbobLgLSxh;4:eYOt7QQmZcQwjPsV+WipFhd5hGbExX60McNnBTuLg6AYdd7BgKM1ECajcfbH+3oylnOaObL8BGfIyQ1LEZZGRMh/TLDxi+vw5mhKb1AnQdv7eny7jkPjbM1B6Pj2ZP8r+gpporxFQRGjn/wa7/3oiML6l10OtlmbxpopiYO21i+ynVSi9zals1Wh/S/2KxwhhrjMzyJRmZmd3G4YMVjtj2RT8PIsYXlUqBB63UGzTfO/zTUTrnFrpL2xx9idDm9Zgn3W1lBoDdp5R8E8b6aiD8m9KcA3zzcttQkGV6yuL20Ft20o0G8xPBh99FZzbVpT
X-Microsoft-Antispam-PRVS: <VI1PR04MB32320529F1D92E98FF9FAADA89560@VI1PR04MB3232.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3232;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3232;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(39860400002)(376002)(199004)(189003)(16526019)(6116002)(3846002)(956004)(8936002)(66066001)(47776003)(53936002)(478600001)(305945005)(26005)(50466002)(48376002)(476003)(2616005)(6512007)(25786009)(7736002)(4326008)(6506007)(386003)(14444005)(36756003)(50226002)(106356001)(97736004)(5660300001)(68736007)(6666003)(105586002)(2906002)(486006)(81166006)(8676002)(52116002)(81156014)(186003)(86362001)(51416003)(16586007)(6486002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3232;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3232;23:GJEkMiwPBC+sL0jYZiVCEr7IJXASsilVmg4pQspoc?=
 =?us-ascii?Q?rba8pg8jK2asMp0h51bbjChh95CRwD48hJQCTVhoB3qNrGnBBt9OBEWN2lrk?=
 =?us-ascii?Q?6CPtdvF0sUQSYYeb8Z5oQ+RMsFPmqttDBsGKaSIfW9jzJmSjjLobBGQIkWv7?=
 =?us-ascii?Q?na1OY4RCdZIlzpcXwapJZ0t9/9U62EgIjhWwTnIIvmvG8/2JvdSYMwXPQRQ6?=
 =?us-ascii?Q?UGjC38pQ3+o1Pa3NtxRjaAe7aGF4gDzknneJ41lpLXVtgh5OD9LNyx/T1E9P?=
 =?us-ascii?Q?hWjSQUiSm/5eGh82Y8AOzRw3ZgP32ZaGIu3qoDSS7TilxvjlBEHUq8pQe2Z6?=
 =?us-ascii?Q?ZQ1oGa5I5jsE4KL9CzTspzz745QLXlytuyyPpbR1bv0SuGzlARH1j9UKqLBE?=
 =?us-ascii?Q?0inTZqP7JqzELiBgVqLfS673Tqa63nCnLxf7c1dDAdEnp9t/aHFbOXAFRDdn?=
 =?us-ascii?Q?FgnXJ5VP6YJfdVXvVVPvQ3jWF4E5f6XjBPWn5HgPsI0kjuBnpI5T5EVrrtjG?=
 =?us-ascii?Q?LUR64oZVtCh9YQ+Oboq1Mxdg0zjt4Wkrvk+Ebd3IBWztaa3tw3S1Qj5CNHCf?=
 =?us-ascii?Q?Uzvb8EGuIa5ODPNiNrzaE6B9qJd4XVaPIjWe5U6mY4mWR6KOqOUuRXzf2asT?=
 =?us-ascii?Q?g50+a6OhSZj/8gefJzpb4P44d9tSglBXVrJU5UkQ7MliYqAEtQ2Kl/KZRK7w?=
 =?us-ascii?Q?EzzzIWvh1029L6N/AL22SRRQSBGxLYEmd2JG+7YLGiGx8ABo+b342xxv9YkH?=
 =?us-ascii?Q?/jZxGxJ3qeQhE3LDJKktD1ztHGJ32FDNYUJTcixsvh1xiU44lbJXVASPZUWr?=
 =?us-ascii?Q?xH/19MNT3IDoTauVmbiSfdXSdbP+8zz58HWYAfHIFs5kCag/fzvgu6G8rsAN?=
 =?us-ascii?Q?UPAH85JLbVUIakpoNYThsUQMuiDg+tUlL1YVnlZwrmXqAf6FuzM4LpXvNIsv?=
 =?us-ascii?Q?DQmqw46OlKtgucSo7s5Oy+sQFBEEReAKSw2uDB2j2/scsEMJJSRPJnfwqCTi?=
 =?us-ascii?Q?PM9Ulw9A7gaMlCdwq7J1Upux+bHfeS4WpnmqSzGXot3Gwmx1QZ4tDaiL6yyX?=
 =?us-ascii?Q?LVnDhEYVhhsncFfLdzEsGGAivhPaRmqLiaZKBsd7DaE0GYLyu3R4yMoXTIUS?=
 =?us-ascii?Q?x2bYA8+vjQ=3D?=
X-Microsoft-Antispam-Message-Info: a6HUWUa8dMaC3bWCmBPxXFkDd4yn8Y//3IhMwC9hdd1i8S1MUMuCQ/zk23yiR5M3DSrMe2bLWGBDUyhIN6tXHP/pwHFQCymBy9r6rsmWWaO7Wm0Z+zHZBhir+6q/2FO3a9oTlv8ZPsSRfJDeiHyGtHO6WfVPTP4lfK7/aGBMY8k5mrXrzQ0ePrT8HKiprP+mZGvOLQMtODy53PKdFE+DtU5T3v01ZlqQK/aRF8VqRtWfQRdmhKVU67b0HJEcMAsIc7tFPxGFbjFCOe10FzrB+DB8IvPDdu9JTKDqLcF9X+flUxax8sa5ZzD6Es8dM2W8f5gw60pb4x9vN5A3cCJHCDzzQs2rLUaIZi3x3zdoxdg=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;6:aRxP9mLY1HpDs+RfRK60Z2PPZIp63EWx7yS4UotYM0wqbsHHlsAfEX1uc1rfyVV1ugE8ClvQZEhn5tKoy88+d0x6YC6A+JeRWvESY69udg7DPSaUvfnG7PEmEpF4zyb/DgaEzC5VTsmqreZ5CIcTBlo026KkaWr6ARFmAtUwfty+lUdbDMShNLaWK4Ed5N+mHHUOSAWqXi0M9SV6UUjXz3hAU2A8O94AaRjirDPPG+XZUBhdK6VNZ0sLjFhs89RjNXXBk+u7BIZCHch6RmV5r9t5t1vvSzVemgAWmv/hlrd9STpBz7eIoYciYulRc3rJF9RvpJHFhzr95TDt6JTEnpvn34OcuKqT29DPA43jOz49OLdGJkREZj6j3CY0Kc4PRA+SNC5Gna61XXuzat1alWfCk32lqZbS5KT9egSC0wjraBDTMTZettf4V3YGNkLHCpmvktOBhzugM661crzrFQ==;5:06ARXDxU00w+kLFq4nRGOLpSp0tSbLkvMalZz46UJ+ufujwj8gc2spjdfO8KYYbBn1qbP4n5KESxm3IvfzivKKgtoRX7RMk8ooam8kBnBJfJRDvwzN+zLjMxkZinRpVZVoy2pjjhq5bQ0W6FMhWAZxTJlM+b5bvezydVHAt1caA=;7:kKC1lLYRZVw7JlJG9y2UzKHSqmQJ1MhTyGUc6rp3xotW2BqDu8IDVy8/PUe2xO6Pk2evjI22SPtGZIAGGuEBPE4DMqEtg3dOSs3Asg3sYj2fH5Z9KekoENojXcxMVxj5wUYo3hbXLL66jlye/Y77hVt39q+OCC69G19RsG22WoJ1/EdsuWe+RAqToSbgoJmyJFtUjRiquPSmGnjVvjPMvgL8A0xJV6FEOQfCIWtFNXNSPxCn6ToJOOhjsk82vfs7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 09:45:17.9968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf81228-7001-45f3-a8f9-08d5f081017c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is to add memcpy interface for imx-sdma, besides,to
support dmatest and enable config by default, so that could test dma
easily without any other device support such as uart/audio/spi...

Change from v2:
  1. remove 'copy_align' since sdma script for memory_2_memory will handle
     such align issue. No such align limitation. Also remove bus width
     description in bd.
  2. for multi bds case such as in dmatest, should make sure all bds of 
     single transfer should be consistent, so enlarge allocated size for
     dma pool to max bds, 20 bds/1.28MB should be enough for all case.Report
     error if the bd number exceed 20.

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
  dmaengine: imx-sdma: allocate max 20 bds for one transfer

 drivers/dma/imx-sdma.c | 121 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 112 insertions(+), 9 deletions(-)

-- 
2.7.4

