Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB43C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961E92178D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NbK5o18U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961E92178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbeHCTvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:51:36 -0400
Received: from mail-eopbgr710041.outbound.protection.outlook.com ([40.107.71.41]:29872
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727850AbeHCTvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCdLtrA1kN8/0je8FqQpiN8x3unLbKCW3xvP6auRcy0=;
 b=NbK5o18UsZ+yXgurW0cD8SnVUR3VyCCY0fcVnMfaJ0r5NR891G397FhoX7im+3MKhTpEgcyKxk6qwMETo435uEdN7yHwZuotVu5pxyIkx9MmvgAYyr3K3OTneiankyb63CggahlCCXuskq4Ra8SCvjzwzu4sqBzpCkDfbv9igX8=
Received: from MWHPR0201CA0027.namprd02.prod.outlook.com
 (2603:10b6:301:74::40) by BL0PR02MB4450.namprd02.prod.outlook.com
 (2603:10b6:208:45::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 3 Aug
 2018 17:53:54 +0000
Received: from SN1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by MWHPR0201CA0027.outlook.office365.com
 (2603:10b6:301:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Fri, 3 Aug 2018 17:53:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT031.mail.protection.outlook.com (10.152.72.116) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 3 Aug 2018 17:53:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGu-0004fm-S0; Fri, 03 Aug 2018 10:53:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGp-0007cn-OV; Fri, 03 Aug 2018 10:53:47 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fleGl-0007bh-E5; Fri, 03 Aug 2018 10:53:43 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v11 05/11] firmware: xilinx: Add clock APIs
Date:   Fri, 3 Aug 2018 10:53:22 -0700
Message-ID: <1533318808-10781-6-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(438002)(189003)(199004)(106002)(2906002)(36756003)(6666003)(356003)(107886003)(39060400002)(7416002)(81156014)(305945005)(81166006)(8676002)(54906003)(2201001)(110136005)(50466002)(48376002)(16586007)(478600001)(316002)(36386004)(72206003)(106466001)(7696005)(4326008)(8936002)(51416003)(47776003)(9786002)(76176011)(50226002)(476003)(126002)(486006)(2616005)(44832011)(426003)(11346002)(446003)(5660300001)(77096007)(14444005)(63266004)(336012)(26005)(186003)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4450;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT031;1:3pze7uAvF87/xESxdQEo6sAKzLZVoTxZgoDo6QcLtiyMbVYsec9squw5C9h9aBOL9lTXH+5hdUDjYh08xRYa+fJRnVvxqjT+O4ZKSMHWt3R3u/fZ60qjG4nXYrK8Euut
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49efa090-d193-41b4-7655-08d5f96a13f8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4450;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4450;3:3S06KZhJqmoOH7ZqOlk7Zoylmkbi/9DpWNSCXH8wEg2F1N1BH44dR5XD33C0gkmHCLjmz4cqPj4cQqtsou2Rnb3RuoSnWpM0KT+Or1L4SW0rQGQdFXN5GJY3SobytfFtYEVpG/+cQKKHM+j4PYW57MaPaRBg3ua52UVIMQiVEUIJwupIzdHsDkTD4e74CtuCIy1r9wgAnJLtgfPQ69QLabDSIslz85/WW0DFDc5ljbigmPQ6Ta4QDMvn+P90o0DLDI1/LH7i+aJFqKgMpv5ixO+m2MhRHaZDm/rWzzPc6xMVqXWPoVbyqfJ44ChfFjVriYBre9mTW9cvUq1EUrjjQQ+ZJeJ3iWTDJ0oKkt1XYPA=;25:aLItTIcA+ZAK8RWys9N3E8qLBWHlP1CDuFZjuTbYSqNgq+wbQQDBMoA3fn8r7Snviv+kWJo27uNsydeKyfgeg25Jk3FKyhG5Z9jCj0uE1fyilaBtwqb1qE0EI79/IdzRPk0z+Q4iZQmdbZhRqhgQtMivuvFHs51Hn8sgYTpX2oGrCydcfWtx5/CxAu0u10OYg2vR/fYgyDcnbkKh028xLaO4kCASv9daB0AMaTV8J1PKe4gtCNLropvjZ6rTgGfgCi+wbKHir/q0GdwmjvFZZI3Xogn9E+ScAgOJRI2sw2mLEd+hGhw39O6PYuMlQdr+IzDGgY5o/ohTDA6TN2KqKQ==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4450:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4450;31:2164MBgNDh0dWmrnNkKw5tf6CM/oMJs21GRYTaoHrrXQ1nhxoMChJg5Mf2qxJetZjFfajJB3XHG3gIoe8BlDprbtd1tw13IxhFRM6FrX/lajKu8hw9JOMU4ZkDn6TFEZcUAu8EgcgsoZCO55rVrJJQ15RZDSNvBo6eapgQTpYsQLcfOdVr6sxolDHEln4SWvaCmBjBnFlVhD2ZKt+XqRSB3iLd0jAjUstK64M0lvDzE=;20:SwjN/aOePbJfA5756uajhQDvZnfiDFPbmGeqZ0SVEnj9za4xydf3INAatDJNNj1NuXnxonYGdrq4AhqD381LYDj74oppYF5ZW0L250biqN+Jic/PabZRClUQUa4C8EJm1JHsJe7W1tYrQ3L1sNlLucgl8iUVDnSSy2WPxkTsx7glopWqwXecOC69MqmzfC7P2yjHForUNhxJs90s6Eu23RaV/mRwEQTnqnb9uwmNP05SHUey6WzNLrx+2kQCxD+LN/3ddIZe6Bza5fupbQxKuyv/niS4LM9Kq5gS8Pfe6pIR7+PWcdRF85V7SY8a0uyibCpgW2FiWNe7UFlVC9WwqaUtrWroKUzFoXO92e4fGCqY1qnV9RqIEuLTE6aAf7z5n6TVTboFOnIYN0VNuQBsXnKprWe9kx8cMGpBpxkAbSLe7HaPpW28K8Kz3jFTX8eqeIJx7AIvq/C6RfoFbq6Hnkk0UTcgjTfQi0+30oWcB09zZNrGvgcp7QCwBb6hM7ML
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB445079201A0DFB581346501FB8230@BL0PR02MB4450.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4450;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4450;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4450;4:dkMMUYg5ZqnEWIN+XwDwXuI+oZ/E3k0Iwn+LM/LoqUxRO2GCxe1IkgUncQL18NmRXAHyfuj8sXgQ8lsfc1Vr2aJQ8W19snpY2jbKMkoh993dgp2VG/sHq5TfHz1jRqK3WYRN0j23ctyfxrkR5WMgHnqpm/8bRM66N8fkV3RnAHs6q2Eq2+YPHcck+MfpveQyQKRfPtWK3B/geqbP6TFMZz9O0vjkJyVNrlPPO/VFKXf/gVqy/TWk3oE69SjzumOUr6xHTmPTy7BqxpaHP1/I7sJx2tpp5F6Zg4J6Gqm5rXn8AYFmCy50PmXdDFRzZqxT
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4450;23:2+DZQ9fHlOO9bSg+svY+IuM34IAMZtp7s5d1AnV+x?=
 =?us-ascii?Q?ZVSdWx4VW9o5WSwTSjMPPpKmYyqOkkb0phwwdEI5t1ubx+to3fOt5YE+AvoN?=
 =?us-ascii?Q?GU/NfYUADJwygpVCEFFD/G4iqM/Uqf9/XgTRM5f8Whce/gylcMBZCAx31BT0?=
 =?us-ascii?Q?ms3xh9LOWCcTZG4n7AgxDA32GCpbDY2nwXo/s5B+8qbaRbT3qsjpODnJpXm7?=
 =?us-ascii?Q?XmfU98w8CL3P72ILqqFzk7GjSSv4vyUSDVaQqclE0sw2K6XULX+tXJmhakWB?=
 =?us-ascii?Q?yAEiglY3UTXpHGcZNs9r/FyxnMwWn1iIAavQ8689hi2b7720nWOhSgMxO2wo?=
 =?us-ascii?Q?05QZUfPwu3PglXNP+oZSH8FaQlskhZ3awKYZreezgWWM/viTHfFgDa6uGb+n?=
 =?us-ascii?Q?vjblDDVnPn4wj8Om5FCpBfSweQhBjSqs1RhDBMBwRETbW89iywK+CU/AXz0F?=
 =?us-ascii?Q?j8v5x4gUYXTjX4jM7qmEz0fqQImBOnZduAf08Fiyfc0Xqr1uTubihkj7JyvI?=
 =?us-ascii?Q?8ZZ0HDE50WPyADjLVQZcdkeioCFaHYWBtIo6E14XQK2hH05aDh17THxmMCh2?=
 =?us-ascii?Q?WP5JYelEF2gm/EucCDUtFlBN/KafPNj7SsDJ92kG9i/a7Sav0EDKEJOoTU9s?=
 =?us-ascii?Q?HhqcGBk/RkHWpvDCgv+H4nJeCDJ7BmndrBOcCWiCOI3fq39FoWJHh4S4NQq+?=
 =?us-ascii?Q?LTe6bKt1vGfS3uWrkq/NGLkvihTnUan5pyhn1PgUhcHHZBxzADuu3O1WPeqs?=
 =?us-ascii?Q?+LxhSURmsCKOv5Ks1slXj95t2sBo/bIgUweQK0GwQo0BdSbVZzV+4thXVzKg?=
 =?us-ascii?Q?9llV5VeP6YyXi1UPfWUXYW8q6Zq0/Hv/TiXBNOMNyz/P8Irb4Y38VUXRJl7Y?=
 =?us-ascii?Q?CYZkBwCnlXIvhA5jjT/PALAyaSAqeT+TlR2IyMrk6XOK+sq2t5/Tkt8NHoD4?=
 =?us-ascii?Q?JV8R7ZNKBlIniGj1yhTlwrwX45uTwMqV9EWN4tn+qFWrbQRVshBZbvgPAvLE?=
 =?us-ascii?Q?eaDYUuLVdloWX/uq17zJDfsNgoPT/sW18UWIAncgtAtKbp88/bxU8MeddrBb?=
 =?us-ascii?Q?W/yBZepfLGHS0z422GHQlG9SzPA6Qw2z7d4Fz3xV++RjTFHJXWOSwZg1Yr08?=
 =?us-ascii?Q?6Nf1iAvy+MuS+iXP4HzfKVZ/4CnPN1vGIjb4exvRY/6uz8tUP9tRwgPZpX6g?=
 =?us-ascii?Q?QhU0Oo70kO2rpb45efL18ZMWS1IP61G8eUVqFaTryV5N1lNxIfXMcontnwWv?=
 =?us-ascii?Q?6G+KwCHjijeTfvHCDNSjWNSRtkSmT4Q7LlRf3af?=
X-Microsoft-Antispam-Message-Info: aYg+I06gFSiwN2lWsUN9Tb5gOrobyyjTkmeFjynPfg8lyavb9pgYRRFH2HNQuu1DPFZCaKwaywMFkbZjZJgIXl17Kixfl/gVPF7ilZ5Y2bSw4c4D0lAMWD+nTtfM8vKosYKQylHAPlMZSFKkic3BWmv3XDQ0nM5gFZlJiWhlJ0wLWJfPxkbNVU2grtP7gwYJc+6E7fUaCBrGpgGubi9ZYiuTatIfnZfL+Cc+e/LgXR7URVKa5Iz7+oQpDCIEurY6vxmhzJvcC61e2ZE0gJgEvL7aPi/3kr6fTS8q9Nrv74gMuDEpqpN1jQektfUF8xHeOgZfIGqfn3ZkIkZp9Id9lyFSiZWfCQPWsFicyJPuLO8=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4450;6:Ump5bVErqmM0Neg4KPLrIX8ypn71heefl/POhRSq/gPSyw/hfyXmgBeIvDIt0kgLQWiVhzplWQ3nBiQmwqoWQtQjS4RyefijHsS7Nb7ef56VcQ2mHGGfoOO57u1bv5diBxDoYbqJqPlv+vWhL3qZBn73bEi66+Z7SfEXgMBiG8V8ZIXwjFzxY02vpVZ1wEFyuUckSBNMLcd1tn+TcjrO7qEq5Ofr7fwCIp0VyvW9uEVk5xpBuIKxaZuqilRhACJTNT5rzpuZ1g+vFEDFZmk+Hz7PARO1VtzSUdKLunO0RFJ2CvdDpesm89N5Tvpd5aqvR5zkEeEGNaSi7hfyRUXO+fHvVF5BpMCY2DmICS7TicaUruDCbbjNDWrRn0zzW2tL05WHIqXKWcrM6nGnj4m19JN9kYqel68+TtkKPDX4aAH1VoWcHJgRWTl3GK6qwcFQV+B2YgSE4HmwMqROyNu91g==;5:ik7k1b0SC+lC1IqlVvUqUNVsdtURffSMW72ah6+D+vic9YGpycFTPI0IiVdbQ/X7ceqK/I57ZOjniZ4KAIYEwOL3a4V7Admq19G3zUj6OR6spakbtPuB+zqlZXtq0JpAsrZBQYY0U11KnYrlGUAfHF25RiCD2MaMlvGOBYdNhUA=;7:JBCZQ21PguVytYYJQvdyYWscwVWLl2rKhYniQA8blQmjyHuNxI1XkTsc/8JE/OXsecmB7dAZ40FkBshQdZkjzZaLoKEs94T/VDDouj7Cw1IoIq8ZUuw0HCmQtFt8TZbCy+F+r4u+iK6H1SQxdftLacGr1FfFEMcASq1EMv5RoxKMbd0mTmUbq7wmVF6MFkgzldfsAQ5F7GvWT328H7ljBuhfR6kaxenr6hHlkoYWDqP1xj5HtJfuY5nx9lJH4s6e
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 17:53:53.3442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49efa090-d193-41b4-7655-08d5f96a13f8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add clock APIs to control clocks through firmware
interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 186 ++++++++++++++++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h |  30 ++++++
 2 files changed, 214 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 8ec5682..41ed800 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -269,14 +269,196 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
  */
 static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
 {
-	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
-				   qdata.arg2, qdata.arg3, out);
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				  qdata.arg2, qdata.arg3, out);
+
+	/*
+	 * For clock name query, all bytes in SMC response are clock name
+	 * characters and return code is always success. For invalid clocks,
+	 * clock name bytes would be zeros.
+	 */
+	return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : ret;
+}
+
+/**
+ * zynqmp_pm_clock_enable() - Enable the clock for given id
+ * @clock_id:	ID of the clock to be enabled
+ *
+ * This function is used by master to enable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_enable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_disable() - Disable the clock for given id
+ * @clock_id:	ID of the clock to be disable
+ *
+ * This function is used by master to disable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_disable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getstate() - Get the clock state for given id
+ * @clock_id:	ID of the clock to be queried
+ * @state:	1/0 (Enabled/Disabled)
+ *
+ * This function is used by master to get the state of clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*state = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setdivider() - Set the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value
+ *
+ * This function is used by master to set divider for any clock
+ * to achieve desired rate.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, clock_id, divider,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getdivider() - Get the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value
+ *
+ * This function is used by master to get divider values
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, clock_id, 0,
+				  0, 0, ret_payload);
+	*divider = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setrate() - Set the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to set rate for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id,
+				   lower_32_bits(rate),
+				   upper_32_bits(rate),
+				   0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getrate() - Get the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to get rate
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*rate = ((u64)ret_payload[2] << 32) | ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setparent() - Set the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to set parent for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, clock_id,
+				   parent_id, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getparent() - Get the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to get parent index
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, clock_id, 0,
+				  0, 0, ret_payload);
+	*parent_id = ret_payload[1];
+
+	return ret;
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
 	.query_data = zynqmp_pm_query_data,
+	.clock_enable = zynqmp_pm_clock_enable,
+	.clock_disable = zynqmp_pm_clock_disable,
+	.clock_getstate = zynqmp_pm_clock_getstate,
+	.clock_setdivider = zynqmp_pm_clock_setdivider,
+	.clock_getdivider = zynqmp_pm_clock_getdivider,
+	.clock_setrate = zynqmp_pm_clock_setrate,
+	.clock_getrate = zynqmp_pm_clock_getrate,
+	.clock_setparent = zynqmp_pm_clock_setparent,
+	.clock_getparent = zynqmp_pm_clock_getparent,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 55ed2ba..58a7478 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -36,6 +36,15 @@ enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
+	PM_CLOCK_ENABLE,
+	PM_CLOCK_DISABLE,
+	PM_CLOCK_GETSTATE,
+	PM_CLOCK_SETDIVIDER,
+	PM_CLOCK_GETDIVIDER,
+	PM_CLOCK_SETRATE,
+	PM_CLOCK_GETRATE,
+	PM_CLOCK_SETPARENT,
+	PM_CLOCK_GETPARENT,
 };
 
 /* PMU-FW return status codes */
