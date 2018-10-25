Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39534C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C749820838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xPOuHfsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C749820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeJYOi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:38:59 -0400
Received: from mail-eopbgr710062.outbound.protection.outlook.com ([40.107.71.62]:7920
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727185AbeJYOi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMA3ZVxZu51r827+tESsEwFICOQbtgnkTp/bMr/A6m8=;
 b=xPOuHfsdz348zyYU6fgdEwYTQPjTAqkZ7nqFFnGJWWMSbhAKcJ2HnOEqOKi/kizm69IKi1rg6B3HIejZEIcjPFX6MAk82fsfVO/WbAbjlmo2WrWEYayE/SwPoYeJhZT3gmbqxYfVWOp+oX+aS1wmuELWkB/1xhI2Wk6O7E/eR3Q=
Received: from MWHPR0201CA0020.namprd02.prod.outlook.com
 (2603:10b6:301:74::33) by SN6PR02MB4336.namprd02.prod.outlook.com
 (2603:10b6:805:a4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.18; Thu, 25 Oct
 2018 06:07:40 +0000
Received: from CY1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by MWHPR0201CA0020.outlook.office365.com
 (2603:10b6:301:74::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.18 via Frontend
 Transport; Thu, 25 Oct 2018 06:07:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT021.mail.protection.outlook.com (10.152.75.187) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Thu, 25 Oct 2018 06:07:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51370 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gFYny-0005qd-9q; Wed, 24 Oct 2018 23:07:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gFYnt-00082B-2v; Wed, 24 Oct 2018 23:07:33 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9P67VVi024464;
        Wed, 24 Oct 2018 23:07:31 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gFYnq-00081U-Jq; Wed, 24 Oct 2018 23:07:31 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id AEB9D1217F6; Thu, 25 Oct 2018 11:37:29 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v10 4/6] edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
Date:   Thu, 25 Oct 2018 11:36:59 +0530
Message-ID: <1540447621-22870-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(136003)(396003)(376002)(346002)(2980300002)(438002)(199004)(189003)(2906002)(478600001)(2616005)(446003)(11346002)(426003)(51416003)(103686004)(47776003)(90966002)(76176011)(476003)(106466001)(126002)(36386004)(44832011)(486006)(36756003)(336012)(7416002)(186003)(26005)(6266002)(50466002)(48376002)(8676002)(4326008)(5660300001)(63266004)(52956003)(14444005)(305945005)(4744004)(16586007)(110136005)(54906003)(42186006)(356004)(72206003)(6666004)(217873002)(8936002)(81156014)(81166006)(106002)(316002)(2201001)(50226002)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4336;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT021;1:R4Os8huHPG+aPAEvSOXds9Jn4ccMiG3yJUC6nRonMvn7gunhtMUa/iZ+wTR1YFqRpDO/3DhV6CzvWrlgz5cNt2iMvjX3SJHh+7EN5vNSJi59SH9VLGeCNaCvD2PQdNnR
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e57ce1ab-4c45-4732-b811-08d63a402b17
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN6PR02MB4336;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;3:e0BFa0l02UlGVXkWwaP69I3V1jQdzMjKP7Tokg2QGsSWzlGOXDVNBJBlJHUilByBc0jSEqWUNFdBIiPoyyznNMnjwoIqT6w7TjSZhwygrBdcuuAvsrdxO2rX2/WSK3miuTXVPLjQKlFU8lrC1atot3sKE0xn7owdkjyXDe762hugclfwxF5cHpUGI/vjywcAKUX81vJYKyeHwhq+Eiz2cMRfuit0Umr22J2BXdbFwlOYs/CjgNUIens0WFs6yimDiTT3BVy52jGZd+MLWLOGkt9xB4dxzmwmOvNi4415qeM7dC2mMQDouPdCN740S+M9mSfBrV7eczbRuziVBOe9bb/tUbrnZM9jj6aAqLGnqo4=;25:REwUxXuumACq+tVD3CXuwJoLdSRhTBHpKvj+vXy1xTRf5eezdwmBtKDDexwmQdwll4YhN5t5Q9Jj7A++y6lLtw3j+RyExTJfAfeSioSI/ea1Dqss9oOLW4NWBdE+w70LSfWpOOmY8jY88HDLq60vTzAO6u4gE1m+AhHPSgbo7VPhQVEsHPUFVclGTuhT3UrtSdf9jYsaFfdRlm//x7VFP/so/ALIO2J4ntZzwIQ0utVyiBvkUwmgO28z7IlqdngJq+Iq9ApbzKPkaqz7S88/GLo6vKNzbnKX8qoiprGJliBhiHAzMJBQvka+wnzcZhacDCPjglGbR4wYFSS3HprnfA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4336:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;31:EwmXye7IuxTcPrOg0lR7vUPpJ+QXQEWDWs6ZCNBgZ3O4Ugy3XrAmBF08+UbYsEdDABNHdRv7jdBLvEqwnqaphQx9cdFPgx/yU5vz9lgVmxiiWVSS51UmhI/fw+xgueafql3WI2nwcmseSafkQbg7yQym2Efq9cv8UOY5bODFSn+rMrMNH77T97z3J6RcIvPn2QnukIdb7THcTt06Tc7LqlYD29d9P5RUE1FSdbEmHBU=;20:/lPLsNFWMogNyTrzoiRKk2HJCbd93X2nN7jxySYqQePhLXMha7Is/lpWjyUoy8PLnW7Qge5dVDjgeE0a9iMh0VNq4JRtBASUoKsq/+A16uylB9+S5uqSYqvqWCfPl/R80kUJjXoAfxQk4FA/dU+G9cpzXGyE/knnsAZ95G+Dtx4t2ZUEk4e6KlGuR9ANQwvMszLkengyO+GptywadBi8K4rtr+a9Tpzffbn7lpGxI+fsccBAIfcli4QxBFb4hNQa6gu6htYDgWh9tXgfkzKk4by+6CGIok/uOBZZG0m1ML4erqQuvmTa7vfcgep01bp45b/3vnMO95t78g/VKNwoWildaYbFjzaSPFVCaeQc8yK5xFNrmRr9awi7Gk0WVzCFqGYIRjL1q4zzrhqAMerSVhWYEAjriZ0eZDAHrBvzDm3YGHceYNhYk6M92zPMGAq4M9DwD9/7TJH0+MWun8zG4N/adVr9IP09UM/FHri5ToLBFiER3d7x4vc7EqJMUztc
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB433627B55F3AC22F4A114F5FC1F70@SN6PR02MB4336.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB4336;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4336;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;4:d9aZ4G8buie/PVJo9AEmdlPVzWORI7lxfD6kxaAwrOF6lBSnh1CV5dqHQnxpkkKe4NqcigTm/PwS3zMXzuwSLR+s/IXuEup6FxD4Bnyl15RuDLB6kZzpV7ExC7BjHmXvGhA0aawZG9t5O/CLDzoAgdca+IPLjagxEduT4PKNNZcU3LDlYZBQAFNfBJePn6RmmihZh0B6tkiARafF6siyOElGKzfnYY63KCHn/Brz29dEMXHXYcx5sWaBUd5aapcaPvj1Hln3Cwdj1m1lOcXTEUj0mxq3qeBqXstmR0/Y+JOhvpek+JI97xCyjdAmwHHu//0xgK1ERG44O9pc2G4tvkccZDjY1JX8WFCza9/xsYmnyHvExJIxExnE3tAaSH+V
X-Forefront-PRVS: 083691450C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4336;23:6JoLm5RAfDG5VJ47v/T/kuro7mSXwwpCFb3zP5oYg?=
 =?us-ascii?Q?lLX/RGAOOWMnPKeXthTI29Mg2hgDuhJxItB6Gf5cyk31uVYv4pLgFyRQWBuB?=
 =?us-ascii?Q?R2iBbiQ7jjyMVbpp6utsH9ELZw2QYZRf4OEMORIaCRFaSjvNCzpCxA2Rl4ac?=
 =?us-ascii?Q?7xjp/Cs9tag9gIERIX3844dMEmD1DKbt9KAeMw8TqXsdTDn+LTVbUPsid4q6?=
 =?us-ascii?Q?HfbUIXq9XRMuu/w5Yk2zcEh8susB9QUUWmXtHd0K2cEmZ96/6J6xI2lmgItU?=
 =?us-ascii?Q?uibUY06K1BbsvsVHK+yhFK73Mu21fhUN1XNOaiSutcvRZ0R+9NliApEE47+D?=
 =?us-ascii?Q?m/jK3MWLBX1y7iy0W29nSj4m3do3EQOKbQaU28AL9HvItIuUV1kYZzcdVJXE?=
 =?us-ascii?Q?ycrO5TUXlecI+JI3pze4assW+d/eDuWGczJiYACXnn4e0CDmETnJfTh4FTQt?=
 =?us-ascii?Q?E1lCWIMNPTyIMWAngNK5j61UngePMs165mLAVzCzIkWavkLzimKemEhbE87A?=
 =?us-ascii?Q?EbSF5MJ7hMdnm6ubo4loy4Z/I/8yhBzumkh4Ib4i59U0YiS/NI4RgAMHf0Ts?=
 =?us-ascii?Q?uJlGEo9z08+/q9CGT5B+ZghT7EwtLayltNEOSBy9QSdubWdgxSJe+EIZjB5e?=
 =?us-ascii?Q?giOFAJOmA5E0+weqponeWmnPrMfEqFzEPh0+KgB9wj9B8XVFdPn9ESdu1beI?=
 =?us-ascii?Q?ODv95KyJ8DU4EWi9FGqpe5DZbd1ORy/23qTdEl6z1hQ/Ht8jNMaPD9u42nbB?=
 =?us-ascii?Q?hSy+U0OEc12b5b9s2+7CmF16c4KOHwUkwRAz/yvosERnqd5tsAfejk7UgJOf?=
 =?us-ascii?Q?0Anjykqmfu5d9rOPlyEL5Yq1FtCRJUIfpNo/omDN9wBSqeUTgoGc9yrF3UVn?=
 =?us-ascii?Q?OYMz4uWxfTqegPMFlQDoHOzC7O9LnQ9t9qzfkWpmDVPENDZmPl7xBJyTfSln?=
 =?us-ascii?Q?K3L392OEG/t9oqEHbvGKOHWr8AAo2O62ba8QChvPeu0qGAXYfp1FdsD5yLIA?=
 =?us-ascii?Q?gJIaebDnw9tQSwx1KfCz/pmNd2WFm8t75ZyJ6uBrKTcUgzxzFJtMOj81V5/l?=
 =?us-ascii?Q?Y/0B3UTn87YPDcD2nbSdTkLbb3ibmvO0adK/juDM1wI9ks7gd3/qqppLmnE0?=
 =?us-ascii?Q?Z27HzQOZPXtQmNOWMMAYfyVnpKrW+gJQ7BB4GvhZEdtG3lKP0hmhgFCbbwwg?=
 =?us-ascii?Q?id3SPFRvEmhD8fEeHaX8woSN9rnBqQl3YgNoj6TipK+a8aY6GqLoNdVCwrBk?=
 =?us-ascii?Q?sAJFn9ruOQtw1td42fvXEsjx2yiU4d6s2GKmjEkBYqIaxiGUGNd6B734cU+l?=
 =?us-ascii?Q?66TCSUCGlnIY9z2eR97Pec=3D?=
X-Microsoft-Antispam-Message-Info: iiGIAGDmjcEpzSyMnrfed668wmvn+9AWGZ2hHgs0pYEJhqXhbRZUjWH35sbwysSjMqxCxSWYrteO2iuGHD+N9zbae+PTweLVQx/7pX0fa60NUE4PHtE3qb4MplZaRJ7Y38rW36FjbsDtkjeyWyHt1261LBAKClHR3kb21HvAjNUSiiKjuAsLDmuSX1DUOIx8Zxf+FvBfJKnODXMqTKAf6vDg3rJwUsdbBe542odebOyhGRj4lo9eHxSvaE9MW5J8dAdnmHjYtl5o1SFqHWV88wL9u+vHcFqF6G94sI0pNKfdMTpKCOyGU0OsvrFsC9a3UUZHfBmHc5E4A7jNhJPx8AwuDSbsNb23KUWjyS5AAEg=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;6:w6PrTQQN6GfelEnME1alD5M45zxFM+nD0S3OTJaI0IOlfKCeH8WMLqRFaFMvhIOS7RUwtmDswOXCLt5eM5Nlieps81NBNF5+8s6b2VCsetmXehJQdcLPVHlocrJJULn3VTbTdjp7hCENwXXpCiAorukkvjTYQjQz8kLeg+8ZEe3BVBaiWbhkzBrprVtueBORTLof7TNbZJ/w/NQ38jtiGMhfEEbTt3Tn/nqLJlqhLZXey48NQd2dB4TSX0yC+sm2VCiNHHugoysWlol4ZZlIqoUm1E9YvwD0RO8veJiK8Mo3WUvJy9JDk7XsXkS2DNvnPbecyfDLmk5mFSmbplfbJmgspPy6qiKKKnT5Z0xJW4JZoBRsBNJWAgCxPdyYu8c2jAAp8VUkz0hIHI9XVsnR0yYndj8pBNj7dgnDMWyWvGxORIWK9NXnf7uq7CnH7Nl5wt/dNiRgZHfPk84sX3VPpw==;5:Bs4qT0Ag8h0U7i6q/O7I28xSWLqingtRjffZQWeEuRPGutHeFZWugw5i+9N2JauVjENf8gLW0tdzJ15qxb0urdadaPxconsQOdKvTgaKjZcZavc/j4iVNQjLVrools2eT6JfqqqE3SZXbKuwc5ROk825JoajKJLfffM2n1wr0qM=;7:FBoimuR52QI8zrtGvJ5rciUQIKPrCVSIUo9rzyXGpNtI0DHa37KIOCKA81E3KLneFqRzibjiwZLyB97I+X28d0g+EZXT+9etRD+LBle33J9obJo14R/gseP8o5MZUsRXbecww11GW1k1DxOlbUx5zA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2018 06:07:38.7296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57ce1ab-4c45-4732-b811-08d63a402b17
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EDAC ECC support for ZynqMP DDRC IP. The IP supports interrupts for
corrected and uncorrected errors. Add interrupt handlers for the same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/Kconfig         |   2 +-
 drivers/edac/synopsys_edac.c | 322 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 306 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 57304b2..7c40eb2 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -441,7 +441,7 @@ config EDAC_ALTERA_SDMMC
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index d1999e0..e81f18a 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
@@ -272,6 +273,8 @@
  * @bank:	Bank number.
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
+ * @bankgrpnr:	Bank group number.
+ * @blknr:	Block number.
  */
 struct ecc_error_info {
 	u32 row;
@@ -279,6 +282,8 @@ struct ecc_error_info {
 	u32 bank;
 	u32 bitpos;
 	u32 data;
+	u32 bankgrpnr;
+	u32 blknr;
 };
 
 /**
@@ -385,6 +390,66 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
 }
 
 /**
+ * zynqmp_get_error_info - Get the current ECC error info.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Return: one if there is no error otherwise returns zero.
+ */
+static int zynqmp_get_error_info(struct synps_edac_priv *priv)
+{
+	struct synps_ecc_status *p;
+	u32 regval, clearval = 0;
+	void __iomem *base;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
+
+	regval = readl(base + ECC_STAT_OFST);
+	if (!regval)
+		return 1;
+
+	p->ce_cnt = (regval & ECC_STAT_CECNT_MASK) >> ECC_STAT_CECNT_SHIFT;
+	p->ue_cnt = (regval & ECC_STAT_UECNT_MASK) >> ECC_STAT_UECNT_SHIFT;
+	if (!p->ce_cnt)
+		goto ue_err;
+
+	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
+
+	regval = readl(base + ECC_CEADDR0_OFST);
+	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	regval = readl(base + ECC_CEADDR1_OFST);
+	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
+					ECC_CEADDR1_BNKNR_SHIFT;
+	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
+					ECC_CEADDR1_BNKGRP_SHIFT;
+	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
+	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
+		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
+		 readl(base + ECC_CSYND2_OFST));
+ue_err:
+	if (!p->ue_cnt)
+		goto out;
+
+	regval = readl(base + ECC_UEADDR0_OFST);
+	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	regval = readl(base + ECC_UEADDR1_OFST);
+	p->ueinfo.bankgrpnr = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
+					ECC_CEADDR1_BNKGRP_SHIFT;
+	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
+					ECC_CEADDR1_BNKNR_SHIFT;
+	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
+out:
+	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
+	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+	writel(clearval, base + ECC_CLR_OFST);
+	writel(0x0, base + ECC_CLR_OFST);
+
+	return 0;
+}
+
+/**
  * handle_error - Handle Correctable and Uncorrectable errors.
  * @mci:	EDAC memory controller instance.
  * @p:		Synopsys ECC status structure.
@@ -398,9 +463,25 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "CE", pinf->row, pinf->bank, pinf->col);
+		if (!priv->p_data->quirks) {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
+				  "CE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "Bit Position: %d Data: 0x%08x\n",
+				 pinf->bitpos, pinf->data);
+		} else {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
+				  "CE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "BankGroup Number %d Block Number %d ",
+				 pinf->bankgrpnr, pinf->blknr);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "Bit Position: %d Data: 0x%08x\n",
+				 pinf->bitpos, pinf->data);
+		}
+
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
 				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -408,9 +489,19 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "UE", pinf->row, pinf->bank, pinf->col);
+		if (!priv->p_data->quirks) {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				"UE", pinf->row, pinf->bank, pinf->col);
+		} else {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				 "UE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "BankGroup Number %d Block Number %d",
+				 pinf->bankgrpnr, pinf->blknr);
+		}
+
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -420,6 +511,42 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 }
 
 /**
+ * intr_handler - Interrupt Handler for ECC interrupts.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
+ */
+static irqreturn_t intr_handler(int irq, void *dev_id)
+{
+	const struct synps_platform_data *p_data;
+	struct mem_ctl_info *mci = dev_id;
+	struct synps_edac_priv *priv;
+	int status, regval;
+
+	priv = mci->pvt_info;
+	p_data = priv->p_data;
+
+	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
+	if (!(regval & ECC_CE_UE_INTR_MASK))
+		return IRQ_NONE;
+
+	status = p_data->get_error_info(priv);
+	if (status)
+		return IRQ_NONE;
+
+	priv->ce_cnt += priv->stat.ce_cnt;
+	priv->ue_cnt += priv->stat.ue_cnt;
+	handle_error(mci, &priv->stat);
+
+	edac_dbg(3, "Total error count CE %d UE %d\n",
+		 priv->ce_cnt, priv->ue_cnt);
+	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	return IRQ_HANDLED;
+}
+
+/**
  * check_errors - Check controller for ECC errors.
  * @mci:	EDAC memory controller instance.
  *
@@ -427,10 +554,13 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
  */
 static void check_errors(struct mem_ctl_info *mci)
 {
-	struct synps_edac_priv *priv = mci->pvt_info;
-	const struct synps_platform_data *p_data = priv->p_data;
+	const struct synps_platform_data *p_data;
+	struct synps_edac_priv *priv;
 	int status;
 
+	priv = mci->pvt_info;
+	p_data = priv->p_data;
+
 	status = p_data->get_error_info(priv);
 	if (status)
 		return;
@@ -475,6 +605,39 @@ static enum dev_type zynq_get_dtype(const void __iomem *base)
 }
 
 /**
+ * zynqmp_get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the EDAC device type width appropriate for the current controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type zynqmp_get_dtype(const void __iomem *base)
+{
+	enum dev_type dt;
+	u32 width;
+
+	width = readl(base + CTRL_OFST);
+	width = (width & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+	switch (width) {
+	case DDRCTL_EWDTH_16:
+		dt = DEV_X2;
+		break;
+	case DDRCTL_EWDTH_32:
+		dt = DEV_X4;
+		break;
+	case DDRCTL_EWDTH_64:
+		dt = DEV_X8;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
+
+	return dt;
+}
+
+/**
  * zynq_get_ecc_state - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
  *
@@ -484,19 +647,43 @@ static enum dev_type zynq_get_dtype(const void __iomem *base)
  */
 static bool zynq_get_ecc_state(void __iomem *base)
 {
-	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
 
 	dt = zynq_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
-		return state;
+		return false;
 
 	ecctype = readl(base + SCRUB_OFST) & SCRUB_MODE_MASK;
 	if ((ecctype == SCRUB_MODE_SECDED) && (dt == DEV_X2))
-		state = true;
+		return true;
+
+	return false;
+}
+
+/**
+ * zynqmp_get_ecc_state - Return the controller ECC enable/disable status.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the ECC enable/disable status for the controller.
+ *
+ * Return: a ECC status boolean i.e true/false - enabled/disabled.
+ */
+static bool zynqmp_get_ecc_state(void __iomem *base)
+{
+	enum dev_type dt;
+	u32 ecctype;
 
-	return state;
+	dt = zynqmp_get_dtype(base);
+	if (dt == DEV_UNKNOWN)
+		return false;
+
+	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
+	if ((ecctype == SCRUB_MODE_SECDED) &&
+	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
+		return true;
+
+	return false;
 }
 
 /**
@@ -538,6 +725,34 @@ static enum mem_type zynq_get_mtype(const void __iomem *base)
 }
 
 /**
+ * zynqmp_get_mtype - Returns controller memory type.
+ * @base:	Synopsys ECC status structure.
+ *
+ * Get the EDAC memory type appropriate for the current controller
+ * configuration.
+ *
+ * Return: a memory type enumeration.
+ */
+static enum mem_type zynqmp_get_mtype(const void __iomem *base)
+{
+	enum mem_type mt;
+	u32 memtype;
+
+	memtype = readl(base + CTRL_OFST);
+
+	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
+		mt = MEM_DDR3;
+	else if (memtype & MEM_TYPE_DDR2)
+		mt = MEM_RDDR2;
+	else if ((memtype & MEM_TYPE_LPDDR4) || (memtype & MEM_TYPE_DDR4))
+		mt = MEM_DDR4;
+	else
+		mt = MEM_EMPTY;
+
+	return mt;
+}
+
+/**
  * init_csrows - Initialize the csrow data.
  * @mci:	EDAC memory controller instance.
  *
@@ -598,13 +813,57 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	mci->dev_name = SYNPS_EDAC_MOD_STRING;
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
-	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = check_errors;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		edac_op_state = EDAC_OPSTATE_INT;
+	} else {
+		edac_op_state = EDAC_OPSTATE_POLL;
+		mci->edac_check = check_errors;
+	}
+
 	mci->ctl_page_to_phys = NULL;
 
 	init_csrows(mci);
 }
 
+static void enable_intr(struct synps_edac_priv *priv)
+{
+	/* Enable UE/CE Interrupts */
+	writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
+			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+}
+
+static void disable_intr(struct synps_edac_priv *priv)
+{
+	/* Disable UE/CE Interrupts */
+	writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
+			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
+}
+
+static int setup_irq(struct mem_ctl_info *mci,
+		     struct platform_device *pdev)
+{
+	struct synps_edac_priv *priv = mci->pvt_info;
+	int ret, irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "No IRQ %d in DT\n", irq);
+		return irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, intr_handler,
+			       0, dev_name(&pdev->dev), mci);
+	if (ret < 0) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
+		return ret;
+	}
+
+	enable_intr(priv);
+
+	return 0;
+}
+
 static const struct synps_platform_data zynq_edac_def = {
 	.get_error_info	= zynq_get_error_info,
 	.get_mtype	= zynq_get_mtype,
@@ -613,9 +872,26 @@ static const struct synps_platform_data zynq_edac_def = {
 	.quirks		= 0,
 };
 
+static const struct synps_platform_data zynqmp_edac_def = {
+	.get_error_info	= zynqmp_get_error_info,
+	.get_mtype	= zynqmp_get_mtype,
+	.get_dtype	= zynqmp_get_dtype,
+	.get_ecc_state	= zynqmp_get_ecc_state,
+	.quirks		= DDR_ECC_INTR_SUPPORT,
+};
+
 static const struct of_device_id synps_edac_match[] = {
-	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
-	{ /* end of table */ }
+	{
+		.compatible = "xlnx,zynq-ddrc-a05",
+		.data = (void *)&zynq_edac_def
+	},
+	{
+		.compatible = "xlnx,zynqmp-ddrc-2.40a",
+		.data = (void *)&zynqmp_edac_def
+	},
+	{
+		/* end of table */
+	}
 };
 
 MODULE_DEVICE_TABLE(of, synps_edac_match);
@@ -674,6 +950,12 @@ static int mc_probe(struct platform_device *pdev)
 
 	mc_init(mci, pdev);
 
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		rc = setup_irq(mci, pdev);
+		if (rc)
+			goto free_edac_mc;
+	}
+
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -685,7 +967,9 @@ static int mc_probe(struct platform_device *pdev)
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
 	 */
-	writel(0x0, baseaddr + ECC_CTRL_OFST);
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
+		writel(0x0, baseaddr + ECC_CTRL_OFST);
+
 	return rc;
 
 free_edac_mc:
@@ -703,6 +987,10 @@ static int mc_probe(struct platform_device *pdev)
 static int mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
+		disable_intr(priv);
 
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
-- 
2.1.1

