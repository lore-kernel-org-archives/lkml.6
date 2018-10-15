Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46269C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1E620842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="h/m2Ti33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1E620842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbeJONQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:16:55 -0400
Received: from mail-eopbgr690074.outbound.protection.outlook.com ([40.107.69.74]:54305
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726424AbeJONQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPlgHWwxxGeMmES3iC9R2B0x0FGDcuWpvXvIdyeQU0I=;
 b=h/m2Ti33jd0SJmWyEnFdxIu49EzvOISOai6lz116QVxMbQVO0q08xIab0Raq6v6ssiQdNOtFsDQL1h44BRnX9JCP4WpewDwRB98TM7erehJ3yMGIabtaY6TttHSv3LCL4iTLkVC9/A5NXaZ6iRAs09M5kc2+Os70yKp0HqJFhKM=
Received: from BN6PR02CA0048.namprd02.prod.outlook.com (2603:10b6:404:5f::34)
 by CY4PR0201MB3506.namprd02.prod.outlook.com (2603:10b6:910:95::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.23; Mon, 15 Oct
 2018 05:30:20 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BN6PR02CA0048.outlook.office365.com
 (2603:10b6:404:5f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.23 via Frontend
 Transport; Mon, 15 Oct 2018 05:30:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Mon, 15 Oct 2018 05:30:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56553 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gBvSI-0006b2-Eu; Sun, 14 Oct 2018 22:30:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gBvSD-0001yJ-0s; Sun, 14 Oct 2018 22:30:09 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9F5U1vx015105;
        Sun, 14 Oct 2018 22:30:01 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gBvS4-0001eO-Re; Sun, 14 Oct 2018 22:30:01 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 01DF51216AB; Mon, 15 Oct 2018 11:00:00 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <olof@lixom.net>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v9 2/6] dt: bindings: Document ZynqMP DDRC in Synopsys documentation
Date:   Mon, 15 Oct 2018 10:59:44 +0530
Message-ID: <1539581388-23963-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
References: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39850400004)(136003)(396003)(2980300002)(438002)(199004)(189003)(103686004)(44832011)(7416002)(305945005)(486006)(50466002)(426003)(476003)(14444005)(336012)(2616005)(126002)(446003)(11346002)(106466001)(5660300001)(63266004)(2906002)(36756003)(36386004)(4326008)(90966002)(48376002)(186003)(26005)(47776003)(72206003)(52956003)(2201001)(76176011)(316002)(51416003)(54906003)(8936002)(8676002)(110136005)(42186006)(6266002)(16586007)(81156014)(81166006)(106002)(6666004)(356004)(478600001)(50226002)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3506;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT053;1:bS9NAh5Y2MG9h6IMbet/9lGcdFLOPrrH1/cBUQTiVJBbgTHWMepz/gzJIkjCRwCXW7N+jJVRaUanaTnCJfqJJfHQ5HUXNKX3D38Z1bvFNeHVnrCeZNJYMnSkdcBYz4rK
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8110c4ea-ead2-4015-4e33-08d6325f4bb7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR0201MB3506;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;3:JdPNZ6uOfbwgYVFnSYg8C64gku2mjX3s2JwGLrW4vn1DqPIT6SNk0brqsaW8Dj9BzbQALW4TP4Ro+ArlpQFBNv6eBXKNq7Sbzrf2+BLLnhOo4J0V9E4AUxRrsVar/Ac4rQhnXq+TazD3d8yn/I7f7u/cqXRuJMuU4NqsCFdF9fCzlyz18kisYjQZDGF1CjqRdJ3hjg3gfxQDvsP3iwh/Cazy5XsSW7NwcEFtrvkhHynUpBUwEnhKa0IBoky32oNojsw1kd+4yJbLCCW2PtBtzwBSerIe+Z4CREApkQK6Ni3qf7ZFWJ5ExGGstxcqXdtAaQJvQrLe8QlexeA8BH3jCJjPPIcN/intQZOZdnRZSA0=;25:aPXJ4A+GmgPqQ6id4lgJfnIypzS6376d+HLJ1Dt+FL9/4xw7LXi9CCPaLqWy+ZZHttdV/P/avlFWaQxrLyhRZLn0dV7veRURPAgMpurCNr0nokyrzZZhEKNCgct//fjB2GguZaQHc26iU1XlW9X2+oroZQqWLMeGBdl11Ze5TMglcj60cF0WVYuaNsm3OcOHiTt4L4EIddOnmEeSkMaxvxRQ4KKz/AmDIQHFeoCyQtNIOkQyKTtv2EqThojdPdepgbv86VfbPGIdynsktfR8N316waKZ9Tjru6dxPEo7j5KUPkTR4wBKoGNLq/aUUr5bRUTNd0ZSUvd2EsmYinXVLg==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3506:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;31:RUFqVtQhbwMmN8XUrNRWs+RfijNL7T11XNdTGRm9e7R7MSlUnYSTr6l1oF1kbxE48ZTXSKSjvdy8X5E1YZaTatqhbZVvIQ0CSpE+eQIVgHfgEpYLmWMUjOv1ZNj9NxmzDWHwQ2BQC5/yRMh2JIddYLN+GcEmJOFl60PI1Am8EvtpL8lse3LuzfdEH+OmKMju4cppL+bkpt0ZOgGOlClME0zFVzm16zbMUhjhBymStvg=;20:WYtAj7ZON2xwgAfoxlXsWEoPgbautqQPMvlPICj/m3g5MFgIycr4/Qb57mWqHc9TfBSTXoLxkgJLlFAsNXYIz6mfVkG2Ylep9IphiRVu0k0vRPtbaTJ7BQfNdQAlXNE9sNoifDTLnnw0UOlJf26+qqguHsnsMHdnNarxJTO/oLIKzSfsr225KgHVhkAQf7Xpw5EAJVni3+IX0EgqFyqtLHULS2dTBtgl0i1PE9L9iO1VqD7pKYQEscuXs8/T0AtcbvXdNe4M4egNDc1JAaYIIFWIklRaAQAf1lmCwAH88WMBcXw57xqR40REMsdX/2q0argg2ARXoZBg8JHN6dE84CmDYJ5kUAGinFRPe074SmxWB/U6+Om92PquhwsYkSKI+TGmRM6/o2W6v5lpXJm4A2SxSn78hWojYTY+BfMK8v6zINPj9Ai7udBlfq6NTTVEvKCoRRP1ul8FaiLCxMuidvjiyrhgx55oBgn5/7rbNTOWazQcu54BuemJdnPT4X5b
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB350653D7A11E854E66B820EDC1FD0@CY4PR0201MB3506.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:CY4PR0201MB3506;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3506;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;4:ItNvZMpCmZVLXBtrXUS65FEXoXjKMOn/T1VJ5gkE+YebL8uBANDcctPzfRS7fVlYRN8JRKjta2jrejS4wsIiXDB0YicYdgYotEOcy8lBb16tb+JN+FnOZjLaX55SmnEP0o/twnGH/zyfP4AEKnZKgmlNz7dw+nWYZZrYDocWR4HkyGtsP3jFteFmkDZrTJTAf1o/niNLg5jv17Ofit/iQ8CRPypIhxRaDCKAaEFDsye6jnGhXQ6boBabXQ5q9OkbAt+fNhqnw0k7tj+TmFqLRBpJVqrKjpt5Kc0yfap1OrJTuB66WoUHz7m9jfoDKOQhL3Wc+BoBl8d0r81c3/kuNn1uQcaQpmhNWnFJG5hGurk=
X-Forefront-PRVS: 0826B2F01B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR0201MB3506;23:cxrwcARwtnKPhrhuHwuvQZcPcY2ewoAmxmsreSQ?=
 =?us-ascii?Q?QMiJDrnJQgRFOlJIzEW6tNElLU0um8uM97VUT8KrAxGi2se74GomPU+tCeDq?=
 =?us-ascii?Q?q0aogKYJMz+6SZ2cENb3OwZ2txOVCdxQvE2W1IY2TjWv/N2LYtXpfhS/dPXH?=
 =?us-ascii?Q?KlhiMAFZ+j8lpVbDw8YHTEqaERmaMBpka3P328c9oJVMOjHcx/e1ZdUeXedT?=
 =?us-ascii?Q?bnhYzKMaKS972/5AkP1yU4cGzw2dKaPJW1LJ5J1Ycq0duWKUNfpgsk94LJXN?=
 =?us-ascii?Q?L3/FqIenX2m798UohfzkvXJH6PpyCAFUmMChiDA+yZSovZnQmFR1A6r7D7Xr?=
 =?us-ascii?Q?CS917aMcaWG3VdyoHQ1U6arlXmK001UP8oTGFo5jaY+MNfogjJmcvpjl0hwW?=
 =?us-ascii?Q?jc3GJMKzXTYMxShIXHkGtsaemRT/waHlmeVI+nAmudWJAj5AgBO5O88JSKuV?=
 =?us-ascii?Q?XF53H49QzrGG0qk0hlBm2ZLi9E5K77C9ZZ701uaHqU5AkT1kD41yq6eq0GiZ?=
 =?us-ascii?Q?ic0fEQBru+0xlCis3TDT+LQsfiosISKFk944Hn5Wa+YY7mVRMYdiWH7rVJwS?=
 =?us-ascii?Q?3LF8M/Ma9ZDdb0dB2wPo8IjRmTQEDzkmd5Jg0kprQv8PHRVFErkLbf+2CRYs?=
 =?us-ascii?Q?kMkBgPYjAT+pO6cZBmVPHOM71+V1MaeYVukLX7JfGkS/iL5LXgrUVCOhrR5e?=
 =?us-ascii?Q?j19+6G2FhtILQ6oi0kwo1ApbTvD9EldmaDSAZdW0otmst6IvcvbUnsaO+o0h?=
 =?us-ascii?Q?UalHc/wEad5HoLLgk8uiKq4eLQAZicSGmyyyeDkj09Hev8WrGvUpmv/k0JHC?=
 =?us-ascii?Q?15Owxy4mZhC5enDEkTl8BCZcv/l4z53jvaqvBipjf3K1sTwG7neeneoHyURq?=
 =?us-ascii?Q?mnusiRPMvA/saWP+hQAnbOIpZslpVRUI2+Omtr/Z7PqeIxwuUasN7yypIISA?=
 =?us-ascii?Q?bgLZ3GQYVEXcBn94oKgDslr8KrbyyxoB3WR2tF2aZvF/YF41uXkpfeCW6leL?=
 =?us-ascii?Q?dwcaXMoFww9Pm4MMDwGNNts7vEZSJ+Zkl9bdEUgK4T6Mxh2np6O+fHYQXtYy?=
 =?us-ascii?Q?+/TyKbgwTCQ242hufKvVT2hqp0+YBkASDUXum/5tKzgxhCHGOfS6s/4KZV4n?=
 =?us-ascii?Q?oheKO7mq04Z0nWKahHHWqt0uLrwfDbbLfyWPPopvJxfEvHniUYyqoe9gWW5L?=
 =?us-ascii?Q?Z9t8SGRCnM82wkmPpTIX0w5JNtcpI2k+YRwGMGZjIr1tHrnln62ii3j89/CT?=
 =?us-ascii?Q?/3trxwRmZOo7BaGUHodLwhd+qMYz38VkVnJEJqjB1?=
X-Microsoft-Antispam-Message-Info: +ig/oqX6gCeDKXLax0lVGH9RI/eU7raohUYIAZugaRX3mn18zUZ0uUOM67K2Xk4GNTy29FZ1ZSd/qBupenXsxb0g0wCTocZLfWPZUvMahkU7sy7o7ew3qtz5XAu+ki+C3Ianre5ES7BHXKnEWwWXfEgfjLop3OHAAKE7xMu/+C115jB428PRatpfWu0VecA68eWswEIMEKUtiRBOyIeSgX65oCnCgAUSJLH26xya4UhpV/tLg4QWugH3WeBRD0LQ/uCtqiLXHfjgEfHt8RCm7r7P10vAbXbqQXZNNuKVK43ZDNOMLQc69SYYu8m7uHDdvTmI6ffQCyFtifrXRZtLnW1xPjQCLtISOq+o+pZQlkU=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;6:Tz4iKxN9JY7oeKXgbfXpSQ5jP2W3eeOWvq8HebVjMChMEbYkZBtXyGqjJFnCIB3w28m7UetRQWBakwVxZr2ojWGj4raePiPd1GyHOky8gUvsQNyvzuU8WNlUH8acKmU8Hb6SAupeNY/Nqq3BzKXZaVg+GPoVfiOWOcbKadumHsGqBVg0XlIPZNOsxJHVq1My9T+lf8LkUJ/ugahJtQ0Xsb3RaYeqGtb7Ff9yOaZdT+0oghfOrdOPlIPucJxppP3xZNwIlRz7tur/RxmwP5a/k7kodItGJqeJT41VWLVjuxXUhiQtjxgfxtsnF2Q3vlg1Ijn5+A4dINQ2zZny6517dQZGue3cXCgstToYvojJZgw68FVbzEUXGjE/AthCUQ6oo/an3ghhEgsegDkhbMoO3rTvE8J+jwzudZqzc3AIi3EuILxeNhVdn0mvgzHmzBVgML0fzGlbu46gIJgUKovasw==;5:w+hiWNfOeAOaT7ZZXrZjDeFxmLs3yUXuYf/CtgCfjxzMELyLf5y8ztaTvyVm0oif8BNCME2ODkjDwScKn0kta7d18tqI0VoZbhzF4RfDwBik/eWmNjVFjuSfnD3o+SxCuvepL5uA8j/QEdhH7taxAiGEf2oykKT4Y9lrz33FFSY=;7:SwTzlYvGMdonflqcr5YuoLG7rI/6CMY+NopyBdPIPnZD73rHkRLuuRQVAK+LoLyF/gEC3Y/79hJa9f72jeeaptE9fF/eUWd0hG9FzOVYivOZd0R1GyK69nOGVih02/qJIKhfL+QWnsVgd32SD04eqkiAtsJPVt6F1A8RKNL/MLScxbBBZFRtG/q+UAkaIWknH4cpnRkj2z+aBopzERp3a12sLneXS+9aTTARIUUMoHgGv5W8f6y6txlsyYidsDVE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 05:30:15.2776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8110c4ea-ead2-4015-4e33-08d6325f4bb7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information of ZynqMP DDRC which reports the single bit errors that
are corrected and the double bit errors that are detected.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

