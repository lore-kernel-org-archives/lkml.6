Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23695C64E93
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AC020671
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LhmtVMKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AC020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeI2EoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:44:24 -0400
Received: from mail-sn1nam01on0088.outbound.protection.outlook.com ([104.47.32.88]:61216
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbeI2EoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIRqxjIqSZw8fklunWqz4Itoz5gMdqn0SGQ/qU+mi0c=;
 b=LhmtVMKvGa9kzg+IemD7y5qAdDosjHCCzCkcjZ2dte9HsRWQfLubOlZ5smY4SY6lJXF/vF8VRvMdihgRBIcJO9IowTeliVGzNZI/14LpkGcESyi2lFlXl4QGTXp2t90Wl62DaOefaQigjr/CAKw6x44edGkOpz4uSZnxFgDMC28=
Received: from DM6PR02CA0036.namprd02.prod.outlook.com (2603:10b6:5:1c::49) by
 BL0PR02MB4755.namprd02.prod.outlook.com (2603:10b6:208:5d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 22:18:26 +0000
Received: from BL2NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM6PR02CA0036.outlook.office365.com
 (2603:10b6:5:1c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1185.23 via Frontend
 Transport; Fri, 28 Sep 2018 22:18:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT045.mail.protection.outlook.com (10.152.77.16) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Fri, 28 Sep 2018 22:18:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g615d-0008Lg-MD; Fri, 28 Sep 2018 15:18:25 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g615Y-0005vP-Hm; Fri, 28 Sep 2018 15:18:20 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8SMIGXi021007;
        Fri, 28 Sep 2018 15:18:16 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g615U-0005ux-Ap; Fri, 28 Sep 2018 15:18:16 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v5 1/4] Documentation: xilinx: Add documentation for eemi APIs
Date:   Fri, 28 Sep 2018 15:17:57 -0700
Message-ID: <1538173080-7597-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538173080-7597-1-git-send-email-jollys@xilinx.com>
References: <1538173080-7597-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(2980300002)(438002)(189003)(199004)(47776003)(5660300001)(34290500001)(305945005)(356003)(106466001)(6666003)(6306002)(36386004)(2906002)(63266004)(2201001)(77096007)(7696005)(478600001)(81156014)(72206003)(9786002)(48376002)(966005)(8676002)(2616005)(476003)(186003)(11346002)(76176011)(336012)(426003)(51416003)(81166006)(126002)(316002)(16586007)(36756003)(26005)(54906003)(110136005)(44832011)(50466002)(8936002)(4326008)(50226002)(486006)(107886003)(446003)(106002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4755;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT045;1:L2Pb+m/aBZU4CMgD23cucdnImQAhzoUf7ZfdPocQ93kQziSHC+cGRM/6X08HuEZQh7YwgP7VQnL0nWp3JXtNjOGTs5UpfWUNW1ielqHkTt32pDWf3DHP+GOO4GTT1Vbf
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67177ff9-5774-4db7-1e51-08d625904fe4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4755;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4755;3:A1h1GOd5IyNdFMwbZvCHBf0sscnxr3MuySYmrVUihASU7HtHGe7BWhQ2W0a6k/M49ZIKX0b7U3F7Et+04nN/34Sdwy6YjlwtGYM+mbYLDLMvJsLlKxyr1VBnpeuowB00jYKixqNK/MbU0sU+roabmXERcMEFuPiKQhtyttaAhdMV9SSZp4JWVcd5ggybSiLRwIk9QL/qUeLP5GIyioG/1+rJQbExNo/Fuky89KqHS1jtKcU8GBc9LrNk29F9dgASvJJkirRJW179/7eu4X3k2hgSbOXI2nBr87FnA59W7BTNfe/hhEP/PbBqiSqyIDhYh3kV+VronR9k9UjtL5k8UFOwRK26CIZBoq3LfbVBz5s=;25:htYqmDcaCm2pX0YHG4zl2yQEO6xxxact1oKEHTIe9H7hxJnjBrWzOfhh5gUC0MAcUS0J6pGVypzzEyO2LdwdWssTMoZ3Os93f9oF+gly3ftfQ3cOVNKLbUt48GBYXUbLUZ+4nV+m+4g0I90aFzBrwyGRRR9HN7iBySgufjTtzNQe1X3T2+OlEOSV/hu4sLc47XMenvVZ0yv8vLyifzxBiyoTF/jLbV0Tg+ttpGuS87MKRZDW0kvVehZcZ6EGEXwDz0/pfto4XBBz9FfM+gsZC9oVGUV8iJ+TOPToG54LdumbeNuIHLZM0NxXFm4/hvOoTfHeNOkDO7TUQel6nNkkTw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4755:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4755;31:GDq/cjXhmR5ZhuY1tgJOrfTjwN14OFJhi9JMd2hhRG6RVcDgkk8sYXSnQPF7agIvTsBACAZvm9MBO5x5woqp811s2pV8Gtbckxfk2TPMy4HoW4XNl3PjDJGQhORiUx75f3i7qdAy8DYeNg5nLmslt+uK7yuupKCMBRH/9b2WYkX5mCTXNepemptpVLBuSiVU/bi/F5F/RFjDUP3MFdMcAyUlaJ/rY9dymbe5ezZNsbM=;20:3q0AivxPbtVB+o7MTSxGLgpgqlFGrRXz7m6BD/ANU0G/5tSr57C7h7mUZIxaxNXWYWO6g32iNyJQ8nL8LRmH9AZ+qtIJzvDqpVwhD6t2ZvXReAZUCTCPzIGl8X8TRUJtycZ19VXs1EKF1VUjPhQFB4SyC2KeSoqRIS/G76FHrpRwfa/446M0vkmi6tahDA4g+8Kijyj6CfsmMfz3NpPNVfqaZ1GPNrBxsWKuhyRV2eYev752ROMICtC8nDkTG2fQaqpJBOo9NNl9XLEHX3XTbCqtPqsvVKC/XCZDEh3xVwyG4Lzx2mxLpVoNhQKvZbY0gc5HAk0LJ2SnEFmf9Gfbw6mqp/qHWM5S/VBvoEBMGg5ENXssrOF8pgfjTLim3CWVa50OpIqbIsy4AqnsnuB1GY7t3YNKs8f1LbqZliRpGuKlXeIqJzsFUkQ/DBq+FYYGGaz2WMy2kMpVNjoPOC/mm9MAo/Cvy6DcTaGqN5wRZ6+lga+15AYxzcNEHSjZ4nx1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4755423DF5F2FD36F0DEE0BCB8EC0@BL0PR02MB4755.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:BL0PR02MB4755;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4755;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4755;4:6s+FS59XYY2jM3BtIH2iF5HatRyKu29uppy/R5+gXxKCDdIa3khkA5Sj0r47bZHiPNPTgoincul6ao4fXGhzz/oHbRFEaLOUrr6y0Ru2zVIT/wzQPQdGq8aRqIyE8lZDRJlXmkWQccD8Bpng+/23NqkCWx+wjqT1EDmUz6TIAt6ZtjhnbDn25WkbAIPPdMfGQar7BaQjpClELloMjX002jbem2liw5F/GJJIsDaYOOLDSMmHViCLTMei/6TQ+pJxHWrFMvaaTevuugtyMmEbBWNxJkTfM5iVuBsTkmXjHps0GMIDBfBAjbrXT/Bslt1fWwK3LTd6iF0uARqYW8c/ykxubasYos+BOnSxgrmJ47U=
X-Forefront-PRVS: 0809C12563
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4755;23:15rax+0rfB+UcqLAaXerdgwZe27YnzNkQ6CICu1px?=
 =?us-ascii?Q?26se18tNi9nZ6fLDVjs8Uee6RZ4iA988NtkAYl6IGSdEj8YqvUgktezh3GjG?=
 =?us-ascii?Q?aXUu9ldS8cJ0uhcZpr8qIHQXV7i7V/hL1sWe+8J7Utvm59pmlX/Wmtv7oOpx?=
 =?us-ascii?Q?DuRdMMjxjYhDh6gfEgHzf3EE8MOGXPM3d63K838NK1J2Mj8kx/O4Xmp5E3BO?=
 =?us-ascii?Q?yxIVS/KlKzejLsG06mqfW4fXkOFP0twl4uftW6Ue14PUdbdsvyQfy8uXfCWA?=
 =?us-ascii?Q?o7k8SgU8LgXjHfW0/lpxstmGQwUzIG6fsZNRqUc//O7sRzTvnrZ2L3uzbbV2?=
 =?us-ascii?Q?gtFiQA6l6R3JfyHyoUbmFcq2Wik+ywzV3F13RoBREj4bOKjBRqGiZOfMA6sA?=
 =?us-ascii?Q?T5N5yS4x+krRnHnU6OlBxMqKMp22d0Rb/cFEyc62kx0k2WzMSC3kuB3CGVjl?=
 =?us-ascii?Q?ivCPkeennvsg8juMHx7bJt7kxFltW6YL03oLuX8Zy4FcoRWyaD6aiddmaXut?=
 =?us-ascii?Q?dA5yvLdOTWU8Y3+7M9VbgQ1LDzQDHY4RVs5diIKfn6dwxPdta3NYAc3OHJqu?=
 =?us-ascii?Q?EGKBq5svgDDxIacYezNmaq1miDD4jaRbN6sNWiBMdl4MKWw0um1L3GerFX70?=
 =?us-ascii?Q?YMld7pZc4LVinpW+VX3c3IEv8FZRr6s9xtQ1F6I0jSxUVmd6/4pheL94Eqju?=
 =?us-ascii?Q?KqZUHL6oy9Uky3N0IP2P2X8XMKXg8buRcI0DzmkexKBwsW015YMHMlNbNrbU?=
 =?us-ascii?Q?XcrO+F7I7KlcqNJnJoRXCHOb2h8TNePaj5ZYd6k3JZe7cuETbfVuM1rXpxd1?=
 =?us-ascii?Q?fHBrFs/PJCasRsOF2UJbmpChJSJT5sA5yd7Tgidkog4v2SlXgGSID1eUuoL+?=
 =?us-ascii?Q?KYJfn5HoDT/QAPklh7duVRyfoPx3nTsXnsnhxosBU1nZWYXfi5YHH0PHmuDr?=
 =?us-ascii?Q?TdtJ3+E/t1s/nbanyPc/ZC/EnUxuGWjA2seGVMUssMW9Plnl4/Ci8YWTABVg?=
 =?us-ascii?Q?fEEMK/Vtj7LLEwxbV/zV/hA5CDyqaqBJbME4dYb0W9IB5ntS/YTpqvjjMr24?=
 =?us-ascii?Q?LU5E0DmtyYLqxPU8bMnilg9/7rtENR32ueLJRs+fOKUcFgSI+kiru1/T+Qau?=
 =?us-ascii?Q?yKpHayXEFuViRaKl1OBPYN4wdc/wsrLWnON19KRS1Qft5pqKAijApR/bC57s?=
 =?us-ascii?Q?gIJ4906tY3s4olq0MKaamyiLu+ijNjL0FwfsXwM0E9P4lv/duNs8qrZiw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: zrgGU3lmCFke46sHrpvzjqdXC3uvI5TaaRq8W7CZqdoa+M9Ms88S4WqyVTPLdrbCCXBTchD0Efqo005Z99Ho+H4Gp2rnjVqQHB9YmvSejyDY3/Nm9xjD1fZznXh6eNi4ijkhgoqTqy0qvi6V6QVihDvZLMY2h+8oyr4T8ic3LtyZUeSrEZMlBdYC42hGXXIhyv3LIHIylLGlDEqxbJPgLNIrPhII32ooNYZK8ZY7Edo1cmxlRDeEVPmvscNw50xwhZZjw64YpG2LwRgXDypzjry/+idXQKldjr9SnYMstHvUc3kIPCkuXg45hzi1kqpxaA6MvPqPdc2umhAdG1febqYfcCLAXbqilVDpFhHh95I=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4755;6:LBb7V9zZzEp1WGKN0OskIkOvZxSGWX8ufpC7OWcMMgLzYc49pHT222KFijwUd/dVHZUBJMmkHjT5f6bC1ZRdySgkSThRabgxjSagjG4v/ZL+Yoqh905whecowAKtxn8GYa2L+Vz79L8umR3WzxISh3+100fE06YRWIdUKzE/JCo2qVsHOJPGw0ChvVTJ9B38vMJysUde6mAIcOqs+E+v+XTd7hnfJXkOkLs0L0kIIN1kjZcI8qd1ulJQdozA6oO+tlflYHZdhmsgxF5zvcy5eP7uVcLw8DZz0K3icVYhgkDdqKMcTl+If6oSVA+I9d9xf2t/res5SNLDUISh9ikamiiddNhYv52qNQ0mgaPx0kqtlFZabwngkNzbglkHBaqyPrg3HU/jwN7zoIYRTzYeRO2iSzLsF3qvDoCvNlTZn4k3EPyPIyxp3Or4i68i9zj358ik2b+Q9Kv74LKwEMkMmQ==;5:RW7V4bXSD4Sq31lBJTx/YyeoHlbDtx7NoZMcEhFlfugZxsI13k5vVO/1y9h+SC/TaEuNncwIiOkMkabDuYvCansiA7vrKlCVRKUmFpwyszXMImIWeB6nTj2IAij3EQkikkxPuEdj1OmennyzQxSFT1Dn6zdZnvxRmd5ygfQsxyY=;7:lvELMWU+IDpToI0dyb/IJMbSk1cy63ASDcYBfQlFv4IZdOwIKpRl2BKbarkzI4hbj8IGZRundB+BHHVQnbIXA/yytFONajU04LRaViecotQ2IYpo16MawrLE4XlQePZ0lo5pMwS6u6VmGjJGBb673eDnhu+LeCKrLjr5AAA9oOXWpFSKt50WF2YQpduVImaTL+RVPlQaIYz902FL9o0P8k+R5QKQ10UxaDS1imVf5t7L0K6jMn0N7W40E78L62rm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 22:18:26.2872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67177ff9-5774-4db7-1e51-08d625904fe4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation for embedded energy management interface (EEMI)
APIs. It includes information about eemi ops and how to use them.
It also includes API information and supported IOCTL IDs which can
be used for device and control configuration.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 Documentation/xilinx/eemi.txt | 67 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/xilinx/eemi.txt

diff --git a/Documentation/xilinx/eemi.txt b/Documentation/xilinx/eemi.txt
new file mode 100644
index 0000000..0ab686c
--- /dev/null
+++ b/Documentation/xilinx/eemi.txt
@@ -0,0 +1,67 @@
+---------------------------------------------------------------------
+Xilinx Zynq MPSoC EEMI Documentation
+---------------------------------------------------------------------
+
+Xilinx Zynq MPSoC Firmware Interface
+-------------------------------------
+The zynqmp-firmware node describes the interface to platform firmware.
+ZynqMP has an interface to communicate with secure firmware. Firmware
+driver provides an interface to firmware APIs. Interface APIs can be
+used by any driver to communicate with PMC(Platform Management Controller).
+
+Embedded Energy Management Interface (EEMI)
+----------------------------------------------
+The embedded energy management interface is used to allow software
+components running across different processing clusters on a chip or
+device to communicate with a power management controller (PMC) on a
+device to issue or respond to power management requests.
+
+EEMI ops is a structure containing all eemi APIs supported by Zynq MPSoC.
+The zynqmp-firmware driver maintain all EEMI APIs in zynqmp_eemi_ops
+structure. Any driver who want to communicate with PMC using EEMI APIs
+can call zynqmp_pm_get_eemi_ops().
+
+Example of EEMI ops:
+
+	/* zynqmp-firmware driver maintain all EEMI APIs */
+	struct zynqmp_eemi_ops {
+		int (*get_api_version)(u32 *version);
+		int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
+	};
+
+	static const struct zynqmp_eemi_ops eemi_ops = {
+		.get_api_version = zynqmp_pm_get_api_version,
+		.query_data = zynqmp_pm_query_data,
+	};
+
+Example of EEMI ops usage:
+
+	static const struct zynqmp_eemi_ops *eemi_ops;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (!eemi_ops)
+		return -ENXIO;
+
+	ret = eemi_ops->query_data(qdata, ret_payload);
+
+IOCTL
+------
+IOCTL API is for device control and configuration. It is not a system
+IOCTL but it is an EEMI API. This API can be used by master to control
+any device specific configuration. IOCTL definitions can be platform
+specific. This API also manage shared device configuration.
+
+The following IOCTL IDs are valid for device control:
+- IOCTL_SET_PLL_FRAC_MODE	8
+- IOCTL_GET_PLL_FRAC_MODE	9
+- IOCTL_SET_PLL_FRAC_DATA	10
+- IOCTL_GET_PLL_FRAC_DATA	11
+
+Refer EEMI API guide [0] for IOCTL specific parameters and other EEMI APIs.
+
+References
+----------
+[0] Embedded Energy Management Interface (EEMI) API guide:
+    https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf
-- 
2.7.4

