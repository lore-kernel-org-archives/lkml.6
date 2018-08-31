Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6945CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027D92077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CiZZ+4XN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027D92077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeHaRgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:36:01 -0400
Received: from mail-eopbgr690063.outbound.protection.outlook.com ([40.107.69.63]:26304
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727430AbeHaRgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V84MF55PtXhOkC0A83NumKLPDJDHdyFG2pR6YJKmQfc=;
 b=CiZZ+4XNKk53DgRbMl9HkUgkpDoZ45d9pnC7ZlD1KMo058SG+VJu9hgGpZIgrK0pdy5T4H7j+xC1PD7JOq8pLWKLt+T7+grnAEkfTBnPxCJSm1pKvyVHwMqcAZ1AssLfHg7iq/t2k5TY+2kccQosrqGi1xBws1BS/YaAGwA+8Yo=
Received: from SN4PR0201CA0014.namprd02.prod.outlook.com
 (2603:10b6:803:2b::24) by MWHSPR00MB190.namprd02.prod.outlook.com
 (2603:10b6:300:28::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Fri, 31 Aug
 2018 13:28:24 +0000
Received: from CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by SN4PR0201CA0014.outlook.office365.com
 (2603:10b6:803:2b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.14 via Frontend
 Transport; Fri, 31 Aug 2018 13:28:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT018.mail.protection.outlook.com (10.152.75.183) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Fri, 31 Aug 2018 13:28:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53332 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvjTL-000408-1r; Fri, 31 Aug 2018 06:28:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvjTF-0000Ak-UA; Fri, 31 Aug 2018 06:28:17 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7VDS9Tb024494;
        Fri, 31 Aug 2018 06:28:09 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fvjT6-00008t-Rc; Fri, 31 Aug 2018 06:28:09 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 0903C121174; Fri, 31 Aug 2018 18:58:08 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <leoyang.li@nxp.com>,
        <amit.kucheria@linaro.org>, <olof@lixom.net>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v5 1/4] edac: synps: Add platform specific structures for ddrc controller
Date:   Fri, 31 Aug 2018 18:57:47 +0530
Message-ID: <1535722070-10394-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(438002)(199004)(189003)(336012)(48376002)(50466002)(8676002)(44832011)(486006)(316002)(16586007)(106002)(54906003)(110136005)(42186006)(476003)(11346002)(2616005)(81156014)(126002)(446003)(81166006)(186003)(426003)(36756003)(52956003)(51416003)(76176011)(72206003)(478600001)(8936002)(2201001)(2906002)(106466001)(50226002)(26005)(63266004)(6266002)(4326008)(103686004)(5660300001)(90966002)(356003)(305945005)(7416002)(47776003)(6666003)(36386004)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHSPR00MB190;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT018;1:WsnNbOoRVvLk2zNdQSHAwUBRJ4JMUfvE3gtEa/9uJYDQL/sUs0YIM/Iss7BgjN1mzoCsesOHGW3LB4nwSttB8aJNmht4ZNEyxIIdxNo0DdJezk455CoW0PxLUje7G/Ud
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baef50ff-9c85-496c-39e5-08d60f45a09e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHSPR00MB190;
X-Microsoft-Exchange-Diagnostics: 1;MWHSPR00MB190;3:v2rx/MNK4CHullVJ/CCG0IEHT7NsyHxCch+Qn4KfHe8egS36hXxU6BjpnBU0l9+KNUOVfmVscK1atuewX7pQzn0csWdmyG50XtAAz4KB0EyGoiYVGIjgEQ6MUDy1Dfk9jrTdWC+DqXIzXoIthf5CQ04FzGPRPUC+2cR1ebxCDzD6D5HQ5HirdtyYAkr+lyivOi/or9WfY7A+n3LoqFGuKbZbunPD4HkUZ9WTqSHSgxFeDFI/hcqZIZ4ZU/aKmC3RdcNaN2CuMb+NyWJgOYdPIq1aTcQAy3IonSaOhTwiaLrJqMnRdyefLigpO68Mi7ORZxXh6+OEZHvkGzN4ugqPcwBPZ0OxuZKuMg2OP8GBxD4=;25:WCKT0v5GHcS18t1weW6LcEO1NRH1m1UbYLZBT54s6SvX9zRh+aPvJLazETSxTUyp1EqA0uwBuhw2XbH1VCW3IayI08S8bhKHcb3eN5IsP4rBLkLpZccBE3sFcbUw8M/c8WiGBy4jml8tM9Vef/589VFBBnXHckqBmXm4OzQsUaY1PkZxqLZz7HFoEA3eBlt5Gd9gs/lGDBHDBW7gGX0ze9Z+0EW3X5WBOZqaBfRbYaLDyc0KMNiWui+kroqgssi/p6b26wQZw4d5KPDrFLMPJjjaUZSTm58rZxGvJ043D7fu519r7xPmiFwkWBiRmwjrujx+JTN2kp4x69M0e3H4MA==
X-MS-TrafficTypeDiagnostic: MWHSPR00MB190:
X-Microsoft-Exchange-Diagnostics: 1;MWHSPR00MB190;31:HNO3rTneKgb85a3L8ekRO09vRygDlQQpCO4FCaobqzedntkSAen56lkahEl4WRUTUq665p4kEef/cZbmIwS0+cI19vRcHN5KRNOtBK//HynmCQQevbmD3b4B2DM8sxhJDcPyW5h/ieYWPPHMfDJx2NxBXzlZiNoAujdEYvaxcMsRg+uaBkEgUHdnLBJQHz1WN8g+GwLbM1mu6ckcZTRGpnp2aGClB+bPgytHjeds2Tc=;20:z/S2Xi/Pkzrb3lRDBMZpiGuZPBt70x39kZPxTT05K6ZfZR/KgdNxjjGLI7MnMj1VikVbJ9eU3GHgmDAZG+BhezLTPchrhDowFrFyEx10vtTUNutzJZrwnDpOapNwETdg42gk5oAqOV/MvmbyFakoXnlZTxh7PCTIij4DMyefoGJvLyfsdpQ0P6x7Lb2+600gPgpOYWwegZKRHNSAM9oXdLNnwpZlzLCTUeJu5teGJIllro3YeK2FUDk1qysUu03wTg0j8amY13F7L8NjHGjUVh8aaNpEjZcUh7nZFpwIzBZ7STQMk1Oy6eeC3jwDa3wUX4U+ciQgwuxE8f0tDDNuodf9C0wck0Uo1lOUBpgG8f3h+Vd1gsNQbEiQ2N+HgBKjdZmTEo569fJJJID08Q2tD0opm9l/RjE3hIgU8rR4oTQH9bGPjY2qC/4jRcjmGvB2y75mmhgBvl/wIjaDiyoGOiRaaUSwsJpej6lnAc3FUJSwDlMZdsnwFyO6nb/I4seY
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHSPR00MB190D1FF4A61F769B8C5C6F3C10F0@MWHSPR00MB190.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:MWHSPR00MB190;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR00MB190;
X-Microsoft-Exchange-Diagnostics: 1;MWHSPR00MB190;4:khiNtFbYT4z04+kRhMiSgV0t+AwhpK1MTPrTWa96mz46+HBvi454K7MvZBnNMWz5kKtECG7CTkVcBqZQNITi1WUcbiwuk4qRZYBKC2O2+ggiuKFjSTcjfv223i+ifSgUkmJZai+g4rrRImBTABst6p9CWB9uKLnfnTL2huL3ux79nIOQsrYfJdLpZ1HUY2GrFMsp+FMjmnBRnsMO0k40ebdQ1u36we4jqwVQ7QQhF/m7V3DDkYw9N4plvopzUVOHXioM1iycj9mbADPqzYpbsIiF8AIcKvhK1XVV75D3W/BNMg/krEjhA+62dkJWUxzb
X-Forefront-PRVS: 07817FCC2D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHSPR00MB190;23:TDhWUMY+ASozCp9cxkm9rqImH6XZyaAugiO2rN1Zb?=
 =?us-ascii?Q?u97SJOrH6yf8ubOw8tnS4IDBjjopRfDMnAAlB91FF7IMmJIkO5H7/cJLdhNv?=
 =?us-ascii?Q?Cmf8BdvuDHe0JAdMXSqRNVAF+6RTFGYtIw0P/zCPdydOgj29Efwz4YhdoP24?=
 =?us-ascii?Q?VJw+ZOd7tDjy7sMkMZKTjo0pu41ZzUHUHtu1ZrjfmZBf3Je1ULX1SM2NOqlq?=
 =?us-ascii?Q?bGvvRhg9vd+KiPG67bzX9h3cSoKUPE8egKJXeZVdEgcouVTLuJzbrpoNn/rL?=
 =?us-ascii?Q?RiJ8ZV/pOfPNShN5KB7ryFKWNKlaYp4inUEd6r3oUTs52O5Y+HfmFV1qEEti?=
 =?us-ascii?Q?xvrHwHultpX1NvNp9hJOD2k5v6zPTIOU04XcE9Wmy75JiqbEXPNF7YppI6Fo?=
 =?us-ascii?Q?jjsGcqu4t5aTMXC8gPId5HPbMdQhQ8PEP5lOnEKIvHHxKfLHKQCn3MlZt04x?=
 =?us-ascii?Q?1HKYjjGhqzzGVH1cNLG5wo1Q2ERUpGreI+dnbyin2fwh0MP3ify7NL1sgXHg?=
 =?us-ascii?Q?zPpy6AGGGBVf8Yk7vt8YD6N04ZNgaQsCeShMYZa+hX/tGWYFty8dX58k6PPa?=
 =?us-ascii?Q?UDqSlojmGQumnml9l+qKNvqcTPXUM6ms5Cx12V3ntaxJ8Du3run5tnXB3P56?=
 =?us-ascii?Q?we0ZT+DVND4R4hlJIR5meoj6VyGo1sz1PMz3ZWTT1MxtE4AQHKtzJhYkELV/?=
 =?us-ascii?Q?6EZAonicX6J4lkEwlTYAUN0etJdw7BnINeZGHyBJtVvASzmhRw74NvaWTi1F?=
 =?us-ascii?Q?vZ72hzPzrozIQtKfUeMuLU1QnO8HJ91tFwiwIc8BfKPgAAsAVxQpBha9zDfS?=
 =?us-ascii?Q?B1LhUWrQ2E1ul1Gsnf+PzDOI6Lwp24FLZSOCVzj6+2Ub72Ntn6AfiSLp/GsW?=
 =?us-ascii?Q?xBnPbwBh3j79PO1GZlFhBEwG6er6yEzwtyBIRGdbcU43Mhp8zxwLSwlLshDG?=
 =?us-ascii?Q?eb13fqwhq3hy7U/fAdHz05QMzcSF5sO1E2UyY2ZIxmhZ8ww3Qah67ZSBSt7b?=
 =?us-ascii?Q?dIHw/c5jzERI/si7xiRd0KhjoQiGs8P7wcnydMyOKZzYpy5yi6Q8v4Y7DwqJ?=
 =?us-ascii?Q?tX94qA647Wdi7fFsSrLeP2A46YfqtBWp+gZmUSqQQKdP/jaVqBvsJOE/jhhd?=
 =?us-ascii?Q?2fdxKUTeW4tdQtIUQpg6e0kUHtUAvSKI5kFdOcWGWzbR5RE7pjzeKExKqwXD?=
 =?us-ascii?Q?bWMlJu/bK/3Ddgys4e4ce/ri5TNTozD/p1IFAEHjdCvL/NwbDDETJTEFT8Kd?=
 =?us-ascii?Q?z49XyqLcB9WtSNvYmVi/oG1i4IiYdfiH858pWGr?=
X-Microsoft-Antispam-Message-Info: Tl6Aj4ILUrxcN5BuPcMIglUaub8KrcJtHSSjo33xaumkFVUF5ATkgClelxeVGc5RiQVaIP+V4stIc5VXbuU0zncusknOIQn6OBhx2g/ew0OLkdoJy5uisVYTQnBKmTeuUbMylJkvUAdqwVp8umgCh8BQ+FHbXE2ByEEhgVI6NsrDiX/TgOtczOhWOe7ja0D05tn3ka2Goi00nAVDJNnTcRnfKFKSs+NyAXZJsVbbN/9Vs2CmF9oLs3JYn+vgvAYMoK7ZjdljstAEadRCFYO6CJxpVIrjWxSb3iAvJVIdNPweSAj6JuZ+/qiG7qzMsIC74uWrRYna7sbtupRhSxCIZtf/YYmiIk2VUL+2w6kYOkI=
X-Microsoft-Exchange-Diagnostics: 1;MWHSPR00MB190;6:sdsYkuR2tosy6TkuabfcGr93TnsK6siyATk3O+tGiPQRp9z8oxiOApyKC51wBRAXfwuidXC9Ys7vPnsFrGANCx4JgcylsSqAI2sw5i8FYPj2JmLbWlO1CZ5a16Z5el9jYxS0eOaf2JAVhcO6f7+wfBrccy/25TBG/gz7hFMxNQJ9ZCxcfULsGAI3BPYunhtw1BetXlVG26QToIIrM7WjkvoNIiwAmG3cLC+kX7X0203RB+KoGYUGGWoI0CY4Hicty9jt+c8ZK3yB9VgMQDRQd/Ubfm4lZWwyqcXwGTnZ8oVDwIFTe4hwjzjzBGayysX4rqKtnmr4rPDCTIPd8sgZRA58kS7iaC9w4ZWRltph8IGCsZtpZwb+CXfPs74AgAOqKX8R2W1Y88rMmUoSveRDUrEONcuQSWy2GcHQavrYMlvOsfM43TUUYYWu90hgRRd+EhMWO56PBY0PflQMQe7pdA==;5:bFoj4AI47GXNxTDNrhNr7166gZyLOFKzGdmyzhARNR/0gOOK9o1iv9oCHfRvXF96l/KztCrAJUdBVhqjx7k8oKDzYz62mM0fFGXVi55zJYOV/Laanaq0fIM8hsGf1HdSWllqjSL6FE0FCyQvQi6capxuiH5oUJQU8bbH6Rp+/fQ=;7:aN/sOhTy/fIguIcuxH/7YrXpk54uVLwb2Wuh79DtoJORvebn/ws0D1staLz/8+2DEoTkKjtR/K/1934fmDT5+vDtg+RzTBHVNeE6yTgdIFnXXvrDTX0jAqfY/0HC2y5Eviypknar1PprzRT3EOP18y69uBYUytG8PHvBP0VScej6VJFwuQqrpResovtjh5acDiWc3dM185uL4wHTIVdZfemGzuenqfawollAgluWtPT7Yqt8gXiOP7sYKWz8NQbV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 13:28:23.4825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baef50ff-9c85-496c-39e5-08d60f45a09e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR00MB190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add platform specific structures, so that we can add different IP
support later using quirks.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 78 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0c9c59e..2470d35 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,8 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include "edac_module.h"
 
@@ -130,6 +132,7 @@ struct synps_ecc_status {
  * @baseaddr:	Base address of the DDR controller
  * @message:	Buffer for framing the event specific info
  * @stat:	ECC status information
+ * @p_data:	Pointer to platform data
  * @ce_cnt:	Correctable Error count
  * @ue_cnt:	Uncorrectable Error count
  */
@@ -137,24 +140,47 @@ struct synps_edac_priv {
 	void __iomem *baseaddr;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
+	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
 };
 
 /**
+ * struct synps_platform_data -  synps platform data structure
+ * @edac_geterror_info:	function pointer to synps edac error info
+ * @edac_get_mtype:	function pointer to synps edac mtype
+ * @edac_get_dtype:	function pointer to synps edac dtype
+ * @edac_get_eccstate:	function pointer to synps edac eccstate
+ * @quirks:		to differentiate IPs
+ */
+struct synps_platform_data {
+	int (*edac_geterror_info)(struct synps_edac_priv *priv);
+	enum mem_type (*edac_get_mtype)(const void __iomem *base);
+	enum dev_type (*edac_get_dtype)(const void __iomem *base);
+	bool (*edac_get_eccstate)(void __iomem *base);
+	int quirks;
+};
+
+/**
  * synps_edac_geterror_info - Get the current ecc error info
- * @base:	Pointer to the base address of the ddr memory controller
- * @p:		Pointer to the synopsys ecc status structure
+ * @priv:	Pointer to DDR memory controller private instance data
  *
  * Determines there is any ecc error or not
  *
  * Return: one if there is no error otherwise returns zero
  */
-static int synps_edac_geterror_info(void __iomem *base,
-				    struct synps_ecc_status *p)
+static int synps_edac_geterror_info(struct synps_edac_priv *priv)
 {
+	void __iomem *base;
+	struct synps_ecc_status *p;
 	u32 regval, clearval = 0;
 
+	if (!priv)
+		return 1;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
+
 	regval = readl(base + STAT_OFST);
 	if (!regval)
 		return 1;
@@ -240,9 +266,10 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 static void synps_edac_check(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data = priv->p_data;
 	int status;
 
-	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = p_data->edac_geterror_info(priv);
 	if (status)
 		return;
 
@@ -362,6 +389,7 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
 	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data = priv->p_data;
 	u32 size;
 	int row, j;
 
@@ -370,12 +398,12 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
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
+			dimm->mtype	= p_data->edac_get_mtype(priv->baseaddr);
+			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
+			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
+			dimm->dtype	= p_data->edac_get_dtype(priv->baseaddr);
 		}
 	}
 
@@ -423,6 +451,21 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	return status;
 }
 
+static const struct synps_platform_data zynq_edac_def = {
+	.edac_geterror_info	= synps_edac_geterror_info,
+	.edac_get_mtype		= synps_edac_get_mtype,
+	.edac_get_dtype		= synps_edac_get_dtype,
+	.edac_get_eccstate	= synps_edac_get_eccstate,
+	.quirks			= 0,
+};
+
+static const struct of_device_id synps_edac_match[] = {
+	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
+	{ /* end of table */ }
+};
+
+MODULE_DEVICE_TABLE(of, synps_edac_match);
+
 /**
  * synps_edac_mc_probe - Check controller and bind driver
  * @pdev:	Pointer to the platform_device struct
@@ -440,13 +483,15 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	int rc;
 	struct resource *res;
 	void __iomem *baseaddr;
+	const struct synps_platform_data *p_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	baseaddr = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!synps_edac_get_eccstate(baseaddr)) {
+	p_data = of_device_get_match_data(&pdev->dev);
+	if (!(p_data->edac_get_eccstate(baseaddr))) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -468,6 +513,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
+	priv->p_data = p_data;
+
 	rc = synps_edac_mc_init(mci, pdev);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -511,13 +558,6 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id synps_edac_match[] = {
-	{ .compatible = "xlnx,zynq-ddrc-a05", },
-	{ /* end of table */ }
-};
-
-MODULE_DEVICE_TABLE(of, synps_edac_match);
-
 static struct platform_driver synps_edac_mc_driver = {
 	.driver = {
 		   .name = "synopsys-edac",
-- 
2.1.1

