Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664CDC07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12F92133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WZhJXY9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12F92133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeIMApZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:45:25 -0400
Received: from mail-bl2nam02on0040.outbound.protection.outlook.com ([104.47.38.40]:32944
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728122AbeIMApX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UNsEm6qWM+BLviGUoFqUWQWsLdlhA6BgENc7GMAhoA=;
 b=WZhJXY9ejzMQmSVyGrDCE7OmOxLQeE6tdKT+KRc8gkpTvh0JbEaYBnhIuHVJJ/y0g2ieCNujBsfkAnjm3EfuqVp9HVVH3Y2L/oDw2qdsaVnPoiu5iXVOvFxoDZvsohcnKay83TpwdO2VYBMxT6PpRw3qP66g1BH9R7TWuNlFJs8=
Received: from MWHPR0201CA0079.namprd02.prod.outlook.com
 (2603:10b6:301:75::20) by DM6PR02MB4764.namprd02.prod.outlook.com
 (2603:10b6:5:18::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.18; Wed, 12 Sep
 2018 19:39:16 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by MWHPR0201CA0079.outlook.office365.com
 (2603:10b6:301:75::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.14 via Frontend
 Transport; Wed, 12 Sep 2018 19:39:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Wed, 12 Sep 2018 19:39:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:36133 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0Ayo-0007VM-EL; Wed, 12 Sep 2018 12:39:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0Ayj-0001JA-Ax; Wed, 12 Sep 2018 12:39:09 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8CJcx7c027622;
        Wed, 12 Sep 2018 12:38:59 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g0AyY-0001Go-Sh; Wed, 12 Sep 2018 12:38:58 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <michal.simek@xilinx.com>, <arm@kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v12 6/6] firmware: xilinx: Add debugfs for query data API
Date:   Wed, 12 Sep 2018 12:38:40 -0700
Message-ID: <1536781120-22794-7-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
References: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(478600001)(4326008)(476003)(76176011)(126002)(2616005)(7696005)(51416003)(446003)(47776003)(63266004)(11346002)(106466001)(77096007)(26005)(186003)(356003)(305945005)(48376002)(36756003)(107886003)(50466002)(426003)(336012)(110136005)(316002)(54906003)(16586007)(14444005)(2906002)(72206003)(36386004)(106002)(5660300001)(44832011)(81166006)(8936002)(8676002)(50226002)(81156014)(2201001)(9786002)(6666003)(486006)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4764;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT047;1:6zurgu81BAhXs/P776F1aD4mnK5cD07FcwZOHvtiZYI7RRngx8kUCn3IwMR31FdkmCB1LzuIttxWEilPYNh31DhmDyeMr7p3ocIlwnPYyheqFO2y06+46GA2t1ayLn3C
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5dc3503-8383-4f94-5d6d-08d618e76c48
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4764;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;3:jAH8xX9tOg6DbLAJkOjQDprHjiPJ+vdsut2ECrhzIPV2ODVq5CELhrmeAhRshp4ZeTSTGt1r3LwV/3+l7AnH8BA18SXtwHFZe6PRpgE1thKNJSP/BSMdJrB0UWjmkWIgGuIQMWSiTHroRbek3NgTFCI3kUgzDsLYDI+rtMW8SxYZ4ndB8RMA8xlGqsjfeA0VMsCcqscTlk0Dt9kxq5ElbOfjNNFdfdp9gmoISAHuA2aPF2GLZF6ieIhbKCFuBYb3KNDO1m8wgz4dks8Z0nUxUeM9GkZnQ6hReJ+jLlIyDo5HMgo8J+8ZfU/nq1CQxplGJwG7vD5Uzfg3gScH7vv5DaFHc7gY6dA+A2fhy6luZfQ=;25:HnBSY69aKX53qi7B4NDKApo6j4aYznwjx1yUs1cgtN8J0RxHgeumEtX0NtR3Mbyg45qFSYAHn3aoxHf0Swz+l9XNk/Qt+wsQUqigO4rzRafzalAz8fW3IPRV/oif7xjMraYTA12FwIc0Zjdq+l1oq0fsVJZD5iiogAijvHHR5m4PzrfvyK4uFVifdDqwaYEN2ipZX6B7/IOrITlih+t8ZKX6GE4kLN6P91TlA7cGb/xoZjUNt6LtDOpQSBP90lgtev3PwVr0YStwz+nOES7wSXfEIl1YStl9HZL4oFYyzYji8n2kRCzY8n+9gH4szWT3/hhwx5IEvYW6wjSyEjKubA==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4764:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;31:kWuW9RqfK7wCGM/hbRTsx5kfh6Dqo/1vyOc7+iUa2iJc+zYU7BQilNvwUq7NOXuBPuuZGbfuPaxuY+P5kIGpq6O1QUHYaTo3AuWjmUSVqgZVqh+rsQeaqecMl2W3+nXnvjlYyEMaJYBSFyYPCn+3ljcDefSqtawiFudB7xU/ZPDNOi17EoYMroLSNJJ3stGAcKx9jEBEtHxBLOCKRZJZSltmDqqrxh5cERIR1KNAyo8=;20:+DwkXLDNjhDxRZXCVugu4ysISTAnjgxpvltTo56gPi9RLj+1En1chlCEt90Awbefq7AcKu7Gk8ERj9y+DQz+b4qjUIofJtyEljpScyqE78us7MSAevQyYwHVZui7LhfQ/Uk+XYOfUJ5xgG5f75aOXEDbFxo3K06bnLoaBP8Skzhavh3Dqs33+25GkK/L0KQEnYKO1QBPQ8lA5lTfxePpV/oufSj9w6aHCKMWP3BkXSM8MolL0Ih1SckEkW3EqCZRFGXXhzJzJJ3wSG0uCvL65Ut/sWTOrRqCkch/gk8B/XvpVUMDC+CTElMK17ioIZxTpRjYCV4Ny5jA0L2zFxfd7IVaLSniQhCCWNhMLxIdYETcukpOrr++4WvywJKk7q4qx7htKz9lKfywhcDrIe+2VV9xGTRMG6AUJAerqt/4xPrJqtRRFGH1M1eQixWHYHYUFJnedyb7qZ8n68lAXbo+9+P1nwgAb4rY74/ioI/gHkyTLTmPNuQHyR8vv5haFONe
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB47647ED753E6D097CE76A974B81B0@DM6PR02MB4764.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699050);SRVR:DM6PR02MB4764;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4764;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;4:7O/2qksPgBsnKErs4zrenf13GCtYRkmpElPiwIM19a1GKn1nPlPB8EnEPgz3a821pqEf3tyIDVlnb762KQSy8ae+opzJGgF9kwt8AuTw1N+HJz+dapeaZpGY1IuK4+ixOB4z/9ZxfDaHUftZNk7nKh9i+LY/iZ5o/GKf0wfLOfHTCnk1ei7kmhwhdGp6bJIbLK7OJNORuJsTOJbYX8b5w1O+Et+Mh+G2fCIV5icYEqKNj19Kq2rX7CmC1NBDqnSKuR6SUvFcgPveSs16pDdlvu5m3vbRvJh+Aj/6nFlu32tHk8DiMw24D3zcodxE98/r
X-Forefront-PRVS: 07935ACF08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4764;23:rZ1J/c0UFaMjhNlsOhjjB2L4YnUgrfbYHiI24bCjB?=
 =?us-ascii?Q?J5+/Qs/ZhI5G0PL6eVBOvfBAm3BkyMoF4L/xYdLC1QOJTZFBVSNDQpjG30W1?=
 =?us-ascii?Q?4ym8KApoROakE6qETFNqUWBgS4alxfz6aU0teyCY6cAdZ/rPpqPERtkbTJAr?=
 =?us-ascii?Q?br2xy7ras6xdfQtzcYZWd62OzvK/ol0ew2AfSrmPdmfUP1p5SV/jIYa3Zs+F?=
 =?us-ascii?Q?VHfMPDllHh/6yA9f8xb/x1FDm8OM1niQSb1k8Smyog7aVBQuEopdwdjYe8v8?=
 =?us-ascii?Q?XYWnyKsHi7YwltxR2QzU9IqirQKU0bxTY6LOU8LQI86pU6sGT6FvxRUEW02g?=
 =?us-ascii?Q?1Jqx9r2U8E2W9iXdNIIkKd+hwyNvwRbozDwEnu033SMvxl4hawJW4frqvgGZ?=
 =?us-ascii?Q?2dHcKoHoPRlKPbWHp7w6IAMSULDk8PJBnDh+njjJZjZ/4KOabw2rmF6Xk27S?=
 =?us-ascii?Q?5nBKgXuUlEEecxw+/UbWYuvd7vy3cwdm2ujyqztCBhfxuS4HUr5X4n4Xc1rm?=
 =?us-ascii?Q?9p+sajsL+dMpTy2HL3pqP9Mxo6slimzwbepkS5QpTHTxUSC8UevWs3bSD5cO?=
 =?us-ascii?Q?iHnTJBkcO19kGXcMDSlIEvCZTuFSpgjd7dU6/RmPwfAQekBsee2YQYu+2noE?=
 =?us-ascii?Q?xOz38vhMHXYvkrPSRj7w2BMkJ1fsWTYpu741PHZp8oEhuMT3Rj0HFW8LTHyW?=
 =?us-ascii?Q?3QmX8VOj5yMd0AyZvTqNw4GeWef6RJZR0vAWdlAE7HfCXG/AnYwtNejSTJ8M?=
 =?us-ascii?Q?mWYXTebZ+UbCq8shY11FvKm3nboGz5oOgHfSNeeroRF0xlM7F1Hu1CpOOCKP?=
 =?us-ascii?Q?m504o4Z8byY3zfjrK1vmyEvq5zznxIq1miBJ0piwmk8QSwx4ZfLV4SUgIOyM?=
 =?us-ascii?Q?KVcNRFz26wD280NIEzHwyi2dLV3lDPk0X/NV7ABPeC/PAoODNiFJEAssjWBy?=
 =?us-ascii?Q?u/ZF6rO33MSFE4OHfClnJioEUde0dJZpAelCcHMLwhBjvXHI21y65e9/LXm6?=
 =?us-ascii?Q?9Z0gAhpuHynkhs1jVlHCDZsxhduy2P1ttB/0+F0hFVFfPqADk2ylYyp8NjMJ?=
 =?us-ascii?Q?gVQPk57ePpFAnc3gFSG9iX78vCBuOwIEQnJslH/osn/bin2LVaGBX05VJvus?=
 =?us-ascii?Q?YHQwClEhn+7PMqWc9+ZkuYiMPfysfq5slvqTMSkAcTBSM9OCsqoIO35+oUHS?=
 =?us-ascii?Q?A/uk9HaQHlRziQhpDWAkag83FZL1N+UvkFxyMrnWXaZ+FWaxjZrhGDh6A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: BbfHav9OSSSOHW7FT4mTmpv92U2vpzeXPg3Zh70JEMe4wEIcuyvaTMoQoFh9NIorcHhvtPvgNsJJu6cC5HIMqKcKgAO4GaNvDZxCXa8gubK5teAbAioAKY6YydJ932EISKVzvjTuDUaFTGwJckXnFRG3rkCiIpFs/fVzfc+DB1r0fIOInknCi7hxw6rOCb963mV7BVq7rs5df/VRGvSXUUHCLtomzWpHvSGJZpsXvbW319AR/f4OppKhPPWgn1bhXl/F+fO1VbhtEIM6Jjtrrdgfyf3hhx9Ul1PN7yRGGOmZJCibNlBgSYJBAy1kqvEqR5p2agN0Wp5tMNT2dZtIZTQy04mqKENzEKnzQcEiWsM=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;6:dHdPPJHWiEAR7pvf996yAAMuNZzcEtEQgnq07gzkiJu7dTTsochAqVvg5w8oWru5ncYRTEThajJuVvxiW+Jd3eyRFD7hKVPMpfUjTztWtGDodPpO1OYidEVzmNs1cPGIn8gOYIYgIjrT+hFjcr074cW7tBduG3/FB4DmClWRPZAzGN7rRuqRuD471WLPMuYB6jTr5r1JzkE80w5iUjETQmd/MGGPysGojpr1Y5WBAdiZEcG8dhWPnzur8u5b7HW32RbgVhLaUzv6tUtcH7aXuLzaPwKiPIuhUE+m2XZgnaksiwYWw23Z1riXuRcTzMsyIuhpU6Xp/XlvDluC++/5+awus99EQFa2YKX7v6/CAqj+U6igogJPSxA+P86GcUzfafUC3bN6QyKW/uvaz4FK+6MP494HtgvmxDVw2fZFxrdWgI1Moim3ICO0PYVCztbH8/m/zV5+u5jACD85AszHaw==;5:HdZmiFoioELwO1fmc7b4JwRCVatzRVazqgSWJyxk71iKaMgJKmfEnTti9iDDtsQrYXjCpBOSBcHEjmPTroEluklwoqp0rBohgOtPTc4CiuyEFIIb7Wxb4E9GE5wyePXSh8rGLcdoWjL4hUgOP28rIfgiwOdiSWzdKRk0HeZkXlc=;7:eWJdBiym2cd7khsVGxXWiKsHSPa37Hxl51f3y2T8FUYcMNcytK6/Ixlj3tQMmmBSP9b/KQw8My1fAtsnV6re0PY+7/C4fGXBjxhk0WQStPMoX9am3BMqzto4eXUbaric20HfmHWNjqxAfSstLBejazH2u2W1Tuw0NKpyi6BCJIs3dQFCgsVopRlpyO66+sz7F6Mj9ZjDEhF0cCeSRFLjQBnPki7ia8HXijIqe5IDuhcXnrvhSJbNRnIryh5AVl+b
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 19:39:15.0822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dc3503-8383-4f94-5d6d-08d618e76c48
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4764
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add debugfs file to query platform specific data from firmware
using debugfs interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index d65cfd2..2771df6 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -32,6 +32,7 @@ static char debugfs_buf[PAGE_SIZE];
 #define PM_API(id)		 {id, #id, strlen(#id)}
 static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_GET_API_VERSION),
