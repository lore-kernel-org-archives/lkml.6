Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09726C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A453D208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="jJBoOei+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A453D208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeHHMqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:46:09 -0400
Received: from mail-ve1eur01on0091.outbound.protection.outlook.com ([104.47.1.91]:54752
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbeHHMqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGJAhgf/vViYGtGYTUj3vdgVFihjZtA8nfS9XO+GpT8=;
 b=jJBoOei+yjF1da5eujkUZAFG1xt3sfyZsyfoHtEM1b+FHK36siveg5aOJndF0ZLEbqUt5LdfFtoIPHs/d3C17v/cQIohC2rPjn+8uGCRpn7XTiJ3gNrzT5kngiBjYkCNZYeFDL8mZIFLBOGDzczQdevpEyN1d3iZY2QtKQYuoak=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2459.eurprd02.prod.outlook.com (2603:10a6:3:82::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 10:26:58 +0000
Subject: Re: [PATCH v4 4/4] i2c: Add multi-instantiate pseudo driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
References: <20180808083006.31919-1-hdegoede@redhat.com>
 <20180808083006.31919-5-hdegoede@redhat.com>
 <CAHp75Vchow81kAaJ-b5Fr2ZjG7huasvM7HOfaKQzso7jaG2xXg@mail.gmail.com>
 <69e355c2-89ea-16bc-3d52-4ef9d0eb953b@axentia.se>
 <CAHp75VdyEannOhudrqMvFqEMR3hZkJ+RG_cGojkte2EfXVmZ8w@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9f24c437-b7ca-0844-82b2-4899bd9c21be@axentia.se>
Date:   Wed, 8 Aug 2018 12:26:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VdyEannOhudrqMvFqEMR3hZkJ+RG_cGojkte2EfXVmZ8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::32)
 To HE1PR0201MB2459.eurprd02.prod.outlook.com (2603:10a6:3:82::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53f13830-8b6f-498b-390d-08d5fd197943
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;3:pETM6QvduiQgGO0/vUxbGimGYZzKGPdO/vQr4OAn159el0Q7pjoSSUWl8l/V0QUscJUFE/XoRPEf/utxWQOIK2UvNSPZI0oI8hmIuTYfogdfNaMaaqfEQOU+adqNspAEjiPSXxuiDYmY4ra72OTZvEhkHNrObL1En+WajwrqJgOjnfdqjWaZ92emFoWkxVWRzbUbWoo2TcPugU0djyG9iCtnmQVBNPhrOx7k6rDnfRKHEHEPW0hSiyRj0fHZF/8+;25:lgLNAGcj5SOD2ttRzKD5SyKa9X69M+xo9tXsDVDMbXCCUnzjKIWynj2kxXmOkmHOpEp4kHcpShY0eXVoIJbo2fGGDOUw1NVMSMYbwLn9iGOQdyi2F1rgu1uKfC3/E7T26Dd5BIVEuPZStvNVwSqPeIuAkac7wqDkGvUzzJueJIkrVRnjfiT5DhnNw6IRsfNaDO9VZUoy3sjEKfiIm6mUwzI2FETj+3ZbrbbUcdvXflBgsPpDEzFkYlWWde6GoVzmtBlrPvIvUA0wVXBGVnGhk2BEQnY0ZGDi/bSp3Q7FpMf9nTqAQJb3SRiX3zHs/3tz0Ic7zNcpsbw8GAM6rjEdZw==;31:XMmztpoDg9tr9DlGpAOaXPQmyKzfNNcyGDJH5cLU2yDG4hHlupKFbNC3h20J6hxeELPGPgynMYZ1jaYBqESleP4WTQj+HqbkzHmpjBq3BHpYK6QSH8Xi0mabz77MPmSV0HMy1EWmDGlaA6NcBxxazTbi2o6nZUude6majd9MksKo60127TGE8zqjd+CYBDwwtVWcMklPKLhgI3RMipjO3TR/42JCWxWbYijyTw9MYSM=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2459:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB24599D7D7A51ADE85AE57C9BBC260@HE1PR0201MB2459.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0201MB2459;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;4:D+HdB0+MVOIYEh86nC4CoAqkAK9sNmk0aXDjjXddfd3G+W06eo2Kxq2XGmdXO+/66V4+snArpWec8oYoVt8AFSugMZsmWAKPOch7Dos3M1fMr0AQzxek1AhpMNNntSfMjXsHMf9FQVHy2gjIiG4BH16GtP+gSCzd+qSF80P+8KXjHeEJLRsE1yPzrlyXwJfKgHQWJVlvfB2JZGYpjfsdJyWlBLNzDvgz9+PaEOlxSSnhveFu4BXNm5uSFso65AWjcmLjt90JEXikcuTOU0hE6Q==
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(136003)(366004)(39830400003)(376002)(346002)(189003)(199004)(2906002)(478600001)(229853002)(52146003)(4326008)(52116002)(74482002)(77096007)(3260700006)(6486002)(86362001)(2486003)(23676004)(117156002)(47776003)(316002)(3846002)(25786009)(16576012)(58126008)(230700001)(186003)(54906003)(26005)(76176011)(16526019)(66066001)(65806001)(39060400002)(6246003)(65956001)(36916002)(31696002)(6116002)(53546011)(6916009)(68736007)(50466002)(2616005)(81166006)(7736002)(305945005)(7416002)(36756003)(31686004)(8936002)(8676002)(5660300001)(486006)(476003)(65826007)(53936002)(14444005)(105586002)(106356001)(64126003)(386003)(93886005)(6666003)(446003)(97736004)(11346002)(956004)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2459;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTk7MjM6MGJZQlBwOXo0QnkyRU9zUVNjTDFBRkk0?=
 =?utf-8?B?ZE1PMHcvQTlLUGtpNy93TzFGMDloeGpuUHk2azdjcXdQbkdSdlhodmNFNmht?=
 =?utf-8?B?QWVlMk5ETTlubU5VaDRXSTlxdXg1cng4VG1ZOTFZV25TTUlKY0EyMXFIamND?=
 =?utf-8?B?Zk5jMWxWMi8xYW9OWHYyK0FDekxwVlR0TDN6VEpzSTkzUHlRQmpTWi95dzV3?=
 =?utf-8?B?Y1NHSElGVmRjUzRqVnE1dWNqRzZUN2lFLzcvRnVmaFA5U3RJeDV0TEJSN1hv?=
 =?utf-8?B?eDlMUENXZVBrNHBVc2Z1elEySkZiTmpMWlUwQW5EbElNczFJT2tTUnlna1pp?=
 =?utf-8?B?RXJMREdBOTBIK0RGQTQ2T3RyWmJFUmUybGtYOEJQUFdSNFl4MEx3VzRSS3hp?=
 =?utf-8?B?RFZmbnJPZHA1dGZ3Mjg1blUydEdtek54RmxNbUorclUwcnRXN0ZFY0tSTnNH?=
 =?utf-8?B?dlg3SVdNME95RDNtampWYjNFMVZNY3BQVlZXQWczY2xVd0gyWHBpbWxwL3li?=
 =?utf-8?B?eHZHUkEzcXRZU0R1cGJXVWp5Ym1jY3FXYzFiMXVuZWdMczA2UkxZUG9JTFBD?=
 =?utf-8?B?enduYUJpTGJnTHI5dWFNcWdzSEk2YlRrWXBCbHJLRjdncjAwZnkrcm9hTmNM?=
 =?utf-8?B?NDRzeElEQlNLYThrMXc3VGRpdE1SZXBsL1lLOGt2dzFaMXB1Z051SW1tUU43?=
 =?utf-8?B?b09LeXRHMDE2cEp4MGdvTUg0ZUhLYjk2d1VPWWRlRzAvMGh5cjR6dGdlK0pS?=
 =?utf-8?B?Rzd2WGM3VXBUeC8wcTZoTWlkMmVNQXlsQ0RVMEFmY0k1VG4rY1pNUEhpWktV?=
 =?utf-8?B?YkliNDV5eVRvMnZJR2N0K0ZlM3FaUWRDVDN3TlprYTV0TGFBOTNtWTQwRWdH?=
 =?utf-8?B?Q0VvOVZKU3p3TWJTYldXN3o3c0IrVllMOEJVSFpubmV6MkJxRnlhSjQrMnBl?=
 =?utf-8?B?OGVZQ1VuaUgzdGc4cWUzQTloZjQ5V2x1T05zQ2ZDWHRnZEo2ZnllZFJzRDdT?=
 =?utf-8?B?YW5ZNkg3UXJaMEtXeWFjYVI5dUlQUjlzQVlPYVYvbkxKU2Q0Q3gzK3pzZ3p4?=
 =?utf-8?B?UkRUQWlpUWd2VzJ2Nnl6aEJ3bUxaRU9tYVRYV3lPcXNnRmNiVDZpZmVYdUU4?=
 =?utf-8?B?Rk40WmhJaWFkL0NGRGR5UDdleDVtckJvdTZHMjJRRmZOaEJsdCtHenlOakFt?=
 =?utf-8?B?TkdKQkk3N0Y2ZDQzeXJBaEpCMGtyZlcxbWhIbm9ITnhXanFqRVlKQ1V6Q2sr?=
 =?utf-8?B?Y1NSRkhtNVRPWngwbGUydEVUQ2dZV3Z4d3Z6RXNlWUh2Y2xUTHJFVnU3aGUy?=
 =?utf-8?B?c3ZPb2Y0cnJycE1aSFF1aDB4TERTdHlWRGJCVUUreXJSYWNUeU9ONWtzdzRY?=
 =?utf-8?B?VS9ZemN2cVU3WmJNWTcxM3N3ekxKS05wampESmR4WWY0bnc2TG95OFJFMUcv?=
 =?utf-8?B?dXJ5ZDd1KzMxVmI0cnVkVi9rYlZDY0JXN2UvZnVSdkx1RmxnT3htT050Mk9i?=
 =?utf-8?B?a08zSWpUKys1M1hBYXZRbk0wQit5UDh2aTFYSUMyS01Sc1k0ZGlLbDh2SEFu?=
 =?utf-8?B?MWlWTWZQS1ErNnViRjVDb3EvTmFKdWNxQUdGNThLd1JMWnpwdjVHK2ViOG53?=
 =?utf-8?B?Z1ZjUlFTSEtHVTdhZmNXS25wNDN2Wjh2QXJuUGM2OUhQUTFGa1QrTFdlUkpv?=
 =?utf-8?B?TWVjbXZiNVFHSFBEekFFTGFNL283YTJMSFcvVG1KS1lNYWtpdUtZK3hGbktF?=
 =?utf-8?B?QUg2Y1dwQVlZN0xwSTBqRHV5UGtJTm1MbDlhRUZFL1pQN0dQQjQyZ2svWjgw?=
 =?utf-8?B?YVBNblpnbmxGTis0Q3hUTllEUUl1VSt4d1BIWGhVZWh2SU9qWnhVdFZ2cGNG?=
 =?utf-8?B?WEY1TGNYcXNjL1hETG9TV3dTcWhNQnltTERSdzkrUHlodkJVMVpVN3ZsajY4?=
 =?utf-8?B?YzV6UGY1bzFIZmFZcjJYdEoxZ3pBOGN5RTdmS0p5dkFVUW9sb2JSQUVTeTda?=
 =?utf-8?B?WS95YThZdHVRelVYdzMzQ0JRYUgwLzRKcGFHVXRMVmFXVHIxSFBYZThBcUJo?=
 =?utf-8?B?MFU1V2NaRlRXQmxmdHMzK2VtcWlucHZTYlZlc0Jsa2RDN1hnQllESjJmYlZ3?=
 =?utf-8?B?ZnE3UzJoT2V3dmFuenRtckZmM0lHRVNnc3JlalRiN0lGYXBTbW11dndIOWE4?=
 =?utf-8?B?SjBmMGVJc1RMWjhpMG1EaHgvQjdBOXc9PQ==?=
X-Microsoft-Antispam-Message-Info: iPmIlSHHEkqf2z95R9RBIXGb0y/hkDZG0B7myqjpgVKXQJHA97EW3xl++UZ5g1BVintl0xvwMotpnx5mrWezaPCY2PK4NeHloK8TnvegHmjEQg1HfmWctKZ2qpxXBmuBiFzUNQaPlpdH46N1nGJfkEMV2NSrrUIYJ1q7slD4aUNut3DSmrmpxM2LfsSHn7EeZEvsAkNW3EHz1F3TkbOEypwfRGiKeCVO+OwANQporUNv76k2w96i8InAChRDOj8kstI+Hj3XKFnbqEKMyL5V427p3+GwulGDJckHTVWmMfxTOBMAEoo7YfCGxYlVSsGlui8mJ1UVUOTcv2qVVuqLHF9PWr+1uL9mSpLFn3QjR/g=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;6:5gaf9wmHvdxEX+aIcpYiIrRed6WIcyGqe5R0sAJEscsVyFmEM1jUX2NemssJBEWC7LTKkmNA09suo7WkO1zezq1SWFQJ4tfzVsn1Iif9CR1C9f2iLqL4z4kydFoEEG2S3N+msECb7SKepljL1Pp+M505ZUBL9Cvm/Nup+A6WMqoJUCLlwWfnuSCHyodWRF1nMuH7SDbl8SVmcKzxzGbK8H4D566r567RVmrwBrjnXtzZ4njcbZfIRuH0fuONaEH9RPOVdICDUD/ViRbGqoZqKFC3/ok0tCzH6BYALa/zEGHTaGyBSiYOe2K7sKgw9UJbDqq8Sc/N4Kk22MbEIYPU+gwJjCIrNCHfIlOM2PhEdpL06j6B+Q3Rga1LO7B8IlGrIT9v6spJREmSeukUyUF23GtTZ+o6OH5lTzEQsfRtePziLAcikMVo5AnJemvo8pTj8Nf806aW2xGvcNUPaqP5iQ==;5:gefFFu9i+k9lu/tDOLx37KR6PGm4U38me3rU8rOVux7Be1FELBt8HW5I3esN2EiFNc5jqv+FlPwwhAEg/dZMTMgcLhiNUQN4TJ8jgGL+Xkg7AZBbdq71yb3NMvA6pl0cqjLmGNttlqdVZFTcv0iOXNMfLvZblI5lSPQk2mtI9tE=;7:dQomdqRIjwFGdrykMKvpbMQBZXh90ExTuaR/WbL8SK56YI/+v3owiFr44rIp79ZmcmNlpx2INyNvWMQKrjfj0TmUc3YjCdpC9OzCQqELwLtA4ZWAd3MyALzg1zmDOtb5hn0Donk5R8X9bqRZboG5iks2uxYUi6KJvK0OtWxCdvgtiq2YL7R5JXdl351DdNsLOcG2PSKnbN7/ajNAr8VV393qQxM3tJ3scMtl7jkpVgzJWQjg5IgStXqlMx4OBsk1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 10:26:58.9501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f13830-8b6f-498b-390d-08d5fd197943
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-08 12:01, Andy Shevchenko wrote:
> On Wed, Aug 8, 2018 at 12:47 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2018-08-08 11:08, Andy Shevchenko wrote:
>>> On Wed, Aug 8, 2018 at 11:30 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
>>>> +       /* Count number of clients to instantiate */
>>>> +       for (i = 0; inst_data[i].type; i++) {}
>>>> +
>>>> +       multi = devm_kmalloc(dev,
>>>> +                       offsetof(struct i2c_multi_inst_data, clients[i]),
>>>> +                       GFP_KERNEL);
>>>> +       if (!multi)
>>>> +               return -ENOMEM;
>>>
>>> Here I see the following:
>>>  - it's kinda unusual use of offsetof(), perhaps i*sizeof() + sizeof()
>>> would be more understandable
>>>  - there is no guard against i == 0
>>
>> I don't see why a guard is needed?
> 
> Because there is no point to have a module loaded when there is none
> client to serve.
> 
>> *Your* code below needs it, but that
>> issue is not a concern for the original code.
> 
> I can admit that's not a big deal, just making logic slightly more robust.
> 
>> It might however be a
>> good idea to fail the probe if there are no clients to instantiate, but
>> that's a different issue...
> 
> That's what I have in mind.

Ah, but there is no reason what-so-ever for i being zero. The whole point
of the driver is for cases where i > 1. Or to put it bluntly, anyone
defining a struct i2c_inst_data with zero entries deserves to be punished...

>>> multi = devm_kmalloc(sizeof(*multi), GFP_KERNEL);
>>> if (!multi)
>>>  return -ENOMEM;
>>>
>>> multi->clients = devm_kcalloc(i, sizeof(*multi->clients), GFP_KERNEL);
>>> if (ZERO_PTR_OR_NULL(multi->clients))
>>>  return -ENOMEM;
>>>
>>> But I would like to hear your (other's) opinion(s).
>>
>> I think using two allocations is a waste in this case.
> 
> On the other hand it makes code more readable. With offsetof() it is a
> bit hard to get it on the first glance.

The driver is tiny, I think it's good if there is at least one thing that
can be a little bit interesting :-)

>>>> +               if (inst_data[i].irq_idx != -1) {
>>>
>>>> = 0 sounds more robust
>>
>> But not as flexible/future-proof. Why should 0 be the only valid IRQ index?
> 
> Ah, because > is used usually is a quoting character in email you
> missed the point.
> It was written as >= 0.

Ahh, good catch, that explains it.

Cheers,
Peter
