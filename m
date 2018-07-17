Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AF2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7967A2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HCGGJHS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7967A2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbeGQUen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:34:43 -0400
Received: from mail-co1nam03on0087.outbound.protection.outlook.com ([104.47.40.87]:2340
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730840AbeGQUdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdxoCw6N7PsaVehr0K1ijk5/waIm7L819w8sPs4IDqU=;
 b=HCGGJHS4HmxgG8KDHhK8DemH0NtgF9tWbrYj1+1ouTy8S8lViBrscefHoqh2XaLXIBYDqkvqeWoNxGf6j5LCzFZZH0810OhCnZelT3SE/9Er8xba+jlw88g8OMUfHTcgj/ExVUFdQVvlmZnKz5Ms7ktgyIi1Zq9FUdQSEVLzhWo=
Received: from SN6PR02CA0033.namprd02.prod.outlook.com (2603:10b6:805:a2::46)
 by CY1PR02MB1625.namprd02.prod.outlook.com (2a01:111:e400:5299::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20; Tue, 17 Jul
 2018 19:59:34 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by SN6PR02CA0033.outlook.office365.com
 (2603:10b6:805:a2::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Tue, 17 Jul 2018 19:59:34 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Tue, 17 Jul 2018 19:59:33 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59442 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW8C-0003Ut-Td; Tue, 17 Jul 2018 12:59:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW87-0004zI-Q3; Tue, 17 Jul 2018 12:59:27 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1ffW85-0004y7-2A; Tue, 17 Jul 2018 12:59:25 -0700
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
Subject: [PATCH v10 00/10] drivers: Introduce firmware dnd clock river for ZynqMP core
Date:   Tue, 17 Jul 2018 12:58:57 -0700
Message-ID: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(438002)(199004)(189003)(77096007)(54906003)(486006)(44832011)(106466001)(26005)(476003)(107886003)(2201001)(6306002)(36386004)(50226002)(110136005)(4326008)(8936002)(7696005)(9786002)(106002)(51416003)(426003)(356003)(48376002)(36756003)(5660300001)(50466002)(81156014)(81166006)(7416002)(305945005)(126002)(72206003)(2616005)(966005)(336012)(186003)(16586007)(39060400002)(6346003)(6666003)(2906002)(316002)(478600001)(8676002)(63266004)(47776003)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1625;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT007;1:cSK2bCOTSY3749v9JKYrj1vPuLt/xlw8fz/9lrqBIj51lmFFMHTd7kk/DAkUJbsSOCOBvKso+MvWbIEHvQxSQiQ5XgbNq2HJNyyM2w34e6xfDPZcOkiQbYHlgxXVgu9p
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81f21bbc-7874-408b-e6ec-08d5ec1fd141
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR02MB1625;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;3:Ui8UffBNeFFrjMqjhe2kx5BU0R/cuG/ONv8NueoKwKNv9t/mf6s3gd8G39Sm/jzGvxDvOiA2OeLCcSYfnDownhQEsW0JT6CwK1po+LM1EZ52vHKT+0r8xMAevhwylvceGoE0m1BwNbYYJxai2XkVB38ag3sWA/hIca/jS8IiXoy4u7b3KGDUA1O+sK4RCEXIvtZsIZCqJqVpiOIBde6hPgvBD5EC+KGRtu+Ms9NmQh1FETUixh7kKEVpe3Mmv+4Rsk1pu1kAwPM7LFZwatRgulEzxFSwSxKUP1bpWVAD3wsduydv78jOMC5ywRDXYjsaTpXrrx0VfMivClnkrcsAMP7VcFhHvZQ5cqVhMjwlH8o=;25:JPNe9zAkyeKBUvvRhJ/bJIS5hrINA9aa5FGCi9Vk7bLEixWZ7q2OFABMC+Lof1rkEk32ARu4Q4m6nIuLlCscOD807QtgRjLYM2mK32/yGzOLIZcBwACXVawAvAVhTJk46YymruWsTQPgvyUk4QkwqlCFos1dk2EDr2yDIxSHJoHeW+vtgk7cbd8gtbTkS+wH2978pl62t6TG1hIY1zdnhY8noYSbeqxVCYu15Mmw2iXPS+MxVjJkk9JGLmjJTZq8W87Rmtet4zDW4MbUaEx43wGVwzqma5NQTAGyr8BrGFjRJwfj1fJS3YGnXjpNpRAfmBQKV98DXVAcWlC40iUY/Q==
X-MS-TrafficTypeDiagnostic: CY1PR02MB1625:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;31:K4vSgYZoLbSpAwVvc7p1S0DRlc3pUJstlXad4cdRWXAf6oi8082x9W+h+8V+TFU+YDGfAbtE5NlqAGuAyJYK1ZYHbKHzxZLapybhVkrHFpz6JcnkQovh+s7dUT+PzesF03JlEfjyo5TJLPqw34TpHAk7coyZIznWrLPd2WnRLClkYU9O/+LudneALSOUolppOs6QYHJ094tU9rR9G7hEgzE6M0ODie1l3aSZJVf75LM=;20:Np1/zbR0SwDca8413F8pqFA3JZiYgFjAAhyHKGVKJrWyRSqy2uTt0fciC6vroDOylpxWaVIvyz33xEiOk8ZmQ141eH1Q3EoEIUJcZ5uixMXuZAJOkweayQ4dn5G4XaMBCvTlCqfsQbbOLjI4ds8yb6xtL+wK+urUgKpYYi7vII/ujMKrIHS1PfIg6gQQZeW4stQ4U45+CekJaLjA19vDCq3fKCd/eRdxt+aYH1q/aHLzvuYGKqSGMkwFBWKyAZOhHLBioDy+aBZ3U762pCWValtxnLriTYsE7wgFRyd9ZW75mIgQm6mCfAFNuaQhBwTrD8Vqnp89AgesCpgTJtRFXUJOAwv9UGTgVZS4k33KbkYl5YcVI/2f54z+2npq6yrfTQC/y//i2GirEaqjMvl3oxeB05+aGTV2B98ooJNXj22//Tyqr0A0LSyYxd0m+859q0bjvSkiR4Jn71lf/y7Kb51IRZNm2547xdrwrAO/zdpwIjv5s4q/O3gUj2opGxkf
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB1625BDCBE461B1F9A5BF5867B85C0@CY1PR02MB1625.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1625;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1625;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;4:LbQ2ouHVv+KBKTPOmNKCxWlgePwqf3FkJml4ZDJ0Ze7+fZwoeZq7spZ6TIret1eYv2DaYHIN0S7m0HvSUemBXeh/5owmhS1Zex7l6UcpyHjDDkS+pAo8g7v7QfAaJHgeOxjYSDwNMRk0KI8NLbj2gEhJDILGZ6e+Erp6bNGlfUc47SlUyPR584V5Dpn3GYjzM33Qe888MQ/XyNhKo2Zy5/DLlH3h5xdAKIS1LyhMGpJX97/hWjuBBRYy2+9//Y9g6CY/G0eVRJc6OoVDRfsMoQ==
X-Forefront-PRVS: 073631BD3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR02MB1625;23:71BZLpKYz5jBKB7a3owQhXsSs8iOVlgGo117OmYcB?=
 =?us-ascii?Q?8R7FHAd6XCvGesezcWvB1NFu/osCB8RWsSNudoXDMocSu4OISrHDPls28qiO?=
 =?us-ascii?Q?1p+HNzRJzQqGWlLAku1RaVRiZWsW7v8yinV5IhbLwHb6BxzWooM6Nw0aRiP7?=
 =?us-ascii?Q?00t50ciY99XkB0LT58TaE7Pu+zIosSvVfS6yD7IUtdIUA9t4QoFKSUFDfWDn?=
 =?us-ascii?Q?ZOCKTdM47oYgPueIcSzF+aD1tl3G4x6pWdG4JsLFZckE0VfNtFjD1QRACkCM?=
 =?us-ascii?Q?qTBGaBXBQ1ReWMg7GRpgmmfd8IrCvFxqH/hV3PMK83JO8IJf5Stps3NACEVS?=
 =?us-ascii?Q?oQreGmpPjw9QUMKPHHRYNk8evsBtLscVBXxFc1DI2hrC7bOdi/xdY1mdPYBJ?=
 =?us-ascii?Q?608fMyKVvHEX+YDUVn+RWuQACwpMBDfyhFCxHdmkNjVm0bBe4cIFuASg0P4a?=
 =?us-ascii?Q?IGvchJTCgrsdv0x8hRII5LZZgXiOC8bFWyZ5i0fGpS/f79trWQuCuzyVSBOr?=
 =?us-ascii?Q?fucmZ9hTU9Kn8mig//JxT4/N2jflvNk+ndT/TAegqBvDQtxelq4MEI93eaPO?=
 =?us-ascii?Q?YY4WV7xjUxsKFq6wJdqHmmGG6e6SIyitnLQVDzDBoFn1+Ks4KI5zIS4czC3K?=
 =?us-ascii?Q?DVT/6A2qgPCCvD4UzHDsXVObr6pvbk+0xuNeXu8lKIVnZl4bHMuuVbT61u7v?=
 =?us-ascii?Q?nooGJYUYLxOWhruUiPNfOvbQRgoLglnMUybsxVV1IkINAyw9kN4rN4WugkYH?=
 =?us-ascii?Q?VcYZApXg6VUrbsXCbOB/GkszPV3+XphRCqbXch63oXNXJ099eMobnk8AGdxW?=
 =?us-ascii?Q?xO8hEa3alFw+4rfgsmKjWGEVp9FJPIg6ZlcMoTDlIQaNqkHsJ2ZGrUTlnoj+?=
 =?us-ascii?Q?KqncwSryHVM2fHmDLmPzc6ZJB1CEHoxjwnOx4LGl9CvTnS4mqU/1LvkMOFfl?=
 =?us-ascii?Q?vpD1Ygs59gEA3tLSJKh8YgM7QVD+AJb7+D2ytqqvzfVhMLR6/CwkJebSdK+h?=
 =?us-ascii?Q?euxKesjsS6ImrOfvILvitBLHqCNOzut/VAcsyNQYwBEPSpUZnV7KoF4BJK0s?=
 =?us-ascii?Q?n2AcA4JvhfkoIkV+cwUsk+98oaxmp1VFIdexpKdcia2C7p265l4zTYIeOf4N?=
 =?us-ascii?Q?9eD5GJFS3h+cnkMUeIUMzwe97l8gg2PgVHKNpZ3yRhjv5PFCUzhTqkZ3jMR4?=
 =?us-ascii?Q?69F6BSvabW/s32vneeg5//+QmU1qFIv7a93xewvpPPQ/CpRc7RWOI3Nd++/Z?=
 =?us-ascii?Q?zBgrXfpAXCbCAUNq/OOxGmpkcnpJ8UqUDK9mwuAci5k+IQTZhBMB5I/k7JOz?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: 4GmsDeY5QavoPylu8Y2vA+usTaC4WV+45c+3ao410p1BtjICUarmcKlpsQCq07RNSyoCVlUm9+uKBr8vW7jaDaF/7VtN0EGdiok8yfF4Mp4MbAH4seRjwWCEg8ReoP6SyvwNSda1rVc1FydS8YF+3/la9A3CpEtr7EHKG4LSVPqiwtGnMXorabpLWiK+p7Q0BlqD+jZ6rfAxfQyZEJQwFswA0CJhgYNWi1a8X+fG0UqvgiHfHbuEinA5rIEx3SzgAi5kY4xG7VTrrLEFSZ5mLIYjpdmuhhiQBTurNLUqp2wy4Jj18ma+sU15IUVNH3RZZ5rgAtVJAyX1Hr+sE3vOhp4BlCCT3ijtwI+IDOPk4IM=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;6:SUflCPDnFpIwWR6UDUSlJcbLIMz0OdWpFbwjh3uZq6keu+Hsl7X+xJvAFNkj8SURPGP8ycvB9quIk5nXPhdPbIaIuBrUF8kXrD7+yOzhFcCcxcXFFPJmSFAzFDAG/uDvUnpwzWGlHQuy8mIvNHDTVD5pMiNxRYptc5bHF98TjNjmrEojXbeDXo57QbF58dFFp02AJn5FVdy9HuGgNCIbROeBALSVh1KqrCuXmF0t0n6D0T+MWhPNBYCX5v8Y5RwaS3lv4VLUf7bY9VjA1vm0PNTZpDPC4DHxTfPs/qc0O5UwFSuXYb2m0QQTrdAjxoC1dZfbXUBKnDZ/ARPr9HX7Z8Xlv/VJGIty9nfCwMZ2q2TfSGl3eSbJGJ3zqcyf2hcscxq33VvTUpQ1kO0hQ892UDDMwJ6+zkjGc7sdn2f9BfZhf/1ADEwP9U9HfRQONEgx6X3e3mu/lL6m0Ikdsu45qg==;5:BDNPsAy3uakZMazbv9URwfrO1pnC5at6GLzI5Kbi36qfQpjUBtKvbFoOWADIiz0+5/zO0hW6EgGRx46ZBC4qA1y2SuOIZap+Zs9HZ45EXcdVLn6COZBx9sB5P89+3AZGeOldVGGJwR+2DCF0BFpK0riRulpcsOFYu19Xl1i1dFA=;24:YTwxP7ET0TcTSmE5cHRGk0rW9q0L23OtvxyNYMXJpor3ADZO35+KGO4P9udM8LagYBnJxY1d7y0Oyoxeqwe+TTKEsN0W0AKnGffu+V6VtqY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;7:ivsuMVMy1FtXa9a0nHOVQRBZEgs9AQuYVm0v+10wdTgXPfAZsKvhq7sYfJrXuV9NsN9iKDR+sDPxvDcOAAHW60Y6TPDbh+YU0ZoOb2xXWbNS3Oe/EGFcE5UzDzr/4c8LXlIAKTLKvHuMyaxCkcI1xeSx565bKI0A4MlEIUbY27PSjgfaAfbELG0wIqVOWF8GJNWlyvwcRr+EHuOWDBhSE1PLhBog0CMz/wBSQzAQLgn6GSub6X7vwnIXVpryrKXG
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 19:59:33.5597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f21bbc-7874-408b-e6ec-08d5ec1fd141
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is adding communication layer with firmware and clock driver who uses 
those APIs to communicate with PMU.
Firmware driver provides an interface to firmware APIs.Interface APIs can be used by any driver to communicate to
PMUFW(Platform Management Unit). All requests go through ATF.
This patchset adds CCF compliant clock driver for ZynqMP.Clock driver queries supported clock information from 
firmware and regiters pll and output clocks with CCF.
v10:
 - Incorporated code review comments from v9 patch series. Discussed below:
	https://patchwork.kernel.org/patch/10478575/
	https://patchwork.kernel.org/patch/10478457/
	https://patchwork.kernel.org/patch/10478461/
	https://patchwork.kernel.org/patch/10478463/
	
v9:
 - Fixed minor typo comments

v8:
 - Corrected typo in clk Kconfig
 
v7:
 - Removed xilinx specific clock debugfs API support
 - Added reviewed-by tags for FW and clock bindings
 - Updated clock node name to clock-controller

v6:
 - Broke patch series to have base FW driver and Clock driver user
 - Incorporated code review comments from last FW and Clock driver patch series. Discussed below:
	https://patchwork.kernel.org/patch/10230759/
	https://patchwork.kernel.org/patch/10250047/

v5:
 - Added ATF version check support
 - Updated some functions to be static 
 - Minor function name corrections

v4:
 - Changed clock setrate/getrate API prototype to support 64 bit rate
 - Defined macros for get_node_status return values
 - Moved DT node as a child of firmware
 - Changed debugfs APIs to return data to debugfs buffer instead of dumping to kernel log
 - Minor changes to incorporate other review comments from v3 patch series

v3:
 - added some fixes to firmware-ggs.c
 - updated pinmux get/set function argument names to specify function id instead of node id
 - added new pinctrl query macros
 - incorporated review comments from v2 patch series

v2:
 - change SPDX-License-Identifier license text style
 - split patch into multiple patches
 - Updated copyrights
 - Added ABI documentation
 - incorporated logical review comments from previuos patch. Discussed below:
	https://patchwork.kernel.org/patch/10150665/
	
Jolly Shah (1):
  drivers: clk: Add ZynqMP clock driver

Rajan Vaja (9):
  dt-bindings: firmware: Add bindings for ZynqMP firmware
  firmware: xilinx: Add Zynqmp firmware driver
  firmware: xilinx: Add zynqmp IOCTL API for device control
  firmware: xilinx: Add query data API
  firmware: xilinx: Add clock APIs
  firmware: xilinx: Add debugfs interface
  firmware: xilinx: Add debugfs for IOCTL API
  firmware: xilinx: Add debugfs for query data API
  dt-bindings: clock: Add bindings for ZynqMP clock driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  82 +++
 arch/arm64/Kconfig.platforms                       |   1 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zynqmp/Kconfig                         |  10 +
 drivers/clk/zynqmp/Makefile                        |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 144 +++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 141 ++++
 drivers/clk/zynqmp/clk-zynqmp.h                    |  68 ++
 drivers/clk/zynqmp/clkc.c                          | 719 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 217 +++++++
 drivers/clk/zynqmp/pll.c                           | 335 ++++++++++
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/xilinx/Kconfig                    |  23 +
 drivers/firmware/xilinx/Makefile                   |   5 +
 drivers/firmware/xilinx/zynqmp-debug.c             | 249 +++++++
 drivers/firmware/xilinx/zynqmp-debug.h             |  22 +
 drivers/firmware/xilinx/zynqmp.c                   | 562 ++++++++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
 include/linux/firmware/xlnx-zynqmp.h               | 116 ++++
 21 files changed, 2818 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

-- 
2.7.4

