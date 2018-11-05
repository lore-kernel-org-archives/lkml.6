Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861F1C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221342085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Srh7oxDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221342085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbeKFH70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:59:26 -0500
Received: from mail-eopbgr740059.outbound.protection.outlook.com ([40.107.74.59]:4296
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388181AbeKFH70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp0TXtvvNWJKYxyxZq0a9KHiyxAo6O9Co4ggitcJNtM=;
 b=Srh7oxDQaQgzvujzVvh0Y0senW2f8Bu6zEXdYP68QwS7uXzllqikgdCjvj21j5WotXdsbyQ9Bv7Nya60UHWZ41DY4QPNA7y254JD4a75Qrz3Z+J+OyEYPzKEZQ2QLuKH1UTekwQFDIyetYW3mLMpFT+KDHBZsPfkEm3o7GM17RI=
Received: from BL0PR02CA0100.namprd02.prod.outlook.com (2603:10b6:208:51::41)
 by BYAPR02MB4453.namprd02.prod.outlook.com (2603:10b6:a03:57::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.23; Mon, 5 Nov
 2018 22:37:20 +0000
Received: from SN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BL0PR02CA0100.outlook.office365.com
 (2603:10b6:208:51::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.21 via Frontend
 Transport; Mon, 5 Nov 2018 22:37:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT014.mail.protection.outlook.com (10.152.72.106) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Mon, 5 Nov 2018 22:37:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50363 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gJnUl-0002nQ-Lk; Mon, 05 Nov 2018 14:37:19 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gJnUg-0001yB-Hr; Mon, 05 Nov 2018 14:37:14 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wA5Mb4d2014126;
        Mon, 5 Nov 2018 14:37:05 -0800
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gJnUW-0001wf-Nc; Mon, 05 Nov 2018 14:37:04 -0800
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <jassisinghbrar@gmail.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Wendy Liang <wendy.liang@xilinx.com>
Subject: [PATCH v5 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
Date:   Mon, 5 Nov 2018 14:37:01 -0800
Message-ID: <1541457421-14820-3-git-send-email-wendy.liang@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541457421-14820-1-git-send-email-wendy.liang@xilinx.com>
References: <1541457421-14820-1-git-send-email-wendy.liang@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(396003)(346002)(39860400002)(376002)(136003)(2980300002)(438002)(199004)(189003)(106466001)(8936002)(486006)(44832011)(106002)(5660300001)(356004)(6666004)(47776003)(50226002)(15650500001)(81166006)(316002)(8676002)(110136005)(54906003)(16586007)(81156014)(9786002)(478600001)(50466002)(48376002)(2906002)(186003)(336012)(76176011)(77096007)(26005)(14444005)(126002)(107886003)(39060400002)(36756003)(305945005)(11346002)(446003)(4326008)(63266004)(476003)(426003)(36386004)(7696005)(51416003)(2616005)(107986001)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4453;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT014;1:gEuHZirX1Th0hXjHXMhRO0L9uODePUkiMIcphkCONISkxN3Prnhj8ICSl4lCKm0nFrWNQrT+FO3Lrz1ENmnyW3bG7IYywwIZf1XtxeZwgaVi9mGEN4/K98NTlFTmrsf5
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dc4cd92-bdf3-49a9-8c8b-08d6436f3f72
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4453;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;3:jm/fQvx9YswZklCpP2q+2HrLO4YGrs8T9HtSneMfZ7vlzS7Ko97Fq/w361pLXiF3XVAXI4tEue7m/ZhrP0AAqGApRMAHyTRi/Hh9lDAYfckWVBPiAI2fvW34IVRX+9CmtMpcbUlStJFQzNhtj8coY1foFMN8L9Olr43iEFYaN20Y2OD5901iFnkqqeEtMJwOI0EX9SwSVfxzDGfPDGqfrX6/b5Fw7uTD6YRUuZrZyH8iLpfvhs/TWDoWkLaN5gtrA9lPk+RdOontboN5dMvWwPyJ135lUO+xSlR8RrTVTJEucwgsnTUuz4YsaldXVnM5j+y08ZHlPREAdZGkMXvbKDtGlPc+GCbXzUG5tBgyBvw=;25:TzSVGl5f+rm1q2p46+bS40kEbuhxYz3OmpQam2SqIIK+fzccUgXHEEgnl3URGtvyCzOe7MxOARSMdsCGs3rCktbiWn7k0thxkZvnNpgPJN62TYx0gvyuWPaTZKnZmKuCJaWp2fa6YErlW8rwRD9XrQFxXpha+2C02Q72R41F0NQDB9r169o62pStam8ASiuftXM4p4rrIMtDCfZ0N7MHV5rQf+FfwOG8FdiMtGNMKF0vQgwmgqSxOyl8OX6NfJGL3a0ilu3a7myzKJe13qWolRetRE1E1KPwA4P/UPH6MC6OVqR/sZeUlQbD/GsdEL3YPVgKDpzyi5WU2sDPjaidBg==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4453:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;31:Ejq0wVT2zLbo/VqS4039kFjbrUApRFqPIoxq+5XSfxGW2oRQAlm6lDRIz6b9TYzrj1qb9ctJ9o2osS+zyDpt1QIh9N5p8lJOVvtH8JdCQZlBTuA18Yv7uBuwrfLfGjUjFrCeuIw1UR7tyErmwfsbW7J2XieOz3eBlepsA16CesXbABe+2ARz0XGKLpYJJgEd7iDy3QkEyOXyEWW3bewK0tkDMZrbulsDDAmjpqpCYmI=;20:CPfPz16kUBodaHv7qIa45hTE79E59wWmFPo/kOYiLbU/drVvD449HAV1Q4/VWTSz4jH5K/aLsQ4lZvCpzEKHhUDsTZqzoYnreySSbm+eKtRDdDrnlYXuru0l2I0mG/ImTswUaEKgXl2VlmnzLIxFV6mpME8JjAl6IRU7o9ztTsqXDBcJkUYsaQiLgzw1Y5+qkwdGqW//SIX0B/Lv4HCsRCwFVI+5RgqJO8EJdoztq40AqMWzORGCDT69uCdMggbgLNyG7BAIvSNsq09bMUOxHtKBiFQEkENhoIFR/iADx7LSiv9hV+NxrfdNnfKjyktD7VNXj8gfhDo6S3XOKVhBrNFdUWRXhPKdLdgYuoQd34DD+AYCRuyHHjBLNCXlFmRloTHTwgfUaZnqsHZrnbTI8x2qbjc42I9OMHhNKeIAJQebo3V5QffJyr01OfR/l247OSxPWQ5nN7dWlh77/7d3t5ut7NexaT/l5HyJhiBpR5GcuCbDD5PYbAHJ55Iypovp
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB44535FBC826205D4F7EB33B7B0CA0@BYAPR02MB4453.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4453;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4453;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;4:cr2ore58eXUnAfiU5ZMfB4/t2e4BCrl6x7Meut8mRkhBwBVMBHPfOWK3nhr7eflGuhUEKJH+LJjexqdnu1fsqcYC3Vk2mQ5yUBmPKt8yFHz3npp+Sm4XgB0R96dcqfj5AQyHT/G8STP0ZRCKB3iWs3UaX1jD/NBAa3dbwfqoN8yvctt+uTnCh6uK3ETfqlBsvzsLL3tDmpkYkHofAeBzZfuNF3zLjkHQ5J3MxWXs64Qd39ChfH1S5VRWA7nTYfgF2cB6NlO8UMWqq8/1cyCNS7pd+VDKHVUyHLTQNHSy7O3fcQIf0fzCJs847aKufEA/
X-Forefront-PRVS: 08476BC6EF
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4453;23:0zFs75SeWUZgsWL+5lmswy9CkoL+W6EHtt0jlSE+6?=
 =?us-ascii?Q?C+an7DMs6F2POojtRAkIiulcy9evx7UriJ1U4a3u+FyJHkvdovgD0idpwy5n?=
 =?us-ascii?Q?E8FxR+Cm9rgbysoWoSl65KgmO9Y7LvFvKenySylbdUi1vMmDHcx3LnCuSjaA?=
 =?us-ascii?Q?Y49jcLcn8rMTctPvgQqcX/WMNNnEv7Q0BuVtAuqvRpDgXbEWOCP0JKsmZyKT?=
 =?us-ascii?Q?LJ522PAuWiJeVfXL2szOS131E+Ydmc0Djo4uGktge0CpSQ5Ky90IdVnjzHty?=
 =?us-ascii?Q?g5Jg6TxXDAsEuJfFuQ2PRWY/jQ90AZ6fugTv22W/d0giLoByWN+SgI2BosNS?=
 =?us-ascii?Q?7Uk3mRbJ03ztiL+fgnRASlb7DiHcp9FYv0Ts5HmfcYU7Fs3JPcyMVUL7Rv+m?=
 =?us-ascii?Q?c79Qt3c2/86XwwkFImtBbxklU7v5TnouXqgqsNOIW4NJoLsMShv1e/SphLMX?=
 =?us-ascii?Q?P1pXpOw2b73GyKllhtS8LVRO8jOBy+bS/tOYC8jG66RqZg2HCO5jPgq2ePcm?=
 =?us-ascii?Q?VMKlfqTfYXnUhxbUORyaJkwDLRf4fWBwsM3Pzek8aTs17qz+mQtcBQfF57tb?=
 =?us-ascii?Q?iKj0tV33yEuIaw9I0zl6f7/xJXCLnNInH1GbFMsg0B9zH797/TT9hTjZdxSM?=
 =?us-ascii?Q?tT+e+zcH8jfap/oYd+h57Vifjo6X6bZ2hbXK2aM4Wb0svFnFLETy3uZqyR71?=
 =?us-ascii?Q?sWZ/uEpIv6fer+5eQ84QYsxNBEVo91iKI2BsWJcoB9nTMs2e292TSMllG7Ki?=
 =?us-ascii?Q?3LTfjyUzH9KAMuq4Fi9TRhYiyjBpEKIMrQxXOpBLWhWbiy1Q+OawbCNwn0pE?=
 =?us-ascii?Q?fpjod4TobQtozHGN+56y3SJ8jquOLpxInOstpQ1cR5wJpZ5ZTNQLi1H8jw7E?=
 =?us-ascii?Q?X8VsMBkdl6mqrFse4uHubteCsWh8sT4f1IBPHw468Qe5APSp4FnhZv3MDfAl?=
 =?us-ascii?Q?CNabiBFkBgP2Y7/G+OKZyh+BbVmpw1c+eDWE1i+wiJ+iYV0qQ8LvnUTlB/as?=
 =?us-ascii?Q?tnzuoKzisY+wO36WdwQUSiU1dcinFSsJh+fe0BMd483thxrSX1lYIpTYrXei?=
 =?us-ascii?Q?EZVNWfrwGdblSMefXwz7LHsckLojpJ4z80F2xvvg0tiOvU9VrBlKPfkr7Bk2?=
 =?us-ascii?Q?CZ3Zna9kehjYPEYWYZm8E7ftwzlT5Vyd/AW3Ul525A8ZlcAj+eqLAChTeWPl?=
 =?us-ascii?Q?6JUQMHCAwBKaQ/L8duNqs4BiDELhkvs8ACyKQ6KOu9Hfx0hhj0yhoT8HdoRH?=
 =?us-ascii?Q?Oy2VmnAB8NBlOJquDGnjsgEI3FLjsuca6maV2nfPyp9W/PWQFPn1SDXhpjLh?=
 =?us-ascii?Q?HekQc5wjLwaiwVucJSEaTg8pWqxj8XMkLRi1c0UgbdG?=
X-Microsoft-Antispam-Message-Info: y13T0ZT/4r1f5V+iCj4QZ1LYbFVxOrwFhartsTz7R/fapw+MIIBwDVeNlcVOhgfedO0yP2M0nUAMS2oQJHO7lVZNt+Xg9rimhn0ctgnDdlddrJd0WyYr8rmpSsokMAJuEi6HvMijAv7Qb9wIrPgx3JChBK/ld8Zkl+YB7F2ITIT0ntYHBEFmToyO1NDukmbxAqAiZ72sSEbp9fQ1o54LZzPfH4RWp9H1mEN34lD9lijYZbqRqJtilSGj+rbI7MPnrXcwzcUkxwxIBZO9i6+Oqg38alUh/A5895vQ0mHMO4zCTO7q0QBjIEv8hk2OJpiOcZMQHGgJZiMLmYMAXr3Dp1Tm1pTqmiBpdBpKKpzU65w=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;6:sULc9y9iwY054vKRNgKIg9Vp3SjJ3adHkXJNYNItkpj60yfVukKjQhIibpLY94Q2cQjqCvm35jqOduyZZHFoYeaYJGpMOkKycw2CJ3QC4hEbhRTzkYL69305DWBb8LmkBSIHJmWdQDvpY5JyLfc9Ctj7NtNGmf578nk2wpQcBgWMGL0fNzzBj+0r2NwDbyzFT28+4gpaTjcjOAEPME9aOF2akNTOe+82JAeasXDUNWMKiOTXOhmORaITYZHePzzenM+DeKznFFTruikUu8uWlWvEAkl7du60ZpoZkDnDIWeS7KftOU4tzad2zjTIb6AltlK2DkOfZIwMCQ0iLxXXYlK37646W642sQs1ncCyfnF799OYYdHckMEdbMIxW8bCDyWDZSR8niH15LP4YZv8I6dmUnfwkw/xTGjLTLHDoe/CUIJfa+LhWEVXj5UUF+JJ2B/930+eq1m7ZztepeVGHQ==;5:Y03+xgpm9/THeMdZvwabv2Bmt8kyNfr/aNeQ+4K+KYiN1dIf1FxHNJgbWvFMKcy1gKCwYMeimzsaw955LjsS0ygVrE91acYhf7v9EOTnmZFJjgEbrl4z+fj23NQ4xK9ce5IhZ2bUzlZ88YKKVRwKw5t9zOkWwlRXrKmmcLulFuk=;7:Z94kTGVZMTxmTCEbA2s16WvB1diAkS75t6bLzEib0RT5lHKcY39EQmE9FimAkz/euN+FKfpTtu+nWcY8QZCXneK5FucZ7SY1qsblKUBfkqeqMOPaLcmZOmt4zSzVwLTcjpy3DXQ90qM1QdozAXrxTg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2018 22:37:20.1281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc4cd92-bdf3-49a9-8c8b-08d6436f3f72
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block
in ZynqMP SoC used for the communication between various processor
systems.

Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
---
 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 128 +++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
new file mode 100644
index 0000000..18fd7b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
@@ -0,0 +1,128 @@
+Xilinx IPI Mailbox Controller
+========================================
+
+The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
+messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
+agent owns registers used for notification and buffers for message.
+
+               +-------------------------------------+
+               | Xilinx ZynqMP IPI Controller        |
+               +-------------------------------------+
+    +--------------------------------------------------+
+ATF                    |                     |
+                       |                     |
+                       |                     |
+    +--------------------------+             |
+                       |                     |
+                       |                     |
+    +--------------------------------------------------+
+            +------------------------------------------+
+            |  +----------------+   +----------------+ |
+Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
+            |  |  Registers     |   |                | |
+            |  |                |   |                | |
+            |  +----------------+   +----------------+ |
+            |                                          |
+            | Xilinx IPI Agent Block                   |
+            +------------------------------------------+
+
+
+Controller Device Node:
+===========================
+Required properties:
+--------------------
+IPI agent node:
+- compatible:		Shall be: "xlnx,zynqmp-ipi-mailbox"
+- interrupt-parent:	Phandle for the interrupt controller
+- interrupts:		Interrupt information corresponding to the
+			interrupt-names property.
+- xlnx,ipi-id:		local Xilinx IPI agent ID
+- #address-cells:	number of address cells of internal IPI mailbox nodes
+- #size-cells:		number of size cells of internal IPI mailbox nodes
+
+Internal IPI mailbox node:
+- reg:			IPI buffers address ranges
+- reg-names:		Names of the reg resources. It should have:
+			* local_request_region
+			  - IPI request msg buffer written by local and read
+			    by remote
+			* local_response_region
+			  - IPI response msg buffer written by local and read
+			    by remote
+			* remote_request_region
+			  - IPI request msg buffer written by remote and read
+			    by local
+			* remote_response_region
+			  - IPI response msg buffer written by remote and read
+			    by local
+- #mbox-cells:		Shall be 1. It contains:
+			* tx(0) or rx(1) channel
+- xlnx,ipi-id:		remote Xilinx IPI agent ID of which the mailbox is
+			connected to.
+
+Optional properties:
+--------------------
+- method:              The method of accessing the IPI agent registers.
+                       Permitted values are: "smc" and "hvc". Default is
+                       "smc".
+
+Client Device Node:
+===========================
+Required properties:
+--------------------
+- mboxes:		Standard property to specify a mailbox
+			(See ./mailbox.txt)
+- mbox-names:		List of identifier  strings for each mailbox
+			channel.
+
+Example:
+===========================
+	zynqmp_ipi {
+		compatible = "xlnx,zynqmp-ipi-mailbox";
+		interrupt-parent = <&gic>;
+		interrupts = <0 29 4>;
+		xlnx,ipi-id = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* APU<->RPU0 IPI mailbox controller */
+		ipi_mailbox_rpu0: mailbox@ff90400 {
+			compatible = "xlnx,zynqmp-ipi-mailbox";
+			reg = <0xff990400 0x20>,
+			      <0xff990420 0x20>,
+			      <0xff990080 0x20>,
+			      <0xff9900a0 0x20>;
+			reg-names = "local_request_region",
+				    "local_response_region",
+				    "remote_request_region",
+				    "remote_response_region";
+			#mbox-cells = <1>;
+			xlnx,ipi-id = <1>;
+		};
+		/* APU<->RPU1 IPI mailbox controller */
+		ipi_mailbox_rpu1: mailbox@ff990440 {
+			compatible = "xlnx,zynqmp-ipi-mailbox";
+			reg = <0xff990440 0x20>,
+			      <0xff990460 0x20>,
+			      <0xff990280 0x20>,
+			      <0xff9902a0 0x20>;
+			reg-names = "local_request_region",
+				    "local_response_region",
+				    "remote_request_region",
+				    "remote_response_region";
+			#mbox-cells = <1>;
+			xlnx,ipi-id = <2>;
+		};
+	};
+	rpu0 {
+		...
+		mboxes = <&ipi_mailbox_rpu0 0>,
+			 <&ipi_mailbox_rpu0 1>;
+		mbox-names = "tx", "rx";
+	};
+	rpu1 {
+		...
+		mboxes = <&ipi_mailbox_rpu1 0>,
+			 <&ipi_mailbox_rpu1 1>;
+		mbox-names = "tx", "rx";
+	};
-- 
2.7.4

