Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC248C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF682082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RFCEFmq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF682082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeLAW1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:27:01 -0500
Received: from mail-eopbgr700084.outbound.protection.outlook.com ([40.107.70.84]:64747
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbeLAW0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAZZpPBI2xYJtIm+BYQ4xb3vKCMWGQ/krb84ZoSfsDE=;
 b=RFCEFmq3cCWbVAg8uWH3ByYFBcaFmWuljRHoQcOU55Yk8+rDPNI5axZTgz3MGx7L0ZbG9U6aBN+odOPSw2mmc30PL2XdE/1lfcaO/lAAbjZEWKLasLGhSqc18L0nPAmPTdVc4agh23nHuGG+GQuR2iWK4q9BMss05hifUGoTaes=
Received: from MWHPR0201CA0026.namprd02.prod.outlook.com
 (2603:10b6:301:74::39) by BL0PR02MB4324.namprd02.prod.outlook.com
 (2603:10b6:208:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.21; Sat, 1 Dec
 2018 11:13:46 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by MWHPR0201CA0026.outlook.office365.com
 (2603:10b6:301:74::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.18 via Frontend
 Transport; Sat, 1 Dec 2018 11:13:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1382.18
 via Frontend Transport; Sat, 1 Dec 2018 11:13:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46492 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DU-0005oG-8u; Sat, 01 Dec 2018 03:13:44 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DP-0001kp-46; Sat, 01 Dec 2018 03:13:39 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB1BDY02015263;
        Sat, 1 Dec 2018 03:13:35 -0800
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gT3DK-0001jr-FK; Sat, 01 Dec 2018 03:13:34 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 9403C6050D; Sat,  1 Dec 2018 16:43:33 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v7 05/10] usb: dwc3: make controller clear transfer resources after complete
Date:   Sat, 1 Dec 2018 16:43:26 +0530
Message-ID: <1543662811-5194-6-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(396003)(136003)(346002)(39860400002)(376002)(2980300002)(199004)(189003)(186003)(50226002)(8676002)(81156014)(106466001)(8936002)(81166006)(575784001)(110136005)(54906003)(336012)(5660300001)(76176011)(42186006)(316002)(26005)(16586007)(356004)(478600001)(6666004)(305945005)(90966002)(106002)(36386004)(51416003)(63266004)(7416002)(486006)(103686004)(476003)(126002)(2616005)(426003)(11346002)(446003)(2171002)(6266002)(107886003)(39060400002)(4326008)(48376002)(2906002)(50466002)(47776003)(52956003)(36756003)(107986001)(921003)(83996005)(5001870100001)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4324;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT043;1:i0H1tIxGY0uBe6syQOiP24+s7xP6o/f3Q74NRIkrolYh/p1bZphrL65mD3loaoEuaE+5KRizEvN+fqziqKne3a3HaKP5rDRBYLHbdUAW6kmFbSmbcktVSnVGBTCyOscW
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb2d18d2-50a4-4c00-b4a6-08d6577e0f8d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;3:bfBoIYcdk+iShPwQnEM77jmCgH6xV1vAdEJfF5OMXg/Yl2i0vfihRVndUNmDF9obCQFJ/ra20SX7p8+wRGy5I3IhPy9vFdKwXBGKktIjNYnn5aXN11iFI5qrl0+82b0FZjBZEj7kYh5rWMnjV9PEW264fYYwFttwaCTpzDrnFLKQb4PmoCzGSS9F8S4sqn5bwybP+x9glR2jvG5q9Tnc2bKKIw/QsjdVjc6zT+4qYRgHPSMBl1Izn2Plfn3rn+mAPt4aHbbRArUmHQvNPPQysHAfA9mMM7ISy7OqkyIH83hX10ygoKUjbHgPeML4dAwdhHqNa5CK5dDeMQpFz2SaUXnmpniDvm05BvJeFozzBF0=;25:iemV+8pCF7dNBEfaaxC2IVRi2IjkDYXWpzBjjAA4VEJ/Ffa4rfOFtrh/IJ8WQzXTDUALfwsf4s+Neia8a+9/MPQxMhLtQJMGwXt9iUvFgXGnf6P3nndytlyW03AyUyO5BfS8QifFqebiqO7Dm6cV6PXuHQs5qlNqZoemWeIpMr86X3dXylCDOjLJJ2Bs3hcw3etUX160ROVKh6hF+ASA9g9gpZXLU+iDX9aDS6o2/3OVZsd/OnuO8/s3umFnnXMnLI+9/nFi+Wu5pbPKzJj6ztMtBbjf6bJB5Fezyj3QXhfWCkhVDdtI19WHQbfpYfYCv18gEG7pMdChVH6yfmJalQ==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4324:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;31:9psmMIPHLfxZUaRRMk4Q0YxGkgIWR1uKS0YKGvX72/PXIjPCaG3Rzrpwh5OyAkQosxuX5OfuQI27RDt0pg3wzySoVg2SsHhCNJP3Pyyzz9TaM4eDtrOVsi0u+IsJNBaCfLu83FS59i8QCQsQANJ3IyAy9Lfa4ZmbgS6/07d+qAMJ+vvXg/QVe03kk8QTJD4kl84b6kE7B/VzdAQZK6E3EhxVMaGJZl05JUWwKEKx+Go=;20:GM+NFochYa/wSWsjSum2a0MbOCDaJNjOK7wfdc9aPR1wwTb35zSap6hNCrrrFu4H4rNApJW+JuBdOyeVs/OcHJwvSjFQ85smVNvSASM7GtapWlk+nbGRKlQ5wrmVMCmd6HtZWEqbcwdCpWPSAUihylBxIwNcnznWvgznTjitVjgDscgEc+2PXR2ZvAtQN/gKkaM8FvXduigoA0RcVJg/lVz6/LQ6tvohf2pWq7QFg4hUigcTU8WjqQ0qmdIdZo8CJj4HFdrD3MUjqehiDccFkl5J5jbqQsAlz5dT658/c2fpp0R/faR7LH1ujWeA+dRRUsQz70zjGBhKRV1Z3J3ZDFZ1MudhWL+e9qXT6/773Ube8NW1d6+IMhYPwSnG691wZ2+cCO3XITDxZyzlHIoXLET22zQtcS2pxMFl9sqJ0wwM2ua/NC4VNWGP8TlCANYcHp1nxAnyaa5AkE9+CGjfMQbbFAlwROpOvrHoYcBMyxZ32w8LAif5Twp9Zp+OlERJ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4324D9317B920EB6646B77CEA7AC0@BL0PR02MB4324.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231454)(999002)(944501475)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4324;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;4:BCJ1kJ+jnpgXZbfyhICYUUcrFOVaB5Wz80J5szYvZ8ZX9dy2Zqei9h+rouDO3Fy8mYZi8yUIXIqAKcyTSn/x6BWUjuxkLBHtS9aEWqcEOzMNoLJCnNwlCFQ+FbVb7PNDWorzvMvK4wuwIli3ZgWCBihj0ElXL6KbB0Q/4ownCmelwpI8RdzXGKIOC9dWSAErvLMV8gquF7SfVpQNB5FoULuoLpY7B6xUWfbaA+ChtqVhDHCfQIm553dlSwjux8c7kq0P8sTB+gYO0jNbppn/MA==
X-Forefront-PRVS: 087396016C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4324;23:HH91psHoY3P/as9Szmqc4D16ulh6fBdcZnq2q+EMP?=
 =?us-ascii?Q?1fLFq20PdfnGq/nXMt/npDAlUVzQDKSGHx29QLQBgd2EAmFL8rvNOUWcihl0?=
 =?us-ascii?Q?ssKQnuvjwn1PbewwNulBGSzO0SINtBNCWKA96VaPN3O50otuQL9ncfi2NZ+v?=
 =?us-ascii?Q?f6xGNLHc14WN3Lm2dIcp8R7h6xaZpivDCjO9krzVH8UlTvGqOv4SAE3Lnplp?=
 =?us-ascii?Q?yswlYw2zdAmy0X0Nd1RtFbMxh7riCXcWrrxzajed3sak/JXvj9IVGvj+zu7k?=
 =?us-ascii?Q?IMuUH99PUdERhDsDYnlvLpZl/rgdRDzyUBgaSzsfgWi5LhewSBncz0ifsL7Y?=
 =?us-ascii?Q?eUz09kXcqjMJqwwXnB/WFyXedCcE87sw4yuxjSa3H9QN2iUYUGZOySEE6t+/?=
 =?us-ascii?Q?RIajt/T/DLIvVoc+IEqNzLZ2P9CCBjcMcI1HKx8T1cM7E6AQ8QbMjKQpUISU?=
 =?us-ascii?Q?F4ezhnJFQNkbht5NkGqXRPrehVJUehUj47woEpxxsqv1ENDk+FYe473WHnyy?=
 =?us-ascii?Q?w6niBoACsx9MkwpFWtATBhBDV6DVcaHRWWRpxEZqZNLJkXQPSayApE9rDBI2?=
 =?us-ascii?Q?KtitjWm8FMA4UbjfHr0Cb/cEjmruC1zCoj6G8qRPfDOplFrWaFr1r9AGsO3O?=
 =?us-ascii?Q?a4nWtujXzj7wZHcKD0aiIlEej+QBB9EfI09Jxv6Nur7fhiJN20uuMDinFTQF?=
 =?us-ascii?Q?RSqvM2np3N9lnjncAZ6RmD8zchVvIHbex7oSoUdQ+IKOxyHH7YDBdi6Qthts?=
 =?us-ascii?Q?cea9eD41+VuC0o0guy80ZE7g3JGnRi4EQlvOe6Zkb5gQeQB+hLY1w7WCuYkI?=
 =?us-ascii?Q?1tKRPtJI2zWuHycbCEL72+wJHbInAQRJrxQYFPVwQEd0OCPr1Zaa7b681zKI?=
 =?us-ascii?Q?xbtZwFUmuUn/y47R/MS/jgBvamu9vXf2Ud03b4PCEsSqI6kkW18FNoWCnb/f?=
 =?us-ascii?Q?Ux4TOPcJZatzG/pk+SezqZO6xgJKoUBtzFa70I39oFNE/YC9rV9EgF4Ke443?=
 =?us-ascii?Q?oj3oORFHiLELuOk+6gYCqEYYg0Ec3iQDsq/7sgv8/v+XrqfQfRiMNoZCwAA1?=
 =?us-ascii?Q?MbNci6SuTcJoFtnlNucg++5aGvBQtXrYRt6OsglJ/Qzyz4o7eCmOafucu5LC?=
 =?us-ascii?Q?8pTO4nFc6xX7OVJUhXHoh5uV9YMfm76VHe5T4cmfosN0MKxXNHhw5dQQnDpP?=
 =?us-ascii?Q?PSqpGJWKI5vbnXF2latNUcABR64pqoDaahF2yjUW/VJ4lBTVagxn5c1gGMqK?=
 =?us-ascii?Q?/TELQKzW/Br6mvqK9hKQlRU/QZEk+ISnajxgKFGfDBZho7kaC80Nn5D2lKnZ?=
 =?us-ascii?Q?3shAKgsGDK6NS8nl2JHk+LojiPriJkwDYOMskbar0zN9pNm/Jv3fvsGuGAQt?=
 =?us-ascii?Q?EHVVw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 4jdV6CHOFSeukrpm5qdGvxZc64T6Wv2t8dR+pL/74hqp3MAGCkkp4ZQ7x/YqyYHs0zKhc5BMxLaub6dsUYr3rOTYbcKXzfku/iaZT151SWnY+Mp9LuRDFq6sxD5I98W5T33UV4lKQOiegwHTelhxPlcHVNpyYbyovvPabpcHuAfMhhWP0jl86NeVGzF9w1Fxs8uqJZxafD+NuYnI2V0+PHJUv6pktr+Kh+i7unrLi5ZYM2P2/D0sVfITp3SjMs3PG3rNm1iLZZ68omHakL5TpfzLXXFJoM0dpbXX4SW5khDH0PHY7QAiad804sudWfbfjUH8Dt7YsxB5BWEa837l+nHsfuRXl6+Rr15TV/ueIvA=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;6:jJxq1Bbztwmb2trWVqQeobwJV2mgV0Uah/TPyY5MexdIgWZCH552cxDM6bNbeBF6PoPu7vYIJ9Y6CjUzUeLkQSZ0DiJcO8/Rrl5gzn0GWj0SlFFxhARhK1gpin5162qZ3thhjE8FwghmLZf0Xb6uIQ87fvIMIcaAh0LpLBM2zjD3F+bnBi4UC/IOSvNQF1yyAfTu2PKq/KNtl+8x1+qBhpDR571dZAmF5D81fwMuFv1GIpnrJVfkWoBfJ4s65LTRtfnN+r+UPTHqLNRQjrLBJoEh7EfhR4i1hRBDv1V6LhgbfOmSFX3h/EMNan446/t9dbMzP20y0goq6SErQ1XIb7eOmQm6JFG6CQWsbjpQtMqOhKBHTbAUga9D3BgEoWhxeS3JiR7JRkJmcfF/2haeqScLifq+DkVNtQH6nBZky1v8aZM5lJC3ySyTwH77s/U6PYC4823cTUw08MGA4jvgkg==;5:gw4Vha8+CDRu3BO7TlHVuzdI2ghmiqgTypbt/EnCgvYknR7pa6H2JlBgrE0couwkGwllA9KfEpTtViT84VM0E0zr+Ld3Dh1lraX2Io+xg/P79O7fIKtFBOeBa2fTTXhMz4cT6kQspV9wEPxsdiTc7cBVheDRoLqTZj9ZK1Sro64=;7:6VQ3r/mKIoc+2VI3QLkcfcqSh72wwVFSTYq9VwKZyk2H4BLDgYH0w4mcAeThbbeY17e5+J0G4+lFs9/DZc/GkeFEIo48QaB4v9CXarhcyBUgpUYeL2sp8MZgrbRvUU0qGmaJ355g218otj6q9XnB8w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2018 11:13:44.7475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2d18d2-50a4-4c00-b4a6-08d6577e0f8d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To start transfer with another stream id, controller needs to free
previously allocated transfer resource. This will be automatically
done by the controller at the time of XferComplete Event. This
patch updates the code to issue XferComplete event once all transfers
are done by setting LST bit in the ctrl field of the last TRB.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v7:
	1. Reverted to dep->stream_capable from dep->endpoint.stream_capable

 Changes in v6:
	1. Used dep->endpoint.stream_capable instead of dep->stream_capable
	   flag

 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. Added the changes suggested by "Thinh Nguyen"

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3171c24..3edfc0b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -579,7 +579,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 
 	if (usb_ss_max_streams(comp_desc) && usb_endpoint_xfer_bulk(desc)) {
 		params.param1 |= DWC3_DEPCFG_STREAM_CAPABLE
-			| DWC3_DEPCFG_STREAM_EVENT_EN;
+			| DWC3_DEPCFG_STREAM_EVENT_EN
+			| DWC3_DEPCFG_XFER_COMPLETE_EN;
 		dep->stream_capable = true;
 	}
 
@@ -1005,6 +1006,15 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
 
+	/*
+	 * To issue start transfer on another stream, controller need to free
+	 * previously acquired transfer resource. Setting the LST bit in
+	 * last TRB makes the controller clear transfer resource for that
+	 * endpoint, allowing to start another stream on that endpoint.
+	 */
+	else if (dep->stream_capable)
+		trb->ctrl |= DWC3_TRB_CTRL_LST;
+
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
 		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
 
@@ -2276,7 +2286,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_IOC)
+	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
 		return 1;
 
 	return 0;
@@ -2487,6 +2497,11 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	}
 
 	switch (event->endpoint_event) {
+	case DWC3_DEPEVT_XFERCOMPLETE:
+		if (!dep->stream_capable)
+			break;
+		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+		/* Fall Through */
 	case DWC3_DEPEVT_XFERINPROGRESS:
 		dwc3_gadget_endpoint_transfer_in_progress(dep, event);
 		break;
@@ -2505,7 +2520,6 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		if (event->status == DEPEVT_STREAMEVT_FOUND)
 			dwc3_endpoint_stream_event(dwc, event);
 
-	case DWC3_DEPEVT_XFERCOMPLETE:
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
 	}
-- 
2.1.1

