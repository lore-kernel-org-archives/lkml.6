Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7D8C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4768208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="uL2Cfcos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4768208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbeG0MMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:12:21 -0400
Received: from mail-eopbgr720048.outbound.protection.outlook.com ([40.107.72.48]:63666
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730801AbeG0MMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FB9yWd0HQXV68b5nw9ZGImMlijl749y+ECtXqj+ht/s=;
 b=uL2CfcospjNmTEEK3naFlLn9OUCDhzYem7lHB9ZvHqOHn1YcMJk5nwlGQVb/crKmXnotyYXWxckcjU8fBYiRT3qeYhUpgwcdi/mXHDvV3iK5ect7CvM5LD5pjBCGu8J1+8YV28LoIxwPacheCr1Xq8VpnZaxd0PSqPVPyfzDo0I=
Received: from SN4PR0201CA0003.namprd02.prod.outlook.com
 (2603:10b6:803:2b::13) by DM5PR0201MB3511.namprd02.prod.outlook.com
 (2603:10b6:4:77::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 27 Jul
 2018 10:50:55 +0000
Received: from BL2NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by SN4PR0201CA0003.outlook.office365.com
 (2603:10b6:803:2b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Fri, 27 Jul 2018 10:50:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT005.mail.protection.outlook.com (10.152.76.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Fri, 27 Jul 2018 10:50:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:35385 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fj0Kh-0003mt-K3; Fri, 27 Jul 2018 03:50:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fj0Kc-0001O0-GZ; Fri, 27 Jul 2018 03:50:46 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6RAogr8011878;
        Fri, 27 Jul 2018 03:50:42 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fj0KX-0001NQ-Qx; Fri, 27 Jul 2018 03:50:42 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 05CBFB2085D; Fri, 27 Jul 2018 16:20:41 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>,
        <michal.simek@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <lars@metafoo.de>, <radhey.shyam.pandey@xilinx.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dmaengine: xilinx_dma: Refactor axidma channel validation
Date:   Fri, 27 Jul 2018 16:20:38 +0530
Message-ID: <1532688639-32230-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(438002)(199004)(189003)(81156014)(81166006)(5660300001)(305945005)(63266004)(2906002)(126002)(478600001)(486006)(6666003)(476003)(8936002)(106466001)(8676002)(2616005)(336012)(7049001)(2201001)(52956003)(426003)(26005)(186003)(4326008)(36756003)(36386004)(51416003)(90966002)(356003)(50466002)(14444005)(103686004)(16586007)(6266002)(47776003)(48376002)(110136005)(446003)(50226002)(11346002)(316002)(76176011)(106002)(54906003)(42186006)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3511;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT005;1:eHp7vXRLaCYgb8JHJgVfMC11R/axyEvsMv92YkB/iVViXQF1qLDUhTpA9yc/DhAYwOKc4fyZ+w4LeUXL+/xXE/E6jNpGUN4w3MKJitM8XeFaDwcBviycZpANW13bXx6F
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71f85369-beec-459d-8f9f-08d5f3aed3e0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;3:0/TfJbfoDox652HGzaGVy9gyAmWIs2AZ4Wz8wvMmFmEVqqgWYZU+xBO/H6DaoPz8aQ/6hnhQG66Nc1x8hHYIyVWhECL4C6kCkBkN0Be8Xg4qpmN7q6dDF/iseilIAJb6llYGx9fPufWGxXHypBp5ruOmG/H9pxGAyxAQfdhaH4pbQkSD3/2mwIwBBHnJS3m9bNILlXHS2DGSFI1f6cNS3dpAR0L3nX2povYLUebIsnQEVguoftqV7sTORXsDobIiUjAkqqRNdNuolVR1tJ45BwJj+w2WLVrXPK9ryubW/S4A0di20FsnxOcqx+T0o1ztSHQpx7zzGwa+Ax1BlLbmwUujcnebk+4DI1szm4H9lSU=;25:hi8GSGz8uywLrmmbR4ZIpt9JvUbbUwace/Z1xrITG2wlj19WXK0egaTSzKFNA53C1kQG35VKI8O+LpUSC+U7EHDPi3pEc6vJfIpW/fimcFBlc3FoQcyhp0SbnlvCH+WEfi91BOuTcEFmZrEkRGoAVYatYLpJlkJkBUmBT/jcDY/oZYXrta5N82AwNbwv0OhcQvuVMMVPm23sMm0n3Z1PLwlj7ZerjMxEPBnpGCCjf6BmrBkWSXpCS8fjaAfGfb0SeA1r4A5PfYgClJVFXn2oWvpaKAIP1SWS7IMswBnCLBJDe8GgZa+6jv84evodsjeoadBYWWybk0hf1KPbbBJOMA==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3511:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;31:iZT2Nr5V34ICniaVcE6EqVq+JFAB9olY/SwKjH9drDVHa1svgyAyEj+RvBeUQUUkgDiDzgncvs4ZlJzPMh5WlKnYJ5P6xNKgG7Df95iDWCOY3Hx68H5YRT902dXy/y8n6mbJMjvph16+hAe/S0RhWo2LYd+5sn/8t4+2q3SuddZ/FaggISt5lLCm5/sAA8JsDYQQpDkgYJTKl26vg2utkiGAb6pquJIJ1NykCZGZEVE=;20:Fu10YWpu71nSBODkKuEVAAnZJ5hkfSHT3us9UatIiZw5g6KjoRZQt+xCHeeg9qqgpF5+ZnCOS8DpkhPGicL3/7DdEs/GTT/ZjqTvgfUlphbrh+U8Ehr/o9xYpZN1t/TniG99W3NAg8bdSBHU4VfqZaUk+HI2+sJHUqMk7wyEIEieL/QelDSUf+6jISnDblv9fctEOs5BOYfYf5CQzCzQhwV/c0ByDGeCGV0+4jK7bNYf91NmkP1cmQ4g1dOuQ1hhmqgmungy4j57/bwKO9ezUwC6S3lLHLxY3Z5bn0w2nHH9WRv6aRA0ynFwezf2QoR117w5P4qcyIWWvh8ydnfsE45DYmTCVhsTC9BqnpJfd9DkQ2QAoOzxlYsaP23otkErLBMwQqWw0awBx+/gHRr5OC9RNyRZ3Aa6PQ0a2FYw3sAWqu1BRKppQoWW1xt8vPD5yRSIi73RnXKFv/4BfLsniD5d3Vo2xR+RluyjR+VnNq+FeuMlKqqKzOb6lWOujUPe
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3511242CCE32B1A4ADE861AFC72A0@DM5PR0201MB3511.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR0201MB3511;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;4:dpJWby4s7JLklpAgXmVIUY+P5baZuu/FzK6p6Z3i/kLqmZeMpWGQe2pv9fAIoB8KEucAMtWBYiNACzCu2pEnT1iDZbDQk12cAaMWcRd4/1EM956F675qtOtmfXHaVlufneSKquvLSAs4HMi08AR5uaOh/AiotJ8BInGgCfgPsqXbiLYL3FR4nGgFTB6KfAiwHC9X5jExGjyVh98e0750NGoarLS54X2SJmPjEP/peiwmtREtHcsOPdihAnMgUAn0Vm/Z7c1IeH6eBPTrVc2l5mahhIRdwDYVj9ih/Ezih1rFgh2HoRgW2SVt8imSs+zP
X-Forefront-PRVS: 07467C4D33
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3511;23:b3lSDxNcGhl7IT3vP3CNJIa9LuuUUzIbudIZmSe?=
 =?us-ascii?Q?fOeYyY655MdFd7JHnXB7Sg2JYd5IlaUsf7rktP4aX9TTvELf8a3BWCmZ4tpo?=
 =?us-ascii?Q?KlzBadPQDGijsx6tIuthkDhtKvX5EYFeWopJPoGX/b+qjiPMaWHno5ZVXc+1?=
 =?us-ascii?Q?r0yDK+1Qf84r4rP1rFLX2tuoCGOCnTQ8jj2McP3e686I3RL4kaBsYSnGVszZ?=
 =?us-ascii?Q?SNA+Z007m/2KUBNUt5EjN1DfTFhuXC5C2l09BZnnfzGg4z6i3l4sa8To6DKr?=
 =?us-ascii?Q?saHnsKnlqhRx5/CPMtPb5WEmDTRsMh9ifS/Z7IrgoUtY0l/yQGtw19L3W5+M?=
 =?us-ascii?Q?9NN/1tpC0/KWWiuv18hYH0n2t+OCXWwMvHJPbh6wrLfQxf0eu6c4zn2Ja32N?=
 =?us-ascii?Q?1bCoTI1QY+ibF/Pu0alwF3uV6YJ8EUHV8PZmCfe7IYt8ittN3SPCr1q3Lj2v?=
 =?us-ascii?Q?yLG0/86sWcBTDjn04Cvzi4MGUiT/O0kg5iwgob1diQePTT5VlVGpe6r0kcTm?=
 =?us-ascii?Q?9qoW+nMQgTA6GafrI/QNPTGWoddWW0NBVFJKk2Gau2bib8jYKVvZiu1M0+wb?=
 =?us-ascii?Q?EgWmuFvF1QOPKzzpSsEegMJljdMkzGY8A/uXCWS+dKAJK3e3WU2mG7ilpAm5?=
 =?us-ascii?Q?gkDqXuTJ0UahzSJkY5MyqqacNp5zJgu40VOQ02iz/hQMTs6iCcodoHi3VQfN?=
 =?us-ascii?Q?QkN8zlasNNUnUETxC4MpnOy2HvrO5s8PpdrSf0IeHlpfYtWQE+Vp2P+ZfdVw?=
 =?us-ascii?Q?3EtjuAbk1a7PiQtguUHsf0jXRdubE0qMOakJNtp7L1lwzj9agdalXR8aGwqE?=
 =?us-ascii?Q?8THVRduW7f83UEB4i0tqivHD7MuHH9610/3FtZJopK1vwWdwb0Who8Mp0iOF?=
 =?us-ascii?Q?wJoNp2WaUbt2jO4tbtmcGDDEzsw7WMmmyiMJEO6GlEfO7Xryl7dwjCpyGphL?=
 =?us-ascii?Q?1SqoZ765REnKKnot3uLEyaF5l6kEcZZQ/ybra/xtdWEYI4OWo/cT2iowsFD+?=
 =?us-ascii?Q?41Yh2iq8j5/twu0k3/A7n7+dJBjwITOIfhwp6uIqfiWDLKyw+RKJzTBFIvhr?=
 =?us-ascii?Q?3D0kdMX+IJPdrYAreZ4bCU1FxonncnT9DafABMejbWV5hBKkfo7oOnm5EMH7?=
 =?us-ascii?Q?3PRv7k9feW3xjCL6u2InRAbYwnPSGPsnG+gV98Mj1Gw0kH2M5pKIXpdNx4y2?=
 =?us-ascii?Q?eVo2fvbWXa30qpIqBH3BejQB0Yfhp9Zl5kveuSjZoAYq39a6G3oGG5UYyEw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: FkRQxqUvBhAcoIfeM9It/1u1qyj6HW7u1AJNR+tfrcZf6vP5akMn/wc0p/ibnreVJ5qomaYJfD8/a8jR72bn16KvY0FPeHxAIfCeFhl/bDaJdjVVuFwp/fMk1gzh6UXSmraZTpzaW/+LAltVXMzs/PQguhUL0ePNK8ct+M+C3cnMfwBfSL3Jf7UDfRKuUUYfUbv0GxDjt6v83S/qjDc1t2jx9Rdh9NS+qxaqPoKILR4+jCeDWWVYdR2XErL5EQyN4g73tmAtXC5ZYr4GcOQmWKzrAiLOj0KGrYREhyLQ82TX+gjy7ICcvHN/ODt8zMx+ycsLj+2IvaoZlvlSmqEaBSIf3T0x4GBNieacRjIJmj8=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;6:zTxAeQkcw5JinkpqqHAW8f8nClBvjIgE3ztqgpGul1NlOQuGGicSKt1DLEn8f2qTjiVB+BIpr1g7cm3mzSJHk25UapAjbUir8znMtM/pXYl1n0FJovxukO57Iiq8xQ7t/ImXD0PH18yZNkt2Yw1z9g9zwiUqPP5StRey6M/0Xk6zvVok3/eJH1hwI+Kyt2HozEmejoJ9ZmcXOuwieSXi5BpI2HptEslMsERvpnLQ9+fUXNUiA0GjqAqwZwKdcBWJIbnPR6V36FZ5z6v/Rmh1PLv1z3okOGgTlQZbxLelZjEoRLoE2I/4iG2Gdo53ELtoQlO3mCc8xYPHiUna9OpIWTEUfGAzN/HVleB1zs1J4XriXSogRc5RJj6Da3BMsc4MB+aqQ8qfGweeMGwZdDPTitGhSo0F1G76LkG/7hTxA6BfMHao9agH5ZIWkowQcYoNinB29stGWr7RaxG60RpigQ==;5:Kwgi8HCn8dhPrQTvu/G1j4+/iHnRXrG6WZrvY5uQutusi257xvLvEVYNdw1lTtdyObgQXDP3iGihFDyE9d2UoRfhk0Y6eQAfgdGRqjiw076h47DGhr6R0S0Orr+sbb+r5uJv1pIRaCk4IsQYkMkAQ878LkhTm4EbdFaI59sMbFA=;7:QQcHdwznQAYjN9RcXLG8NW2UbzA/yJczzpZFAovbtvP4XMxW3oUehlGULzvrg/j7W+gDbgUa/dzabl4z+s6ZA6ksDEtPBKwZtIpfBQQfw8C5Lc608H/ACFK98V/fQXzZGWJ9XZ5YlR8/RrFTArDKG3O8cC7142TQi1feUiht/HSbVl4NGVN5sRrH802/djBubnsbYb1prV31ZrVrDCDPF3gqZR+VeVQXsdjnDP7BYU4m+Gy66bniRtVnptzPTpO9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 10:50:52.4392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f85369-beec-459d-8f9f-08d5f3aed3e0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In axidma start_transfer, prefer checking channel states before
other params i.e pending_list.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 06d1632..a37871e 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1271,10 +1271,10 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->err)
 		return;
 
-	if (list_empty(&chan->pending_list))
+	if (!chan->idle)
 		return;
 
-	if (!chan->idle)
+	if (list_empty(&chan->pending_list))
 		return;
 
 	head_desc = list_first_entry(&chan->pending_list,
-- 
1.7.1

