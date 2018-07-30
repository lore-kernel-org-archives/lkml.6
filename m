Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF7113F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A0820881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="nwMvaJG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A0820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbeG3Phx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:37:53 -0400
Received: from mail-sn1nam02on0078.outbound.protection.outlook.com ([104.47.36.78]:58319
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbeG3Phx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGzrUSLSmIc/OI1rhbhbgr1BW14KEbYCjXqsbQhXMiE=;
 b=nwMvaJG90BvVyYVeJdXbjD80dJf/2x+5TinUsLiNKKsKr8TW4VND86Dtq3YuLe7LLqB6rF8CBjrtM3lKIwzU3z3ZDJ61kTIpfDEFkGPt/tyNwrXE63lel4k5Z3Ghqw2KxqNIiYop9akinwk6dUtIimSjeCWxs0RUsc86rUvuTUE=
Received: from BN6PR03CA0054.namprd03.prod.outlook.com (2603:10b6:404:4c::16)
 by MWHPR03MB3133.namprd03.prod.outlook.com (2603:10b6:301:3c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.21; Mon, 30 Jul
 2018 14:02:36 +0000
Received: from BN1BFFO11FD017.protection.gbl (2a01:111:f400:7c10::1:110) by
 BN6PR03CA0054.outlook.office365.com (2603:10b6:404:4c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.995.16 via Frontend Transport; Mon, 30 Jul 2018 14:02:36 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD017.mail.protection.outlook.com (10.58.144.80) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.16
 via Frontend Transport; Mon, 30 Jul 2018 14:02:36 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w6UE2ZsW015831
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 30 Jul 2018 07:02:35 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Mon, 30 Jul 2018
 10:02:35 -0400
Received: from mircea-Latitude-E6540.analog.com ([10.50.1.102]) by
 zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id w6UE2V0Z013457;      Mon, 30 Jul
 2018 10:02:32 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
CC:     Mircea Caprioru <mircea.caprioru@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Ludovic Desroches <ludovic.desroches@o2linux.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH 2/2] iio: dac: ad5770r: Add AD5770R support
Date:   Mon, 30 Jul 2018 17:02:05 +0300
Message-ID: <20180730140205.4972-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(438002)(189003)(199004)(72206003)(486006)(51416003)(478600001)(7696005)(109986005)(966005)(2906002)(14444005)(50226002)(8936002)(4326008)(106466001)(6306002)(39060400002)(50466002)(1671002)(1720100001)(356003)(7416002)(5660300001)(246002)(86362001)(36756003)(7636002)(8676002)(305945005)(575784001)(48376002)(426003)(186003)(77096007)(26005)(47776003)(44832011)(476003)(126002)(2616005)(336012)(53416004)(6666003)(1076002)(54906003)(316002)(106002)(16586007)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3133;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD017;1:QMfCzGUjpX/uqBZLRjrx8mFw8mEDOaMyvyTjgTWIIZqe0Aot+bpbJcaKYRk/nuWe9X6/OM5M3iTXCRXGKbx9aG59DFrMXFnGOY62HKU1OXvXH2y1eKE4C/mK/bWSBxqh
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 436fd32d-2353-4f9d-81eb-08d5f6251a9b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:MWHPR03MB3133;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3133;3:xiItJjoN8nmrzTwZSU/nnpjKRFoR3ruBqSLA7qCDF88ZeYa2QJtdb1Gx3Vu6WUWhbKH8tfTtkqYuYQVZuyI9550e8ff6+D0x7ScgF//ixzE62O+0PALE17i771yirB7Bg5KHsjcYX+iCHUuPW9NraYrcHLmN9RwQ235+2DVnWtjCIfVZ91RnFhjzPuLxkm6nb0a4Lh2bshOnd16aqfHQd3pdQ+vcFz7UdU31czJJonSLFJwm8ZF1BoLCup56us+w5sj/ar8uXZw3fHH9iBNJ5nh+xySKONXrnztIOCWPkhGJgFSVonqwr+TVO938Klqf4Eu91zCA9vVwTALhYs3M7X+QgVEf81y3FJZKWxoRy9M=;25:drKkJf7bBFBd1jlJcXp0NT1tSRmYgCS2zDaLXBLu1Oraf2ag9avJQcI4QBczXFGbuwIBCVzL1Ra8WcaOQa5er2V3dyb+wtJKxCfx6mMFr/EHNfLr6Lp0pjL8NaLDykb90Oa3Q7DqQSKAa6MwmGbwALUPFYYbO2l6PuyoVvbQdfMVfXgEWJkwpL01/AKnR73CCcQIYts9jfupwfmlbCqiFh1SxP7F1uJcdr4ehcQNIBD5nhEWXBrfYE15MZ9Y3pf16UcQlvp+E7AMDdDJUcwcEHix8xIY4qgLapth4VkqBPbny9Ctr2bxnQ7JthiZ140BL1PQnzsebwmk/DX6OlFi5w==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3133:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3133;31:IScB+cZmGcXyYfsBVve+TiMe8/75wGO4e+q0ms4iB9q2a2amwoGD5l1Zslqo6a/+x/72qLRBk36qHCeyEL5B70AlrtA9XshD5rpOeAXsBHJOtgTbKHn2g53zSXlfvRTD0zYw3e14XfAe1vgX9SBmDHTwrvT/pD6YhujXFFONAmtGNkMYonJ9xbd/BMoUAweDzDRNorDmjmv3qkRR685X51kpZEcG6mkbfrzg5ibN8oQ=;20:GhAhCAtsH6Hfcx7ATtChwvfp/NHz6gjkc/hDx2VbXIBcQ11n084n+Xn/QXP8tLJS8kS+cEzipNos63eyKw+rOXo2n7QAGaJ7V2hml2LJBnrghHw+L9YnGGiQUO6JryOiiMebY7C4pV10OjMV5rN2DzGWvJSrBy2eNVvPmP8OTa/iRx6krn4gMnCLntwP4wP6/5xGjt2VBFcO0peFIoEU1znQg3a2CUh2DKf+mPQyDwRpKMEpiIxu2McOq6ii+AQxhmz/7V1ce4oODvvLtbwLSWUDvMrj6XAowC2J2/ZdHAienLJFKFGwRd4ZYrLcOgjWzDTexmzBzPql5TPudWY1oPqJ3BjN/7kfKtKVZ/tqaXaPqen4BolL7wUmgpXJQjho9vmptIjr+KwaSck78xKYDsRe2lVfPSfS+Z3+VrjxpuLrGrY1RWvf4M5LRGwwDXcEGzNJ4qRoHuPMR8KCuWfVyiMdzYW1i7IZQcZrZSn4tyibNmTctJVLNA0qVkVWpWhO
X-Microsoft-Antispam-PRVS: <MWHPR03MB3133AD2382AFB6FF4FEDC8F9812F0@MWHPR03MB3133.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674)(95692535739014)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB3133;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB3133;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3133;4:XtfHWMf6eT9NJjzjsHuhZW1f5I4Bb5CuQJsHZaDGCDsTFeQ7A0yMT6+NNSwXQFHe041tdqBA1+nWZE7doR14ouTQEKlR91xbUa1kvo73BqN414Hqq0ZfA80syN5Gy5RepAFUv6VggOb7c+RQhA+yMdhUyxTG5VYEaQk5EcUdkMQs2nOo2jirzHP0Al0wM6V8H8g0Bw4avkF15VBvuHim+BEhIQEdpycMw8aYPKoLt712OT9QSqL0cF7FoRfJFMxDv2NOwjRPP3TuzNM0PqFtelGLF7c5XVFAG2zikl1W1h6Zy/D9wKhXq9B7PFGwk4uJRcklv9UDQ4VDn9ytiY8qox1UjsXP262C+FaYyBUtw1+Gr8k8uQiouPbU/cF/RBm3LPmBRgEVw9hf0sLcqxHL2I5hqXMeYA6LiuwH05U537o=
X-Forefront-PRVS: 0749DC2CE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3133;23:ZsJMICtZYYLyMfjhchRfzJ7o0/B2swEp1KHkMLLHJ?=
 =?us-ascii?Q?F6IXVJie7zjDPk0laejiiodYyZ1CPucLSAag2xvFhMI38RYmMMHA7Jo7vaQN?=
 =?us-ascii?Q?RDtDdLq4uDbHkFIPmXWrR6Sjs4WG4oXgVlmXFZE/Z55cHw1stOsL9NjKez3S?=
 =?us-ascii?Q?4Hs/lmpIawebuyucLIF1OXid/y9o1rRGUAm/1znfSiCjPQiIj/MTWVHBnhlE?=
 =?us-ascii?Q?Jxvcd4sMTxf1zMFt2XasS1cPCMrr4WDF71gwb1oSbzqX36c7Wg1bDckqzNbu?=
 =?us-ascii?Q?ReYeU4q6HEsKk4oxk40/qG7Z1/82XtpmroeVbshIyqbu24ezxhHBvtoVVQeG?=
 =?us-ascii?Q?Y5hjyuEY0DARPcIpxRI7BrSRNMocifzQmo37NZdc8cZ089I1mNAMIWJFgdi9?=
 =?us-ascii?Q?JdRlLzX2bkQM18/qkYjhpr6I3s6IYDokRLF1HqRTA5P/8/aH31K2w2jIcHpL?=
 =?us-ascii?Q?Oefms/Yoe/5SsX6YEsDj5Q/SdWT0mz5uJKFQtVn8IsfLRDnUHaIpSjGJ0zOM?=
 =?us-ascii?Q?SFfUuG9SDY1+aZdNVcLxsaIMxeBkIugcy1qRquqmu2J+CscpjRxNUk45sz0y?=
 =?us-ascii?Q?5g6/VVqRgS++wykpQHNkus7irThjc3kX+BvEI148pEHwXywecI4DBRofqIkW?=
 =?us-ascii?Q?ky8Tb2J88sSk326m3X+dpmbwOdHp65XtbqAU3ZIWS1OgSO0Yz5+CjbJlcip9?=
 =?us-ascii?Q?3kOr2zc/6h3wkilfg2FUy8ZWX+n88QaTzYIfzv9DgHnZT/+4QptzJmFvP+0K?=
 =?us-ascii?Q?OAG9YDxCbvQR0u5XkDrOq079CFYchQkuYfzRHN10hg8g/BKmM6gfXCnOeKzW?=
 =?us-ascii?Q?v7Wu8in0XCa52w2ygmZgONf8mLloKhKdj37/6GhWbjy9LnUFXdEkjqjxAt9F?=
 =?us-ascii?Q?b7u0jcvVDAHrnt94eur3DZgmBe889X+bHdeaU5yaYKdPf4kCX4pH1Ai4Dux2?=
 =?us-ascii?Q?QTjY6FbmqyU2J2VAiexE9MH9eaJhf4cnsepZeAWpEh9tUftAcNV5RfNul7rx?=
 =?us-ascii?Q?3Xi13GRcCavMvrZV4e6dWjHBcOBlrRgpc51YeRSaeS5jAae/BoyFRg227+8V?=
 =?us-ascii?Q?7SWBkXQYpOBf/ris4iXiFnyq9Jp8L7Rq9jPmQPnddZynIlbQqM6pl/hS/yES?=
 =?us-ascii?Q?HULcUrbc8aCHK/mj+dtWwI1tiA86KUYDyE81eA8NRBmybPpHOycPjkVDEMHy?=
 =?us-ascii?Q?Hbe4GFfOrf8nI44UTKiFUf9glKw9cgMSQcMd8hiX7NrZtpJey8XG2kJ6w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: Rj1jeRWjt+zHm6EaPZnGunaAO4HI4Eb6HvekMAtaL/qZfdENTZZczziCfuzpM+6O/x0uQrM6hOs28bGMSIACB692yhDqgWUimKbg7ntqRvc3NsyJHgx1JIViREKF4PKHvK5kd29c02A/lcrzgxijKe4sM46Ksl9Eh9whWMvCEBmhOoKx9oZ9KFlB3ceYdkI7ZqMfj+Kuv/kwM5Wd1s2F4ZZc5cdL2jorqBJrruAV01fnznMPjLxZaR36mfZb2Xd3GU/FcUty9hj6WWN3sM9pjOpJjjFM6ioyp2aqUlh1M5WFDHDM/R+kYcnjLBe1mEnw9f/HWz8Wm+MQJaP9ahpMwdgaJwb6qXVxZKGEUoWccZU=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3133;6:irD4LeYP22L8x9I8n7IDFDdDPr+77cf3yt3Ta3DdUYOGyrzBgu/0OqG3EjReAsVq0faDA9YwjRiT+Q3Pe7fpGwI1EDRO6JD/yTH9G8pWFeb9bfxvWmB5EGGG/XIzzqlVbOv3aldT3sw0RWPK43qZ1FsI2X3MNsoEWCHk9CaDglfA97K4M90nVHacX0kN00jNCLXCa6O4fBb5QUjxETo0YEB6r5N2qG2n2UTMm25C+biXTNUSvE4YyvxKnNx4thiovAWJ1MpOdn2yOpBjeHXvF5mGroebJ3HxMMqTLjGod62DKpT3T+32qTmM37TPVkEhbeqx4s9QJ983urWua9Bfx8PbY4fizoUH08NVxoXbjyoFUOJkUa8A+qP4Wao/+WuuU+HdNgXPyTYbBOwAbpLVViEE++jZ5Z9vEwH2Wh8uB9QFhjeTBEz6vg4E+r+BpYbp90/0o9KklhLJoq757jsd8w==;5:o+PRWYealdFI2xNNUrzpyF9s8LHo11ZxbWl8REvjffhVDxRXgHnsPo45U7xqsCNmGPdw2kvml8V2X8/2DzhJpEK6zRioKGIGLKhAXc2uY0Y/2PqexuIdw6STlBkM0Il8EEB5lS5ljRd3sSetOppqxNjjyAwKnnDTu12hL8BqJwE=;7:52wvyy3U3dJFI/yb51uFudE5ugX+tuggVh1eyIECMvp08Eh1KR9nvYuu0Sigr6OgqOxI8SJ1JAsMR5bedSFTNqvGUK3wmBubDY+/vYWnXyEV8RvukOUMm/9Brq3bCQng0ZcuMX7TZtF9clK/r28th79w6igb86UplJGCFt7pmt2EnKsw/TzYOzxLye4dqfm/YUd+1R9wj4dQlEVMQ5FK4FNl4oP797vIgrbgA1zcnxxXoD52o9DlM82sL4IbKRG2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 14:02:36.1383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 436fd32d-2353-4f9d-81eb-08d5f6251a9b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3133
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD5770R is a 6-channel, 14-bit resolution, low noise, programmable
current output digital-to-analog converter (DAC) for photonics control
applications.

It contains five 14-bit resolution current sourcing DAC channels and one
14-bit resolution current sourcing/sinking DAC channel.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/dac/Kconfig   |  10 +
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/ad5770r.c | 548 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 560 insertions(+)
 create mode 100644 drivers/iio/dac/ad5770r.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c2626079592..c9168ae18f0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -762,6 +762,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/dac/ad5770r.txt
+F:	drivers/iio/dac/ad5770r.c
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 25bed2d7d2b9..798db486c333 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -171,6 +171,16 @@ config AD5764
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5764.
 
+config AD5770R
+	tristate "Analog Devices AD5770R IDAC driver"
+	depends on SPI_MASTER
+	help
+	  Say yes here to build support for Analog Devices AD5770R Digital to
+	  Analog Converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5770r.
+
 config AD5791
 	tristate "Analog Devices AD5760/AD5780/AD5781/AD5790/AD5791 DAC SPI driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 603587cc2f07..0a38690bbd2b 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_AD5593R) += ad5593r.o
 obj-$(CONFIG_AD5755) += ad5755.o
 obj-$(CONFIG_AD5761) += ad5761.o
 obj-$(CONFIG_AD5764) += ad5764.o
+obj-$(CONFIG_AD5770R) += ad5770r.o
 obj-$(CONFIG_AD5791) += ad5791.o
 obj-$(CONFIG_AD5686) += ad5686.o
 obj-$(CONFIG_AD7303) += ad7303.o
diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
new file mode 100644
index 000000000000..9d3db3b25335
--- /dev/null
+++ b/drivers/iio/dac/ad5770r.c
@@ -0,0 +1,548 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD5770R Digital to analog converters driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/delay.h>
+#include <linux/property.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+
+/* SPI configuration registers */
+#define AD5770R_INTERFACE_CONFIG_A	0x00
+
+/* AD5770R configuration registers */
+#define AD5770R_CHANNEL_CONFIG		0x14
+#define AD5770R_OUTPUT_RANGE(ch)	(0x15 + (ch))
+#define AD5770R_REFERENCE		0x1B
+#define AD5770R_DAC_LSB(ch)		(0x26 + 2 * (ch))
+#define AD5770R_DAC_MSB(ch)		(0x27 + 2 * (ch))
+#define AD5770R_CH_SELECT		0x34
+#define AD5770R_CH_ENABLE		0x44
+
+/* AD5770R_INTERFACE_CONFIG_A */
+#define AD5770R_ITF_CFG_A_SW_RESET(x)		(((x) & 0x1) | 0x80)
+
+/* AD5770R_CHANNEL_CONFIG */
+#define AD5770R_CFG_CH0_SINK_EN(x)		(((x) & 0x1) << 7)
+#define AD5770R_CFG_SHUTDOWN_B(x, ch)		(((x) & 0x1) << (ch))
+
+/* AD5770R_OUTPUT_RANGE */
+#define AD5770R_RANGE_OUTPUT_SCALING(x)		(((x) & 0x3F) << 2)
+#define AD5770R_RANGE_MODE(x)			((x) & 0x03)
+
+/* AD5770R_REFERENCE */
+#define AD5770R_REF_RESISTOR_SEL(x)		(((x) & 0x1) << 2)
+#define AD5770R_REF_SEL(x)			(((x) & 0x3) << 0)
+
+/* AD5770R_CH_ENABLE */
+#define AD5770R_CH_SET(x, channel)		(((x) & 0x1) << (channel))
+
+#define AD5770R_MAX_CHANNELS	6
+#define AD5770R_MAX_CH_MODES	14
+#define AD5770R_LOW_VREF	1250
+#define AD5770R_HIGH_VREF	2500
+
+enum ad5770r_ch {
+	AD5770R_CH0 = 0,
+	AD5770R_CH1,
+	AD5770R_CH2,
+	AD5770R_CH3,
+	AD5770R_CH4,
+	AD5770R_CH5
+};
+
+enum ad5770r_ch0_modes {
+	AD5770R_CH0_0_300 = 0,
+	AD5770R_CH0_NEG_60_0,
+	AD5770R_CH0_NEG_60_300
+};
+
+enum ad5770r_ch1_modes {
+	AD5770R_CH1_0_140_LOW_HEAD = 1,
+	AD5770R_CH1_0_140_LOW_NOISE,
+	AD5770R_CH1_0_250
+};
+
+enum ad5770r_ch2_5_modes {
+	AD5770R_CH_LOW_RANGE = 0,
+	AD5770R_CH_HIGH_RANGE
+};
+
+enum ad5770r_ref_v {
+	AD5770R_EXT_2_5_V = 0,
+	AD5770R_INT_1_25_V_OUT_ON,
+	AD5770R_EXT_1_25_V,
+	AD5770R_INT_1_25_V_OUT_OFF
+};
+
+struct ad5770r_out_range {
+	unsigned char	out_scale;
+	unsigned char	out_range_mode;
+};
+
+/**
+ * struct ad5770R_state - driver instance specific data
+ * @spi			spi_device
+ * @regmap:		regmap
+ * @regulator		fixed regulator for reference configuration
+ * @gpio_reset		gpio descriptor
+ * @output_mode		array contains channels output ranges
+ * @vref		reference value
+ * @internal_ref	internal reference flag
+ * @ch_pwr_down		powerdown flags
+ */
+struct ad5770r_state {
+	struct spi_device		*spi;
+	struct regmap			*regmap;
+	struct regulator		*vref_reg;
+	struct gpio_desc		*gpio_reset;
+	struct ad5770r_out_range	output_mode[AD5770R_MAX_CHANNELS];
+	int				vref;
+	bool				internal_ref;
+	bool				ch_pwr_down[AD5770R_MAX_CHANNELS];
+};
+
+static const struct regmap_config ad5770r_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.read_flag_mask = BIT(7),
+};
+
+struct ad5770r_output_modes {
+	enum ad5770r_ch ch;
+	unsigned char mode;
+	int min;
+	int max;
+};
+
+static struct ad5770r_output_modes ad5770r_rng_tbl[] = {
+	{ AD5770R_CH0, AD5770R_CH0_0_300, 0, 300 },
+	{ AD5770R_CH0, AD5770R_CH0_NEG_60_0, -60, 0 },
+	{ AD5770R_CH0, AD5770R_CH0_NEG_60_300, -60, 300 },
+	{ AD5770R_CH1, AD5770R_CH1_0_140_LOW_HEAD, 0, 140 },
+	{ AD5770R_CH1, AD5770R_CH1_0_140_LOW_NOISE, 0, 140 },
+	{ AD5770R_CH1, AD5770R_CH1_0_250, 0, 250 },
+	{ AD5770R_CH2, AD5770R_CH_LOW_RANGE, 0, 55 },
+	{ AD5770R_CH2, AD5770R_CH_HIGH_RANGE, 0, 150 },
+	{ AD5770R_CH3, AD5770R_CH_LOW_RANGE, 0, 45 },
+	{ AD5770R_CH3, AD5770R_CH_HIGH_RANGE, 0, 100 },
+	{ AD5770R_CH4, AD5770R_CH_LOW_RANGE, 0, 45 },
+	{ AD5770R_CH4, AD5770R_CH_HIGH_RANGE, 0, 100 },
+	{ AD5770R_CH5, AD5770R_CH_LOW_RANGE, 0, 45 },
+	{ AD5770R_CH5, AD5770R_CH_HIGH_RANGE, 0, 100 },
+};
+
+static int ad5770r_set_output_mode(struct ad5770r_state *st,
+				   const struct ad5770r_out_range *out_mode,
+				   enum ad5770r_ch channel)
+{
+	unsigned int regval;
+
+	regval = AD5770R_RANGE_OUTPUT_SCALING(out_mode->out_scale) |
+		 AD5770R_RANGE_MODE(out_mode->out_range_mode);
+
+	return regmap_write(st->regmap,
+			    AD5770R_OUTPUT_RANGE(channel), regval);
+}
+
+static int ad5770r_set_reference(struct ad5770r_state *st)
+{
+	unsigned int regval = 0;
+
+	if (st->internal_ref) {
+		regval = AD5770R_REF_RESISTOR_SEL(0) |
+			 AD5770R_REF_SEL(AD5770R_INT_1_25_V_OUT_OFF);
+	} else {
+		switch (st->vref) {
+		case AD5770R_LOW_VREF:
+			regval |= AD5770R_REF_SEL(AD5770R_EXT_1_25_V);
+			break;
+		case AD5770R_HIGH_VREF:
+			regval |= AD5770R_REF_SEL(AD5770R_EXT_2_5_V);
+			break;
+		default:
+			regval = AD5770R_REF_RESISTOR_SEL(st->internal_ref) |
+				 AD5770R_REF_SEL(AD5770R_INT_1_25_V_OUT_OFF);
+			break;
+		}
+	}
+
+	return regmap_write(st->regmap, AD5770R_REFERENCE, regval);
+}
+
+static int ad5770r_soft_reset(struct ad5770r_state *st)
+{
+	return regmap_write(st->regmap, AD5770R_INTERFACE_CONFIG_A,
+			    AD5770R_ITF_CFG_A_SW_RESET(1));
+}
+
+static int ad5770r_reset(struct ad5770r_state *st)
+{
+	if (st->gpio_reset) {
+		gpiod_set_value(st->gpio_reset, 0);
+		udelay(100);
+		gpiod_set_value(st->gpio_reset, 1);
+	} else {
+		/* Perform a software reset */
+		return ad5770r_soft_reset(st);
+	}
+
+	/* data must not be written during reset timeframe */
+	mdelay(1); /* TODO update with value from datasheet once available */
+
+	return 0;
+}
+
+static int ad5770r_get_range(struct ad5770r_state *st,
+			     enum ad5770r_ch ch, int *min, int *max)
+{
+	int i;
+	unsigned char tbl_ch, tbl_mode, out_range;
+
+	out_range = st->output_mode[ch].out_range_mode;
+
+	for (i = 0; i < AD5770R_MAX_CH_MODES; i++) {
+		tbl_ch = ad5770r_rng_tbl[i].ch;
+		tbl_mode = ad5770r_rng_tbl[i].mode;
+		if (tbl_ch == ch && tbl_mode == out_range) {
+			*min = ad5770r_rng_tbl[i].min;
+			*max = ad5770r_rng_tbl[i].max;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ad5770r_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct ad5770r_state *st = iio_priv(indio_dev);
+	int max, min, ret;
+	unsigned char buf[2];
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_bulk_read(st->regmap,
+				       chan->address,
+				       buf, 2);
+		if (ret)
+			return 0;
+		*val = ((u16)buf[0] << 6) + (buf[1] >> 2);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		ret = ad5770r_get_range(st, chan->channel, &min, &max);
+		if (ret < 0)
+			return ret;
+		if (min < 0)
+			min = 0;
+		*val = max - min;
+		*val2 = 14;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5770r_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct ad5770r_state *st = iio_priv(indio_dev);
+	unsigned char buf[2];
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		buf[0] = ((u16)val >> 6) & 0xFF;
+		buf[1] = (val & 0x3F) << 2;
+		return regmap_bulk_write(st->regmap, chan->address,
+					 buf, ARRAY_SIZE(buf));
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5770r_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct ad5770r_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	else
+		return regmap_write(st->regmap, reg, writeval);
+}
+
+static const struct iio_info ad5770r_info = {
+	.read_raw = ad5770r_read_raw,
+	.write_raw = ad5770r_write_raw,
+	.debugfs_reg_access = &ad5770r_reg_access,
+};
+
+static int ad5770r_store_output_range(struct ad5770r_state *st,
+				      int min, int max, int index)
+{
+	int i;
+
+	for (i = 0; i < AD5770R_MAX_CH_MODES; i++) {
+		if (ad5770r_rng_tbl[i].ch != index)
+			continue;
+		if (ad5770r_rng_tbl[i].min != min ||
+		    ad5770r_rng_tbl[i].max != max)
+			continue;
+		st->output_mode[index].out_range_mode = ad5770r_rng_tbl[i].mode;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t ad5770r_read_dac_powerdown(struct iio_dev *indio_dev,
+		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+{
+	struct ad5770r_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->ch_pwr_down[chan->channel]);
+}
+
+static ssize_t ad5770r_write_dac_powerdown(struct iio_dev *indio_dev,
+		uintptr_t private, const struct iio_chan_spec *chan,
+		const char *buf, size_t len)
+{
+	struct ad5770r_state *st = iio_priv(indio_dev);
+	unsigned int regval;
+	bool readin;
+	int ret;
+
+	ret = kstrtobool(buf, &readin);
+	if (ret)
+		return ret;
+
+	readin = !readin;
+
+	regval = AD5770R_CFG_SHUTDOWN_B(readin, chan->channel);
+	if (chan->channel == AD5770R_CH0 &&
+	    st->output_mode[AD5770R_CH0].out_range_mode > AD5770R_CH0_0_300) {
+		regval |= AD5770R_CFG_CH0_SINK_EN(readin);
+		ret = regmap_update_bits(st->regmap, AD5770R_CHANNEL_CONFIG,
+					 BIT(chan->channel) + BIT(7), regval);
+	} else {
+		ret = regmap_update_bits(st->regmap, AD5770R_CHANNEL_CONFIG,
+					 BIT(chan->channel), regval);
+	}
+	if (ret)
+		return ret;
+
+	regval = AD5770R_CH_SET(readin, chan->channel);
+	ret = regmap_update_bits(st->regmap, AD5770R_CH_ENABLE,
+				 BIT(chan->channel), regval);
+	if (ret)
+		return ret;
+
+	st->ch_pwr_down[chan->channel] = !readin;
+
+	return ret ? ret : len;
+}
+
+static const struct iio_chan_spec_ext_info ad5770r_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = ad5770r_read_dac_powerdown,
+		.write = ad5770r_write_dac_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	{ },
+};
+
+#define AD5770R_IDAC_CHANNEL(index, reg) {			\
+	.type = IIO_CURRENT,					\
+	.address = reg,						\
+	.indexed = 1,						\
+	.channel = index,					\
+	.output = 1,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			BIT(IIO_CHAN_INFO_SCALE),		\
+	.ext_info = ad5770r_ext_info,				\
+}
+
+static const struct iio_chan_spec ad5770r_channels[] = {
+	AD5770R_IDAC_CHANNEL(0, AD5770R_DAC_MSB(0)),
+	AD5770R_IDAC_CHANNEL(1, AD5770R_DAC_MSB(1)),
+	AD5770R_IDAC_CHANNEL(2, AD5770R_DAC_MSB(2)),
+	AD5770R_IDAC_CHANNEL(3, AD5770R_DAC_MSB(3)),
+	AD5770R_IDAC_CHANNEL(4, AD5770R_DAC_MSB(4)),
+	AD5770R_IDAC_CHANNEL(5, AD5770R_DAC_MSB(5)),
+};
+
+static int ad5770r_channel_config(struct ad5770r_state *st)
+{
+	int ret, tmp[2], min, max, i;
+	unsigned int num;
+	struct fwnode_handle *child;
+	bool ch_config[AD5770R_MAX_CHANNELS] = {0};
+
+	device_for_each_child_node(&st->spi->dev, child) {
+		ret = fwnode_property_read_u32(child, "num", &num);
+		if (ret)
+			return ret;
+		if (num > AD5770R_MAX_CHANNELS)
+			return -EINVAL;
+
+		ret = fwnode_property_read_u32_array(child,
+						     "adi,range-microamp",
+						     tmp, 2);
+		if (ret)
+			return ret;
+
+		min = tmp[0] / 1000;
+		max = tmp[1] / 1000;
+		ret = ad5770r_store_output_range(st, min, max, num);
+		if (ret)
+			return ret;
+
+		ch_config[num] = true;
+	}
+
+	for (i = 0; i < AD5770R_MAX_CHANNELS; i++)
+		if (!ch_config[i])
+			return -EINVAL;
+
+	return ret;
+}
+
+static int ad5770r_init(struct ad5770r_state *st)
+{
+	int ret, i;
+
+	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
+			 GPIOD_OUT_HIGH);
+	if (IS_ERR(st->gpio_reset))
+		return PTR_ERR(st->gpio_reset);
+
+	/* Perform a reset */
+	ret = ad5770r_reset(st);
+	if (ret)
+		return ret;
+
+	/* Set output range */
+	ret = ad5770r_channel_config(st);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < AD5770R_MAX_CHANNELS; i++) {
+		ret = ad5770r_set_output_mode(st,
+					      &st->output_mode[i], i);
+		if (ret)
+			return ret;
+	}
+
+	ret = ad5770r_set_reference(st);
+	if (ret)
+		return ret;
+
+	/* Set outputs off */
+	ret = regmap_write(st->regmap, AD5770R_CHANNEL_CONFIG, 0x00);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD5770R_CH_ENABLE, 0x00);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < AD5770R_MAX_CHANNELS; i++)
+		st->ch_pwr_down[i] = true;
+
+	return ret;
+}
+
+static int ad5770r_probe(struct spi_device *spi)
+{
+	struct ad5770r_state *st;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+
+	st->spi = spi;
+
+	regmap = devm_regmap_init_spi(spi, &ad5770r_spi_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+	st->regmap = regmap;
+
+	st->vref_reg = devm_regulator_get(&spi->dev, "vref");
+	if (!IS_ERR(st->vref_reg)) {
+		ret = regulator_enable(st->vref_reg);
+		if (ret)
+			dev_err(&spi->dev, "Failed to enable vref regulators: %d\n",
+				ret);
+
+		ret = regulator_get_voltage(st->vref_reg);
+		if (ret < 0) {
+			st->vref = AD5770R_LOW_VREF;
+			st->internal_ref = true;
+		} else {
+			st->vref = ret / 1000;
+		}
+	} else {
+		st->vref = AD5770R_LOW_VREF;
+		st->internal_ref = true;
+	}
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ad5770r_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad5770r_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad5770r_channels);
+
+	ret = ad5770r_init(st);
+	if (ret < 0) {
+		dev_err(&spi->dev, "AD5770R init failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&st->spi->dev, indio_dev);
+}
+
+static const struct spi_device_id ad5770r_id[] = {
+	{ "ad5770r", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad5770r_id);
+
+static struct spi_driver ad5770r_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = ad5770r_probe,
+	.id_table = ad5770r_id,
+};
+
+module_spi_driver(ad5770r_driver);
+
+MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5770R IDAC");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

