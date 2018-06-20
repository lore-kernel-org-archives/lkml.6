Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ABCC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67BC20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IHqS0Gpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67BC20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932710AbeFTRmZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:42:25 -0400
Received: from mail-bl2nam02on0074.outbound.protection.outlook.com ([104.47.38.74]:31008
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754726AbeFTRlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVBiSxntjfy/KDw0X/Ld5N6pMDD6GvsJIVypGFahZxk=;
 b=IHqS0Gpc1UoG6v83yAlT8vD12yTl3Cj2hkIaNXoZgxe/KXwscWbeDB9sDUbK4NFfxAjiTurxZb9ei89oYBCa2UOfmMpfhbmCvWYeA66ttpjHLbAa5gNhXABfl6ZJKlNLmdjolMOcQ6ntjSGblOG4YSL80ZpFh3mWSer468LmbUo=
Received: from MWHPR0201CA0086.namprd02.prod.outlook.com
 (2603:10b6:301:75::27) by BN6PR02MB2644.namprd02.prod.outlook.com
 (2603:10b6:404:57::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Wed, 20 Jun
 2018 17:40:59 +0000
Received: from CY1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by MWHPR0201CA0086.outlook.office365.com
 (2603:10b6:301:75::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.19 via Frontend
 Transport; Wed, 20 Jun 2018 17:40:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT048.mail.protection.outlook.com (10.152.74.227) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Wed, 20 Jun 2018 17:40:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6G-0002PA-IR; Wed, 20 Jun 2018 10:40:56 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6B-0004lu-Fi; Wed, 20 Jun 2018 10:40:51 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5KHeg9n027151;
        Wed, 20 Jun 2018 10:40:42 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fVh62-0004hY-A7; Wed, 20 Jun 2018 10:40:42 -0700
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
        Jolly Shah <jolly.shah@xilinx.com>,
        Tejas Patel <tejasp@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v9 10/10] drivers: clk: Add ZynqMP clock driver
Date:   Wed, 20 Jun 2018 10:40:35 -0700
Message-ID: <1529516435-7315-11-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(39380400002)(2980300002)(438002)(199004)(189003)(2906002)(59450400001)(8676002)(77096007)(11346002)(2616005)(476003)(44832011)(186003)(72206003)(478600001)(486006)(126002)(47776003)(36386004)(48376002)(63266004)(8936002)(81156014)(5660300001)(76176011)(81166006)(446003)(7696005)(51416003)(426003)(7416002)(356003)(50466002)(336012)(9786002)(106466001)(575784001)(110136005)(53946003)(6666003)(2201001)(107886003)(39060400002)(305945005)(4326008)(50226002)(316002)(36756003)(54906003)(16586007)(26005)(106002)(921003)(107986001)(1121003)(579004)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2644;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT048;1:zm+g/Hx9c/+H4JmbzbBoY4hwq3xI8+dzcoXqsm12lvtTP6mKHhmCKW1dSPPHiHuz7iENX27wXIDQ/eKu3x5FjUPxutfZgSTofnmAuBfrvFzd2W/tq2h2Njb/CAIZBtZV
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a042e1c-3dbf-4f48-cdba-08d5d6d4fb53
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BN6PR02MB2644;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2644;3:XW53XsQVl4QaQoN7TbaZKt6yvAI8k2AR5Pyzd73DWGHAM70jl6YKs+sfuJNwwhLF7Dtuunw/NeW8Au0ZAY/oSIs3yLhU7X77d/JIUX43rkqg3S8eS+qpoMeswtGQ0Ka72lzvgmoMJbiHTSOZaSeNbdZ6STf0fTmE5hyFcYz8zz1+gtQUI13ZbzAzXEndsGvzHOIMTp2rACzOvVXEObPX6wwcf4MlJncoFYwIsQxrANFglXltOsK/OJ1K30Ed6RO7Zn91qfJVI06BgpRtclmOSiDrCZioshJIwZP5TK4JFPBj7bQI8HkN0+XsomGWHaa/SBvuiScv58tdILvPuNgosXMfn1RUTY1R7/7Cvq05B0g=;25:+VWAq9Ad7ezRXnoZLavqMQzZtzEFiO3H1WPPrZMvAyV3v+K6SBsjo3ek6ClbXSXYvlQ3mQ3N/l80A+d2PJp/Ur5OovnpLs+Z3V9tuNS2k+RxZSLxTYPQbL3K4G5hXli/h7WYYSM9OBdAkJC7XIcmcNkdjVCbhqxG2hDztdFqKAf6CJ7g5T6tURPxgwkydKfAZuOq9tSkfwPW7/okolNkl2EDlSlBP9ZuiKOcKM8W+Q0IC+v13+CKPynJ2L5f9HTcky89/I6KB1DMo2VECn/O3XZY0uduLw4t7yEv8kszmgL/5vTKG3fLIZyyBl9U6p3pbFCZ8J8rFYXESSzIToPS5g==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2644:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2644;31:RxWoadTMCf/dqpVRK3Vq5GvWSbJ7Y9HyXfaKiMyAiGbAOlQU7EFmP0+nQq+9oQVWYUCEoyeyfOV3q8V/3wNf1PT42fv7yUFY5JiLOCIi634g8MXJJsCZBI4aFNnGzAgA5GDOpz9lXH2128QQqM8axjnC/APaGkusQQ0VEo3mMj4hwWtwv4R0J1Lnl86pnKclbEHFAqZcU7i/Ckva3Yd/ZOV2Y9jQSPO5JfTS1IMO/10=;20:s4sAP5EpbAI4NnSPhMbYF5ZmhfOcEU05a4OEIABHOWqQAGUeIWkqnqhFlrzw2v8p43J1MR57i/SJUySdyPYSDp2shZ7KrdQa11/5qk8/JSnhaMNk4rzAsAgZtX7hioyUxPU46mlNlbZy0kijiniNATOSepu1uNGW2YbgLbj2+iJkoaUaMO8zR6dWU722IkiUJf/U+/vI/rp72vNhEhS8PgL+nmdv4VR0OMwpyhTLi3vYq52JZIUpDKXaZJ2qiE8LAFZwXUaWhUrlW2Q/LfxWaF9wZrY8Yc3eBQ3EAi02rYK9t3p3UUMck+BfAcibkkvv2ID7fjlCBa2GLgwgNkFT/N7KiZQhdE3WrMFhZC/FiUrOhX5yustdaJPV5L3OxyKQFKrg/9pC/EHVD19m7nHVCQV/nlThjErzdR2UUWv3yKUOsOyW6ktgb9xtbrwbdHHTCtD2NZqcJqEytX4qw+C3WsQOKj1kv2c2XRx8dBhMl7Ddvqz/jk8ZZEJIXIKb7IlD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB2644D3ADD5C3842622633569B8770@BN6PR02MB2644.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN6PR02MB2644;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2644;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2644;4:PrGd+eEteqWR0Q0VoV8l4OK1NW4H3qys9mZ1PGyaisQwVjSnalP2a7aJNvjuRrn9pYNqgH5/CSTOsOlemF8VELBILkUoE7tuiZbx0UictzRQHtq0/YVdiJDb1uh7bwKxcWdRCU9aqMeU6+zjYc1oYZ+irsmh8W4N2SSGC0ofxNPsSmMslR5NXORobsJcFSxRlcESQUDNw4Dcau0dozCPCrUUwhKb1p6Y2v0lQPMQOI/T+DDfMpymrcRmpCjbbvP2c6pQ6UThjpxA1huZEqDrGUMGSbHcrmZD9OVZi2i7KgY3ANXZzGPsCddf/Ub3Pc1m
X-Forefront-PRVS: 070912876F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2644;23:M8kenxpqiBSubl0EijPBXZz/mvikDEl+otD9dQ7Cm?=
 =?us-ascii?Q?Njj4ePrgX7jFXP3McPA0p0pjGkc0QrxKHMay6Q50jDSW2vplms6NxWHFrBQF?=
 =?us-ascii?Q?c9Cckt3vvZLqZRDivODoUx1hOCM8oXkBjW9SzRAGtOeJ9OBsu7nsW2ViLui/?=
 =?us-ascii?Q?1GZqCd0WF5rkNwnOEPwTlThr5CnDBA0AAJSXkGrfGaD2FbRWdkOHvkQD6oNm?=
 =?us-ascii?Q?IW2rEtOh+AwWz+v2jsRsRrORbflALUXVT3eg2XRVvjhIyzGCfSE8UrGNQkPC?=
 =?us-ascii?Q?o0Bzyhe65BsTBpn4QBokOqiZqPrkRtfzAqZxmNPgkWYPpNQqrg1cNV3YJymH?=
 =?us-ascii?Q?3sDptCmj2uU0M7f/VoJfMVTRkutKourwJfeyJbg43PTfIjqA7e85y//Fg1Cv?=
 =?us-ascii?Q?j88jBrYauMpAF7c7lr6eaOQP7mjt8jIoBRP9TQgEqmZ7+Pb5hhK3jYWz4Wnx?=
 =?us-ascii?Q?9AP2RbEy4fm3YyTHTl6eivcIRnZ8qh6FVS5fUIdwG6y/VNi41RuvRTkVOt0r?=
 =?us-ascii?Q?aj9FydswGyMzJU+OY6sZEfT63+QfQMwpP8vtNnK8XHFe9+2l2HFvPJKkKJBn?=
 =?us-ascii?Q?7/FBxnKJEJOJTVnZ08+XfUozbRKdDIUONVe8yfAfKUpimfF7j8nWThXhDQSl?=
 =?us-ascii?Q?3h+PxgxEljOj/nVl3Xp2pIckZJi4MnUtNdd/497jAQFnI91P1ycmV/IhJxUb?=
 =?us-ascii?Q?7XGYWNoa6eKa8Hbwutv4Rh9gjwrpA7WuIL7z/BU2Te9sdRzEx4UlRmh8AGl6?=
 =?us-ascii?Q?g5LPuhV5PdmiP92+d8MMMcigGSdNkY1SteWL+ul79e9Unoq+L6i3h3TiVH5Q?=
 =?us-ascii?Q?pAUggGWQb2YLpM1qlJWjIW8cJStzHgnu37k3k2HiMx3fdTR9kuniRLZNHEiu?=
 =?us-ascii?Q?rLSaX8ePlXcTMxAsvtdl37qIBfncukVE9Mhw76BoFR0FhqcJuffCNFkH/SBa?=
 =?us-ascii?Q?3DVJiEZPd6HPYzw+Fygiex7wFQxdiGHae7hXMHWyQyqdqWawn0mzfq0dfueu?=
 =?us-ascii?Q?WNSD80vFvMoIjRXTdpwTxpd5X7+3vgeBEC4FZWb0cHeymkOJ4oWVr2EAll35?=
 =?us-ascii?Q?TTmY1OABx16JFh2ZyKK9MKDr9OSRFPKgd4HjbraBndoLRrDZF+W+wVbF8g1B?=
 =?us-ascii?Q?F9vlmvLdXfdfilkuyc034ei8xvMG/7j6IpSX/rL/jGaoNDU1q/2LNmGO6XOh?=
 =?us-ascii?Q?6zmKlsiQlUyY39mYnKgPEt8Ieo/A/b8QSSgTMeHEdmhgkRjansxDJOAYPFjz?=
 =?us-ascii?Q?PcMv8uKAKtaH1caiOpIQJaJO29BTIE0f0aax/EcI+QQpfbT0V+SmcTTvB/CF?=
 =?us-ascii?Q?Ptn5Z+fO78dAmm7G47SayfrMq7qjGNSJrvr5QfjJNDtKw1habSXht5jTdgcm?=
 =?us-ascii?Q?l1Ss1CMA79ea9D8PkKgJkg97vk=3D?=
X-Microsoft-Antispam-Message-Info: yBASG5EC+QzgQuTUrTH6tUxpUJmdNz0MCOHMrnfW9CsYFFU87oLUwn2JTtFJpF8ZeM3oFi9Ru4Np1an6pVk4FRRyBX+vyfZds7gIsVMSTMVnKxzhRhazAVcQ3cU/wuFxHyTZGHBMFPRFHAvpxqsnwbgGInmvHkewKJzfOX3URRRkxihK/OyzJ7pfCCPFGkMSnegM2Us2C9Te7XtS4snXoe/gNz4+4F5dSjdtx8HmKgo++309dTUo3sQti8WJmfOtMMmULWM7k7pdVems2kk35KkGUP6oM7SDxtJVIgu1eUJXLnqXZX8AZj82XgPecn5b4pwKSed9EHwa0LTeGn8h+g==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2644;6:TcUavECW1+tFmo2PQ91Reead9N4SgFt3qteGtITh+OANmCxJFcPq1uMP7/PIIpKz2j8dYphXiCmInaKcYbbNJ9HnFEHqSCjfv05wAcIHwJ9LIaOuqA+AOlLQQwVOnwxn4Twlm7TmDpawPDlbztAxhhgQQGb0Dkozs3Rxrqj5HLQsqzd0tlcxgkR9FT9DBptZC4y7/Ne2B8or9GNvWgJyVZkTIPnaO5WXnlpRsYA7+h00e7eXBFT9Wwz2mujsAp0/OXQxIocorzRf9iWPmnSV3YAQkXWXlMKKBsHnrv+iitMYdw1xa3MDbdAPlvM3gw/zugVJvi8ZO2vnD2dX7N8bdP7M7HYw/FzFPhYSFSfdAz/Xtr5urpEqw/3OTQtiNjIFCx9dOEyPZlvw7BA4i3eLmsHQmAJ9SeCmQiVHYYcZCm+sa4BDb2asDEfdUfpfoA01Q4Ly9iM88XfKHxyhBdtsjA==;5:4DJ54EaTpBit/oX+4/ddLPkBKv3LIBYZziChnq/2uryaTrtDyAkFKKh2LMAQVN1YEOd94owGjORepEBoZTcw3AwTjPcHj0LbOjIyuyRO0DxxYSLdH6DaTGxOeLpPrYXDlEY+8jkmh7NlA0hOlB+BSjU2On5GABXehC/jHjRjwlI=;24:B0bBd3bSTHZ6BtAg5VI5qcVomGDU6TtWuLz7dde27QahoA4+kuBA13GbyfDH91TywTdhKAHfXK/UIW86UVY8eHEuqhojWb7W81FA1MST9Pk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2644;7:DZv19K/I2ypySrg5qJJtdSZZ1t3pF0JLfCP1kiQ3B6PRC2qiscjC9f4nKcHNcilJaolw3BrJYSQwCF8KOJXMC8/JYQu1MUwbknvk2SlP7W5p5vQ4Q3pur42l8lJ9FSiY+VIm9Wgu56KPSr3uETQoma2IN86smoVUZy8C1y5MZDi94IQvb5fdPyRm5U1CHretAIH4VLy7VgBXrZFz0byQSYA04W8wgfi90zaRUh+sxmAcLTFxh+zHOIvNRN1lxv9V
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 17:40:57.0448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a042e1c-3dbf-4f48-cdba-08d5d6d4fb53
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jolly Shah <jolly.shah@xilinx.com>

This patch adds CCF compliant clock driver for ZynqMP.
Clock driver queries supported clock information from
firmware and regiters pll and output clocks with CCF.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Tejas Patel <tejasp@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/clk/Kconfig                  |   1 +
 drivers/clk/Makefile                 |   1 +
 drivers/clk/zynqmp/Kconfig           |  11 +
 drivers/clk/zynqmp/Makefile          |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c | 146 +++++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c  | 150 +++++++
 drivers/clk/zynqmp/clk-zynqmp.h      |  53 +++
 drivers/clk/zynqmp/clkc.c            | 737 +++++++++++++++++++++++++++++++++++
 drivers/clk/zynqmp/divider.c         | 219 +++++++++++
 drivers/clk/zynqmp/pll.c             | 345 ++++++++++++++++
 10 files changed, 1667 insertions(+)
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 98ce9fc..a2ebcf7 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -252,6 +252,7 @@ source "drivers/clk/sprd/Kconfig"
 source "drivers/clk/sunxi-ng/Kconfig"
 source "drivers/clk/tegra/Kconfig"
 source "drivers/clk/ti/Kconfig"
+source "drivers/clk/zynqmp/Kconfig"
 source "drivers/clk/uniphier/Kconfig"
 
 endmenu
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 71ec41e..b6ac0d2 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -100,3 +100,4 @@ obj-$(CONFIG_X86)			+= x86/
 endif
 obj-$(CONFIG_ARCH_ZX)			+= zte/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
+obj-$(CONFIG_COMMON_CLK_ZYNQMP)         += zynqmp/
diff --git a/drivers/clk/zynqmp/Kconfig b/drivers/clk/zynqmp/Kconfig
new file mode 100644
index 0000000..0f8986c
--- /dev/null
+++ b/drivers/clk/zynqmp/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config COMMON_CLK_ZYNQMP
+	bool "Support for Xilinx ZynqMP Ultrascale+ clock controllers"
+	depends on OF
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on ZYNQMP_FIRMWARE
+	help
+	  Support for the Zynqmp Ultrascale clock controller.
+	  It has a dependency on the PMU firmware.
+	  Say Y if you want to include clock support.
diff --git a/drivers/clk/zynqmp/Makefile b/drivers/clk/zynqmp/Makefile
new file mode 100644
index 0000000..0ec24bf
--- /dev/null
+++ b/drivers/clk/zynqmp/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Zynq Ultrascale+ MPSoC clock specific Makefile
+
+obj-$(CONFIG_ARCH_ZYNQMP)	+= pll.o clk-gate-zynqmp.o divider.o clk-mux-zynqmp.o clkc.o
diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/clk-gate-zynqmp.c
new file mode 100644
index 0000000..b927eb1
--- /dev/null
+++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zynq UltraScale+ MPSoC clock controller
+ *
+ *  Copyright (C) 2016-2018 Xilinx
+ *
+ * Gated clock implementation
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include "clk-zynqmp.h"
+
+/**
+ * struct clk_gate - gating clock
+ * @hw:		handle between common and hardware-specific interfaces
+ * @flags:	hardware-specific flags
+ * @clk_id:	Id of clock
+ */
+struct zynqmp_clk_gate {
+	struct clk_hw hw;
+	u8 flags;
+	u32 clk_id;
+};
+
+#define to_zynqmp_clk_gate(_hw) container_of(_hw, struct zynqmp_clk_gate, hw)
+
+/**
+ * zynqmp_clk_gate_enable() - Enable clock
+ * @hw:		handle between common and hardware-specific interfaces
+ *
+ * Return: 0 on success else error code
+ */
+static int zynqmp_clk_gate_enable(struct clk_hw *hw)
+{
+	struct zynqmp_clk_gate *gate = to_zynqmp_clk_gate(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = gate->clk_id;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_enable(clk_id);
+
+	if (ret)
+		pr_warn_once("%s() clock enabled failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return ret;
+}
+
+/*
+ * zynqmp_clk_gate_disable() - Disable clock
+ * @hw:		handle between common and hardware-specific interfaces
+ */
+static void zynqmp_clk_gate_disable(struct clk_hw *hw)
+{
+	struct zynqmp_clk_gate *gate = to_zynqmp_clk_gate(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = gate->clk_id;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_disable(clk_id);
+
+	if (ret)
+		pr_warn_once("%s() clock disable failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+}
+
+/**
+ * zynqmp_clk_gate_is_enable() - Check clock state
+ * @hw:		handle between common and hardware-specific interfaces
+ *
+ * Return: 1 if enabled, 0 if disabled else error code
+ */
+static int zynqmp_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	struct zynqmp_clk_gate *gate = to_zynqmp_clk_gate(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = gate->clk_id;
+	int state, ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_getstate(clk_id, &state);
+	if (ret) {
+		pr_warn_once("%s() clock get state failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+		return -EIO;
+	}
+
+	return state ? 1 : 0;
+}
+
+const struct clk_ops zynqmp_clk_gate_ops = {
+	.enable = zynqmp_clk_gate_enable,
+	.disable = zynqmp_clk_gate_disable,
+	.is_enabled = zynqmp_clk_gate_is_enabled,
+};
+EXPORT_SYMBOL_GPL(zynqmp_clk_gate_ops);
+
+/**
+ * zynqmp_clk_register_gate() - register a gate clock with the clock framework
+ * @dev:		device that is registering this clock
+ * @name:		name of this clock
+ * @clk_id:		Id of this clock
+ * @parent:		name of this clock's parent
+ * @flags:		framework-specific flags for this clock
+ * @clk_gate_flags:	gate-specific flags for this clock
+ *
+ * Return: clock hardware of the registered clock gate
+ */
+struct clk_hw *zynqmp_clk_register_gate(struct device *dev, const char *name,
+					u32 clk_id, const char *parent,
+					unsigned long flags,
+					u8 clk_gate_flags)
+{
+	struct zynqmp_clk_gate *gate;
+	struct clk_hw *hw;
+	int ret;
+	struct clk_init_data init;
+
+	/* allocate the gate */
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &zynqmp_clk_gate_ops;
+	init.flags = flags;
+	init.parent_names = &parent;
+	init.num_parents = 1;
+
+	/* struct clk_gate assignments */
+	gate->flags = clk_gate_flags;
+	gate->hw.init = &init;
+	gate->clk_id = clk_id;
+
+	hw = &gate->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(gate);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
new file mode 100644
index 0000000..a0b452d
--- /dev/null
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zynq UltraScale+ MPSoC mux
+ *
+ *  Copyright (C) 2016-2018 Xilinx
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include "clk-zynqmp.h"
+
+/*
+ * DOC: basic adjustable multiplexer clock that cannot gate
+ *
+ * Traits of this clock:
+ * prepare - clk_prepare only ensures that parents are prepared
+ * enable - clk_enable only ensures that parents are enabled
+ * rate - rate is only affected by parent switching.  No clk_set_rate support
+ * parent - parent is adjustable through clk_set_parent
+ */
+
+/**
+ * struct zynqmp_clk_mux - multiplexer clock
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @flags:	hardware-specific flags
+ * @clk_id:	Id of clock
+ */
+struct zynqmp_clk_mux {
+	struct clk_hw hw;
+	u8 flags;
+	u32 clk_id;
+};
+
+#define to_zynqmp_clk_mux(_hw) container_of(_hw, struct zynqmp_clk_mux, hw)
+
+/**
+ * zynqmp_clk_mux_get_parent() - Get parent of clock
+ * @hw:		handle between common and hardware-specific interfaces
+ *
+ * Return: Parent index
+ */
+static u8 zynqmp_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct zynqmp_clk_mux *mux = to_zynqmp_clk_mux(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = mux->clk_id;
+	u32 val;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_getparent(clk_id, &val);
+
+	if (ret)
+		pr_warn_once("%s() getparent failed for clock: %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return val;
+}
+
+/**
+ * zynqmp_clk_mux_set_parent() - Set parent of clock
+ * @hw:		handle between common and hardware-specific interfaces
+ * @index:	Parent index
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct zynqmp_clk_mux *mux = to_zynqmp_clk_mux(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = mux->clk_id;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_setparent(clk_id, index);
+
+	if (ret)
+		pr_warn_once("%s() set parent failed for clock: %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return ret;
+}
+
+const struct clk_ops zynqmp_clk_mux_ops = {
+	.get_parent = zynqmp_clk_mux_get_parent,
+	.set_parent = zynqmp_clk_mux_set_parent,
+	.determine_rate = __clk_mux_determine_rate,
+};
+EXPORT_SYMBOL_GPL(zynqmp_clk_mux_ops);
+
+const struct clk_ops zynqmp_clk_mux_ro_ops = {
+	.get_parent = zynqmp_clk_mux_get_parent,
+};
+EXPORT_SYMBOL_GPL(zynqmp_clk_mux_ro_ops);
+
+/**
+ * zynqmp_clk_register_mux() - register a mux table with the clock
+ *			       framework
+ * @dev:		device that is registering this clock
+ * @name:		name of this clock
+ * @clk_id:		Id of this clock
+ * @parents:		name of this clock's parents
+ * @num_parents:	number of parents
+ * @flags:		framework-specific flags for this clock
+ * @clk_mux_flags:	mux-specific flags for this clock
+ *
+ * Return: clock hardware of the registered clock mux
+ */
+struct clk_hw *zynqmp_clk_register_mux(struct device *dev, const char *name,
+				       u32 clk_id,
+				       const char * const *parents,
+				       u8 num_parents,
+				       unsigned long flags,
+				       u8 clk_mux_flags)
+{
+	struct zynqmp_clk_mux *mux;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	/* allocate the mux */
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	if (clk_mux_flags & CLK_MUX_READ_ONLY)
+		init.ops = &zynqmp_clk_mux_ro_ops;
+	else
+		init.ops = &zynqmp_clk_mux_ops;
+	init.flags = flags;
+	init.parent_names = parents;
+	init.num_parents = num_parents;
+
+	/* struct clk_mux assignments */
+	mux->flags = clk_mux_flags;
+	mux->hw.init = &init;
+	mux->clk_id = clk_id;
+
+	hw = &mux->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(hw);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(zynqmp_clk_register_mux);
diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqmp.h
new file mode 100644
index 0000000..57e81d45
--- /dev/null
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2016-2018 Xilinx
+ */
+
+#ifndef __LINUX_CLK_ZYNQMP_H_
+#define __LINUX_CLK_ZYNQMP_H_
+
+#include <linux/spinlock.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/* Clock APIs payload parameters */
+#define CLK_GET_NAME_RESP_LEN				16
+#define CLK_GET_TOPOLOGY_RESP_WORDS			3
+#define CLK_GET_PARENTS_RESP_WORDS			3
+#define CLK_GET_ATTR_RESP_WORDS				1
+
+enum topology_type {
+	TYPE_INVALID,
+	TYPE_MUX,
+	TYPE_PLL,
+	TYPE_FIXEDFACTOR,
+	TYPE_DIV1,
+	TYPE_DIV2,
+	TYPE_GATE,
+};
+
+struct clk_hw *zynqmp_clk_register_pll(struct device *dev, const char *name,
+				       u32 clk_id,
+				       const char *parent,
+				       unsigned long flag);
+
+struct clk_hw *zynqmp_clk_register_gate(struct device *dev, const char *name,
+					u32 clk_id,
+					const char *parent,
+					unsigned long flags,
+					u8 clk_gate_flags);
+
+struct clk_hw *zynqmp_clk_register_divider(struct device *dev,
+					   const char *name,
+					   u32 clk_id, u32 div_type,
+					   const char *parent,
+					   unsigned long flags,
+					   u8 clk_divider_flags);
+
+struct clk_hw *zynqmp_clk_register_mux(struct device *dev, const char *name,
+				       u32 clk_id,
+				       const char * const *parents,
+				       u8 num_parents,
+				       unsigned long flags,
+				       u8 clk_mux_flags);
+#endif
diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
new file mode 100644
index 0000000..a315fc2
--- /dev/null
+++ b/drivers/clk/zynqmp/clkc.c
@@ -0,0 +1,737 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zynq UltraScale+ MPSoC clock controller
+ *
+ *  Copyright (C) 2016-2018 Xilinx
+ *
+ * Based on drivers/clk/zynq/clkc.c
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "clk-zynqmp.h"
+
+#define MAX_PARENT			100
+#define MAX_NODES			6
+#define MAX_NAME_LEN			50
+#define MAX_CLOCK			300
+
+#define CLK_INIT_ENABLE_SHIFT		1
+#define CLK_TYPE_SHIFT			2
+
+#define PM_API_PAYLOAD_LEN		3
+
+#define NA_PARENT			0xFFFFFFFF
+#define DUMMY_PARENT			0xFFFFFFFE
+
+#define CLK_TYPE_FIELD_LEN		4
+#define CLK_TOPOLOGY_NODE_OFFSET	16
+#define NODES_PER_RESP			3
+
+#define CLK_TYPE_FIELD_MASK		0xF
+#define CLK_FLAG_FIELD_MASK		GENMASK(21, 8)
+#define CLK_TYPE_FLAG_FIELD_MASK	GENMASK(31, 24)
+
+#define CLK_PARENTS_ID_LEN		16
+#define CLK_PARENTS_ID_MASK		0xFFFF
+
+/* Flags for parents */
+#define PARENT_CLK_SELF			0
+#define PARENT_CLK_NODE1		1
+#define PARENT_CLK_NODE2		2
+#define PARENT_CLK_NODE3		3
+#define PARENT_CLK_NODE4		4
+#define PARENT_CLK_EXTERNAL		5
+
+#define END_OF_CLK_NAME			"END_OF_CLK"
+#define RESERVED_CLK_NAME		""
+
+#define CLK_VALID_MASK			0x1
+#define CLK_INIT_ENABLE_MASK		(0x1 << CLK_INIT_ENABLE_SHIFT)
+
+enum clk_type {
+	CLK_TYPE_OUTPUT,
+	CLK_TYPE_EXTERNAL,
+};
+
+/**
+ * struct clock_parent - Structure for parent of clock
+ * @name:	Parent name
+ * @id:		Parent clock ID
+ * @flag:	Parent flags
+ */
+struct clock_parent {
+	char name[MAX_NAME_LEN];
+	int id;
+	u32 flag;
+};
+
+/**
+ * struct clock_topology - Structure for topology of clock
+ * @type:	Type of topology
+ * @flag:	Topology flags
+ * @type_flag:	Topology type specific flag
+ */
+struct clock_topology {
+	u32 type;
+	u32 flag;
+	u32 type_flag;
+};
+
+/**
+ * struct zynqmp_clock - Structure for clock
+ * @clk_name:		Clock name
+ * @valid:		Validity flag of clock
+ * @init_enable:	init_enable flag of clock
+ * @type:		Clock type (Output/External)
+ * @node:		Clock tolology nodes
+ * @num_nodes:		Number of nodes present in topology
+ * @parent:		structure of parent of clock
+ * @num_parents:	Number of parents of clock
+ */
+struct zynqmp_clock {
+	char clk_name[MAX_NAME_LEN];
+	u32 valid;
+	u32 init_enable;
+	enum clk_type type;
+	struct clock_topology node[MAX_NODES];
+	u32 num_nodes;
+	struct clock_parent parent[MAX_PARENT];
+	u32 num_parents;
+};
+
+static const char clk_type_postfix[][10] = {
+	[TYPE_INVALID] = "",
+	[TYPE_MUX] = "_mux",
+	[TYPE_GATE] = "",
+	[TYPE_DIV1] = "_div1",
+	[TYPE_DIV2] = "_div2",
+	[TYPE_FIXEDFACTOR] = "_ff",
+	[TYPE_PLL] = ""
+};
+
+static struct zynqmp_clock clock[MAX_CLOCK];
+static struct clk_hw_onecell_data *zynqmp_data;
+static unsigned int clock_max_idx;
+static const struct zynqmp_eemi_ops *eemi_ops;
+
+/**
+ * zynqmp_is_valid_clock() - Check whether clock is valid or not
+ * @clk_id:	Clock index
+ * @valid:	1: if clock is valid
+ *		0: invalid clock
+ *
+ * Return: 0 on success else error code
+ */
+static int zynqmp_is_valid_clock(u32 clk_id, u32 *valid)
+{
+	if (clk_id > clock_max_idx)
+		return -ENODEV;
+
+	*valid = clock[clk_id].valid;
+
+	return *valid ? 0 : -EINVAL;
+}
+
+/**
+ * zynqmp_get_clock_name() - Get name of clock from Clock index
+ * @clk_id:	Clock index
+ * @clk_name:	Name of clock
+ *
+ * Return: 0 on success else error code
+ */
+static int zynqmp_get_clock_name(u32 clk_id, char *clk_name)
+{
+	int ret;
+	u32 valid;
+
+	ret = zynqmp_is_valid_clock(clk_id, &valid);
+	if (!ret && valid) {
+		strncpy(clk_name, clock[clk_id].clk_name, MAX_NAME_LEN);
+		return ret;
+	} else {
+		return ret;
+	}
+}
+
+/**
+ * zynqmp_get_clock_type() - Get type of clock
+ * @clk_id:	Clock index
+ * @type:	Clock type: CLK_TYPE_OUTPUT or CLK_TYPE_EXTERNAL
+ *
+ * Return: 0 on success else error code
+ */
+static int zynqmp_get_clock_type(u32 clk_id, u32 *type)
+{
+	int ret;
+	u32 valid;
+
+	ret = zynqmp_is_valid_clock(clk_id, &valid);
+	if (!ret && valid) {
+		*type = clock[clk_id].type;
+		return ret;
+	} else {
+		return ret;
+	}
+}
+
+/**
+ * zynqmp_pm_clock_get_name() - Get the name of clock for given id
+ * @clock_id:	ID of the clock to be queried
+ * @name:	Name of given clock
+ *
+ * This function is used to get name of clock specified by given
+ * clock ID.
+ *
+ * Return: Returns 0, in case of error name would be 0
+ */
+static int zynqmp_pm_clock_get_name(u32 clock_id, char *name)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	qdata.qid = PM_QID_CLOCK_GET_NAME;
+	qdata.arg1 = clock_id;
+
+	eemi_ops->query_data(qdata, ret_payload);
+	memcpy(name, ret_payload, CLK_GET_NAME_RESP_LEN);
+
+	return 0;
+}
+
+/**
+ * zynqmp_pm_clock_get_topology() - Get the topology of clock for given id
+ * @clock_id:	ID of the clock to be queried
+ * @index:	Node index of clock topology
+ * @topology:	Buffer to store nodes in topology and flags
+ *
+ * This function is used to get topology information for the clock
+ * specified by given clock ID.
+ *
+ * This API will return 3 node of topology with a single response. To get
+ * other nodes, master should call same API in loop with new
+ * index till error is returned. E.g First call should have
+ * index 0 which will return nodes 0,1 and 2. Next call, index
+ * should be 3 which will return nodes 3,4 and 5 and so on.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_get_topology(u32 clock_id, u32 index, u32 *topology)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	qdata.qid = PM_QID_CLOCK_GET_TOPOLOGY;
+	qdata.arg1 = clock_id;
+	qdata.arg2 = index;
+
+	ret = eemi_ops->query_data(qdata, ret_payload);
+	memcpy(topology, &ret_payload[1], CLK_GET_TOPOLOGY_RESP_WORDS * 4);
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_get_fixedfactor_params() - Get clock's fixed factor params
+ * @clock_id:	Clock ID
+ * @mul:	Multiplication value
+ * @div:	Divisor value
+ *
+ * This function is used to get fixed factor parameters for the fixed
+ * clock. This API is applicable only for the fixed clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_get_fixedfactor_params(u32 clock_id,
+						  u32 *mul,
+						  u32 *div)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	qdata.qid = PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS;
+	qdata.arg1 = clock_id;
+
+	ret = eemi_ops->query_data(qdata, ret_payload);
+	*mul = ret_payload[1];
+	*div = ret_payload[2];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_get_parents() - Get the first 3 parents of clock for given id
+ * @clock_id:	Clock ID
+ * @index:	Parent index
+ * @parents:	3 parents of the given clock
+ *
+ * This function is used to get 3 parents for the clock specified by
+ * given clock ID.
+ *
+ * This API will return 3 parents with a single response. To get
+ * other parents, master should call same API in loop with new
+ * parent index till error is returned. E.g First call should have
+ * index 0 which will return parents 0,1 and 2. Next call, index
+ * should be 3 which will return parent 3,4 and 5 and so on.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_get_parents(u32 clock_id, u32 index, u32 *parents)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	qdata.qid = PM_QID_CLOCK_GET_PARENTS;
+	qdata.arg1 = clock_id;
+	qdata.arg2 = index;
+
+	ret = eemi_ops->query_data(qdata, ret_payload);
+	memcpy(parents, &ret_payload[1], CLK_GET_PARENTS_RESP_WORDS * 4);
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_get_attributes() - Get the attributes of clock for given id
+ * @clock_id:	Clock ID
+ * @attr:	Clock attributes
+ *
+ * This function is used to get clock's attributes(e.g. valid, clock type, etc).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_get_attributes(u32 clock_id, u32 *attr)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	qdata.qid = PM_QID_CLOCK_GET_ATTRIBUTES;
+	qdata.arg1 = clock_id;
+
+	ret = eemi_ops->query_data(qdata, ret_payload);
+	memcpy(attr, &ret_payload[1], CLK_GET_ATTR_RESP_WORDS * 4);
+
+	return ret;
+}
+
+/**
+ * zynqmp_clock_get_topology() - Get topology of clock from firmware using
+ *				 PM_API
+ * @clk_id:		Clock index
+ * @clk_topology:	Structure of clock topology
+ * @num_nodes:		number of nodes
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_clock_get_topology(u32 clk_id,
+				     struct clock_topology *clk_topology,
+				     u32 *num_nodes)
+{
+	int j, k = 0, ret;
+	u32 pm_resp[PM_API_PAYLOAD_LEN] = {0};
+
+	*num_nodes = 0;
+	for (j = 0; j <= MAX_NODES; j += 3) {
+		ret = zynqmp_pm_clock_get_topology(clk_id, j, pm_resp);
+		if (ret)
+			return ret;
+		for (k = 0; k < PM_API_PAYLOAD_LEN; k++) {
+			if (!(pm_resp[k] & CLK_TYPE_FIELD_MASK))
+				return 0;
+			clk_topology[*num_nodes].type = pm_resp[k] &
+							CLK_TYPE_FIELD_MASK;
+			clk_topology[*num_nodes].flag =
+					FIELD_GET(CLK_FLAG_FIELD_MASK,
+						  pm_resp[k]);
+			clk_topology[*num_nodes].type_flag =
+				FIELD_GET(CLK_TYPE_FLAG_FIELD_MASK,
+					  pm_resp[k]);
+			(*num_nodes)++;
+		}
+	}
+	return 0;
+}
+
+/**
+ * zynqmp_clock_get_parents() - Get parents info from firmware using PM_API
+ * @clk_id:		Clock index
+ * @parents:		Structure of parent information
+ * @num_parents:	Total number of parents
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_clock_get_parents(u32 clk_id, struct clock_parent *parents,
+				    u32 *num_parents)
+{
+	int j = 0, k, ret, total_parents = 0;
+	u32 pm_resp[PM_API_PAYLOAD_LEN] = {0};
+	struct clock_parent *parent;
+
+	do {
+		/* Get parents from firmware */
+		ret = zynqmp_pm_clock_get_parents(clk_id, j, pm_resp);
+		if (ret)
+			return ret;
+
+		for (k = 0; k < PM_API_PAYLOAD_LEN; k++) {
+			if (pm_resp[k] == NA_PARENT) {
+				*num_parents = total_parents;
+				return 0;
+			}
+
+			parent = &parents[k + j];
+			parent->id = pm_resp[k] & CLK_PARENTS_ID_MASK;
+			if (pm_resp[k] == DUMMY_PARENT) {
+				strcpy(parent->name, "dummy_name");
+				parent->flag = 0;
+			} else {
+				parent->flag = pm_resp[k] >>
+							CLK_PARENTS_ID_LEN;
+				if (zynqmp_get_clock_name(parent->id,
+							  parent->name))
+					continue;
+			}
+			total_parents++;
+		}
+		j += PM_API_PAYLOAD_LEN;
+	} while (total_parents <= MAX_PARENT);
+	return 0;
+}
+
+/**
+ * zynqmp_get_parent_list() - Create list of parents name
+ * @np:			Device node
+ * @clk_id:		Clock index
+ * @parent_list:	List of parent's name
+ * @num_parents:	Total number of parents
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_get_parent_list(struct device_node *np, u32 clk_id,
+				  const char **parent_list, u32 *num_parents)
+{
+	int i = 0, ret;
+	u32 total_parents = clock[clk_id].num_parents;
+	struct clock_topology *clk_nodes;
+	struct clock_parent *parents;
+
+	clk_nodes = clock[clk_id].node;
+	parents = clock[clk_id].parent;
+
+	for (i = 0; i < total_parents; i++) {
+		if (!parents[i].flag) {
+			parent_list[i] = parents[i].name;
+		} else if (parents[i].flag == PARENT_CLK_EXTERNAL) {
+			ret = of_property_match_string(np, "clock-names",
+						       parents[i].name);
+			if (ret < 0)
+				strcpy(parents[i].name, "dummy_name");
+			parent_list[i] = parents[i].name;
+		} else {
+			strcat(parents[i].name,
+			       clk_type_postfix[clk_nodes[parents[i].flag - 1].
+			       type]);
+			parent_list[i] = parents[i].name;
+		}
+	}
+
+	*num_parents = total_parents;
+	return 0;
+}
+
+/**
+ * zynqmp_register_clk_topology() - Register clock topology
+ * @clk_id:		Clock index
+ * @clk_name:		Clock Name
+ * @num_parents:	Total number of parents
+ * @parent_names:	List of parents name
+ *
+ * Return: Returns either clock hardware or error+reason
+ */
+static struct clk_hw *zynqmp_register_clk_topology(int clk_id, char *clk_name,
+						   int num_parents,
+						   const char **parent_names)
+{
+	int j, ret;
+	u32 num_nodes, mult, div;
+	char *clk_out = NULL;
+	struct clock_topology *nodes;
+	struct clk_hw *hw = NULL;
+
+	nodes = clock[clk_id].node;
+	num_nodes = clock[clk_id].num_nodes;
+
+	for (j = 0; j < num_nodes; j++) {
+		/*
+		 * Clock name received from firmware is output clock name.
+		 * Intermediate clock names are postfixed with type of clock.
+		 */
+		if (j != (num_nodes - 1)) {
+			clk_out = kasprintf(GFP_KERNEL, "%s%s", clk_name,
+					    clk_type_postfix[nodes[j].type]);
+		} else {
+			clk_out = kasprintf(GFP_KERNEL, "%s", clk_name);
+		}
+
+		switch (nodes[j].type) {
+		case TYPE_MUX:
+			hw = zynqmp_clk_register_mux(NULL, clk_out,
+						     clk_id, parent_names,
+						     num_parents,
+						     nodes[j].flag,
+						     nodes[j].type_flag);
+			break;
+		case TYPE_PLL:
+			hw = zynqmp_clk_register_pll(NULL, clk_out, clk_id,
+						     parent_names[0],
+						     nodes[j].flag);
+			break;
+		case TYPE_FIXEDFACTOR:
+			ret = zynqmp_pm_clock_get_fixedfactor_params(clk_id,
+								     &mult,
+								     &div);
+			hw = clk_hw_register_fixed_factor(NULL, clk_out,
+							  parent_names[0],
+							  nodes[j].flag, mult,
+							  div);
+			break;
+		case TYPE_DIV1:
+		case TYPE_DIV2:
+			hw = zynqmp_clk_register_divider(NULL, clk_out, clk_id,
+							 nodes[j].type,
+							 parent_names[0],
+							 nodes[j].flag,
+							 nodes[j].type_flag);
+			break;
+		case TYPE_GATE:
+
+			hw = zynqmp_clk_register_gate(NULL, clk_out, clk_id,
+						      parent_names[0],
+						      nodes[j].flag,
+						      nodes[j].type_flag);
+			break;
+		default:
+			pr_err("%s() Unknown topology for %s\n",
+			       __func__, clk_out);
+			break;
+		}
+		if (IS_ERR(hw))
+			pr_warn_once("%s() %s register fail with %ld\n",
+				     __func__, clk_name, PTR_ERR(hw));
+
+		parent_names[0] = clk_out;
+	}
+	kfree(clk_out);
+	return hw;
+}
+
+/**
+ * zynqmp_register_clocks() - Register clocks
+ * @np:		Device node
+ *
+ * Return: 0 on success else error code
+ */
+static int zynqmp_register_clocks(struct device_node *np)
+{
+	int ret;
+	u32 i, total_parents = 0, type = 0;
+	const char *parent_names[MAX_PARENT];
+
+	for (i = 0; i < clock_max_idx; i++) {
+		char clk_name[MAX_NAME_LEN];
+
+		/* get clock name, continue to next clock if name not found */
+		if (zynqmp_get_clock_name(i, clk_name))
+			continue;
+
+		/* Check if clock is valid and output clock.
+		 * Do not regiter invalid or external clock.
+		 */
+		ret = zynqmp_get_clock_type(i, &type);
+		if (ret || type != CLK_TYPE_OUTPUT)
+			continue;
+
+		/* Get parents of clock*/
+		if (zynqmp_get_parent_list(np, i, parent_names,
+					   &total_parents)) {
+			WARN_ONCE(1, "No parents found for %s\n",
+				  clock[i].clk_name);
+			continue;
+		}
+
+		zynqmp_data->hws[i] =
+			zynqmp_register_clk_topology(i, clk_name,
+						     total_parents,
+						     parent_names);
+	}
+
+	for (i = 0; i < clock_max_idx; i++) {
+		if (IS_ERR(zynqmp_data->hws[i])) {
+			pr_err("Zynq Ultrascale+ MPSoC clk %s: register failed with %ld\n",
+			       clock[i].clk_name, PTR_ERR(zynqmp_data->hws[i]));
+			WARN_ON(1);
+		}
+	}
+	return 0;
+}
+
+/**
+ * zynqmp_get_clock_info() - Get clock information from firmware using PM_API
+ */
+static void zynqmp_get_clock_info(void)
+{
+	int i, ret;
+	u32 attr, type = 0;
+
+	memset(clock, 0, sizeof(clock));
+	for (i = 0; i < MAX_CLOCK; i++) {
+		zynqmp_pm_clock_get_name(i, clock[i].clk_name);
+		if (!strcmp(clock[i].clk_name, END_OF_CLK_NAME)) {
+			clock_max_idx = i;
+			break;
+		} else if (!strcmp(clock[i].clk_name, RESERVED_CLK_NAME)) {
+			continue;
+		}
+
+		ret = zynqmp_pm_clock_get_attributes(i, &attr);
+		if (ret)
+			continue;
+
+		clock[i].valid = attr & CLK_VALID_MASK;
+		clock[i].init_enable = !!(attr & CLK_INIT_ENABLE_MASK);
+		clock[i].type = attr >> CLK_TYPE_SHIFT ? CLK_TYPE_EXTERNAL :
+							CLK_TYPE_OUTPUT;
+	}
+
+	/* Get topology of all clock */
+	for (i = 0; i < clock_max_idx; i++) {
+		ret = zynqmp_get_clock_type(i, &type);
+		if (ret || type != CLK_TYPE_OUTPUT)
+			continue;
+
+		ret = zynqmp_clock_get_topology(i, clock[i].node,
+						&clock[i].num_nodes);
+		if (ret)
+			continue;
+
+		ret = zynqmp_clock_get_parents(i, clock[i].parent,
+					       &clock[i].num_parents);
+		if (ret)
+			continue;
+	}
+}
+
+/**
+ * zynqmp_validate_eemi_ops() - Validate eemi ops
+ *
+ * Return: 0 on success else error code
+ */
+static inline int zynqmp_validate_eemi_ops(void)
+{
+	eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (!eemi_ops || !eemi_ops->query_data ||
+	    !eemi_ops->clock_setdivider ||
+	    !eemi_ops->clock_getdivider ||
+	    !eemi_ops->clock_setparent ||
+	    !eemi_ops->clock_getparent ||
+	    !eemi_ops->clock_getstate ||
+	    !eemi_ops->clock_disable ||
+	    !eemi_ops->clock_enable ||
+	    !eemi_ops->ioctl)
+		return -ENXIO;
+
+	return 0;
+}
+
+/**
+ * zynqmp_clk_setup() - Setup the clock framework and register clocks
+ * @np:		Device node
+ *
+ * Return: 0 on success else error code
+ */
+static int __init zynqmp_clk_setup(struct device_node *np)
+{
+	int idx;
+
+	idx = of_property_match_string(np, "clock-names", "pss_ref_clk");
+	if (idx < 0) {
+		pr_err("pss_ref_clk not provided\n");
+		return -ENOENT;
+	}
+	idx = of_property_match_string(np, "clock-names", "video_clk");
+	if (idx < 0) {
+		pr_err("video_clk not provided\n");
+		return -ENOENT;
+	}
+	idx = of_property_match_string(np, "clock-names", "pss_alt_ref_clk");
+	if (idx < 0) {
+		pr_err("pss_alt_ref_clk not provided\n");
+		return -ENOENT;
+	}
+	idx = of_property_match_string(np, "clock-names", "aux_ref_clk");
+	if (idx < 0) {
+		pr_err("aux_ref_clk not provided\n");
+		return -ENOENT;
+	}
+	idx = of_property_match_string(np, "clock-names", "gt_crx_ref_clk");
+	if (idx < 0) {
+		pr_err("aux_ref_clk not provided\n");
+		return -ENOENT;
+	}
+
+	zynqmp_data = kzalloc(sizeof(*zynqmp_data) + sizeof(*zynqmp_data) *
+						MAX_CLOCK, GFP_KERNEL);
+	if (!zynqmp_data)
+		return -ENOMEM;
+
+	zynqmp_get_clock_info();
+	zynqmp_register_clocks(np);
+
+	zynqmp_data->num = clock_max_idx;
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, zynqmp_data);
+
+	return 0;
+}
+
+/**
+ * zynqmp_clock_init() - Initialize zynqmp clocks
+ *
+ * Return: 0 on success else error code
+ */
+static int __init zynqmp_clock_init(void)
+{
+	int ret;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
+	if (!np)
+		return -ENOENT;
+	of_node_put(np);
+
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-clk");
+	if (!np) {
+		pr_err("%s: clk node not found\n", __func__);
+		return -ENOENT;
+	}
+
+	ret = zynqmp_validate_eemi_ops();
+	if (ret) {
+		pr_err("%s: eemi ops validation fail\n", __func__);
+		of_node_put(np);
+		return ret;
+	}
+
+	ret = zynqmp_clk_setup(np);
+	of_node_put(np);
+
+	return ret;
+}
+arch_initcall(zynqmp_clock_init);
diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
new file mode 100644
index 0000000..ef3e2e9
--- /dev/null
+++ b/drivers/clk/zynqmp/divider.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zynq UltraScale+ MPSoC Divider support
+ *
+ *  Copyright (C) 2016-2018 Xilinx
+ *
+ * Adjustable divider clock implementation
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include "clk-zynqmp.h"
+
+/*
+ * DOC: basic adjustable divider clock that cannot gate
+ *
+ * Traits of this clock:
+ * prepare - clk_prepare only ensures that parents are prepared
+ * enable - clk_enable only ensures that parents are enabled
+ * rate - rate is adjustable.  clk->rate = ceiling(parent->rate / divisor)
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+#define to_zynqmp_clk_divider(_hw)		\
+	container_of(_hw, struct zynqmp_clk_divider, hw)
+
+#define CLK_FRAC	BIT(13) /* has a fractional parent */
+
+/**
+ * struct zynqmp_clk_divider - adjustable divider clock
+ * @hw:		handle between common and hardware-specific interfaces
+ * @flags:	Hardware specific flags
+ * @clk_id:	Id of clock
+ * @div_type:	divisor type (TYPE_DIV1 or TYPE_DIV2)
+ */
+struct zynqmp_clk_divider {
+	struct clk_hw hw;
+	u8 flags;
+	u32 clk_id;
+	u32 div_type;
+};
+
+static int zynqmp_divider_get_val(unsigned long parent_rate, unsigned long rate)
+{
+	return DIV_ROUND_CLOSEST(parent_rate, rate);
+}
+
+/**
+ * zynqmp_clk_divider_recalc_rate() - Recalc rate of divider clock
+ * @hw:			handle between common and hardware-specific interfaces
+ * @parent_rate:	rate of parent clock
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
+						    unsigned long parent_rate)
+{
+	struct zynqmp_clk_divider *divider = to_zynqmp_clk_divider(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = divider->clk_id;
+	u32 div_type = divider->div_type;
+	u32 div, value;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_getdivider(clk_id, &div);
+
+	if (ret)
+		pr_warn_once("%s() get divider failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	if (div_type == TYPE_DIV1)
+		value = div & 0xFFFF;
+	else
+		value = (div >> 16) & 0xFFFF;
+
+	return DIV_ROUND_UP_ULL(parent_rate, value);
+}
+
+/**
+ * zynqmp_clk_divider_round_rate() - Round rate of divider clock
+ * @hw:			handle between common and hardware-specific interfaces
+ * @rate:		rate of clock to be set
+ * @prate:		rate of parent clock
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
+					  unsigned long rate,
+					  unsigned long *prate)
+{
+	struct zynqmp_clk_divider *divider = to_zynqmp_clk_divider(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = divider->clk_id;
+	u32 div_type = divider->div_type;
+	u32 bestdiv;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	/* if read only, just return current value */
+	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
+		ret = eemi_ops->clock_getdivider(clk_id, &bestdiv);
+
+		if (ret)
+			pr_warn_once("%s() get divider failed for %s, ret = %d\n",
+				     __func__, clk_name, ret);
+		if (div_type == TYPE_DIV1)
+			bestdiv = bestdiv & 0xFFFF;
+		else
+			bestdiv  = (bestdiv >> 16) & 0xFFFF;
+
+		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
+	}
+
+	bestdiv = zynqmp_divider_get_val(*prate, rate);
+
+	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) &&
+	    (clk_hw_get_flags(hw) & CLK_FRAC))
+		bestdiv = rate % *prate ? 1 : bestdiv;
+	*prate = rate * bestdiv;
+
+	return rate;
+}
+
+/**
+ * zynqmp_clk_divider_set_rate() - Set rate of divider clock
+ * @hw:			handle between common and hardware-specific interfaces
+ * @rate:		rate of clock to be set
+ * @parent_rate:	rate of parent clock
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long parent_rate)
+{
+	struct zynqmp_clk_divider *divider = to_zynqmp_clk_divider(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = divider->clk_id;
+	u32 div_type = divider->div_type;
+	u32 value, div;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	value = zynqmp_divider_get_val(parent_rate, rate);
+	if (div_type == TYPE_DIV1) {
+		div = value & 0xFFFF;
+		div |= 0xffff << 16;
+	} else {
+		div = 0xffff;
+		div |= value << 16;
+	}
+
+	ret = eemi_ops->clock_setdivider(clk_id, div);
+
+	if (ret)
+		pr_warn_once("%s() set divider failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return ret;
+}
+
+static const struct clk_ops zynqmp_clk_divider_ops = {
+	.recalc_rate = zynqmp_clk_divider_recalc_rate,
+	.round_rate = zynqmp_clk_divider_round_rate,
+	.set_rate = zynqmp_clk_divider_set_rate,
+};
+
+/**
+ * zynqmp_clk_register_divider() - register a divider clock
+ * @dev:		device registering this clock
+ * @name:		name of this clock
+ * @clk_id:		Id of clock
+ * @div_type:		Type of divisor
+ * @parent:		name of clock's parent
+ * @flags:		framework-specific flags
+ * @clk_divider_flags:	divider-specific flags for this clock
+ *
+ * Return: clock hardware to registered clock divider
+ */
+struct clk_hw *zynqmp_clk_register_divider(struct device *dev,
+					   const char *name,
+					   u32 clk_id, u32 div_type,
+					   const char *parent,
+					   unsigned long flags,
+					   u8 clk_divider_flags)
+{
+	struct zynqmp_clk_divider *div;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	/* allocate the divider */
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &zynqmp_clk_divider_ops;
+	init.flags = flags;
+	init.parent_names = &parent;
+	init.num_parents = 1;
+
+	/* struct clk_divider assignments */
+	div->flags = clk_divider_flags;
+	div->hw.init = &init;
+	div->clk_id = clk_id;
+	div->div_type = div_type;
+
+	hw = &div->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(div);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(zynqmp_clk_register_divider);
diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
new file mode 100644
index 0000000..1782829
--- /dev/null
+++ b/drivers/clk/zynqmp/pll.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zynq UltraScale+ MPSoC PLL driver
+ *
+ *  Copyright (C) 2016-2018 Xilinx
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include "clk-zynqmp.h"
+
+/**
+ * struct zynqmp_pll - Structure for PLL clock
+ * @hw:		Handle between common and hardware-specific interfaces
+ * @clk_id:	PLL clock ID
+ */
+struct zynqmp_pll {
+	struct clk_hw hw;
+	u32 clk_id;
+};
+
+#define to_zynqmp_pll(_hw)	container_of(_hw, struct zynqmp_pll, hw)
+
+#define PLL_FBDIV_MIN	25
+#define PLL_FBDIV_MAX	125
+
+#define PS_PLL_VCO_MIN 1500000000
+#define PS_PLL_VCO_MAX 3000000000UL
+
+enum pll_mode {
+	PLL_MODE_INT,
+	PLL_MODE_FRAC,
+};
+
+#define FRAC_OFFSET 0x8
+#define PLLFCFG_FRAC_EN	BIT(31)
+#define FRAC_DIV  BIT(16)  /* 2^16 */
+
+/**
+ * zynqmp_pll_get_mode() - Get mode of PLL
+ * @hw:		Handle between common and hardware-specific interfaces
+ *
+ * Return: Mode of PLL
+ */
+static inline enum pll_mode zynqmp_pll_get_mode(struct clk_hw *hw)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	u32 clk_id = clk->clk_id;
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->ioctl(0, IOCTL_GET_PLL_FRAC_MODE, clk_id, 0,
+			      ret_payload);
+	if (ret)
+		pr_warn_once("%s() PLL get frac mode failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return ret_payload[1];
+}
+
+/**
+ * zynqmp_pll_set_mode() - Set the PLL mode
+ * @hw:		Handle between common and hardware-specific interfaces
+ * @on:		Flag to determine the mode
+ */
+static inline void zynqmp_pll_set_mode(struct clk_hw *hw, bool on)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	u32 clk_id = clk->clk_id;
+	const char *clk_name = clk_hw_get_name(hw);
+	int ret;
+	u32 mode;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (on)
+		mode = PLL_MODE_FRAC;
+	else
+		mode = PLL_MODE_INT;
+
+	ret = eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_MODE, clk_id, mode, NULL);
+	if (ret)
+		pr_warn_once("%s() PLL set frac mode failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+}
+
+/**
+ * zynqmp_pll_round_rate() - Round a clock frequency
+ * @hw:		Handle between common and hardware-specific interfaces
+ * @rate:	Desired clock frequency
+ * @prate:	Clock frequency of parent clock
+ *
+ * Return: Frequency closest to @rate the hardware can generate
+ */
+static long zynqmp_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *prate)
+{
+	u32 fbdiv;
+	long rate_div, f;
+
+	/* Enable the fractional mode if needed */
+	rate_div = (rate * FRAC_DIV) / *prate;
+	f = rate_div % FRAC_DIV;
+	zynqmp_pll_set_mode(hw, !!f);
+
+	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
+		if (rate > PS_PLL_VCO_MAX) {
+			fbdiv = rate / PS_PLL_VCO_MAX;
+			rate = rate / (fbdiv + 1);
+		}
+		if (rate < PS_PLL_VCO_MIN) {
+			fbdiv = DIV_ROUND_UP(PS_PLL_VCO_MIN, rate);
+			rate = rate * fbdiv;
+		}
+		return rate;
+	}
+
+	fbdiv = DIV_ROUND_CLOSEST(rate, *prate);
+	fbdiv = clamp_t(u32, fbdiv, PLL_FBDIV_MIN, PLL_FBDIV_MAX);
+	return *prate * fbdiv;
+}
+
+/**
+ * zynqmp_pll_recalc_rate() - Recalculate clock frequency
+ * @hw:			Handle between common and hardware-specific interfaces
+ * @parent_rate:	Clock frequency of parent clock
+ *
+ * Return: Current clock frequency
+ */
+static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	u32 clk_id = clk->clk_id;
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 fbdiv, data;
+	unsigned long rate, frac;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	/*
+	 * makes probably sense to redundantly save fbdiv in the struct
+	 * zynqmp_pll to save the IO access.
+	 */
+	ret = eemi_ops->clock_getdivider(clk_id, &fbdiv);
+	if (ret)
+		pr_warn_once("%s() get divider failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	rate =  parent_rate * fbdiv;
+	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
+		eemi_ops->ioctl(0, IOCTL_GET_PLL_FRAC_DATA, clk_id, 0,
+				ret_payload);
+		data = ret_payload[1];
+		frac = (parent_rate * data) / FRAC_DIV;
+		rate = rate + frac;
+	}
+
+	return rate;
+}
+
+/**
+ * zynqmp_pll_set_rate() - Set rate of PLL
+ * @hw:			Handle between common and hardware-specific interfaces
+ * @rate:		Frequency of clock to be set
+ * @parent_rate:	Clock frequency of parent clock
+ *
+ * Set PLL divider to set desired rate.
+ *
+ * Returns:            rate which is set on success else error code
+ */
+static int zynqmp_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	u32 clk_id = clk->clk_id;
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 fbdiv, data;
+	long rate_div, frac, m, f;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
+		rate_div = ((rate * FRAC_DIV) / parent_rate);
+		m = rate_div / FRAC_DIV;
+		f = rate_div % FRAC_DIV;
+		m = clamp_t(u32, m, (PLL_FBDIV_MIN), (PLL_FBDIV_MAX));
+		rate = parent_rate * m;
+		frac = (parent_rate * f) / FRAC_DIV;
+
+		ret = eemi_ops->clock_setdivider(clk_id, m);
+		if (ret)
+			pr_warn_once("%s() set divider failed for %s, ret = %d\n",
+				     __func__, clk_name, ret);
+
+		data = (FRAC_DIV * f) / FRAC_DIV;
+		eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_DATA, clk_id, data, NULL);
+
+		return rate + frac;
+	}
+
+	fbdiv = DIV_ROUND_CLOSEST(rate, parent_rate);
+	fbdiv = clamp_t(u32, fbdiv, PLL_FBDIV_MIN, PLL_FBDIV_MAX);
+	ret = eemi_ops->clock_setdivider(clk_id, fbdiv);
+	if (ret)
+		pr_warn_once("%s() set divider failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return parent_rate * fbdiv;
+}
+
+/**
+ * zynqmp_pll_is_enabled() - Check if a clock is enabled
+ * @hw:		Handle between common and hardware-specific interfaces
+ *
+ * Return: 1 if the clock is enabled, 0 otherwise
+ */
+static int zynqmp_pll_is_enabled(struct clk_hw *hw)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = clk->clk_id;
+	unsigned int state;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_getstate(clk_id, &state);
+	if (ret) {
+		pr_warn_once("%s() clock get state failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+		return -EIO;
+	}
+
+	return state ? 1 : 0;
+}
+
+/**
+ * zynqmp_pll_enable() - Enable clock
+ * @hw:		Handle between common and hardware-specific interfaces
+ *
+ * Return: 0 on success else error code
+ */
+static int zynqmp_pll_enable(struct clk_hw *hw)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = clk->clk_id;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (zynqmp_pll_is_enabled(hw))
+		return 0;
+
+	pr_info("PLL: enable\n");
+
+	ret = eemi_ops->clock_enable(clk_id);
+	if (ret)
+		pr_warn_once("%s() clock enable failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return ret;
+}
+
+/**
+ * zynqmp_pll_disable() - Disable clock
+ * @hw:		Handle between common and hardware-specific interfaces
+ */
+static void zynqmp_pll_disable(struct clk_hw *hw)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = clk->clk_id;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!zynqmp_pll_is_enabled(hw))
+		return;
+
+	pr_info("PLL: shutdown\n");
+
+	ret = eemi_ops->clock_disable(clk_id);
+	if (ret)
+		pr_warn_once("%s() clock disable failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+}
+
+static const struct clk_ops zynqmp_pll_ops = {
+	.enable = zynqmp_pll_enable,
+	.disable = zynqmp_pll_disable,
+	.is_enabled = zynqmp_pll_is_enabled,
+	.round_rate = zynqmp_pll_round_rate,
+	.recalc_rate = zynqmp_pll_recalc_rate,
+	.set_rate = zynqmp_pll_set_rate,
+};
+
+/**
+ * zynqmp_clk_register_pll() - Register PLL with the clock framework
+ * @dev:	Device pointer
+ * @name:	PLL name
+ * @clk_id:	Clock ID
+ * @parent:	Parent clock name
+ * @flag:	PLL flgas
+ *
+ * Return: clock hardware to the registered clock
+ */
+struct clk_hw *zynqmp_clk_register_pll(struct device *dev, const char *name,
+				       u32 clk_id,
+				       const char *parent,
+				       unsigned long flag)
+{
+	struct zynqmp_pll *pll;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	init.name = name;
+	init.ops = &zynqmp_pll_ops;
+	init.flags = flag;
+	init.parent_names = &parent;
+	init.num_parents = 1;
+
+	pll = kmalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	/* Populate the struct */
+	pll->hw.init = &init;
+	pll->clk_id = clk_id;
+
+	hw = &pll->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+
+	clk_hw_set_rate_range(hw, PS_PLL_VCO_MIN, PS_PLL_VCO_MAX);
+	if (ret < 0)
+		pr_err("%s:ERROR clk_set_rate_range failed %d\n", name, ret);
+
+	return hw;
+}
-- 
2.7.4

