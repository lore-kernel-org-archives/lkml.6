Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D012EC65BA7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E06E21486
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tAT+AbSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E06E21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeJEET2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:19:28 -0400
Received: from mail-sn1nam01on0053.outbound.protection.outlook.com ([104.47.32.53]:5760
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbeJEET0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M39qo0zj4PCoi+MjONaPAVHRKQdD9EIssUqWbk3rOt8=;
 b=tAT+AbSCwvnH5owfE9DS+30pznDin+yd+oMeRUwXsKPa4PPj/A7je+KVEcbFYWnn2GG4V6T25pLZ9wC9YzhXIi2zlPr7gLYpSfQRmh5yQDSliOFCLGGs523iF/UWx9kgwkLGFe+XNZHrlu8CzPietWaTrtHk6PihS5f81aOWAjw=
Received: from BL0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:207:3d::19)
 by BYAPR02MB4469.namprd02.prod.outlook.com (2603:10b6:a03:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.21; Thu, 4 Oct
 2018 21:24:11 +0000
Received: from BL2NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BL0PR02CA0042.outlook.office365.com
 (2603:10b6:207:3d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.17 via Frontend
 Transport; Thu, 4 Oct 2018 21:24:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT023.mail.protection.outlook.com (10.152.77.72) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1207.19
 via Frontend Transport; Thu, 4 Oct 2018 21:24:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g8B6K-0003dY-2V; Thu, 04 Oct 2018 14:24:04 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g8B6E-0001wm-Tl; Thu, 04 Oct 2018 14:23:58 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94LNvus016480;
        Thu, 4 Oct 2018 14:23:57 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g8B6C-0001w6-Tz; Thu, 04 Oct 2018 14:23:56 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 4/4] drivers: soc: xilinx: Add ZynqMP power domain driver
Date:   Thu, 4 Oct 2018 14:23:41 -0700
Message-ID: <1538688221-9823-5-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
References: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(438002)(189003)(199004)(478600001)(63266004)(16586007)(316002)(4744004)(48376002)(72206003)(2906002)(107886003)(36756003)(106466001)(36386004)(50466002)(6666003)(4326008)(11346002)(126002)(446003)(47776003)(426003)(110136005)(8936002)(9786002)(44832011)(7416002)(476003)(5660300001)(2616005)(186003)(77096007)(336012)(26005)(81156014)(106002)(81166006)(8676002)(7696005)(51416003)(54906003)(5024004)(14444005)(76176011)(305945005)(356003)(2201001)(486006)(39060400002)(50226002)(921003)(107986001)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4469;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT023;1:8eT4DgflxVSZ023D+pLKz6sN9X5nv7b5hbnWKmr0GA3WJYhZRV7uXm3be3uVbUEqWx6zGgkS+6RuEotVyeCz5Ira1N4Z/g8IysnnRvRiKKX0XylvA1pOvJOXZZ4XSbAL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc6c16fb-b9f7-4206-7d39-08d62a3fb941
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4469;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;3:ELSVfpmHASfEIqQe69HJsf8KBKIQrEckkbSOM5+Lpzy+v4lIb1qcIq84T0ykPQZG+mruUI8z4D8z2+4+x7pIFpeVt79vYjpS8SO1d9cAEoTImpDsx2Ixg5V/W4QHAmXu5xMOY8LM6+SDeKpqzcIz9n/GAROf8/bIBGhMQp1OEgXF9Pcjzv4CDItn227PlX4v7YYh15AihP02n28JFraxbXH2isPYKdBUX7S8KFuhjtFFjvdnk65rQU5KXiXkxZkNTYsOTpoDPf2f4SX09NWd10vS1nJfwDWySnOqPwXfSCDxV+ipe1EJeTT+RTet+HL83dKZd/rG1YgnMwLZUmYejWFuh9B/qt2wGh2RbokOa6E=;25:PrLbzpIKRVVMA9p03CQHDerWKrIk7wJwQVFM/JtOXZCa6H64WLOASpWZxa6u7/lwjj5g1f5JJdUmB3mqvIncJVkyE++j2Stw1H5uyfHRzIjBD4No5ZCo1cml4IDDv2x5sj2m+gm5ihkT30Rj0xgS3PxqUsw9FOzN9nooIdfBBK8KWlV1b53FuP/f7HXfd9cxTvDRjcXf3mPkh2K+swC2S5h8ieRDioCca2nUOhgLpG0+H/n5jepqd+tz+/28Hg0hSZt63lVbZmRbMYWcADWHOAjNExJrKUGjTLszlZmfWnreXA78E068btngQ49BAZGl8/3AAQ5obZWqsBXP4rA/gw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4469:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;31:6sAzJ5TInfo8Za3A3V8fUaRJAdgFknemZlhCG8QxzC5jACXEJ8xUzEomCPBxlH6D2yAQcUCoD/UykGupD0qRyYqIs4+D/wdLjDbtJ710IZol9LjxgPF4MuIuEpAKJ/0R/tRCHpxHQQT/dsR7hjpjJQX/hBSdKxiXfF1UldGBDM9W9ZHe8wJKdBorI7PNXpMGqaAGkMQPGlzyXv9K2kY6Qipj+xJwzujWmQVEEo2VdSE=;20:hq1WA+Bskwk52PYTjs8qGsK3W5GmZNWkrBl4mABRl5W+9GPrLoMQ4M2PjpOF1JED8gXM/BLzq2DU9eYB63vTARX8d31BY01q0IO1lC1hp0TwsDME3GAHYqSAmpGaWHhAqlFC3h4VNmfL19yhAPzbr/tHftTov8RFf8vOMY3dSg4aqakpIrxy2HI86pHdnIHSNO/kRrUBHdtzwDTsGvWiVCZ0OGDB22nD/d9fwtFD5fpKOOWdMAjLAwC85NgnuXf2hiOGVWAhRsMBehHvjFIdthDTOG4mndZy46KS1ykozGF5VhzQK46d0PGcT5Usg37WoPlaPA2uKu+aWpRGi19PbdI9VR2laTua/tMYEKETt5Tju3854Ia7oH2yfoKkFSP/2ty7fwXj6rxrnGu7aj2qLMl9vIjZgm8ONXiIsPVENwkfcRr1hl0f41a2eanwGFA5UC6D1241tvFwjqLFscjuaPrgjTVUSpy0DKHdjz+RY7OUrhDNvnd6KVC2M0ZHj1tT
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4469717B08CA93F4A165CFA5B8EA0@BYAPR02MB4469.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(269456686620040)(192813158149592)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051);SRVR:BYAPR02MB4469;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4469;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;4:HKN/+++4BRv2XJHHkix8ZtWcI1U3nAmEc+hRVUovQKivihtW0TEY0lpsgVF2pqVfsNFe0YDXAi6JD5sNdi/Vg+rZiKCzv5c4Nh8DBK9of+Pq1lnRfkbmyBTiQQd2W6Fp9p7/if+hf0VdKOHBAJrIIKDWeZVlEl91ATdulUpCXMMWeGfSwTtNV4nfuACU3VL4qTEwF3ejmDTxAHc3a6PDltwRO6F7lOcVwqb7rWxuK7jNAzRqPUWsPeftEtwLgkjkl+/5UaL/VlBHcJJwlKtj6npRmCwg4rbDpBJApf98ZpAwNlvwcB7+l3CeFHcnlP37w6OdAqooQ/ZRyP0RoAcESkpaYMHMaABSNxYIE414IH4E0/bKtqqTScKkYeiSJ+RU
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4469;23:p/eJP6Phg4Lmeh0N21aHARA5ivaRUjCvwYA2xGINu?=
 =?us-ascii?Q?S2MlzBkqHPkj2oeqty0HFNEAseLH8cYMFeuri8tAF0lyKNRE9ShsZ1OmLdU4?=
 =?us-ascii?Q?Ut1SZJUQeWafCCs4Hs0PSKSQLc+t4LNcE3nXWPLxWmf+K0h59CnZXvWSoLeA?=
 =?us-ascii?Q?k30cRZyaM108pnsAclgB2TC50g6x50ENL4klPSLwv8+fb0kWVs2cqdpAtMhr?=
 =?us-ascii?Q?QEi6YHmdHDnok/xLaZoiFkZD/pP6/qVzjxo555Tyjt6KIbGUeKXaiOP5mFQW?=
 =?us-ascii?Q?rXLu9gQUFXMNPV4UXzqqTlBoFLidDS30MJ2ax0Hu9V3P0+RSBULc/DhtjZoL?=
 =?us-ascii?Q?9wKWLDbobK0CE9dYPKtPCZad9sUi9ha9e9WNUoEHCuMqydhvOXV+yfOt3Srg?=
 =?us-ascii?Q?gihirtiyRcZ6+2bSS2EAeWL+05v5lcKqazROKh1GWdzjiAwOLEpj/4omShCz?=
 =?us-ascii?Q?WR6a/6dyh4iVOklQyzR7Kj++XJBkiZIIpWSEHEkjWBg5OYa2aYuQRfNVvgfU?=
 =?us-ascii?Q?Zn0Gyboihb4Jt6pImRRTggokr2xASipFmqYMDzXnLB7pEsyrkQZ2q3+dd5b8?=
 =?us-ascii?Q?8PaIZxHtC32BpL29l5vB7aQ6lM+Z1wZ4xLGboxR8BTVukW0LtMVkFLm8Zej3?=
 =?us-ascii?Q?qCQ4ZeHNip7+aTfzs8/zpYSAsxmeY7WpzKsmgf2SMjSL761fDRQMnz/DN25r?=
 =?us-ascii?Q?7GQ8p5UMC3jAtY1q/Esdao2I5g517QfHvM412WFL8m8baMA1m8W6/fw8ppm9?=
 =?us-ascii?Q?RfyGBqRZ/HMAkejg9QEIP1WZULJ48nw1kEamsrtYukCdwQGbS7Bib+rSRAal?=
 =?us-ascii?Q?KPPh3MqiPZ1sB3GRcxCr92wrS5xeR6tdJWMEjNYuanOm71i+eESMt4zgmPeA?=
 =?us-ascii?Q?jCnvj2RTSkOR4WESVKaC7DGmyNw5gQ09qKsfoz+rbRPFhLM7MA7XLDSaWQuD?=
 =?us-ascii?Q?a9i3U1+CMtnW4LWHoy9EK+VGdqQkAchVSwrjrlWOiDbCLRPqT9JV7JkABDwN?=
 =?us-ascii?Q?Fg13fmwdoO51cdY7FLOWZTOFF5Xw0NpXMF1UlHH0Dq5+NN97McGvVQ5DL1V2?=
 =?us-ascii?Q?VF0oFMm1E0hNTWHxOF/wSmPzWNGvYvNMAm01d++Ml9Awh85qJHYTJJt0xhuG?=
 =?us-ascii?Q?YPNWay+yS+jf36j4K3vomPSsaqIct1EgLkKdpxVVXqbNERyZ/am6sf/wE7dD?=
 =?us-ascii?Q?e9hsqbqSRdujUNPzKTHAUK13X2cgiyA0VBQSNzNre4bJfySAmdpyi5iolgf3?=
 =?us-ascii?Q?O0Lp+X+2SueVzwaWUueeSlR1aPbuhO0rHu5e5egVPoDzZ6S5jHT9KPN3D0kB?=
 =?us-ascii?Q?nDvyePFggMrwgMVvCcyHSx+TX1zW7Ypg+Q1dncqjFwo?=
