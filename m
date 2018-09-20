Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1A4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751DB21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="U8GDjuTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751DB21525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbeITPQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:16:26 -0400
Received: from mail-sn1nam02on0043.outbound.protection.outlook.com ([104.47.36.43]:32935
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731684AbeITPQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQvn3nUObNc8y3ZHQrilJ0mTeJLdj8v2UDvNxDzdWo4=;
 b=U8GDjuTAXviASTRco6emyzmnjlu7/VCsk6DtSt0c4Ty/Uyl8cOnKJageFfsKt2pLQBDIViwKN9izZH0GserV8V1iDcu9dJhPr+VpyZtwJZW5+7/CEwK1uRyeylYPpYrCcw2QYef2l0vMYl3pEVNk3gMGY0+uXfA8O18TcG/VhqE=
Received: from BL0PR02CA0081.namprd02.prod.outlook.com (2603:10b6:208:51::22)
 by BYAPR02MB4760.namprd02.prod.outlook.com (2603:10b6:a03:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Thu, 20 Sep
 2018 09:31:09 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BL0PR02CA0081.outlook.office365.com
 (2603:10b6:208:51::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.17 via Frontend
 Transport; Thu, 20 Sep 2018 09:31:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Thu, 20 Sep 2018 09:31:08 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58110 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2vIh-0002Zb-Mf; Thu, 20 Sep 2018 02:31:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2vIb-0007fV-VS; Thu, 20 Sep 2018 02:31:02 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8K9Ur1f012993;
        Thu, 20 Sep 2018 02:30:54 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g2vIT-0007ai-Lw; Thu, 20 Sep 2018 02:30:53 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id CC48512167E; Thu, 20 Sep 2018 15:00:52 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <adrian.hunter@intel.com>, <manish.narani@xilinx.com>,
        <amit.kucheria@linaro.org>, <sudeep.holla@arm.com>,
        <leoyang.li@nxp.com>, <jollys@xilinx.com>, <rajanv@xilinx.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH v2 0/4] Add support for SD Tap Delay setting for ZynqMP
Date:   Thu, 20 Sep 2018 15:00:41 +0530
Message-ID: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39850400004)(136003)(346002)(376002)(2980300002)(438002)(199004)(189003)(186003)(8936002)(106002)(5660300001)(103686004)(6306002)(14444005)(2201001)(50466002)(6666003)(26005)(51416003)(63266004)(47776003)(52956003)(16586007)(90966002)(217873002)(54906003)(316002)(110136005)(7416002)(42186006)(6636002)(2616005)(50226002)(966005)(476003)(305945005)(4326008)(336012)(8676002)(2906002)(72206003)(44832011)(126002)(36386004)(48376002)(81166006)(6266002)(426003)(106466001)(486006)(356003)(81156014)(478600001)(36756003)(107986001)(921003)(83996005)(5001870100001)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4760;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT047;1:e3s9p9Ly3JFrcfJmd+0OpfIXhqMC1FYRbnFHfD0bZwIZZa7lrgXREZBbmsPE4INDoKVuTC5Wpn9sfUN01YIE3m5A12bZqWqGN/g5Dw0eIpWENrjnyTWBzARqlmHhD4NK
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbe00de0-e3df-4922-8754-08d61edbcbd3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4760;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;3:AecIyw3rFvkppaweYfWTh/xKPzLjJ4N13Z48fJlcb2vp/SAynZXxHwCq1U6S/ANzXifTQlqy4TH23Q/UwxFZ7eNQzayms8N9+1Kt5ykqwy2KCjlLnYlct4jBZULSMmllIiRCWPx63CBdiPEiSnnXs8+r3aOlQx8P2GpHMLaGp9XiFQS5IUWOMcX3Png2IUc5JMWmsXHIsWUY4O1AbVyVSIKDypJ0HTMQOYF7KFzNajWgS3cA8/vd/c4XhDJcoj/7qTNfNjNUFzv8ZusHYvWjTCgNWfZmjwPpFLiBZKbLBp8MQ6u9EShjL7zqTV481qBgkRPkzGjaVfQNMoRVClP4iQyJ5vy338OQllaOJlc7eCM=;25:LjPYi9ZtqOqQLHjKjG9aodcbOJJk3mKCJfDFHjeKYrfd8+lrpUBE+2B7mRTjRj5BBeSq5JLaE2oGJEcUDw/uswiGBeno3mIpUWizrgacUhV4EXwyo9EZChXGcDCANLFGfhnV2QojMT/QrDnlQJuTcD/U6sbBM6pnGAD+73zYNbYJU5+DeOUCiHduLbuw4XzDFBgdMsBLWV5y0mlJEFjQNTFPyysdsne3vY3jWnv9OkXrR9iBNdVc4Gy7sjZHJvBRvRgLM8KDMx3sfjVVUDo/MVC9zfVn511m2p2iuzeKDtfSeQpGssVxoKQ0nD97C/Deeqyz0ATdn5c17BF9xlngIQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4760:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;31:tBrtNonM8ToqJ/tIwSlzwKXSMVtjQ9HxGz5UKWLK7S8pGxV4lhC/S8yt1NyS3Lw2ejQBtrRXxUSt5DxF36qsnR7lLiQmtPXU7xGIQJVjBzTAAXKvLCFQm8jp6MSGk0Xn9mNRfJFNvUuAlf014anG7k+FLGYyJ9V0/vojy65+KjqGZfsgtRohADQQbJZd8zi4SjgGMPX1RZcRNh3lmlS/AMzsS5veD3ReNxSW9a5z1Oc=;20:wdmwu8qSBkrlO46l0yPpXGQfWWR1Yl73Lx7751CXIqgPzrPrvyO6aSOGUry2ScbtijkSOwSTi61TqtxJ7d1RPcWguvboimJmnCBwY+dgTvmdTYIB2ESPhwFWgkb4pTaLepihl3tLibjdWy75BLOFAXHAGqgdFZ3VA51nZwhRlfEGfXIM4/+Zu3NGZnCNtzFULUVRAzlxc0Aq5Co6QO0i3Mgyzf6xNjQAgZBelZhievkwpp6WDnkV3R/tnK3i4gayc/BaPirra3CokG6VF784CzWN/Ju4+ljoc98/wZJFOvvb05qQmIN1qt8CRj7oEWfgt+6vBsNfryS8PAL2tHzkY+drwvL/dw/k/cYPds/L/k8LGDgcHE+46gSXBHiuS+K8zPQlDROAwuP+kM6f76QVk0Wt6UHdAGvg0leFDnQg3XVpkafqz/ynIEqBTP8YCslTmbPR4Uy5DZ7bKYyfeWeqXYUf06A0VMd5WjCXb4AlCUL7WQJWGfi0sYV/lE/KuVV8
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4760235AE9530E943D8F1903C1130@BYAPR02MB4760.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:BYAPR02MB4760;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4760;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;4:Jx3KU5mHOcKCLP8kX4iuf2vkOACnmIvAMLKpAwwnAKgSqQHyQ6jQHklVYn+KZKRWhIxJQQkg9cL7qc3KpCuKSwzqBpIkiBgOmqOlAPzd71GwdBlzwwFHtnf7xkLrjS4EOO4paY9hHaMM3DApgyKhLLAYdxfzcMuI1p6TejIYevge8f6SCBzAEC8J8nBkNy/Xy7k0WOMf7NgtFybV9I8VIiWEehXxM3WdupswE+je63wzKTPUKZ/RZsl6HFixHATFviAG488m1IenD0r3qaHZiQ==
X-Forefront-PRVS: 0801F2E62B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4760;23:MJKnObDE/8zdoLmSZ7LGUSmXmi8C/LJZT8uLSmeMD?=
 =?us-ascii?Q?mP8vjlJpjjhDW6WQp9DRPSlx8xlqKQj81ZWUnYKdVrdfROY9uz2ficd8YO6P?=
 =?us-ascii?Q?Cr+frBHNUYD/jXjEEqTC2wlgSqMakQ718lMQvzeQzEzRsdlSpHi6QIdWA9Gj?=
 =?us-ascii?Q?yAqJChsstxj5oB+Wi54tD6jrVQeeG2PQARYUumzQjcgvcL1GjNOq+FjAcUlX?=
 =?us-ascii?Q?iOZrSLb4YCGuUpADHncGB3nkse4ULK9O1yLoYYnWKrAHYS6e+mqHmA+QY4dL?=
 =?us-ascii?Q?Yo6cohYMA9BIYpdmgsuonkuLLbq7DdIsNdzbEH/MtfmitccBZCVnBxc88xPB?=
 =?us-ascii?Q?f6EQsdMJg4WoMDxg7roXRfxDFxUeCMRUjMhEvfigGcCkZ0sqI5lSmeos3M4L?=
 =?us-ascii?Q?GrPQ9F4kK0HU4GgfTxHIfBrTVUrAfFNjYKpNFs7Iy0huOQkZ9Oj5T95qOmAb?=
 =?us-ascii?Q?0XrpCojM2IC0GsvVzUjcQGZ2D+CelVavE+0qlRmWidJDXa5xnaB6F4FGl6J6?=
 =?us-ascii?Q?NT6cFs3rPKot1uQKIjDn7ReJ1j8PG0Wg21vECX/WL41LRpDPq2shOKtuFu/z?=
 =?us-ascii?Q?dydnlQDhZLECAyMP+o9k0yiUw6J3MmBy/MIpywcR9P9P6tv1HCiGIwuFvQUR?=
 =?us-ascii?Q?GS4h5NpiZC5+g8khYWGMi8lo+BZwkdnBn3DMIDJRAu7Tvl/aZ8Fm59hR9tGN?=
 =?us-ascii?Q?aOYgRHWbwjn3gLKAJ3CiFUerPYXw26X+5kquT0MyFodQ4tGtYyf0VZDNIYSG?=
 =?us-ascii?Q?2zyjMo7Di+3YrQzdLxNDpC04JTDb1zB3zW1tlq23ikuehSgww8PkDmVYqaW3?=
 =?us-ascii?Q?cEeyKUhXTEiA425/oexLnf03829U3aiR2ImLSYhrSCLI/CH+PLrigioIQUKs?=
 =?us-ascii?Q?fUy/WxbWESJPHEe7d8bKUOneacMhxqDg5f8RFDpxu9Jx/7A1PvIoOyPh9Oh7?=
 =?us-ascii?Q?BJz8TiD3sh0aB3GM8SzdwdYRmcZXuLOLtbT9VhoG3A6LeDo/IOGnXt5B6iD8?=
 =?us-ascii?Q?2yuxH5zpQkfCEi1rkI6RZ3ZdD27fqZwgVyrO0x7FcyvktwO2nkzGA76ltwXM?=
 =?us-ascii?Q?Dis74GkTFaR2pG6kG/yQ4HpN45lCX8ZIXHk6QXyNariXPlZ3mr7WmlsxCSh0?=
 =?us-ascii?Q?pwvbT8DBI2r7O1zZeq7ERIsqlfkQuo6EUix0PHNMMVz47TgUE9eH9WQeuQnf?=
 =?us-ascii?Q?s5fHlbked+brbItA3+g+fH5zjeTxMXUz+Rlf8BQWQkKgjGQTkrwYQ5McPptU?=
 =?us-ascii?Q?7NNb9AA33SPs2OdOJIuxJjass0ObV2uzEvmv3DUfWnj/eUYiBrJGWuiMoIcp?=
 =?us-ascii?Q?NyI///rUXDbgsQDl3/bZ0nYfrbg+GoYufibPd1DUNvZhGx4ygEpsv6TDM17L?=
 =?us-ascii?Q?FcZqw=3D=3D?=
X-Microsoft-Antispam-Message-Info: PI7eXyCmotrflIL9PC6ZgtOhTL+9YSzL7MvtKSjt0MUe6b13CZwdk13CzRUKkXFznaMdTkhyE30bZptqD7HsPruqSm0vpN1jNaTXTTUOuVnUUQOElvp7YfAYQRCgRqIqV4PaqF6kqFwqdJlPmwMzMAEFCJl03TBkyPMs/zLL/Z/ojVg98NyC5Igh9gXqlYbfFFLURF4GP42bVPRbqbr6cvbv/WfZn6WIgIC5QkvL0gCwaEl+MZm6YRKyS0XNnxWHf9JiNjp1KtjPNKOO0Fiw5rqoWuy24F3FiQqMiA8oA4D/WjRMtIyvcYEeQhBWZ7JSO5lmHiqnB2+U+AZ1VhGjEdPvO42YZdXp40DNb4jjHjc=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;6:BBKjXQJiUF9jWbnbkJzhBbkNVPyr3My8gtP0GJxGAFHWeLVNvUEo7VE08VR+1M7V9inAeR7zjwazoEJGiIJyzbZNMKR+Zp0dAspQLe9/mzijkP6RBMUTM5tLlFhwCHAuV6y7FgzTDpjbaIaQa0Og7SzlctbURMRpgYxAuU6XcouGbI0F/KBN//+csoqoNLT/5CfwkTsS/kYjZXWdsRU7f/qY4GfTVTGbsQc6gRO9A6Wt5CGVAjb4hPaXKJiOq2OiHdC316+oO0U+QqLqvWsqMRMfGKgxHBE+8RPzFEDnYkYvwN/zKWvZDpvdhioc8Ie1vZEj1CqxOzfYemqwBIsyvSQ0UyvwCR3JjwB54LoUDnjebMDAKgquvTnIAd2hlb0bevlZwGo4/h2+1K/pd1pBKdCLWHhQZRjXKuUjps7N3oZMBxNGwyXfcOPlqaXvzKIsBlXpotaYnOaDbFC35oQ6Dg==;5:0Fk7BJypDTPSjtH+1S6jwzukgW/AwdFquw3Vz6E/BW+6jWqNOb3Aoqq6ajAtHZz3rWKZzOJVdNStBraMUsiOtla/1aUseDSfitrCYMX730Egj/7YH+87Lwb/yAH93oXNXWNbmzZR6D0xFPHqBvEQcwFYYW9Xt/sHTbQEkvg88n8=;7:/c5iFN6gq6OS308koC8IjYD9P6HP9T6AWEphQDeSx4zx+NOsMjAPQ8hMK3NwZIbYg6cL5ymwAqUaGU9OwOEbsuYz82qKNXbmmPs8/QEsRGSjFDrCHVR1ORRbaJt09QVqp76vk/cvqvkwS8xLJTqCzVdEAreCOXuR6nrcGtG3oXiusd/mVH40l3+dOtF9rQY61Dx/l3dOA7vXIbmNOh3u35GhNbjCsw3Vwtv41PF6bha+2Bbu8QDdnT0LEfFSDNVP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 09:31:08.3937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe00de0-e3df-4922-8754-08d61edbcbd3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are created On top of the
below series of patches.
1. https://lkml.org/lkml/2018/8/3/687 
2. https://lkml.org/lkml/2018/9/18/1034

As the ZynqMP Firmware Driver is not yet merged, sending RFC to make
modifications before sending the final patches.

Changes in v2:
- s/_/-/ in the property name
- Changed order of the patches : DT binding change -> driver change -> DT change

Manish Narani (4):
  dt: bindings: Add SD tap value properties details for
    'xlnx,zynqmp-8.9a'
  firmware: xilinx: Add macros and API for SD tap delays
  sdhci: arasan: Add support to read and set tap delays from DT for
    ZynqMP
  arm64: zynqmp: Add 'xlnx,mio-bank' property in SDHCI node

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  19 ++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   2 +
 drivers/firmware/xilinx/Makefile                   |   1 +
 drivers/firmware/xilinx/zynqmp-tap-delays.c        |  39 ++++
 drivers/mmc/host/sdhci-of-arasan.c                 | 215 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  33 +++-
 6 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/xilinx/zynqmp-tap-delays.c

-- 
2.1.1

