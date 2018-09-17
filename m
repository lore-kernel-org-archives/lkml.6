Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E0CECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975B9214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aKTRPW3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975B9214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeIQTMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:12:33 -0400
Received: from mail-sn1nam02on0045.outbound.protection.outlook.com ([104.47.36.45]:21120
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728637AbeIQTMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ3NeCBybdN9/05ncCfixJY8fgpgVOMpej2+0X+NoZM=;
 b=aKTRPW3f0rc9XKJR9WOMt3lPq/WzQbcmt0qVkWpov31+zT5P5xvD7yh+eSf45jNysZyt9TklorO1XDpF1uL/tgjnhKVT/2Cn08FtLOC14R+Db/Yf+zXvYe2cT2P8Rj7dISa9F4RiDfoqd8nQk0G9g1IAaSiuuju3JEMLLJcjHTs=
Received: from MWHPR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:301:74::24) by BYAPR02MB4472.namprd02.prod.outlook.com
 (2603:10b6:a03:10::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Mon, 17 Sep
 2018 13:45:04 +0000
Received: from SN1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by MWHPR0201CA0011.outlook.office365.com
 (2603:10b6:301:74::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.18 via Frontend
 Transport; Mon, 17 Sep 2018 13:45:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT041.mail.protection.outlook.com (10.152.72.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 13:45:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1tpn-0004kP-3Q; Mon, 17 Sep 2018 06:45:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1tph-00057c-W3; Mon, 17 Sep 2018 06:44:58 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HDisqn024422;
        Mon, 17 Sep 2018 06:44:54 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1tpd-00057M-Qq; Mon, 17 Sep 2018 06:44:54 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 0BAFF12142C; Mon, 17 Sep 2018 19:14:53 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 6/6] edac: synopsys: Add Error Injection support for ZynqMP DDRC
Date:   Mon, 17 Sep 2018 19:14:33 +0530
Message-ID: <1537191873-6582-7-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
References: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(2980300002)(438002)(199004)(189003)(5660300001)(316002)(305945005)(6266002)(44832011)(26005)(72206003)(42186006)(2201001)(478600001)(4326008)(103686004)(50226002)(8936002)(8676002)(90966002)(186003)(14444005)(2906002)(106002)(51416003)(76176011)(110136005)(486006)(446003)(476003)(126002)(2616005)(54906003)(16586007)(52956003)(356003)(36386004)(11346002)(426003)(336012)(7049001)(106466001)(63266004)(36756003)(81166006)(81156014)(6666003)(50466002)(47776003)(48376002)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4472;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT041;1:nGRd60wwgAviSf21kNOvK3aFKkWtltmlHC1JLoU9wu/TjwyOXDSfBpTNzg1ZV8MC7FTMAGuCC8uZtxQeL3yUsc+NEbxF8y7Y/hdxYtDjdOH/ncy1kcI9Y9CTe0r5o1/U
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8996f4d-aa74-4451-d9d5-08d61ca3c5a1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4472;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4472;3:xp5K6DUPFtRIJLA0JhjOS0METYmMyvg+soi7ScxbtcUj71v0tTBrcQHCkhniaj/o/N4T2FW6x4EPynReX4XMLTK6ubI7yItYBVfF1ImKVB7+oxxCaw2WTGreWTyzupMMN3Nh9K//0z/0gf+qjsxfCNNA3uEGk3caWDqhrOTzSci9NMHJIs/t9T1KD2PjYQG1jvKH7CSp3aZ5vEd4gFtK8irgYAWb5UdnkkR/U+EEHQHo8zuh2o6Au8WhyFEZS6x+UvIF+74EdbQJcQgL1Wfg5f4qqcboXYr42IoV3iZ+B+FIJ5kQmLh75CYz/QBGFBbYY8aw+l8IttawdwTu5Ss5OtJ3CJ+wsKFlM+w1S4w7Ysk=;25:GPeNoG9M8OU4vD5hXxphJndbvUFVVs+t0+PhyTHc3E6DJPXR6whiislyMW1pPCeuL+t4AZtXaxveQSCKHA8GK6A5ljFOCzmyvPua9kBWyX1/LKO83pZdeP6yaaoSQQ5Bf0r+U0sWvChgEa+sUeOyw+cMr0RVGJa7oGF/aYXpqrUYAC6x89P66qWSsUNgXeZ+nU4JTV4MwgBa9CYg5+eBMPQkXevtfu36hXJUSm+AsJOeJO8jTdbztuAyQHaXskNuFpM9/r+XpLzMSyusNeu03r+D1xceuNp+Bnr3mUmnx23pbgWsC1/10ihJGT6HYwNZVsGvpKANF7obZZ/YXGgjhg==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4472:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4472;31:CiBTOd4FZYiSNB+rnjBf//zbeA321ihnBtO2UpLfluOP/DvG/tJBq2tdSgVmVIbwe1TU4tsVHno4tAM/BsDBvy7CsFp+79XPLJRA4R1vNXwfxERYxLwfUyxKWLC7gbp52OIWU4HWDnaCsmLQRz6II6ApV8IZJYwK1x7gj2ndOo92g4kCG6oHFlb3Ul6YCm1TNDK7CBVK2Hzu+IV7qwQDdZkGv9iNA2zZTg/SWsJE1R8=;20:UMZxon3dVbWNGZKDquZy0FfETXeihFn/vKn4IINvitkeqplHhoJVnWFSpE5jjv33B/L9kdZLT6x4pFjJhzXfOBNziZyBDhPQq5E2r3XdZP5/uw9XqPz7dJedqTg+nAtywVMhJLu1XKUwIlmeITZFygsUDl6iWMUkti6mvT9ekkIdK5dII7401/w3/7mJHSr/9ykLOFf5S8KTn2ycfdut3jj2DzehHA8U/urfEVh2ZFh3KZlBkeIovzcgio2Sq4lL6Y1De6QK76fwlJMfoJSQhjq4phshS2shj8WP0PYJK5bpllbERTEB5QXQRqcaAlGaXxd+iZ+Ge4nUCZUniu56ijf/AEp+pBnmi6kbDcOInrC1fTYtQTf9DW+tlR9IFgQp5tjCc28FizJa6yQB2jHc1DAsGmnLX5m2ggFT0h+V0Oc4gJ7ELedZPTf5cQgwDwUPt8tNmCKthafclVZDmkFOFrQIJfOVVTG/Nzfzp8M7IDvyf607oIp9nZlDuIWv1Y4r
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4472E14A3F31B620126360E1C11E0@BYAPR02MB4472.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:BYAPR02MB4472;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4472;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4472;4:iGbg7vGq3e/m3HXVfM1VwJVn8DYitHomLV/Uz3kCIgk063/tdVsEsSlU6hXn59/SefSZj6hJO4gb9I85xxAM1vpozr9NYi68BmAcgSpTM2goxFoZfG5SZlFYwKRo7v2c+8eoHd2cEhMaxnSsOeBcmu6gqhc2gvsddJAmM1VwLEoCAFhsW3xfmrpQW9mvrDEKPgTUsxReUEbXpp+hTMdM+FT4V1BUYYeWTw/7r9a/XHAdbJFOdFkm9+TDH6Hb+AC/GtKUevuxy8zV5BWEUZYYSQl4ZaKH+7LjMPQfIlwtv5jWrrkY3DMCL+XMIOYadwpFNlIUWW7GAQ4EG6DMN2phG8mxaDB8uxN0F4d4EKYO44U=
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4472;23:ygWMef6Td9aIrA3i9n1GBBht+WlwTAvC0Opvq4B4S?=
 =?us-ascii?Q?NXyDwnmeVi4wTpGTt6jH+e5oQE4GE6ABiLrJ/E2RVpmnYJ8Mwl1X/CkJjVnu?=
 =?us-ascii?Q?ysMMdOnQV3L4svq75Z26VmEFAReM+dcjgTHM9O1T4yBYK21Jyvd4r8+SEtgF?=
 =?us-ascii?Q?9CmRBOAMC4fMFltILOcrG9nFso6t2UK5D6WZVr+I4vYnaOfydYINMSioa4u1?=
 =?us-ascii?Q?+ZfSktCSnQC0po3czGum1n9KrABj4BWcAqFjk8tVYfup4cRgsvsFoXOboIQ5?=
 =?us-ascii?Q?VVE4Uwisp5JraW9c8Ka32GjuTQwHoLHxSF6unK1kkNhb4jV3SRhMlmE6LlwW?=
 =?us-ascii?Q?e52VYd9FJI308Pd6KDQQQY0G4zat3AK4vSMtHnMjDGnI2Odmc9BcYGTjWHPS?=
 =?us-ascii?Q?GhnfMks4Fk47XllIQNlkjsjShj7mb9l37J/Ax8ZhGNceKn7coDuFWxV46sTm?=
 =?us-ascii?Q?3d0ZgE3HMW6A9jSP0Yo2KikVwU9gEyI5zKm4UDAmta7ljzBIbuiMrjc/XZR1?=
 =?us-ascii?Q?3IWHhmT5g0vXulncAx2BWDi3hdktantQPZPSbblDy34GL3LX3pzWALUav+A2?=
 =?us-ascii?Q?+fnUXlCAWCgHISO8fd1bgMykm+4JHi0pGNZWSfz/YlXHCWizeww+IgrD+mtX?=
 =?us-ascii?Q?c99rHB6qNeDu1vhrhTpItcK65PFCqNUK04DiNIA5J+CZwRAtVaRPLRRwEshs?=
 =?us-ascii?Q?GK+RuQswEUHbyciqEKnhjHIhSVvz3rSyQQBBQhpvAKjHXNMGq4IqWKzHdPTr?=
 =?us-ascii?Q?KLwfO5BjT+3M/DnTIAkeHsYLrsgDBVLhnWQ1rICG18JcPtHLUHcHGQmoDymg?=
 =?us-ascii?Q?H4W2nqQRHMTD5uabTPVqn9NSJxlj1oepLkTnXqId9/Vx6FKnXbaogwXOYSip?=
 =?us-ascii?Q?J+wLBaeBo1YP8Gdl0P+/VnPYx+M+xWIH9Vmj8tqS3hlArmvyoz0MlKzWfE+z?=
 =?us-ascii?Q?6SWdiZMkm0BrcPKEH+6iQuq4R206/bAkEA85VbnKYfkbt9kV1Yw+MC9M8HeB?=
 =?us-ascii?Q?u5D2MrxRD3ry5hvYFQloy1nI3k177NKnvssW06QjmCGoprYmRgB2X3awdQ1u?=
 =?us-ascii?Q?egtw9cpM0uoxKmqvlX2nffvZLeXm1go5mtnnkcBsYosYNeIKVsFQ+tGaIMN8?=
 =?us-ascii?Q?yFs1yOmSuExDqSoxOJqnEpfPQHLZoE+luHFGTZW7ObXD44823TPWGoxYpzVs?=
 =?us-ascii?Q?BFY7jtM49AwwmrdsRzYgGA4xN/kOItWDzIQLlZGZ1o1Worb4uv1+u6TTy9F4?=
 =?us-ascii?Q?Zyy6gVLSgcgtftDAnU=3D?=
X-Microsoft-Antispam-Message-Info: d7UxhtqC4k8t1LRJZxgN46Ec/nJ2JVQuagBEwRgQXd/bhgumJHWX7FNRcuUcGYlDXtaJeGhjfkvDgGvY5b/7fVkYFueuLko/cw4QpZAYk0cKu/5fwloMOBI5lvWr7UZrNPzPOsQMyCElaQeWMnFNLnxAD+idmH5hXe6xfuEXrahGwsBdC6ZrEevnrigfz+225ndhFMiYrW6sDLIg/zLWmxrNbtgFyza1s7v57qRQrjNjqml275SBoMfSKPZ3CkRLJfyg4kezxe5gWtO2YBxnwAyPU2Vs5+e9y+gjIoCFoWb1doQNP4FXbqXSdb4toeCE+uIIuQA8fFhjer/PDYl+ZQVRfLBApN9RhuXBZSWM/VI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4472;6:iCyDFRB9CjIPhkT6T3PFhKPxZLlRqBDy9m5fyISvA2N9P529GVvrrPnPArc2JlMTAuzSly97RTxLoolyCh6dcbNe2cNzqJZ2RH5to1rYnrwvIqNzeSlO5djdaipxjBSIZJc9JuyXI4QsVPvBmjC/sXsaf38M1X44H7j7iHvIG4FQ8ZHrOvvJPzqiKwhBw4x8EZ077GMqZzpGU70YP04JEIJHRZtNOdX46jYxtNRceicLpJfFwLvpsWueO6vTqIS1lI6pcmwB/UnSs6NmCi/2LUOTICNkF5ymex+Y8bixAs2y6Sd8OBqD1WUp4fenbXJyTU2hT8KwCFSXH50cCsByo85Lb4K8poAb78WLt8RyEHVuRr2r9JeTe6JAHHDAtOCX+Nt7thFOd380b9Ue3IlknwSUExf74s7VpGTNEq/JnLWfQoHQgVVaxUkMcocQ5e9Q9zwH0yoUNDE0G0cAQg6fGg==;5:wiPZV5NyWe2T1wwwfYeHDW1RoezwtMtdrspkl0D2ewGFymjnSrywDlQl2Ayn0tpNPAhyl0Ra1WKsf2kCv/DRptYpIMvmSP+Lw9aAdRyj2qTbwWXkC/niQbgCrsHqiA2vWKFD+a4Ix9P5afwoc+qnZQRcwNZAlhritDccVXPqwcs=;7:Rbz91ogC9f44+SHy635s5nBweR78c6uH5eSRSt217/CZsAN5TuVw1UvlC8M2pfC/HpSJieIl28+/q6AhaZHrwH9f8q5cSeprRZrYrq8xm9Sse2DnGD+i0JvjDDYdX6AJDupePMJjuAJJn9zeslbt6tVkNqSk8XzmSYEgc5IVQUZ2gcMbqk0dOy339AVi6FiQEZxCxQIb919e18yfurZN0K1Oz7rPj1zKLZBRH4UYwZRSYWomyhP8F2oh6WOcYQNN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 13:45:03.5625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8996f4d-aa74-4451-d9d5-08d61ca3c5a1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Error Injection for ZynqMP DDRC IP. For injecting
errors, the Row, Column, Bank, Bank Group and Rank bits positions are
determined via Address Map registers of Synopsys DDRC.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 423 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 417 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 7ab5b9a..177b5c3 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -302,12 +302,18 @@ struct synps_ecc_status {
 
 /**
  * struct synps_edac_priv - DDR memory controller private instance data.
- * @baseaddr:	Base address of the DDR controller.
- * @message:	Buffer for framing the event specific info.
- * @stat:	ECC status information.
- * @p_data:	Platform data
- * @ce_cnt:	Correctable Error count.
- * @ue_cnt:	Uncorrectable Error count.
+ * @baseaddr:		Base address of the DDR controller.
+ * @message:		Buffer for framing the event specific info.
+ * @stat:		ECC status information.
+ * @p_data:		Platform data
+ * @ce_cnt:		Correctable Error count.
+ * @ue_cnt:		Uncorrectable Error count.
+ * @poison_addr:	Data poison address.
+ * @row_shift:		Bit shifts for row bit.
+ * @col_shift:		Bit shifts for column bit.
+ * @bank_shift:		Bit shifts for bank bit.
+ * @bankgrp_shift:	Bit shifts for bank group bit.
+ * @rank_shift:		Bit shifts for rank bit.
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
@@ -316,6 +322,14 @@ struct synps_edac_priv {
 	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
+#ifdef CONFIG_EDAC_DEBUG
+	ulong poison_addr;
+	u32 row_shift[18];
+	u32 col_shift[14];
+	u32 bank_shift[3];
+	u32 bankgrp_shift[2];
+	u32 rank_shift[1];
+#endif
 };
 
 /**
@@ -842,7 +856,12 @@ static const struct synps_platform_data zynqmp_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_eccstate	= zynqmp_get_eccstate,
+#ifdef CONFIG_EDAC_DEBUG
+	.quirks		= (DDR_ECC_INTR_SUPPORT |
+			   DDR_ECC_DATA_POISON_SUPPORT),
+#else
 	.quirks		= DDR_ECC_INTR_SUPPORT,
+#endif
 };
 
 static const struct of_device_id synps_edac_match[] = {
@@ -861,6 +880,380 @@ static const struct of_device_id synps_edac_match[] = {
 
 MODULE_DEVICE_TABLE(of, synps_edac_match);
 
+#ifdef CONFIG_EDAC_DEBUG
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+/**
+ * ddr_poison_setup -	Update poison registers.
+ * @priv:		DDR memory controller private instance data.
+ *
+ * Update poison registers as per DDR mapping.
+ * Return: none.
+ */
+static void ddr_poison_setup(struct synps_edac_priv *priv)
+{
+	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
+	int index;
+	ulong hif_addr = 0;
+
+	hif_addr = priv->poison_addr >> 3;
+
+	for (index = 0; index < DDR_MAX_ROW_SHIFT; index++) {
+		if (priv->row_shift[index])
+			row |= (((hif_addr >> priv->row_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_COL_SHIFT; index++) {
+		if (priv->col_shift[index] || index < 3)
+			col |= (((hif_addr >> priv->col_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANK_SHIFT; index++) {
+		if (priv->bank_shift[index])
+			bank |= (((hif_addr >> priv->bank_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANKGRP_SHIFT; index++) {
+		if (priv->bankgrp_shift[index])
+			bankgrp |= (((hif_addr >> priv->bankgrp_shift[index])
+						& BIT(0)) << index);
+		else
+			break;
+	}
+
+	if (priv->rank_shift[0])
+		rank = (hif_addr >> priv->rank_shift[0]) & BIT(0);
+
+	regval = (rank << ECC_POISON0_RANK_SHIFT) & ECC_POISON0_RANK_MASK;
+	regval |= (col << ECC_POISON0_COLUMN_SHIFT) & ECC_POISON0_COLUMN_MASK;
+	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
+
+	regval = (bankgrp << ECC_POISON1_BG_SHIFT) & ECC_POISON1_BG_MASK;
+	regval |= (bank << ECC_POISON1_BANKNR_SHIFT) & ECC_POISON1_BANKNR_MASK;
+	regval |= (row << ECC_POISON1_ROW_SHIFT) & ECC_POISON1_ROW_MASK;
+	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
+}
+
+static ssize_t inject_data_error_show(struct device *dev,
+				      struct device_attribute *mattr,
+				      char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Poison0 Addr: 0x%08x\n\rPoison1 Addr: 0x%08x\n\r"
+			"Error injection Address: 0x%lx\n\r",
+			readl(priv->baseaddr + ECC_POISON0_OFST),
+			readl(priv->baseaddr + ECC_POISON1_OFST),
+			priv->poison_addr);
+}
+
+static ssize_t inject_data_error_store(struct device *dev,
+				       struct device_attribute *mattr,
+				       const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	if (kstrtoul(data, 0, &priv->poison_addr))
+		return -EINVAL;
+
+	ddr_poison_setup(priv);
+
+	return count;
+}
+
+static ssize_t inject_data_poison_show(struct device *dev,
+				       struct device_attribute *mattr,
+				       char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Data Poisoning: %s\n\r",
+			(((readl(priv->baseaddr + ECC_CFG1_OFST)) & 0x3) == 0x3)
+			? ("Correctable Error") : ("UnCorrectable Error"));
+}
+
+static ssize_t inject_data_poison_store(struct device *dev,
+					struct device_attribute *mattr,
+					const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	writel(0, priv->baseaddr + DDRC_SWCTL);
+	if (strncmp(data, "CE", 2) == 0)
+		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	else
+		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	writel(1, priv->baseaddr + DDRC_SWCTL);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(inject_data_error);
+static DEVICE_ATTR_RW(inject_data_poison);
+
+static int synps_edac_create_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	int rc;
+
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_error);
+	if (rc < 0)
+		return rc;
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_poison);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+static void synps_edac_remove_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	device_remove_file(&mci->dev, &dev_attr_inject_data_error);
+	device_remove_file(&mci->dev, &dev_attr_inject_data_poison);
+}
+
+static void setup_row_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	u32 addrmap_row_b2_10;
+	int index;
+
+	priv->row_shift[0] = (addrmap[5] & ROW_MAX_VAL_MASK) + ROW_B0_BASE;
+	priv->row_shift[1] = ((addrmap[5] >> 8) &
+			ROW_MAX_VAL_MASK) + ROW_B1_BASE;
+
+	addrmap_row_b2_10 = (addrmap[5] >> 16) & ROW_MAX_VAL_MASK;
+	if (addrmap_row_b2_10 != ROW_MAX_VAL_MASK) {
+		for (index = 2; index < 11; index++)
+			priv->row_shift[index] = addrmap_row_b2_10 +
+				index + ROW_B0_BASE;
+
+	} else {
+		priv->row_shift[2] = (addrmap[9] &
+				ROW_MAX_VAL_MASK) + ROW_B2_BASE;
+		priv->row_shift[3] = ((addrmap[9] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B3_BASE;
+		priv->row_shift[4] = ((addrmap[9] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B4_BASE;
+		priv->row_shift[5] = ((addrmap[9] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B5_BASE;
+		priv->row_shift[6] = (addrmap[10] &
+				ROW_MAX_VAL_MASK) + ROW_B6_BASE;
+		priv->row_shift[7] = ((addrmap[10] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B7_BASE;
+		priv->row_shift[8] = ((addrmap[10] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B8_BASE;
+		priv->row_shift[9] = ((addrmap[10] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B9_BASE;
+		priv->row_shift[10] = (addrmap[11] &
+				ROW_MAX_VAL_MASK) + ROW_B10_BASE;
+	}
+
+	priv->row_shift[11] = (((addrmap[5] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[5] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B11_BASE);
+	priv->row_shift[12] = ((addrmap[6] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[6] &
+				ROW_MAX_VAL_MASK) + ROW_B12_BASE);
+	priv->row_shift[13] = (((addrmap[6] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B13_BASE);
+	priv->row_shift[14] = (((addrmap[6] >> 16) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B14_BASE);
+	priv->row_shift[15] = (((addrmap[6] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B15_BASE);
+	priv->row_shift[16] = ((addrmap[7] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[7] &
+				ROW_MAX_VAL_MASK) + ROW_B16_BASE);
+	priv->row_shift[17] = (((addrmap[7] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[7] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B17_BASE);
+}
+
+static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	u32 width, memtype;
+	int index;
+
+	memtype = readl(priv->baseaddr + CTRL_OFST);
+	width = (memtype & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+
+	priv->col_shift[0] = 0;
+	priv->col_shift[1] = 1;
+	priv->col_shift[2] = (addrmap[2] & COL_MAX_VAL_MASK) + COL_B2_BASE;
+	priv->col_shift[3] = ((addrmap[2] >> 8) &
+			COL_MAX_VAL_MASK) + COL_B3_BASE;
+	priv->col_shift[4] = (((addrmap[2] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B4_BASE);
+	priv->col_shift[5] = (((addrmap[2] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B5_BASE);
+	priv->col_shift[6] = ((addrmap[3] & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : ((addrmap[3] &
+					COL_MAX_VAL_MASK) + COL_B6_BASE);
+	priv->col_shift[7] = (((addrmap[3] >> 8) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 8) &
+					COL_MAX_VAL_MASK) + COL_B7_BASE);
+	priv->col_shift[8] = (((addrmap[3] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B8_BASE);
+	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B9_BASE);
+	if (width == DDRCTL_EWDTH_64) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[11] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		} else {
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[13] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		}
+	} else if (width == DDRCTL_EWDTH_32) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		}
+	} else {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[13] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+		}
+	}
+
+	if (width) {
+		for (index = 9; index > width; index--) {
+			priv->col_shift[index] = priv->col_shift[index - width];
+			priv->col_shift[index - width] = 0;
+		}
+	}
+
+}
+
+static void setup_bank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->bank_shift[0] = (addrmap[1] & BANK_MAX_VAL_MASK) + BANK_B0_BASE;
+	priv->bank_shift[1] = ((addrmap[1] >> 8) &
+				BANK_MAX_VAL_MASK) + BANK_B1_BASE;
+	priv->bank_shift[2] = (((addrmap[1] >> 16) &
+				BANK_MAX_VAL_MASK) == BANK_MAX_VAL_MASK) ? 0 :
+				(((addrmap[1] >> 16) & BANK_MAX_VAL_MASK) +
+				 BANK_B2_BASE);
+
+}
+
+static void setup_bg_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->bankgrp_shift[0] = (addrmap[8] &
+				BANKGRP_MAX_VAL_MASK) + BANKGRP_B0_BASE;
+	priv->bankgrp_shift[1] = (((addrmap[8] >> 8) & BANKGRP_MAX_VAL_MASK) ==
+				BANKGRP_MAX_VAL_MASK) ? 0 : (((addrmap[8] >> 8)
+				& BANKGRP_MAX_VAL_MASK) + BANKGRP_B1_BASE);
+
+}
+
+static void setup_rank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
+				RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
+				RANK_MAX_VAL_MASK) + RANK_B0_BASE);
+}
+
+/**
+ * setup_address_map -	Set Address Map by querying ADDRMAP registers.
+ * @priv:		DDR memory controller private instance data.
+ *
+ * Set Address Map by querying ADDRMAP registers.
+ *
+ * Return: none.
+ */
+static void setup_address_map(struct synps_edac_priv *priv)
+{
+	u32 addrmap[12];
+	int index;
+
+	for (index = 0; index < 12; index++) {
+		u32 addrmap_offset;
+
+		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
+		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
+	}
+
+	/* Set Row Address Map */
+	setup_row_address_map(priv, addrmap);
+
+	/* Set Column Address Map */
+	setup_column_address_map(priv, addrmap);
+
+	/* Set Bank Address Map */
+	setup_bank_address_map(priv, addrmap);
+
+	/* Set Bank Group Address Map */
+	setup_bg_address_map(priv, addrmap);
+
+	/* Set Rank Address Map */
+	setup_rank_address_map(priv, addrmap);
+}
+#endif /* CONFIG_EDAC_DEBUG */
+
 /**
  * synps_edac_mc_probe - Check controller and bind driver.
  * @pdev:	platform_device struct.
@@ -941,6 +1334,20 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
+#ifdef CONFIG_EDAC_DEBUG
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
+		if (synps_edac_create_sysfs_attributes(mci)) {
+			edac_printk(KERN_ERR, EDAC_MC,
+					"Failed to create sysfs entries\n");
+			goto free_edac_mc;
+		}
+	}
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "xlnx,zynqmp-ddrc-2.40a"))
+		setup_address_map(priv);
+#endif
+
 	/*
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
@@ -972,6 +1379,10 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
 		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
 			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 	edac_mc_del_mc(&pdev->dev);
+#ifdef CONFIG_EDAC_DEBUG
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT)
+		synps_edac_remove_sysfs_attributes(mci);
+#endif
 	edac_mc_free(mci);
 
 	return 0;
-- 
2.1.1