X-Microsoft-Antispam-Message-Info: VgSQVlChtw1RaZpqSDczAZVqk0qT46uHJelZ+OhrosW3gxCKneJVbKWDzGW+MHN//A3ZmhpykWSougfLYVG18sVLNXIPk0v8j2/sIRS8unLi2b7deH6IO3qQkTLpHz2PrLamj5xkyR1LUGmdQmh7gGFKa+cqsGlK0n9XD77NgAuOX5eg5RFifnwFt6vDgp/xEEKB9dZa8UjwHJijtQp1aB6WSGSVUFDbsrGcTijojMyK+99zvmUb4rIENybYeRL7H8+PV4KlJMkEbKkzTzjPXq9W1iKku6p1qANVRu0sm2iH+g7E6LMOfVSIW5rO4AqXxi8V9CSD6K3ddU8i0BqatddGv/yEtSgYUuKGv3mBxK4=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;6:lxQlmdSqFg+pP05Rhkd3Y5qSwwI5IZyETUd9EfkLMntGWKeyoIgOdgeT/6Pxc9SDdZXm1O2m/qunEEr9COLWTyoLrqXW+KVL9EaTsgiK7Rhlqfn2uCigoz5b1BXrfsnBnX4rQY3iM/D9ODkuz/mAqBeHk4HBk6PZq+uo1iRbqqAsIU/IZt0cRV99peEMLKHH44TE2qciOD8nity6E7ePOg5cop01hBJor8I5nfgZQbjnSuGmDmGXvgnX4EMcKnsW050TcMLfTLlBbRHq9htmvk6NQIncBEC9UondGrMJNW058AoNTzqGWDBCe4vX7Pd/qgq5cWXIUF5AUUCB1VDyk8TD+DmfrryPelH7vhjICQB6zEpYc1e60m9wvnUPEchLoloF6PfeCNxEqaK/mHb49egALFCcZM+pMsCPgBtXlN8yv3dIb4NSEjU5B9gfxojG9c74hQVORY2mz8j6KdSm8w==;5:lmIihx6nVW5BC3s+laR8vKdtG16YkWIEnzmfWkg7MdbuDj8gqp2+efEAhf43ngkdmdQQeCBHnq9bAXyX7xJvctTicUF7ZVefcVUY+xZ5rXpFQfCBNwjW/1XQ/zkCok5dlSjGXSWOjDpQ70JfgT6hQTJuCiP1kjMzdgdN2vZjVv8=;7:ct/N/G9vQnJsFxHMSoKofecgCyaWcaJvfBQImUwBmB1S9wlXrlEu3le/OzhYX3VE5BfiPAgdeNxvooX2o/EgUAmGYdDL86kPq4E5au+KaoM7/nXHAf2nPCgTjoQDEeUTCjc26FnqWgN3O7sWEDXdCKneN/tP5WBWl0Atp4aQx77tPxAhjfFI4vLsbeerg6y0wM75icflL9y5JkD7oKufRr7LJa7lIENYGbtVZkj2/fO6YYyWHqtRD4lN/1btn3v6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 21:24:05.0447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6c16fb-b9f7-4206-7d39-08d62a3fb941
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jolly Shah <jolly.shah@xilinx.com>