@@ -49,8 +58,20 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_ioctl_id {
+	IOCTL_SET_PLL_FRAC_MODE = 8,
+	IOCTL_GET_PLL_FRAC_MODE,
+	IOCTL_SET_PLL_FRAC_DATA,
+	IOCTL_GET_PLL_FRAC_DATA,
+};
+
 enum pm_query_id {
 	PM_QID_INVALID,
+	PM_QID_CLOCK_GET_NAME,
+	PM_QID_CLOCK_GET_TOPOLOGY,
+	PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS,
+	PM_QID_CLOCK_GET_PARENTS,
+	PM_QID_CLOCK_GET_ATTRIBUTES,
 };
 
 /**
@@ -71,6 +92,15 @@ struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
+	int (*clock_enable)(u32 clock_id);
+	int (*clock_disable)(u32 clock_id);
+	int (*clock_getstate)(u32 clock_id, u32 *state);
+	int (*clock_setdivider)(u32 clock_id, u32 divider);
+	int (*clock_getdivider)(u32 clock_id, u32 *divider);
+	int (*clock_setrate)(u32 clock_id, u64 rate);
+	int (*clock_getrate)(u32 clock_id, u64 *rate);
+	int (*clock_setparent)(u32 clock_id, u32 parent_id);
+	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

