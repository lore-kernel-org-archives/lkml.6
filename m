Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE3FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443AD2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="woSd8AdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443AD2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIEVNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:13:50 -0400
Received: from mail-eopbgr700056.outbound.protection.outlook.com ([40.107.70.56]:60949
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727413AbeIEVNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwJl7SbKGF2BvikE/n1DfiWb/xSOVP4pqneMyaAQWzI=;
 b=woSd8AdICmOYF7ZG1TkCATQqiEs3+pI+dL/VphQk1Rb5s+3mEGDjgcaneCU3Ci5bC3zUYU+5RETaiq3DjvDCMKQnya/hgaB3ft9mNlHt3hSE+Eyn1ndmqJZX/02XFikSWej9ZObNArso60jg2b5UI9jhOZDYnb0q6hNbD8OZZLg=
Received: from SN4PR0201CA0018.namprd02.prod.outlook.com
 (2603:10b6:803:2b::28) by BY2PR02MB505.namprd02.prod.outlook.com
 (2a01:111:e400:2c39::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Wed, 5 Sep
 2018 16:42:45 +0000
Received: from SN1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by SN4PR0201CA0018.outlook.office365.com
 (2603:10b6:803:2b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.14 via Frontend
 Transport; Wed, 5 Sep 2018 16:42:44 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT010.mail.protection.outlook.com (10.152.72.86) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Wed, 5 Sep 2018 16:42:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40769 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fxat9-0006t5-TE; Wed, 05 Sep 2018 09:42:43 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fxat4-0007Pb-NO; Wed, 05 Sep 2018 09:42:38 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w85GgU6T019953;
        Wed, 5 Sep 2018 09:42:30 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fxasw-0007O0-1z; Wed, 05 Sep 2018 09:42:30 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 4044A60492; Wed,  5 Sep 2018 22:12:29 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <kishon@ti.com>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <vivek.gautam@codeaurora.org>
CC:     <v.anuragkumar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v3 2/2] phy: zynqmp: Add dt bindings for ZynqMP phy
Date:   Wed, 5 Sep 2018 22:12:27 +0530
Message-ID: <1536165747-6405-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536165747-6405-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536165747-6405-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(2980300002)(438002)(189003)(199004)(50226002)(106466001)(356003)(8936002)(81166006)(81156014)(90966002)(316002)(14444005)(50466002)(48376002)(63266004)(8676002)(478600001)(39060400002)(36386004)(103686004)(107886003)(4326008)(6266002)(336012)(426003)(2616005)(476003)(126002)(36756003)(446003)(11346002)(486006)(26005)(186003)(52956003)(42186006)(110136005)(76176011)(305945005)(5660300001)(54906003)(16586007)(51416003)(575784001)(47776003)(2906002)(106002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB505;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT010;1:wQwQhvjx48VMHKpDtUKpoP9kxVjSFa33VFIe4YVyzIMpucpWggIUGPJHGr6WyQ7ejP2M1Cydk8g1qBj0G6Z5ioPtldRDS5M4tPJM0GFPeYyWditi6khZUbMQmcHLqO4w
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0719d611-3c6a-4fbd-cbd5-08d6134e9af1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB505;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB505;3:+1oyF3S8DVg0hiJMpNJ1cP9j3U0/O/frjGq2g/RWFttKUJ0dE2XzksdlBiDUNgOxizPHv2J3PUlstO0M75uYJCOKcd/zq5nuYea4sllWkAIAUH+h364CmMhcO8ajwLk/ReEuTbKLP3dMSeG+RZ7G8tG4bJVvHhhAZVxq4gczAyyIY3cSD1sBd/R4LhRqPCtdxKlTCqypMPoJ8CnjuBOlWkh53GtLxfB5CrFNBTW5bFU9hhsq4Ys/AVc0K80he3lDGqStMNfdFr/ui48/bb32Wf7VqjUrwAEPASx11OqmpAW1wiNCJHGqsP8qEDp4B6fSHVUv4ddSjeLalCm6tc7p79+eEC9Kxf5sq9x3v3NKIqQ=;25:wW89bDWMzBDiAMmLerScv9AA6tEDxd840RgSJ+Qx5M6glFhH8W4ADup7KugHZo2+bnY/ri5VpyJHgyE/5VafEGt0LoOj/5lAbcU7Aw/c1lRFyjQnShxHy/Ye9VV1Mhh3RKpwGF8lsWhRgMcskttVb1RH6GCe7JyxvG4xTx3gnb2LbaxrZKsP9cYqtdCWe5W0waSl/9pEDrYuDH9rLPeya5sLbX8Wn+In7v/C61GGoupz3MBNoxMhlZqMSue+ozL2w6I0y4E4froBnF8Sjmr98fc2i0jlcuJ3Zok5qL9YVe59Qg5hjywdV6iUUDAVl63ugIZv8c1AEkx0aOCvVvnb7Q==
X-MS-TrafficTypeDiagnostic: BY2PR02MB505:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB505;31:pgU+TEze0gEow+Bj2MA1cIGzhALp9xHJNn4/8mjd5PTDiVE/YoY8Cf8e4ofLYQ760yxG+S1AsHyjzztXgfdyyxqVl5n9fmnSDgFcY9MCfbJAqQF3+tZMfGq3ZMWvzll4izmFQPTVNHw+29V++jISMRuVTlnDh+uiw27E/sqa9fSq6J4urG5fNGj3nubW/V1FXInfyWaf/IY+9InOYKc415XuyKCxGHXvBSBPMQD9UN8=;20:oNq+soR+q08aci8HwUGUYvkiXqXGxE9dFBhVLXykmxXAk0jSXcQtbnkNBOfzDYQkK4q5IlkQvyRic/Z8EuRrv/9pvoAeC/hJ8HoCcCEeiiybgD/F4+VVe+jUW/DQuPTep6UFgUNCoUKIApMFDM2Z4WhdhDqK8oxAuGFs3tRcNQemnA+RbfWk6nzeGlzTRPyBoM9WMbC8QG190j6MFWi1mdjkXG9bSWy2z2jQrjt0NbR9p+7A14Rr4iwZqIUn7MQjb/EAushg/P1pySMgwHvnKf/88tlTa2r7qJuQHp3NPKtDArwsl5hztAOkRaU6/KT4AbzuJHazC8jrnLe5OO2N0t8qKyugEATGHh3XLdQ7E5O89AD87OxePd+Y7HxDrJr1wMadJ+Hn956OKMANTtSqc6jVSmp8l8vhaTDsB5pUZg6ueBsCX5l9U7iCR5neFfN6Enaj2oTv4UowptkBnbUCIHf6b2grRt7fhCsEeAkEZnmJIdGD+Y/CSCDa3vag82dd
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB5053ED2B29C90B7FBA64E06A7020@BY2PR02MB505.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:BY2PR02MB505;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB505;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB505;4:HNeReuWaekhw0uwFO1a/RIap77QUnFr6JNEVIiWUfvHnkE/nVIyW3nJIt+sgUNwUFVn8G6ckZQrXvMcp+ykiRXCVr95S08txy+SsqANMDydvpcsHpj1pzmhtD52Fbl8t7Y+jb90hh8MxaoAWGkqlEWZFblo94nFzJ8z3AkgTRl18kEA2Z+AQ2CEIatKmQeBvL9QB/St20LtANglqU30dsI6qwRod7tm8RIAItKiImTRgKZOQcGPvb1djk1WzaUU+9YYgllE3KbwfQgUjd5lrlujhoe2sA92/UnBJhLHn2vzqPTUW0TMecweQy1IFQMnx
X-Forefront-PRVS: 078693968A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB505;23:Ke2ANbVpnbHr880p/yjexDgsdTt06yQuDTBd2e41Cu?=
 =?us-ascii?Q?N8dPpVtpeixUAJLKP+PYA39XIuncJHi/D3u5yuyOZAQs+7FvAHjuTnA0nrJQ?=
 =?us-ascii?Q?0P95V29uncLlzgd7sbXuIwTE2zXucz8KNEKebcFXviKwDgbQlq/C4L48O9yh?=
 =?us-ascii?Q?123WHqrXBiJ2MSl6TYuTInDbOyIxqog5MO6+BJ05t/+bifE3RRW8SntNBoXo?=
 =?us-ascii?Q?8KAYR0AO98JUC/nIkUOSRYt4xrFq5DKmdd4p4XEqxlhFR2mzIzIQ4E9IePvp?=
 =?us-ascii?Q?nxpRKSjSdw5d3a9bHCQF6D399iOtHmmS0B3G6WkdBvJHtyrxR0BkmqMA+mci?=
 =?us-ascii?Q?Ti11Narj8hgPTq6ov4ygkxYhTiFCBpRArUjHsxokMGymb/HaGEUxHeKczoLU?=
 =?us-ascii?Q?qubpYPDuMJkqvLC547gOaQsLCYJm6uXqWPryN8h4rxSiVXfC3mw6fJxxkiJ3?=
 =?us-ascii?Q?vbQMnrVVRGRL3kyatFyx1ZRblnVj9Pv9gjcBwh+T8P6ZVNbzeN88DvlVaF5n?=
 =?us-ascii?Q?Qsnn3dAf+N7HQI5NQPhClDrpU76BQ83I/EHmfUywQCAxBTgoM3Mpfb3On10R?=
 =?us-ascii?Q?ydodLeupdZqTAu3T+RR/eO1Xz4BHX+cE83tp6pkRKrPTjEafmmuby8Kf883o?=
 =?us-ascii?Q?YwBIkASg9avKUwxhyoQxPRvEB8Qbhr0ImbkmxkaAauZ4lwsXVQd/nudjB1E2?=
 =?us-ascii?Q?oL/HRoRjYuip90q1tevGN8ZQGNa0nIlWequoNwpY+pcQsSRpTVo8wSX1mxd4?=
 =?us-ascii?Q?/0Rs3sKU/JPBHJCOA/D2tA9IhVDWt0S9NWJvu+EWxkarf73HdmhD14tfGixD?=
 =?us-ascii?Q?KYRfz+aH7oHIOI5xQa0WFcJQjFy2ZmLe9pMARdGH2KnLKYhGzadlyRcyalGT?=
 =?us-ascii?Q?FdwVtjYWlOyUxfHOCan3PKrFrJNgq6+KtPQCtgX2fOFcq7rhU6TNUZme+tDf?=
 =?us-ascii?Q?AYWBeokeX2J956KLPRSpeMxctc/vRiOaSBvPlpYFHpMkrSNCwUN+0g7Vr8bF?=
 =?us-ascii?Q?Xx7UqC5Ig8VJ3Lk1fZVwufOZY3ypyMKoYUd1REVQZduL/fZBHw+RT7zpEH4a?=
 =?us-ascii?Q?xePzIQhi1L1zOsEN8nfdpxhJH9YJxKCuvHHjS3K2BRY4SSjYHElxFlbsNRYr?=
 =?us-ascii?Q?G6p5f1fogcN8Bx6/6VpEb/tOmeK9uSUOHUSeWCoaQdav7jZUmZbc1Gqhduyq?=
 =?us-ascii?Q?RTwfPaAw4lVo/h+eftThb9UrpdiXmV3sag1FEkTEomQPEpKH5UxB19Vg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: k8zWkLUysEDYh641Q/k8VNvkZFHPPfJN2VUlTg/MJBiGFi1JqsHjKr455yvkuqJ7baDNvMqWvMLQmgq0+82cryHP2tJTh4/L2Ul8lqkmU0mGuAj/8whRZxUUr4vi71F86xWNq5vf82KVHfRv8nbwTxyxV0KRRtNJJUW4iJ3mNk6uLRN23VKsPQ+IVg83+UyY5fxVJqOnuzCYfPhgX+STw0dupKUEJz8t+rs47jX+yU5PWRn+w59WqWuTq0EtoGhFuDl6Oq4jgX0PuKjjq/APKAPQceiRGYNco55KaKy9AxgVYqyRTrWFi5BCO2Jns9eKgiBniKmhu9WY4ZZYsWNsl1OE1HJOvZBenVraaEiuGLM=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB505;6:ZrmesWqohaqdfrEmUWN+hmAT9Q11MLcOF5f/Uwn5LI9Ieszsd3db29qLkK8vJEZvoY9a+ZwSVqcEKb+h/3jxzQ9Raez7bx7AMNwtvstd+4HlcLyKnuufXNNW6BvrI6JvfH8fsmJIQIUnJMyehp0YY1jGUKIK3RdR4oNRmcdnXIPRjjCeR34+QbsFNV5n5y8rdmBs3HiY6t2eQEDV8a88YMvADV62CJ/0/r5YtpOCVTkP+tvxDbBVN+p2kQoJjZl0ZpE04PvjldFKNhAOZpxOpUZI9mfPaDADw1Fjp10rscBMgjHsrgJxb3lQR/Nn1sDsh257WquoyIhK0UgYtrfH/iKlMpewdFBJBnl0R8s4IbG+XxoDpHCoQP97SmPnPC7U3dHfwdaItpfTnk3QRfN2UpoAU0Zc0PA3bdVoUymBbXWGGtFzS8+wJfpfJCOrqQW/0MgNXqTu0+Z4PyFakxuiDg==;5:+VXqb42J3Qvr+Pubc0SYsnULbdZDeHcKYs4cXhlYQ7wlGsQhgB1PV280lN9qiBRdQkHigoX4kcqf+uSBLVI96VLdHJTUtzOR2ovsFNZhpMKMMOc/fc/DceRX+amDhp4wzMOX5l4cJ1fFWYp/25KnJw9bnNBdpo8z0BZdXgOid3M=;7:+FpGu1U6McabVnYKetFRJHcdGTN7CFzH5nm3hcJkSy4b5w/OkqqSHVSjw8nFDNoBOA6SD+Nl71CSZMijS2k5fXLJG4YQOugJX1q80VE9vxXWs04XalQFvnkJbXGw7JNyVEzgnMKSrtvqGGFIq857f0h11PUexjAZpZu9nXqBX1vZAJxrx0Zu2x+9VVZl5R8wmifDDvIPrJVvsaF0FezC98Bfn5NKtuGJpUvVa5AIHVJI96p6PW7bC30tbD1qdm7G
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 16:42:44.2105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0719d611-3c6a-4fbd-cbd5-08d6134e9af1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the document describing dt bindings for ZynqMP
phy. ZynqMP SOC has a High Speed Processing System Gigabit
Transceiver which provides PHY capabilties to USB, SATA,
PCIE, Display Port and Ehernet SGMII controllers.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v3:
	1. Corrected the Documentation as suggested by Vivek Gautam

 Changes in v2:
	1. None
 .../devicetree/bindings/phy/phy-zynqmp.txt         | 104 +++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-zynqmp.txt b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
new file mode 100644
index 0000000..65007c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
@@ -0,0 +1,104 @@
+Xilinx ZynqMP PHY binding
+
+This binding describes a ZynqMP PHY device that is used to control ZynqMP
+High Speed Gigabit Transceiver(GT). ZynqMP PS GTR provides four lanes
+and are used by USB, SATA, PCIE, Display port and Ethernet SGMMI controllers.
+
+Phy provider node
+=================
+
+Required properties:
+- compatible	: Can be "xlnx,zynqmp-psgtr-v1.1" or "xlnx,zynqmp-psgtr"
+
+- reg           : Address and length of register sets for each device in
+                  "reg-names"
+
+- reg-names     : The names of the register addresses corresponding to the
+		  registers filled in "reg":
+			- serdes: SERDES block register set
+			- siou: SIOU block register set
+
+Optional properties:
+- xlnx,tx_termination_fix : Include this for fixing functional issue with the
+		  TX termination resistance in GT, which can be out of spec for
+		  the XCZU9EG silicon version. This property is not required for
+		  "xlnx,zynqmp-psgtr-v1.1"
+
+Required nodes	:  A sub-node is required for each lane the controller
+		   provides.
+
+Phy sub-nodes
+=============
+
+Required properties:
+lane0:
+- #phy-cells	: Should be 4
+
+lane1:
+- #phy-cells	: Should be 4
+
+lane2:
+- #phy-cells	: Should be 4
+
+lane3:
+- #phy-cells	: Should be 4
+
+Example:
+	zynqmp_phy: phy@fd400000 {
+		compatible = "xlnx,zynqmp-psgtr-v1.1";
+		status = "okay";
+		reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000 0x0 0x1000>;
+		reg-names = "serdes", "siou";
+
+		lane0: lane@0 {
+			#phy-cells = <4>;
+		};
+		lane1: lane@1 {
+			#phy-cells = <4>;
+		};
+		lane2: lane@2 {
+			#phy-cells = <4>;
+		};
+		lane3: lane@3 {
+			#phy-cells = <4>;
+		};
+	};
+
+Specifying phy control of devices
+=================================
+
+Device nodes should specify the configuration required in their "phys"
+property, containing a phandle to the phy port node and a device type.
+
+phys = <PHANDLE CONTROLLER_TYPE CONTROLLER_INSTANCE LANE_NUM LANE_FREQ>;
+
+PHANDLE                 = &lane0 or &lane1 or &lane2 or &lane3
+CONTROLLER_TYPE         = PHY_TYPE_PCIE or PHY_TYPE_SATA or PHY_TYPE_USB
+			  or PHY_TYPE_DP or PHY_TYPE_SGMII
+CONTROLLER_INSTANCE     = Depends on controller type used, can be any of
+				PHY_TYPE_PCIE : 0 or 1 or 2 or 3
+				PHY_TYPE_SATA : 0 or 1
+				PHY_TYPE_USB  : 0 or 1
+				PHY_TYPE_DP   : 0 or 1
+				PHY_TYPE_SGMII: 0 or 1 or 2 or 3
+LANE_NUM                = Depends on which lane clock is used as ref clk, can be
+			  0 or 1 or 2 or 3
+LANE_FREQ               = Frequency that controller can operate, can be any of
+			  19.2Mhz,20Mhz,24Mhz,26Mhz,27Mhz,28.4Mhz,40Mhz,52Mhz,
+			  100Mhz,108Mhz,125Mhz,135Mhz,150Mhz
+
+Example:
+
+#include <dt-bindings/phy/phy.h>
+
+	usb@fe200000 {
+		...
+		phys	  = <&lane2 PHY_TYPE_USB3 0 2 2600000>;
+		...
+	};
+
+	ahci@fd0c0000 {
+		...
+		phys	  = <&lane3 PHY_TYPE_SATA 1 1 125000000>;
+		...
+	};
-- 
2.1.1