The zynqmp-genpd driver communicates the usage requirements
for logical power domains / devices to the platform FW.
FW is responsible for choosing appropriate power states,
taking Linux' usage information into account.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/Kconfig        |   1 +
 drivers/firmware/xilinx/zynqmp.c       |  15 ++
 drivers/soc/xilinx/Kconfig             |   9 +
 drivers/soc/xilinx/Makefile            |   2 +
 drivers/soc/xilinx/zynqmp_pm_domains.c | 403 +++++++++++++++++++++++++++++++++
 5 files changed, 430 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c

diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
index 8f44b9c..bd33bbf 100644
--- a/drivers/firmware/xilinx/Kconfig
+++ b/drivers/firmware/xilinx/Kconfig
@@ -6,6 +6,7 @@ menu "Zynq MPSoC Firmware Drivers"
 
 config ZYNQMP_FIRMWARE
 	bool "Enable Xilinx Zynq MPSoC firmware interface"
+	select MFD_CORE
 	help
 	  Firmware interface driver is used by different
 	  drivers to communicate with the firmware for
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index faf6a52..6b365df 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -14,6 +14,7 @@
 #include <linux/compiler.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -23,6 +24,12 @@
 #include <linux/firmware/xlnx-zynqmp.h>
 #include "zynqmp-debug.h"
 
