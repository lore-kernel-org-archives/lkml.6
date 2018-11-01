Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6DFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD242081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="n1iLYirn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD242081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeKBAbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:31:55 -0400
Received: from mail-co1nam03on0052.outbound.protection.outlook.com ([104.47.40.52]:24992
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727966AbeKBAbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHOXm3l2E8bD0F6EAhGWm+/kBPUiLt2LbvfuVpdQxBU=;
 b=n1iLYirn3s8pgP9dtfrNxkcppJohKk2CmfNpwhgH9Qvw8qJCSIq7C+dyWN61d+uVqNkyEmLCjT8j8GN2YW3TwS0HFp4dgjnEQXZMIKqn0E2xdFttV9bW1+YVlXXYioFVEAQM7Qen5Qfb/YbfRvxvaZpE2YcbBbb8/DE2lpNQN7g=
Received: from DM5PR03CA0031.namprd03.prod.outlook.com (2603:10b6:4:3b::20) by
 BN6PR03MB3124.namprd03.prod.outlook.com (2603:10b6:405:3c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Thu, 1 Nov 2018 15:28:22 +0000
Received: from BY2FFO11FD028.protection.gbl (2a01:111:f400:7c0c::165) by
 DM5PR03CA0031.outlook.office365.com (2603:10b6:4:3b::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.21 via Frontend Transport; Thu, 1 Nov 2018 15:28:21 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD028.mail.protection.outlook.com (10.1.15.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Thu, 1 Nov 2018 15:28:21 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id wA1FSKZd008525
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 1 Nov 2018 08:28:20 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0301.000; Thu, 1 Nov 2018 11:28:19 -0400
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
Subject: Re: [PATCH v3 3/3] staging: iio: ad7780: remove unnecessary stashed
 voltage value
Thread-Topic: [PATCH v3 3/3] staging: iio: ad7780: remove unnecessary
 stashed voltage value
Thread-Index: AQHUcfFNJc0AQf6YWEqsBIFWv9Leq6U7TjIA
Date:   Thu, 1 Nov 2018 15:28:19 +0000
Message-ID: <8e33078437ba3153305c5d31aba54412a786a9bb.camel@analog.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
         <d6b6aeda46121f59a53b43599bf0200580d7a79d.1541082656.git.renatogeh@gmail.com>
In-Reply-To: <d6b6aeda46121f59a53b43599bf0200580d7a79d.1541082656.git.renatogeh@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5C6142CF954A34392C15B37AA8B5531@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(118296001)(2486003)(76176011)(5250100002)(7696005)(3846002)(2501003)(6116002)(50466002)(39060400002)(47776003)(106002)(6246003)(2906002)(14454004)(229853002)(4326008)(23676004)(8936002)(486006)(476003)(126002)(102836004)(8676002)(246002)(186003)(86362001)(426003)(7416002)(336012)(7736002)(446003)(436003)(7636002)(11346002)(2616005)(2201001)(54906003)(110136005)(316002)(106466001)(2900100001)(5660300001)(478600001)(36756003)(356004)(26005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3124;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD028;1:ozWX+rt7UCsUhZ5y9IjS/eSt2wwKRwGQH6qn1UTkHu8Wdg2pDrH9M4vqD8zbRaKnq+Nmznpm1FsZ3rAsa6zTZUmyPxlRXF9R6iUBcLQ0Eu4tM+UFhMZLrR+Ci2e7t5UX
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7fd7799-9c2c-4224-381b-08d6400ea85a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB3124;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3124;3:OO4Kh+jLY0YwZubYf69aEBrHrMauhA/vy9VrzaSuLKF3rR+TGzPxFUkSNhdQPpMxWEFWXGntQggNkbaaUuxSEkoOkEJ0wFEHHD44GYW6OTB3CMywNMCu4ecKI7azSk5AoAksI50IiA7fxOTi7YbvGEB5NUiX6YnNvvexOibXRZoCEUKncXodRLFTD9DzXAmxgQNeWBrCWOW6uq7LcnWDppcFexkCLC53PeEu70QwCZjvEGyzpsEDSH28yg8TC0u5V7WWlA8tt+B2tiJmX1Y62SklfTgdGPJ1JGNmbkH61tSdYbulGWjGVHHFdUBUYPbEawVESHodMCUodeZQS7Hb0rnZVFWOjZHYUFpPV0fjW08=;25:RRlqK/7PoBuBjtLmhsNThnzVGtZPx0qJimZn0TWHHHxaASB4+psWD3cfbxuz0Nt4flMOWI5dDSc9pYidXUwx+83B7RUUEasU3FFHle6uHT7eeTbX4o0rl3ExrQf7M1ksbAThfRlmLJ/Ya1rWU/UXGVp5A7YtsSqK7jdXsM5nB4FFIPAk/C5KKAxvbCE6uy0UEecqLQamGwgKhCdHuimiOiOYoior0Nolf8uzFE5rO8OQ45mgvFa2sUf4sP86YlWfCJVpF4aESEhQkfE5AjlJcV1GmEw4O1MA4eqj8XmZ48vbTT2TrRsI9raujQOob9jF1jkoPow3rf3oEu/jxlSpfQ==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3124:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3124;31:KqVs4CJtCSSRoIaO5aRqPt6qvHX6Y7EeYdHUXilydSuAOXiLZxVRZGtTVBB6zUbPMtulr5E51xx7sHzqzXg2Vy8PQ6pdnYZ/osQSSNHCTJN0rle1L2FT3IbLP098cjMvweMn30kwZJwoA7xl1vT5tD0WnMn0DP66kjqoB0zBhVmN1LMkek8mjA+o3aqqYj53if5oLi8kFVZb1wBGaNku294AocWBbUmf09GBPTVzgno=;20:b8gPxJdG2g2W+z6WS7ysbVaVx5tI+iyA1/RtwgLB+Qd7oN0OfvWFZQI6CLKvx9UOK4Onoap8248UOuOERamhfTypFEEAUO/mbSpfZpBHgWHw2BYDbPdlyKsqFDA345kTSgqEzIGHPe7RLY3/aWIZZt5B6SpoQAnACx4G1CSgLA/iePi981UF0jZ3/1CkhFlH/st/9ZRj176CBRyouwihUNsMAY2iQjlEZlbuU06j5P8LwPewMNobBPjyXq1fzLh6835gzmNqnEIycrKl6Njng+Jc7kNmIc7fqWeZAZqGCzrjqPrtAwyuwejQ7v+SiQt9/ugIU2YzZEW/i2pUjgkR83N8cNuPjbhEM4ZU9qkz66ork/HmIa7aLJ0rjMPpbMrvQbr4l40yCkjlCZyhjCh7GQUXaNGVWJsngoxXr3VZqPpxPwQ9nn4PSodt3KPa3uHrGh903atSfIt2r4QWLWIjxOOO4sVXImXO4PGVIeIILBF1kH9ZnpGMfoMxef/I8VfL
X-Microsoft-Antispam-PRVS: <BN6PR03MB31249891903734216F963D90F9CE0@BN6PR03MB3124.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR03MB3124;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3124;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3124;4:HmgiLkmG/4lJuX+4bjGeOarE2MZEzEDNHnTR3KC1OIQmyIP+WS0HguK0LWFq9K3/XuJG4YfKc9cDaoiNyWP5UVt4anwTlUpHidLFmr5TQtzAi3kfXHV2dyZ6Rj6kmNWhH17vHHgnaZjXWKO2GvUjEwyPU6Mk1ip7X217kb5QvNFoleuoTgqAbHOG4bjTSpaiMK5JdDLFQt6pve2Mh2b+6dSwc35nX0TPKdEc5YoBmwBUqE7+ONXU4TCjXRaq0Lh97kSrg0L5cNRGhoqzNgqs5WOFxzzfIRRXUE+IuOAQl6HHwrgpJ95syiWqHA08n84J
X-Forefront-PRVS: 0843C17679
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIzMTI0OzIzOktET0lEbUh2TjRVcjlBM0h1bCtGY3FSWWdS?=
 =?utf-8?B?cVN4UHdlcUpLSXJmU29nUUQwcHVxWUU3cFY5Yk1sUkVQYXBGSDlOVzRHL0o3?=
 =?utf-8?B?a05oTTBEK0VkRU92SXNyWmtwWHNjM1Q5dU1EQjV0Qm9zbmpHMTNNN0FiSTlh?=
 =?utf-8?B?cmRoYWRkVnZvWnB6TDhpdFlCcHh4V1NmMVJaeTZjV2hsaGo3R1lDNWJNZVZD?=
 =?utf-8?B?NjllTFVyQmxubW5wREgvckpXYUgwaWJsek1aeG9zQ1pFQ0Q0dko5TkdVOFVG?=
 =?utf-8?B?YTNBaVZ3NWx6L3E3d3ZlMkp3MUNsUUJmcU1BN3d1cTZ2bDlsUFhyWThFWDJm?=
 =?utf-8?B?NDVQMmh5MHluV0trVWRLZGd4dnoyTGQzejZVc1F6dUREVlRORzNYRlJqY1J1?=
 =?utf-8?B?MDJpQS9LTGpyYXZ2MlhIbnJNekRuOS9IcmtUZ0RSS3dTTEZCZlFTdk1EUldk?=
 =?utf-8?B?RmhxQVJVbUQwQk1ESFI2QUVLWTVITnlQdjN6amVZUzd3a29uVnQwZkpXWG5k?=
 =?utf-8?B?SndVYjhhRWE1aXhSMTJER016L2Y0bEhncjhPZTVsWGNuNXhWUVVMMjNlaWRx?=
 =?utf-8?B?V2t2N1lqamhTWGIvQ2RQbnQ0R21MTmYwTlZ3OExxOVhSeVUwTHNyZlRWRk9X?=
 =?utf-8?B?L3UwRUtrb0c2TnhkUi9zM1BaQUppNjVVamN3TnllZGkxblhIMUFoYVIweFZu?=
 =?utf-8?B?YVdPWU9OTlVJZlZ4MlowcVUvTFV6cXFqM3FaN1R2cy9HMUR2MzQ4dzhtRmpj?=
 =?utf-8?B?OHBHdCtMd2g5Sys5MlRSc3FyTXhrT0V0d2o4KzVrRHFUaUE0dFltdnRSVVB1?=
 =?utf-8?B?SDNRMkE5TjE5WnBoUWY3VmdWVXlUYWpoTzV5UHR6RHl1bDVEVEN3aTdZWkl2?=
 =?utf-8?B?a1NGeHYvbUVYRUVpemN1ckhiUTN3VEZSSjFxeDlmZmMrZ3Ztd0JtNGpGNERX?=
 =?utf-8?B?ZDVLTlFKR3BwYjhxTnZHQm1ka0JUbVkzcnpyUldRMjFqeDFuZ29FK1hCT1JQ?=
 =?utf-8?B?VUgxaklCQ3NQK0h6YnNBTGtZZnVSL1l1aDVpalRGZmNLejRVdTN6cUR6NVc3?=
 =?utf-8?B?V3l3RzQvNGpaRERDTXR4WW91LzN2RVNlUklJaVpSMmNpTlRJSzZ4SXlOZDFJ?=
 =?utf-8?B?clA3S3M2UUhTK1RVOUtUci9oMmp0eDJuWnc5a2d0RThoaUFwdjhoVi9FL3A1?=
 =?utf-8?B?Nm5sOS9zVTlCUEpzNFdsKzZBU0hGcStzaVhHekNhdkdaQUNlbkZFWm1pMHYx?=
 =?utf-8?B?aW9TNXdYUUx6T05XSi9jT0xZaTRaaTRwalE5NHoxY3RXUTlPcndudHVEYTZL?=
 =?utf-8?B?K0hmUnRsdWRvQW91ZlJBUC9rYXZNKzRyVlBwcnIzeWRHcnZ0R1AyQkJ6WHkz?=
 =?utf-8?B?dnFvL2ttUDVtMHl0eENZUHI4dXp2MkR1NWMvRGxJUmpDaURPbEhpdmp1cmRV?=
 =?utf-8?B?VG1Edk9wcWdrZm04TFV2Q0tCYzlTakVabEwvV2VITGpZemJlNHg4UUo1b1Zk?=
 =?utf-8?B?UEpzQlVnWVR1VHZQQnprNGZQQmhscmNuTDh4b2FMbmkzOHJRdERyNlIwYitv?=
 =?utf-8?B?TlNMWGg2ZUttVnhaRVFKRk1JSW9pNlduZ2pscEZNY3ZSV3lSeVU3WkRieWZn?=
 =?utf-8?B?KzZMdUduNGEzQUdsN01MQWtMTnlWc0JnMmN1bXU1dEdzckgzN1crOUVSMWtE?=
 =?utf-8?Q?q191gmxYTorI4tIILw=3D?=
X-Microsoft-Antispam-Message-Info: iKzP0xO5bIwtadAcX9FETo3EGvKBDtzzsbPC8gE0//T2i0Frxucyn11wKUAPxceBv1vSHdRUoT/IxYLg0imtN1wTiGo8MkzOTKl9EWuaZAivq7lszXoqEHS4lFq5NPO4wQaSH9KnlkttfavUcTrCwi6ZPoCL8n1ckWDHDXXl+3ixuWiVfOodkhfTN0cYsfqoGj9lUOUsZrGY4INDb71jivlg+zmiSkWlhD44uKp4jN3KF0Zfqwpn6x4fdYW/7PaDxT3mWpaJzs1mODlKhCaEGSY0Yx1s42hAf8KM0UFgnkX0onGGriDGr+b2ShUDBrUm+D3s10FRaQgKBx1sSA2sGdDD2c/2dI8Qiq0oS879Lcs=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3124;6:nYP+g0skM3qAk1/D1naTOKsGymGDzSHKhzw8OUx3CGUk8rF/NRn0a4BhiA7UCUPS/4+V/EgAbFAs06GsGIGPB5uR2YPUZFBPCgRPT/Zx5lAUJNkxLm8TRP5JZL2b8AQDk/kX2nbAmk212Aq7S+jUGc6CVxwATQoijhB06Jbwqui/4KSiyODMHCXcbGMTnPlSt+zyQR5F/+WGyX6itAHxCOdPoSDz0uzX7c9Gvn0+zjCraJdD7/N0JBvBrYPklw+MxFIfNmj3h01LCE9pwuQzOL3IxycIT8Km64ZjnFEUUUxwVriepyXZji8+tvReFzZQmzYi8DmlSKa+l+JmG9s3xouPiilDvDwhgXfOpn1WdFyn8L4dhCBnLXXVvj3r6/HofkOzFxHQXIfePjdX+gGogyGgZuZZBBPse8uaJM6LdbSuuwCdRNit0cqV5Z29xDYF3CDo795G566flSIcz3Vazg==;5:6MVjwcTVKp3Z7RA2NMFo/z8xGCEom/HGqcm+df4DiiRl7+Y8Bmct1m5+VUrzm018WAK14ntmZwefocLd1/T5MR9syFrYkUouQD/aA4T+Hz3nGhSLc37xpvfG9mZQQio0zIM0A8jiCZpq9kw6Wx1k14J0VLaJASspmf7boUexu94=;7:t6xGJaQU7HwQnfMoZK4JlSVGhuRorjgNdjOvMLOtoGCOHy9h8lF3XlVX1nUWrmm2fQQkSadwLSbtJ06zCNzRew6Y4eAG0QJncqCKdCUS2NIu+VxTv8qAwyuHjF9SpvHspf5oWDY0XiU0k1q27Teoaw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2018 15:28:21.4896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fd7799-9c2c-4224-381b-08d6400ea85a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTExLTAxIGF0IDExOjQzIC0wMzAwLCBSZW5hdG8gTHVpIEdlaCB3cm90ZToN
Cj4gVGhpcyBwYXRjaCByZW1vdmVzIHRoZSB1bm5lY2Vzc2FyeSBmaWVsZCBpbnRfdnJlZl9tdiBp
biBhZDc3ODBfc3RhdGUNCj4gcmVmZXJyaW5nIHRvIHRoZSBkZXZpY2UncyB2b2x0YWdlLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUmVuYXRvIEx1aSBHZWggPHJlbmF0b2dlaEBnbWFpbC5jb20+DQo+
IC0tLQ0KPiBDaGFuZ2VzIGluIHYzOg0KPiAJLSByZW1vdmVkIHVubmVjZXNzYXJ5IGludF92cmVm
X212IGZyb20gYWQ3NzgwX3N0YXRlDQo+IA0KPiAgZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3
NzgwLmMgfCA1ICstLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3
NzgwLmMNCj4gYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBpbmRleCBmMmEx
MWU5NDI0Y2QuLmYyNTAzNzBlZmNmNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL2lp
by9hZGMvYWQ3NzgwLmMNCj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMN
Cj4gQEAgLTQyLDcgKzQyLDYgQEAgc3RydWN0IGFkNzc4MF9zdGF0ZSB7DQo+ICAJc3RydWN0IHJl
Z3VsYXRvcgkJKnJlZzsNCj4gIAlzdHJ1Y3QgZ3Bpb19kZXNjCQkqcG93ZXJkb3duX2dwaW87DQo+
ICAJdW5zaWduZWQgaW50CWdhaW47DQo+IC0JdTE2CQkJCWludF92cmVmX212Ow0KPiAgDQo+ICAJ
c3RydWN0IGFkX3NpZ21hX2RlbHRhIHNkOw0KPiAgfTsNCj4gQEAgLTE5MCw5ICsxODksNyBAQCBz
dGF0aWMgaW50IGFkNzc4MF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAgCXN0LT5j
aGlwX2luZm8gPQ0KPiAgCQkmYWQ3NzgwX2NoaXBfaW5mb190Ymxbc3BpX2dldF9kZXZpY2VfaWQo
c3BpKS0+ZHJpdmVyX2RhdGFdOw0KPiAgDQo+IC0JaWYgKHZvbHRhZ2VfdXYpDQo+IC0JCXN0LT5p
bnRfdnJlZl9tdiA9IHZvbHRhZ2VfdXYgLyAxMDAwOw0KPiAtCWVsc2UNCj4gKwlpZiAoIXZvbHRh
Z2VfdXYpDQo+ICAJCWRldl93YXJuKCZzcGktPmRldiwgIlJlZmVyZW5jZSB2b2x0YWdlIHVuc3Bl
Y2lmaWVkXG4iKTsNCg0KSSB0aGluayB5b3UgY291bGQgcmVtb3ZlIHRoaXMgYWx0b2dldGhlciwg
YW5kIGFsc28gcmVtb3ZlIHRoZSBlbnRpcmUNCmB2b2x0YWdlX3V2ID0gcmVndWxhdG9yX2dldF92
b2x0YWdlKHN0LT5yZWcpO2AgYXNzaWdubWVudC4NCg0KSXQgZG9lc24ndCBtYWtlIG11Y2ggc2Vu
c2UgdG8gcmVhZCB0aGUgdm9sdGFnZSBoZXJlLCBzaW5jZSBpdCB3b24ndCBiZSB1c2VkDQppbiB0
aGUgcHJvYmUgcGFydCBhbnltb3JlLg0KDQo+ICANCj4gIAlzcGlfc2V0X2RydmRhdGEoc3BpLCBp
bmRpb19kZXYpOw0K
