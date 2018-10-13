Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61661C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A1820895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3lojVacm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A1820895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeJMUwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:52:31 -0400
Received: from mail-eopbgr700046.outbound.protection.outlook.com ([40.107.70.46]:44640
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbeJMUwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGCPHH8BOrHAfn823CUTbAEsL/kukbfu6KfzTAYKgCo=;
 b=3lojVacmGTfORpdZHm7X8QrzzFss1rS888uIwfCy1Ibi8OpIFOmjSLt1uf3anH6aIH142L+NeJpUx9UOsXijLc1J6wPR4cQI+BEF+SMdmSr/Vb9xS2KBoL8AIzb18Ets4HKt5tSQgivj54bTssLS6zFcuPzIf/D5TMlfHo7lVmI=
Received: from BL0PR02CA0065.namprd02.prod.outlook.com (2603:10b6:207:3d::42)
 by CY4PR0201MB3507.namprd02.prod.outlook.com (2603:10b6:910:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.23; Sat, 13 Oct
 2018 13:15:21 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BL0PR02CA0065.outlook.office365.com
 (2603:10b6:207:3d::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.26 via Frontend
 Transport; Sat, 13 Oct 2018 13:15:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Sat, 13 Oct 2018 13:15:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlH-00068h-ED; Sat, 13 Oct 2018 06:15:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlC-0007wb-9p; Sat, 13 Oct 2018 06:15:14 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9DDF7d4026424;
        Sat, 13 Oct 2018 06:15:07 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gBJl4-0007pN-M0; Sat, 13 Oct 2018 06:15:06 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 3B0C860508; Sat, 13 Oct 2018 18:45:06 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH V6 07/10] usb: dwc3: check for requests in started list for stream capable endpoints
Date:   Sat, 13 Oct 2018 18:44:54 +0530
Message-ID: <1539436498-24892-8-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(438002)(189003)(199004)(14444005)(7416002)(106466001)(81156014)(50226002)(36756003)(81166006)(8676002)(51416003)(8936002)(26005)(106002)(50466002)(4326008)(316002)(54906003)(42186006)(48376002)(52956003)(76176011)(110136005)(5660300001)(107886003)(103686004)(6266002)(2906002)(486006)(47776003)(39060400002)(446003)(305945005)(16586007)(356004)(2616005)(11346002)(336012)(126002)(478600001)(36386004)(476003)(426003)(63266004)(186003)(2171002)(90966002)(6666004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3507;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT053;1:GfU81bdja2Mua0dqPyDhG/yhJewCf1FOeyynetAPqpyNILDycQf38j7A2i/H3KulQivpwNhW7yQyRd5XHkMsM73XAG+dFw1EFj2c31XC34iA4dDDqmNjhR1gfUzZiSSw
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44d13b36-79bc-4063-5489-08d6310ded34
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY4PR0201MB3507;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;3:zu8xqoJysTAzjBySvJ8Ydz9zqyqm3WQP9MIBqXcwjJI4yRQXzQruG9Uk51RKIliIfdnFafGECf40yidlcFRcBGVvMVlEEH3yuGEoiQhmMnh49lzM4Ac83Www7K4PAIJTmGKnzJ/88BxajbOSekt3cJZgqIDE8zgYWWocEvP0pC6KEcadBMXpftDDlzFbQmh1uF+zxJ2fX0EuWrYB4h0BnhunXSygR3MQr9WYA+5tTw0A7ZeElJkSKWBkYuIjs4fybfG8+Fmcpe63y2FqL+YnUqXbrS+4tXINta5ICuBVtn1st+Bs2NNyULCcE51NtvhXmjxJKHRhiudlj9SFWIp7D8rkSL64SYfyRmYQ5upyE2I=;25:HiOzLponeRfX790ImVwzMtCAgJ9lEuV4Ic+IzLGw/DgeWthvAc5yDVHgd7b9VWSZiUF+1YxGqi+cJTDjXKTmckaBYWV4y6R8jo7aMcrIm2xeNUqsHBJGi2KapeBZ1PIS8noZ2OkyWpmQk43Y3yrzGjr2fkwflgkAwzawLGHck5CdHIKvqe6OvtnitEav6R2e32nx6Nu9mNT0zksf2VY+RjsXA/mYNpeo/uG4yOc5BvfMyCPVjUL7N9ICa+ZRGWNsL5IXflAZMre21gYwu4WLlWbfyWw/ExYJdIYNvMr86KsBxWLISbD5UK89Ici0SRHkI854I7LjvTTT3AqoihX+iw==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3507:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;31:sjwka1h4TVBWiDb4UyDs/FQmMI20eKlA4JKWXlWsG4a/bjLtFnAP2rO7KEEDaOJNC/ZRxOkzh2kFvRCPvAvd8Z2zZZUR6ZfQ7GQdLITjtKPQhA32LL8boBM+5TXStwCxnf5drWm6r2/My8anJD8Pco7odUODzvshkmCCWXcpYLvCrQTflmR2cHsDvg2v3caVqiWHFLoHxfKxG6YYuD9bpDFgOWlnd7cKyHLn5hKMnBg=;20:OluK4odb7fCqwpa31/PTJWvKKqkH19Pk/YYedWiATANVYPatW237XcRg8pMwU2zziNrVHaEWk5EKhgEGHNVW4o4LRmmNzV0NCco2xx3cNjFy02DVI07uJ7ezEZ08cQ4BoT3OfB8beI0WANoX1xmbk0qv7g9uHw4QcM8SqrbP5O5SLahtn9y5NxiAaTHI6uZUnEZITyA8ptwPcZEk6gyvplunhttWjNzeOpx0cb+rNBsN2yv74MtFDFslFF7NIoi78DUE929CiUlH4SwqHhRUerBUjpaktw4zZJSsFXzWhmEoTrJrWyR6UNQ4BJjOSYriGxX4t86QGvdqVdx7HDsYUZAmvAwqjjE4vOvel9HwI6YaTE75qSRuObfq5ZKMCjC/W8SEE/XsCtvqyV0MYaFVswLlV3EGHgKeFClwF2df1Q+M+WoMTd5RLeRtQJR4yt15M5Ms00EnujBXg86+G1k3iebDEsJC8CYct1ONH+UcBFY3IeSdKWqoqWXyjVb7q6Jr
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3507852577447E4F84561A6FA7E30@CY4PR0201MB3507.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:CY4PR0201MB3507;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3507;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;4:JeiETRyqoFejO+OAxVYc0vlXnQo1rcLMror8mBTlxOUEwOZ1jZbIiszSM1ekhXVovEcC5XeSet03lEpeuekmzrLcIlZp4kNCF/x3W7fHmj+ZlKSwHnFkiqj5PI5VRtNWrns621XpoUEzQFtJr1qKhz0DLxr5biNXnA8l0SJ5DntjWC4fUbpKMh3H2YDChRloE+QvMtuZmVEsT2a6yM7h4/kKZo4fiFX0sdWytlL0oXaBsU89ta1/ZA6KF0o3CBoKy0/0l8t1bqMxSAjJn5nS0VfillNc4lLTDLEzlzV+l+jpyQ3FAg4+qXPDqv0CXWvT
X-Forefront-PRVS: 082465FB26
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR0201MB3507;23:2zqZZ6nflcGO7IRH40xAVf4V3Tkt9TSBOOQMiCh?=
 =?us-ascii?Q?UcXIJkStUe7YqFOqDR1mJ0zMV/WGS8J6+pUGMxGx9ozvjdH+xTraDDHah14j?=
 =?us-ascii?Q?/l5Ejp1yeqXikEwxxZIv9uMvQx3eZyKMe9u1nA0r3SXwIxzE9fGtTbuyrPPx?=
 =?us-ascii?Q?Hp/fg5f8yKXRG9rroCJseqqf+u1omBTpyZtobRDMYO2JTPrumSoUqKd73+7I?=
 =?us-ascii?Q?tHWiU7hG02I4i0ggg3SrwDY8JXzENVX50ZQwuFIvhg5exEM8Ru8CBRxBWgKu?=
 =?us-ascii?Q?IMqplDRbPYZWcYUfRKMYERCrYDj4nkM0yMESkJ7ew9uVFLyq4TIP6OQCVVWE?=
 =?us-ascii?Q?Q5c2RWMr5A+cHLclfcCeDxqWuduvhHCCzNeCf0WzCMQ/gEyyFWVBlWfKpAw+?=
 =?us-ascii?Q?1JoWbtM6DKryupgE5x6ONfdyfuO2JnIQhGWVPkC1YdGHxFrQ6BvwvOdRqIyO?=
 =?us-ascii?Q?z6a5W6I8dlnkQwBnhXIXvf1/exQABRstUy9l0QhDXMaWPLTqx6f6VnyFz/6G?=
 =?us-ascii?Q?KynI53h+sd6YW+oVfUGjxQXGXkWR3advT0DxMzTF7jeCQW0fdGIzApNoI6wt?=
 =?us-ascii?Q?csEvT9tMpYaHOQYTi1kqQEv8YacxYKok+zzng0H86f8nmRglkzPgUzUNz+fX?=
 =?us-ascii?Q?Nf73y5LgC6+xjPK75Ot0EUKBvfMrA7etm9njmJ7VqxLSV+nIojlPkJSjzW1o?=
 =?us-ascii?Q?IDaKw6CnMWuYeqlTFtD+tvK3wMlyM94F9PVJ2p+nEslVMNu/vrh3TIwEN9vq?=
 =?us-ascii?Q?pW8froe6EPFxdU44mmbx3V7/5B/K+2qZw1jQjpuVGwofElssrsjTp42LlExr?=
 =?us-ascii?Q?CWKdYxSavqyYui1/kTcsKi3ozzpMq4JUcOl4v0lx9v00YTvQbJdvx1FOX5bu?=
 =?us-ascii?Q?8iiYONI7hBkQ+j6Awg3J2/DLG/MbdiZn1kuPw96yBonqAMBzxjskE4+x2W46?=
 =?us-ascii?Q?g13EKVmTTa3baubJ6kMGVnDWUnwowCwvT21S8ajO6U8N6k2Tf0Zi14N/UILL?=
 =?us-ascii?Q?7AmLjVF4Ej+6iCIWAQQ+zSYB3HFQ0ew3Vr2KIAh50bhtkY/u3Bbjupgd2o1Q?=
 =?us-ascii?Q?BDhYXlpzH0U1VkA/pmV/1a4fUGYheZjF2O9hLwPuVHWsvpb9E/Te9nslMmFa?=
 =?us-ascii?Q?mf/WGLz1nRnfmh+iU+dDv2Q1S1DgI/ZH1gYyX2UtRyOq+QUqtd1Y5lRmiiBw?=
 =?us-ascii?Q?ndlzaY9D9IHawZ10VyefZFv3VTfZ2E9Mq/AH9ZeDyn/x54/a1HB7dt1G5lA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: /QLsXxcz5etnKneGimuLoS0rMz3m99W+cJA1Pg0ispkM8raSSNKAS6vA6wOKPOZHVCoD1cI1+GProgfJpTvA/A5tZprQgeVHnDNp+//aTT5KCgYWxrtEc8kgVhBzbwusD1wAkk/ArhiZDaCzFrz1Uv9XfuB/T2MjU4xqD7tcp2Sh9kyw0rSCvZiKQmenRP2LWdtXueQivfkrKQfLSpmB9bxdc3qBxDYTOWVNGiJXkFFlV0nMETOQoMOJ7DmbtFM7TvFiiQ17cbysi29wJvLxdCr+NTvpZyoDSzMjFQHHHukHr1ku/vIqHe9Nr2RPYCx/uBEpatueGiozjpt+l3FmO+bXqIW4GmeUZ/lM5weBe/E=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;6:8vE/LPZQ86QxLCONRr6frXLZxStAK2+m/gyC0oDcFMb7HB9teJbLA1qP4gCwIFyctiAGgd/pnV7JnVF9gTviU8MIEYIO1x3+Y57c9bKExlphXDgaljMUsVk2bZqNBg0A5e3JQkUEslsExbl6V1CYtsrQjLlD6m4MWkyjZp5ZWsnbs768tpUwQJR2aoEW7hKstu1j+ZeXi0TCeTbcZ7qZNni85MWTpqTQX1EKNHkRshxeqzVagGXGLJbUmSGs9WMBo2itQFC41cUXvlOHCD80V56w8uMyecqhNaP6UW5jxzm8X7u6eygplMdXkYpKLoVb/27AyMfhVi1Kd78P0aNWYw0tRxtq6f7tk3c0W6nDVrkEC+pOLQCNAyYQzvd43P9Ya4aPDiIpYMU+6fwFuEpVhGjT7kTcIKJWEpNvVyw3KqR/yLcaTOZ9hqH3+Q/15XeYsPf6Op8Hg6tIIeaorIakoA==;5:UcHdksDLwipChlwv9cQ0pQoO9S5zO3DqHj7Hb39OCP4NqzUi6E4E0hSMDX6JYXGA+4auJY8Eau/aulEcbskoci84diuJ7ILGLAFVx6NFVbGoMNAAMSPd0Yg7Z1/bl82Y4yX8FoWcrPDRIfzKc2xdenP62NHEXdm6DvIJJzHib58=;7:TqsKhaxZlLWz5vLhGyZf9/DtUVvRpD+l2wG1T38cI3kTWeFMzR4xIJ0tdjqQS95GzayBZg6K4c+c2kwzCHjoRd4efm0Fp0eC1UblB7y9H2wOIeXEIvfTr/GCePWlfyLA4MqZjLWtBApKX96UgCoMnAPew56SmGibqT0Ady+vTBI7zzJl0aaPpw/UvClDS+cKR7qd2ONZUSRhyacQHmFdizo/QbEDeg7rCTq8hONY4EY84ERtMdD7MvwTeBAUDAc3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2018 13:15:19.8781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d13b36-79bc-4063-5489-08d6310ded34
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For stream capable endpoints, uas layer can queue mulpile requests on
single ep with different stream ids. So, there can be multiple pending
requests waiting to be transferred. This patch changes the code to check
for any pending requests waiting to be transferred on ep started_list and
calls __dwc3_gadget_kick_transfer() if any.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v6:
	1. Replaced dep->stream_capable with dep->endpoint.stream_caapable

 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89df030..9bf1688 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2420,6 +2420,9 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
+	if (dep->endpoint.stream_capable && !list_empty(&dep->started_list))
+		__dwc3_gadget_kick_transfer(dep);
+
 	if (stop) {
 		dwc3_stop_active_transfer(dep, true);
 		dep->flags = DWC3_EP_ENABLED;
-- 
2.1.1

