Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42D7C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633152073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="C1XQYT/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633152073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeI2EoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:44:18 -0400
Received: from mail-eopbgr730060.outbound.protection.outlook.com ([40.107.73.60]:36800
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726896AbeI2EoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJPK/Fv/6Y2Wo/HsHIWIKsWPfhsni+7rYOSnWVD+Ihw=;
 b=C1XQYT/vJyoZF/7dr6RnDApQWcmLaH7034A7kPjCCmrZU7AuFJlecx32UdfJwtV6CXIxIYXoRHH04wQJP/wBO2yftkz77jgbjeyhL1uChmQ62nzFkzIcLOUkS0s+h7DcLA2zRlon/PwePTUfsq0i0f7t1eCjEt8xY9cXC/2TqZ4=
Received: from MWHPR0201CA0073.namprd02.prod.outlook.com
 (2603:10b6:301:75::14) by DM6PR02MB4761.namprd02.prod.outlook.com
 (2603:10b6:5:18::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.22; Fri, 28 Sep
 2018 22:18:27 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by MWHPR0201CA0073.outlook.office365.com
 (2603:10b6:301:75::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1185.22 via Frontend
 Transport; Fri, 28 Sep 2018 22:18:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Fri, 28 Sep 2018 22:18:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g615d-0008Lf-Cq; Fri, 28 Sep 2018 15:18:25 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g615Y-0005vP-99; Fri, 28 Sep 2018 15:18:20 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8SMIGi0005851;
        Fri, 28 Sep 2018 15:18:16 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g615U-0005ux-D1; Fri, 28 Sep 2018 15:18:16 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v5 2/4] firmware: xilinx: Add zynqmp IOCTL API for device control
Date:   Fri, 28 Sep 2018 15:17:58 -0700
Message-ID: <1538173080-7597-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538173080-7597-1-git-send-email-jollys@xilinx.com>
References: <1538173080-7597-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(2201001)(478600001)(77096007)(26005)(7696005)(36756003)(51416003)(76176011)(9786002)(6666003)(36386004)(8676002)(110136005)(2906002)(72206003)(316002)(217873002)(81156014)(106466001)(305945005)(81166006)(356003)(63266004)(54906003)(5660300001)(47776003)(8936002)(336012)(50226002)(14444005)(476003)(126002)(486006)(50466002)(16586007)(426003)(2616005)(107886003)(446003)(11346002)(4326008)(34290500001)(186003)(106002)(44832011)(48376002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4761;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT057;1:PORqYvJ9Fo4xSTfUp+ZUsOav0ljM8nJqLhzzHfj56aIfuI45YzcmyeGZgBd62lolTFUgY2fCgZYHH1eMlpj5TGAhe1LjJitUfM8tHVkSjibOFMnXh5DHFe/2/r+kQF1R
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 928c50dd-1706-4450-e96a-08d625904fbe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4761;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4761;3:89disNnEuc0sw2awV0se/dpmJ2xDG3h6OIjt0lhhtsxhXoFMMZF5CW+4PEehxHv6lNSQ1hpz06b9saclsHi8tp6J1y+h4xg8TUnumcOJN2TrgxtM5wE+cQ5GGgdEdfHBpZVyl/qyH+uvc9LD0rbqKV3mHCMG7VGNe8QNMItiLTIzmCdGujiPGW8QKl/G2s9esE3G4GyZ4G0ekXmxVHlVUGl4OQB0ISjejAsQkQbllX4KB88SEEZ826XiLck/Y7CCdg4q/DFT7/CeiMiNn6GgFGVY/0atXAO80/bfqPdxhDsr+1uTpJ3eOtFG/7XnDhZ6xNCg8P4y5GnoRrZTExu+I+fCsLTDQfdoJ8sXuiOYATA=;25:NylCaW2Prusv03eAf+Si5SWRTG/dYH+Nm3+kKM5NhK+TrkOToR0r2cpEJUP+t5BfJcRqmn1WRk1OwirICNeVRDlFbEjstyvq7t8OVCwyWQ+2v9nsAGyNSUFJUaQ4R1rXf6/HkjoUD73radZd/momgZ6PokPkMPksWbibbhl3P5Omrh5h4Rrlry6Bgucy+6xzYmkNiSxcvVJGJqtimwSSfgppWtvD1pyTYM0dt9kP1/qK36DA8/cfjIgKdg5JPtdqfvRNEo56KtQ8VEXD82LV7rY6BreC5BkmgGNCSmuzGBTyovTtVb+UDXcRxAKAWfErot3r8F/v38FrC5nyenCXUA==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4761:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4761;31:RxKvW2AHplY5A9y6IznwV/QD06m1lJXS5TTZva1cLja6WRGz8ZGZUUJdTTwscFihtMhBv0sFqDmfCV85ZP7fMSGCMqDQb+Wpyof8BhxnAwdydkR1lNJwWjZNpShwhjWicoJSSBFnwg0IMQhvZLmYoxbSdy/fjeKeEoZPLxL/tWlyLkrnfe0o4+LU25NcwfjErqSR9u48xYtei6Rv2nWH1PFKoV8Sd4ROMzyTiJLAgaw=;20:ONLBTiWM1d4iEQGwi7oqrWncPbAMsQOk8GbbSN5igq9VjJg6jK2hKCKxbBzxDtQ9ezmxnWVA5QlL88lP21cXUTd4MvOhdyeLJlVSsCjXqxxwTYET6+fTc92gwCS3qSkRxxcGU6jPyWCJF34Kt4mkJdZk8LqJR4FVJeUtPrVOXcx1M+lgkoSmvA9GTW3uu3tl8mzVFiP/tS4DWJ/FmYOXPWoEdIP7WDry+04+vhOO7vg/xSngn7yPhbU1E1gLsvM9bV/LLr3Pkxo7hTdnbVGF4Vq/sR/nrVnXcDbA+Mybyudhta+qm/a1mKe00aBEmHouVpmHPZ8rYsc1ZQyJrLO/yNgbifoDQRs9fMgm2pO/GyuklDRPJ+gQP6wOHWhQWODBnccDc7GBVGQX3zy4UGuPXoJfzDymrhZ3IqKquWkUxRliX8T8hgIf0ZF+XeQAMHOUGg2f6c1XpbCDBqfcuqiw8cOGZW8ly4EkwVeMKZiSvafeW47c+2d7LBc3/X4h+Llu
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB47611CA4ECFF6845E84CBC80B8EC0@DM6PR02MB4761.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:DM6PR02MB4761;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4761;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4761;4:mlXF6MOLUNBBQ9i+u6lVDHazsoVBhuTwB1lcwJG5cawbJqG6cpy5OCMsBYxRbZF4CSx718rGwwEvw4xcTTMEFSLTd0bg/MzayUfDvh9zRx3xAEV43OCSik38b52VBPBRrIpA5yP4IzbDTEVmGnps448+8byH7yzUHOVi/30572sphUOglN1Ad+5+5j96D1pQ/SvjYBJ8fMNdPaSihgnDeeIQPN8wvR65SeEGlnj2obxFYhS4gkhl/5V5lNDJFaZpLtIFpACc1GoSOeBGIG93a4z0L8PBvY/XGSI4Sjd8Qnxqb09G8OWlaS/4NFsxWYG9
X-Forefront-PRVS: 0809C12563
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4761;23:yCo2TpblBfKJmd5n8/m4LSnCPhg0G89W5nYrCBk8l?=
 =?us-ascii?Q?IuM/ex1z6HJr0YsIgYFCg62mJ+lqJMi1fX/ptzTfx3EQ1EMZLtUogxUvqlqM?=
 =?us-ascii?Q?oV4EoCHKazyn6hN6ufP4FX7dcxVNYVroSoqUoDkYkwbxpfjAGF7l2kHDbiEK?=
 =?us-ascii?Q?doeowSOpFmJ7XyH0Xz33XWlZtYEbZHiIwPaeIW+q77KU6YrGY24RAUlcrBYC?=
 =?us-ascii?Q?So9KpBomVcmWLVAC1zFjFHH6PrswOMCIix8NGmkVybwg0A482s7dTHexf3w2?=
 =?us-ascii?Q?nxYjYzRbaOjKuiPf4mmqmywq0beyBWLusNCIfmPHL9OeM/2Xr12Rbc9efLRV?=
 =?us-ascii?Q?jYXl/8TTcm30qpIQlgiImQR9wMNSdUvOL3k6D0d6CU5VQv/4C9aaGuE+Voqc?=
 =?us-ascii?Q?P66OqXb5+WsjMGyUx7mH8M3EgYFWINz3pbXUTkvYx6ZWX8un4kVWeVpiCUEa?=
 =?us-ascii?Q?JBTwS4Tvh6tj1f4g1beflUmXvJQeyirMLagofAtvQlt3pblyx9zy3tVxnAi6?=
 =?us-ascii?Q?leUK+F4QR0HORy4hcq2/97EiRuc1X/GHaDwMxoYrnGEV7s/QIUMCM7YLxogC?=
 =?us-ascii?Q?DxBAJ7MJHq2RT2j42UCDbrsZ53dhwE1w8FOY80XHZyLgjollR13pyPN4bPO2?=
 =?us-ascii?Q?LLCBtInImvzLefSTbVDGTD2aK09zaQQeGyYoyKglc+xD0fdw8xXtLF0JWlMr?=
 =?us-ascii?Q?GmDk3mj84HUoSj43McTM7Xr6n8dW6/9xURV2nfXmv9kBb/m9u/2dbRwmkK6K?=
 =?us-ascii?Q?dB8WaXGdJQ0aTRrdgKOUgOjxXbagyE0UboPcEcSwT2Qc0MNyssu8+5yrO1U8?=
 =?us-ascii?Q?doSagjYq1sSzqvNtCiTSo3p4q5HW0+AS3CeVkJRXCWsqTWuGEnNQgZ0R3bKM?=
 =?us-ascii?Q?Fc+ER4E0zobPv4W4J/L35cIVJIQMggSkvp1dgY2Pl8kfGLU2tXo70QDTsPfd?=
 =?us-ascii?Q?2T7/S3SjI/dmKd+1ji8O0aeCsH60GYhdWUw23WhPm/10b7I52j1IAjLwmKEK?=
 =?us-ascii?Q?Qm3XXBst4mO8XRNn3DZyVMEqPxVYrGaxV82BUWV2uCEYGDY5oZYGiHeMK+NL?=
 =?us-ascii?Q?1Tq1+e2KL9E7XbggF7B8vY/5OrS1MGpoPVPiMydPCKAi2IVtVjBHy45wqXzs?=
 =?us-ascii?Q?QE+UH73NMj71IZAtqnVeqWtZaYrxuIitoxkG/u8NWqj0vmZlv/U8bEk9lPBq?=
 =?us-ascii?Q?x1awI8PoAeE5RJXy0U3xpDd4phIkt70gXQ+jrGv2ryw/wVXgAX+H8XkCg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: MI8iPnrmEU8oco8KJDwi57LHIuf8cpbJo1O1ZCVzjUlUxRdSaqrshJKWEsnH9UFWgqSiyLV1u/iWOPfbeG44+HhKlnsRVLjBsFGjJhjVw10+Wqkl7JB3/eW5QFpWImiBl1x0CwpR4l1T4hx7vMXpcPyBaY3zc1uP0kfuSAsDZDhhX7zIUwkM2lqxpb269U6G55s/VqH6XcXb+Is6fQURF4atXRzs99l+sc9BI4FzSLcg6WDjYzYPuLJx+aJ0yj9GDI9Qsc/9poRTOV5jdjbKzVkwBwrLuJi/N+4houenWapKT65qFQIVOm8hgDDh+VD/Nx3tN3fpJTH/x6Njsg0vNVCOriyrs+Z3VLwhjzEuNY4=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4761;6:9i4WW81nJxNOq8kqlN/0n9pkYNcIXxnT9XYruoLLI6d9ma8s73rViGTneuxqRpX6Fcd2PX5+oXCwttPSjmNRLPPghdOoA0mBm1U4P7oXF6IImhXM9t3vBhcSH4iwU8Ty6QIG2k0k/NHgFu5F0vqe7SYALAykiSQLSXZvDL/2P3CtDT10eWqBF/ElLdKKlwayy4he1NtzdM5eT7Sdjni45dtQs/SLYomcIkf12+Cms8wGwgvnl6zBxlYPClE+B1G6Qa8RUXiopTh6vDcI3Owdp9djWIlEfoeUnmM46WaTiTgO61az8Z1a1CSazUCdhZPdYoRH5/VLRyCNsBLaVV2E8FaERtKeun8hNg7lntTBmBxKxZ97SbQf5E1Yz5l2GRDo92x1p3b4NwPkI5sqkx6sTproglEauN7PRssb6Q6dwXUWxmI0vTUV2gLQH5xgMiwaL3oHBvlj2oqiGsccv135CQ==;5:qUN0U4YDxCEXqqrM3YCpUQwIgSoIoMQJ9EeBbptGhLg0a4pcjp0e0ygV7ZKHo+UWAQjBcy6OQu/mfM4sxEY7NlvlIrpY+QCxLoHqyVfQJ5XJ3T4u3TqfOuIEtg21bOq8uJx2aOHQL3No0rhR9j7/9AIyYjplo3vc7tCiw4pfSTQ=;7:BV6QbES3/0EH3IbtM7FrUarS2bKpPfqWzunaD4BjQCzA5FL+2e3ea79b5ED5Sn60w1BVnai8/3i6qjvMx205LMJMw3XjBwZd7/3FgoD5MVlV9HdSz/hafV5Lg91TcWPidLeGDD45JDdwUagsXOOUW6umTVBVILS59b0Ye5p6xgqtkm36ADlQf4U0LJato7K73bzV4UdQuj8J8lVxUsysiTWYTa+hmNoKDJ862O9RN4mb64U0X+b52A3j+pJAAZOg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 22:18:26.0433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 928c50dd-1706-4450-e96a-08d625904fbe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4761
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add ZynqMP firmware IOCTL API to control and configure
devices like PLLs, SD, Gem, etc.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 drivers/firmware/xilinx/zynqmp.c     | 42 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  4 +++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 84b3fd2..9a1c72a 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -428,6 +428,47 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_is_valid_ioctl() - Check whether IOCTL ID is valid or not
+ * @ioctl_id:	IOCTL ID
+ *
+ * Return: 1 if IOCTL is valid else 0
+ */
+static inline int zynqmp_is_valid_ioctl(u32 ioctl_id)
+{
+	switch (ioctl_id) {
+	case IOCTL_SET_PLL_FRAC_MODE:
+	case IOCTL_GET_PLL_FRAC_MODE:
+	case IOCTL_SET_PLL_FRAC_DATA:
+	case IOCTL_GET_PLL_FRAC_DATA:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+/**
+ * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
+ * @node_id:	Node ID of the device
+ * @ioctl_id:	ID of the requested IOCTL
+ * @arg1:	Argument 1 to requested IOCTL call
+ * @arg2:	Argument 2 to requested IOCTL call
+ * @out:	Returned output value
+ *
+ * This function calls IOCTL to firmware for device control and configuration.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
+			   u32 *out)
+{
+	if (!zynqmp_is_valid_ioctl(ioctl_id))
+		return -EINVAL;
+
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id,
+				   arg1, arg2, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -440,6 +481,7 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.ioctl = zynqmp_pm_ioctl,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 015e130..7a9db08 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,7 +34,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
-	PM_QUERY_DATA = 35,
+	PM_IOCTL = 34,
+	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
 	PM_CLOCK_DISABLE,
 	PM_CLOCK_GETSTATE,
@@ -99,6 +100,7 @@ struct zynqmp_eemi_ops {
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

