Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95A7ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A62D2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="h4fsuwlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A62D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJSQmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:42:55 -0400
Received: from mail-sn1nam01on0089.outbound.protection.outlook.com ([104.47.32.89]:29728
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbeJSQmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuD5svM19EVJGnvbkmyRup6Vjj3VTpRB9i8mLekF2dc=;
 b=h4fsuwlhOBaceGPyeBV82ysBUjvxw+vkagmGe8D3+29Cd9er9KdDf/AIqALpjRsgKqm0L5Z7iRIOEWxSAupt9QwVgq77xk3HMFDyN2vDUjzJAvWn8Fw33p36lWToXRCLmO8NnSZB+cZBzLj50JyVEzRy5Fw9BqF7q9ZLk2RgK/8=
Received: from BL0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:207:3c::29)
 by BL0PR02MB4451.namprd02.prod.outlook.com (2603:10b6:208:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.26; Fri, 19 Oct
 2018 08:37:42 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BL0PR02CA0016.outlook.office365.com
 (2603:10b6:207:3c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.20 via Frontend
 Transport; Fri, 19 Oct 2018 08:37:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Fri, 19 Oct 2018 08:37:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50994 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQHt-000233-GX; Fri, 19 Oct 2018 01:37:41 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQHo-0000uo-CZ; Fri, 19 Oct 2018 01:37:36 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9J8bROW000612;
        Fri, 19 Oct 2018 01:37:27 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQHe-0000r8-Lz; Fri, 19 Oct 2018 01:37:27 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] firmware: xilinx: Add zynqmp_pm_get_chipid() API
Date:   Sat, 20 Oct 2018 14:06:01 +0530
Message-ID: <20181020083603.27602-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181020083603.27602-1-nava.manne@xilinx.com>
References: <20181020083603.27602-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(438002)(199004)(189003)(51416003)(81156014)(8676002)(50226002)(446003)(7696005)(47776003)(186003)(81166006)(1076002)(126002)(48376002)(14444005)(486006)(50466002)(5660300001)(2201001)(26005)(77096007)(426003)(106002)(76176011)(2616005)(8936002)(11346002)(9786002)(106466001)(63266004)(6666004)(110136005)(316002)(336012)(476003)(36386004)(36756003)(16586007)(2906002)(478600001)(305945005)(356004)(921003)(107986001)(2101003)(5001870100001)(83996005)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4451;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT050;1:nW/2rxC0GuMtmDqWsVzMSMhOZmka5OulR1Smwkdne1p/Ujbyc+TxnQ2zf51ni/IEkOrDNLx8gnLxxUTiYLZTWiGp0h/V2qtpdZO1dWc4kg7XsKmeBQTB4ne4di0kLX35
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe017edd-e75d-4efb-373a-08d6359e22a5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4451;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4451;3:ymCkRhLCKKUymNiK+ExbADwG39DLlwogy2ixZTUqbmIvx1T6Gq188It59KywrC7p4+Yc3xX95J9K52jjc+MUhNZ0AiXcQ4O29BORYebdaWAW13n3Al12iI2rfDB2sGbycGIQ9eHx7/3KnM9H5acuuqNRP+8GFwC0WS+Py3WkXy2hafyMG1pFmSaIOLUlgHYbKwkVnwgR1ZN66VbWXl8vbW4GumNZEuS088Sa7P9/XaZJd2iWmq+DPmqd0XuAW3kK+3ya+CxM2YgPK+rZRjGF7XhVyF/y8zmyFInaixzvHBT2S76r7FdZRtovtCTBmsf3nj6brhJpChXGiBvNXfBJxUDV8lf6HHi3PtAcIN/m3E4=;25:/FBz/KkaMXIJWk8cB8jzb4QUTgFZbjZb7RPVDJm2leKphM6ba6QMJwHeH05mF9PifrGffX6sK1hT+gOC7SAEy82zifxoyb3AFJp3n5/MxKPN6MXASaDVJw8qVn5vAeTwJsS2RxnBP6dmXO2PivyvX3bQD5flOt5cZgH5Xw0DWwFkT2fuBHwf/6IvwrAnZQbnItTb4uxGt5gdAHRzne3EKNleJJOqBYTf3N8I7s5Qz/0FkB/U19SgvAoBfiKmtzyYdf9S8A2Zlq8pZ2dIOWZF/q24/7b04hAFLpHimFJ5aCdVHcsKXa4c0NbZbtOp1weqKhs5nNo5UeOvkUaMg62qVQ==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4451:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4451;31:TSrfh6jMph9hx+1+ZJsodydhzVLPQ8fumbWBnj03CEPbsS8lWbmLRdSL8eHP31qzDe0wr7tJHTNTVH42ZH1khAUX7E3MQmwsKUMeZnjrwFPOoDSLI1jMgQTgcc4WyRqs1rT6cdt1sqB5nPPg9o8Afvtze/orUjEvfPtzVo2QZxQIqrAzuK/kkhuIvZ1p1phDMu31A+Q8qJlTXXJatOLv/kSFrcJREE5vJ4A6LCG0Cto=;20:x+1465tnVhwg932bMd5t4ojA62STd7ht5oea8drnrwW2vtd3AjXIWsyZ+1QWCv+EqFza3xsFin6CF0gK5Ppx3/SWlXJ0yocetLYTaV1bx6ZKfw99dlrZd2Cg5Purn9FtRc2ZXMbt57eGJ3mBUMzEunhjwEwDNGfo9D6JKIw7SLBNZ8mCi0RkjSsnScimdEIK6sAQf6IeP3/DO56eRRT+hMwZU9RE2d5T859cChanoWBi+z+fc5OGR35pTEvtEtgSmcJdhsuY3lXHGuJubiD+N84t6Sa7bhEM/VCFz/sf8VmkE0+skCmL3PdaKLY57xs6CaPte1EVKa9yL49jYsZVqmDjoORuur4GFIf+vjnXxejiLZvrOlI1qW3vYG86QGMOkSOUfG1xq6rq9w6wZ4ICCFQ80/O01z3a+qC9H+iRJ47j3CNOnrC8jvJ32WgMuxgRD0FMIKbcLWBYJW2iIqXQXFdBWZv2UgS4lGmgKta1lNlJ9zkABSW5F5xxjxT1hcwd
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB445138F62DD103A7C428D3A9C2F90@BL0PR02MB4451.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4451;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4451;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4451;4:WMJRxegG76esmJtdpmsQus/Cy1O4YkrFFYzgtt7T7xd9ycfKpSPeR+wMXmTdoojLRChKjMnD1dJrWADaol+cv9zp4ByZ3jOV18ir0/Uw8IaIuX0HtTQuB//wvwAnz5hO72c2mh+4ch53gQ+3oyS4KzLuzM1sfBFtidUIiw/vKGrBJVifgaRPHkf600QE+J7698jCL9RLD8cyE7bgZ34mITxfbfogScdo1d/IGl/9OTnGXA27k+YyOTxKJ2rfBCAM+L3SsnMTuj/f25NEGRNI1Ob8RkvSeLhyzN4+TgRlT7mx3iGlLIbjnCpquJg3OSK+
X-Forefront-PRVS: 0830866D19
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4451;23:D2X8Z4VSp2TKw7AaE+ylA3JOyHmr9+1s4ghAUBRf2?=
 =?us-ascii?Q?G5L2rh3+I8MykgMVBTQdUqxzzCIDED5WTOLbm/3wuJvt1UBSrx+1/PGLyEVA?=
 =?us-ascii?Q?ZKaC8ixGby8fYl6+24fJctT0qQt7VJ0VJjnT+JALJb9LI4w6Vr7m8MX6vmJ2?=
 =?us-ascii?Q?Mk4njawnZrGepG81r+APbC4rrUOyrTMryM9PduuYuetPhoJeojNt3X7iNhyd?=
 =?us-ascii?Q?p/JbQ+SLL7TGi+/o+aq/I9C1YZtah7x7G7nyOSSngNCJcyRT6ziT2TLmgS0S?=
 =?us-ascii?Q?DwgdqPjGwSukqmM9cc7LlG5I0lTZfc7uVmEeWjeYstSeWKMkYcPL3BRmxBzE?=
 =?us-ascii?Q?u/9Bzf40oHiMhIL771sTFZvkUIri0Fl5VMrnC6dOP9qKARU+pD0r6EFcbR7h?=
 =?us-ascii?Q?bxxnfKdd7D3jiqiiwT3TPRiQey6AaJR6SX0R6h7s9IwNBjzfo0SByTaMYWGi?=
 =?us-ascii?Q?uZ5JZneajdA2WyDeWRwaSK5xcLBDBgEuYkMmXpS8UJz/FhJK4WQ52rZtRD2g?=
 =?us-ascii?Q?o+LIoXOKr3xjtpsnhKbW300OAGKcOYdMKGv6OcexmyItaidgcdVRK0kyKoAe?=
 =?us-ascii?Q?rlHt0dZ7f4Rpv/Uajq9gpeQ3++FtGwssx91P4hpcLLYWM6iGOH8FxvPCmut1?=
 =?us-ascii?Q?geAVR3M8PYMh9iVkxGgxO93ZgUACekrxbeGP8mJyWHAmwKk0NBMhHykwEQjU?=
 =?us-ascii?Q?OyKxOs7tokstDBqF1APJGz5G6mwUmD/aZicBi76GoKeunTeWi+oKIS5lBNA4?=
 =?us-ascii?Q?hzGpB0ALACx9FncyJbANPS5CcrUnn5TtKA2s9i+jQLvJyU65JUAflTagdtDH?=
 =?us-ascii?Q?VNuViaNQiF/o2AL3DCd5IY3AeMepGnILKiITZullm/M5EQBDgpke7eUbGIDO?=
 =?us-ascii?Q?/kDduu/QdVAEbjaC6GiVnr+DqRO8C4REX8FMPZT8r2wZEe7pqMzWqBCWnkKp?=
 =?us-ascii?Q?zvaLlht4Wu7gVLFzRKw2+PC2JZ9hIk/Gq8hPbF9pATaZ+/YDn/vl0FAmLkys?=
 =?us-ascii?Q?zYkafCMcirqQ45UPzXFqbf/K9cUIqDBvdd2L7pOjBSnVEriqJ+wfsxqHa2Hn?=
 =?us-ascii?Q?ihwkHQP0PeJAu24Vj5AS8Lzc48Pt4fCymLn4qBjOZFYK5FBv4Uusf3T4wzps?=
 =?us-ascii?Q?vIevWvIFcpTaOE1y+uqCuJnPk2fcYKEwZAQW17L0qOiowDSfe68FiaC+XqMh?=
 =?us-ascii?Q?8iKhEIc0kCkf9phi8chcINHA+P6RjeDBMs26yIVcLVOuwW+FjMMH+P5IShTk?=
 =?us-ascii?Q?cslXBrVHUxprqWTmdpgDl9eTAUxw7Wp7Cl4d83JIV0mMsH88yEc43NLsvh//?=
 =?us-ascii?Q?z+DsExtmrAdiS5Ik5ZZ3Uw=3D?=
X-Microsoft-Antispam-Message-Info: ZKyzty4RjAwlUEIFHV0fUUPF37fy5n++L1BuKbttv5esaSzvx01wmPILYwx+jRVKE4zeTtl7VziiZswh94WGXHvCB1Keqd4sqhVzmwrF9bO3YwmIlyaAYm3IOGwqAsbnrGpM/JEDN6pXazjf/i3eeR+n0XeCPjQcflbAeSptxUCuV0C7zBQPInlzl9UWZ0F5UbgpMBq5JakXiz5mZ63uFzJwEfESLNqaLdGIkjrxkmfgOb7kyhP7SkezOu+H7p/Fjxh8VCWDE+9aIA7IXn72BCeqWwucSzM6SqCk1kwiEsbOK8LFd68+Mz7NZVOGMC00uQhIuZINw9UB0O76/dLksOwSdgTjSdIox2x9TJvVazg=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4451;6:ee2zzzoVlYizweWF22NfkfJOFRC+u8u2HOGcrcB6d99W3fSm8I6Y8Tq98pohQZdelj01yl9dOb8j3oweIdd0d+bp8W5huYf2+59Z5DSFN95M0ei4AGAes2vl2DePaUdOmkc7xtO7pYfKAF99c9q6SLxK5xZ4FJzP5+Uopb1/6crcG+M1+DMVYZFJXU9APY8T2h60sLKyrtc6q/TOhEKQBNrrzaj3w4dd5Luihiy4D55UwPsReou7nk00lzi/djrCUhxSzEpWUV59LIGVq+7F5I6vZUIB9L2+Q+rZpntDS3KqRuq1NfpEe0eYopqj1IlsST9/AGszEfJqduKglEY+pSrL8jRtYOE1Wo6GEFt91CTNcb/YzPXEvjOzFrAwEKjskJd5OPgGNsLX56Nc0Zr0qtFjGoMbtI2HVPUtOSqw5o1WZ63oMfbQ7h2BNqu8JEVhaJ5mDu3rJ9ckdHQxYW4yMQ==;5:8iXFbmzzCx9otsL/Q9gjLdjmZxSgNcn9zDi9gO3HFhLwdTIqNM0c1hBa5LYgJDzpNas9OMHBevj6vBbMKoHr6mh9wCJnufau5fPPHpiKInqhwAg+V5FINkcgaBZwSguIsoymGLQOzsAHE6TxofJ7OyS47WcVZg7V9KF10n5P8kQ=;7:oCupSIDdID7OvCg9PpKXdJBIN32uGLev1PJRSeFsFgPE1NIuO9xGgRlHHEONw3fmx6Jvbatum0o3qSU8/sL0ilLNAmZRb/Xq3FqhW/An1CbKLuLRxxcsFugaYEMSCdKajV9hD/Zwn1T/AXbcap4B2mfnMF0Kl7S7C05SgsNIZvO8VSHVpiEprlGvqNLNV2ERRkMrWD+dbJGlB6AkfXOoo8Aux1HMw42vBYKlb8QNlGd0Ec3uCpyrKlrGmEUZP2Jo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 08:37:41.9049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe017edd-e75d-4efb-373a-08d6359e22a5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new API to provide access to the
hardware related data like soc revision, IDCODE... etc.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v1:
		-None.

Changes for RFC-V3:
                -corrected typo error in commit msg.

Changes for RFC-v2:
                -New Patch.

 drivers/firmware/xilinx/zynqmp.c     | 24 ++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 84b3fd2..e76c889 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -187,6 +187,29 @@ static int zynqmp_pm_get_api_version(u32 *version)
 }
 
 /**
+ * zynqmp_pm_get_chipid - Get silicon ID registers
+ * @idcode:     IDCODE register
+ * @version:    version register
+ *
+ * Return:      Returns the status of the operation and the idcode and version
+ *              registers in @idcode and @version.
+ */
+static int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!idcode || !version)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	*idcode = ret_payload[1];
+	*version = ret_payload[2];
+
+	return ret;
+}
+
+/**
  * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
  * @version:	Returned version value
  *
@@ -430,6 +453,7 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.get_chipid = zynqmp_pm_get_chipid,
 	.query_data = zynqmp_pm_query_data,
 	.clock_enable = zynqmp_pm_clock_enable,
 	.clock_disable = zynqmp_pm_clock_disable,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 015e130..1d3126d 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_GET_CHIPID = 22,
 	PM_QUERY_DATA = 35,
 	PM_CLOCK_ENABLE,
 	PM_CLOCK_DISABLE,
@@ -89,6 +90,7 @@ struct zynqmp_pm_query_data {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*get_chipid)(u32 *idcode, u32 *version);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
 	int (*clock_disable)(u32 clock_id);
-- 
2.7.4

