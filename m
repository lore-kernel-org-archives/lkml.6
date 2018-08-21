Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D15C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF198214FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Hu/rPFW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF198214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeHUKLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:11:42 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com ([40.107.8.134]:19264
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbeHUKLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40Fbk7b+t8m5fLIAJ80kKlFdFc+f2G7ht0X8oyacn8Q=;
 b=Hu/rPFW8c6DAgBaKXxHXQbi9szZ/diKJVu0T2dQu4SKOSpbEYofGiXrd7m6Osal5o8XaZgxK4DoNiLr/CF3Le8azO5BSJQ1qlL+hHUOtoUsWNPRZkxWkeGiqqUYelBh/h5+WsH9t9OWmXpDdHNi7zUznsP8GV/D3HZPBGJvcOgE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 AM5PR0201MB2449.eurprd02.prod.outlook.com (2603:10a6:203:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.23; Tue, 21 Aug
 2018 06:52:37 +0000
Subject: Re: [RFC RFT PATCH v4 1/4] gpiolib: Pass bitmaps, not integer arrays,
 to get/set array
From:   Peter Rosin <peda@axentia.se>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20180820234341.5271-1-jmkrzyszt@gmail.com>
 <20180820234341.5271-2-jmkrzyszt@gmail.com>
 <0e79bdc3-ca20-6823-c86f-5e9da7dafbc9@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <83653abb-ae2c-b72c-0877-14483abc1f64@axentia.se>
Date:   Tue, 21 Aug 2018 08:52:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0e79bdc3-ca20-6823-c86f-5e9da7dafbc9@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0202CA0041.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::27) To AM5PR0201MB2449.eurprd02.prod.outlook.com
 (2603:10a6:203:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 633be216-9aa1-4b19-6854-08d60732b011
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;3:KI+bH4SnCyRs2IB8tH5ppEGv9oN87D3rFSGwHkYpCGWeeoiiz9SzePZS9hPU9KMC8wb49sFDGIfOqWYTH0uIpbWAKIr/7YD5/1u4r20VNhEiEfC4Bi7lVK/C87Bz8qUIIjDhLJ5ishfIvxGhwEMXXeka+S/AqCbnmFXjf6Cj0wTzujLfTiDv2oO5hqYqCIIlvR9+uKKz3oqIu5QKXZwohH1C53619myzLdXKeXNCE8rGH9Mtxz2VPXbnFO0cUNHe;25:r+rH+bu4aoW058Lm9fXdtYo9z2lgoQAPZssFp7YrBNyOsI6PVJ9GfrHRSyITjNAMg+BWoX05g/hgTTGWIdWdFQPR8cYxeSmwRxtXFUY96AvvqSJ0whDO6Kz8KPBcFXYs/saLKBvmj2ToAD4524MCmIgIH8lrMvMoRj48zElkYG0XWelGWjpB93Ev9OyDIDkRqKFQ/hvVjQkjg0hJ7cOEjRB/EcriZeZhsNGwE0VhSC6oQqxC0JAAUFRUvqgAV7m4q8YeYP5bHsm53axRNTaz1me3vFaDlRzDanaErZuj4xjD8ZwcpM65wNJic6ICd8l17f2ZuyZjQO5WOKwkjZpx5Q==;31:QQpanCDDAglls/GT86nzc3CTX0sYS3AxOnk5DkLYMcc5c+8h0ofDEwAL9U9aFeiFbziaMVNZNhKs9bQjW7sBLsMinQ30Zp3A+uuSNquAoXVrpPxU/of44WgV5sRgBg8j1tKYm8YGmqUq/bsoYiV8wdqjj17HK9/7BC4UmO5/rGPojckZNE1CFg/sIXid4c1kpshsS5E9vBRx24Xcqm8v7ukzp2P7T5zxOgRZ/EFBJN4=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2449AD91E26B394AFC0CDC7ABC310@AM5PR0201MB2449.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2449;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;4:h27vqCOOfVeFT8dF37afjbNNfqLHLViTam+uq2687KN2ATd2vxc1VYWAMfsGyQ2ZYxBjALxIQQjfn8GK6Wf7TWTHoAKkUhtYWlv2xUb8zal7FdoGvZfW421qdv5t/olkNBUJ9IwwzC68DM1d4Fn7FF1linQXSBllpUPw+mf5OJ5stgFuQgPc7hyDp6zGNLSYE6P4VVQRPoQw7fV4HEn1VgsCsPI/oR3YllFPPEhh30YjKvkON5o3ka7CW+/ke5adrv47435EYu6Z7mI+wU/pDveZ3/OcG7UBaO95BYsWkbpuqtwOP+U2bDYo22F+4qPn
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(396003)(366004)(346002)(376002)(39830400003)(199004)(189003)(6116002)(36756003)(106356001)(74482002)(97736004)(93886005)(229853002)(6486002)(31686004)(65956001)(305945005)(575784001)(66066001)(5660300001)(86362001)(117156002)(47776003)(50466002)(31696002)(217873002)(65806001)(478600001)(7416002)(68736007)(6666003)(65826007)(105586002)(58126008)(486006)(7736002)(446003)(11346002)(54906003)(64126003)(16576012)(2906002)(53936002)(81156014)(110136005)(316002)(8936002)(23676004)(476003)(81166006)(186003)(26005)(2616005)(956004)(77096007)(16526019)(76176011)(36916002)(52146003)(8676002)(52116002)(230700001)(386003)(3846002)(2486003)(39060400002)(4326008)(53546011)(3260700006)(6246003)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2449;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NDk7MjM6dDdkbTJkQ2IxOUNKdUh6SzBJSzl4cDNN?=
 =?utf-8?B?cGJodVhmdHlCdFFXaHZEbUkwWW0xOWRUYktqb09xdklHUWEycjN0cm5TM3Fl?=
 =?utf-8?B?d0VrVWFyZnloTm4wU3FIQkQ3dC9weFhlYjFLcGtHbHFpV01YNExuOFMrbmZQ?=
 =?utf-8?B?cFMwM1REN1Z0eWZNMWxPeGtDMjhFYjQ3TGIrY2Z6SzRTRW1IK0JFd0tjcUlG?=
 =?utf-8?B?STN0RHd5T2JVMWwxbk56aTVpNU5KM3I1cCsyYkt1dE0rT2pqWkQyaXZNWWpL?=
 =?utf-8?B?RXJUYm9CeW05THJrOG0zTTNGNklZQ0w5em9FbE9hd1I3dXFpdmVuZlQ1dzRT?=
 =?utf-8?B?STJmaGVLOFRSSkxBVnNteXk4b1lwN25sT0RudGcveWxPZFl2eURpYTV3ejZ4?=
 =?utf-8?B?bHJha3kzR0pOemMzWnJiZzJMc3A5cXd6bHJ4NUU4MnN6NW93WFloYkQwVHN3?=
 =?utf-8?B?TnZxRHpsUGlwTGNoT3lXNGxkT0xJUUhmREhDakMrbXF6dFoxV1hvaGEwVGJt?=
 =?utf-8?B?Tm4yMml5dGtUM2FEcStNWll2S2FJTjVSaGRZN0hFdGpydFdqdHFteFVaVkJl?=
 =?utf-8?B?L2V5b0kxZmFGRm14V3cwTjZBN0dmc3FTRDNwT2pVWWVHYU1lTG5rMW10U21C?=
 =?utf-8?B?aVpLQUtJT2xpRTZjZithMXBzZ01mbDhyY1ZuQ1FOV1JIOG9XNU9BdGJFbmxZ?=
 =?utf-8?B?ZTJNSzhtbStkb05WVUtFRUhhOTRXdk9DWk5hUnA3MUo4SnRyY0dXUGpIeTBJ?=
 =?utf-8?B?YXlzMXkvSjVJekw5YnIxRHZuTnVubGJVR0VVcVU0OSt5RENYc2hIU1JOZ1pN?=
 =?utf-8?B?SmFEYy82Q1AvTTA4aXMrL3dsZDI3WUpQZWg2RXlWcUFSd1RhcVhJbkdKampu?=
 =?utf-8?B?VXB4aFVGVExWUm5uUmRhUld6ZTNSL2hzWnlMTDE0TEtLcGdjb2lQdC9iMytZ?=
 =?utf-8?B?ZjNTSTlUR2VYMXc3bnVmZW9aMTVxMk0wNnZVbWJVMy8wVVE5TUJCU1Y5R05i?=
 =?utf-8?B?V05rWDdNZzQ5akMrd0p6cjlwSEcrT1FXYXlJTzNTV0Z3dFZmYkdZdXRpUm11?=
 =?utf-8?B?Y1o0dUNMY0xUbS92ZCtleXR0Sm9OQkxOVjE0b0gyaTd4NEdLWldKbEFqblhL?=
 =?utf-8?B?THZ0dExUL3N3dmJjTmMzK0U5eGNPeVJ5U0VXbzF3b1ZxaUM0VFFoQzdKMy9w?=
 =?utf-8?B?SGs1YnRCZGphTFJCQ0wrL09vcmNEY1d3WE9PMStzeFVLQXZJeE1oQkdBVm5J?=
 =?utf-8?B?M0s4dVNicmJNTmhOTE5hUVM2ekFJZ2p0YXROOExxUTZnYkpDQ3lKU3dpdkli?=
 =?utf-8?B?Q0F2N3dNVVJzNExRb1d4UG1tMEJnOVcrNHYvRGJGd0pJdzVQSVJGaGNhdHNx?=
 =?utf-8?B?SkJjeVhSL3g4UDdJVnQxWlZGZGc2WHVqVForMjRaZEw0YVRGRzJ5dlIwY0FE?=
 =?utf-8?B?WXNHWE5QdjFBQ0FkZFFEejJrK0JJUU9qZDhTVUx5MElqS1RON0VEV1NnVS9C?=
 =?utf-8?B?OWZ1NGFHYkJQVTFYN0RHTW14NnUzZjkvYlNlWnYyU2hBQy9pSUt3Sk5Scmhj?=
 =?utf-8?B?MHBhZXh3S0ZHQjVJMm9RcUY1MGYxYi9yaDErbFJ4SkNwbTNKdXlFOWVJZm5q?=
 =?utf-8?B?aGNmdEZNbWxKNGY4dGpObUJIQkE0NjhFY2QwSUMyekpka3diNTBsaWZkK1J6?=
 =?utf-8?B?SVZtZzVVVnlueWFkdGFaWithMWRpelVLUTRSa1hJa2RPLzBjL3pVaVo5MFkz?=
 =?utf-8?B?SDNmRWxtRzZhamdkaG9SL3ZNUGJYSlNsditiQmNPRVozcmdFR2w5QkRTYnBv?=
 =?utf-8?B?d0RGVEFiNk9hb0trVEpsUWVVaklCdDgwOG4ya3U1Z3NzVFVadm1ndDdUZmI3?=
 =?utf-8?B?NkE2RUdtQ21JUGVqOWU2YXFIbzRnN3hkK04wOGltZ0IwbWZseEZoNzhWWVhs?=
 =?utf-8?B?RUxkY0pBU2J5ZGN4VzN1cEhQSXEyR0JzazF6aVZhbWV2TUNYQVpIaFZycjZC?=
 =?utf-8?B?b0ZjQngvRkRGTVUvNlZwK0dSQ1gycFRMNU9Gc0U3eEJxRzdweHVHbk9teFVu?=
 =?utf-8?B?SXJlckJXd1lQWjN3MlA3NnZFODd0RDByTVVGbFFFeHhCdGU4UTlXN24zV1Ja?=
 =?utf-8?B?OVBHcmROU0RNaGIxNEJ3azRMQWpkMjJnWkhpUy9vMXgvZXFCS1o4UTF6NXZx?=
 =?utf-8?B?ajJ6dlRmNWNQYUdOalhXL1dpV1BpYlNNTEsyaThFKzBWc1F6Y215KzRENmpj?=
 =?utf-8?Q?niltg58RyiQg5DaMmF7n?=
X-Microsoft-Antispam-Message-Info: uUBDGA9iKXiTBestbnQKasmRuOTWtxZmWqyhnqV2i9Fml42u+Acj6uCrqi6nn+m2ppHkMBTpfBjCr8hEx3qRaQ+LFow1SLs03R0iFPuZmfbr8dDUt1LOKj/QMsKZXN8MXb6g4Dr38243DyQEdSGrrzP4RWSPcKjTFZU0+iHRgGbv9cqvvaonKmEsCZeSN4UGb6PK849800HRnOcJbuZjl8QAOwB2XyKKrXNPbmId6vDa4BN0bNQf4Euuq87lKifGmOsVGyAsY55fC7H95UoeXwIS1xmVR8G6/q2lx3t0IE5myNnVXPM2ky4Wuw6LDRtiXuS0cdqvbx4woDrzeTlxZ2kuaroEUjb8vsbwtr2f/Ao=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;6:RL3UYMwnzZa5FLEBxizeoSpRUphi6fjISxg6pJyA4YXg5alWg7Mw7/xnzPMnv+P8boR0Hi3QkFqMM0XAw1TyxGG3Fiw73VRsMNhL8LK5WQadHdBBUByiMG08GQN7rj/twViz64A1jBC8FUiEE9CtY2JndF4ALgiiSoqOEf/mvFP7jf5a1CV6wyfdPcVDshhjsCBwhnaDJze4jRxJ4Ww732jSl1MGk+gDA9/bEi9rSpm/8VWtlohzN1D9lgldezvW14yURR6u8HbffRYaxzPoseY2hR6qUIg7ukVIpzcLo2Odj3SRicsRBe/IoUVQnWuewe2xWT5VhGJ9ScE1dBWP68GEtFe7kIYHji/s47RN9xjjfAD5Gx1cAvI4utJNPmm0Z94jdvMsFzMAoaIH3RjfWPJp4LGE90TaVui9udYDCfZXApYvhDiBeEyAeLEffwCH40j3n56w/urCad3voUJlvw==;5:dHUp9Z/Bnx8XroQjnanFIimCjJxM68/rfpX8YUvQllj5QKee3lNdSQ7E+cJuLfeQ1SgP0Iv1tepZ8U230dBXx4nNR6ON+Xekb5QyLqjW1g5YN56ismhAkgxdiDvoRX6793BhOWFm3f3EOIodFf/KdzMroNJ7Yy0brsIOBg8Wmf8=;7:inVpz1AbSE7xN0u0Yqzm/Ejk/ZqboHgXCm87Q5Tkqu05veqe4NsxOAOmbO0qRVHdzwt9OLit+kWX1MbMiKuYDdWx02g/4QwKHEGUaKmulYnUUt/zUiEgPMasC/smStP/vYi9DP8IBzqm2OVjvuvZaAjHs62jZMmeWkxO0v2JdQsOua/ZImYcPy6z2n66l78loYahr1tfmn602FthRTuml43/aUK8ygNY28LX7SvhexPpFH3TA4p+95i1in3OGGo2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 06:52:37.6821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 633be216-9aa1-4b19-6854-08d60732b011
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for replying to self...

On 2018-08-21 08:49, Peter Rosin wrote:
> On 2018-08-21 01:43, Janusz Krzysztofik wrote:
>> Most users of get/set array functions iterate consecutive bits of data,
>> usually a single integer, while or processing array of results obtained
>> from or building an array of values to be passed to those functions.
>> Save time wasted on those iterations by changing the functions' API to
>> accept bitmaps.
>>
>> All current users are updated as well.
>>
>> More benefits from the change are expected as soon as planned support
>> for accepting/passing those bitmaps directly from/to respective GPIO
>> chip callbacks if applicable is implemented.
>>
>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>> ---
>>  Documentation/driver-api/gpio/consumer.rst  | 22 ++++----
>>  drivers/auxdisplay/hd44780.c                | 52 +++++++++--------
>>  drivers/bus/ts-nbus.c                       | 19 ++-----
>>  drivers/gpio/gpio-max3191x.c                | 17 +++---
>>  drivers/gpio/gpiolib.c                      | 86 +++++++++++++++--------------
>>  drivers/gpio/gpiolib.h                      |  4 +-
>>  drivers/i2c/muxes/i2c-mux-gpio.c            |  3 +-
>>  drivers/mmc/core/pwrseq_simple.c            | 13 ++---
>>  drivers/mux/gpio.c                          |  4 +-
>>  drivers/net/phy/mdio-mux-gpio.c             |  3 +-
>>  drivers/pcmcia/soc_common.c                 | 11 ++--
>>  drivers/phy/motorola/phy-mapphone-mdm6600.c | 17 +++---
>>  drivers/staging/iio/adc/ad7606.c            |  9 +--
>>  drivers/tty/serial/serial_mctrl_gpio.c      |  7 ++-
>>  include/linux/gpio/consumer.h               | 18 +++---
>>  15 files changed, 138 insertions(+), 147 deletions(-)
>>
> 
> *snip*
> 
>> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
>> index 401308e3d036..d675e0ca2fa4 100644
>> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
>> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
>> @@ -27,13 +27,14 @@ struct gpiomux {
>>  
>>  static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
>>  {
>> +	unsigned long value_bitmap[1] = { val, };
>>  	int i;
>>  
>>  	for (i = 0; i < mux->data.n_gpios; i++)
>>  		mux->values[i] = (val >> i) & 1;
>>  
>>  	gpiod_set_array_value_cansleep(mux->data.n_gpios,
>> -				       mux->gpios, mux->values);
>> +				       mux->gpios, value_bitmap);
>>  }
>>  
>>  static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)
> 
> Please take the opportunity to completely get rid of the values member
> in struct mux_gpio. It no longer serves any purpose.

struct gpiomux

> 
> *snip*
> 
>> diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
>> index 6fdd9316db8b..cc2d5f50472a 100644
>> --- a/drivers/mux/gpio.c
>> +++ b/drivers/mux/gpio.c
>> @@ -23,14 +23,14 @@ struct mux_gpio {
>>  static int mux_gpio_set(struct mux_control *mux, int state)
>>  {
>>  	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
>> +	unsigned long value_bitmap[1] = { state, };
>>  	int i;
>>  
>>  	for (i = 0; i < mux_gpio->gpios->ndescs; i++)
>>  		mux_gpio->val[i] = (state >> i) & 1;
>>  
>>  	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
>> -				       mux_gpio->gpios->desc,
>> -				       mux_gpio->val);
>> +				       mux_gpio->gpios->desc, value_bitmap);
>>  
>>  	return 0;
>>  }
> 
> Dito (but the member name is val).

Here is where struct mux_gpio fits.

Cheers,
Peter

> 
> *snip*
> 
> Cheers,
> Peter
> 

