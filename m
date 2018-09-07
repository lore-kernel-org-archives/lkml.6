Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2879C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3C82083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WOd83gQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3C82083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbeIGRzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:55:22 -0400
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:55808
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728906AbeIGRzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VivjJ8eR/tMk5x1HOhKpeEGXvTa9y0P/UaFqCcVCyM=;
 b=WOd83gQinFE0XwvFakw6ialzefXS4rXYiGy0pMmx9TA84MXfHq5Ooocx0tc5lSJ0nSczO9wzCibvcBvffG+7s7365VqzFS8LiIfDrmsGqncBRLKFlSBK/j7afyOIMhUOEBTSpX4wLttdp+7raCnvb3KGBflNP2xnear3EEu+HZw=
Received: from BL0PR02CA0106.namprd02.prod.outlook.com (2603:10b6:208:51::47)
 by BYAPR02MB4934.namprd02.prod.outlook.com (2603:10b6:a03:47::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.15; Fri, 7 Sep
 2018 13:14:23 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BL0PR02CA0106.outlook.office365.com
 (2603:10b6:208:51::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.15 via Frontend
 Transport; Fri, 7 Sep 2018 13:14:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Fri, 7 Sep 2018 13:14:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaZ-0000KU-Oi; Fri, 07 Sep 2018 06:14:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaU-0005mb-Kk; Fri, 07 Sep 2018 06:14:14 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w87DE7Mm019328;
        Fri, 7 Sep 2018 06:14:07 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyGaN-0005lV-3L; Fri, 07 Sep 2018 06:14:07 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id BA39460508; Fri,  7 Sep 2018 18:44:06 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v3 6/8] usb: dwc3: check for requests in started list for stream capable endpoints
Date:   Fri, 7 Sep 2018 18:43:47 +0530
Message-ID: <1536326029-16327-7-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(2980300002)(438002)(199004)(189003)(51416003)(110136005)(90966002)(54906003)(97736004)(316002)(76176011)(42186006)(16586007)(5660300001)(106002)(53936002)(8676002)(356003)(47776003)(63266004)(478600001)(106466001)(39060400002)(6266002)(36386004)(186003)(446003)(50226002)(8936002)(11346002)(2616005)(476003)(126002)(426003)(81166006)(81156014)(336012)(305945005)(48376002)(50466002)(486006)(6666003)(14444005)(4326008)(107886003)(26005)(103686004)(36756003)(2906002)(52956003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4934;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT043;1:kQAUhAZ12Z4lgl4uBP/qG8VD1uVVIkSPV30LGBtQQ6PNvIa3In+KOaF3z6Vhh33WZaLjVnn5OZQFvA0Q6T2os4rkWbhp802zb6fSQTcjojC3GMbtb9xKUk5eOKvJZH06
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62851096-91ce-4032-19be-08d614c3d2b8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4934;3:vZTH/CEzdAYYqNEB84cZcfXJkKA3a05o5FWE/mJS9XZUo1U7CcfNyM+5VY1BSOGdw6oy1FBd88j6q+cNzL8Qc37kzXGe5znkw5VMR3CQHfZ84+cnxK8C3RRVxE6gHFuvw3uynu5Sqq6EY891OGqrUV2g9ACcWvoNzmsD/jh//kWI/y0HSCrQCFSUXxstf41of8rRrXCiMlEzQVQqhtvBYp9tVQDQDKvgWxudyq+XWVTIfYyAshYOgZzhOATGGxo1pzEeV7CQ2ACzSS+YbZouvkOPVLYs62lbD7U3BunsKPRslOEOZZuNa5daMdKeXlkoUtw3FdMJBqdguSqYN/myRThWofwq2wf6sTRwjMdA87A=;25:hX1jGTjRNLUiRmP1k69Ac31mf123cY6HoWNacNdVBziaOfWCgebp7dBb7uwgf9H065glx+6a2p0JZDpMcYARmjkKR9LGL1iotLvLhlWwivNUqOXxdgGVdpD7btUsPMeezo2SKssd082K+cfhZcYhLUHs4id1YYg77Bv/dLj879e0v6lWdLX/TN5i4OfGVFQlTIm5LeTHCeU47bt0weSX+IbM9MIwi1VswiXFd2ew2QtCNOi4zm9HFnOm4bgyzSLAQRgD8m58I1vvhbQr+vL4tIicpiRq/JhxmaRxl1Xbl0n7ClIxar2gaZpjiTA4YGgqVQiq3AW1QwbL3IT0j7Vn8A==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4934;31:Y02qbQBnzepyixvjDaNSkNsw5nRNDu3mT1aXjMZJoG+PTLY9SYqAQX4zKVpsug9WWaWoKZeczAxZayUk38cG6BjHLgOJLTle2661BBlJNlnTH2fVQhdCS8tgNToB8K3PNr6JKmo5MirXCNLxR7Rj2yg+53kJBmhCBJ0sPfsDQFZY39lL7VvBKKj9mciaH/kYT8RXODjf/MQT3xtVvA0EzF4zo41bQu1bL7Wj5shO2Ok=;20:qrSSrnN00ySesxGUd9ZJqfMXLzWS+SUn8VvaD1E+vSNvHkEwFX0sCfqgH52duV7Pcd4+9zcnsHvWZCBVD8nkHb8a3vF1Jg9PpXegkOjniM6L1lnRgXU502q1DvXLfLmnYnteh078Uo/cI6zv77ffICvC40ZmXW00yt/YfuHIQggSQnUngb9uw2pT9ubM/WvnlHm0KL0ojPSTdygrUtkugWWleN2DX6EYyt+lHwO2oZKRpNKw4uvpGhoPcGcO9jyjJpUAfGzaz1quLl+v4poTZzjasITKxf/R8KMG+SvYtcDO6YfQzepFahNHEIn1PTa479Z3Ay9reUfbfl4woUh15jeK5cqVYBkuCxOknHC7yFTaUZWEMKJTi0W12CJdbY2SQyWwRqo15D/eGOE/OotvbVtF4v2tmShIsQHhH/N1Ca3CcHEfluDPblcE/tRJpsKx50zFFNY35wLz1jjZmYJD9wnghzQ2unZAt7mW42g/LponPKrPxJj4EO2fjichYvwm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4934034EE7CCF13535DBB6F7A7000@BYAPR02MB4934.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR02MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4934;4:qs84AsEzwyAwsbfJtr9MU6exZfRITwgf05+DnL+HS4T9bWDMx53AIU+efVSRtDnvHSuMhu6MU9ieMNUnn/VCZw47DqUwgFSpsJVy+6miiFKVPnCdEhuZX+lBbPZ40F8FcU9tBbsBXvzbrUiMT3m5HE6c1/l3AQhPrJ3BGTxNv91RCtkK4ck5XnXuYVLey6Rn5XxrXQv3OZw80B0S0GFUCyu1+eWpGg+ijqN3BeveohiQhTltOLHWJoyCkIVAzM8gqXupR00D3uhNAJuUS+5Vh/cpG3QC3FaZk1lUxvSJL0ZDMsg6E53AErYH73mTz7PP
X-Forefront-PRVS: 07880C4932
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4934;23:8Awvga6eZOeRLUawFHYHwRy0MK37Kgl091KvsMzgj?=
 =?us-ascii?Q?W9pEB8TApqkK+uuzvTzdNddR6NBaUFsHha8LHaKI/uMn6Rugql40s53PoUtK?=
 =?us-ascii?Q?Z4pd5RDEVFrxs7UQ9PsYkhBgwSwcbUUNkOHwyQsW8lXAvdmwmCalDEf8XyIB?=
 =?us-ascii?Q?r19gEyS81YNaI8SmzaZyOvcubK72aO8mG9J7qXjf8ShJg9huODBL+2C98FwL?=
 =?us-ascii?Q?L/pCO+DyImg03tC+hGvWV4UAvMfXUAPORMb4B6nCkCYzW3aViMZ3c0Eidxxi?=
 =?us-ascii?Q?qOlo7y19Rqf72TWhVRl2IvZUFDGjRQKdZwUSzCcsQXoSWI3F+p22fx9GgmsM?=
 =?us-ascii?Q?mshZcsa0FIsnukItwqU2Z0ekHhMiHzUSUtktzigigiXBPFP8z3BKHN6gOPlo?=
 =?us-ascii?Q?ESM9Ggr5hqZgzUqAcJnpjSt724JQHtzcBGnHs5oRZeJhJn6duN4SMcGi+7NG?=
 =?us-ascii?Q?KJM8IvdWfL+Y41jxfovrdCDDrNT08pYx4hwV65Vx1amT46LUORwK59hvybHR?=
 =?us-ascii?Q?56hL4HaYEt8ocqCWZxh0Z3OPm8mMdgVwsH3YoZbwUhyuWBGzDpcEXFrl/CuS?=
 =?us-ascii?Q?+/dZOfuDsS3BWPGfuIhUkxADhnvPbwWNo0C3SA7ZK3X7vLbYX4/iTtfLberF?=
 =?us-ascii?Q?DlRpUavzlva2HTQRVUpcRZkdMcvSbui+rkt3gtoRQOdnOyYDkzsPKVpurot6?=
 =?us-ascii?Q?7gAd8cc9m+XiC47bkIbgT9pQvD0SyTo+O5K+9JOUjtOFotJ5XNd6cDZfaWfd?=
 =?us-ascii?Q?bO9h8RqpA4/4hqvLXTDEyJJSL+mYYBvSFaZeevcg00whWyyFjHB4igZFK35E?=
 =?us-ascii?Q?KcVQ8E+YT6AYBVRaClvCEXGHceihKwSveGFQSDNNt1GIRDHBJaAQnx7sIOP0?=
 =?us-ascii?Q?oNI7bMIdvoWF9NiBJ390dlaFRw8QBoYMVkcxfMV8gCDhT119GEMpFM1JbG+E?=
 =?us-ascii?Q?65//PvO+1dVWf6vMd0fMgFMurWI6gvdLQXOwCc4c7wGMXiAUbfRZticj5HUm?=
 =?us-ascii?Q?sS9RSmVIHzGiGqrGncDNv5lDZc97wGdFb/KZuAVxm2gwKxIhud6lJIsu4UBk?=
 =?us-ascii?Q?yoRy5Z2MG0Azo2+zC2+aroROvlq/SKWW4wtliMADxCYq3aijSt09jP6dJGYW?=
 =?us-ascii?Q?Jof29ymrbHlbQ400OPa+AHNTDyA/DlsQuIhML1hmUeVbqxCEPVoksPGb0jwk?=
 =?us-ascii?Q?CfpOWEx6/fvHLv9VNhyc6IDirYnIE7KTg5VX7ukemNHeLrYL6mCmX7RKTIMC?=
 =?us-ascii?Q?70Mqf+MUEjSFm8FUpE=3D?=
X-Microsoft-Antispam-Message-Info: MJ0UNcqzIHsE24pQXRDFR7whCSB0an6ZPbSEDn1b62+Cr61iVNXM8oUBmxGDgimovDuaccr2OAgAXDJEoFCB9qPRVAwEpPoxmQzdg/hvsWKtBFP5/MwvG0xiwIbdGkgJLzUG6r3u+O+WpWo1gC/j4a2e1gdXCIdWu+o8WS5eO6+gQkL5TLJ3mIynUeEWeY8PmU6e4LDw9m4MgI5viQDeKmADN57+gJUxzlkEb7gQROsnFQMUfzpk1/uH1dOCeo1t49s4K7MvAImm8Z5YQZvyk8rfTs8iNDi7m8wq4Gmdb6D5K9TAvjnhOmnhQAgKHrOPVCESAom0kxZWxCGdzdn4Bk4dpQhx/ISZxEOdEFbJehw=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4934;6:THOfcgtDUGrhdGlUHyepp5r/HrIRS6zjLU6zc0C0cD5KgLtbMh/8qLM/ow0Mc+caKhqBgCOnCblS+sIwDKuEpBQxHOiVWgPli/fNz1Wi65RVEc1GTJo8YSvHbNirChSZMH6pzKT3yNVJLxEwMtji3AiMLu7LWKrq9+PxcLduSg7QErOrMpAem6GcMXK1EBt4CuJV6Fl8KEDgyat7Mzd1D6U7AUbortYDzQI4zqZ9QJ+9gUWOb1oYo6Ym51jlCmPwRjV18PxM1TqCpoXtK1MDDvCPUS5ZWIRAuIgR958ceexlMLlxjjFLrCtRExkuVVpHvMenSQJfUNUoRu9X4VaPOf9+sCDGFw8HDQnDYrhOzEm4s68tf3e7qm48YYiRUkojIl7Gd+UUTdX2hJQ6hr66VDA+AJE79srm9gSjtzZcQfs3YW9v0iJdANaEKz29fu9FC8DbZKcemC7/UNhVrho1UQ==;5:Ti3hQhSy1AWNx1sDi/pBD/k1SFUtMrkIsI9QQu/vvIAemEvIwpKWcJcd5ADJwYYwAv4h41TBiAnmT6T1F0Q2moVB+YFjRfuDOOgnXPY2b6qmUVR1exiHka/hyaSxkls3WWVuoi2Q6v/ZlJag4qk59rlScMzfZBi/PVjZz+hQrLk=;7:piZ5wvqUNC2JDsYgG5yuGOwRnOGJQI7Utl55lzyODUWYQDTBffI0NF+37V0rrp18d17UTQOsEw3obQfDYfP7woN6GGPQZ6Rivb2gA5R0gZDrp7nsJNnc7+prwqOgRqh/M0OWmddLODK3OryOgQplMvLX7kqMhROSHAg38wlX4pCJ3MBjHoBRdmXVydC5T8Jeb5OoOU/OSi3zhyenNUgGZNTyfLXoTkhdhqleVhJcDpLO6Ir11yhF1H47Pnww93pZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 13:14:20.2212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62851096-91ce-4032-19be-08d614c3d2b8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For stream capable endpoints, uas layer can queue mulpile requests on
single ep with different stream ids. So, there can be multiple pending
requests waiting to be transferred. This patch changes the code to check
for any pending requests waiting to be transferred on ep started_list and
calls __dwc3_gadget_kick_transfer() if any.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 6936adf..e9901cc 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2424,6 +2424,9 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
+	if (dep->stream_capable && !list_empty(&dep->started_list))
+		__dwc3_gadget_kick_transfer(dep);
+
 	if (stop) {
 		dwc3_stop_active_transfer(dep, true);
 		dep->flags = DWC3_EP_ENABLED;
-- 
2.1.1

