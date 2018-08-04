Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FB6C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CCB217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lNPfW/Pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CCB217CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeHDL0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:26:22 -0400
Received: from mail-bn3nam01on0071.outbound.protection.outlook.com ([104.47.33.71]:58240
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727096AbeHDL0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSrjBbxZmbIdaxZmw4sBJvFApEDkBHZD2je4KbNmhjQ=;
 b=lNPfW/PjXLt5l3fDmduNkBoQvzfATVXZvyez6fgG780xYmPw7kdxu/8/B3A1qQ8hOGLkkFM8qpiHU23pdsbFfEOmqpK2iR8dS6hlmlE40oszQxoFYK68rbNFPzGEUO83rjVPqDmgYlpT4/kv0FPjZwhXp5JgQJWmBpOeLsbO0Og=
Received: from CY4PR02CA0028.namprd02.prod.outlook.com (2603:10b6:903:117::14)
 by DM5PR0201MB3509.namprd02.prod.outlook.com (2603:10b6:4:76::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Sat, 4 Aug
 2018 09:26:15 +0000
Received: from BL2NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by CY4PR02CA0028.outlook.office365.com
 (2603:10b6:903:117::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.14 via Frontend
 Transport; Sat, 4 Aug 2018 09:26:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT063.mail.protection.outlook.com (10.152.77.121) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Sat, 4 Aug 2018 09:26:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46152 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flspC-0000SS-4x; Sat, 04 Aug 2018 02:26:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flsp6-0002RS-VF; Sat, 04 Aug 2018 02:26:09 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w749Px87001276;
        Sat, 4 Aug 2018 02:25:59 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1flsox-0002IQ-2r; Sat, 04 Aug 2018 02:25:59 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 626321214D0; Sat,  4 Aug 2018 14:55:58 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <mdf@kernel.org>, <edgar.iglesias@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>,
        <naga.sureshkumar.relli@xilinx.com>,
        <bharat.kumar.gogada@xilinx.com>, <stefan.krsmanovic@aggios.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v4 2/4] dt: bindings: Document ZynqMP DDRC in Synopsys documentation
Date:   Sat, 4 Aug 2018 14:55:33 +0530
Message-ID: <1533374735-16662-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(438002)(189003)(199004)(36386004)(486006)(103686004)(2906002)(90966002)(305945005)(14444005)(50466002)(48376002)(44832011)(106466001)(2201001)(36756003)(72206003)(63266004)(336012)(6666003)(52956003)(5660300001)(478600001)(50226002)(26005)(186003)(7416002)(8936002)(446003)(51416003)(126002)(4326008)(426003)(106002)(316002)(16586007)(356003)(42186006)(476003)(2616005)(11346002)(81166006)(47776003)(54906003)(110136005)(6266002)(76176011)(81156014)(107886003)(8676002)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3509;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT063;1:QKneoM5kOuHqW3bvLtdz6Hhqs5XdGaPXIK0OWch5jmrDoFvOLmHsxlz4nZSnFeuc/K4Fe8ndE7c5xV6UDdy/ctJxHDw8gL0OMeJnvk2TKFD2MMGJPBb/tzl5OpGOBkmJ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cba40095-44a1-49fb-4a25-08d5f9ec5366
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM5PR0201MB3509;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3509;3:XnsMZ9Scr5UkykP6+fLexXwDVegbgTupxPYZHEqXhDQMQvvY01wtEEHFj9urj16xXpvbePpphoFXjlr5kYPU5J6C6prKVVbXrkHoZXssu4H4QWffd++QyUrkko9MuYNUlZu2YhPHCw8nWwxHLrekaBjSLtOV65mLR4Z1h0mneYDbHPoKP1mHExn5NHGA3KX/s9KFK+ZU1nvKM6Frb302Hy9m/uc+pC2X9GDF7C6wfn9n5IIdahvMy8EXiRk6fbY4uiYgNDWU5ojj9CSh1AYP85jsFIsV8DW4eoiNz36/syxW1uSxVhrM4TvMp+nlTW8XJ+jzioUJFAHG+BtuJ563RX4oschRCyB14Iq3n9gi+IM=;25:qn/+ccfpR/KBBWD3+OwBwPdBiPW3giVqhgzDkxltUb33E7ICmXvg8kSvEJOauhuq3I8q1pSaQ8ZYO9qC4Po87+VGZgj5odDpCYUwkrGctpoc+pCUb3u8jmpUL+bh+3yPiCmdUPShpm8IX+4T+u2oEYtjFleqEHi8ChCsGfXAqbgm0bjmr0Vh3+JmvsVQdRrdyUJxQz4YcIR+nY4TwNpULdx3XnGzQaieG/5nA1BW0zJW7Gi3/I74AEFmlZVSbSL6eyFNYXO/E8C7SAGcUCPuXGh4j6NLe45/bBu4UL1qJPsOotz6toTyxKDxHJv6ITd34ItrWH1wfJSRAZjUb4RpJQ==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3509:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3509;31:rANJAoL5bx4OPAIYjFYy5lWdjgSn3qVw/O3rlofxozIKVxAkO7AtVzFL3ca+LKPOnjHI5GZP7it20UogzWiU8pj9mQSuPjUyB238ozA2aoOqoUXpbnuODcJu00LfmW6xVXjieZ125kC0Epd0IYx6UTj7LNfRrtyEyll0/Al1VYTp04oAaxchTUSBLu7aGM71UnXtmAq5YHL0shZv4N39cSHv0EKPGqVtTl7i0iqCweI=;20:W/p0NtAMgFGZUPwOszGygEYkYYny+RYI1jxKnD+6nqPbMSbr6WlQaCOiqIXI9rQ/zj+Bb1uygtdmWYYnqDC5gr0Ssb12TRyYv+b+u+hwJICQgBGLQVup2/zF1bdsikpPJyghxi8Te8nv3mULyvm04FRh8kTJRPCQREh49PCQZD3sod6urWpK1uBQMAeWWZrmumie4MEJmxn1JEe7gN3bvNkAni0YvU8MInxF2nXjPt4rhsfL5/zcOlRXlEzsUFNyMGRWAmntfxOgqOshi5LXnrRxsUjjpLPRsS+nRnFO83W3i54zgqDSojxVMZM6KFIIjfxrYbb65KMLEYuhE//CUqHTIXcMMXHuxq0SV91CQ3HHJXoBqoB176yAxA/rmeNONjUhl0naX9b4g5AbfqKOozBUacozGgi1eNoUKcrpx4/vD+IGh5mTOMfjR2x99bV5E3LhSHQnii2eq9T5BWaRxMDphJWuCXZatUk775FC3UgFEEYRlazK+azRXsYRnkPv
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3509916B81A207280F3ACA61C1220@DM5PR0201MB3509.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR0201MB3509;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3509;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3509;4:jKfDd9TvhnMlPbzeHPQoeUT4XnBHhfMeIWmVurp/YQ3FnW4wC2MMS6fEnWBfuAtRNfatfbN/7axzOk2u0qImMi72E6Ls0u4avW3SAMXaqOdL3XD1Y28MHKbVbnntpyTd3KdV6qUkir7golOJDO1J1p61uQI46MsrgPLhzTRuxFb6kA3k4ZJhqHfc/fbjFJf88DDsRXgLmmXt/iBQObt9vpcTPKoNXT1XdTiJut1KOnKpVG2SXWW8I7f+UaDBxjL+58PMkgrNW7ExLRXDlQLhfA0YvYbIn3OfoF9MYgFy6OiWaFsczT/8jW+5U5149MOQPiiuzenvwD1BUXZ1H36xutB+tENF/NPccoC3CKgz368=
X-Forefront-PRVS: 0754F7E325
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3509;23:70ZkSnbnxPHdaccT6ezY0UhtI9kxHj7BuURWl7w?=
 =?us-ascii?Q?lCg+0ZCXA3mdZU+nymsLTmcEFXVe9xtRRSllNbOJ/nd+yMBCfF0nbNXIvffo?=
 =?us-ascii?Q?UmmkkmovgqRCy0udUulNUlHuvh/duqoCfU8uUB1u0f78kODp/CjF2SMNPG0n?=
 =?us-ascii?Q?uj3uGvT9WTt/CMSaCghQ0juBp4aNHUrhBNopzeAnlDmPjc1wRwkME47No5CS?=
 =?us-ascii?Q?4GvoTq4YQU8nmp+7WgUgXpNj9G6AkIiCbW168HZMczXK4k3KX8ktEUNdso1V?=
 =?us-ascii?Q?zfG6lE6D0sHmTxqKp5/vdyG31TZE50G0y0Q+ftjOOXXjYDYtOdKMwc9s0HXr?=
 =?us-ascii?Q?rezZMy0lQalkmJpNkFHxF3LQodZQTINNNQRblLphhoioybOW+bhx/sDDGKa4?=
 =?us-ascii?Q?Kia+2Dh11TtfIhBdpGCOS337fCipnCIIaWyUzlJb4wEjfkXse2Ha8CAIjahY?=
 =?us-ascii?Q?luqAM6U5/yF5axRvbDQoqz9RvG1fWiD36T4mN3ka4FFE0gyZtbkY2jpGMBIp?=
 =?us-ascii?Q?9G85lyuawlpq3LrAbk9bNEvdf7nkKXB6Z+D0EVmXh15ZSvpByhpbvcUKb2Jd?=
 =?us-ascii?Q?hxW6YalJALKv/LVBCFMcrRO0dHzL7Q8SVX6nVZmV+d93DuuDtJvmB9ird69T?=
 =?us-ascii?Q?1QYPVA/SIm6MDPMIA4RllWcin++JTBRcKytkk2qAGb72P7IPGKeYE8cBBZqy?=
 =?us-ascii?Q?gbc2he0rZgWHl1QfllakDqFckOcFui2X/gsz+Ix1Vc/SosaZ6nWBKxL4NxG2?=
 =?us-ascii?Q?DThRyss82S5kR2ksXmkRXbowHQxbxvLjl2AalIQ5/NvbLUgPEdJu07EZ1H9h?=
 =?us-ascii?Q?axi0OVxG4NowEKrbZegn1tjj6Ie3XdpH5mblSLiIHiGPGGIPkY/TkQ4COajR?=
 =?us-ascii?Q?IaMSa2hst3pPcUwfmTpPyYvN3Xu2cP4XJBUZw7sC2Ejdyglg724yaLh9ICoE?=
 =?us-ascii?Q?PqACmAsGIfh777bOtDxT07H2ouU8dexjXAbsFLUOUgC1xIT+yOt2vPI89S3k?=
 =?us-ascii?Q?wISWsnR/JKG3CkVHWJj50o8pbpixRB70/W2lCoJZaXGu6h71ElZzQzBYWv1S?=
 =?us-ascii?Q?uZpbjAcHRuF7lit9rIB5HfexKJxC8YWDbHBXmvfJPgL0lZBOeGMhftavLDI5?=
 =?us-ascii?Q?jNZIYtwg1T3S0YaKmVVtlWsnzxfzC7K1y3VMxN7Tp/2jttP08n6UKcfUCQIL?=
 =?us-ascii?Q?A1fYv1swGrnu0Dw1jeI878J1kU+vGmfeUq+8a89WHgfxF9ndsqVuXdIA9UJp?=
 =?us-ascii?Q?op/yD4xIVMgPRUUVuJXj28bwHvusiF6TgzWimovarelfKdCnARxXweT+1Tsb?=
 =?us-ascii?Q?ti0ZWajj3HqkrMYq7NdQcY2o=3D?=
X-Microsoft-Antispam-Message-Info: Poq+3EfHl3ZZyRwnplED7ObR3voOVQ+Pi2VUrC35dZNw4N0iq11pEsFvYqRe54K7tWRXU8Nt7xAnRSwsmETffKrXSuPDMswmcFgJFR09e7JAvQooNQdOlULU7bXhkBvkjsvc+WrwseX9fU1ZoLzncxmWc190FFLgIi7H8p6nSeNiU8rxwkHTT3izirkNqN5uMLcS2oziPPiQNl5fsouMzvNY45g2YDSniTpWgRDIEXtfeLsa/66YwuZR3hQ0jUgtA8I2N+uSJTCH6/OhpKG89QwR+3xeRZB+T+ba9AFxyNYujJ4Hvp6ARpocT3kSykyHPtOyLnuv59Z0RDMORhdmpeuwUMEpJDR9k38YxsmQifI=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3509;6:kr7PeiH57sJ+1FS5iVQZgWQ3T+xHsPvBB5cJJOnjSEb6TfeJribi97IRrnEpWnixUaZcNGV5gn868zEL9GBHZz2t3RVI2q6Rm/t93Vf0ReUeWybK1Q683lWutwRLqj+FaUcjYPAq5OVIfSmReETEvAFqCFg5PEBJP+U9FdtWpABTL7XHpqPF7x+CNez6RpXf48fkiakLIMaIwDoYF1Kn56rqO3du0+XSFc/cOAkdPOosuKSwFYedLnw+BkajX4PS1t93WPdQ7tzQ2KfYdFOeGkzvJHrULIO20uX4OYMFXcwZO5fF7ORPwtHHLkON0ymwK2KBNG2EImiX/XnOtpN4k5Icis2w4ugwK2I4qOXDYGoqKnOxHpf4e1FG/5ZLTQ+RXpBsAqbVVVuePhSgssbEU1d1C2ruhpJgRNvVAcCoyR9HoojkqolVinNFNwZzOgKwH5KnOCHi1m6iDNnoIvSgMA==;5:q22pQF1SZdwYleZNBIgVGODXNhijuAxG3vzrLLIqHLQEhreOxkNkUas95zmLjrn5V82iIdaFSyz+Xb+BfKp8A5FFELnot15V32F5DPLBsYQho7V93N6gpYzNBm50rUi9kjj6ke4/Ut9ZFc3S9PejXcnZePuS/EbZT/7YvCAPXMQ=;7:wVAGIN6AI6OS/kvd55PFW/GOhNKwn2b84lSXpd0f3293L4olaIpB7N3YDqzbo371PIzdLhR6E4H6z6fpe6Wgt77t0vizlhauPF5W8j4CEWxL8/wS5PlV0ll5qBebEkmW78jbmUo2b18FTxnQtf+y2SO/utKg11/+r1utGDAsEubhxhCU2Qxse23FHaMzE6Ek4QDt9dAcj91db+pBSyvTP8hfe8DKP1pb7mqXzwJy3lqgSX9FIaqKgaVq/BKKiKV4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2018 09:26:14.7885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cba40095-44a1-49fb-4a25-08d5f9ec5366
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds information of ZynqMP DDRC which reports the single bit
errors that are corrected and the double bit errors that are detected.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../bindings/memory-controllers/synopsys.txt       | 27 ++++++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
index a43d26d..9d32762 100644
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
@@ -1,15 +1,32 @@
 Binding for Synopsys IntelliDDR Multi Protocol Memory Controller
 
-This controller has an optional ECC support in half-bus width (16-bit)
-configuration. The ECC controller corrects one bit error and detects
-two bit errors.
+The ZynqMP DDR ECC controller has an optional ECC support in 64-bit and 32-bit
+bus width configurations.
+
+The Zynq DDR ECC controller has an optional ECC support in half-bus width
+(16-bit) configuration.
+
+These both ECC controllers correct single bit ECC errors and detect double bit
+ECC errors.
 
 Required properties:
- - compatible: Should be 'xlnx,zynq-ddrc-a05'
- - reg: Base address and size of the controllers memory area
+ - compatible: One of:
+	- 'xlnx,zynq-ddrc-a05' : Zynq DDR ECC controller
+	- 'xlnx,zynqmp-ddrc-2.40a' : ZynqMP DDR ECC controller
+ - reg: Should contain DDR controller registers location and length.
+
+Required properties for "xlnx,zynqmp-ddrc-2.40a":
+ - interrupts: Property with a value describing the interrupt number.
 
 Example:
 	memory-controller@f8006000 {
 		compatible = "xlnx,zynq-ddrc-a05";
 		reg = <0xf8006000 0x1000>;
 	};
+
+	mc: memory-controller@fd070000 {
+		compatible = "xlnx,zynqmp-ddrc-2.40a";
+		reg = <0x0 0xfd070000 0x0 0x30000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 112 4>;
+	};
-- 
2.1.1

