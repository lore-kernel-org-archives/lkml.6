Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D78ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571A421476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WgN/LmxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571A421476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJSQmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:42:55 -0400
Received: from mail-cys01nam02on0089.outbound.protection.outlook.com ([104.47.37.89]:52208
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726920AbeJSQmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/8kc3aAcr3R1duJd8xV18Ou+FFC82osfgJTCsQV6Yk=;
 b=WgN/LmxYSoTVPUG/r60U0a7TX1HyEnrZ+jjxwre0l3qVROQ225q4Y3GtsOmP+HarLf39VdWNptiTOF58Z5C9bh3ZddgKX6eRxkeegSEiRZYUADde9MNyJ3lwChCkZrlPYX+UWh7i2k3sx5hQZAfFM6GLZ+HNLpuRHI4oXuWylzI=
Received: from SN4PR0201CA0071.namprd02.prod.outlook.com
 (2603:10b6:803:20::33) by DM6PR02MB4459.namprd02.prod.outlook.com
 (2603:10b6:5:29::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.26; Fri, 19 Oct
 2018 08:37:43 +0000
Received: from CY1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by SN4PR0201CA0071.outlook.office365.com
 (2603:10b6:803:20::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.29 via Frontend
 Transport; Fri, 19 Oct 2018 08:37:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT007.mail.protection.outlook.com (10.152.75.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Fri, 19 Oct 2018 08:37:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51002 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQHt-000234-Jv; Fri, 19 Oct 2018 01:37:41 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQHo-0000uo-G3; Fri, 19 Oct 2018 01:37:36 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9J8bWKX029403;
        Fri, 19 Oct 2018 01:37:32 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQHj-0000r8-Je; Fri, 19 Oct 2018 01:37:32 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
Date:   Sat, 20 Oct 2018 14:06:02 +0530
Message-ID: <20181020083603.27602-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181020083603.27602-1-nava.manne@xilinx.com>
References: <20181020083603.27602-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(2980300002)(438002)(189003)(199004)(316002)(426003)(106002)(2201001)(2616005)(76176011)(51416003)(476003)(48376002)(63266004)(1076002)(5660300001)(2906002)(486006)(110136005)(11346002)(50466002)(446003)(16586007)(126002)(7696005)(305945005)(356004)(6666004)(36386004)(8936002)(8676002)(81156014)(9786002)(186003)(81166006)(50226002)(336012)(26005)(478600001)(47776003)(77096007)(106466001)(14444005)(36756003)(107986001)(921003)(1121003)(5001870100001)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4459;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT007;1:jzOqLL6v1sfVgnFU2Kqk8kF6H7LFhs/wTkY7Fpv3o97e9hz4GqQ0HCViTSChG4owHojl7l7gaesJYW0K7G8lYJWi7G77JrN7ZOWmxPHgXGu3JM16GpmFpWVdSENr4eML
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29fdccff-916d-4fc9-39a4-08d6359e22da
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4459;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;3:RRGPbBaUjMpm1PObJxJ+Ft5O2qVUvpy5Qe4oCLjFU+aEDMh1p5nwpAoSR1+8LkxG3yGxLPpYH6znKd8J2V4geM+tXz7b1hWxvf32TF3NlfsuMe1d8Q09SZmey4n+GRMm2q2VFmfvHAcPMDsbnqEwPtYQr/FG1m5yZgd6Tw7RcCx9+iWAt3MMuFxXoGWf6DcNdOEcju3dRZ3x9Bc2nAPwJM776cdqp+wqyejD/Cs9BibfxKfbXIbR++I4JINE1XcVf5bRl3LN7tZnc/B7zR4rrvizZoIEbyGGSnA0vTycd7zhVZcE5SpQTkM+wfk46uFYvOmtRZR0Py7wHgyvqKdo89aH1LfmwgwmnaveKpWLnfo=;25:q+Q0ACguC8VwPCCt/wB4VBEGROJKtzM4Z39gSIxndCs+l4xC/fEu9ITYhf9XRmcxBHN3NUIRPAuJyUZacrqUrFZung1HkPrNZqm7kE4XrW1mSsyx4yNhLlgA9Jt/2YPb5l11an25Y5uMEC6LLBFe6x0wfawNW2aIhG7UM2wFNREzrlvCgaIg049DDGs1iQ6F5/9wwPslcpF7Pm2fUMvP1uOeN+Eky7qGJHhTlP/RMMs7rl4M/zrxVhK0O+Jz/HeF11lJMQsW/gmHms49iZC5vJ6Vy5ifjgyabVfJ9TeGmvr6U62lV4PbIR+IHybk39n453ISNPLAnZ1VdjHJ/Z97/w==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4459:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;31:QvR3mPKQQjg4P/Q3XFrnZfCh/UxrZ54+yce/sSyJKulprw4mrpc80TwlyGQPcXJIh2BpQQlHR8z2N52cT16B0g+305UV4TWUglKt1zar1FnTVfvgZcKMC3MgHuHRJhl32QmhZNQI0y+FPVBLM296qFLl48e6oqVwf42cPZBVYGUN9oqbzw+Klo2CN5nb71BlEv0m3Atjb/EiJjSs+wIm/Oz1mQoxOitlfhFN/2+w2Fk=;20:TtLPaoxtdKWNSvvSlKrmywjBSx/U1rWvug9v57+BMfuN2UUMZZ1vImJxYxkzMJypH3Y5zRvW8o2SSwaPiB7Pc2sRODlT/ce+eOanGp6ffmOjMvhEZuUuFpwlTUZbwCR5/H8p222r2XoaEOQ18UQEC1wmJ5zq7Kyauh5abxi8AM06H0m6ZSuDYYcnTIvdE+EzUcIEw0zYVB2vvuiFNcxHYHT530+YxLjjvVTn1dNSg1/DWzYjbf/xEbAnVRXSkOXsq5GM/6sU9C/xpnvW2uBbAiDx4n1WkQLgPHAXbMuiOjgOJzP4fQc44vHSrgbfarI+6EseHhEKCI7CiKLJqF8HMDK7p8y3Hp1qwSX0rYRF23TeIliFfP05o+lIzVti9ahabJQrxM79oV7uZFgoMZu4uHNfTrL/SWZxMPCP9iUadD0a7GoFbOhJAHzSl6JYVkMWphMVpHlUUtxHiYCHm8INVhEa5LrWwHZ+ZND93CTHaSEzokf59lxGAgyXuGxqR637
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB44590007189304180A00E402C2F90@DM6PR02MB4459.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4459;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4459;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;4:dmUzxNb0jpYInPvNOaSl58faXeNXf6qSd/H/Q+HSufR9g2HpQCuhqmBb66lpsJeYoc/fk2ABsJ1Fc26kzDpWhRyF1J0MEujdP985Jor2cLW0N8FeL/psOlY5M3O1YzY09eK0La0XsUTwSXWy/s7B/5b8NjMeWJcNv/UxjsRzWsN940XVgvl6rEtG52+y7VCfNVg7CJk23yJvFRffqH+UWie3lvNPvA+Y7O4J/70G1r//NrH2snDJ9KWRwazjnmKUOgVZVSVc/VIheWjpmdlExs2DzQq+mqZQ/rE8rZnaTdR0YLqVSHn61GakI6EWmJSw
X-Forefront-PRVS: 0830866D19
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4459;23:gkZpQto8sh6jJfmHHPKPplQo2LWW038dVW3RpqT7s?=
 =?us-ascii?Q?ZikMbr0CnwdOzqSMu1tKjJACZdG6YWLO8J946zFJqceAefxVAmmGJKd6A6uX?=
 =?us-ascii?Q?/Brerh5TSzOsZHLezv4CjqcIY77DcT9DoGnrcGOemMB0gr3zRcbepZj8T9Au?=
 =?us-ascii?Q?99NVB82dARyZnLHvEmk7oVQ6dSko4NidoZmAhi4AU3js4ewqP2CUCxssooT8?=
 =?us-ascii?Q?0OqSADG2qxsfQxRLK6zvp9g9JViE6xuPxL6en9FnBja2Yi4iAU60gW5pivwc?=
 =?us-ascii?Q?y0qoHyK3489TQHrwGQkP9Tmx5MLUyftJBpsfBMkloa4hZxgnzYpihfnWsAEw?=
 =?us-ascii?Q?MAbjUlsmUiJJbeHpOGDeeiXKLkaSotTf69SNpE2hNlQTRsDPkS6nHtA+xV8W?=
 =?us-ascii?Q?Wu2dDzB/Fb132W6DtOBzVN1fv9LqjEHz0V2Wo0xtz/BzjiQ3+cvIHekdo3BL?=
 =?us-ascii?Q?8f6AlUwlHkMkw+UpgKigA8xyzYcKvYX1O0gImFh76iM5ccB6Br3pX9e5roh9?=
 =?us-ascii?Q?k19XGB2+xcsfLpPmjawxxN/YrMdOHywbsaRm2h6TsUIWnnx3e+WVNhMtK7/G?=
 =?us-ascii?Q?24tDYPA8Eo83IHhrxwLZ8O5IHfp0yTee7pAMQaHduDJHXygIKemPzDk55UO7?=
 =?us-ascii?Q?0SlfqlWfXUxBJyHju1w0K74452CZpd7aa4xVBXAbZUcp2yrrVh/WgVm8Xxj5?=
 =?us-ascii?Q?prWQ1hM4ddKBjwy/DfRtzL8I5xG2wLNeH5xnyited0PDpi1QsalaXZqIbgdO?=
 =?us-ascii?Q?qTWs/i+dUdNPjiLQnfjeFyTdxQats9CHjBYGYj2wuEsgte5eU6Dq94p0Skn9?=
 =?us-ascii?Q?hgvY2aDelLGeiZwOJslr05pqrLrRMST23i1cqTpDpfL32/XLDZZAEqjx/eWg?=
 =?us-ascii?Q?EVpwchk5/GNx3KP2ygfzG9ZBfUksumTU5Smz+XYCUnjt8BfZCY2LpnmGnHYy?=
 =?us-ascii?Q?rF3v5CEXS/t1vNhdOE26jsk4fa1bO8uJXsEf9XerlbXnxmLzeDXBrrbeTUFT?=
 =?us-ascii?Q?dWQSbgy8DKXfJEN0eMTaXtMZRcIFQhe1dzUvQWHjyi6eSYlHqiVvm65kFtSz?=
 =?us-ascii?Q?mlMEvEEzBx0zm0p3soZe9ItzPfIqjO/M8Iv7W0mhhC7R+DOU/QJiJ+Xh2N1P?=
 =?us-ascii?Q?iCMRYjIXEr+sOoihy6NoYfwu9vj/GQf+5Kjw5ebrIlB/QsFL0G+Dyj48KCfI?=
 =?us-ascii?Q?Wq8XoiG4JOp8lPw/BP1DkFS7qFTNO9xsfG4?=
X-Microsoft-Antispam-Message-Info: LyDzgIMFWnBohmqAcKhHPSi/627twA4suoLdGsNiX7xJuKtD1sOVYUafFf2v7dB+Wy/j1CYwgqLzyyOD4WGPIY7Y1k3JRcgSjQe0u3OgSXsUyL1xRlwXyPhcsoGIN031QMO9g6JM7tPgrVhhOM8TVS3mA0hNn6tWVlXh+pIuBxwUsa4GKzRDl2SUC28rbJrUzNXF5AVdACiIaZwk1iZLR/M5WzGA4HdrzMahQXBYuJloAOLsgehe5nuC0bcINcIamiz/6UiF2qkzTJlWbiS08KDdipr3srJxrUfZkGvydlhVU7tAcA8qS/rMF5uwi2meCAXq6HHFUjRjMLNzhjiuJ7IiWCMD9Wsb0lvysFdka1w=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;6:BaH6oRufSr0lmb1nVVbHPzn4VHytUybpl04vYE/0GZwspJPtoZACoYw/vGVE8Ruxwyez1sHVoz6ha8911uLlbCjncct1aELXBqHLkqYwiR+zkYHPEYa5EpcJPS5K9f/J36ZBw9Gj0GARRbhI5Pwfvl0Hm+4bsoNI8uKlC+YSta5jREMI9Et/pcZrYqB6Bqf2SxTM7jwIh7u1b/6f5wKs67y+B5dDJLUp3SlLKNfA5gyHsIYMZ9eDoyBpGlSBN5qraC40+OqICBjLo2484YauLSXQ1rQA/o2IsH2U/HiXw/PyoKGClVpkFr2sVrf14JvvJUU4Dbuthj9+ySz06H6A7KlVgQ5TheFmQ+bhGkginjhlcWtE4mB24BDUPfgcpyLS9nKxI9t/s/tu8Ppimn43AYmk8qfDBLqDopn3tmBfdKkfONkf+9CAOc5lp/IrZ6yeQ/HaN2Kzf7ZAGZtZlqH2Ig==;5:pBR5adyt4fUALzeJd8nHFCipYGlUoGsQu+WtNfJsa3GDcKhXvKTwaDgrOEKc3k+XxxskbuKs9CiMFY+FRVC53I4ssnnuE2L/yOeouoFco7Tw1QMMHe4BljWa7gZVEhtJ98YsYetzSASDlIrztLmTSXFe6GSvH9o1Cf7vxaPdWZ8=;7:C/MnSyxgCbeN154olF88w96X8G2Vz+gIIWlPoagEBTgsFTcxDIk7dd7OinFyo7J1k6S6uwDravc5PzweZ5wMEXOcl7qnJs3zgoDnV5VZ4V2495ARkDx4tETo2jghQZmRBLcYo2VK6jUKr6u2GX6ShEoom7KsJUSt6EyaSTcG0/fU1PNdwK/s641n5YMUfqgIxrQnE1dz+9yyPE3+11VCH0D0Buzcd3X6IMPouLo+YL9yTXe7qp3C8fjnEl/wE9hY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 08:37:42.1429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fdccff-916d-4fc9-39a4-08d6359e22da
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP nvmem driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v1:
		Created a Seperate(New) DT binding file as
		suggested by Rob.

Changes for RFC-V3:
                -None.

Changes for RFC-V2:
                -Moved nvmem_firmware node as a child to
                 firwmare node.

 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt           | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt

diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
new file mode 100644
index 0000000..0bafb9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
@@ -0,0 +1,37 @@
+--------------------------------------------------------------------------
+=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
+--------------------------------------------------------------------------
+The nvmem_firmware node provides access to the hardware related data
+like soc revision, IDCODE... etc, By using the firmware interface.
+
+Required properties:
+- compatible: should be "xlnx,zynqmp-nvmem-fw"
+
+= Data cells =
+Are child nodes of silicon id, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+-------
+ Example
+-------
+	nvmem_firmware {
+		compatible = "xlnx,zynqmp-nvmem-fw";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* Data cells */
+		soc_revision: soc_revision {
+			reg = <0x0 0x4>;
+		};
+	};
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+For example:
+	pcap {
+		...
+		nvmem-cells = <&soc_revision>;
+		nvmem-cell-names = "soc_revision";
+	};
+
-- 
2.7.4