+	PM_API(PM_QUERY_DATA),
 };
 
 struct dentry *firmware_debugfs_root;
@@ -87,6 +88,7 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 	u32 pm_api_version;
 	int ret;
+	struct zynqmp_pm_query_data qdata = {0};
 
 	if (!eemi_ops)
 		return -ENXIO;
@@ -97,6 +99,32 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
 			pm_api_version >> 16, pm_api_version & 0xffff);
 		break;
+	case PM_QUERY_DATA:
+		qdata.qid = pm_api_arg[0];
+		qdata.arg1 = pm_api_arg[1];
+		qdata.arg2 = pm_api_arg[2];
+		qdata.arg3 = pm_api_arg[3];
+
+		ret = eemi_ops->query_data(qdata, pm_api_ret);
+		if (ret)
+			break;
+
+		switch (qdata.qid) {
+		case PM_QID_CLOCK_GET_NAME:
+			sprintf(debugfs_buf, "Clock name = %s\n",
+				(char *)pm_api_ret);
+			break;
+		case PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS:
+			sprintf(debugfs_buf, "Multiplier = %d, Divider = %d\n",
+				pm_api_ret[1], pm_api_ret[2]);
+			break;
+		default:
+			sprintf(debugfs_buf,
+				"data[0] = 0x%08x\ndata[1] = 0x%08x\n data[2] = 0x%08x\ndata[3] = 0x%08x\n",
+				pm_api_ret[0], pm_api_ret[1],
+				pm_api_ret[2], pm_api_ret[3]);
+		}
+		break;
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
 		ret = -EINVAL;
-- 
2.7.4

