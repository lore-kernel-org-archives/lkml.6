Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E45ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDF620881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="y5uFkPYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDF620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeIOA4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:56:23 -0400
Received: from mail-eopbgr700040.outbound.protection.outlook.com ([40.107.70.40]:35328
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727002AbeIOA4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rRCt/Fp2LLqjvnno6HZDN4J5l5gTptrmTa7RJuTUAg=;
 b=y5uFkPYYrKfnNXtIbbvrAnN1gfSCzX3bwRznPGuy0rYHM1dP856l+se9ckwNqMO8L3PbaYO5F2u/qpEI1N0d1VQM6mwvvlu/gXglh+hJ0bgSn7peGZNvbNJfpUXKnvzaLBWycsckqdx/VX91VXdUqASxCiX2FWS2+ng2tl2Vd8k=
Received: from BN6PR02CA0046.namprd02.prod.outlook.com (2603:10b6:404:5f::32)
 by SN6PR02MB5118.namprd02.prod.outlook.com (2603:10b6:805:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Fri, 14 Sep
 2018 19:40:19 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN6PR02CA0046.outlook.office365.com
 (2603:10b6:404:5f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.15 via Frontend
 Transport; Fri, 14 Sep 2018 19:40:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Fri, 14 Sep 2018 19:40:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0tww-0005SF-MV; Fri, 14 Sep 2018 12:40:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0twr-0006TC-Ib; Fri, 14 Sep 2018 12:40:13 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8EJe3oa012253;
        Fri, 14 Sep 2018 12:40:03 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g0twg-0006EA-8c; Fri, 14 Sep 2018 12:40:02 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v4 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Date:   Fri, 14 Sep 2018 12:39:50 -0700
Message-ID: <1536953990-12755-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
References: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(438002)(199004)(189003)(336012)(7696005)(63266004)(316002)(7416002)(51416003)(76176011)(54906003)(2906002)(107886003)(106002)(186003)(36386004)(6666003)(5660300001)(16586007)(486006)(11346002)(446003)(39060400002)(8676002)(2616005)(110136005)(126002)(50466002)(48376002)(44832011)(305945005)(106466001)(14444005)(72206003)(356003)(4326008)(36756003)(476003)(426003)(8936002)(50226002)(9786002)(47776003)(26005)(77096007)(81166006)(81156014)(575784001)(2201001)(478600001)(107986001)(921003)(2101003)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5118;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT027;1:7/xG+jaS79BAtpVknc5eji4wpcQMHpA0Y3G13GCfJx8fEIKHPoLyuvvmx1j69LS/NczBmIb4MYcORi7t2vd+4WXm5OVeEld0j5A1ivK8He+VX8D5rdKTpEIm7texDSJH
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb61e6fe-a176-420b-cde9-08d61a79e76f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB5118;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;3:pBP0op7NwHhGqU3ufVhaCZJN85pEekIlKZpFnXRc85S3p8m3avASuP06ZyOCMwUr6HVgNkeb1cIlbs2aegs3nN2Pjcb3oalmJ+jBYyGM3+RTq5N686Qep9Lwb4+/l2nNLccaCrwEvcyCv2OikSXQuyfrd54MfkHzPQmpqfG+wnxL/QLxRHi5Op8ZM3C78Ofhq+GtwUeNu9XRUruIVxQOF4JtT5UxO3nfiZM3DaG5YE+kn3DzxKZ55L20ImDvFLF5w3MN1XHyI1h6u2s//0yApJLpm/fqi8HMaTcLlykJf0df5WutLRgFFMjDRXCshH9StTnTmNjpKXMusj7l2YK1XdHZH7CsQIxGdAqtLKFw/QA=;25:r1HShdLP/OjDJ40sLJmmehwGuHeLqZScR7thmaKBu4fQYYtZZflqj0mYPix2hhF+2CM3MRsSWDlu/f64unEBsirLOxihOgTjfmNWaPHTwZ9WEb5UNyIJB7tTVQoP82GqGLx+dzvwZjPnpUd8ZMrpMgjB8DKxUQyF7VaUO81oYd6ZDlwvuVmuHCZSxC4SKVVRalkIGQZewP8hMafS40ZzL4j0mfXm60GEX/Cf9wLW5tjhrkKbTh+RO5OnVhv2llIRGRi1fTRTouY1q7O7esr086jkxbpV1c6Z/B2vGgeP1JdEQcodGWUYByeNaQTHlH3dlVJTjw9aHJFCWPqhyDf2nA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB5118:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;31:DAkfzElsK+DeQSdQ88W9VewYk3eQcqCiCzYSqSeBgCzDQ50rb/y4GZd+2/DkkvwnHeaZPRtx6JFg0Nm4E9zoXsRC7Vi0/LP+j62jZmM8r8G62+r34jxRXFVM8YSs5BAP6oBa2JqbY7fqCI8zEnemU6L04Br3k5oFNSpaRF2POYtwEcJPcBBRknhtq6yfuE5BK+j6j3IKwYC3sbqX+jcbJUvftBhO2l1CAzAgYuaP4Ps=;20:xFhReFLuCIKjhIE6kKuWBbr54otVvlnB1Fo/Nu5NOg9iqsXE6uT2vcU8MEBJUe//aqtVFToqXIaPLIx88wRs9U1a82titBzDYTcybdxoYmecLIDb4ldmWbk6+0lcyYxAkNtcVQgenVh4vzPRreq0toshyw8r5JsGBnZ5cEq7N3niyn6o5U6qsMzK/X8XhGjIIfrTKjkpCKchruAk+Nz7zLFquU9F2U+k85Z0Ukiw+T2tqjytiHB+/IkAq/ga0P1XY3oGoMDa4PFDmygafWjZeDVUuvDuaRfHEViE9a5Y6gf+cZkrAIfeZ2VCWTvoJJYSjVEcvKA41esCc5YQsPQVS5Bdzv75Ta+xbjxDkX4guXtR1ZAO3cdl6tOgwKOa74TJ+E4V1oXiGzrUGKFaElh/v8QTJojce1NrxBYzd/7J7SQPXShCyVAsbPbOvzNG58E/ICqVMx4VRRYhbVFG5Z7IrgMg4gLv7ZTR3SIkmEfiRKq5MTefq6hpGhMajfScxgp0
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB511889C547C95D7FCB1F18EBB8190@SN6PR02MB5118.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:SN6PR02MB5118;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB5118;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;4:Tin8CasCahGNt8NzjQjzAAbMtPE4FkLZmYZJ5hFh2ok6aFojLUnV3TQpzVuLyg8IxnW4KlW9fILpsNef9+uNP6HgI5aasFlnrhi0VRwdyNICDu+w4J8+GCMfeWzzFjVc/PrmnZIrBWJIq/gznHwnWtp8htk6lpvEfFTXeswiKtcnCtlaYCCSl1EM/NRkMD1Op4XXKvyfvOW2MstoxMzLl7Irr08A8qvbWjIbfrNH0uYhHnmY5PG0jHmX3Ec+xdjuYuUYdgFH1vD01R3l3wGSpnB7MX8hqX3bT5wwQ577Kmu8JQDVSaMlxt3XjWpKBm/p
X-Forefront-PRVS: 07954CC105
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB5118;23:D+L+H9KmngJk036nQZBzpyRdPOgHMp5FWPhQ2l6jn?=
 =?us-ascii?Q?XKeWDToD1Tyj33lIyHLEYHr7qv6V4vcPRdElnViDWEAmADZlc0ttoyh4yxLj?=
 =?us-ascii?Q?gDaRPJKCNOyPdN5ERzzAcqTQjn6pQjc8tkpm30ogHU6UFvQVZ6d39WdEirN8?=
 =?us-ascii?Q?V5jj6Tk0KJQEzY3gJzDg9kQ0G49m/F3wU7T35MgjB7aaskyDzUJdv7JUP/if?=
 =?us-ascii?Q?IQ/TB6WQxFbnLGE/+2DKUFy6K9C1D0OoivZD8oYDmOlQl4NM5Gq9RMe1X26l?=
 =?us-ascii?Q?ZYxl177PWVHjyRQnNoLHOPHCzrK0iTgiWvLZxtmtBmVaMMp1OdBO0tyTMlxJ?=
 =?us-ascii?Q?zzrQ6Y/iezatgK5cE8pLK0AzOpnKpCwd/ejVjsSNhy4JqyyQwkJivh2WOGFm?=
 =?us-ascii?Q?gMaAupmVCf+JIIQcuAh0J/Rpe/xzWr5uBJpl4xHTaK7uigX7kknMZU0ESiga?=
 =?us-ascii?Q?nTXgJ8a/aPgLlCeZg/6CcjPfCe0mBfS7cmdjQm5KZ/kstGM3ohoB3tsHdo8X?=
 =?us-ascii?Q?8aSuHlYWp18PhE34EvEo10K9dPuVsMrOeqcKwZ6d9cIyoa2Nh81ylfjC0eQ3?=
 =?us-ascii?Q?34nyAR8L7+SQcToq+67pgceKkSPn90oighwROefGZaRA7wJBGSmhjA15gBZZ?=
 =?us-ascii?Q?UHzD0VdhU0qRhGIQbeusYjKk0mN6pQgjP7sgLWoPRG5sCYBWnGTu1pPSe0Va?=
 =?us-ascii?Q?VjR1wg08psui9puvjDcpF18xXrbEH07Fdvg80NdxWlKTJKLh3Ep9koZAmdFM?=
 =?us-ascii?Q?pdwyVgWsPmMuWNJO8gmDLYQhduyLGeNSI0HWu1s1i6t6sfbrSIjscMk8G8wL?=
 =?us-ascii?Q?UG85byfboDm/tGJbHsO5AJTm18fwOprBmIkpCk6KEjx8JBBIUowJ9M9vU8fY?=
 =?us-ascii?Q?WU/p5T9KwhWdcprK4ozjDqvM0VBndkN0++SEFX6f+wDfuP64q9by23UuFSS5?=
 =?us-ascii?Q?1vHNpaXtko0P0RQQBVEPNnG7bzi0YGaw55lVkMA3TOZQvqHqNDQEPiyXsjfU?=
 =?us-ascii?Q?wSjwpP9pmRzE9mdmQ8o+pWlw16NleUST9XrjO/sI7y3k18H25doXkkAXcUKR?=
 =?us-ascii?Q?nRxEZwBHum9dkHN+wJpACCv0wC1tuZXqE0+aEPiQoyUSKu/JyWgPBVU99skm?=
 =?us-ascii?Q?+QIZvKVmHYnOekfKfRj73Dadrz48kNZyXaCPOccvEl7ohCuXgGPo4yr97gn6?=
 =?us-ascii?Q?SxbEAEF3J214rPDW0GYYfMYeBrNiX4vTQjDLoCfpV6PfoOOB+soAtlkPzhLG?=
 =?us-ascii?Q?E8lK9RYCsT82Yblsjl8Ba8qx1so1l9FIaznLfd+/Nqgwl28KPRvATpFkKa4t?=
 =?us-ascii?Q?S9UNONgBjA3SIU2Zeo8O7p8qL1gUm8RHa+vCC5N5tvo?=
X-Microsoft-Antispam-Message-Info: xGlR5EBpj1AJoMyugFNCKgc4d87YTJklTkQeHuPMcXEc5qllk7ZCv/tzkhpHpscXu5TNBfsArw8JSx0ujcytqgSlT6eYqes5Ozd9MSN7+iotYEkt4GMrfYcH3sYj5W9bmVWCRpCDuuCo82dzS9P7tzRniG6qY496+hjpVDNwC1eTtqn8KYywLXeCWzgYhf7ydkERn4+tdlxbVkUclRdlT9S27ixvMJlQpDqQ0cC4V+WLUyIEDUq3E8Ilr+PZRHtOZ4RWSH4oKUpHSWiv4hG7PixfYLUUTuSi5RyxHcEbajbX8g2VtxziHkW4GsjPhU0JCoP7fdutF4UHuwwcJ4zRogwDeqA8SksTHa44VSuvffw=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;6:CqvP9OEPOormJ/ooG43oHrW+e04WTihAGxibeeInMTvmmFVHWGZoCWYlSblAhtxUaTwDwdil8lSaZ/wmzwOAAlJkWvq/L5RFotMeRh9gyUHlB5Wpl2qOqnwIVliXUVxNT0NsQNprk/Jp3ZA+PLjkyrhGqfcFz3fkmpRJWSKE3xS8YJzPApElm38sjBtxDhcp/WfdX2uuL4PpvlNgylUJVauRaKr0NdQWGBXxDCVWrd/n0x3c8ocMTvikDfFRa40f7vdEQFq8rLrQJljk119llbaIlqYEyxXuHnGhIyqh3Lp4gLcwyqip5tSHS70kJKmGu8NaKxsvBlLGAZ6ah/0Dhz15wgeEk4BV7wikohPvAUlehKJ1huNph88hx9YMLtv/JZ0DzV8BpC87Cg459tGYoIO8jIntK6tE6jKjwC5yNV8dIakHHh8v5DN1sJdI7jSbYXGot8isAit82TMn0qGdow==;5:chrsbvNQk1gSokEo7reyK7vRIjsSTQtIwldgeGTWn7mSK4zU/Pq1ld44T5LTbsMB9Z1gpKq/S46peHc8WEy5kw4iYuo4V/HI6VikJ7IoyVKAzOAsnIXekwa4dxWYL6m4Dru/+WKfmz03m88Kkvb13ogoyIsI0/g7kmNsZpYeDr4=;7:zQ2oFPu8cyR6FOppSMTSnXxT92IBgmvrmgDrP1xtfuAYaChQoXZDEN+Dl03uDL9DnIoQeeHUj2PrCRfQc9W8qOFrXAB1OmF2m/I9jsHCfMhdS46DPszaBvsT0BTGIGXYu/k6M1vXW1dj53NQeqdtCT0dHg0hn1BKE5VeUKi58e7+GibyGo0OeGr2jXDgrgC3Ek9Bjf4QeXnrvFoktrBSAeKIRxGUV2O+UtvqcFRRZhVf34Ab71fDG7VE+UT2FGPA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 19:40:19.3076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb61e6fe-a176-420b-cde9-08d61a79e76f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/soc/xilinx/Kconfig        |  11 +++
 drivers/soc/xilinx/Makefile       |   1 +
 drivers/soc/xilinx/zynqmp_power.c | 178 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp_power.c

diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 687c8f3..5025e0e 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -17,4 +17,15 @@ config XILINX_VCU
 	  To compile this driver as a module, choose M here: the
 	  module will be called xlnx_vcu.
 
+config ZYNQMP_POWER
+	bool "Enable Xilinx Zynq MPSoC Power Management driver"
+	depends on PM && ARCH_ZYNQMP
+	default y
+	help
+	  Say yes to enable power management support for ZyqnMP SoC.
+	  This driver uses firmware driver as an interface for power
+	  management request to firmware. It registers isr to handle
+	  power management callbacks from firmware.
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index dee8fd5..428b9db 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
+obj-$(CONFIG_ZYNQMP_POWER)	+= zynqmp_power.o
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
new file mode 100644
index 0000000..771cb59
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Power Management
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajan.vaja@xilinx.com>
+ */
+
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/suspend.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+enum pm_suspend_mode {
+	PM_SUSPEND_MODE_FIRST = 0,
+	PM_SUSPEND_MODE_STD = PM_SUSPEND_MODE_FIRST,
+	PM_SUSPEND_MODE_POWER_OFF,
+};
+
+#define PM_SUSPEND_MODE_FIRST	PM_SUSPEND_MODE_STD
+
+static const char *const suspend_modes[] = {
+	[PM_SUSPEND_MODE_STD] = "standard",
+	[PM_SUSPEND_MODE_POWER_OFF] = "power-off",
+};
+
+static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
+
+enum pm_api_cb_id {
+	PM_INIT_SUSPEND_CB = 30,
+	PM_ACKNOWLEDGE_CB,
+	PM_NOTIFY_CB,
+};
+
+static void zynqmp_pm_get_callback_data(u32 *buf)
+{
+	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
+}
+
+static irqreturn_t zynqmp_pm_isr(int irq, void *data)
+{
+	u32 payload[CB_PAYLOAD_SIZE];
+
+	zynqmp_pm_get_callback_data(payload);
+
+	/* First element is callback API ID, others are callback arguments */
+	if (payload[0] == PM_INIT_SUSPEND_CB) {
+		switch (payload[1]) {
+		case SUSPEND_SYSTEM_SHUTDOWN:
+			orderly_poweroff(true);
+			break;
+		case SUSPEND_POWER_REQUEST:
+			pm_suspend(PM_SUSPEND_MEM);
+			break;
+		default:
+			pr_err("%s Unsupported InitSuspendCb reason "
+				"code %d\n", __func__, payload[1]);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t suspend_mode_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	char *s = buf;
+	int md;
+
+	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
+		if (suspend_modes[md]) {
+			if (md == suspend_mode)
+				s += sprintf(s, "[%s] ", suspend_modes[md]);
+			else
+				s += sprintf(s, "%s ", suspend_modes[md]);
+		}
+
+	/* Convert last space to newline */
+	if (s != buf)
+		*(s - 1) = '\n';
+	return (s - buf);
+}
+
+static ssize_t suspend_mode_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	int md, ret = -EINVAL;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_suspend_mode)
+		return ret;
+
+	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
+		if (suspend_modes[md] &&
+		    sysfs_streq(suspend_modes[md], buf)) {
+			ret = 0;
+			break;
+		}
+
+	if (!ret && md != suspend_mode) {
+		ret = eemi_ops->set_suspend_mode(md);
+		if (likely(!ret))
+			suspend_mode = md;
+	}
+
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_RW(suspend_mode);
+
+static int zynqmp_pm_probe(struct platform_device *pdev)
+{
+	int ret, irq;
+	u32 pm_api_version;
+
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_api_version || !eemi_ops->init_finalize)
+		return -ENXIO;
+
+	eemi_ops->init_finalize();
+	eemi_ops->get_api_version(&pm_api_version);
+
+	/* Check PM API version number */
+	if (pm_api_version < ZYNQMP_PM_VERSION)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return -ENXIO;
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, zynqmp_pm_isr,
+					IRQF_NO_SUSPEND | IRQF_ONESHOT,
+					dev_name(&pdev->dev), &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "devm_request_threaded_irq '%d' failed "
+			"with %d\n", irq, ret);
+		return ret;
+	}
+
+	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to create sysfs interface\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int zynqmp_pm_remove(struct platform_device *pdev)
+{
+	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
+
+	return 0;
+}
+
+static const struct of_device_id pm_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-power", },
+	{ /* end of table */ },
+};
+MODULE_DEVICE_TABLE(of, pm_of_match);
+
+static struct platform_driver zynqmp_pm_platform_driver = {
+	.probe = zynqmp_pm_probe,
+	.remove = zynqmp_pm_remove,
+	.driver = {
+		.name = "zynqmp_power",
+		.of_match_table = pm_of_match,
+	},
+};
+module_platform_driver(zynqmp_pm_platform_driver);
-- 
2.7.4

