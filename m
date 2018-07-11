Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091C6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDF72086B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mSdzAOZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDF72086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbeGKHkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:40:09 -0400
Received: from mail-eopbgr700043.outbound.protection.outlook.com ([40.107.70.43]:33536
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbeGKHkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUMbbLoAM0HiojMYCmar18r6zGTxTPP+YfbYGuxFPNc=;
 b=mSdzAOZ6kPjLSXbnATFzkteRsBvG2rFSUNqNOLozTyTQlm7pntJKWiHfzZNIre3ALhdGF61A1v6u1eOc9+/tjk/Qpl1Qp1lR5/DLxupW+DxDN/ZaivqgvjBALJu5EG3cwfwyv8UYiyYgyP66tRZU1RrNZsXAso1cdM9Tqr/lfJ4=
Received: from MWHPR0201CA0048.namprd02.prod.outlook.com
 (2603:10b6:301:73::25) by SN6PR02MB4336.namprd02.prod.outlook.com
 (2603:10b6:805:a4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Wed, 11 Jul
 2018 07:37:12 +0000
Received: from CY1NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by MWHPR0201CA0048.outlook.office365.com
 (2603:10b6:301:73::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.21 via Frontend
 Transport; Wed, 11 Jul 2018 07:37:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT058.mail.protection.outlook.com (10.152.74.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.930.16
 via Frontend Transport; Wed, 11 Jul 2018 07:37:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fd9gU-0004hH-1b; Wed, 11 Jul 2018 00:37:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fd9gO-0003Wm-SB; Wed, 11 Jul 2018 00:37:04 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6B7b0pW000449;
        Wed, 11 Jul 2018 00:37:01 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fd9gK-0003UL-CJ; Wed, 11 Jul 2018 00:37:00 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.co>, <honghui.zhang@mediatek.com>,
        <miquel.raynal@bootlin.com>, <linus.walleij@linaro.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>, <michals@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v11 0/3] Add arm pl353 smc memory and nand driver for xilinx zynq soc
Date:   Wed, 11 Jul 2018 13:06:49 +0530
Message-ID: <1531294612-29526-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(438002)(199004)(189003)(316002)(36386004)(81166006)(63266004)(9786002)(7696005)(7416002)(50226002)(51416003)(106466001)(8936002)(26005)(16586007)(47776003)(50466002)(110136005)(8676002)(5660300001)(54906003)(48376002)(186003)(126002)(107886003)(2201001)(36756003)(478600001)(2616005)(81156014)(6666003)(39060400002)(336012)(356003)(476003)(2906002)(106002)(305945005)(486006)(966005)(4326008)(77096007)(6306002)(426003)(107986001)(921003)(1121003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4336;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT058;1:N9w3j3/mYDRJb80Kt00BMiysRZkaul5WTYmRuOToXrDBivCu7G4E7W5sgNj7eBI2xOz1qvEGF7oQQ1Q3C8j8K4lZc2rcyEZJ8pkDBTBbP5qvKay60luRWCCQqeCqto4Z
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14fc1bb1-f0fd-42e9-2ad8-08d5e7011d34
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN6PR02MB4336;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;3:ce24TfRIdOEbhnI5tqrqKp2digZjkknplNeQB8xcnGKyr6zlddQgwQY2+hByeyKDH07JTLul/GvAcxO+MBBt9N+hnbJBAGHg/BOB8gSe7yM5TUtQuA7o9UYJBUqNCELTuJPoq8fS0S1iBPgepJS1XVofrsQ9CSey/KPv45fRfzpZGOZDGAXHwE/bqCvXUiZ5ctbA2lbJKQYzQUCQUKXQA4bfYMNlf06og2q7xuBEq4eVYvmuvlkDGgHP6ubY5MGv/iB8jdx5QIs9Q0sb9xxLr0TaGc4Zft7SN1qWcEcjal0dwjU0aQf2Xz7Mzcxb4sey3X/w+Wk/FCz5WeLptGwgjpgY53BK0SxZuveqiGtGdvE=;25:A0bSrifyfPFuaABVFKM8NwjXtYQBpHszy8rYwR7YQ+NTRVNt25gMyZD6k6tRRJaxyXecX3TL4gANKCUMh09b7S2P//itfjlcg+gLayNcVHQ3wYPXtqwfm0Rt2JD4RNxEqp7IXzMTCJm6Lmgdkdw5SlYxnWubDg69HvJf8L8WHypmKUXvbYWEZXsXR/02DxfWjkfeRAL60Vp7Lufo8ltBNEpSw1wCDvfLAoXuJ5qTztO0j2pYO84uaJxEhOooOJHfrEhWuVZDeU49UrjSjS+e4L8kzBCNWw6Q0KO7ekIuViSX5zd3W91lm1GvkeDtZCTpo1Ya2ufb9p3m3q7hiOCKfg==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4336:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;31:Yy7pYIb49WCQnYEBZQwrcKa/jTDzfLGze+HEsVjwqkaDlYeoJK4HA3UGqPrY219TCz1QoPcFhgVH5uJ7uQfNbw5vM101a8j0Bw3Xw+OyCw3QN2Zeah9nrfHU4+kcjuAUBzQ4p4qPnVKqRC+qDSusuzJCxH1akvJ2wOJMHSfG8JhbNugeCuDG44uj7PVfGtEWmfw2nSoXlUZMQTU1MS6rT1tu8fCQlcl2ZUXSS574I/o=;20:Q+xF7QdmH5GqXyE+3pehIKyi/b01yd0uQWrgKOTV18QBIi/B1+Ed/Yhj2iXO4yJv8jjfNUz8A6h4lIlCQPQvFVcjY9H50TSFOZWUcZ9R3Jbk86ie5Nbr0DIgGkBXNr7T41UR/gKAYO0NH1ftIyGYRR1o1MJy4XaUsHpi5LMLY/sXv0duvZlspQVhchxs6ro0OXNd5K2fRmJZnUqMJ/Q4wmDDphME23HWvFWbAlpcch/oQt9T7sHDl9D1n8zgRgEKMwftd0tXrUG3fSQc6/IgUNzcGC/VJSOT8ehJhBQPbi5v5hLBARyobKTNA70HFW4AxTKlFGf8StvE/TAZST7JBa40VUBzFxqBd6kvt0R1WNXJqDTsRT2chiapwF8Fj2NblusneQuFCMEUSB/jL32xktpDYhskSgvM6E960FvszaaBCMFAO17M4m/hgBlZop9JnUtXyi2BYsil3l1amRvKJHVMNncbEpiIaLfRNFgAhHhYEfE76Ftms1RgMpPanZIg
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4336B4046808223BDC1D1C68AF5A0@SN6PR02MB4336.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4336;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4336;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;4:8pkgwHPuGQhX849z7A9eVEPbs0UblYsRW/c6bDucMY3BRzvN4Licmq6y55ybHdH4Z5Ff4Q0p1CFmiYbkVdfCnEsB7Xs9luYnmb1A2ajV6E73OGB5bncYVvD4GC6edY2ubw5GCvliSHo2JoGx6G+ZDL8eCYOIEspwiMCLHGgwjmeJExaLIb54swhRBVdIhpNzx6kcaNkvCCFU2xnGNVoNHxcULXmkDkgWFREgxemlk53j1ojE/WpzmpANYagc4+zI0w3EGQopMybU58JLprMwqXvwav3dEcKsLZDFMNgyEs8AsITteL20+Kdie0Q4Dspomcbl/DXIrUm+Uxwjk83EdbNv/kolSpCY9ChyN44waldfXPPpNEKmk3C6MwwVvzwl
X-Forefront-PRVS: 0730093765
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4336;23:iyLgKu1tfm2FMh8TXaIBceBR1A5u00X8Ld79fncDo?=
 =?us-ascii?Q?MFj3vspBfBDQg0M/9tDxSJda2Jc4cyZSHrFl5Z9ZNqaOb2sb+81z3uBweM+i?=
 =?us-ascii?Q?YMNlqu8p6SD8GVHBT/qgQ7JYu40zatx7aHhNq0RFA2osRIicLM8n80B+S+R1?=
 =?us-ascii?Q?OIMNI+H1YcuScSAwnMWxNqICDp9S2SvPRxY3wLFnfA0ZY7vkmeQq0cRXwy/A?=
 =?us-ascii?Q?iHE0bOKc+Ach/Lz1xAru0pE4xBIj1PnHrtUAVVWF1J8x3XAEcj0OEjKqiW1C?=
 =?us-ascii?Q?H1++KlkyxbwbQNp72mmglXxjkc9TdayOeGkVcXHhV5tQE6bu3Q9toBZHYETQ?=
 =?us-ascii?Q?jB/lGgtxddRDQj9FbfDCAk8jkaSeFIAZ6uiG7Lvn4khfUdtP2mRgomhpuQ7E?=
 =?us-ascii?Q?qN8ZuN78qMuycutYNpD6Kru4NzAICoJz1PQCqZNZS8G9lLatoF0dz9TgENWS?=
 =?us-ascii?Q?Rn6BrCmd5vUuZZstMcYcXW/cEVWIcc2GQKiyJa9O1hZdriz4+DTekWaIzYYh?=
 =?us-ascii?Q?/0nDQDb+h6QvhLBbV4N8JnFKFAoYDw1DzKn99jeuRiGFo3T33uAOl93CcksI?=
 =?us-ascii?Q?3g4/5fCHauuiVQk8QSb/nIm8iVaJfmyxL0T7lXVwM7Mg2or8IYADxQOR6n1w?=
 =?us-ascii?Q?YvCnjWFAvhK8WUOA72pcFb0jMiv13woNGtmjHgyhI0dPYK4PbT3c1aGABwWz?=
 =?us-ascii?Q?QKkD9rpUKpIIZPPZJah/oPNX6YlYpmjjQOVCWMON6r/+jqh2B/1bRphhyjRn?=
 =?us-ascii?Q?QMDTcWp9itEk3cIWqnO5RrkL43OAaJAZkMDuiKVXDCCNPRRvIEzlErVbEBEh?=
 =?us-ascii?Q?pWFCWthgdyhrmhMEMu0h4B5RyZnHw7FwgF091R6xzywqBMsy8CAd/kLzgFao?=
 =?us-ascii?Q?D4ZU3Ku5qk2YwYkDMkQ7yvbFecLvjXQ0tDV+ahytSL8WYzZTVEPdMmOm3pKE?=
 =?us-ascii?Q?rXjomeb7w0lHYO3oflDx+xNTk7gc5iU/ZEHvfkGkYjQxWnuA5DBkQ1YEwr1G?=
 =?us-ascii?Q?JYXsIyqKca5hhga10aVFkAxLiJ28hfH0FsbgH8eQpQ0AM2yqw84ywgRojPRH?=
 =?us-ascii?Q?Ae+4Y5q8sZyjvSLn+dEiPAEoY28MpJL7MmZeh5VcOQ/dbd7yayE5GOMriybk?=
 =?us-ascii?Q?Xgnu2q1vITYt7zFTX/vH7FvKimiLRFiWOXRJrBFQZn5D6RBod0dz2JV09aKM?=
 =?us-ascii?Q?vWKvhXNq4PYBZfc2om2C6cKpR0DMgK6G8x0?=
X-Microsoft-Antispam-Message-Info: eQbos0qsW5xYi5FMIasCl/dICHqHqNKuyR7MLGa9rKPj8+o22ffvcydzl5d8OfPfjxixPcejao2Fty1Zqjkj5pcBKvAOaFVMpz3ZOg210PLg2DNZacGAH3W/Bk4cWpM70L9hL/0SFSfXB9BH8MfNUusGjsz1A8vk2La+xiWl0AZz9/UvDJAzHa92WnvIo7ST13ps68qAnaHH5ShIn1SneC2qVvCVeJVK6jiM4vMqGGs3WetIXiibNWUUMayV9FVP7b+glX77mFiJsAOFSkm0UBHuyWphYh6EQ9RYZz83M5C3d13LCTymjK5mvL5Qtc8iUF/pg6MfP11+cPuw+iNjqPk/zU87yvGR+k0u3kTuMr8=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;6:1ZcAoXwFyAcQ2FG/HrXup0Zvr64u/GPRxVzWpJoFGl9BwWdcgyw7FJd/A04sVMvq0HKxkk8tNzx8vguobC/TLP4qOoAeuQB3trNno4e+qBj7ebUYUJ/Ts4FxXsicSkluX0gJno7RUsttRXBKwZPhXLJ0dmfMi9Fk8+UQFNr8nXqaFiJ7KP54AHYopbcugpoj7qd82J/H9CLiHDuqdm+k7kBkOvBlbIZ1MMLeCI70rGa9B9E/5/iEHkRER27R89Lxit9kOgxagQe7rUi1YiBc0NVL4rHpJJdmbKdR1dzS8OfTZyVSHurfz7VHdY7RdNm8IqEvGiC7pDf4o8v4pkUzv166NJFETmTBjzAXJgSZKD/0El3kcwXrUWvXxFkqp0bvRdxpM9hFhJ4U1E04ydNB+qFvNgdTSU0XB7pkA+24j3Yr/I+xrV3be38xGmkfYaC8PcUTuJ6der29doZsfXqmfA==;5:kxxAMZTB6ODVMlI0veXsy67wWg1G4S6seNUsfMkCPRdNRGDiM376sY5TDD77qsotbHleTWKiW2r2sJSJHWThg6b6uCCYLly+u5Zm56jgYyUYeD2dTEhI5OM3Gqvh2KDTYa2JzRBuyiDGOP0lcRIPZIy6w9zJf3E87lrpU1QuEEA=;24:NpVJpfrMvlPzFe/GfN/7gllFQBEH0x9pMj+pT5H9tga5neug2bJLlQH6eluaax8GLs+5UlJxfanOnh170eTQb1cmxr1bTFxcXgEs9YVg4vE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;7:bMtWbt/t0+64LpshtVi8aQ5YK2Gry895d1OV7nplQ/9H8BoktLMg9ckxa44Kz21OKNQAFAsloAioApHYzG4LH2EGGDyBAU2LoQwrY8xqfuYz0LGrwbDtEfah6+B+1PpLPvmj9S5GOFe08MZN8ulS11U6JmKCsMPsnyfmk/cZkWV8BoO21z5HLT6YPmTe2Gzv7dPlsnSOdRiFuCYGIUIagsMaFkG34bnouVrr9iBAWL/+6hB38OUu7Mp475WB79CL
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 07:37:10.4515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fc1bb1-f0fd-42e9-2ad8-08d5e7011d34
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add arm pl353 static memory controller driver and NAND
driver for Xilinx Zynq SoC. The arm pl353 smc supports two interfaces
i.e nand and NOR/SRAM memory interfaces. The current implementation supports
only a single SMC instance and nand specific configuration.

Xilinx Zynq TRM link:
http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf

ARM pl353 smc TRM link:
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/DDI0380G_smc_pl350_series_r2p1_trm.pdf

Tested Micron MT29F2G08ABAEAWP (On-die capable) and AMD/Spansion S34ML01G1.
This latest series make use of ->exec_op().

Naga Sureshkumar Relli (3):
  dt-bindings: memory: Add pl353 smc controller devicetree binding
    information
  memory: pl353: Add driver for arm pl353 static memory controller
  mtd: rawnand: pl353: Add basic driver for arm pl353 smc nand interface

 .../bindings/memory-controllers/pl353-smc.txt      |   47 +
 drivers/memory/Kconfig                             |   10 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/pl353-smc.c                         |  468 +++++++
 drivers/mtd/nand/raw/Kconfig                       |    7 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/pl353_nand.c                  | 1314 ++++++++++++++++++++
 include/linux/pl353-smc.h                          |   30 +
 8 files changed, 1878 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
 create mode 100644 drivers/memory/pl353-smc.c
 create mode 100644 drivers/mtd/nand/raw/pl353_nand.c
 create mode 100644 include/linux/pl353-smc.h

-- 
2.7.4

