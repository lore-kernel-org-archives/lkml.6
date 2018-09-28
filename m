Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC78ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9520120868
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0bRcxLLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9520120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbeI1Xj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:39:28 -0400
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:55427
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbeI1Xj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjYL8jiGXRwIzTUZkSeHWjCTGuODWMbHg800OVg+Dvs=;
 b=0bRcxLLUlrZlpabtVhTRwoSy3K/9q1VTjTF0Q1O6Xf7ESNx8P13nUSmDLPhHwWiiQ6KrwuYIYSZEw4gQyGeKSvQw2jKOGrgqPBdYoRwJSw6uvTkO0jkJLbjplRN7A8MS2AwF1IFcF+rwzvwo+etcJBqGD663/DcB//R5dtzPAN4=
Received: from MWHPR0201CA0088.namprd02.prod.outlook.com
 (2603:10b6:301:75::29) by BYAPR02MB5109.namprd02.prod.outlook.com
 (2603:10b6:a03:70::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.20; Fri, 28 Sep
 2018 17:13:38 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR0201CA0088.outlook.office365.com
 (2603:10b6:301:75::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Fri, 28 Sep 2018 17:13:38 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Fri, 28 Sep 2018 17:13:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5wKf-0006ak-BY; Fri, 28 Sep 2018 10:13:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5wKa-0004HW-7n; Fri, 28 Sep 2018 10:13:32 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8SHDTRW010121;
        Fri, 28 Sep 2018 10:13:29 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g5wKW-0004H1-VJ; Fri, 28 Sep 2018 10:13:28 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v4 2/4] firmware: xilinx: Add zynqmp IOCTL API for device control
Date:   Fri, 28 Sep 2018 10:13:16 -0700
Message-ID: <1538154798-6828-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538154798-6828-1-git-send-email-jollys@xilinx.com>
References: <1538154798-6828-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(316002)(217873002)(50466002)(48376002)(8676002)(34290500001)(50226002)(9786002)(26005)(36386004)(2906002)(77096007)(5660300001)(81156014)(81166006)(336012)(107886003)(63266004)(106466001)(8936002)(486006)(76176011)(2201001)(54906003)(7696005)(14444005)(106002)(44832011)(426003)(478600001)(47776003)(476003)(186003)(305945005)(4326008)(126002)(6666003)(2616005)(51416003)(356003)(72206003)(446003)(36756003)(16586007)(110136005)(11346002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5109;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT055;1:/6sOOsgja0vS4w7pUArT9mfRpzKVyGAJo5AhOLeRjHPIGFpZqSjdgQenHvaYjHaCE4pO3vHDO0Lw+mtf8kCAU5BSh0LbzrJBIl15wzXaKp+9/hG3ukoHF9aK1c968b04
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a97c4f32-0a92-4e83-a0bf-08d62565bb42
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5109;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;3:nhMpvr0iqgtZeNuJGQc7Ur7e474xD8TsdmS4crP2XtrG5hiouSc4qBNEZux6nfSmYY+Jg8SYFPzGhpycc7L0tpcKMX/YcrP0JPWZlRmIakzr4FP05U5ftASc3IXwqpQG/xsX8OFKuhAin09Y4ndwjDLSxvOGFKwqglxlXvcBaRyt1/0wNI0ugD6RB6eFf0vL5pY+1wwbwoVtIFJ1PzebuRq75SrvqgukPTeKugRTR036iYBdlQWvERb8oqR3ZhROxzwsLWab8iVq5BIwNXSbW2U9LQtkwRShaWt1F0WditFCH53VEkNW8515JdIkA3ooGwjRxlzxJ4uefN62xQlqasJVwWBNGXxKRb1izopNLx8=;25:FkbqqUv+5Lbs8yQNd9hnETYEIS3Hhi8qSPes3DgDZhdjGBADfd7CE668aa3tiZ7amGwSw3UrwSXs9Gh7m41fzYkpyE/ONQW7OA5//UPOKyb/V1kYCBqSv+WDm1qeiUA/HyL5eK6s+lXQRsdrzK8U2YBbzcpB0RbBr48/7hwHso4MLbslCz0nI12ytB6MNcTOGVLx9dMa+iYmeKdecIRr2c5x4HsU80jECh/ynP+TNlYaL7eDo/tGQOGEJ7uZhx2m4TQ0y/m+Hv7sIQCUpRjNzxxZiRvO2Slrf9Q1VVNQtJrA8bTQfefCscbJegar4OYXl1HCf1EjCUS6ZJj+sEhhlA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5109:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;31:4zqVl/OV21G4wGujAKyOKpUxt8MDE2GOOcZfqYasDy7poHERaKXXvUp3aE0rXq8qAEykz+b/k/REmRh5DYseHuHFMR3RyBDZ+QdQLlt5AROh0QBsx9J5vBTW2ADiEQnlk+4PjNQ5x8VMsODR8dWuF0G9jWDlG5yP6DNNgor3ryPwxcC1i29JXj+60vZQkMBCzni3o3SeuHVV+WxsPacTo3p/dgXiuBhUP7CNvmb0YCA=;20:icY+c3IAx5kF9qpJ8G0N/+zbXmmKxivSAuN6+yt1U6WGEh9TT0Ug+PmjWnsWUPToEPiu8MGlaeHm6SrWo/ILbaykRxjtTUIXlUvfJV6IwvOEyuAjuRhlj8ke63gyuaiLYvYxUYh99vanNGlO2qs13yPV77FNj0PNdbQ0JSJf0naW6T/6Rwl+/VQZtrH9LIRlQ6MXoMIGIPrYHHCeszB6eBlbgulbDBMA4UoVMIlb4SBFio8TA2Hv6fOf2Owks/oxOnyhTgqvBLXGccXnU+cMyYm4s7AINz/jfUd55Y4GZehKCbsmzKRyXhQ9N0xFr4gSTp8F+5fgvugt1QERyWeHjdN4MDyazSyHkF8ka8vAxV9REtMYYBgotgpNy7t3FF2kqzLMj6naw6mjt0VBCbBF6QuoeJGuMZXBZ7U9z/QFEK9sfhbHnBywqNSHEOnNNbljoAy/AzLexfHr0cJkRQuuLP5Sj69Pa6LSxFFUTqApdeaN4pxZyWedSc9sW8CWuH9X
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB510922558ABC213A5CBB5C66B8EC0@BYAPR02MB5109.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:BYAPR02MB5109;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5109;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;4:MKyzH0xhWL6mmGdY+AeKgfqR769xVsQKC4EbUQHn/54UuEkOfw7SmEl8K5mYHdsZLJPVeJcYRI+Tx5DXUNuGuLFNKxD5IH/AkFW4x/dgDoJlAYw6INWPFeDi2NKGmJ+iGTuBc8B1gp//NzdgxzRJs1QKrlCD3ZU2Xm2QCr3lI6d/+NDjYG4nBLTIKyWhOuWfEbP/LFwMB15zHPXoHShWPQoH2ynP0aKWfx52O56FhjT2s4uQKZhVH1K5Nf/xmbzl9VwDO1uv/TGPnFJiearHDuLw789/O5c5AHTMFgAHpqQz6164ZWCN3ZAj4RzYVz3P
X-Forefront-PRVS: 0809C12563
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5109;23:fp+8ETQuUCGVlMqd72kECtCzCfBvr+tOpx4yXQ3q5?=
 =?us-ascii?Q?u5ZoMaOXwiTY1pb8+Q9grOQuRSNHU+MVVtVpxq2RHfA1Zj/DhpEH+uXoFg4s?=
 =?us-ascii?Q?lm/Dg11ZwbCCcx5RxGgpkBkEwLVmf4oDgrLvG5Q7vbkxZFSa1vs1z4QUj79Z?=
 =?us-ascii?Q?ixz2Qs5DjiuNYBuHhDfC+c6dNVH01wQLufnCdEQtxTfajVb4YHc7jt0hKrj6?=
 =?us-ascii?Q?g0epM8tfK4wn6vEFr5eZUkWDX8oae58Ur+DyCc7vGWUcvzKNcebMrw1/ruhz?=
 =?us-ascii?Q?Wtd8yuHp8WDLe4HoubjKX3YOXRLtOI+cSr/aBx4D+wDfzcVcliglP/7+r9tS?=
 =?us-ascii?Q?PuffV8LLeCH4iar8yDQx/tkW51frYuvTahMzgHDClKQKl1kJRjNhSUOLyMqI?=
 =?us-ascii?Q?cObBA7qd/48N1HynyX8iaxaD11V53wfE19Zki5iEVxPu5SRELZpmsWrEhT99?=
 =?us-ascii?Q?G4ebPVDVRrHy6kae+OBIo5EgPdIOYYSg+j87dglXYfbL7JEJXL2dqtkSKQuc?=
 =?us-ascii?Q?qduBw+7bcG4v7JiS60Ksz/Hoy1HYqofX5opDPXzBYzxCB8F+8QU/81Q58/V7?=
 =?us-ascii?Q?EPQmw8FCdaqQ6Z6bsouoYSebzB3R09NN77qEJekZYVSezekv8ZkYD38GdO5k?=
 =?us-ascii?Q?CTIfVpXIQwIjuhnn0ShcMM6FdqthJGSE2Uw7aZqfHVgaNDQhzJkiuTZm1aOu?=
 =?us-ascii?Q?iJ68BDxwCFo6uiL+u2yYS984nUpNOmVh4p7IxcwftK6/lF7fQtJAks1kuMrv?=
 =?us-ascii?Q?nsWsxyQyyrCZarljqTSuNyn461+RzkWZHEJvjG4Z4VqEMb9t6OzfiRkfMLMF?=
 =?us-ascii?Q?3FH3pwqLO/NPOxGw+za2e/PZjkmIHs8zGerzYfOyN7q52xN734uK3g5+goJF?=
 =?us-ascii?Q?7kY8V9etat9ZrGo9onJgCJz8K5OphpcrpfJ6Yivv5D4yf2Iok/2VszDuIJKv?=
 =?us-ascii?Q?lAYRmUEdVW1Lxe4FCZDYSmVKY6q7h+2TSKhUnSttUz6Dxzr1b1lkmtsk47+A?=
 =?us-ascii?Q?YWfJUfhpv2kJTTwn9ku7USpr+MjnBUswUT32gvb3OED18qcLtLSY0eCp7kcE?=
 =?us-ascii?Q?NCR0I3ej9qWQm0iqc10wWenEg3UK6w/dw6DF1eqElOXLMxERqGmVPrp1lZtz?=
 =?us-ascii?Q?rlbXOdJdIkSIm+Q3jJj/+u0yTNN1GSCzk+GKXIdoXXbV8P9ft8NiCJeomcL3?=
 =?us-ascii?Q?+EvrhgOkYNchvnWIzEOMwHaN5FibnsEiHxtvOwAsVbq2kRkOI9CW47ulQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: +he/E/ng4AJ2rEIPuz/KawemE/MqW260pmuGloeRNB2kWAMm5QGtBjAjBbGKX2DbvKoyhFLJ/rRqEttb8xHLnHh33iWSGBmYpTQtm7VtHAwdznTPsGHfmBfe9EWXUagKJue68/A9NCOjyI4cxZoHwXrN2NUYZGHWv303EHUFQZYPTSB5CCi7G9z6cadlRIaOmDXvzZq1V5rFPlssYUWeeNwz1WV9RX1Kot3YJOz2tWnZTzl51Vk/Ng1j6sSjTV82+2OcpiIyk9X6kpxUy9foKXo5GeoULiVOWFb24YzX33QTSiPREOOSVepv5/X8H7JtL4rF4N7DD4t5Ol9TBglMJXrw/atTvb1ocq6Nyw1gvpI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;6:P9c4hG91Bk8QZQ3mOmpiTvJ3BdwltBoFW5CihKBbRYpHJggvD4jWeFGk5AeGr6JBu/2yxugpi6Uq7+0vaIfdIkXtjFotRCTC0oQi9ELda6WeMaX46qdIafreUClxu1duCMiXc8OBTSZQrH1eyXMWXh8uouAhRcfIQoxfwkj65zlel3WDV/YaDoUIyMl9dPGmFKHLtxQ1pfQ1b2A9d26C7qguKZKuffB1bXLlKZItxndFvoTuAQEzC8S8rRXdwbQvZOE6yEEHmPaBBZyFXXGfYAYhlODuwSr44yLjW4HXpDLgd64l0h/9/LXF3w8j4qAV/nXBxvh/+C0j99CfTGswqkcRaK8/y3bTiw6Gc2uRPL3CmxeFzzUTRSy2fEAWWzoTpt6jrS1qAgIFzwFJrkt2dfKEI5bmkLiWoS2v/DMpKQKrDVSumNHmqBVfQNMKJuCWZx7OjtKgS3LqUuREcHiukQ==;5:7+0z3OAbJIq/0s/dvQDJQz7NJS+BGcmOEjBg77Jt3QCNoyBWVazGDP/nVA7cZdSqHqSml+eB4QxuhfdESmHgc3CIfTHx3u6KksDKqAjoeU8twrU6jefX+ep88kYKQCtJywfE3xqeS3peUDmeaBzLc4hLjnIIPeCC58g/jV6W0ZM=;7:SDUt93g/QD2+j4go642oTNcwmtRNWhEogj+lyFyg0qY27Ap0vSOGtLoPgfZ4Lu5akq2yyTtYyDDmKgfjxYKLPJU/1A9E60Dpl4AS6ccj+zLpqxYhJWge3OJlnSyqlM8wxsKwY1T42gun21O56M0Wz34RrjXK4u+Hw7Ai3hNjAcyBivjwqd5CvsmSL73/od0QVDAv98D92EBdivE3QpIde1imXbbZ57zchF7KKdPnW55e4gjf9SJUjNAl49J3NGTq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 17:13:38.0634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a97c4f32-0a92-4e83-a0bf-08d62565bb42
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add ZynqMP firmware IOCTL API to control and configure
devices like PLLs, SD, Gem, etc.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
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

