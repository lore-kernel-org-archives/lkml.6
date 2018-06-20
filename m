Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01F9C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC0C20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="I9W0z3Mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC0C20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeFTRmi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:42:38 -0400
Received: from mail-bl2nam02on0065.outbound.protection.outlook.com ([104.47.38.65]:22755
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754230AbeFTRlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwtiiZiHzfLbbVRcBmMNvRgGT2rBdNot346Kz+HPsXk=;
 b=I9W0z3Mo3HpxiHlwCCYMLclXUY5Z05mV6GKzzahcLRySzed5gIpsooJVMzwNeGQN7Kxo1CaL73kXokFhFLIJdTKkl/UmQcyiz7/ZKM9hExSXADgjnSNerguKTYYu3m373wq26C4W56hFIr9FDGsvkBtsI+ZNtBVdpMthdf8m8Ys=
Received: from MWHPR02CA0024.namprd02.prod.outlook.com (2603:10b6:300:4b::34)
 by CO1PR02MB175.namprd02.prod.outlook.com (2a01:111:e400:101e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.863.19; Wed, 20
 Jun 2018 17:40:58 +0000
Received: from CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by MWHPR02CA0024.outlook.office365.com
 (2603:10b6:300:4b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Wed, 20 Jun 2018 17:40:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT030.mail.protection.outlook.com (10.152.75.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Wed, 20 Jun 2018 17:40:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6G-0002P6-9w; Wed, 20 Jun 2018 10:40:56 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6B-0004lu-6L; Wed, 20 Jun 2018 10:40:51 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5KHef7X027139;
        Wed, 20 Jun 2018 10:40:42 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fVh61-0004hY-OG; Wed, 20 Jun 2018 10:40:41 -0700
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
Subject: [PATCH v9 02/10] firmware: xilinx: Add Zynqmp firmware driver
Date:   Wed, 20 Jun 2018 10:40:27 -0700
Message-ID: <1529516435-7315-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(346002)(39860400002)(376002)(2980300002)(438002)(199004)(189003)(106466001)(81166006)(106002)(50226002)(8676002)(63266004)(5660300001)(356003)(336012)(48376002)(2906002)(50466002)(6666003)(110136005)(9786002)(478600001)(72206003)(8936002)(81156014)(47776003)(54906003)(186003)(575784001)(16586007)(316002)(2201001)(77096007)(26005)(126002)(51416003)(476003)(2616005)(486006)(36756003)(7416002)(305945005)(59450400001)(4326008)(7696005)(426003)(11346002)(446003)(44832011)(36386004)(39060400002)(76176011)(107886003)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1PR02MB175;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT030;1:cGJ/zKS35xaf5EAwaoyT0BLwwOYn3dwdk7TXiNAOsjT+K6r/q8Y/1q7Je9cLobjD7N4W2LC7friGQFfL1jM3HB91wMj5CykmvPucdnJzwYUFusfhoI7CTiBVndCYlNiI
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d54ecdb-4c89-440f-2d7f-08d5d6d4fb38
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:CO1PR02MB175;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB175;3:KKmWf17zL139s7KRfKtrVGcA2KvpRW9Y4kVeqnmzW8smwDk/stM4US9TY4KnwE+GJXh7qHMQyTnb5tZmnvLsNiz8AY3l5E+o/4/124rAkrKyqdkgPCYM/HOqSQFCYfueIism+7v1ViEGtkxfVkKygNtXbOzOxpV/FKVMDL8GQaPbhq+adfdJ0dIk3eUBhnj100l7SpI8rZPBun37uGCh+4T19Fx1XCwLQFGaoDAW+heVu3rKhBY8bYikmr7yrEIOP5FWsIOQ8u1Mb0kXDHOCWP+zzFe5D3w+ud2wys+CSk3T9LqkOL3FcbS1WfXdjNpzxBmR9x2I8/kZyT4nuptN56pOEq2LaSbmusIop4l2aIk=;25:o0KSMEKUuRx0m/27x6DOCOrp+KConHxcjpNre5Q03/8f7GrEy4aaYtGee+FYn+2JLGx3TbYcOaDFJt8+dTg95h+JP5ru+/kK7gxDGpodB7Hz+k9m0MN5en8gdV87p6UsxHiPIy58gBCDSOcm4nlnafQXSRGhXuPC7AVxsp+WGY4WqCNoCXuWbrd+WgF5YulOekoyZLazyl6CjJB0ysjaZH6zaKIXbVNv71jxkwMfpQLcPaEl3Q2UeBbY4JSThRsTS1OmYNAf4w6g9wgQi3fhD+M3iz9KPP1Pf+zRJVvjMKXgXvQEh0jNj/BmDmsIm/wW0DX/wntwI8pG6t0kfSvJgw==
X-MS-TrafficTypeDiagnostic: CO1PR02MB175:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB175;31:I9azf/cS1t/LBpaRj3hhGpBtsZsrlNi7ISAdX9nYlwgiQzUFy7qJKFFtWAT4+emDjzDxZzWwAOya0nXAcbR2dBStZAD/07jWy/r4cDyioR+j78PaJ1XJRKhsbniz2K1vBo5gzqHPWNXrZ+3rhKK9AusyljsIrBdsWvUu+s+n0bDZ5CsmgKP3dCygmjsUx5o+BzxaP5feJHabkKcCYt2UoSmbL+Drrn07pg2ptRHPJcA=;20:G+NmzDY1NoLDsXq7ztxmrO5NFiYIl8vGg2OUN6Rvoe4BHkMVFMdF/ndXGLL1fFoUTBAK9o9H7k8tQjrmd+uOwyNxmAZmTRywOoqqwhhB6p69bjitJHoeZA+Q8qLbleFEypxlCCH8QwOGazU0aqhh9eApeu9bwuPxjtSJjVwsIEGOM1pKbU7aCii2ngWAcVDsmtyMsjdvXMPi8NuWrkVoIKV96xbDBKUcs6FoaHJdWlr0XLA1ROkm1CMQVTpo0CGkMEZv6KMbcT5Ui4P1l4vXQxP/tj1xUjgDZtvdSAPk0GVI6ZjAWIxAmGZRgfB2aTSof7HfD01MwIkgC+BTUlVTX0wtvYvcuwigQ9eNDqzQeX8Nu/lLYsU3IS3f9KywywPyUVrP4WxmZLQd3pYNUfyaC86ZzAjh8f216h8EK8XM4xZRaBTRrHMQ+iot6PG8Xed6frgFMdKDbcNR3D54vc5d0Tk83yrsHZ4ALxejqJM2za++7hYAGPB8nCpMjKDp867g
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CO1PR02MB17534C147557209DA2809CEB8770@CO1PR02MB175.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CO1PR02MB175;BCL:0;PCL:0;RULEID:;SRVR:CO1PR02MB175;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB175;4:shfbFwA6830sA1H0WxHa25tslCUlD+MV7KDCF1mv2DLtM8THsVNP4OhSYsv74AKWZI0SEIx764gfq6nT9DRr0R1VmIJ11x97okuQMGiYmsX98i+H8hAXnOkFP5NXpDj361nVG4FTI2oYWBk3SA4PmYgjvdiklDe1hCSoez4KenUw56w06hNjgH1P6Ov7WUGrDi/Gakbs5XluPJ1GpMafvHyMeNQ4NGQ6UCs95Mhk2t9CWiOhUc/FXQfGaq9nmGz26aa5Tn5jJet/05Ek/cuozRCT0WZq3d1asA/HH+yKNKOV6GIcOlrrSZmiRDa2MmKn
X-Forefront-PRVS: 070912876F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR02MB175;23:2VTwVaZXZIveVBFZSiwJHkENQhJcY3zNBf7GeQz5GA?=
 =?us-ascii?Q?fScaSRp99W6ey7QwHD5EL8KW9c1/mr7VTxO6RF5ltxdKYWXAnvoPCaAeLJ+Y?=
 =?us-ascii?Q?KaR3OyGp+g4tmYkbTr71Qrk0uoqZR8MdVld0E+LBc+Ur0++cGhi5QRvnqUfR?=
 =?us-ascii?Q?zROPru1iuAOIGhb1FiwL7JuU9+eQIGRuEDAjbLgFxMIBuNQ3wiFH0eEiDR/c?=
 =?us-ascii?Q?bmPFp2608lm4ZrpzX/mnTNklqu0pwXzV0YDa9oJfS56zs8smGWdYZYp5zHCW?=
 =?us-ascii?Q?AzVcaMkefUgVyMXgBUBKevjLi/Q+nkRegth/UyyYC+BECSvoKXeZOyCH/T6u?=
 =?us-ascii?Q?H6MuAcLExt8xfpM60fCY9owDSCl++iVUjDQW0lHws7wh8KrDULW/mKVSuxXM?=
 =?us-ascii?Q?o9SPF9i6Q0K5aI7HK67kXv0x7VF151Trya2U75eXuWvx5lGDQyGCk4wrgv9I?=
 =?us-ascii?Q?DzDQywqFWYGSaB9WbNWTONjNhDtjogeVM6kCzlozX8tU7+ED+I85ipxlDzVm?=
 =?us-ascii?Q?EyO5Hs5Hhh20Jh1n2aYMLGZK5VQktFCx1a9B5b++aTobsBKu/uC09uajCeFj?=
 =?us-ascii?Q?kB2NRUUcHubTKON4GZnGY2GlFx9GYNxEDWGKMYovPBwXzyZ70ym/KXC1tHeF?=
 =?us-ascii?Q?3kVsWofXm+JDPf5usE1ekb+6lR0ERq3g6VVCWteP8xzJHVTL6/0eo8wYoIYI?=
 =?us-ascii?Q?3Rh2I9p6tRzkPWpmP5HkETPhHiUYdaWEpINdz/qKu+cMyZPFRvmHNgrtjDWm?=
 =?us-ascii?Q?tSHviRacdqz7ffSLyXiedKpPdxKIlq2nl3GSRQqYd7syXBUzfQ9ei89kbNK7?=
 =?us-ascii?Q?7QpHJrdUiL6t4JxsXvvG+eoP5oEf36GwjAQHhzpN0ntRjulCQtXBgzhsD7NY?=
 =?us-ascii?Q?fLarAWPzIHQ5IsMsiRiuQhsUxGoIvy2Q2wQKyMkJnJBqkmFS1V2j6XEUl+di?=
 =?us-ascii?Q?W4HYGZ4AqvExQL7HfoPW3VUrtECTYCdvxzAxCcJawj/dk4CJfPuYI8YHa9Hv?=
 =?us-ascii?Q?ZOsYsc3kVQoUcpkpPBJTRLBMt4EtRP1eROGk4m0SU+kYAIzVaGsaXp8XL3Cz?=
 =?us-ascii?Q?pv7FGiCxPS0Cjv4DJFM7mNAL8c6RWrNecqefP9KFwNf60AEiodY4fcVBDvin?=
 =?us-ascii?Q?g3f9kmmEuwy7maMzh6+FjRD29ftd/ZlBVPkq+Gz17pP48XWqpB7+SHKgnPbx?=
 =?us-ascii?Q?rt45bC8uBR5UgQ1Ewat3PGetq95754wTxzEQKw0lT1r6jY4Y3FEfWulCKEqV?=
 =?us-ascii?Q?BDooBURQLBOYYCdbZnxwteiAM8dh0J+WwpmolmYHQGZz8hD9MOq7C+C8Tpfd?=
 =?us-ascii?Q?+5T8pnu6cSD5votkCNuNs=3D?=
X-Microsoft-Antispam-Message-Info: KnI4hW9k2Ym6reYDhNln256lzo0XVEvXYmMkab9QiDc8WCy4XZR8DYObhhQVROthI9Y+QI9VLTl3bQHRYF1xHmh+x6dbzOtADpqymGBpjTUn0T5q4RTN9hHPqDJ4ets82pdKibSs+V5lmKwQtGDML2nM0kGMz41eqn3XBfXavuoXQPzTmA1sA/GwDYfqavDnIPQO9Yts7ZDyNQZK0ynmyk2DYlIsShOBHGPGd7FQ3SqOtgK1tql05Hy0hwyKx2jPAkVhMtTF76/B0KqdSFIF9t38IFmFaT15hNpL71QCqmqzE9UBshIR6YyKGmWdVsGndppLo8e8fhsBBR7RpMK5WQ==
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB175;6:C+jZ95t0p2PsSFAkA5/bnp+yCK+zj7Nei6HNxM1fRt7Jwh3tnjUHQ6LRL/5ILJhIdEuylT98Ap0iATB5gAa18UqzivAh+G1a5GgNbrdoPahswfO1OGbt/VLw988+tVXhmWX+BnC+yKp9DBGJbPMZxvU1BFg0GrxUBB76ZdF8H9+Dv7O0RswwaLwXbnYWKVpACFjkJqlgjyPQ0kl64Kl4U6mZA/Lyhz8lVT7Pr3Sk7A7Yh0ocIMPov743Tfd2Scb+TJy9BnyoJcpL2TFh/asqYH4r7WAKXw04CfxknlB0ocY96si2+DEqJCqsWD2ndiHmVKnyVmjBmeW0no08f+Er148C95isWJ4MtzX+S5wS/JH/jfK4Oocbc6WNWAvgeJbAy48menRz82BlwjmdlaxRqlXvDVT4XOtIzomeRQJUZIZQRNQmisYFte3Mgo8l0iG+ubrJB2r6elsr9wy4IwCGiQ==;5:V0Vre/4G1roJTNrGEsHxS5fvRAyQzvXLmdXlwDWNeV3MJ+v1HUQmzGuOvnyCob5gAHaf2NO8zHT/TdS0/HMroOGFqd0MUfg2Psl0kfKiyzWVaKb7FjLZVZFHNJxCil1t8ymurCRH0aNjQQRCYwXUR7QTbIgappPtiEkKBeDofak=;24:7H2/vZGC2uXvFka2uidWLBt0JVcTpwIUSSswqKVEjtLehraDGE9UDb1NUseS/VG1ftwsIrN5p/504KE92jlX/laJfEB9JiKZvvOrrG/RN0A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB175;7:kwIe9MxhTVIgWHXZVACCUuuwUr/VTu3uVYFDICsbW3ITyIjVraHx792/fkuho24cOGpknRgPotqgrCroBsZXPDeCp4gqCGg5c07h1C7EEdqLpuAvXGRpIzETMLcBJV6kkmkeIqCV5ylXCnrILwIsb7SwwA6BeSJw3qGWL7woAJdomct86rXmaPywB95qoPV2BfG3VKYQrhfUmf1AH3PZRMrc67F1PFn4T5lyU/LxQjATXJwn5tUiQCcvUnO0/Q2E
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 17:40:56.8498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d54ecdb-4c89-440f-2d7f-08d5d6d4fb38
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

This patch is adding communication layer with firmware.
Firmware driver provides an interface to firmware APIs.
Interface APIs can be used by any driver to communicate to
PMUFW(Platform Management Unit). All requests go through ATF.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 arch/arm64/Kconfig.platforms         |   1 +
 drivers/firmware/Kconfig             |   1 +
 drivers/firmware/Makefile            |   1 +
 drivers/firmware/xilinx/Kconfig      |  16 ++
 drivers/firmware/xilinx/Makefile     |   4 +
 drivers/firmware/xilinx/zynqmp.c     | 337 +++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  63 +++++++
 7 files changed, 423 insertions(+)
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index fbedbd8..6454458 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -274,6 +274,7 @@ config ARCH_ZX
 
 config ARCH_ZYNQMP
 	bool "Xilinx ZynqMP Family"
+	select ZYNQMP_FIRMWARE
 	help
 	  This enables support for Xilinx ZynqMP Family
 
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b7c7482..f41eb0d 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -257,5 +257,6 @@ source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
+source "drivers/firmware/xilinx/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index b248238..f90363e 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
 obj-y				+= tegra/
+obj-y				+= xilinx/
diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
new file mode 100644
index 0000000..64d976e
--- /dev/null
+++ b/drivers/firmware/xilinx/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+# Kconfig for Xilinx firmwares
+
+menu "Zynq MPSoC Firmware Drivers"
+	depends on ARCH_ZYNQMP
+
+config ZYNQMP_FIRMWARE
+	bool "Enable Xilinx Zynq MPSoC firmware interface"
+	help
+	  Firmware interface driver is used by different
+	  drivers to communicate with the firmware for
+	  various platform management services.
+	  Say yes to enable ZynqMP firmware interface driver.
+	  If in doubt, say N.
+
+endmenu
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
new file mode 100644
index 0000000..29f7bf2
--- /dev/null
+++ b/drivers/firmware/xilinx/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for Xilinx firmwares
+
+obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
new file mode 100644
index 0000000..70e335a
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/compiler.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/**
+ * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
+ * @ret_status:		PMUFW return code
+ *
+ * Return: corresponding Linux error code
+ */
+static int zynqmp_pm_ret_code(u32 ret_status)
+{
+	switch (ret_status) {
+	case XST_PM_SUCCESS:
+	case XST_PM_DOUBLE_REQ:
+		return 0;
+	case XST_PM_NO_ACCESS:
+		return -EACCES;
+	case XST_PM_ABORT_SUSPEND:
+		return -ECANCELED;
+	case XST_PM_INTERNAL:
+	case XST_PM_CONFLICT:
+	case XST_PM_INVALID_NODE:
+	default:
+		return -EINVAL;
+	}
+}
+
+static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
+				    u32 *ret_payload)
+{
+	return -ENODEV;
+}
+
+/*
+ * PM function call wrapper
+ * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
+ */
+static int (*do_fw_call)(u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
+
+/**
+ * do_fw_call_smc() - Call system-level platform management layer (SMC)
+ * @arg0:		Argument 0 to SMC call
+ * @arg1:		Argument 1 to SMC call
+ * @arg2:		Argument 2 to SMC call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function via SMC call (no hypervisor present).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * do_fw_call_hvc() - Call system-level platform management layer (HVC)
+ * @arg0:		Argument 0 to HVC call
+ * @arg1:		Argument 1 to HVC call
+ * @arg2:		Argument 2 to HVC call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function via HVC
+ * HVC-based for communication through hypervisor
+ * (no direct communication with ATF).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
+ *			   caller function depending on the configuration
+ * @pm_api_id:		Requested PM-API call
+ * @arg0:		Argument 0 to requested PM-API call
+ * @arg1:		Argument 1 to requested PM-API call
+ * @arg2:		Argument 2 to requested PM-API call
+ * @arg3:		Argument 3 to requested PM-API call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function for SMC or HVC call, depending on
+ * configuration.
+ * Following SMC Calling Convention (SMCCC) for SMC64:
+ * Pm Function Identifier,
+ * PM_SIP_SVC + PM_API_ID =
+ *	((SMC_TYPE_FAST << FUNCID_TYPE_SHIFT)
+ *	((SMC_64) << FUNCID_CC_SHIFT)
+ *	((SIP_START) << FUNCID_OEN_SHIFT)
+ *	((PM_API_ID) & FUNCID_NUM_MASK))
+ *
+ * PM_SIP_SVC	- Registered ZynqMP SIP Service Call.
+ * PM_API_ID	- Platform Management API ID.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload)
+{
+	/*
+	 * Added SIP service call Function Identifier
+	 * Make sure to stay in x0 register
+	 */
+	u64 smc_arg[4];
+
+	smc_arg[0] = PM_SIP_SVC | pm_api_id;
+	smc_arg[1] = ((u64)arg1 << 32) | arg0;
+	smc_arg[2] = ((u64)arg3 << 32) | arg2;
+
+	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
+}
+
+static u32 pm_api_version;
+static u32 pm_tz_version;
+
+/**
+ * zynqmp_pm_get_api_version() - Get version number of PMU PM firmware
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_api_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM API version already verified */
+	if (pm_api_version > 0) {
+		*version = pm_api_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, 0, 0, 0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_trustzone_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM trustzone version already verified */
+	if (pm_tz_version > 0) {
+		*version = pm_tz_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, 0, 0,
+				  0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * get_set_conduit_method() - Choose SMC or HVC based communication
+ * @np:		Pointer to the device_node structure
+ *
+ * Use SMC or HVC-based functions to communicate with EL2/EL3.
+ *
+ * Return: Returns 0 on success or error code
+ */
+static int get_set_conduit_method(struct device_node *np)
+{
+	const char *method;
+
+	if (of_property_read_string(np, "method", &method)) {
+		pr_warn("%s missing \"method\" property\n", __func__);
+		return -ENXIO;
+	}
+
+	if (!strcmp("hvc", method)) {
+		do_fw_call = do_fw_call_hvc;
+	} else if (!strcmp("smc", method)) {
+		do_fw_call = do_fw_call_smc;
+	} else {
+		pr_warn("%s Invalid \"method\" property: %s\n",
+			__func__, method);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct zynqmp_eemi_ops eemi_ops = {
+	.get_api_version = zynqmp_pm_get_api_version,
+};
+
+/**
+ * zynqmp_pm_get_eemi_ops - Get eemi ops functions
+ *
+ * Return: pointer of eemi_ops structure
+ */
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return &eemi_ops;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
+
+static int zynqmp_firmware_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+}
+
+static const struct of_device_id zynqmp_firmware_of_match[] = {
+	{.compatible = "xlnx,zynqmp-firmware"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_firmware_of_match);
+
+static struct platform_driver zynqmp_firmware_driver = {
+	.driver = {
+		.name = "zynqmp_firmware",
+		.of_match_table = zynqmp_firmware_of_match,
+	},
+	.probe = zynqmp_firmware_probe,
+};
+module_platform_driver(zynqmp_firmware_driver);
+
+static int __init zynqmp_plat_init(void)
+{
+	int ret;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
+	if (!np)
+		return 0;
+	of_node_put(np);
+
+	/*
+	 * We're running on a ZynqMP machine,
+	 * the zynqmp-firmware node is mandatory.
+	 */
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-firmware");
+	if (!np) {
+		pr_warn("%s: zynqmp-firmware node not found\n", __func__);
+		return -ENXIO;
+	}
+
+	ret = get_set_conduit_method(np);
+	if (ret) {
+		of_node_put(np);
+		return ret;
+	}
+
+	/* Check PM API version number */
+	zynqmp_pm_get_api_version(&pm_api_version);
+	if (pm_api_version < ZYNQMP_PM_VERSION) {
+		panic("%s Platform Management API version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_PM_VERSION_MAJOR, ZYNQMP_PM_VERSION_MINOR,
+		      pm_api_version >> 16, pm_api_version & 0xFFFF);
+	}
+
+	pr_info("%s Platform Management API v%d.%d\n", __func__,
+		pm_api_version >> 16, pm_api_version & 0xFFFF);
+
+	/* Check trustzone version number */
+	ret = zynqmp_pm_get_trustzone_version(&pm_tz_version);
+	if (ret)
+		panic("Legacy trustzone found without version support\n");
+
+	if (pm_tz_version < ZYNQMP_TZ_VERSION)
+		panic("%s Trustzone version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_TZ_VERSION_MAJOR, ZYNQMP_TZ_VERSION_MINOR,
+		      pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	pr_info("%s Trustzone version v%d.%d\n", __func__,
+		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	of_node_put(np);
+
+	return ret;
+}
+early_initcall(zynqmp_plat_init);
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
new file mode 100644
index 0000000..cb63bed
--- /dev/null
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __FIRMWARE_ZYNQMP_H__
+#define __FIRMWARE_ZYNQMP_H__
+
+#define ZYNQMP_PM_VERSION_MAJOR	1
+#define ZYNQMP_PM_VERSION_MINOR	0
+
+#define ZYNQMP_PM_VERSION	((ZYNQMP_PM_VERSION_MAJOR << 16) | \
+					ZYNQMP_PM_VERSION_MINOR)
+
+#define ZYNQMP_TZ_VERSION_MAJOR	1
+#define ZYNQMP_TZ_VERSION_MINOR	0
+
+#define ZYNQMP_TZ_VERSION	((ZYNQMP_TZ_VERSION_MAJOR << 16) | \
+					ZYNQMP_TZ_VERSION_MINOR)
+
+/* SMC SIP service Call Function Identifier Prefix */
+#define PM_SIP_SVC			0xC2000000
+#define PM_GET_TRUSTZONE_VERSION	0xa03
+
+/* Number of 32bits values in payload */
+#define PAYLOAD_ARG_CNT	4U
+
+enum pm_api_id {
+	PM_GET_API_VERSION = 1,
+};
+
+/* PMU-FW return status codes */
+enum pm_ret_status {
+	XST_PM_SUCCESS = 0,
+	XST_PM_INTERNAL = 2000,
+	XST_PM_CONFLICT,
+	XST_PM_NO_ACCESS,
+	XST_PM_INVALID_NODE,
+	XST_PM_DOUBLE_REQ,
+	XST_PM_ABORT_SUSPEND,
+};
+
+struct zynqmp_eemi_ops {
+	int (*get_api_version)(u32 *version);
+};
+
+#if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
+#else
+static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return NULL;
+}
+#endif
+
+#endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

