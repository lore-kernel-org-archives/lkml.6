Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9E5C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C2B2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Uz6WGI5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C2B2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeK3S1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:27:35 -0500
Received: from mail-eopbgr770079.outbound.protection.outlook.com ([40.107.77.79]:18880
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbeK3S1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcdFL53JFcGe+qV3q9TqOiGQFdrUYbGoMfsOezww+3E=;
 b=Uz6WGI5CmOU7MOpqMvWlFyMkmhviHfZ6vsntv/k+nmGmQjt1cJyxgvcufrMyLs0Ii1m8gfRYOnx9l2zyXzHMV+J9pEHlS5UfscbmO3CSmyj+Bk7bsuoPu0SDi9ONFG4GAGSsPhIJEgesNqufFEJ5otIH+WFzSGd0m6zPYyEZGWY=
Received: from SN6PR02CA0002.namprd02.prod.outlook.com (2603:10b6:805:a2::15)
 by MWHPR0201MB3514.namprd02.prod.outlook.com (2603:10b6:301:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.18; Fri, 30 Nov
 2018 07:19:10 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by SN6PR02CA0002.outlook.office365.com
 (2603:10b6:805:a2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.18 via Frontend
 Transport; Fri, 30 Nov 2018 07:19:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=bestguesspass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1382.18
 via Frontend Transport; Fri, 30 Nov 2018 07:19:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:36890 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gSd4v-0001qL-CY; Thu, 29 Nov 2018 23:19:09 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gSd4p-0004eC-Vd; Thu, 29 Nov 2018 23:19:04 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAU7J29M001512;
        Thu, 29 Nov 2018 23:19:02 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gSd4o-0004ce-8C; Thu, 29 Nov 2018 23:19:02 -0800
Subject: Re: [PATCH 2/3] dt-bindings: mmc: sdhci-of-arasan: Add deprecated
 message for am654
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>,
        <michal.simek@xilinx.com>, <kishon@ti.com>
References: <20181129161513.31734-1-faiz_abbas@ti.com>
 <20181129161513.31734-3-faiz_abbas@ti.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <6f4734e6-8238-2e14-ae11-114e396df75c@xilinx.com>
Date:   Fri, 30 Nov 2018 08:18:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129161513.31734-3-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39850400004)(396003)(346002)(2980300002)(438002)(189003)(199004)(106466001)(36386004)(63266004)(106002)(31686004)(8936002)(81166006)(81156014)(7416002)(229853002)(65826007)(4326008)(316002)(58126008)(110136005)(54906003)(5660300001)(8676002)(9786002)(64126003)(126002)(356004)(186003)(31696002)(77096007)(478600001)(26005)(2486003)(23676004)(230700001)(6666004)(2201001)(336012)(6246003)(426003)(76176011)(36756003)(47776003)(65806001)(50466002)(305945005)(65956001)(44832011)(486006)(2906002)(11346002)(446003)(476003)(2616005)(15650500001)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3514;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT011;1:L71/3uMHzd55wYO8ll51MCAl/x1V6qXQgAaNibiGhY0ERvpzlH7BB5cnFr/fK7USEyZwTrfonEJzCRoA9GwVwittpIKz2Np97h6eoJZGn2PU5PnV5km6CvLN30jrKRVK
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b232f70-01e7-44fa-9dcb-08d656941fa6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;3:72elRX1xnGIwHSIFqlujrIXobXBeNXOuVI9g1zuT8asc5qDJmVkYMTUksL1+THUca6J7k2hINxhYLSbUgohMmCJ4Wz1czXubFOykmmDd5i7qQ+V0tMqs94AW2Gsxea5q3z4KzlPmWltUHDNa3gKFM4NMtKKj1Lqb2pIdqXZTI5LoTz6zc/ofZY63LN71/NpOLLk6ZWacpZL8rhFLHh+OTAb9cQjBu502L7NyPTJR8U26OKJya7F2+WlnVCOOFb+ngGi6s1UKZsxJYeg5bUS1+8PJNq59NwvTNL3zDIsbp88pJCfLRxS0zr7V14xmCUa0vFKpwOmft0Z/0QQHhe+1btmT9De2tJsq9jFYxdRE/cM=;25:DEk7uzaVNYcsB5f+puxpyC3sJ07NwWBckI3FbC3C5ndGZK2TW32ajRAtwjvFRdQK7A2oyFKJZyWXmCyjBy+b5SU7lCNZqjVdVtsab5Bd8oPuqZDPZ4yHokhYcBnO0lvnnOoW2vXVpDq5zsezVxo1XKlgSHCxLBa/J1M6B2ppJd6H0r9D/o7qCROs4hbF9bzmYSXx0+AYS2S+232St8ppyDb+rxCQOPuSkGGNyASpBtQ+xiLIiAOglicRPDIufwoolmkORejXyGLiRBCj7Dfhceg3FIS+WHARjbK/u+Pv5DeekqUyIdYDPEDaVu19M3HkB25Rc/lyR/efwtlb+oVCjw==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3514:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;31:2UxWDznPjbekiYzsV1/nQEWViDQKvrW1uc0yNmgcxsm+utM6LKfnYtXgtIgDQ/V41IaRqWiiUTO4/fb+qZuFbZHP8xzl1S5FaW5dWDgsSaV/GzXYzowswDaYlw+FNm0dVvLlvYCgWwvjqCfe4LPG+d5OJwUBfa7cEvEOmAl9mYrOJKZ9s3hbbL4Ig9Fkjr0tH9cxWctPlS8aqhVBYnSi8SS/tGUb1TKfbwofW7uWIp0=;20:FklqbzMStvx7ntEqTOu0SWUEnMioJOMsx6PqmTTf3JRSjvzfv71Nmvm2U9jZA2G4ZT6N0faxzoiubXJaLFoBpw9nAD9dVXoLHXpb4CMsNwyz59fpsWqF/V7NUodgVsIf1LPqFlNMzUzv0Yv/HG+g3RqXx/WIju1acO4G6QX/edM4LIYKoKUGKGklGZ2la3UimJ9WDcVaNh9ulBMuDXNBVnU8TynKmW17eazkPIKLP71BRVNDGlykkHPVQeIeUuexr/wdi8ebmj/QLx0/syNzMafz2H7lHBqLKUwxFWu+FwEZZJCcZY4XxEyl0ZTbi2TFb4w62Pu0bnbwRiYoaPlsCQG24bQUi0zKlP0mRvp8tWVqpRg8sUPrnQmqfZxX6Rz4BpHlj7fdqftH86K73iu/HJVYUpnCNyCv8NjjDCPxk5TMokw2mM7feFd0/RCVs27zn8lSNUYglzmsTwWyMfDAWWS/vNsTLL4aiUfYsCWEGGeT5k2e9WBTIzNDhygm82hG
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3514DAB384A20BC92ABF4696C6D30@MWHPR0201MB3514.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231453)(999002)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0201MB3514;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;4:RdCdJMJGHe+TpsLUXz6hTb7YY03cfxNn1h+3QCyhbaO2lY9flUGW4oZALrwUJ+x9DtBZnJ30jrKeIj+6/LF8qIx1092BS2lS6TqIvU535Yrkh3ywS5eMXq+SVEWf7XPIdMLqMPIfPqW+3JxCTqVjjRNq45fpI4OJFQNHIu1bTR9Hh/rGsBRhvt7tyASPeIjL0pEVQoccUBXoOAdsSr//xbVNGrGEYTK2dAm4M3oFnpgL365DFSFh06AwSfP7dOCmvwiyvgHwbpqHfA5NnCpJAw==
X-Forefront-PRVS: 087223B4DA
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAyMDFNQjM1MTQ7MjM6QitYTUxLUjdDNVlieTJ2TjFDbGdYZXgr?=
 =?utf-8?B?alNndEhRQ0p0RUxUdzJEb0hSbXppSU1HMnJraUhLZU1lMzlyeXAxQ0FsVUNY?=
 =?utf-8?B?cm5kU1RMcklYVDJ2em14cFc2VEtiT1o4YUVueElBUk0zS2J6RXZaWmI4M2J6?=
 =?utf-8?B?ZnVhNzBEdmtRNjJDUmFNS0NsT1VKaE9aWmZtRHZPdWVSNzVQM0trWkJTMkox?=
 =?utf-8?B?VlVOb1NWbTFtb3dYakpEWEZCUTNObFhVTXpMNnNsaTg4QkwxWXR4MzlRVFAx?=
 =?utf-8?B?YTI5T293cHNLQzRsSG9MclhqNVYvaEtEa0dOdkozdkdrclNXT1pMTldTdEhk?=
 =?utf-8?B?cG9hQXBHSjNOVjJncGhiQ2hYcnJncUduQWZ2TGtjcXR2SzFNdVFOL3laSWpu?=
 =?utf-8?B?K1RIeE9sQVRDcGp4L3BZMXowZ0t1dkRjLzh4NytUbVo0bE4xTkVyeGk2bTk2?=
 =?utf-8?B?ZXBSNVl1Z2pXb3RzMnNMOUdPRjhOamhiWmdBVEhSMlFxcVBFMmxRRld4Rmsy?=
 =?utf-8?B?QkQxdDJJUnhRUHZETGdUVms0UndWZ1MwYm1oc1NwNUdZeFlJcUp4V2JqVjVm?=
 =?utf-8?B?ck9tT1kvZ3d4dlF4a0F5UWdrcWU0WEFDVjdVdmtUT3hHTmRhbU1ubk03ZTJ2?=
 =?utf-8?B?NWt1MEhBZWhrN1d1L2VNeVMzUjZpNDRHcEhkVHZFUi81MURiUlBjRzJMank5?=
 =?utf-8?B?aGJWQVBoT0ZCc0kyRGxwZFY0SUdobUNWR09uU3RsZUhPelBzUUJ0UUdOVmRp?=
 =?utf-8?B?UFNRdG9vYVdNTDh6TytVN0VxUi96cFg3TWx3bXVWMkx2bTVwaVZrWGN5S0hF?=
 =?utf-8?B?SllDZmRhZ1lKK3BDOFM3ZzdDa21qMVQrU2JXWENlUkdpcWppelhDcy9MRCs3?=
 =?utf-8?B?M0VLcnpkVmJMMjlwUkZ5NEVaVTlHd2pvUDY3REhOdkJCOHR4QlN0TTEwOGZX?=
 =?utf-8?B?UWhYUnJQYjZHMXNVWUVQQ3hiSmg5cVp5QTZSZnc4K0FSdUtvbHFlTURFYUtm?=
 =?utf-8?B?N2s5TmVUbTF0S3Z2TnRpcFJkZmU1Y0x6WWs0ZERXMG9XZ1F0OGt4c2F2ekc1?=
 =?utf-8?B?U3dpVG9nWkRXV3YzTDJIVHBCTkdJdmlSR3VJRGF5L1oxMm1RTmQvZTB1Ukt3?=
 =?utf-8?B?cTM4L3BNR1Y4aU9ZWkpMeHdvTGhiZWFEZEpmL01iNFArRDUvZ01EMEhCWVd6?=
 =?utf-8?B?dkw5OXp0YjlrMFc2NUdWa1RhY0ZQV3R1RS9adDB2WjQrVGlJMFBzV3ZLV2J2?=
 =?utf-8?B?VDlNVHlueTdPM1RaazFITFUxODVZR01mVkxYQ1JxVE9XU3AySlh6L3FFOFdX?=
 =?utf-8?B?eHM5S0FXQ25jQ1Qxb0xDakJkV0diRE5uSWJyWUlEeklEdkFwSDNqeGhkbFph?=
 =?utf-8?B?U2dIeHpDY2NKdjR5RzlTWHZ6cGpxRlR4UVU1c0hzc0Rxa016WFpzRHppeU9Z?=
 =?utf-8?B?SGJXYjhlUHZsYU1kRU1NWXRVUXgvK0E5YTNZd01lNDcwVmhUOGQ4Mm83ZWFV?=
 =?utf-8?B?d2xhSGo4TUlPQ3lERmtrSTVzM3o5RFlJVVJuNnJpemZackZ1UjJBem9JQlVz?=
 =?utf-8?B?TFduWlpGYWZyWTJncXVBU0phNktQR1drZk43dS9jcWozVXJsNkVxbnZHM2NW?=
 =?utf-8?B?YXlRcExTRXh4ZEVHUVFPV2l4cU1ncEV0VjJ5N3RUN3JxWENxY3BMZjJ3SGo2?=
 =?utf-8?B?U2dycnY3T1FpdDZVcCtNc3FXQjkraStDaGlBM3BvYTlwM2hJOGU0RUxyYkpJ?=
 =?utf-8?B?WnBnalNiZWtIK0k5bGE2VWxzZXRuRVdsa1Q0UVRTakUyM0t4M3UzTU9kWkJt?=
 =?utf-8?B?WkhoZ05JNzNUTVVTSmUxYUdDRk0vc2YyVUVBWDNXTzFxRzRteWhNUmN0dGxD?=
 =?utf-8?Q?+xU9eL+iKzPlE=3D?=
X-Microsoft-Antispam-Message-Info: 6c3fInVQsxWgUIY3Ws6d96PIpAMzAajzXoFXypZMYhA8faJCRr2qz/XMpe3IJDGJuN79kBB29aHD/17lkuvKvxD3rLBCC9gKm7Wg7rIGVT1c2mFVvb+VXIZYVszXVHU0rOZH4v3ksQ3Wzf88O02mta6YwXlEAxPsq+29u4IFsStFUgLjfjsXE5X2VDQgojCBAb8Kv7f5U0cGtUNTXBl/nsEj0CJjiqazTfQKkgQ2sjl3WH4XfE3fiCsuvXFdjNoQEgnl5dJyJlsgW0SrxgFOETb7QpJMRjSILtfrJIsmFuP1XzTWI5lxnY+SpSHpennRdyGV8pgVkTexSE0+XrVBrMY0tUcHyvDWrLMcM+R84Jg=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;6:jR55nDbYhWwoCKLBuIvHnxf5PIhtPTs2LeYfNlS2D99Ih7K9v/NWYTb8zkVN02D45n7jBjwC8EtzV9yNghQnYvKUHfpBSeO4g0lgYDE7MWXqnGvovLCVfpFbt5s75sro4KB/UulOruH/19/UZsHMidEJnCy9SP73ThBNKDny9og1NfkF3iNU7IZbY8p+z6QD5Ly98/bk6AEHU+oZU6EDOONK//4rONR1qDUokKc4y3FN2SL17oGw1B7fQ3hEcv7vIW2XEqbCCQHWok2yDo1gG0xbEua+EAgiU5hdLwX5AdKTGfEzPyg/UohgntHYn1jDbtYYc3pgA5vC7P9f9YRmH/+xSd7J2PeldXDmjZenSAIvtjAertun+kXy+O7hUDNRUK9ohuU3bLAZFdMOgZkP4YZoCQoZS5oRgYA7lzZCDmeEHxNXKjU9/GIpdSydlgO6e6DErdtu/KzlRGi2vfRRdw==;5:rp8+f9ccRrSP9OgxvQZf0QJ06dkL4FjFRgELDoRUz2DuhRGri471AVIe4x2HBxvu5ixpbr7GsMVI2s22lZYdwxoIDArS1Yi7CnXOKQrbmHxRChJhlqkuF7ImwSkcOnG/Yd9o6iECEKpstaFgoZ5Wx3pNijR2liwFGc8Nvx2Y8Z8=;7:vh8tYxLGYw4PETNJKyBPLx20bg7zar0Kh5EN6CDF9N05NTNDf5YqDkAZO5lQlO4Ar66Vf+omURy2L4Gdy6km88VLDpazq7VyKZUVfrsIy7tprQ/4dpgc4TRE0s6qNguwApbsJRGHP8MI1Dc/BnpM2Q==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2018 07:19:09.9884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b232f70-01e7-44fa-9dcb-08d656941fa6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 11. 18 17:15, Faiz Abbas wrote:
> The "ti,am654-sdhci-5.1" binding has been moved to a new driver. Indicate
> this by a deprecated message.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index e2effe17f05e..1edbb049cccb 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -16,6 +16,10 @@ Required Properties:
>      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>      - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
> +	Note: This binding has been deprecated and moved to [5].
> +
> +  [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> +
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> 

I would prefer if you can extend commit message by description you have
in cover letter which explains reasons. When this is applied and someone
look at git history none will understand from first read why you have
done that.

Thanks,
Michal
