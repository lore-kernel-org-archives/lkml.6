Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0A3C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6981C2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PiiddBDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6981C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbeJDW3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:29:44 -0400
Received: from mail-sn1nam01on0046.outbound.protection.outlook.com ([104.47.32.46]:6413
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727472AbeJDW3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+M9KqdVrwaWohLtX5ol4EdWWvwIfvAT9j3hDU1B9ok=;
 b=PiiddBDL4T/p9ih4RrdcdiLjAEx5dWbsZkuOP3saR0LNRKQkMWhxxkeIow3E0ZH052MQ/C4GxvqATpr55lUgkgG1WmYmk5w6PDgcKTAVRumsbkys8p3xd5oWH+qC4OS5kZJfV50RU55ImO+tTjD1sQXwNtC1gTiblAcvqzWpD24=
Received: from DM6PR02CA0009.namprd02.prod.outlook.com (2603:10b6:5:1c::22) by
 BN7PR02MB5107.namprd02.prod.outlook.com (2603:10b6:408:22::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Thu, 4 Oct 2018 15:35:51 +0000
Received: from BL2NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by DM6PR02CA0009.outlook.office365.com
 (2603:10b6:5:1c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.18 via Frontend
 Transport; Thu, 4 Oct 2018 15:35:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT043.mail.protection.outlook.com (10.152.77.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1207.19
 via Frontend Transport; Thu, 4 Oct 2018 15:35:51 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54896 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fK-0002Y8-Ik; Thu, 04 Oct 2018 08:35:50 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fF-0008Vk-F9; Thu, 04 Oct 2018 08:35:45 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94FZiAx023767;
        Thu, 4 Oct 2018 08:35:44 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g85fD-0008VK-L0; Thu, 04 Oct 2018 08:35:44 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id CF6AD121465; Thu,  4 Oct 2018 21:05:42 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v8 01/10] edac: synopsys: Update the driver code for better readability
Date:   Thu, 4 Oct 2018 21:05:19 +0530
Message-ID: <1538667328-9465-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39850400004)(136003)(2980300002)(438002)(199004)(189003)(36756003)(15650500001)(81166006)(336012)(106466001)(81156014)(90966002)(8936002)(36386004)(8676002)(72206003)(63266004)(356003)(478600001)(50226002)(426003)(76176011)(48376002)(446003)(2906002)(7416002)(51416003)(50466002)(14444005)(305945005)(11346002)(16586007)(103686004)(106002)(44832011)(186003)(54906003)(2616005)(47776003)(6266002)(52956003)(476003)(2201001)(26005)(316002)(5660300001)(6666003)(126002)(4326008)(486006)(110136005)(42186006)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5107;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT043;1:mmumrW1wQ9qZpYrHGxTyVutOufk38xYCHoSEMJN72ST4kRSgG04PqosfuF4uRyXf2KsLLVVBFN3rd+4zOnZhL9IBjPVu7Tyi9Rg7PONTZAWPkqK8EmT/PWnrNoN8IgTx
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b892c77a-8a2b-4451-5394-08d62a0f10d6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5107;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;3:R6Dhe9c9HOhC6v9++h06ewyT0nNgOWxt36d3mcGLJ8GhQQ5/M+iO9B9cAcicdNVRoNy+HvHTOOe64y3XXvQo7IiQ/SumR3fyIO0yVaw9cap3s2ZsAN4WVrzZmPIKYDmYHbfCccVU3d/qHF9DcmoaBC0fWhOjzTR/zNzPd7rRMJEbV9YH6tUG1+G4B0GhcpYuqRIapvl7OA00iCv8dwtPFc4j4ryO95gm6ml1nX/iz5FzMCv9gznQPfta7yAj4SjgNdA+VS91H2w7DqSwvWHthRc7pwgVr/nnPFyrGQ6qjbjQa2+PypixiaZ4cBcCwflLBvXDK1EGU5v4Mmb+EZIbXB5cC+xktImZZ96zsd8LTqg=;25:3I4nAmEbI3di+6LnZcc4uq0Jv2/VOGV8DHJEeV9SuHSMx44XK6NnEQXd0S4F6XyFlNqE4CQGhM4C25JdcQ4nFort3wovoApuby8hrAY8NvDZ+VH+WaJtN6pcKNBIEIm6P/Zkqsd+cCqZpEaJMxeW35CIfXhl0xAPJdtOdgF/l1RaaqdQpcUq1Ml4m1/gYZjHmc8aqQD93PsoeEOTbiWI2YKMaFM9r6fBA/THIaOH1EcCA513NpszG7UwoKb+J++88fILrO/X1J9eOW0Y99Q5dcIsiRaAQDfMyo1HF+MfMa1jNopb7GulE7H3tKbsu9t4YUQ9NtzYETuDGveDRe5Nlg==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5107:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;31:4m0P5FYatRsVO62WHAUdHSy+BqN7qu+E0+58eG2dkQB/e8rTl8ZysLqwR911I/Pzld5Fl8A4zEmn6gp6HRXABZuVTWa6LvuyDfWwKVxmMtIw/4x2umJKKs6+4tTdQorW9h4bbPRiKOEskMaRh559RKuM0frI21YOcNJQrnlkazDWsJGZqBV2O6JSlgo6trJ9EMPZwQxdbwE0NFvTQ34cJ/qei62+XBi1zW0pOssNsSk=;20:pIkw6EdRc2hfZ47zlYRg+5KTNoMuaLNEXyvkD6NJWBAL4E2f2j1fZqSA8pIwdxqmg59k3Rlc0yka8oM59XVbTz8MpwXrNw+3oFfg8wadweQXX3A8lD255PVTMnB1m5/Feq3uBpDua7pKGEjtEzVclZ23xEaOdaBmihhDZsnTug7/gnC1QctJ0YmciKo4yn1vk3sD+pg37GY8csahKroiY2DkdXacVFPJ5AmFe0UHyoazHcwnurubv5rVjv5yTIEwTLKTLEp3oSeIcWvVzW0NGY5Am8kvi7u7I1NRBMSmlXfGVOw4hY1I+VcS9Qc8vmXKGbnrZKwRBIiR+GKXWTuP2nKgW3Vw1jr/X/NtkJ6uWnrsc33yCZI/0dqFDu9uiwsCbDJgO/jJN+ule64OubKM1dy7phaZNL9Yqhln9cE/km5YgvlzWZDLVvdrJ8CIfmZRfCNFwwW30+/BMIkBqj+ghaGYPNJdlFMwpX9yDWwg/M93wdUeeQjW2hE9yxG33R/6
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB5107858FDEF4DDA662FEDCFDC1EA0@BN7PR02MB5107.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:BN7PR02MB5107;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5107;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;4:v7FsM0qcO6XKMM0la3F3olXJTJ/3ghCvBcLtHJ3LcakhF/Na9LtRBb1MovRxjMQR/x0iTFWJG8amZmFCTMO4ipk1MpIwasXp6uGHLwwCHGTKUz8rdKdMbowUcnIzNu80GyzOV7GBLI7yyzb3jFQKYELlq5YKfyB+ETdIfVZu03whGcePiBIcxsJAI9jOXxY4CYj3pgTvxRys4fJa3nIDnSCbubArYRWwMcdhahoPP/xHBIQ0033taBgU2fnnbH9ub/llGv2tfN1bVGwvAI609ABHpTv9fnpUNU6ifKJ/sWOnnzUozBbYv4eI9YVn5JApC/aL/AoX0hdn1WGjcL8qmZSSuBB9I+XxND/K6Q/SVaA=
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5107;23:FMGtlIrSQrCix+B1Cv4oOkHazgzfVH6QwfHfagC4H?=
 =?us-ascii?Q?Jotf4wcI5XPu0hRSs8ZVmhW5CuDrIQXuA+DRDMvQlspIQXkPJ+6zI9YFqk7R?=
 =?us-ascii?Q?Adi6kBbgMRrVYJXRZVLEGw+pAusUCRz5FuRb0KZT2OTeyWzXGs1mnwwuDEIR?=
 =?us-ascii?Q?hnUyqjJTgoFKi+Y19A1QimqFXoyh2D7/EEZg4h4of0IrZTy3hBFdjtlDpNch?=
 =?us-ascii?Q?/QRpsCskNH2WBkzhRHMC7E0UcZ2E9WLskisFItdWGtS9L/zuWgA72K2MvJzE?=
 =?us-ascii?Q?WP03P5t7GcDif/KYSyfA/+wrDphdzA+CKaHyCvDJs9G0FpWSRprKbNHbx2pq?=
 =?us-ascii?Q?KLNwnaPHwAKJ2sBKvGGuYObXCxfskJiOP0bXkGS0pbGhYDNd8JffZCA2isIV?=
 =?us-ascii?Q?PwUR0LDT7z5weHYem1ZUZBWdvDnR0K1aZgWTNClmCIgFkEI5nujOoAKQ1gqp?=
 =?us-ascii?Q?0cJMiEa8ixaMt6iYgrEXy2aD2CzZMmbMaAlexChZu8R1egY3DJje4Pv0WwXo?=
 =?us-ascii?Q?xbkHxiVrgIbk5yLOvrmPpPeQFfg3lvNviU3Q1pBAeiihSjO10cmPRqFrCgtx?=
 =?us-ascii?Q?neU6JC0o3zBmJaS4AtDrP0Nwl1suVhGM3Fw2Xxbbt6dRESc/vkKKQGsPGsZz?=
 =?us-ascii?Q?oLKbwjFV2dgF/nx03N4DKWUxGYetE+mqTqWedno/C0uQEweEGOWbC9PEt8Y9?=
 =?us-ascii?Q?5lh8ANw3uu9BVvpuzBCilPiSRFXNjfIAVueuTfA8o8g0qgUgKRJkblYZ+cz7?=
 =?us-ascii?Q?yaSq+K5bIsDzyxiZRjQcefNObtAuEhrr1d9PikNAMqKeL5SUSk4mI2cIq2fh?=
 =?us-ascii?Q?hSU5twrZ/V8884hTbDCOJOBO8taGJd17lf/Ksmn0i3TMaGRvP8HFmmZjART/?=
 =?us-ascii?Q?cO4fKunBrhBhN7w6TRWgX8J2J5GVaiKHv8Fza618HzznQXx8M83WpMmnaoN+?=
 =?us-ascii?Q?5NmJEHVTlazU8NyPzapHmFOfGp+tSssFXmeWPowvKhGqJAb9n4fYRdeCwNn2?=
 =?us-ascii?Q?1uAbdVku2pBoDTrgP+Lv+LAs5JcLocCLLDkb9RtbVgT5BvXzQSyBX6qW8l4G?=
 =?us-ascii?Q?+tDj8x02VOAg2W0KzmC3GcvcM6F6YaeFaoCtF8tcljH9wzRfoSLsrEySNs5W?=
 =?us-ascii?Q?EkbQvvS20eP62fYPXQqs5sOLUMMxG4U7dSebRH22WoeTVOBpF58TTmpDAvWy?=
 =?us-ascii?Q?TfTiFFpGrWl8iPC3zvabkUlDgtMndI5XFHmYi5r0Z5UzW4ppYYoHhBlPrrde?=
 =?us-ascii?Q?9h3gJCjEPWARQQZPS08tN63x2JNFczQzdBrLKi/eJ/L4FDytekfSHbZ6dSxV?=
 =?us-ascii?Q?GLB+bDdj37Q768hF+d4Agk=3D?=
X-Microsoft-Antispam-Message-Info: pbZux0NKZGwDz61IiPCuQW6N/si9xXfcylH7xsE9RaLodW5GU3AJFfJerfSQJ28pyCusn6yaSkYP2m4OWv3tn9A9FFb2F8sNXTsWAd0o1pX4e5jqFfK//fbcfWo/sYqVy4y/52xKezIYL+vlGDBidsQ4OX0A7B4gZfx+qX9hn/Bbl32PzDpGOutl2WXxLVLqHi28MT+6h2eKVJisVd8ixypySW1aqJ1HTYJwkn/7V2n8TamZU0Bf1ZUA+W/Bym5goUzNOkqimu2a+4fLZ1EtQDNcECvZduFrGxSQqVeEZ/atFYuQPEs3VvYaUvbOCapgSbomAuUaT2eAY+s00ep14NsQ+/q7DcSCNDNQ7HNRdEs=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;6:P3jQEzROc+1hik7+3qpP8j0KhKBkPDzZ3wlhxmgOfvSEdVqSigPipl9AaID3IbxTB3kRNbmZl0pXYJK6lNKyE925/VUvqznbg41oHpMx91VBEK8GwtTilAEmDxU1591057y9ISPeKIJzZFK9Pl+CkRzF5CHZYi9HNxRwCIkg1khHQ+J7D7J7snxaax0sK+B9SvEDMFB9ZGC/gejQ/d720XE89iHhIdWKC1wqiFcYFdX58PXYXgJ8o+vxxv7rJPg2DJ0skzO0Ck62YHXgcy6fTpyYlfFHI5nNYvQcb0RsLhMzsIDHgAutg0eVwf9SbUb9sB5t6x/7bj6OQX7K3gd4eptw1V1wLR2D9rgjuNERLx0MOAXdW30zPrLRRtrV5hJDH5L27gpDMtAyzWjR4ZZ15Cmjbq/PI7t5qbURqCcUlwm5W9DdzV20bCw92Gy9kRX2NUn1KggbnhWiU58xz8bGFw==;5:5s5TErCawYPurbVwtGCo5lgu6Q6s+BBoGLGlIZLdlPjJeNO2hRcaBRn6iZtMj3Bf9m1Lw90jjmoAAFMOOTTGVgfhYzFdnK5S6vLQR8JNdcvZ7ogzEhB4ra3W6kG+V4F7coOntvJo0IgxfXUDcyHAC6Y8Q2WoNqNMXrFiem84qMI=;7:6TnSaxwMkYtUJLkwwGVNY+4F/cZffIx/+XTCUhLIPEPRk4hA8VdtSVjPYULnvBAIw+ZTJHAuXkCGMr7CJE5Zr0SvaDX8lMLm0c2TU3HHHXNizFkFgvKvTOMJR65YDtlA6DpRrUjk8lLYH2ExzDUaDlqfk/Yl11srzP1XOdKV9j+lLLI1nu8aMEuE4KHiA6Jwa1cNs1Hzz8Xzvs1wDBYityQluUUGuS0SGJb13xyMnaTnYTMKflvCL5m8kB9OkDnN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 15:35:51.2361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b892c77a-8a2b-4451-5394-08d62a0f10d6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the driver with some changes for code clean up. Update the debug
messages for EDAC errors reported. Increase the indentation of the
macros for better readability.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 104 +++++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0c9c59e..1936c73 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -26,74 +26,74 @@
 #include "edac_module.h"
 
 /* Number of cs_rows needed per memory controller */
-#define SYNPS_EDAC_NR_CSROWS	1
+#define SYNPS_EDAC_NR_CSROWS		1
 
 /* Number of channels per memory controller */
-#define SYNPS_EDAC_NR_CHANS	1
+#define SYNPS_EDAC_NR_CHANS		1
 
 /* Granularity of reported error in bytes */
-#define SYNPS_EDAC_ERR_GRAIN	1
+#define SYNPS_EDAC_ERR_GRAIN		1
 
-#define SYNPS_EDAC_MSG_SIZE	256
+#define SYNPS_EDAC_MSG_SIZE		256
 
-#define SYNPS_EDAC_MOD_STRING	"synps_edac"
-#define SYNPS_EDAC_MOD_VER	"1"
+#define SYNPS_EDAC_MOD_STRING		"synps_edac"
+#define SYNPS_EDAC_MOD_VER		"1"
 
 /* Synopsys DDR memory controller registers that are relevant to ECC */
-#define CTRL_OFST		0x0
-#define T_ZQ_OFST		0xA4
+#define CTRL_OFST			0x0
+#define T_ZQ_OFST			0xA4
 
 /* ECC control register */
-#define ECC_CTRL_OFST		0xC4
+#define ECC_CTRL_OFST			0xC4
 /* ECC log register */
-#define CE_LOG_OFST		0xC8
+#define CE_LOG_OFST			0xC8
 /* ECC address register */
-#define CE_ADDR_OFST		0xCC
+#define CE_ADDR_OFST			0xCC
 /* ECC data[31:0] register */
-#define CE_DATA_31_0_OFST	0xD0
+#define CE_DATA_31_0_OFST		0xD0
 
 /* Uncorrectable error info registers */
-#define UE_LOG_OFST		0xDC
-#define UE_ADDR_OFST		0xE0
-#define UE_DATA_31_0_OFST	0xE4
+#define UE_LOG_OFST			0xDC
+#define UE_ADDR_OFST			0xE0
+#define UE_DATA_31_0_OFST		0xE4
 
-#define STAT_OFST		0xF0
-#define SCRUB_OFST		0xF4
+#define STAT_OFST			0xF0
+#define SCRUB_OFST			0xF4
 
 /* Control register bit field definitions */
-#define CTRL_BW_MASK		0xC
-#define CTRL_BW_SHIFT		2
+#define CTRL_BW_MASK			0xC
+#define CTRL_BW_SHIFT			2
 
-#define DDRCTL_WDTH_16		1
-#define DDRCTL_WDTH_32		0
+#define DDRCTL_WDTH_16			1
+#define DDRCTL_WDTH_32			0
 
 /* ZQ register bit field definitions */
-#define T_ZQ_DDRMODE_MASK	0x2
+#define T_ZQ_DDRMODE_MASK		0x2
 
 /* ECC control register bit field definitions */
-#define ECC_CTRL_CLR_CE_ERR	0x2
-#define ECC_CTRL_CLR_UE_ERR	0x1
+#define ECC_CTRL_CLR_CE_ERR		0x2
+#define ECC_CTRL_CLR_UE_ERR		0x1
 
 /* ECC correctable/uncorrectable error log register definitions */
-#define LOG_VALID		0x1
-#define CE_LOG_BITPOS_MASK	0xFE
-#define CE_LOG_BITPOS_SHIFT	1
+#define LOG_VALID			0x1
+#define CE_LOG_BITPOS_MASK		0xFE
+#define CE_LOG_BITPOS_SHIFT		1
 
 /* ECC correctable/uncorrectable error address register definitions */
-#define ADDR_COL_MASK		0xFFF
-#define ADDR_ROW_MASK		0xFFFF000
-#define ADDR_ROW_SHIFT		12
-#define ADDR_BANK_MASK		0x70000000
-#define ADDR_BANK_SHIFT		28
+#define ADDR_COL_MASK			0xFFF
+#define ADDR_ROW_MASK			0xFFFF000
+#define ADDR_ROW_SHIFT			12
+#define ADDR_BANK_MASK			0x70000000
+#define ADDR_BANK_SHIFT			28
 
 /* ECC statistic register definitions */
-#define STAT_UECNT_MASK		0xFF
-#define STAT_CECNT_MASK		0xFF00
-#define STAT_CECNT_SHIFT	8
+#define STAT_UECNT_MASK			0xFF
+#define STAT_CECNT_MASK			0xFF00
+#define STAT_CECNT_SHIFT		8
 
 /* ECC scrub register definitions */
-#define SCRUB_MODE_MASK		0x7
-#define SCRUB_MODE_SECDED	0x4
+#define SCRUB_MODE_MASK			0x7
+#define SCRUB_MODE_SECDED		0x4
 
 /**
  * struct ecc_error_info - ECC error log information
@@ -172,7 +172,7 @@ static int synps_edac_geterror_info(void __iomem *base,
 	p->ceinfo.col = regval & ADDR_COL_MASK;
 	p->ceinfo.bank = (regval & ADDR_BANK_MASK) >> ADDR_BANK_SHIFT;
 	p->ceinfo.data = readl(base + CE_DATA_31_0_OFST);
-	edac_dbg(3, "ce bit position: %d data: %d\n", p->ceinfo.bitpos,
+	edac_dbg(3, "CE bit position: %d data: %d\n", p->ceinfo.bitpos,
 		 p->ceinfo.data);
 	clearval = ECC_CTRL_CLR_CE_ERR;
 
@@ -250,7 +250,7 @@ static void synps_edac_check(struct mem_ctl_info *mci)
 	priv->ue_cnt += priv->stat.ue_cnt;
 	synps_edac_handle_error(mci, &priv->stat);
 
-	edac_dbg(3, "Total error count ce %d ue %d\n",
+	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
 }
 
@@ -295,9 +295,9 @@ static enum dev_type synps_edac_get_dtype(const void __iomem *base)
  */
 static bool synps_edac_get_eccstate(void __iomem *base)
 {
+	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
-	bool state = false;
 
 	dt = synps_edac_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
@@ -359,23 +359,23 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
  */
 static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 {
+	struct synps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
-	struct synps_edac_priv *priv = mci->pvt_info;
-	u32 size;
-	int row, j;
+	u32 size, row;
+	int j;
 
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
 		size = synps_edac_get_memsize();
 
 		for (j = 0; j < csi->nr_channels; j++) {
-			dimm            = csi->channels[j]->dimm;
-			dimm->edac_mode = EDAC_FLAG_SECDED;
-			dimm->mtype     = synps_edac_get_mtype(priv->baseaddr);
-			dimm->nr_pages  = (size >> PAGE_SHIFT) / csi->nr_channels;
-			dimm->grain     = SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype     = synps_edac_get_dtype(priv->baseaddr);
+			dimm		= csi->channels[j]->dimm;
+			dimm->edac_mode	= EDAC_FLAG_SECDED;
+			dimm->mtype	= synps_edac_get_mtype(priv->baseaddr);
+			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
+			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
+			dimm->dtype	= synps_edac_get_dtype(priv->baseaddr);
 		}
 	}
 
@@ -434,12 +434,12 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
  */
 static int synps_edac_mc_probe(struct platform_device *pdev)
 {
-	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[2];
 	struct synps_edac_priv *priv;
-	int rc;
-	struct resource *res;
+	struct mem_ctl_info *mci;
 	void __iomem *baseaddr;
+	struct resource *res;
+	int rc;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	baseaddr = devm_ioremap_resource(&pdev->dev, res);
-- 
2.1.1

