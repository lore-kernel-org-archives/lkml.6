Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06DBC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D5621501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BUuq0LSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D5621501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbeHBOnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:43:19 -0400
Received: from mail-eopbgr690058.outbound.protection.outlook.com ([40.107.69.58]:63566
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387420AbeHBOnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOQYaEkn6CJfrNy/5WPYE2NiLhkM1Zi4tahiV9x9BrA=;
 b=BUuq0LSDCJJAz1BF4dFAxJiIssEwjMLDzLK41WFWAtVMePOalnKen8Kn8NAyagQYnvvEN6aHE0Ur/Tt1aB1mwkJmJtx6fHCwOWKuFZXTha3nekz+gaf0SyrEhcS8NFaMcvergOxfuPgTMxWh2vbGuKu23uFYWPpG931xq6sdRZ8=
Received: from BL0PR02CA0102.namprd02.prod.outlook.com (2603:10b6:208:51::43)
 by BL0PR02MB4322.namprd02.prod.outlook.com (2603:10b6:208:40::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 12:52:08 +0000
Received: from BL2NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BL0PR02CA0102.outlook.office365.com
 (2603:10b6:208:51::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Thu, 2 Aug 2018 12:52:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT045.mail.protection.outlook.com (10.152.77.16) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Thu, 2 Aug 2018 12:52:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flD5G-00022h-LR; Thu, 02 Aug 2018 05:52:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flD5B-0002WF-H0; Thu, 02 Aug 2018 05:51:57 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w72CpqDD011580;
        Thu, 2 Aug 2018 05:51:52 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1flD56-0002Vg-89; Thu, 02 Aug 2018 05:51:52 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 7175F121417; Thu,  2 Aug 2018 18:21:51 +0530 (IST)
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
Subject: [PATCH v3 1/4] edac: synps: Add platform specific structures for ddrc controller
Date:   Thu, 2 Aug 2018 18:21:19 +0530
Message-ID: <1533214282-9977-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1533214282-9977-1-git-send-email-manish.narani@xilinx.com>
References: <1533214282-9977-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(2980300002)(438002)(189003)(199004)(44832011)(76176011)(52956003)(2201001)(16586007)(2616005)(316002)(356003)(42186006)(103686004)(336012)(63266004)(426003)(51416003)(36386004)(486006)(110136005)(106002)(26005)(126002)(305945005)(54906003)(476003)(7416002)(2906002)(11346002)(6666003)(8676002)(478600001)(90966002)(8936002)(446003)(5660300001)(50226002)(107886003)(81156014)(4326008)(72206003)(81166006)(47776003)(36756003)(186003)(50466002)(106466001)(48376002)(6266002)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4322;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT045;1:RY0iqzLrQkhlobjWHhYiPpXvsJINp6lEKfeQvRAB22zvVb/veTQLONk1cuKfQdGCgN7wGnpprGseJlRS3c4trrpjj6/IoPBi/g2E0mZ1761AH3gxvpVLyFBdxtLAgWKO
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6cd29f4-a12e-4eac-ecc2-08d5f876c1ab
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4322;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4322;3:2XCCKHNVOCA/bkCTzGiG4cqWC6MOfjgETEwXu/uQamG1lykC/DlgJ4qHCjzIPTkEw7PfbsTX835mDfbIU0nfypMxKxcNP0lTfSimmEkrT3oH5d2e2dnAnYz0NpnD6tHAfOt+vyAXIbavWe4KC5Th61pxj74n/vtTNRzysZH1T93R6LcQ9zQDL0PiKSPCbNg3LCn35QbhaPmZWs+zZEB50sS3gUV4Ls7k7ZppT/ye6kL3hUtvAp1VqUZbH736LgRhafvwYZd7ZS57btBAg9+peLm9v6NalJRT/cKGUTVTyOi6AuYCil4lkAba35kEXTA6P50tSSLgbIL8pakLl9GVRgOSPeoun4cLrFOhJ0qFElQ=;25:ewcv76z26MF8YLTfvZTRhHnYeD0ZXnGTOlORJW8z3DRTHytsPtlhgNcbJM/snX+4THvmhyPwrw4nxOB8RssqmBWq83eMaM73l9QDDZYbtPseX7y1qALnklKTzKzD/GpMZgL2VNOhjc2gR98b/48c0aDuWnnxecMSwLm1wEk+3ODAlaDNhSM4s4KwKIBHbzBnyQEmPYkcmbIk88bKBfidIwHV5V3atnzSKgzLaRQRM+nAece6Q+IThxxVgnXuaJQ5Dha59ZPiDQqoBUIP6A7uCiw6fgZ9WRLgEh+zbP4lwvLISJKwKI+mSaqWOgR2r5HJQT2f1dXTOtZpceE072Z4Gw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4322:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4322;31:YrH+arr3UCBzBNuWeBsD1B3y+LB5IjxO5ZDGeBwY6HkKpwePORmLZaG2g51Qae1huUbQuK2owUN6FCrPXnxpKQwn5wNRsHfS7RIdp9EacSWUOoL4om5beUgZU25Lin0UiazD3t1ce06JizzZrSMsZVEPnnuht9Nn9PEmG67U5o9u9ObAynMudKXDkIhkvL+A4fwmvETdgNoOU+FzJxLQng+nlXjKoRO98kbUqhl6ZyU=;20:yicr+dR2Fn1iZ5xNmQJQLS/FgZxC/aLldDyVRhZpoRQCImqtayI5SPLimCF9LgpYCyro7Z/OtrNxgFr7aPEUQe4xwWn6vKeMnsCnatqRLg5pfK/TxIoLuTQOkah8UV2yesAK7zKQyipJit3OFmWYJzs3Ck9XV1GDZYedZqZNfaesHBgeCsKSFSeFpFSoTy+h5ND5j07p/XelpAecvzOYjlFSFT7k+XIntbkTkADKkMe6hsLx7l5seVmB246VuVxny/xgWozes7Mb8R9RqveUUdAAp5no2yHalV1EaXasjko03T6FDpOGUVUoNfQ7xDNzMvsCAYGwpE8Fictv1sdryPlAWdm1kTMRj4kRBVEhdDhELF7ZoYwxnb23Z7OtLF9eUpNlApAhcg+01sMuHIlb2dBepPdZWWY0Ke7Amicrktzbgw5XWY05xptHO+9pOLBn9EJh41argoMNtHKqZl/b/YVWt8UbNeA/8QQyNNjRm7IMkvR+6tH6gID1IodADBVK
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB432215EF91DFBCBA0C7C3979C12C0@BL0PR02MB4322.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4322;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4322;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4322;4:OT0bOOpVIyFpB5hjo4UNQy8eyzAljlrKM12wsyZIM0Ww6Exma10Dby4BVJGCAshHb+0pCVS8eEPftBVVk6oLv17BSZlnNFJ2fRwMOB/ZOlq0M97HBRswupl/50GyExLzwdZcU1VFfJsRYjg5ZDNLeqTQpRYFmWo0/xU9GPl95VDc8Sc+BWpRLijHExceXvQ+wTSeTaHEKgYA8+n7x5rIg6OLr9ZN34QTBPzNHxAJlgUUXPDOF5PZw4mp7IE+zrXuJo1fuSQ5yE2pn5rjwsbEmwEadmpjPqWVYf6jn8ATQZ+0ifuz9tWlo68LLIuK993/
X-Forefront-PRVS: 07521929C1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4322;23:RAFTNkHiQltUu2D/24tD44F27oeIaM2QEV2hfMXJ7?=
 =?us-ascii?Q?Jvuoc2mlQNdEx1YP+ctzmdJVxrPlVTgxaMNKE4OX8gD1eCdJTv9aKssnR6OR?=
 =?us-ascii?Q?FyilIWltU6qyULBDpGRdU286tJekNddnyUHjg0CnDZB4W0tkHGRkjy4NikZw?=
 =?us-ascii?Q?e2arVvcAYyzp8aCdakqjHypRkCgBjSPrRZsJEm7SI0quPwQpaTt+DGm1ny6M?=
 =?us-ascii?Q?cpTidrhv0zcZhSjFnuwjvoMySEnoE+QMfW3O3q0ywtY4USK7W3acTev0EgXh?=
 =?us-ascii?Q?9IZQf2eHiXhawaXDOQA1/nQ1JSpKaJrdXuGAH7UycSf5vDdX9zrsSFaPqlGv?=
 =?us-ascii?Q?wkn0W7L1SlvjyE+yLukFXDMP/VJ2Pt68xGg1yR1cMMhrzmmItrJeA0eLyLMK?=
 =?us-ascii?Q?ngF/Ly9TkDF9BRHz0Ip94LsAg8vYW/DrkIflOKG9rNfnI6GksQyy4e31SvrD?=
 =?us-ascii?Q?031+LZnUJY60CUJpRGedbA5VPqeIABlk7ZB5kcJFpHktjFVUWHGMsiFyF32w?=
 =?us-ascii?Q?qwHD6zvebBdsnYM2mPHp2lWbCutj45tLO6QOTSq+giFj8NC9rOO7KLt5U9gp?=
 =?us-ascii?Q?8R5UlZYmsejORR+7a4un28AHiprf7uxGR9+dX4uV5+29OfTfpA7ArQA5aVz5?=
 =?us-ascii?Q?WlPdm2Kj0pWptX7uanhgBe9VkEf9SZYqvitMt0gSBW0/TOt8d6My1NC+r4Ab?=
 =?us-ascii?Q?yKMU77aPvBv/0pwc25Y6XmIZIBDMxJUzAbhAezQK506o8fpoECZtGi9YSQTo?=
 =?us-ascii?Q?dguxDB6lX5LYuRYfS99qafx4Z7libQREoWEr0D5SR717MSzMMUouWDN9jAlQ?=
 =?us-ascii?Q?HFc9klnBstFrT7ZiXINGGqcsyAbSia8oQ8O33eQ3gHpZYT7BifZfWfxEAdFw?=
 =?us-ascii?Q?qlS4Y1aAz5aCMgFz7vkKVM/+uTFvhjEyhLKeNChj1EUn5K/IV0HIrzZwvo8c?=
 =?us-ascii?Q?MGkPY69wfFfkHw7uAqg8UEY+qL3Joom4yRmnb13Zh8q7IBdeCD4YWf8WkAdV?=
 =?us-ascii?Q?vG9zJ9QPla7c8sWmZOwf8x0glkbBTzQnVCmXldJNWhd/hJXemETol0+xSnbL?=
 =?us-ascii?Q?nNqiXqsgW1Xgi3JYUes5gO6ojdkKiDJywz5JdzxICp2W9to5pUOgdLGB5q3X?=
 =?us-ascii?Q?akNfJurSs8MPx2o42EQfcgpxgz90EJnPfVNQyqz1hgtyGuL1hYUh4M8r0fgO?=
 =?us-ascii?Q?qT5tLafnLk6rO7KdCDnL+EBbHE00JFfIc0+I+0UvUEIMxGiexqqXK83wWYN+?=
 =?us-ascii?Q?Hnob0awX2KCcUTrN8UehdAX14LqwWtL/fKd+Cct?=
X-Microsoft-Antispam-Message-Info: G09NPlJ8ZOXrzSqlnK0WRRXkyArvtmCMOrhX6NEz2nD1g9vsEud2+8/3KgZuKHbSpjHxhk8M1faVzw8yrZPa1Ca+9+/w59wZYFHC4vDU8LyH4KxAFVBP2EQkzfMoXLJ0fDztUJEUj4Z+yoF0m6ok0iEw6eAlzTR4zqvKiSojP1mnZyt7Gt9ijxfNnhbT47Qo8Q8/Dm0401F3xHXwi2sLGaY5jnquCqZn2N9zC5lwRqR65vtCmohYcNNG3W8OEcg96mHl8DDEglLxeiNpmtW6/u221VQsq8+9KfBVoG7+Vk5ZW0vPJi6mUaUY92uygSLXdrqTVecQ6Gqiy+43aUmpurmVZsOLUVgLNM0GpMIqSYU=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4322;6:MIIoaKTjX/Cd+5ddOa1RPIo+bh0UOJRu7OPeh5to09zLLX9qFmnAGoleKvbSpCfg6VHFU0G5Ai00WWwMFUUhu2LczivUPuHCGXxI7L97g2tAfztXGSnc5Tz8mJEBU8uvkSv22Ml4Tiq/TUD1Im+Qc9t23qqrso2P1Zq+uIBPx+S5BbD83sAh5/rXN+UzGabv6R3/S8NOArNCAn8rhZ7lJppG2+cP+SMK7G7IovP+lP1dGzgqz8+puBelCjOifU+XHe9V3oE+zybjEz5i8RrTcbL86kNJY3BqGfqm4ju9bfKck1ng4IN2zhboEvmNqvJNKCdtx6dXLZYcID5WkRRAfIgOt2ykhn5h9ay/ZwpPntssuy+Awqf//AnK1fNQZMJvkSPljuFGERub5lJrgvllEYqiOUX9lZ5uM1fi0kQlYWz5lxf5+vC2Y6V+4sY1bGx1n9G/I/gBYpnYZbAm3z2MnQ==;5:c55WfQlP8yBWSicuXvfM50tG8gMA8qW0H9/YnHMtukQffkb+CUR6b34VW+MrTTLMEi9mZIE4LzbgsK2mIQHulsDQNXq1ZeuC8zN87NqdZMCWuiAUeadQUSngUO7QtLbOgYCo2ilbw1H7w4IAFhVfadCMP8ec9s8+j5pki1FLG9E=;7:SOICOYnk9BRYhy7U3zHewjHPQlEU9VF5PG6J3abyZjh3FD49u8I2WAiNgBuo5+7s6Sz2HOfWU0S6S616TR8y7x6IhJsl/1o5Y5owjNT0KKqqzTvG/UxHjjhX1QFFmWurJx0tUEH1nJJwiPHn0+qOeSiJQy3KiZQ4E07X0ZqFN3u22PHYmNjc+EjRG3C4Q2WPXYlG89EpkMsiFfqOw3lDS3tuI5BRDBE+TtHnuPHJ9KaEjNmmrGyB91fIXP/igQOX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 12:52:03.6735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cd29f4-a12e-4eac-ecc2-08d5f876c1ab
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4322
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds platform specific structures, so that we can add
different IP support later using quirks.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 64 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0c9c59e..d4798e8 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include "edac_module.h"
 
@@ -130,6 +131,7 @@ struct synps_ecc_status {
  * @baseaddr:	Base address of the DDR controller
  * @message:	Buffer for framing the event specific info
  * @stat:	ECC status information
+ * @p_data:	Pointer to platform data
  * @ce_cnt:	Correctable Error count
  * @ue_cnt:	Uncorrectable Error count
  */
@@ -137,11 +139,29 @@ struct synps_edac_priv {
 	void __iomem *baseaddr;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
+	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
 };
 
 /**
+ * struct synps_platform_data -  synps platform data structure
+ * @synps_edac_geterror_info:	function pointer to synps edac error info
+ * @synps_edac_get_mtype:	function pointer to synps edac mtype
+ * @synps_edac_get_dtype:	function pointer to synps edac dtype
+ * @synps_edac_get_eccstate:	function pointer to synps edac eccstate
+ * @quirks:			to differentiate IPs
+ */
+struct synps_platform_data {
+	int (*synps_edac_geterror_info)(void __iomem *base,
+					struct synps_ecc_status *p);
+	enum mem_type (*synps_edac_get_mtype)(const void __iomem *base);
+	enum dev_type (*synps_edac_get_dtype)(const void __iomem *base);
+	bool (*synps_edac_get_eccstate)(void __iomem *base);
+	int quirks;
+};
+
+/**
  * synps_edac_geterror_info - Get the current ecc error info
  * @base:	Pointer to the base address of the ddr memory controller
  * @p:		Pointer to the synopsys ecc status structure
@@ -242,7 +262,8 @@ static void synps_edac_check(struct mem_ctl_info *mci)
 	struct synps_edac_priv *priv = mci->pvt_info;
 	int status;
 
-	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = priv->p_data->synps_edac_geterror_info(priv->baseaddr,
+							&priv->stat);
 	if (status)
 		return;
 
@@ -372,10 +393,12 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm            = csi->channels[j]->dimm;
 			dimm->edac_mode = EDAC_FLAG_SECDED;
-			dimm->mtype     = synps_edac_get_mtype(priv->baseaddr);
+			dimm->mtype     = priv->p_data->synps_edac_get_mtype(
+						priv->baseaddr);
 			dimm->nr_pages  = (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain     = SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype     = synps_edac_get_dtype(priv->baseaddr);
+			dimm->dtype     = priv->p_data->synps_edac_get_dtype(
+						priv->baseaddr);
 		}
 	}
 
@@ -423,6 +446,21 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	return status;
 }
 
+static const struct synps_platform_data zynq_edac_def = {
+	.synps_edac_geterror_info	= synps_edac_geterror_info,
+	.synps_edac_get_mtype		= synps_edac_get_mtype,
+	.synps_edac_get_dtype		= synps_edac_get_dtype,
+	.synps_edac_get_eccstate	= synps_edac_get_eccstate,
+	.quirks				= 0,
+};
+
+static const struct of_device_id synps_edac_match[] = {
+	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
+	{ /* end of table */ }
+};
+
+MODULE_DEVICE_TABLE(of, synps_edac_match);
+
 /**
  * synps_edac_mc_probe - Check controller and bind driver
  * @pdev:	Pointer to the platform_device struct
@@ -440,13 +478,22 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	int rc;
 	struct resource *res;
 	void __iomem *baseaddr;
+	const struct of_device_id *match;
+	const struct synps_platform_data *p_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	baseaddr = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!synps_edac_get_eccstate(baseaddr)) {
+	match = of_match_node(synps_edac_match, pdev->dev.of_node);
+	if (!match && !match->data) {
+		dev_err(&pdev->dev, "of_match_node() failed\n");
+		return -EINVAL;
+	}
+
+	p_data = (struct synps_platform_data *)match->data;
+	if (!(p_data->synps_edac_get_eccstate(baseaddr))) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -468,6 +515,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
+	priv->p_data = match->data;
+
 	rc = synps_edac_mc_init(mci, pdev);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -511,13 +560,6 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id synps_edac_match[] = {
-	{ .compatible = "xlnx,zynq-ddrc-a05", },
-	{ /* end of table */ }
-};
-
-MODULE_DEVICE_TABLE(of, synps_edac_match);
-
 static struct platform_driver synps_edac_mc_driver = {
 	.driver = {
 		   .name = "synopsys-edac",
-- 
2.1.1

