Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A5DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641DA20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="ihMRjJnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641DA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbeKFSt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:49:57 -0500
Received: from mail-eopbgr710071.outbound.protection.outlook.com ([40.107.71.71]:63168
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729160AbeKFSt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUhdCphhFJpRIv28dj/m++Jcjr+NQrU0rc8NH9zrudA=;
 b=ihMRjJnRIzlI8Qm3k1j3TZ10hVfRcqPoMRgxBuLew+LacWsqIn0nFHPPHYaKqD34Y3BpFKpBMHgdxKFXg3VuJUE9DzcfFeszBrL/jNnYyeaplvzvvPweJjznPrgdIXhEj0q7CbXNhO79lLSNznDlodHhdxNwof6I7WHF2pkBQHk=
Received: from CY4PR03CA0102.namprd03.prod.outlook.com (2603:10b6:910:4d::43)
 by BN7PR03MB3716.namprd03.prod.outlook.com (2603:10b6:406:cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.20; Tue, 6 Nov
 2018 09:25:30 +0000
Received: from BY2FFO11FD029.protection.gbl (2a01:111:f400:7c0c::181) by
 CY4PR03CA0102.outlook.office365.com (2603:10b6:910:4d::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.21 via Frontend Transport; Tue, 6 Nov 2018 09:25:30 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD029.mail.protection.outlook.com (10.1.14.212) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Tue, 6 Nov 2018 09:25:29 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id wA69PSHS011464
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 6 Nov 2018 01:25:29 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0210.002; Tue, 6 Nov 2018 04:25:28 -0500
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
Subject: Re: [PATCH v4 2/2] staging: iio: ad7780: remove unnecessary stashed
 voltage value
Thread-Topic: [PATCH v4 2/2] staging: iio: ad7780: remove unnecessary
 stashed voltage value
Thread-Index: AQHUdTwL/HVi8LfBMESDJb0QbsgXPKVCzqYA
Date:   Tue, 6 Nov 2018 09:25:27 +0000
Message-ID: <f36da3b8962d463a68e53e29563b3c9bff2e0ddf.camel@analog.com>
References: <cover.1541444377.git.renatogeh@gmail.com>
         <3920d49d888f63b600a4d2f2600921ed2900a470.1541444377.git.renatogeh@gmail.com>
In-Reply-To: <3920d49d888f63b600a4d2f2600921ed2900a470.1541444377.git.renatogeh@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <897C1D1884CA794F847E9B141CEC9251@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(4326008)(126002)(8676002)(2201001)(8936002)(6246003)(246002)(486006)(229853002)(50466002)(11346002)(476003)(2616005)(2906002)(426003)(186003)(446003)(336012)(36756003)(86362001)(436003)(3846002)(5660300001)(6116002)(54906003)(356004)(106466001)(110136005)(7736002)(478600001)(23676004)(2486003)(26005)(118296001)(316002)(106002)(305945005)(7416002)(14454004)(2900100001)(7636002)(47776003)(102836004)(2501003)(39060400002)(7696005)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3716;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD029;1:agCDRtBTnb0YLS+ftUis9VmPBS4VRqlvUB91qS3jjqi12tYdNEoYqH09q4pTM5hS9haFZVDyrF2wO4+j/75NCekyoGEXtIviFJy1WjOHsWdHypm3W1nVWufEbl9NhXsn
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cc4fad5-f2a2-46b4-9527-08d643c9cb84
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:BN7PR03MB3716;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3716;3:IGdStOtqhVDvzwxmPgsW6Glm6tpolwlgzFL3eqgx3AM8nSKnn31ZqoANyila4zb1KR53w2E3itRyIS33P9PULxgDRyL2GSAF6ASLDhL3J2CHTFxAD9iG78yY46x4d6jbo8Z6xxVLu0r7rKgLxwqQzchawneiH+Zr6rLXMCXM9X2CWnYAzWqdf3O9hwx0MGJaw3fv6VIEASJaPKqJ3cewp55J6355ikHUS2GGOSMIsKUIFmYBvW+cLUpEoymbc8yn7MRMoUNCH6dxVdHP2xKkWSXEEm1FoWvPQq61xGHaaGMFYbyeKBbSvIS9vRjm1DQw2jWbKC/Nf1YNY9osYwGbRQ==;25:WWAkajc8holLPKKBIsJoDuJHvF7DhLTv7xOIJ/xDUjbC4oYHWoqidmGsppOsezqkOygnmes7QWuZvGUeYa1WDBpHPQ6jNUFevXklLJGGxn2oHINOIA16FFFBSr9eHmuo83XGw2J7GMhkKyG130IPvQfF5Wc9AQQjtFvsO7AMToucN0IRARbvxYtveo3LEsw/tNZKzq6yY4s+T7iC4lE0sDVEzRB7zSMuY9yxRMP5GJp89WNkFStE4uvHZ5pWFKOhxDyjb3YwT8x6JXh+jmeJzsWCxDG61VkqLchN4SU06HGO44oD+V/1SkR1Wut5CqnqKJSzAbjFlxVM6pd6FiwzlA==;31:Chs3theOODeey1MG9rqBwFRk3MdMNf1hnfwMEmzDX33H+RCo3TSZmejCa7keHcJe+40Rp2OqBj6aOszRj444fvEgVr5bpSP80HHFlXILUKKJG1zf1Ih99/0cqdl5BW3zZWlQhEJOtL3E+rTPvzDMnHIrWkcLYnA8yH6DrBSQ08Ufz7+7UFEcY85/GDiYAI8PgisMbEz0/ocXBiQags0qNFsge/wQzb7PF6Pac5xXVDs=
X-MS-TrafficTypeDiagnostic: BN7PR03MB3716:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3716;20:GggMRiHkJBV5Oy4xNbG9888nzZoQaToBOxT0a+22QZe3RmcfmSiexm6xZMU2U10T+59YnCf+gbYAKyPv+pTaMR7X7zXVI20XfO89IOO9SrFBJRkkG4RRVy8mnMhwTb1nYuBikLCD24o8+y2HN2og9PAsLPL7fUXEyYMeJwuaUGShoefEf7o1pNnrMDe3f0zpL34QFkpIPA54kC4tH+4OmhD4qLcNN8JtuA5wMevD8FCdd8HHz6L7wS5tseBwE2SpoPL+LexzsbSiTAkPWuNuyA/AtzENQLLTaEjMVuT1oGNTwYPYeQ5h49i0EL52V/YzSAhVwWWCuFGsbINWVyxrRuX5sSFMUGbS5t+MP/Fh9D80XytYUNd6yyb+NeoSOP07zrvXglEHC6uGu5XowN3Z4tyE5nS8HdHzdxNMIKMB3xssM+My8HjhuCNNhfVwlrRn5Dj5JgU7oYQ6shQa2+fhT8BZ+g+8za4S0R5whxvfWhqnsMbdnYP36GSWgI85Bi5I;4:qXySMjKTHj6w3llSyW2z1km60AHXM0rRPXIBd3vKStF77oMo4TmOSTSV+IKB3QlmyBiZW0woGtBPKH8k7wEBDbHevgWXwInAwsq9iRptmXNMBJ1GLE/pUnxD3PUaWWBvd+MRnpipx+1LgHMF+i+dyPD88TI7jsR+deY44np9b6HIYZXFiEXAp1+lIKFnz9mJVgrUwCosXjKN1eD1j6/XMkslN/Kq8ZJ3NN9W1/06ECJAc9ZDxoP1nL9sUPZx3usRfkef3pBmWmgzV4ITZlmRun6EsOCNUwAJ8VP4ocQsK82qTICgWDnjUDiAJrNEBb/2
X-Microsoft-Antispam-PRVS: <BN7PR03MB37160181964425E81B9D3236F9CB0@BN7PR03MB3716.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN7PR03MB3716;BCL:0;PCL:0;RULEID:;SRVR:BN7PR03MB3716;
X-Forefront-PRVS: 0848C1A6AA
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjAzTUIzNzE2OzIzOmFxNEpadTlEZ0txQzFKYW55R3JXYzFTMlZs?=
 =?utf-8?B?NDVqbTZEaUhkZVNrcUJnY09RUVA2OWJsbm10d1JQWFlLdEk1QlBLRmxyY3cx?=
 =?utf-8?B?NTZ6dkRrVWZ1WSt2aVJJVU45TmcyRG9tWXZuVTR4RGcwcmVVSG04YWEycEVo?=
 =?utf-8?B?ZTRYb1Q3bGxjWjF0dlpKbWpTNnlteDdMV0FOQmhMYldDaGwwYjNMNkh4WkJa?=
 =?utf-8?B?SVlDeE1XSWVob1R6KzdCVkp4TEkvREtZRXNTaXQ2STBMWVQ3QzViRTYwam1l?=
 =?utf-8?B?UUJPcjd5S2E0cm5EYUhUUXF4b0J6N2E3NVpmTVMvdTdscnhkMFg4bmVtYkNW?=
 =?utf-8?B?OW9va1Q3ZmJDSmRxc0h1U3hxWTlzTW8wQ243ZUFrZVo4eE5QaGM4K1hnQkJi?=
 =?utf-8?B?UW5QZDVjYjExYm1vMDk4UjdOaFlEYzVpanJ5UmxOY3pQSlI2MTRMQUx5MEor?=
 =?utf-8?B?Qk52dUpSdXg4clczb1R0eWZ1Wm1iOFc0aTJ5REYyeHZMUnBLUkpqV2xXVW9u?=
 =?utf-8?B?QU1WK0tlSjJCZUhkaHd5SHZsREdBUjdKM05PYjFVVGNYUDJPZHRNUVFwMW44?=
 =?utf-8?B?MjdBOTBHNzE4SmxTVXg4TEdkVC9NR0lmTGlCWXRydFZkMVBybVRxN0pmMHJp?=
 =?utf-8?B?NTAzVGRoRjN1NmQ5ZyszZ3M1ME1DWDJMWjZIdmpjTnloNjkxc255WCtaS09l?=
 =?utf-8?B?ZUtWUHVaQ05hUHVjOWNHWHE2bXY2ZS9qSGFZNFZtMUlDRlJXaXlKOS9sMUZF?=
 =?utf-8?B?aVhsL05KZGZudVNLRSt0bG0vbks5M2pXQnN2TzVGMFowNTY5QW1hYzF2R2VP?=
 =?utf-8?B?ek5Ic1JuWGVIQVBWTnBpSjg2OWMvUVZZcHRCbXJQVGtqbU91T3NnbkZBSS9G?=
 =?utf-8?B?clU2ODNTa2pINUQwUE8xSzdQUUM1dW9McTNGdldkeWN5T1VETkMxMnBQVHRG?=
 =?utf-8?B?RndLd0FsQUlDdGxId3Z0dHprcDY3Q3pvOFdSNE1BdEd5RHhTdExxRURJWjQw?=
 =?utf-8?B?cmJWZzQ5aUN5Z3YxUHFybzB1NGlwdE1iZm1XNDNrSndvQ01Hdks4SjlteHJN?=
 =?utf-8?B?dXVCUzExTisrUE5nbWhBOStsd2NvbDBiaDIxc1pJNDVyUlBpMFhEMlVBaEda?=
 =?utf-8?B?VjEvZm1yVjBkdkFlRENHSE1FTXhsYXg4VnhuSXpIZFdsNFZNRmxKeld5ek1p?=
 =?utf-8?B?OU9weHJzRld3bU0vMTZLdldTR2toR3VTQkNSZWtnSzhnMW5nSzJSRXpYRGk5?=
 =?utf-8?B?b0xyU0RlUXZVSnpLaE9TT1V4R2FCTjBBZytIMTZJdy9XM05pQkpuWUpaUU9D?=
 =?utf-8?B?WUkxa0JzYk8zRFlxWWtiTldVZldqWnF1QTBxRDM4SFRRY0V2WVRwa2RXbU95?=
 =?utf-8?B?UWFQRU13dVlDS1RJd0s5aWZSOHJBdXpZSmFtNW12bWs3RmpBRmJVckxOTEEv?=
 =?utf-8?B?bjBpZ3l4SXYzdkZ6N1AxaEtpYWM3Z1FVaEUyREppRlpqNUFVQmpPZlA2VTZD?=
 =?utf-8?B?UFpIdHpYRHdTaVpHTzVHamlHZU9obDJyUHRkaTZRMzVIbVhqOTFtUG5ic0dR?=
 =?utf-8?B?YkxaNUExU3JNTFpkd3BhbGJTWU5mUzdyRVNSWTdjcTZQSlBPN29qSXFZRkUy?=
 =?utf-8?Q?XvP+7ySwrIGQgazY/39y?=
X-Microsoft-Antispam-Message-Info: 1ucR0I50jRGa/3WRSGeSB+XIszSb/zYGnhrCo32fH8WbenhVHCaofK3tNHMc7acJO3wd6CIlETV1wKBONzcUix1/IAI4T8v8yQTXM6qHpwAr7D1P15h3C8XwHEA/zqyTSRzfiZfyTLHRS18SFxcWYzXmUxOWE856/xTkrlSJ/K8I9DyhznhZZhvCT3BL0ikcUjqSgYg7sgmILhjQ+VK056NTkgWRWE0gI6DRaoddOmIWPIiCc3eUoZis44Lw4m3WGi1dONl757P6Qd7nJQl86Xtvz3hEX22MEMK/gYjswwmJm+C/IpAEJqE6UtVyrtr4L7wPjDiPysRZHLh0I3C/bVJOdCyovbXPNf7KtZQ7Fi8=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3716;6:WHskvvWbYjhGKq+xKS/NKStO0mETSqb/rIQ+ouWxCfM3cDNqGfP1GHYClIaqh/7weMv9buQba26zu1tsAFsVzS3RTcLErL6P28KK0lOK/obPeF75n2gOjqUo6uI5X4gRijHbOopQUVEMqo9N/g4/jfHZ1Ik9XRWWvHBIyjR43ynCXD+XXm9DW/ru6/dkIN7kStgvbAX3UQY6hl1G6b0psHoVQ/f1KBQCzWMkD02LOdAXb9/37LwNrMkOAS0RbL4wRdCw6UO9n069eFXld3OeaTwjoJBLbg2j3MCYtKxZByUav6Q7wwp5y0E8F/VQyH5xLhcdJ6h6lIZdNBjUseUUdYQc2KjDxDa3tPh+tSxaL1HEPABxtytPvr9nzzhTQvuY7MGpBYZ0qbHUNtYDqwVV9aDbfc4lFBZhmYsmutP4pS+2woXHCnuzNPp+G4c5FnbNcU+HRM176AU8oE4rdz2bvg==;5:o16HeX+IW0k/m6La7cCQm0+/zJGVsava5tTvKSZHqSbW6VlhRr8Rp5fDJzxFjT4YSC7Ueoxs+EBrg66d023T+w++oojlQpdgIquoyapZwxvRZGWuj2d7UZ1Loc6yfBC04lAZBTwRuzfFrYowzkeUP0d/MZNeGCHcZW7KnQJPn0o=;7:GOrFsnLd4sN9odKNfQdygi+3cJlhrCpxaO2SQQ/uHpuARoHXOsY3fj7jdqjmuk2qTFJAWhm68iUe5ICuppj4tqBuG+O4PpFxaEIoEcAvq/vDrwqc2o2RBmUUBnqROVLtVAfI0+gPkhg/mhHv0z5uvw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2018 09:25:29.8486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc4fad5-f2a2-46b4-9527-08d643c9cb84
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTA1IGF0IDE3OjE2IC0wMjAwLCBSZW5hdG8gTHVpIEdlaCB3cm90ZToN
Cj4gVGhpcyBwYXRjaCByZW1vdmVzIHRoZSB1bm5lY2Vzc2FyeSBmaWVsZCBpbnRfdnJlZl9tdiBp
biBhZDc3ODBfc3RhdGUNCj4gcmVmZXJyaW5nIHRvIHRoZSBkZXZpY2UncyB2b2x0YWdlLg0KPiAN
Cg0KTG9va3MgZ29vZCBmcm9tIG15IHNpZGUuDQoNCkFsZXgNCg0KPiBTaWduZWQtb2ZmLWJ5OiBS
ZW5hdG8gTHVpIEdlaCA8cmVuYXRvZ2VoQGdtYWlsLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4g
djM6DQo+IAktIHJlbW92ZWQgdW5uZWNlc3NhcnkgaW50X3ZyZWZfbXYgZnJvbSBhZDc3ODBfc3Rh
dGUNCj4gQ2hhbmdlcyBpbiB2NDoNCj4gCS0gcmVtb3ZlZCB2b2x0YWdlIHJlYWRpbmcgb24gcHJv
YmUNCj4gDQo+ICBkcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYyB8IDkgKy0tLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDggZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gYi9kcml2
ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBpbmRleCBjN2NiMDVjZWRiYmMuLjUyYTkx
NDM2MDU3NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMN
Cj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gQEAgLTQyLDcgKzQy
LDYgQEAgc3RydWN0IGFkNzc4MF9zdGF0ZSB7DQo+ICAJc3RydWN0IHJlZ3VsYXRvcgkJKnJlZzsN
Cj4gIAlzdHJ1Y3QgZ3Bpb19kZXNjCQkqcG93ZXJkb3duX2dwaW87DQo+ICAJdW5zaWduZWQgaW50
CWdhaW47DQo+IC0JdTE2CQkJCWludF92cmVmX212Ow0KPiAgDQo+ICAJc3RydWN0IGFkX3NpZ21h
X2RlbHRhIHNkOw0KPiAgfTsNCj4gQEAgLTE2NSw3ICsxNjQsNyBAQCBzdGF0aWMgaW50IGFkNzc4
MF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAgew0KPiAgCXN0cnVjdCBhZDc3ODBf
c3RhdGUgKnN0Ow0KPiAgCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXY7DQo+IC0JaW50IHJldCwg
dm9sdGFnZV91diA9IDA7DQo+ICsJaW50IHJldDsNCj4gIA0KPiAgCWluZGlvX2RldiA9IGRldm1f
aWlvX2RldmljZV9hbGxvYygmc3BpLT5kZXYsIHNpemVvZigqc3QpKTsNCj4gIAlpZiAoIWluZGlv
X2RldikNCj4gQEAgLTE4NSwxNiArMTg0LDEwIEBAIHN0YXRpYyBpbnQgYWQ3NzgwX3Byb2JlKHN0
cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ICAJCWRldl9lcnIoJnNwaS0+ZGV2LCAiRmFpbGVkIHRv
IGVuYWJsZSBzcGVjaWZpZWQgQVZkZA0KPiBzdXBwbHlcbiIpOw0KPiAgCQlyZXR1cm4gcmV0Ow0K
PiAgCX0NCj4gLQl2b2x0YWdlX3V2ID0gcmVndWxhdG9yX2dldF92b2x0YWdlKHN0LT5yZWcpOw0K
PiAgDQo+ICAJc3QtPmNoaXBfaW5mbyA9DQo+ICAJCSZhZDc3ODBfY2hpcF9pbmZvX3RibFtzcGlf
Z2V0X2RldmljZV9pZChzcGkpLT5kcml2ZXJfZGF0YV07DQo+ICANCj4gLQlpZiAodm9sdGFnZV91
dikNCj4gLQkJc3QtPmludF92cmVmX212ID0gdm9sdGFnZV91diAvIDEwMDA7DQo+IC0JZWxzZQ0K
PiAtCQlkZXZfd2Fybigmc3BpLT5kZXYsICJSZWZlcmVuY2Ugdm9sdGFnZSB1bnNwZWNpZmllZFxu
Iik7DQo+IC0NCj4gIAlzcGlfc2V0X2RydmRhdGEoc3BpLCBpbmRpb19kZXYpOw0KPiAgDQo+ICAJ
aW5kaW9fZGV2LT5kZXYucGFyZW50ID0gJnNwaS0+ZGV2Ow0K
