Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE90C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C5C206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dqkPbD9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C5C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeI2Xr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:47:59 -0400
Received: from mail-sn1nam02on0082.outbound.protection.outlook.com ([104.47.36.82]:23251
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728446AbeI2Xrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzG8K3nxEtwM5xOo5aV2Dga2Pfeoax1nos7vIjey7hk=;
 b=dqkPbD9GDg9n2hHL1j5QdT3u+00h4KTrn6Cfd4e1oKdlenxecxiG9B8CrZ0N00sEMYoRu1au5ftBoLW893EDxInfsHuC0G/SK5iFWtM07OhgyYCUF0mqfwwec/lj7Ib2KL06+AmC96Otv4AqxQ7VFdshdRK3CFodCV180RoT8ts=
Received: from MWHPR0201CA0020.namprd02.prod.outlook.com
 (2603:10b6:301:74::33) by BL0PR02MB4468.namprd02.prod.outlook.com
 (2603:10b6:208:4a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.22; Sat, 29 Sep
 2018 17:18:25 +0000
Received: from SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by MWHPR0201CA0020.outlook.office365.com
 (2603:10b6:301:74::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1185.20 via Frontend
 Transport; Sat, 29 Sep 2018 17:18:24 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT008.mail.protection.outlook.com (10.152.72.119) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Sat, 29 Sep 2018 17:18:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1g6Isq-0005ZF-0E; Sat, 29 Sep 2018 10:18:24 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1g6Isk-0001eG-Q8; Sat, 29 Sep 2018 10:18:18 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8THIHHD003734;
        Sat, 29 Sep 2018 10:18:17 -0700
Received: from [172.23.37.150] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1g6Isj-0001dz-Dr; Sat, 29 Sep 2018 10:18:17 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 9A98C3C32B0; Sat, 29 Sep 2018 11:18:16 -0600 (MDT)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] dmaengine: xilinx_dma: Minor fix and refactoring
Date:   Sat, 29 Sep 2018 11:17:56 -0600
Message-ID: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.199-7.0-31-1
X-imss-scan-details: No--4.199-7.0-31-1;No--4.199-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(438002)(199004)(189003)(51416003)(106466001)(103686004)(63266004)(356003)(34290500001)(90966002)(305945005)(50466002)(2906002)(478600001)(476003)(4326008)(110136005)(54906003)(26005)(186003)(126002)(7049001)(6666003)(48376002)(5660300001)(81166006)(336012)(47776003)(36756003)(2616005)(8676002)(8936002)(6266002)(6346003)(81156014)(426003)(106002)(16586007)(50226002)(2201001)(52956003)(42186006)(316002)(486006)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4468;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT008;1:GOTh92HJ5oOu7Tf9wTVSq6wpY5/fI+XVqUE16tkmPMry1cP8IfzCNlGM5cxdvAFX0D5FK7BUZdtFxI/7Pr5GSg4AmrgTHCe0/k+7JSq5uGENF4tDDuPUrqAXiFP975Dk
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bafd1787-5f37-4233-ec34-08d6262f9052
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4468;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4468;3:KZBXLHRzZUzrzn3ELR7dGByxt3tizeAch4NeyFqiKYnc3Suy1FLBlXGtmu/acO2tYO182fvLoPdsEYvc5J2M716TA6OvxslMlpfg8Jpb8TCdnmRbOJTwnHmP/p4DWmNkzTNZnJfWDiRFXIC33VYkH5SkS/CrN9AR3LHkhhIKRQKg81k8OV9j5tD6DOQXAEZbIWwZ1eh5ND8N17shG2vbahdJSzeE9oji785csXUaJeGHhf6rXqxILxqjfewxSKqSRtsI0+lJRqxvAa4Dj1R4/xY78+xaRxFZn1E3YPticAiadnHzn9x8CCB3l/y5xb+hmdH5nIq+4H2/xmZDwcFQbqQ3imwbv1xijtzkdAcNfW0=;25:6DK5OoLU1NU9z/+I41GTkuU3BBHZ562HyQzmhw0bvP4oBPOPkWc1pexsoBsriOSZ95gKpTcX5YQ25j+75/x1BGspYMqvogh2hsww8EwIqf663l6ZBjXGgXRdD88LdM5GmVs8zSh72T7wxbJ8+vxZMrWOFu8H0vQ9VjyI5N3m6Pc+i0WYDrfGimlU+urP7/63eAbpAMmxANQuNOEwDD7vlrhcVBW4NKe8eflL1WZuOp4ceChvde5Z4G95XpgYyZO/JUYFSsjtaGf0WbbM2kiA7t676Mpt0ZZA/PVhDR5PcI5TqOB+5zuPyxQFm1PPm+DE1EHL8byJ1IxoU4H/ot1yRw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4468:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4468;31:xyYWOHU40iaqgiLJ6VDDG36Iy67Wa180W9Q+USuZpPiS+7jr24IW2ITCnEAmbyMVeuQ4dW33ntng4YFEheNplxeo84XoFu3AbXyhxL2yVY215MZAIPfoUorNrG0bJS2G4jL5cLjy0hOlF0EdTWgQOmR/gf8B+eDZsRklkZV3QLplGWsU6dkJWt5kCsUPLpXWT+XnUpGI0KsvbS7azsou79YGjJK/abM/ljphA3vftII=;20:yh6U79tDOjotIiMvKyCMAHFO1LfhIdcciV8rqi8bf1taPj4xLmmj5oSCs71S2V8K+kZyOSoGFgGstbhRmT1VVSGLTziyYRSXiHXwA+octVh7ZOMYTkgtyswMKS4hdX4DfTcRuX/tobBRI765rKsVF6Ts5PLgRTqZEhxYj0kCdAslcpJ+9xoDFb0gQaq0RPo+gCNYoap/kIK9vOB2FTX0jhpdCe26BYQlXuk/Bxejrjizb5pize6nZiBHLDQ9JxYK5aMFQmXrYT9bDmNioyzRobLncMpxNhrBiZazeydcNtbazgFQCckZGpei13fExbtulwX3CtL7R60u9rC2ElvqWl+To5wxVQMz3/oHi5ZcPhYmQk2/Y2lLJuD9Wsk0HrZXFHndQZj3wBBAV7EiWYAVdAKvuQWiWDk7NjPyfE8qa8g2bfH7AxKAx5kW4VhQogaFP+HVTdZ97k6grT8rRNYhU8K4r/itwFbLphhKze8mMJEXeQOP57T5uutdVxNVlAuD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4468C3D4E9D6FDA4F1BFEC30C7ED0@BL0PR02MB4468.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:BL0PR02MB4468;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4468;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4468;4:gg+Uy9BA+ohnTV3e3btb7dGUTZDvbVHvH1rsA1NlpG2ueBgyHtk7deum+vJz9i0UlaPfORY99XQYjdJigz8H3btQhmNLHP1lwtc+qav+TE6abMmxUy67Fx2hqPJg2HC2v7hUHvietgt98v1O7uw9YKkVI5dxxjw9I8598MVbhy874QlJDwAo2Er4w4b2vYOZaHVR5VTM9AQtACN8GCwJRfCWN4E3sBP3RgvoOztIP3wDGznGMZdzRV/kSQ2lPomeDCB+Kmpjdrgi4WWPe22Zhg==
X-Forefront-PRVS: 0810818DA0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4468;23:Qp/iEUCPY3IvK5Pa/oZDuS7N5yCQkptQrPjmeQ9rc?=
 =?us-ascii?Q?/CHqtQliWP3LdLNQFIt2ENegiFUgc7AUUBF9obLIxXxN1BWHZn4IS6ZVz9M9?=
 =?us-ascii?Q?yzO8alzurFfOqmyou5AJgzfbo3EivrhVjqU0iIP2ySrJv0OLQHJOSD/kEjtd?=
 =?us-ascii?Q?SSvr/RLg8S11tp8x/fMJZ/zIau4QWW6zTCU4yAzn2HxL7bXKThZl9PqswDoY?=
 =?us-ascii?Q?LlGuiQk9lEC/rSj4zvCTyIbd710N1bPPdzT5amLfnFPCzzj/fZzEqXzR+ShB?=
 =?us-ascii?Q?zvGI9QDhJ+dJ2SjIMaGhDsTkOMFk/G09rJySFUy4GbgaGbtPb1rufBLseV0l?=
 =?us-ascii?Q?NkZXw5vZUyEWKOkLdh36zW8fN64mlvSYowBiQhKZunYMz9LY8pJPLKbR+4LU?=
 =?us-ascii?Q?lDoOhTuUguc+BnKR6lSnZ+D+Y+Z8EhnFeAtLtM4YoHbuRIsvdlILKwR2EqsY?=
 =?us-ascii?Q?gI4AD8JB6/wLJSbJKnr02tpkGeHm8ZZ+AqDLnYaY3X973RII5dgF0urkSDxU?=
 =?us-ascii?Q?NM5B5rjQLkINAjrNpy/0oU93j8aZ/YR6siS1/Y9HD9oSR0/qkQ8AChAZCCqK?=
 =?us-ascii?Q?A8EtMOaLG+AybljpmAQTAhv+bvhvQqYIYKQF/0L+J4LGfBp3J3eu0mzQUtIo?=
 =?us-ascii?Q?tRoaYxmHRnv65KWxvXSvnJjvAqMC/5kVWRECjs+EIYXIE/EKKOBtr8nTApHk?=
 =?us-ascii?Q?Duuyj8d3OawsXDrzKAFfFZQYDokJQJotRvJxyQfiZjXBslv0xEJy0JcnUAWr?=
 =?us-ascii?Q?KFUBhaWRreOco9nkfjhUImct3EFWZrDRnQQ0s6zju/F7Y1//L20fqppUXIXj?=
 =?us-ascii?Q?VxW2cMgrEgbtkWWEzCdfSSFH5BVGpX0h+GCeBuAoXBZDoYcNmsEhqbs+ujEJ?=
 =?us-ascii?Q?11rlKf0NCWDmzI05sJ1RkkwgOlLKmgZebNmkUYIur+RdHRyfpgOLgt/1FgFm?=
 =?us-ascii?Q?R4lx7FTR8KUAos34AffoqW5gJ9ZI+75UeMQ6zUxVLeu8tumHhK0I+fBu+2vH?=
 =?us-ascii?Q?WpZwpMoGGMtOTZQZ4y6bFFalOblRk0fgkIc1j3VAb2WcQ4GP1M+gfpFD6PGq?=
 =?us-ascii?Q?bt5296C7SlEgpco6qrtPz+UXvVqAHqE+R1BoI4THJuzTibFqgyegegMjkgG9?=
 =?us-ascii?Q?zqj9ZiXs9ZAJ19IBSBKQ54WJlIV2MP7?=
X-Microsoft-Antispam-Message-Info: c0eEk8LwUIjoMvDMxyzqnWF8m8FhiJKZzxIDSP/snngfT+qgIS0Q4jXkitHS3jmnmLvWQN07Z037MGsHfv4uSwTWrvu38yjRcgdl3lK2rHP8z38A60YVxXb7Aop/TCb1BdPmBSIkg0jqVoBYscMAqqjeO9HuUEFh9Ql58RQyh0Q1F3sQim3Noz4BdtNeNQOjJ4BQC+d++MOflDg5fc/OL9i02BMf33nfjiyq2KAFKJUmC1dg1Cg2bMS3FI6bYEy7b0BjM0QsnLMT5eoW+s4fZfFW3bSY7iRB0Wi0m1w330C6ULKvPfG4xk/BqVTCdbQ4/9dvdO8VP/PCy/LfyuthvzROIbNGhemZEI33QnIldXs=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4468;6:GbL0lm+cA3VAea08+Crg3TrLG14PhAQ+33d+H80hOoxZYIV22fRkkBIp0xpnBLN0iK2E/h5ZoBf/s5KVgI2Q7ngENNiQ8bWYOPayD4/Et3f5OIje2Xmt6yRkLJzBUbZEFGw0vApx7XZbIPV3urGh+IR4+aKQLIN8aGlDY/806R+RUbwlUqAdimB767OJ07xP0iRSaBRZ/6eSMM1U6JcMNucAPnwFwOe5FqW7mKgsBfICJEBjd1nYrWN35tjP3lTrKyJ9eiMN/kbSRhgBiEw1SIyOzdscOPX+gHOnRqS44O57+4hYNF8avp5XNruIAS+rDNi5Y5nIZoBMnqf8IClAgI1s3c75LqWMOmY1iiIHDvB3eX0Qn2dgubVuvoHjYb5C1drRKn5kHMDZJpkoo/XKMKgsoQlDi/SWrZmxYNJXDRpoz3oAdoK8FmEnoEyM4PEQ0neiiz0TJxohPGKg1Febsw==;5:2bXd0h+9mBgzLWvWZ2zO3x8kwHS7m5v77uOScJ3PGhRSXhgcdNsG+/q45iu36BxiB4yRdc1OQxDeiZJjhTIKy/9fkDUS9QDrmrlNY11fgbsrmInHfE8wC8+qfvst+2M0wHoM8ca6Uq/i99lGQ3Cnyv4eT/+BISO4E7wdcIGcMTg=;7:WH1Djgj8YsbiDjSdnb+O6tlgiOFU5rRc5qqCUl2xLRT1DKbA324bWPYkmwlGPoI5zeiPcTgnm7NYZVIn+MMYoQa+k+uOKRjg7c2MVhi2C8pyMNNiYPSUZn27zhlbq+cLKsYQ+96xdERc58WUww/BrM6Fbc1yV1cHF/fd+x2Yrnqbyq9zNOuvhsvJyRYAMhiJnQGXU33J4DqMJZ9fRkj8YwGq58QtyHBUhGMUfDHLeUp3/IDFApd7QCPYfJgsVG4T
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2018 17:18:24.3676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bafd1787-5f37-4233-ec34-08d6262f9052
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4468
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes 64-bit simple CDMA transfer.
It also does some trivial code refactoring.

Changes for v2:
- Introduce helper macro for creating dma_addr_t from hardware buffer
descriptor LSB and MSB fields. Use it to fix 64-bit simple CDMA transfer.
- Modified commit description in 2/4 patch.



Radhey Shyam Pandey (4):
  dmaengine: xilinx_dma: Refactor axidma channel allocation
  dmaengine: xilinx_dma: Refactor axidma channel validation
  dmaengine: xilinx_dma: Introduce helper macro for preparing dma
    address
  dmaengine: xilinx_dma: Fix 64-bit simple CDMA transfer

 drivers/dma/xilinx/xilinx_dma.c |   48 +++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 22 deletions(-)