+static const struct mfd_cell firmware_devs[] = {
+	{
+		.name = "zynqmp_power_controller",
+	},
+};
+
 /**
  * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
  * @ret_status:		PMUFW return code
@@ -596,11 +603,19 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 
 	zynqmp_pm_api_debugfs_init();
 
+	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, firmware_devs,
+			      ARRAY_SIZE(firmware_devs), NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add MFD devices %d\n", ret);
+		return ret;
+	}
+
 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
 static int zynqmp_firmware_remove(struct platform_device *pdev)
 {
+	mfd_remove_devices(&pdev->dev);
 	zynqmp_pm_api_debugfs_exit();
 
 	return 0;
diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 687c8f3..81a345e 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -17,4 +17,13 @@ config XILINX_VCU
 	  To compile this driver as a module, choose M here: the
 	  module will be called xlnx_vcu.
 
+config ZYNQMP_PM_DOMAINS
+	bool "Enable Zynq MPSoC generic PM domains"
+	default y
+	depends on PM && ARCH_ZYNQMP && ZYNQMP_FIRMWARE
+	select PM_GENERIC_DOMAINS
+	help
+	  Say yes to enable device power management through PM domains
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index dee8fd5..f468d1b 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
+
+obj-$(CONFIG_ZYNQMP_PM_DOMAINS) += zynqmp_pm_domains.o
diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
new file mode 100644
index 0000000..999fe67
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ZynqMP Generic PM domain support
+ *
+ *  Copyright (C) 2015-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajan.vaja@xilinx.com>
+ */
+
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/* Flag stating if PM nodes mapped to the PM domain has been requested */
+#define ZYNQMP_PM_DOMAIN_REQUESTED	BIT(0)
+
+/**
+ * struct zynqmp_pm_domain - Wrapper around struct generic_pm_domain
+ * @gpd:		Generic power domain
+ * @dev_list:		List of devices belong to power domain
+ * @node_ids:		PM node IDs corresponding to device(s) inside PM domain
+ * @node_id_num:	Number of PM node IDs
+ * @flags:		ZynqMP PM domain flags
+ */
+struct zynqmp_pm_domain {
+	struct generic_pm_domain gpd;
+	struct list_head dev_list;
+	const u32 *node_ids;
+	int node_id_num;
+	u8 flags;
+};
+
+/*
+ * struct zynqmp_domain_device - Device node present in power domain
+ * @dev:	Device
+ * &list:	List member for the devices in domain list
+ */
+struct zynqmp_domain_device {
+	struct device *dev;
+	struct list_head list;
+};
+
+/*
+ * struct zynqmp_pd_info - PM domain info
+ * @id:		Number of PM node IDs
+ * @ids:	PM node IDs corresponding to device(s) inside PM domain
+ * @name:	PM node name
+ */
+struct zynqmp_pd_info {
+	u32 num_id;
+	const u32 *ids;
+	const char *name;
+};
+
+/**
+ * zynqmp_gpd_is_active_wakeup_path() - Check if device is in wakeup source
+ *					path
+ * @dev:	Device to check for wakeup source path
+ * @not_used:	Data member (not required)
+ *
+ * This function is checks device's child hierarchy and checks if any device is
+ * set as wakeup source.
+ *
+ * Return: 1 if device is in wakeup source path else 0
+ */
+static int zynqmp_gpd_is_active_wakeup_path(struct device *dev, void *not_used)
+{
+	int may_wakeup;
+
+	may_wakeup = device_may_wakeup(dev);
+	if (may_wakeup)
+		return may_wakeup;
+
+	return device_for_each_child(dev, NULL,
+			zynqmp_gpd_is_active_wakeup_path);
+}
+
+/**
+ * zynqmp_gpd_power_on() - Power on PM domain
+ * @domain:	Generic PM domain
+ *
+ * This function is called before devices inside a PM domain are resumed, to
+ * power on PM domain.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int zynqmp_gpd_power_on(struct generic_pm_domain *domain)
+{
+	int ret, i;
+	struct zynqmp_pm_domain *pd;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_requirement)
+		return -ENXIO;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+	for (i = 0; i < pd->node_id_num; i++) {
+		ret = eemi_ops->set_requirement(pd->node_ids[i],
+						ZYNQMP_PM_CAPABILITY_ACCESS,
+						ZYNQMP_PM_MAX_QOS,
+						ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		if (ret) {
+			pr_err("%s() %s set requirement for node %d failed: %d\n",
+			       __func__, domain->name, pd->node_ids[i], ret);
+			return ret;
+		}
+	}
+
+	pr_debug("%s() Powered on %s domain\n", __func__, domain->name);
+	return 0;
+}
+
+/**
+ * zynqmp_gpd_power_off() - Power off PM domain
+ * @domain:	Generic PM domain
+ *
+ * This function is called after devices inside a PM domain are suspended, to
+ * power off PM domain.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int zynqmp_gpd_power_off(struct generic_pm_domain *domain)
+{
+	int ret, i;
+	struct zynqmp_pm_domain *pd;
+	struct zynqmp_domain_device *zdev, *tmp;
+	u32 capabilities = 0;
+	bool may_wakeup;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_requirement)
+		return -ENXIO;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	/* If domain is already released there is nothing to be done */
+	if (!(pd->flags & ZYNQMP_PM_DOMAIN_REQUESTED))
+		return 0;
+
+	list_for_each_entry_safe(zdev, tmp, &pd->dev_list, list) {
+		/* If device is in wakeup path, set capability to WAKEUP */
+		may_wakeup = zynqmp_gpd_is_active_wakeup_path(zdev->dev, NULL);
+		if (may_wakeup) {
+			dev_dbg(zdev->dev, "device is in wakeup path in %s\n",
+				domain->name);
+			capabilities = ZYNQMP_PM_CAPABILITY_WAKEUP;
+			break;
+		}
+	}
+
+	for (i = pd->node_id_num - 1; i >= 0; i--) {
+		ret = eemi_ops->set_requirement(pd->node_ids[i],
+						capabilities, 0,
+						ZYNQMP_PM_REQUEST_ACK_NO);
+		/**
+		 * If powering down of any node inside this domain fails,
+		 * report and return the error
+		 */
+		if (ret) {
+			pr_err("%s() %s set requirement for node %d failed: %d\n",
+			       __func__, domain->name, pd->node_ids[i], ret);
+			return ret;
+		}
+	}
+
+	pr_debug("%s() Powered off %s domain\n", __func__, domain->name);
+	return 0;
+}
+
+/**
+ * zynqmp_gpd_attach_dev() - Attach device to the PM domain
+ * @domain:	Generic PM domain
+ * @dev:	Device to attach
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int zynqmp_gpd_attach_dev(struct generic_pm_domain *domain,
+				 struct device *dev)
+{
+	int ret, i;
+	struct zynqmp_pm_domain *pd;
+	struct zynqmp_domain_device *zdev;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->request_node)
+		return -ENXIO;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	zdev = devm_kzalloc(dev, sizeof(*zdev), GFP_KERNEL);
+	if (!zdev)
+		return -ENOMEM;
+
+	zdev->dev = dev;
+	list_add(&zdev->list, &pd->dev_list);
+
+	/* If this is not the first device to attach there is nothing to do */
+	if (domain->device_count)
+		return 0;
+
+	for (i = 0; i < pd->node_id_num; i++) {
+		ret = eemi_ops->request_node(pd->node_ids[i], 0, 0,
+					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		/* If requesting a node fails print and return the error */
+		if (ret) {
+			pr_err("%s() %s request failed for node %d: %d\n",
+			       __func__, domain->name, pd->node_ids[i], ret);
+			list_del(&zdev->list);
+			zdev->dev = NULL;
+			devm_kfree(dev, zdev);
+			return ret;
+		}
+	}
+
+	pd->flags |= ZYNQMP_PM_DOMAIN_REQUESTED;
+
+	pr_debug("%s() %s attached to %s domain\n", __func__,
+		 dev_name(dev), domain->name);
+	return 0;
+}
+
+/**
+ * zynqmp_gpd_detach_dev() - Detach device from the PM domain
+ * @domain:	Generic PM domain
+ * @dev:	Device to detach
+ */
+static void zynqmp_gpd_detach_dev(struct generic_pm_domain *domain,
+				  struct device *dev)
+{
+	int ret, i;
+	struct zynqmp_pm_domain *pd;
+	struct zynqmp_domain_device *zdev, *tmp;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->release_node)
+		return;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	list_for_each_entry_safe(zdev, tmp, &pd->dev_list, list)
+		if (zdev->dev == dev) {
+			list_del(&zdev->list);
+			zdev->dev = NULL;
+			devm_kfree(dev, zdev);
+		}
+
+	/* If this is not the last device to detach there is nothing to do */
+	if (domain->device_count)
+		return;
+
+	for (i = 0; i < pd->node_id_num; i++) {
+		ret = eemi_ops->release_node(pd->node_ids[i]);
+		/* If releasing a node fails print the error and return */
+		if (ret) {
+			pr_err("%s() %s release failed for node %d: %d\n",
+			       __func__, domain->name, pd->node_ids[i], ret);
+			return;
+		}
+	}
+
+	pd->flags &= ~ZYNQMP_PM_DOMAIN_REQUESTED;
+
+	pr_debug("%s() %s detached from %s domain\n", __func__,
+		 dev_name(dev), domain->name);
+}
+
+static const u32 usb0_ids[] = {NODE_USB_0};
+static const u32 usb1_ids[] = {NODE_USB_1};
+static const u32 sata_ids[] = {NODE_SATA};
+static const u32 spi0_ids[] = {NODE_SPI_0};
+static const u32 spi1_ids[] = {NODE_SPI_1};
+static const u32 uart0_ids[] = {NODE_UART_0};
+static const u32 uart1_ids[] = {NODE_UART_1};
+static const u32 eth0_ids[] = {NODE_ETH_0};
+static const u32 eth1_ids[] = {NODE_ETH_1};
+static const u32 eth2_ids[] = {NODE_ETH_2};
+static const u32 eth3_ids[] = {NODE_ETH_3};
+static const u32 i2c0_ids[] = {NODE_I2C_0};
+static const u32 i2c1_ids[] = {NODE_I2C_1};
+static const u32 dp_ids[] = {NODE_DP};
+static const u32 gdma_ids[] = {NODE_GDMA};
+static const u32 adma_ids[] = {NODE_ADMA};
+static const u32 ttc0_ids[] = {NODE_TTC_0};
+static const u32 ttc1_ids[] = {NODE_TTC_1};
+static const u32 ttc2_ids[] = {NODE_TTC_2};
+static const u32 ttc3_ids[] = {NODE_TTC_3};
+static const u32 sd0_ids[] = {NODE_SD_0};
+static const u32 sd1_ids[] = {NODE_SD_1};
+static const u32 nand_ids[] = {NODE_NAND};
+static const u32 qspi_ids[] = {NODE_QSPI};
+static const u32 gpio_ids[] = {NODE_GPIO};
+static const u32 can0_ids[] = {NODE_CAN_0};
+static const u32 can1_ids[] = {NODE_CAN_1};
+static const u32 pcie_ids[] = {NODE_PCIE};
+static const u32 gpu_ids[] = {NODE_GPU, NODE_GPU_PP_0, NODE_GPU_PP_1};
+
+#define ZYNQMP_PM_DOMAIN(nm)	{ \
+		.name = "pd-" #nm, \
+		.num_id = ARRAY_SIZE(nm ## _ids), \
+		.ids = nm ## _ids, \
+	}
+
+static const struct zynqmp_pd_info pm_ids[] = {
+	ZYNQMP_PM_DOMAIN(usb0),
+	ZYNQMP_PM_DOMAIN(usb1),
+	ZYNQMP_PM_DOMAIN(sata),
+	ZYNQMP_PM_DOMAIN(spi0),
+	ZYNQMP_PM_DOMAIN(spi1),
+	ZYNQMP_PM_DOMAIN(uart0),
+	ZYNQMP_PM_DOMAIN(uart1),
+	ZYNQMP_PM_DOMAIN(eth0),
+	ZYNQMP_PM_DOMAIN(eth1),
+	ZYNQMP_PM_DOMAIN(eth2),
+	ZYNQMP_PM_DOMAIN(eth3),
+	ZYNQMP_PM_DOMAIN(i2c0),
+	ZYNQMP_PM_DOMAIN(i2c1),
+	ZYNQMP_PM_DOMAIN(dp),
+	ZYNQMP_PM_DOMAIN(gdma),
+	ZYNQMP_PM_DOMAIN(adma),
+	ZYNQMP_PM_DOMAIN(ttc0),
+	ZYNQMP_PM_DOMAIN(ttc1),
+	ZYNQMP_PM_DOMAIN(ttc2),
+	ZYNQMP_PM_DOMAIN(ttc3),
+	ZYNQMP_PM_DOMAIN(sd0),
+	ZYNQMP_PM_DOMAIN(sd1),
+	ZYNQMP_PM_DOMAIN(nand),
+	ZYNQMP_PM_DOMAIN(qspi),
+	ZYNQMP_PM_DOMAIN(gpio),
+	ZYNQMP_PM_DOMAIN(can0),
+	ZYNQMP_PM_DOMAIN(can1),
+	ZYNQMP_PM_DOMAIN(pcie),
+	ZYNQMP_PM_DOMAIN(gpu),
+};
+
+static int zynqmp_gpd_probe(struct platform_device *pdev)
+{
+	int i;
+	struct genpd_onecell_data *zynqmp_pd_data;
+	struct generic_pm_domain **domains;
+	struct zynqmp_pm_domain *pd;
+	struct device *dev = &pdev->dev;
+
+	pd = devm_kcalloc(dev, ARRAY_SIZE(pm_ids), sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	zynqmp_pd_data = devm_kzalloc(dev, sizeof(*zynqmp_pd_data), GFP_KERNEL);
+	if (!zynqmp_pd_data)
+		return -ENOMEM;
+
+	domains = devm_kcalloc(dev, ARRAY_SIZE(pm_ids), sizeof(*domains),
+			       GFP_KERNEL);
+	if (!domains)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(pm_ids); i++, pd++) {
+		pd->node_id_num = pm_ids[i].num_id;
+		pd->node_ids = pm_ids[i].ids;
+		pd->gpd.name = pm_ids[i].name;
+		pd->gpd.power_off = zynqmp_gpd_power_off;
+		pd->gpd.power_on = zynqmp_gpd_power_on;
+		pd->gpd.attach_dev = zynqmp_gpd_attach_dev;
+		pd->gpd.detach_dev = zynqmp_gpd_detach_dev;
+
+		domains[i] = &pd->gpd;
+
+		/* Mark all PM domains as initially powered off */
+		pm_genpd_init(&pd->gpd, NULL, true);
+		INIT_LIST_HEAD(&pd->dev_list);
+	}
+
+	zynqmp_pd_data->domains = domains;
+	zynqmp_pd_data->num_domains = ARRAY_SIZE(pm_ids);
+	of_genpd_add_provider_onecell(dev->parent->of_node, zynqmp_pd_data);
+
+	return 0;
+}
+
+static int zynqmp_gpd_remove(struct platform_device *pdev)
+{
+	of_genpd_del_provider(pdev->dev.parent->of_node);
+
+	return 0;
+}
+
+static struct platform_driver zynqmp_power_domain_driver = {
+	.driver	= {
+		.name = "zynqmp_power_controller",
+	},
+	.probe = zynqmp_gpd_probe,
+	.remove = zynqmp_gpd_remove,
+};
+module_platform_driver(zynqmp_power_domain_driver);
+
+MODULE_ALIAS("platform:zynqmp_power_controller");
-- 
2.7.4

