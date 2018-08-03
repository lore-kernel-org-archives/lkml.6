Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EC6C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4221D2177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FI/EJwAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4221D2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbeHCTwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:52:04 -0400
Received: from mail-cys01nam02on0056.outbound.protection.outlook.com ([104.47.37.56]:20213
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727843AbeHCTvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae3uMsPM9qWtcPtZCcchHnnmLXzK+8XsulKYSv1xPnQ=;
 b=FI/EJwAjOiiTYfjgyU0qYCCdSqEqG5UboVtajbpJixXJo8HsUhCNSxSCP0ZXzojQTuZhJh1Mz3kEC9cRfsXv9CEVGXqS+K0R7dK0YDRijdee8CgdJH04tfjODtgceSDZMit6xrALZN/+baeW2l0rRShQyTUKV/rkzUYY4v2bWaE=
Received: from BN6PR02CA0088.namprd02.prod.outlook.com (2603:10b6:405:60::29)
 by DM6PR02MB4458.namprd02.prod.outlook.com (2603:10b6:5:29::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.14; Fri, 3 Aug
 2018 17:53:54 +0000
Received: from CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN6PR02CA0088.outlook.office365.com
 (2603:10b6:405:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.14 via Frontend
 Transport; Fri, 3 Aug 2018 17:53:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT051.mail.protection.outlook.com (10.152.74.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 3 Aug 2018 17:53:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGu-0004fi-DG; Fri, 03 Aug 2018 10:53:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGp-0007cn-9X; Fri, 03 Aug 2018 10:53:47 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fleGl-0007bh-No; Fri, 03 Aug 2018 10:53:43 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v11 09/11] dt-bindings: clock: Add bindings for ZynqMP clock driver
Date:   Fri, 3 Aug 2018 10:53:26 -0700
Message-ID: <1533318808-10781-10-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(2980300002)(438002)(199004)(189003)(110136005)(16586007)(6666003)(81166006)(50226002)(106002)(72206003)(9786002)(36386004)(316002)(8676002)(54906003)(8936002)(305945005)(478600001)(81156014)(7416002)(2906002)(14444005)(356003)(5660300001)(11346002)(51416003)(107886003)(36756003)(77096007)(26005)(426003)(446003)(76176011)(44832011)(4326008)(2616005)(476003)(106466001)(126002)(486006)(7696005)(336012)(186003)(47776003)(50466002)(39060400002)(2201001)(48376002)(63266004)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4458;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT051;1:r2aaelOlGinHop5AwkglWkdQGiko7SdFguC1UTEs1ZMLw6EOu3O3TR/38D7r8d0yBGJlzhzQnxPuCf70DmEp4uoomt3QCEihRgMc83ykJDqA4j5H+3LV6MEFFZdwi7L/
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3e901e9-096d-4104-a2f9-08d5f96a13ef
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4458;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;3:PFwFIbFWgQNHpmBa7jNoZ0zs/Zf4zzFVT9ICaAHrSvZKtI2gWPdnExfaHWU/QtCrQTMNcR7l9kIk+DQVkCyZWNCdiGrPqDmUeVYB0mf2bSvDJtzU6rL6bgtSdE4oEYDf+Hn196zI5uZ0/DWq+on2XqgunWBX4F1bBSFVs1T0Di6r5AKZJxi/AxTgJppOi+/yncQ55Kx3TKDVUzesb0uFt6M5rR04lVto2hSRYZGzorgxqjxqjzYPNg6fZrcWJS9Cxi6e3pGvspF88Mn+aQpVDOPRtHT5VEDwYMygoVM4X5aDy7IVogJbw0GQIQyoDK37mIoNNHOEDClzi/Gh6NgH15sKOTi3FMlWZqIVSsDVdBc=;25:zig4Iv1wWNgO2YBS4QYVsKRamvs9x4tZ5gIPyWPmQ/8DZzpJKRsflVYoSONxM3Qec37xwOM4i52C6fKohfKxi6Xd8772vrYMluXBCm5ZAWRt5GTbNeVVBWsnXIs2QWiXkuEv9qg32XjqmquunP5dfW7yV8Y6Dv4hbbS3WWEkKpBg3ZKqOqz+o5eJ9dWofxxoJXDlDb6kssBLRxZygZ5QCa2+WLWSpAmW2GoM9585XTnf3Qk2E4B1QJlvnSlC1X1vDOco0YjijDAL6Jv1stLkLCREKgZLzYkAuiFw6qH5GkpaDlyRYz/vkZMuqRmCO3P0B79rF6uasVOhQRfi2H95Fg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4458:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;31:aPIZIyCms8f+olId4AeZE8pRsFfsvgO5+/q5Wb0zV5SwBML1C7GKWIII87SsIdcv6nuTCK7A7Q/DmJjcj0BtSi3mozaKpbgrgCSMpEoZD4hzdoPFpZEJFjL/bD9lKepLe5ZwDsL4gNaot4zEfL1W6fHEjhoguTroXj+UA7I4lq89BVYLn5t7UtgbY7xHtH1czP1njT2AzS2+/d57rY3LBH7WoSVfjId+FAfSum6sSkA=;20:vRhrabWK/L3tvahM4UVZr3mtapwp+Zd29VQxw+VOXeGI2baTrv61j6nmARvijN1yJFv082sRJQtmIL9lhOQ7tOyKEMpxpX39Dk5UEIosAy4HXxaJoThc5a3p5xdyZLGj7gDMclOgHQFvRV9fmnSTjyZc2C+52sIyvXJj4h26kDNblSfXOoSIL/iaPlGggnnnpYpxlQlBv5awLE3ovK1n+Jp56LChSCnR9AbeKa5O1CzXOvXJmE/gMs80Hz6R3L7xEI+IV7jPKw5ObVDPkMOqvZzT3Vv41YnOVBn80xFy6D8FJ6nx4PRwhGSeHOMxZZU7KmSdAOxQkWCdxoJjPb2SszPXpQ4SwILqLz0X8oV8MTIMThqYbMSHxMamZ2DSyhUi3RTlPFRq1qVqUacj79V1MI0PGTL2HvbdgdX30qPbobtk4lL1GiNn6/pdOMBxDRw3fXIFeuds1+LkEtQiqjT7YXOY2I5hXgzFYfSY+QWvVQl1TpNOU/JRXqDwepwR5l4E
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB445864027854CF1355F56F27B8230@DM6PR02MB4458.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4458;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4458;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;4:/mexK16c4/CPTktwuWtd7fSd04+/Md4/7N6DHUYdIxBprYYDQA30zlVjXjBilUnmIhOid1hVE0s00qJs6DHpNEr/u46rR302iB9yv0s7Q3AVV7QYOcBSmylWgfP17HMkLjvEH6+/Suj9R8KjSdpHp/ARtXUxEdIoLLRizSs141ulsPTsH2tv1wVD/MZepGaiRzzMf1uG4ii9I/lKFsbhw+VVXRFIjZzvB64kYiV4CouZqASeDzq9+1JANgXfrwfphr1HKDPlje1fQ2wHHsBXMT7yIG31GoU9VBYRQ6yRGY71NniMQCzsaS1/JZn+ybst
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4458;23:xwee+5SQDhefFzvX3mraisWTaB2oMx55mZqnSzcxY?=
 =?us-ascii?Q?kGSa5qXC635bSJJoPBmXpDiBA6sB6L0NJToWD7bsSamKMZNyain4qKA8FuK5?=
 =?us-ascii?Q?Cp9FqlGu22CyEVOd4nnU2ICtC9JbloO0Rl/HF+y942lRN9Vz+K5kRNwf6Fln?=
 =?us-ascii?Q?YThY/weyeBjI/kY8wszOVmu2OX/K2YWpdImrZBESoEgNiIiFGvSdq293DQzO?=
 =?us-ascii?Q?lwnRqvnNY/XAkYDgdRndYZhA30Jp5vJXXwLb9Br0ZHvfq8Gn38nEkoBHVbYg?=
 =?us-ascii?Q?ntjeL76Vfgk5chYFwJOGXT5EI304e96796FiJK48nNpv5IziH3VbGRhrOy0T?=
 =?us-ascii?Q?Hwf2Tui6+6IVVmpJ8TljYnFgj8nq2S85Mp9+K9+gbl6RHYz12DV0BIGD5Zwa?=
 =?us-ascii?Q?Yl3GUyPw8sD+6EVszHQIanTnBL5mp/2elwfuEg56c8M+Y54IJNBV+Jqm169p?=
 =?us-ascii?Q?JNvLfr74/2TDWUvu32orqtOUrDbzbRo4pp5mLTmpvZEuz5gYmmOXYK/ekg9l?=
 =?us-ascii?Q?T+K9uNH3lYCN3SyPkv/sta4n/YqZrOMd53L9P7P3hZl2SdpDZDs6ZcJRjWPJ?=
 =?us-ascii?Q?9tzHLLmlplv8L/fkVpj2ZV5sADg9JP8DQf8YNppqbW0nkstrPq+JpcltuHit?=
 =?us-ascii?Q?/Gu4XMfqk7DVTcpph3hfpIMwqxJOxtg4e35o0kRaRHhMzs/jOIJrtzirij4S?=
 =?us-ascii?Q?+5aXAqI0A38vfvuuJPmgqD221rsAU90NxGr2tkM1HxfQWm0h3yeJYG1Xs/xx?=
 =?us-ascii?Q?Do9QvFqwNcvueIbeYnoMHlGryHChjRuFktWCgzw83EYBBcfrKv2K7hQpnRml?=
 =?us-ascii?Q?QIkdr/aqxDlxDsc1dpc7g9e3HQ3NpQezQVIv1Pk6cVbAZA1PNEVax+mLj+Ks?=
 =?us-ascii?Q?eG7rDexBTIwQ1k9tZhwKIVmPFv6Endo91b9m5nGWNCbwLWT7Fm6119kSoRr0?=
 =?us-ascii?Q?GHdxkzn6EuZYUvcYkl555O7R2mZmPteQNg8Tx6ZA1c+r7705HWXw6Bh2Srgj?=
 =?us-ascii?Q?+PmzeXGAOo2z4mKykGItFF+Xuz+PxehE10HkTJ4qsULyuTBcpJHoy3WJ/z+5?=
 =?us-ascii?Q?NryAporWaSsJ3SxNk4Zu4Oi7BiB/9L9CeMa7X4NEeGhkcXULYlZNihwEaTpI?=
 =?us-ascii?Q?KJY7GATwD+RpDzifLOI3wxNddxI1jwup/6Kw9sStjzAG/FlrIcHTngfWw0et?=
 =?us-ascii?Q?iA6C70UVnF/zZxQgC7bBH1JKlIt5WxG+6+rzbzPi0r+ZFOtZIRpk6Ffz96Zu?=
 =?us-ascii?Q?86McbOMljUQttNbK8kb8zsqqYo2KEtC2CzRaveq?=
X-Microsoft-Antispam-Message-Info: wclvtrzyumn/KBLhIbNujKXB+sBcaJ5At5qeWG1ZQRTQFahoFQd9hq8U6V+k4VMhS84Y+YKobZK7fw0Y8+ZWAay4EgwNFSh/GwsFeaBBm6S+yksBg70LZNJklNotz01kke83jfhoswnSqcssI1ygMtfbXKOWCZBgRIN7zxmvMQbDNevOFow5GxPVeBuUvbexXTyb4zQ6yIspRFYeop2j6Jb+TY6sVwlRZOFi/0fOzb9zNDlHd8GyArD8SO0VwXt0xC8w6anMhaKM4aB0n5gZUJZBzKv/Dcp5QzymxQlNJ0VMuL773AyKTw/l6HiU2jsmSF5czvDpqeWde/m3IZ5QcSD/LjW4WTcTV/C2AKpf+m4=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;6:IBHHntVa4dlq5QTh8LURikXic+rbzUx9OsNAR6BsDa1NfyrYA9PLe91CEb8OcXWiATeeAzLZSF9q7OTgfZtqOx/KJ/JS0WOsjjINxvQAGCe258FG/wDg1zQU4NzRTYczH+pjNHKzhfr8GRRtkQMsKM/T2tIeygnUKEH+jNljpVwFoOzSt4BCIcptzFVBA1iyLz/GSoCutHsmfir+weMJj6wHCMn94Q1OiyiOGr7x0lJhIGhFXuVn0e0eXu7CJUmbQEkIy45aQCVSk3xFnpIM1/Lnaao4X3GoyQzPhmOM8T7t9A2FfPobNWAgLIjXAlfEzyCJpzmLYvBWHP0RYiygQQSz7eh7sEzMpm7yL6FOspR7guQK15tRht7vfJuSvg+c3WqtmVF3n//Y8jMfCGZmMsbd3/cQkY22pwvdXlXEY0hiFFmGTKq7cdsA2lEF1F3H/Jm8LRF8Cl+41ZZQV9QFww==;5:JsxYzcQUL1tVyB8Y2WFuzf5CU6PoCtoElkvTcJ2qN2LqjHQ/pCb/ZS7vqVrUQmrcn5rRgsa4ohloleKoOKN6hLLwzH2pjsEMdryZTPRM70Z1dyRu1rfBqKlZS+1YisFtYK8ikc0dEonnjosiGwfYkQfLV6E0jr3rBzJw+muBwpA=;7:SWFVkAVa2OixXXyCLAb2sKQc+8x2cL97GXGkPGS/3oh9Bc4ZCYBB2EZsumpcSltzI2wTxXFq0+FmwJpP1PAIeV2TSc8nqIa1Pyn9hemb8TwbstcZeJKVSZqD23P17cm9x3NBdcjpwGEn27Al3xSSlmGwBIrrtZCscqA80PLwIlDzS8fSHLRRgPc2MrS0Eo1KqppT69Q43eLOR94i7eq9XdkEviwd3lcFzTMpwuGt109mYguNTnW9oBaBvdzsoS7E
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 17:53:52.9427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e901e9-096d-4104-a2f9-08d5f96a13ef
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add documentation to describe Xilinx ZynqMP clock driver
bindings.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 +++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9..d215d15 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,53 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
+Zynq MPSoC firmware interface
+--------------------------------------------------------------------------
+The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
+tree. It reads required input clock frequencies from the devicetree and acts
+as clock provider for all clock consumers of PS clocks.
+
+See clock_bindings.txt for more information on the generic clock bindings.
+
+Required properties:
+ - #clock-cells:	Must be 1
+ - compatible:		Must contain:	"xlnx,zynqmp-clk"
+ - clocks:		List of clock specifiers which are external input
+			clocks to the given clock controller. Please refer
+			the next section to find the input clocks for a
+			given controller.
+ - clock-names:		List of clock names which are exteral input clocks
+			to the given clock controller. Please refer to the
+			clock bindings for more details.
+
+Input clocks for zynqmp Ultrascale+ clock controller:
+
+The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
+inputs. These required clock inputs are:
+ - pss_ref_clk (PS reference clock)
+ - video_clk (reference clock for video system )
+ - pss_alt_ref_clk (alternative PS reference clock)
+ - aux_ref_clk
+ - gt_crx_ref_clk (transceiver reference clock)
+
+The following strings are optional parameters to the 'clock-names' property in
+order to provide an optional (E)MIO clock source:
+ - swdt0_ext_clk
+ - swdt1_ext_clk
+ - gem0_emio_clk
+ - gem1_emio_clk
+ - gem2_emio_clk
+ - gem3_emio_clk
+ - mio_clk_XX		# with XX = 00..77
+ - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
+
+
+Output clocks are registered based on clock information received
+from firmware. Output clocks indexes are mentioned in
+include/dt-bindings/clock/xlnx,zynqmp-clk.h.
+
 -------
 Example
 -------
@@ -25,5 +72,11 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		zynqmp_clk : clock-controller {
+			#clock-cells = <1>;
+			compatible = "xlnx,zynqmp-clk";
+			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
+			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/xlnx,zynqmp-clk.h b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
new file mode 100644
index 0000000..4aebe6e
--- /dev/null
+++ b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_ZYNQMP_H
+#define _DT_BINDINGS_CLK_ZYNQMP_H
+
+#define IOPLL			0
+#define RPLL			1
+#define APLL			2
+#define DPLL			3
+#define VPLL			4
+#define IOPLL_TO_FPD		5
+#define RPLL_TO_FPD		6
+#define APLL_TO_LPD		7
+#define DPLL_TO_LPD		8
+#define VPLL_TO_LPD		9
+#define ACPU			10
+#define ACPU_HALF		11
+#define DBF_FPD			12
+#define DBF_LPD			13
+#define DBG_TRACE		14
+#define DBG_TSTMP		15
+#define DP_VIDEO_REF		16
+#define DP_AUDIO_REF		17
+#define DP_STC_REF		18
+#define GDMA_REF		19
+#define DPDMA_REF		20
+#define DDR_REF			21
+#define SATA_REF		22
+#define PCIE_REF		23
+#define GPU_REF			24
+#define GPU_PP0_REF		25
+#define GPU_PP1_REF		26
+#define TOPSW_MAIN		27
+#define TOPSW_LSBUS		28
+#define GTGREF0_REF		29
+#define LPD_SWITCH		30
+#define LPD_LSBUS		31
+#define USB0_BUS_REF		32
+#define USB1_BUS_REF		33
+#define USB3_DUAL_REF		34
+#define USB0			35
+#define USB1			36
+#define CPU_R5			37
+#define CPU_R5_CORE		38
+#define CSU_SPB			39
+#define CSU_PLL			40
+#define PCAP			41
+#define IOU_SWITCH		42
+#define GEM_TSU_REF		43
+#define GEM_TSU			44
+#define GEM0_REF		45
+#define GEM1_REF		46
+#define GEM2_REF		47
+#define GEM3_REF		48
+#define GEM0_TX			49
+#define GEM1_TX			50
+#define GEM2_TX			51
+#define GEM3_TX			52
+#define QSPI_REF		53
+#define SDIO0_REF		54
+#define SDIO1_REF		55
+#define UART0_REF		56
+#define UART1_REF		57
+#define SPI0_REF		58
+#define SPI1_REF		59
+#define NAND_REF		60
+#define I2C0_REF		61
+#define I2C1_REF		62
+#define CAN0_REF		63
+#define CAN1_REF		64
+#define CAN0			65
+#define CAN1			66
+#define DLL_REF			67
+#define ADMA_REF		68
+#define TIMESTAMP_REF		69
+#define AMS_REF			70
+#define PL0_REF			71
+#define PL1_REF			72
+#define PL2_REF			73
+#define PL3_REF			74
+#define WDT			75
+#define IOPLL_INT		76
+#define IOPLL_PRE_SRC		77
+#define IOPLL_HALF		78
+#define IOPLL_INT_MUX		79
+#define IOPLL_POST_SRC		80
+#define RPLL_INT		81
+#define RPLL_PRE_SRC		82
+#define RPLL_HALF		83
+#define RPLL_INT_MUX		84
+#define RPLL_POST_SRC		85
+#define APLL_INT		86
+#define APLL_PRE_SRC		87
+#define APLL_HALF		88
+#define APLL_INT_MUX		89
+#define APLL_POST_SRC		90
+#define DPLL_INT		91
+#define DPLL_PRE_SRC		92
+#define DPLL_HALF		93
+#define DPLL_INT_MUX		94
+#define DPLL_POST_SRC		95
+#define VPLL_INT		96
+#define VPLL_PRE_SRC		97
+#define VPLL_HALF		98
+#define VPLL_INT_MUX		99
+#define VPLL_POST_SRC		100
+#define CAN0_MIO		101
+#define CAN1_MIO		102
+
+#endif
-- 
2.7.4

