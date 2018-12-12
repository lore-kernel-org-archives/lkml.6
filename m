Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EF4C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D412086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="G/lUEa/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D412086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbeLLNuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:50:21 -0500
Received: from mail-eopbgr720045.outbound.protection.outlook.com ([40.107.72.45]:11269
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727604AbeLLNuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTgmWmdGKPIXbkl3FWZoINS0/n0hshGOjuNzckb5K+0=;
 b=G/lUEa/DPATXWYZiF1LYuCySZITG2PwLn4e4GfdVhyxITpDIKt/f5yWjSNWCVCw9yCYd2l1dBrxroARSVnumnF/JeL7zYWD7eXgZJhKIU74yBuYy008SrkuPSJu7cx0O3X2fY2pakA29Jx4+cokQC0sS8R43a9fx57IW4SJwVLw=
Received: from CY4PR02CA0044.namprd02.prod.outlook.com (2603:10b6:903:117::30)
 by MWHPR0201MB3514.namprd02.prod.outlook.com (2603:10b6:301:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.18; Wed, 12 Dec
 2018 13:50:17 +0000
Received: from CY1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CY4PR02CA0044.outlook.office365.com
 (2603:10b6:903:117::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1425.18 via Frontend
 Transport; Wed, 12 Dec 2018 13:50:17 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; socionext.com; dkim=none (message not signed)
 header.d=none;socionext.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT047.mail.protection.outlook.com (10.152.74.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1425.16
 via Frontend Transport; Wed, 12 Dec 2018 13:50:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:39825 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gX4tz-0008OT-Tr; Wed, 12 Dec 2018 05:50:15 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gX4tu-000196-QY; Wed, 12 Dec 2018 05:50:10 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBCDo33j012443;
        Wed, 12 Dec 2018 05:50:03 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gX4tn-0000p9-9O; Wed, 12 Dec 2018 05:50:03 -0800
Subject: Re: [PATCH 0/7] microblaze: fix various problems in building boot
 images
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Michal Simek <monstr@monstr.eu>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <19c7bdab-8df8-f7c6-7921-9a4d43dbca64@monstr.eu>
 <CAK7LNATWSNqZ8uE+teMW+uvDCLXfq6zMTqh_7=ssrPquCLJz8A@mail.gmail.com>
 <938f1368-5e07-0178-5b99-d8331ce216f8@xilinx.com>
 <18fb7c8b-2b47-eb39-d80b-7137e7db466b@xilinx.com>
 <CAK7LNAT-RuvvwGy5Tf01_rWk4EtD0H+y4UPF=aa7B3YB8v692g@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <44c60aca-c9de-8459-aefa-5d95111f8e8e@xilinx.com>
Date:   Wed, 12 Dec 2018 14:50:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAT-RuvvwGy5Tf01_rWk4EtD0H+y4UPF=aa7B3YB8v692g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(136003)(39850400004)(346002)(396003)(2980300002)(199004)(189003)(65956001)(65806001)(2486003)(53546011)(47776003)(76176011)(23676004)(305945005)(26005)(186003)(77096007)(106466001)(5660300001)(65826007)(336012)(316002)(356004)(106002)(63266004)(110136005)(31686004)(58126008)(36386004)(478600001)(54906003)(8936002)(426003)(44832011)(2616005)(486006)(476003)(36756003)(8676002)(11346002)(81166006)(81156014)(446003)(9786002)(126002)(229853002)(6246003)(4326008)(50466002)(14444005)(31696002)(64126003)(93886005)(230700001)(2906002)(107986001)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3514;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT047;1:wm6kWGLcyt8XJZvOI8x5SRi8KWlw18Pg0jcxmBlEaBc3zJgY38vidVWUBDmgJIRpaMmntXBUh3qgkJ52/z/V2Vdoqv0obCbzKaBFGhQQZcTX+w/477HdRdKhs5SxgET6
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29a71bb7-dfc6-4fad-cf45-08d66038bf95
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;3:lolRKhBHc1HKATGBVi2tFiRSnC0WKS9ZYKV0ozWMzH0ii6lmhrP7CqW5l5CN3nKQ3uemNkooLejeEP2Ef+TvK1VMHvdl3f9ksC0NcJhYChQYGrA2Ab6r6ejry65705o8+i0+VrkBHoVS/TJss5KQli5jIO22XZPYAjaFoHNnsAFmlWL/8QxEnuz4GK/FL3dd7sj+vstDyVcVyD9oMYiZUa6Y68r/ixN8my3dbJxaWImhMmThQRJfdMGf2KTX4/m3XF6OcsmGOF5t0CoqDg/seuqi6wSfzwTVp+3xfKnjYCje+vlkWX98hVrozb31Hdb7JnvSW58dOsJmebhDTMEaucVos6mPY78okIDGjQNfFDo=;25:pOAqw3CAeL3Tgr2WxhfeA18Yt/lhRR0XsIKepW9webH+3u8PoE29hXGG9esVYjGNfHFU89MJdSMww1cA71Q/hGSoqOp8XSwuyCGuqZcDEQP79R0meGprIXG27/hDNZmH2IrIdGsOYgBCapuCx30tao8ZSEz1K0B6c6Pm5t5wm6y24d+EIvHrhDu64VVz+URHUzbKbIl5k/++cVEhRwsUoMPD6DbPsJEp+b8lkbIZTNvZlHQ7bunjt5Faegq2Ibi6uw39K6qNya3F2QeY6omK88+/mAv7ceM5tNxFXXEs2Zh/lgZIGo2RhdqwJOpWcBzpioS98zh1PUCioyhQulMRqw==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3514:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;31:n5a03YGecmkBJCMW9EoDHw3t6uXYSOQqTg6h4oYP7yAjYBIJ4wP4jjSRqVodOGuDZrwQ3nkdcZjQUTWr9XvLUykfJKtjqKDdru+NvyolXYm40sWHbaIX7+LhQf+fCHvcEmFAQ+4o/aPY6805tEygglWSTfPN3+iMBVET4/8T8tAuvUQ5O6gryErbI+aHL8Mgw7aGkJodA8ExDGq4WNbvxKLnZQsQsGkKwo+jO0FCJ5g=;20:4HJhNQT7GEv1eVL+YWmXoRd0CxDafLm8e5dgyZgee85O2SaJzvEx/YX1MBzhPMqKQGA3CcSh3TLW8MpeIcE7PbCnQgkC/sw2IC/ISrihXqv1QjWAzQYcW4ytGzwSvpB6rw9EBdY/uAeoXfRo3MHVc2hOv17BemYFNT1LGWTXckJmu2ZVxK9xiqXLIfpKoU0r9gF+2SCbG/YXKPcuh0wSEDjBoPD6LnFvmfeY2xSUAupwpUHHpoSVHfZZn++PoqhlVQKuCBpojQ8EwVGXa/moPKuNuQD8njpgvrHSHCMaxE8yMiX8IqGNto1vyHvTN1Gx3TpaOYiJnzqvaTMBWpQ02o7mW83qh5CPiRaKvn++Cvj0W39X25TGX3KVxLivhYigFmG06f11LVD31IvnYpsIpaYmPQ3RyIE2EgAjmZZpyIOHimjaspKJ+TRX9lB2S+6mz8MXSD2pJPufi+LaZYTVeyJJ9sBhDuLYyX8s+6UeVniOnk4XSc+EOSXw5SEKO2w3
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35146E3BDC6BCC808FD692E0C6A70@MWHPR0201MB3514.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0201MB3514;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;4:LddVo+5DbXrBkZJa2fZYmED4mK3xINaKkP8L+OoHbHgC2wb7QezAC9JtNEQNiHmnrMwq1+Px3+FwXsOKhf2tfBk2zYBc5q/n5NviB5eSS+eN8bUb5h6taW/NjuhgOBeFDXazNNEfYJv39nUEOEn7YnQFlUXG/uozungwIEujpTxSvcZlsLo66Nfgtp85wBrRLoqCyEAVvajSHXLOiHpwfqWvIIasZ4C7/9z2FEdxuKEMUj4Q8bQlkwvf5ISAQopVAiqbUXNGBpF5I2344Bi2Wg==
X-Forefront-PRVS: 0884AAA693
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAyMDFNQjM1MTQ7MjM6bDIvd1M3QWJKY0txWTNWT3hxaldFRE9v?=
 =?utf-8?B?UmdVblFLdEg0SE12RFl5S2VMNUhlNlQ0c3hZc1R2RUlGRHF4YWdHZDltU2w3?=
 =?utf-8?B?SmRzVGZsUW80UERZb09YWCsrUGlTbVN6SWJrU2NtOExTTGVWVGhLMFVOY09F?=
 =?utf-8?B?emFRa2lNeGdYdnlwTGtrMnowNU1YNzN2Zlo5eDlLaGw3UGxpUEZQS2p3NEc3?=
 =?utf-8?B?QmdxQVA0TW83NURabE5xTURTWmY4RkFmMHIxSXNWYkZ3dE9kbVR1clNscUo2?=
 =?utf-8?B?aDhOOGNuWTNKU2liMXdVamN6akpnVk5aV0pLallRWXNueGsybys3MGU2dWlr?=
 =?utf-8?B?VEdINmNiRHZDTVdadmlVY1NDNHlBcmJiaXI3RGdWUDlIWWxVbnlhMjlQVkJN?=
 =?utf-8?B?Q29acXZFK25SM2ZxT3VYbHlXMDFNYkNOWlBPU3RhcTJzeW5NaVFHYkVubFI1?=
 =?utf-8?B?NGlnemZZaXdLc1F1TkNkeExObEwyM0ZqYXRsSEJZRG11Z2lrWGY2UWpCWFlq?=
 =?utf-8?B?YkhuNDR4L1V4RGt1ekNEU0tlS3hqZzB1NVdtdytoQk1XNGNXVTZGUmVVVkE1?=
 =?utf-8?B?akkvR2RyZXN1YmE0eTdBbWt2ckE0TXZNem53MS9vOVI2RUU2WmZyL3h5VXpU?=
 =?utf-8?B?SldHeFY2cVNOY215MzhzUmdUVFljaEk1cUpwRjEySXRQeVlEWG9LQmJQKzR5?=
 =?utf-8?B?c3JuSEQ4VnlRNnJudXQva2JWblVBR2Zpa096cDZxZ0ZyRlJlWnBWWTFoZjB2?=
 =?utf-8?B?Qm14eVo0Tm1VUVRNM0Q1MnFvekx6SjB5UVJmSmJjMzk4T2JRQXZRdTVOWFFH?=
 =?utf-8?B?SFNkeEY4RHNzT1k4aEh1dmdueitTdzlsZDZ6TjNxcCtkaVNDdi8vYUNMV3Jr?=
 =?utf-8?B?QWhDVXZMVFgwb0ZTU2Z4dlZQOGNlM2ZVZFhWcFFrZVRGcGtVKzNaYVdMeXF1?=
 =?utf-8?B?Q0syNHhBcThBVHlmckFLeDFjMlR4SjlMNGY1T1phMWhLUmE0ZHFaLzRIMTh2?=
 =?utf-8?B?ZUgxS2JkK01OK3FKZE0zay9LaE5VdnZUajNnbWcvUmh3akVIbTNQZ21GNjBi?=
 =?utf-8?B?c1JRYlFlanorL2dWNTN6RGJlUUdTdFUva2NUcmVSM2xOZENjSFQzczZRblo4?=
 =?utf-8?B?MzZtMUpMeTFkZlRXRkFPQWtRRkRtU2ZIWWVDTUFmRG1VUHc0Mk1lZ2xxTnBz?=
 =?utf-8?B?Y0xNZDJQRUFKZU1ZM3p6bHQ3dms4Wk8yNnpnSGllWlhCN1lLQ2drL3JXQXVh?=
 =?utf-8?B?NnBXNHJnYnZUanhiSnI1UWNmYzFOS0hCNlNDb0VYMldJVitBQzRVT3l6NE5x?=
 =?utf-8?B?cVd3bm9QMEQ5Mk12b0xndUR6eldIVFR6ZWUxK0ZrTTNkTUFsRnk4S24va29Z?=
 =?utf-8?B?NFkzTGR2dEM0eGhjaUxBN0tLTXhkeEVnSEFQZmYrcnJIcEx1dEcrNFYzcTcx?=
 =?utf-8?B?MUpYRlg3dkF2dVh0VzhxL1BOVUsxVGpjWFIyeTF1TzAwdjdYKzJqcWxUdGVC?=
 =?utf-8?B?VVNqMWJ5aWsyQU94cHlwUXcyYStEUlA5Q1FHbGZqNHNHL0Y1REhVTHF6OENV?=
 =?utf-8?B?eXZJQ21YKzc1MjRiNFNjQVlaV0FGamtBNkFSdm9xaHNRcjVBL3NDb3c2Zkgx?=
 =?utf-8?B?TTJmQTRJK0N0UDYyeFFqZVlFS2UwbElodU9zN0swOWFmWGM4d3pBVXFoaVZz?=
 =?utf-8?B?bTlzZnhsbVNkekVHZEVkZG1YY3RxNjYzNU5Qdk00QjI3WXAxM2NQZVA0cE1l?=
 =?utf-8?B?U2xXbFJqU1ZoeWc0WkxWWWlIZWFrclJIUXN4dmE4Y2tXd0RlelMxYXBxVSs1?=
 =?utf-8?B?NEJwT09uTWkxc0hQcmlvRFRiUElZQXU5L1VKbjBqUHBaWjVFWFpZejlXZGI1?=
 =?utf-8?B?WGdmMnNzQjB2bUhDL0kyNWExeHdZSlBvUVQrVU9KNGFob2hjTU1rZjd5M1Jt?=
 =?utf-8?B?SnN6OGdTeG9mK0E9PQ==?=
X-Microsoft-Antispam-Message-Info: pV3xfxs2Q5wszSbrLJapHC/Lw/DOt2WVaZnTmZJ6HZbMdMaG6Etsl2cPZdJgb6VGdtintthFUSwECUMO4onsJKLBRR2iKAJJjQA5TM21PNC/ryuZA/hhYslBiqwgg0TsbANUn+/LwGLI08AW0h5NyuFCjT9xsn37tgm7dFW++j0iOlqujBYD9uZzQMKTJuX6IYh+42d/obxJJUm0vbBfxcDox4DhrTXRlYnDTw8bOTajM16I4j/MZkmlLTqE4222QrVXrq0z+tMbeqAdKIhSM7rZ7V3X3iPKJzYFnOpLk1Z6fl2Srhlbc9TNDmt4nSw8
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;6:k8NIxWAbKt0DdXCdPTJKSCrDYnrWu7mbIIgHTbIWY26gP4NfiW/0CGLNuY/qjKBTt2kSOJvNOrkS72XpyTHSGgXSuH74qN002jfVBqHHlfJ0Z9da+q9pJxbxiXRZ8M7FEyQaFPzxqi3iiSbYGGp/BTQeCuqkKYKB7I1oGgEvOVsZAnBPXmPaqv1reESAnXX+XqOdwO5L7bVk1MHSe3UnOibxnebhvM74FeOffmfraAD1LIijRyCAmCgHI3V38YqRCpUspY76moFgIzZ5+Bu9Tfk3Ipw4QvNXH0SKkXSi9dVwZfYwqE8hs5gPVziNsFhSycIuVhGI9VeDnLQuz/kaGYZAtgFyvqoYv0K/RJlx+LyIefGOaE+AB35QavhdPjukMY6blV61i8z+FzccfO5kig6Wd3EPpzGn6YamMFaLE77EwtOACxZNUmOKvbva1iKxaqOmExDnK6LDc9RrKicYQw==;5:tSkGdRVIySlANXnug87GUrcawaTNObOzwr03PKKmsNNvBEx8YVMzXUGjL1oujTaDVWveJhArGchcQGEwl3eGVqMfIFG10KbtXrQW5FYU/Y2ainvsxM5QxnoOCxm+l4mQlVjg4e9+fg44IDO0TPGAiwHs7elCJNY5fvd5y9FdFaU=;7:V9cXyeXuOBlhDbGqehYJK3hXy9Vh1vSgHa7WWjuE+cW+JNkidGYrQrh24JWnWHtXiCL5Yq8+rqVkvmYEplGBI93RZogCS4UctncUc+9eEd3/UgP3AwvirhVM1oeK/qB+WMkXPsV1dO154Ded/GxOcA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2018 13:50:16.3361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a71bb7-dfc6-4fad-cf45-08d66038bf95
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 12. 18 7:14, Masahiro Yamada wrote:
> On Sat, Dec 8, 2018 at 12:20 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> On 07. 12. 18 14:29, Michal Simek wrote:
>>> On 07. 12. 18 12:29, Masahiro Yamada wrote:
>>>> On Thu, Dec 6, 2018 at 11:55 PM Michal Simek <monstr@monstr.eu> wrote:
>>>>>
>>>>> On 03. 12. 18 8:50, Masahiro Yamada wrote:
>>>>>> This patch set fixes various issues in microblaze Makefiles.
>>>>>>
>>>>>> BTW, "simpleImage.<dt>" works like a phony target to generate the
>>>>>> following four images, where the first three are just aliases.
>>>>>>
>>>>>>  - arch/microblaze/boot/simpleImage.<dt>:
>>>>>>          identical to arch/microblaze/boot/linux.bin
>>>>>>
>>>>>>  - arch/microblaze/boot/simpleImage.<dt>.unstrip:
>>>>>>          identical to vmlinux
>>>>>>
>>>>>>  - arch/microblaze/boot/simpleImage.<dt>.ub:
>>>>>>          identical to arch/microblaze/boot/linux.bin.ub
>>>>>>
>>>>>>  - arch/microblaze/boot/simpleImage.<dt>.strip:
>>>>>>          stripped vmlinux
>>>>>>
>>>>>> I am not sure how much useful those copies are,
>>>>>> but, I tried my best to keep the same behavior.
>>>>>>
>>>>>> IMHO, I guess DTB=<dt> would be more sensible,
>>>>>> but it is up to Michal.
>>>>>>
>>>>>>
>>>>>>
>>>>>> Masahiro Yamada (7):
>>>>>>   microblaze: fix cleaning of boot images
>>>>>>   microblaze: adjust the help to the real behavior
>>>>>>   microblaze: move "... is ready" message to arch/microblaze/Makefile
>>>>>>   microblaze: fix multiple bugs in arch/microblaze/boot/Makefile
>>>>>>   microblaze: add linux.bin* and simpleImage.* to PHONY
>>>>>>   microblaze: fix race condition in building boot images
>>>>>>   microblaze: remove the unneeded code just in case file copy fails
>>>>>>
>>>>>>  arch/microblaze/Makefile          | 14 +++++++++-----
>>>>>>  arch/microblaze/boot/Makefile     | 33 +++++++++++++++++----------------
>>>>>>  arch/microblaze/boot/dts/Makefile |  5 +----
>>>>>>  3 files changed, 27 insertions(+), 25 deletions(-)
>>>>>>
>>>>>
>>>>> One more thing I have in my mind for a while is that will be good to
>>>>> configure kernel build flags from DT and completely get rid of these
>>>>> symbols.
>>>>>
>>>>> XILINX_MICROBLAZE0_USE_MSR_INSTR
>>>>> XILINX_MICROBLAZE0_USE_PCMP_INSTR
>>>>> XILINX_MICROBLAZE0_USE_BARREL
>>>>> XILINX_MICROBLAZE0_USE_DIV
>>>>> XILINX_MICROBLAZE0_USE_HW_MUL
>>>>> XILINX_MICROBLAZE0_USE_FPU
>>>>>
>>>>> It means setup CPUFLAGS based on extracting that values from DT that it
>>>>> all the time match the hardware.
>>>>> It will also simplify all the CPUFLAGS logic which is in
>>>>> arch/microblaze/Makefile.
>>>>>
>>>>> Do you have any idea how this can be done?
>>>>
>>>>
>>>> I have no idea.
>>>>
>>>> Parsing DTS with sed or something would be possible, but ugly.
>>>>
>>>> In my opinion, the kernel should be multi platform image,
>>>> in other words, it is the least common denominator
>>>> of supported platforms.
>>>>
>>>> So, the kernel should enable all features that may or may not be used
>>>> depending on platform.
>>>>
>>>> I do not know if this works for MB.
>>>
>>> Microblaze is soft core CPU where you can select if you want to have it
>>> with multiplier, divider, barrel shifter, etc.
>>> You can of course say that you don't have them and you have "universal"
>>> kernel but very slow.
>>> That's why user has to setup these configs which are converted to cflags
>>> to say GCC what can be used.
>>> And these configs can be simply parsed from dt.
>>>
>>> For example like this based on dtb (quick hack)
>>>
>>> for i in `echo use-msr-instr use-pcmp-instr use-barrel use-div
>>> use-hw-mul use-fpu`; do
>>>       UPPER=`echo $i | tr '-' '_' | tr '[a-z]' '[A-Z}'`
>>>       echo $i $UPPER;
>>>
>>>       VAR=`fdtget -t i $FILE/arch/microblaze/boot/dts/system.dtb /cpus/cpu@0/
>>> xlnx,$i`
>>>       FLAGS+="CONFIG_XILINX_MICROBLAZE0_${UPPER}=${VAR} "
>>> done
>>>
>>> make $FLAGS
>>>
>>>
>>> When simpleImage is requested dt could be parsed to setup proper build
>>> flags.
>>
>> One more thing I found is that I have done these changes
>>
>> diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
>> index bbd6968ce55b..dc6a6fee3ae2 100644
>> --- a/arch/microblaze/kernel/setup.c
>> +++ b/arch/microblaze/kernel/setup.c
>> @@ -153,11 +153,13 @@ void __init machine_early_init(const char
>> *cmdline, unsigned int ram,
>>  #endif
>>
>>  #if CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR
>> +#error MSR is enabled
>>         if (msr) {
>>                 pr_info("!!!Your kernel has setup MSR instruction but ");
>>                 pr_cont("CPU don't have it %x\n", msr);
>>         }
>>  #else
>> +#error MSR is not enabled
>>         if (!msr) {
>>                 pr_info("!!!Your kernel not setup MSR instruction but ");
>>                 pr_cont("CPU have it %x\n", msr);
>>
>> and run MSR with 1
>> make defconfig && make CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=1
>> arch/microblaze/kernel/setup.o
>> it errors #error MSR is enabled
>> and all is good.
>>
>> And when I run MSR with 0
>> make defconfig && make CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=0
>> arch/microblaze/kernel/setup.o
>> also getting #error MSR is enabled
>> which is wrong.
>>
>> Is there any rule what can be setup at compilation time?
> 
> You are trying to do very specific things,
> I do not have a clean solution.
> 
> I do not mind whatever you do in arch-Makefile.

ok.

> 
> If you look at stack_protector_prepare in arch/powerpc/Makefile,
> it is parsing a file with awk to setup compiler flags.

Ok. Will do more experiments with it.

Can you please at least confirm me that config options passed via
command line as above should be used instead of that one in .config?
(Just want to understand why USE_MSR is so special that it is not
working properly).

Thanks,
Michal
