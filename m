Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F0EECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005F92064D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="y1LWI04q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005F92064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbeGWJjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:39:13 -0400
Received: from mail-eopbgr700085.outbound.protection.outlook.com ([40.107.70.85]:34400
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387933AbeGWJjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOpVBsJ6/LZZOrkK9A7mWU4/Fwd+AoSjUJ+5gTtvBII=;
 b=y1LWI04qk4s2hTuc1870UYoxFK0fW6uog5m4AtDPajcWXsnvXuc/JEm9YgCUDmrrm+p8YK8vhTjy2pWtYCpiT35zK5H5BG0dmcqAtPWMudDS1LPfZUk4j8CjPeMjcOtVkV0M3BKNu+D2g5xdTpT4g42t+iswLSXZDf0EVUji0UY=
Received: from SN4PR0201CA0032.namprd02.prod.outlook.com
 (2603:10b6:803:2e::18) by BN1PR02MB088.namprd02.prod.outlook.com
 (2a01:111:e400:40e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.973.21; Mon, 23
 Jul 2018 08:39:03 +0000
Received: from SN1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by SN4PR0201CA0032.outlook.office365.com
 (2603:10b6:803:2e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Mon, 23 Jul 2018 08:39:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT004.mail.protection.outlook.com (10.152.72.175) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Mon, 23 Jul 2018 08:39:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58287 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1fhWMw-0005Uh-0a; Mon, 23 Jul 2018 01:39:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1fhWMr-0006jy-1B; Mon, 23 Jul 2018 01:38:57 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6N8cphe014267;
        Mon, 23 Jul 2018 01:38:51 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1fhWMk-0006hY-Lp; Mon, 23 Jul 2018 01:38:51 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <netdev@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] net: axienet: Fix double deregister of mdio
Date:   Mon, 23 Jul 2018 14:08:47 +0530
Message-ID: <1532335127-10683-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(438002)(189003)(199004)(5024004)(107886003)(36386004)(47776003)(2906002)(2351001)(63266004)(106466001)(575784001)(54906003)(50466002)(81156014)(48376002)(8676002)(305945005)(5660300001)(6916009)(8746002)(8936002)(6666003)(81166006)(106002)(26005)(356003)(36756003)(50226002)(44832011)(77096007)(4326008)(478600001)(336012)(450100002)(426003)(45080400002)(9786002)(14444005)(186003)(126002)(1857600001)(476003)(316002)(2616005)(51416003)(486006)(7696005)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR02MB088;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT004;1:KalJvo4LVwrJ0nFKoId0GfYs3Wu0gfNkwUs7pF9ZZThdvLC+vgC8nAPwreuOodA/1cAmdqASkLQ7JrCx2Jpx9Kkdp4khXOm+UwPRkYJAiiMU0yWMK3HI5Msz3yqqmhNa
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88161f8b-cf16-4b33-b6c5-08d5f077be28
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN1PR02MB088;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB088;3:bjeL6VBPVvlZmvwJGKSVS3bmY1uxq3Uyrieei5IA0V/CsvJcSMGOG4vAczNcPndfbiqwZcyEeHJAN/Y/2mb90mNlkRTG+HA9RAFyKFJhqH6HgUZ//pB/CDjI6qIPg7C5ilnojFl4gUFdiBuaLYkJeJWusQXjBxvuGoXPPbuPt0UqTuWe6eeELI6xngV8Xo09uAoHtXY5wchomwR52w7bwmsoaM8pM7CWWueMPIFI05CDfrxjTOVGEg+pw+MYATTvXyWk4s49lbNMe4ihL8HY6306dUEVaYTQtOVXAGuiI90dgBawg9UK79pUanPkwD+ISvMEP9o5nn6SkjiEA1ioNojbYDDJXPgFap4oxqPNyT4=;25:YqomZfJesZiZdiPDRMXkYz4JZD9fd3+YCePIxQ46pcysiuOi3XcYjIF7iyhyW/ZPY3Ft00EELc670NXVWGWrhHe1neMHepHMJ3qh+ATIWpD9uKDDPaTihU8JCIkQBg7Ajb8JIvMcxHhywM90FPBPIDvhSyEd2oZ1sVy4oBAkVuH+s6HDQMp7s2G7WQuW+lfE1oRfLjgTmoMvyJRMKe1c4Xcd1C9AbcASegGt4XmQXBJxgO4pkLQ+9GttkflBnNdCERG5WWgronfyeS8vv3wmZMBjMQxRYYx3iESb1EdN6gYHd9m2v1zIS7slyeU40E6MGnTN/SJfpEj8v9WKC90U2Q==
X-MS-TrafficTypeDiagnostic: BN1PR02MB088:
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB088;31:HrBA6hY4H5Z+AuEFJdvfYulCCGc4PJqffSjGNtVOG4sNS+/+u/jIqYOvmku45OzdDX05WQkyqyGha8F9GTU7/1JE6Xf3JP0/gN2snWkBNtvDC5GM765wzUuKqmiaj+5Pyp0ciyjOpOeQ49Oww3X5J3gS0rEREJquwUywYPYhqo3c2F2uSl9FmiUGebEQQ8YF8J5ciLfe8StZ09lKvkd46ku62MijFIuY8UMIS7Vl6DA=;20:MMTMWD2PBxDz3E/BWXe1PW64xfBz8Jv0WBX09QHIwi/4EJxmy77uMppUx6f2o5z81Z7S4Tyvv9+3TiX0mUA42DpVVitPs2Gma/ujVVRRQvYULS+4POblnNCXO/XyfV9wvUzg+gx3wsjWSDvyQZdq56zLMbGgYb0WrfqJE3JL366Kas2n8RqCN+/LXBC/HU41lxzQ6TIerjN1AuOaMFKidg4eJLRKud1pMtRmCoQu0EuZpxhHl4ynb0yDDU4TkdGSyZD3eQ1lFjM2MirFepn67KnzW7g+Rz1JnZ78+QR3LaRVs51ZLFSldbQsNeiakZBRuovdIwvHzIWHIzkaPiPY1uoI/4d5sUCZ+HsqR1MRHW244YLfLTlx7KVADQo4uFTGHBqzhZfVrLRh9s46iWmnyDzSEKZTCUyW1C3XhO4pXM5tocqS/lAoe5K6wdHzCUHtfPjsScFy9Urv5yxjuGMDg4c3B09cuqcrYtKU627QY/jdvM6xDBLiqnaBVYNYcSgt
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN1PR02MB0881131CD5BE49FDD32EE02AA560@BN1PR02MB088.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(223705240517415)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN1PR02MB088;BCL:0;PCL:0;RULEID:;SRVR:BN1PR02MB088;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB088;4:oImypa1hgYm7kCXoy3gLucmVoO73H5TFVmkYrVlkZEjSqsxdsAf5tBmzFDeNm0yf3lNalQOfPzlHRvZvg0HBnfvL/OjYt6vD5wG2jNKIR9LBU6ChYP8F1adxIxwwS6BPKMpzWjVzWcO+5++LBST/T6F9BIZAM2lczEzHN0cTNMcw+vHLI/yVw04oL6kv15IuVfxFBGIMenlLaq26aIugqV39blVrTS07JXf2yJGd47d67dPj9JFoVL8cfl1oZDcJ8PSE3M4PpLxZEvxZz6cyRk1cHNWtE2ZRSyTQ6impOP0J5dPLQYmKjq6bvpxPcETdn+o7fzNkSLdNKrIzhcVxyfImRck9526TqisuZT6gd/U=
X-Forefront-PRVS: 0742443479
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN1PR02MB088;23:C5gwZs58eK2FmQjAlsBNyITO5kEQiPCYcpcVSQVmNg?=
 =?us-ascii?Q?qrvplHt0Vca4N3p4P2ynJqaKV3keo4IkIfX+ncqnd1m4W/E3BEysOqR0wqV0?=
 =?us-ascii?Q?eFQQn8MoswMOa9o6ibFczKyS7F3SWtwZby8x0AGUVB0Bdlncky6hkbPxGS++?=
 =?us-ascii?Q?VhjzrHZBKZ+I68KTRqe3FrvyWOwWohi/kFiWXjlrc6ReNnUxD/S1B7BQR6Sv?=
 =?us-ascii?Q?Lbo6qOyA1Oa4nl8JJ3dS12c6O3XnJFfnFLvPSjJdIUvUWSf67yPyLKvVlE52?=
 =?us-ascii?Q?/MuCQgQeFquX8KmwgjeRz9CYh/Zyy5htNf3iOVO1X8UWap/hoGKdYrcB41lW?=
 =?us-ascii?Q?9xAntb0wEVzlDeYYpqT4Tz3C4dXClWWS0lDp3tuukBfYC3IoWa0u9DGwKkI8?=
 =?us-ascii?Q?QXl7QnqYLjyKfxmUx0a1PS7RZBr9qsz6UsZfym+2/uaxKA+2geoTBGP55vrv?=
 =?us-ascii?Q?AmsaJxRnCLmARLA2tbZUgNZwlsEx9p1788GrITDyEratNUhSCJHSmzknVwtI?=
 =?us-ascii?Q?SUlbNhfD2UJ6S9XuG/+JB1I7WBYMfOu/JTxZ8//i8brm/aF/k52rzPbfd6VO?=
 =?us-ascii?Q?L4tAPhuoUB7POB/XKyZwgTQX9lswt3ZKv/8hcNdRPJECOefy7Zv0d4fdYxeb?=
 =?us-ascii?Q?u0mUTQAVi127aYpWnnPvpmtdwyqIYI/Mv0F2FcgEBVyFZAX697cYqY56B8vo?=
 =?us-ascii?Q?Vy9k6YCGLDJbHYGMw/ea+JybAsnMNdfU7grsvtl3yAm35tVYOIEDvrisYBJB?=
 =?us-ascii?Q?RBwSoJSCa5+lVdzuOdfyh6niluz/qHCNSOTDp0aryy2Ehyoqe1sHAO8c3sSW?=
 =?us-ascii?Q?GTuI0vf1mlYBA75BtZEgcjHsKsm/7o0LYmez4sqNozNgNRRE5ISjK31Ex4oT?=
 =?us-ascii?Q?Kd6tG+PqX+KC0q4Rfj03ielFHYeEcZt03EPyBaB9D7w9Y7jewO4HvdfMsPHL?=
 =?us-ascii?Q?nJ4l+pVbMo8ColzjcPx7BnkJDjrsNex4WU6LwPCEYd6rGbqthc8+xDeHG39O?=
 =?us-ascii?Q?yObuYhgMWHioymZQLmdZAl5jwZszKvsI5+1yD5S9IdQZO9efxGoRIc2avaRQ?=
 =?us-ascii?Q?VAiXT+gybcX9BaFfo+WYM2lR8G7yscmgONvcb092iShsDdJZBrGdNvm635Mx?=
 =?us-ascii?Q?qlAD6m5MBOrjEdIEL5cYW5WV+GoIG9pB/xMpNcFTZiCcCk9/1sH+XZE9xeJ/?=
 =?us-ascii?Q?KAL0LnFf/xm2brjcQmC6dK7cSopj/z0LZOV30LAXO9W14nlKT7OYtNHFGXtd?=
 =?us-ascii?Q?fAg4qfkq9f4l6Qn3A=3D?=
X-Microsoft-Antispam-Message-Info: MnqydMapEw+islyNM0koKnpKKet83kmysyaNp9zCvea3/MaemagJbUPxo2ICyBULau9sO9Q1t8aUHV8h83NQOrCTFXcXMTC8cxXigMExzA2iqyqfiH/w0S3c7Wr+y0aPB+xfNQzn76HU8gq40kw+Khf/nUYJFEMdZxfrfel51e9/aycujVrJIph+ygzRR+0V6VNYqphNKLE+j5dwLmE9t0dQAGgTuMXU0bsennjp1e2RiEt1G2JewQyvo9BYIvJXznOvL0HmZido/Zyshxi1zHf92hOY7EFiTqrL9W/781C3teGqClmj2N3hVp5KDHj0ngP33U0uA652x0WOT2TUplMXturO5VILJuzOPds5ego=
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB088;6:FkDjgvj3CVqmr604dpDygNAAX9DX1xwXW237Fk0gSHJXPXfCJI4S2GYFBApTlocWvWc3XdkLO1iSRZgRO9us8euERxGiRK8pRXxPLul9cr1adaQJ+hmb0Ef+AO6E2e+aTK9g10uavmqQbJ9FK5b5E/kj5Kbb0RivK9C99hrFT/U0yeFh8wU3OZBcYkYI3VkZXRjIfOcEPssQXXyUMIIwltVJ0A6vCojmBhePx9Ko1U/jTJY3sqj8BdugL8Z0dMRb/nPtJzmn6cqM7DbbizoW1ZL2kT62R7fZHWXIQWBhuIg6Dc9qIAZE4sVNrLFN8YSBd2VI03foOioQM6MkaADmuf0g4Bkm1BwmA4l4dSh3tduhnFcfVQJdb2zPAwoO9sjlFsmc7PZ1UVpXp6K2s+crvkijmd00OIBLy/wiWEwgA9XXFYl+5ZW/hrQi7ws0eatandP6X5pxCHDy9zKZMxGcGw==;5:N7ln4l0HUaYOLJhrNx4S7PP/tXT7mWAPlh3uuC6ghKZoe/Vr9SfiafKuMBO4qhHD1Mk1FFYoJ1yXRklXDJq4jQNiz9AH/qbiKlbGenN8MDVcTjdAwOEfjNSDH0wufFA4qIpmXqBrKmiDWVkaG5g2HK4uyDUPYtiFbU4qzovV1w0=;7:Pc9lYOJbDDDOoywXF72IdMDNmxLwSw1ndCd5aVRVXCdWIhS+/fY6nPkuH1cKB1mvdOEo/vpaDa0MeA5/Ypm9J7T0hUeItjkwFGNPNS+NlA3kMWCVerKc+K5QKT9wCHo7vDZKrhVIo3vjSzrBm9M0xeBWKkzlogxm7hVeag0wX/Qlr509qjZEByM6yja9KwHwWdKyJF30C+r4tQeYYBWYojNbpBwF3YdVSfezCAjswdGkOVMojI9dhpvKUcRQsw1w
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 08:39:02.3656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88161f8b-cf16-4b33-b6c5-08d5f077be28
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR02MB088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the registration fails then mdio_unregister is called.
However at unbind the unregister ia attempted again resulting
in the below crash

[   73.544038] kernel BUG at drivers/net/phy/mdio_bus.c:415!
[   73.549362] Internal error: Oops - BUG: 0 [#1] SMP
[   73.554127] Modules linked in:
[   73.557168] CPU: 0 PID: 2249 Comm: sh Not tainted 4.14.0 #183
[   73.562895] Hardware name: xlnx,zynqmp (DT)
[   73.567062] task: ffffffc879e41180 task.stack: ffffff800cbe0000
[   73.572973] PC is at mdiobus_unregister+0x84/0x88
[   73.577656] LR is at axienet_mdio_teardown+0x18/0x30
[   73.582601] pc : [<ffffff80085fa4cc>] lr : [<ffffff8008616858>]
pstate: 20000145
[   73.589981] sp : ffffff800cbe3c30
[   73.593277] x29: ffffff800cbe3c30 x28: ffffffc879e41180
[   73.598573] x27: ffffff8008a21000 x26: 0000000000000040
[   73.603868] x25: 0000000000000124 x24: ffffffc879efe920
[   73.609164] x23: 0000000000000060 x22: ffffffc879e02000
[   73.614459] x21: ffffffc879e02800 x20: ffffffc87b0b8870
[   73.619754] x19: ffffffc879e02800 x18: 000000000000025d
[   73.625050] x17: 0000007f9a719ad0 x16: ffffff8008195bd8
[   73.630345] x15: 0000007f9a6b3d00 x14: 0000000000000010
[   73.635640] x13: 74656e7265687465 x12: 0000000000000030
[   73.640935] x11: 0000000000000030 x10: 0101010101010101
[   73.646231] x9 : 241f394f42533300 x8 : ffffffc8799f6e98
[   73.651526] x7 : ffffffc8799f6f18 x6 : ffffffc87b0ba318
[   73.656822] x5 : ffffffc87b0ba498 x4 : 0000000000000000
[   73.662117] x3 : 0000000000000000 x2 : 0000000000000008
[   73.667412] x1 : 0000000000000004 x0 : ffffffc8799f4000
[   73.672708] Process sh (pid: 2249, stack limit =3D 0xffffff800cbe0000)

Fix the same by making the bus NULL on unregister.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/ne=
t/ethernet/xilinx/xilinx_axienet_mdio.c
index 16c3bfb..757a3b3 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -218,6 +218,7 @@ int axienet_mdio_setup(struct axienet_local *lp, struct=
 device_node *np)
        ret =3D of_mdiobus_register(bus, np1);
        if (ret) {
                mdiobus_free(bus);
+               lp->mii_bus =3D NULL;
                return ret;
        }
        return 0;
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
