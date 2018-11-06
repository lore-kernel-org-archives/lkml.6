Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6260DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F802085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="umyux8h9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F802085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbeKFStM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:49:12 -0500
Received: from mail-by2nam03on0051.outbound.protection.outlook.com ([104.47.42.51]:16635
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729160AbeKFStM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mvzyfESff1ANvqzsOIl56ixKj1uBuD9AWSCIg1aGFk=;
 b=umyux8h9gLphqCJvrlgz0JXX39KhktIwXnBs9BWK1z8NEqjEe4fq1Hy0t3NU6pVVDFVwdxCiBjhAs3FBM+oiKXFscVHe2cjcKx4Hr9YHzIk+PHaZvHkbAqablcrDUUZGfXmnbqT528o/gpYX4leUumYsqrHOBlzow0KSZWzHRsk=
Received: from DM6PR03CA0032.namprd03.prod.outlook.com (2603:10b6:5:40::45) by
 BN7PR03MB3508.namprd03.prod.outlook.com (2603:10b6:406:c2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.33; Tue, 6 Nov 2018 09:24:45 +0000
Received: from BL2FFO11FD017.protection.gbl (2a01:111:f400:7c09::178) by
 DM6PR03CA0032.outlook.office365.com (2603:10b6:5:40::45) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.26 via Frontend Transport; Tue, 6 Nov 2018 09:24:45 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2FFO11FD017.mail.protection.outlook.com (10.173.161.35) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Tue, 6 Nov 2018 09:24:45 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wA69OisU017164
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 6 Nov 2018 01:24:44 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0301.000; Tue, 6 Nov 2018 04:24:44 -0500
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v4 1/2] staging: iio: ad7780: update voltage on read
Thread-Topic: [PATCH v4 1/2] staging: iio: ad7780: update voltage on read
Thread-Index: AQHUdTvejJfp1mcJpU+n2xq+NR6i/KVCznIA
Date:   Tue, 6 Nov 2018 09:24:44 +0000
Message-ID: <30c1ff317baefde88a0f4d0a002b19010290d16b.camel@analog.com>
References: <cover.1541444377.git.renatogeh@gmail.com>
         <4b47bd8f4bac2575b72529b37e5ac90bebae2446.1541444377.git.renatogeh@gmail.com>
In-Reply-To: <4b47bd8f4bac2575b72529b37e5ac90bebae2446.1541444377.git.renatogeh@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3C5E660D417774D88B0BED6486A9253@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(438002)(189003)(199004)(39060400002)(229853002)(8676002)(2906002)(8936002)(47776003)(50466002)(246002)(316002)(106002)(106466001)(110136005)(118296001)(54906003)(14454004)(4326008)(7696005)(5660300001)(6116002)(3846002)(2501003)(2900100001)(2486003)(23676004)(478600001)(26005)(356004)(76176011)(36756003)(102836004)(86362001)(486006)(7736002)(7636002)(11346002)(446003)(7416002)(126002)(476003)(2616005)(15650500001)(186003)(14444005)(436003)(6246003)(305945005)(336012)(2201001)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3508;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD017;1:W9aDrSLrSW3yV8tda1SPCG5E5As5yoxtiEGOOdXPQ/ba3EaW4yS8NoZPDMMcsY0RcMKfRaT9IDb+g11THERXNoyKGmY0RgOSiD2/TOtwHlazL1bAdGWJhEFqrIzbSzUc
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f4fb867-734a-4fa9-80c0-08d643c9b0e4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR03MB3508;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3508;3:IdLckIQIZWEk2I/9aaIkIBxIFjo+tM5gZdYl3JzyJyQ4sLiX4eBRytTCZ0K370bCV7VIZNpcNxEAQzvi9KwIxWPlVyadfCSz0mcudk3M6hc74Y4qlpLMQPck9LC6eA1F0sDw96mMmLPmPQc4PXR71UvCze5BILyOLH2PbdqGR67nMMDY1FHHn/54+jXXNJi0LouVUdE38Czbw/9W1QsKHxdXPrFvBL/MiWUZ9JQiRpau+924LVS1w9SprCd3zVDT22MZn1Ms+TXK3TvG5AOXdAzs66AuZODwZdu4Jk4+mSi83id9ckPw06vTIoAI5DuXeoVysrRZisKCprWqZKPshA==;25:gjv9YjShxPVElqLm6+0INez3JQU4zc4zAd3oorN04g3uf43vQFwSadXrOhFUnBRTUn2X6oHYb/UlOM7KkbqDBkkzHGfHvOQaU9ZIH7UxWh1fPJOBpQwV1mqrxvVOYsDxGyMyniybEm66LPskK6E8lQDwz8o/A4/rLtR9LDl5UXK7x4yirxSpF3IzrwaaUwqBnVcmmDe8rmerBYhuB3d6vHPLCHq4kVZiqmXcNPyGNp8Z+9blO+ga8CXIuA764Lv2ZUbGagkyPWZTukwTFXGPLlVhxM6WVhk5dzMprY83eu378+GpRsoFU4oXEhp+3juRlywvvNSoqGkNLtjvg6oM4A==;31:iaAqL5WXacqGUFrbp23n9MSycgWUXg/n9JkAmFjFPxLCFYBecUvnxWuAMG+owmNLMlrbnoS7v5lsnc8eLqHdk1Og5RFzo5nrViOsz1yNSPOs/XzaNoYeUC3dHmKUj7r2BGdZoa238zWd84zjWdLiS/IMcF4NOzKooDkevD8MiemGN63fQfv9rk06PuX4kEye4hC4kH3Y0otYqh0jtOG1+qF1a5/vKmgFUKUaHKannnI=
X-MS-TrafficTypeDiagnostic: BN7PR03MB3508:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3508;20:UYF3zJImXHSSuAcNwtVg9u8xuW3Nq6Am4NQzkWXwv6qTb+yBoPfWAU6cU18F9UxrwiUI3yzoK7HYP+5Ldv54Oq3jXSkYmX8drbF7tEzPR21LEtV4MjOEKgssLoy/c4Cl+U8czCQFV4lx2Igami9uwOofBRbp/Lu3MHgdw20Sk6lMmE5iByVskGEh7qb07SYx3M4j2cQRajf3rHZYXc0g/Nhd2gMbx/815v1fK7JP5WjylhMpaC9g0fIrp/khTfegniJF1bhlK0oRibwrov6ueetoOufVB5sV8SANPZ81VxNcUwJuPX41/6B1M4ttDu5Ti6fkBUn/EAjV1AqtvtetozHb6s5kiuWlyftnnfqBuqGi8FvOtdR2XKxU+RwIxJpGaVLHKSr0MqgG8NfZcCtVCi51bcjdRB0S+9gztpGa/J72QWJQ4u+aONBjhoMWOytYMkaOPINve7/tdi8fiGoDjpU+RIgJYHgRixz2qOg59XR3tkAx+CEHlYc3CIBtag6L;4:lY9QezxW6Rshne5eVEoZsuqxK8RAf6IQqpNWJanT8HygFkGwpseEWgzgIo2vFA0ZwY3Z3do8thu4YCa7pM3wwqUUZ6fO48WMCV9dfu9pwKPptaqSzzcjQBuseOc5+tO+WySP4/Q+S4Vy5J6Kybn/X0xyvG4KzjLGaq/F5fEepO0xJ9l9u+OBK4sNlIdRfjBcsHcegzEGbQaU0zs2DNLgb4bBMgQUqLtX+Qo21tHPQqNmJlWDiwfGg3wjvbc5F7zFy0COgZfcADC/IVJlTR6EM8jyeamRcNvJs1Oj7/HmiP7SJpHETaifbG7SWpAv/GUM
X-Microsoft-Antispam-PRVS: <BN7PR03MB350843729A63C627EFC94A5BF9CB0@BN7PR03MB3508.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN7PR03MB3508;BCL:0;PCL:0;RULEID:;SRVR:BN7PR03MB3508;
X-Forefront-PRVS: 0848C1A6AA
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjAzTUIzNTA4OzIzOngvQkJONFlVanNMRW44SHh6bjRPR2o0T0Jt?=
 =?utf-8?B?b2FjS3hGeVk3bFJwMnRRZVBTUVpoTDVGOE1weVNXWXNQSWlMZ1IxK0VqZ3M3?=
 =?utf-8?B?cDdFRHJKZ2ptRUtnc05aSTJ6Q1VhcVBMejF2MUJjOHFJcFlRZit2WnpGbDd4?=
 =?utf-8?B?L2F0eFJpUHArN2Z1c1h0UlVJYkJyL1JZMEtIMzNnbDJhdDV5ZElSRDhxaWNL?=
 =?utf-8?B?dlNNV1g4K3dlTGJSZklWRWJ2Z2FIekJRUENnTnBGdytGWGJxbFN4SGpnVDJy?=
 =?utf-8?B?UFJ3UzB1ZVpJd0lwWUtpSTc1TmUybkZpK3pBMng0VXd3K24rZEVyWFlmQ2dn?=
 =?utf-8?B?Y0tRK3cweXphQnhHOFdld3gvYUMxSnFuejdOVE5DbW9xV2NibXpranZWTC91?=
 =?utf-8?B?VERLdHlYMGE4eUt3bUZTMFJHbmN2ZnphdGdJeXdCaE1ZWDJ1YldzYjAzZitR?=
 =?utf-8?B?TEQ0S28rbWdlYTE1dk1RTmdpZEVvUjNkSWdsR3hmUExZYkxBbFdhdElzblB4?=
 =?utf-8?B?ak84TnJKT25ONTErb0F1VHQ5RUlHbUhFRjJWSXU0WnNHV0wyeXovbzlEZFlH?=
 =?utf-8?B?a0tSelZIUENqYks0V28rejdqRm5NT1daTE8xTTZPeXNvTGxJUktTcVZUcHhO?=
 =?utf-8?B?MllmcXZpS1RKNWMvVUtMZnZnMXVVTnkySWlsOVJ1TDNsNkVqS01NdStGMGZ0?=
 =?utf-8?B?V2NlNGQ5S1hHM1B2eFhlYm1ubTU1QWcrRnExdm1abmo2Y1JabjA4a3F4MWph?=
 =?utf-8?B?YjZzRldDRlQ5b3ZZbW1mS0xtZzNjU1g3Y0JVU05RY2J1STZMd3NuLzlqdHVk?=
 =?utf-8?B?VzFjM3MyczJZcHFIb3QvVW9iK2l5YTg3S2ttT2RYYnN2bk5iMExzTk5VNXBv?=
 =?utf-8?B?czNFQTk5RHMvVndBMDUyWlZ2dmpQZU9VQi9iRjJISC9kOHZZVS9FQ3lhQnZL?=
 =?utf-8?B?d245RlN5UHVVYll3cGE1QnUzUjNaT1YxallSdkhWUDBOM0RrejZjSFc5RkpL?=
 =?utf-8?B?RmRlVkpEcC8vcDBNaTlZOFJ0S1U4bk5qaWNVL1h6WmJCZEdBMHVyTys2YThs?=
 =?utf-8?B?bGdGTDJLbmI1ZEptNGw4bTVVdUdOdWtvdEFtNXhrMkhwSmQ1WEgxVHFjWHA0?=
 =?utf-8?B?TFFsTEFMWHozbXYzK2NCc3IwejBzemd3bWJjZXJKS0t0ZFhZVkliYVdRSnZT?=
 =?utf-8?B?c0VzbVRkQ3QxeVpxeXh3ZUw2S0tOVmIxVFJGSzg5cGxHTVNrcGJjWHNFOCtn?=
 =?utf-8?B?WklrbENMTE5VTmlBNlRsbkFNWDFTQ2Izb1BIZGFtaHhwNHUzY0daaXNIZHBq?=
 =?utf-8?B?MUpBVlZXS28vN1ZlVlhkSDBNVTZpTi9CN3Z6UkVHYXNRNnhCNnBBT2xmZndI?=
 =?utf-8?B?ZnZoTHY2cXk4RURSQ1hTemROb2dmNks3aXg5VEgvOExYS2VCVVNXMjhkVEJn?=
 =?utf-8?B?YzVXNEZmUTFnYkhSR1BXcmxDTVpWUFJaNkNBSldaNUV2VDlvMXQvZjBTNjNE?=
 =?utf-8?B?SlQ0TThmaXBFaDR3SC8wSVl4c3JwU3RVZ2czTkdsRzR0aGVKYmVTQlJsT1A4?=
 =?utf-8?B?SjMwS21YTHVod291RTRBR2dtQVdzTnVJZklmME5GdEZMSm9YZDVLNFh0RWFI?=
 =?utf-8?B?N2tUdkhRWXJKN2pHajJvM0tPVGtJNzNvWVg5TlIxeVcwWXhKbjZyMkNNREZW?=
 =?utf-8?Q?r0XU1btg37z+ScGyR0=3D?=
X-Microsoft-Antispam-Message-Info: dJZlJb+vBg1CdaJYMJjqg4xost0oLTaDENVLs+GYLcPpa7sZZ7UnDaHzZu0tCFBTfWE2yXV6lu1oHmi1kFX4BXSWZCIi2jBpYXDA0AcEnsmncezI/C/esfhHjVsQZ32jFj8uc1yXPG4vnXqJIBnR1ibUoc/+zHjnHjqQLYNSqwhijLi5IcH9I07iqA/VTR8bXGw8ioYx4CIEJWxeVkFJHnxXtGB9Jd8iUZDhoU/03A9R6Uk25sqLWR4a27Ub+sxHxPIgtclEkblJ58aQUycLiGljDTGG0e4fls4LKMyUXaRi2GkvuHcgvGi2CUnSbYRb0xaYgW/k/NMLNwO4MYsb6MCy2hr/I7eBc8JravfV2yM=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3508;6:dEbRCANz28O5zgL41AqT7+zgUqkZhYvovvkdWk0y6GGavfIM8jnsuho6go+Y5toWr+OfhIEyYEt+eSpSftYmeXPqG4d2CN1T9HTw9Km3HnSTNJE3EyDhvhLQ1ZsB3cJ9WhcIroD4v2KnaMBAgI8GyTNaJ/QDH2gAUr0NTWPTiiybwxzspLDgy+SVqUyfjHZ0/nJk1YJj9LJavnzLSOZHWViue+kRC95SnEamB1WlEy01U8Uww3q0F33+Hu7TGpnJvWKavYSr39Th72zybkINco5QzDNNs9nFVwmRmtsoKng+B+PpKguKig5KCJslwBkARsHQl1TXl9LxexYKrvTmxA7JdANR/QNp41UUu6IuTXxi7tr0V4KBNGO6v7wGyXC45XZxoKtGKM2w7o8je2Y9VxbqqyRvSe5G3zQSv5g97roq6f6nOUmXpdhhfOkr7NeEREwTW7xlVPLC7qv+IqOd+g==;5:yGsOXuoqSVyQadsJ6uIz2gkTYmyu++eugzf8brjrRkV8LcDymODdhhk8R1oURmJc+ZvO6kDnvOashTDEoWnoq6C+ikL3qsgo8k21VdswO4ryxAWMsm1RPi397ffLn/14mnBXtlxLFaYvlvVw397H0N2LUpfuGqzkpv5Z2tCWQjg=;7:U0yFQRoV2wXo47MKLFUnRkWIOhzif9As5kJGhl8n6whRYy98QICXWYjUJIP47c9sjBMmjh8bKWWg71bGsuorO0efm2PzUoQb8a06conQnI+bcvhlpsRQQ/PSYAt2jXprxph6FrwXV5+BW+0TOrQ+uQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2018 09:24:45.3662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4fb867-734a-4fa9-80c0-08d643c9b0e4
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTA1IGF0IDE3OjE0IC0wMjAwLCBSZW5hdG8gTHVpIEdlaCB3cm90ZToN
Cj4gVGhlIGFkNzc4MCBkcml2ZXIgcHJldmlvdXNseSBkaWQgbm90IHJlYWQgdGhlIGNvcnJlY3Qg
ZGV2aWNlIG91dHB1dCwgYXMNCj4gaXQgcmVhZCBhbiBvdXRkYXRlZCB2YWx1ZSBzZXQgYXQgaW5p
dGlhbGl6YXRpb24uIEl0IG5vdyB1cGRhdGVzIGl0cw0KPiB2b2x0YWdlIG9uIHJlYWQuDQo+IA0K
DQpMb29rcyBnb29kIGZyb20gbXkgc2lkZS4NCg0KQWxleA0KDQo+IFNpZ25lZC1vZmYtYnk6IFJl
bmF0byBMdWkgR2VoIDxyZW5hdG9nZWhAZ21haWwuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2
MzoNCj4gCS0gcmVtb3ZlZCBpbml0aWFsaXphdGlvbiAoaW50IHZvbHRhZ2VfdXYgPSAwKQ0KPiAJ
LSByZXR1cm5zIGVycm9yIHdoZW4gdm9sdGFnZV91diBpcyBudWxsDQo+IENoYW5nZXMgaW4gdjQ6
DQo+IAktIHJldHVybnMgZXJyb3Igd2hlbiB2b2x0YWdlX3V2IGlzIG5lZ2F0aXZlDQo+IA0KPiAg
ZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMgfCA2ICsrKysrLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+IGIvZHJpdmVycy9zdGFnaW5nL2lp
by9hZGMvYWQ3NzgwLmMNCj4gaW5kZXggYjY3NDEyZGIwMzE4Li5jN2NiMDVjZWRiYmMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+ICsrKyBiL2RyaXZl
cnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+IEBAIC04NywxMiArODcsMTYgQEAgc3RhdGlj
IGludCBhZDc3ODBfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiwNCj4gIAkJCSAg
IGxvbmcgbSkNCj4gIHsNCj4gIAlzdHJ1Y3QgYWQ3NzgwX3N0YXRlICpzdCA9IGlpb19wcml2KGlu
ZGlvX2Rldik7DQo+ICsJaW50IHZvbHRhZ2VfdXY7DQo+ICANCj4gIAlzd2l0Y2ggKG0pIHsNCj4g
IAljYXNlIElJT19DSEFOX0lORk9fUkFXOg0KPiAgCQlyZXR1cm4gYWRfc2lnbWFfZGVsdGFfc2lu
Z2xlX2NvbnZlcnNpb24oaW5kaW9fZGV2LCBjaGFuLA0KPiB2YWwpOw0KPiAgCWNhc2UgSUlPX0NI
QU5fSU5GT19TQ0FMRToNCj4gLQkJKnZhbCA9IHN0LT5pbnRfdnJlZl9tdiAqIHN0LT5nYWluOw0K
PiArCQl2b2x0YWdlX3V2ID0gcmVndWxhdG9yX2dldF92b2x0YWdlKHN0LT5yZWcpOw0KPiArCQlp
ZiAodm9sdGFnZV91diA8IDApDQo+ICsJCQlyZXR1cm4gdm9sdGFnZV91djsNCj4gKwkJKnZhbCA9
ICh2b2x0YWdlX3V2IC8gMTAwMCkgKiBzdC0+Z2FpbjsNCj4gIAkJKnZhbDIgPSBjaGFuLT5zY2Fu
X3R5cGUucmVhbGJpdHMgLSAxOw0KPiAgCQlyZXR1cm4gSUlPX1ZBTF9GUkFDVElPTkFMX0xPRzI7
DQo+ICAJY2FzZSBJSU9fQ0hBTl9JTkZPX09GRlNFVDoNCg==
