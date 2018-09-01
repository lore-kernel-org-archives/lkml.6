Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A29BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E042083A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="e99KKy92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E042083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeIAEda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 00:33:30 -0400
Received: from mail-eopbgr40116.outbound.protection.outlook.com ([40.107.4.116]:29776
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbeIAEd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 00:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1AE0B1PpWi56Z8oJUSKJ2XEdrLHFvP5Jv03hSZnYmE=;
 b=e99KKy92wYq1LxoXSJchAAPuQ0RNkFxDttItezxhGB9h+RHtRy6tGZqiNQArII6DMnXHUIPTH7xgfoSdDEy1zRZoCkW96tQTHc0DO4s1y+xjlXqtA2lBs9rzkSEyjh6SrIZ+ifO5r/EMYFjzV/SY4sKg3E1uVm5oracuZCZK0dY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 AM5PR0201MB2450.eurprd02.prod.outlook.com (2603:10a6:203:35::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Sat, 1 Sep
 2018 00:23:21 +0000
Subject: Re: [PATCH v6 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180829204900.19390-1-jmkrzyszt@gmail.com>
 <20180831225616.29221-1-jmkrzyszt@gmail.com>
 <20180831225616.29221-2-jmkrzyszt@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <47a7e66f-8635-7131-8a0c-c26cf849fd50@axentia.se>
Date:   Sat, 1 Sep 2018 02:23:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831225616.29221-2-jmkrzyszt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P192CA0001.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::11)
 To AM5PR0201MB2450.eurprd02.prod.outlook.com (2603:10a6:203:35::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eaa1c7c-e902-4bfe-71b6-08d60fa12118
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2450;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2450;3:IKmo2pvzBmk09uGGnfoAHwhgbSdkf2IkBzi9nH2tQdRU/PaIJfvSBfmWB1DrbkcFClzOE4v4YP3DP/zXZYYjDwwUqhnsn6XAtvsDCkR03tpXyn3wQyLdf7ZTcG4CE93cYSe3/QuTevygowfM92PIWaHxZAMj+BJVV6fWKrtjOh90eNU9AEFQtMQpk5nNSVkl0c1XeXeFsCNrLOzGfNpdlAoyj2Qm5w1S31968+LLNdN+1uR28P4QGFQoQW6u30DM;25:kMrOXQ/qR1ludClOiw8A5aGFa1crco1tFbSERwB6B3ywvVzAPOT8jajMh9yLT+VXfwib2nt1Vz9x/dT3bE+/OkSvIBStEa6wzpQEHTJoCKly0h5tA4cmyDQBj2Oy+7SD9utIMvF3kLTVkuF0Nx9aOcuBcueF+zVMzwx3NedYF1Vckoi2MdZYEmf4K6LtVZ71VZ1wz5lQowTf74+3kgT4XQTTGYCRan3erk7V/3iKMGtRphdPfJlIBO5MTNJTBgVa3g3LaA+xl+zMejU6gHSwX2AX92/5ICSYv2HIJ7t/uKKYVSsJDJXEy33F3GfOE7mWp8H4vMw2Q8A8Py9TAtNk3g==;31:yMTQwgO8kFxXRdRa+CetZ2hcqGAFjhEJAUcMC8FESgE3WOzUNXFdhAmdeMQ3oE6NBwzQwlUSO5s2Oug2GWJckGWQO+ID6EwjGro6HQX2A3x+IGPjJSc8XJJz1+HHJfr1TyvERZ8cOTbRKQO6pEYgkUoHowpPZphhn+GsrSxDaEYu31s5P/O26/cnNScyTJ1z2zQ+/3Z04Bc6RQKdi+lfXj0A8KILdXs3Xw6/vLTnyLE=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2450:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB245089BE07692486A303DDA7BC0E0@AM5PR0201MB2450.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2450;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2450;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2450;4:HupZjzpoSHZlp2z6Uflq9KahV1q1OMehSwukuwWUDBZO6qSThO63gcps3Z6wDEPQbt+7bbdBNX95q9o0zTkyJSVzyQY8N1SisHqVpJSenjSLTMRXj6owxSRbftCCZLhrdhgLp1/8vSFjTkIPiadxpwsXixtDKsnc18la18gp+65251ewuh9CriZgiXwhkrq/o66Er9kf5Off2jd/5b1mb1idmBfQn7psA+J2iU8ZAoew4/KuF8j1Web3o8+0rdjqSjDpiwYFVSuUSk8KIQ9UyQ==
X-Forefront-PRVS: 0782EC617F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(136003)(346002)(376002)(39830400003)(366004)(199004)(189003)(4326008)(478600001)(486006)(53936002)(81156014)(81166006)(2906002)(6486002)(39060400002)(97736004)(47776003)(3260700006)(6246003)(117156002)(74482002)(25786009)(36756003)(2486003)(52146003)(52116002)(76176011)(7736002)(68736007)(66066001)(36916002)(23676004)(65826007)(31686004)(31696002)(230700001)(956004)(65956001)(2616005)(6666003)(106356001)(105586002)(5660300001)(86362001)(65806001)(186003)(476003)(54906003)(77096007)(8936002)(26005)(50466002)(446003)(3846002)(8676002)(16576012)(11346002)(229853002)(53546011)(6116002)(16526019)(305945005)(110136005)(7416002)(64126003)(316002)(386003)(58126008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2450;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NTA7MjM6bFlMdllaUy9WQWZhWEFWdDgveGdhUlpz?=
 =?utf-8?B?QjNGZnlZakZuUjBWSis3UHVjeW5tcmFLcGhkYnFHUExKODJVNnV0NW5pZEtG?=
 =?utf-8?B?UDI4b093eEpMMXhoL05pNktYMnI5emp2bkUrY2dWRzNsQVRBUmlsZzhXajhw?=
 =?utf-8?B?S00yQ0RWVkUyTTZJZjltZHRNUGNlZllXc2FYcWs0ckptK1lER0RNM3NMZ3kv?=
 =?utf-8?B?RmFBbG1jdVNiUXlXbGhCSUprZjIzQXVXbWtBRUE1d0tUSWhFU1lqU05ybjlu?=
 =?utf-8?B?b0lFR3NEL3U3N0ZBWHIxa20vRzk2WEs4dzd6VFR6ZUE5MjlnY1JsWU4vcnVT?=
 =?utf-8?B?ZERoc2ZTWVRwRE5GQXA0Q3NlWnc4TlpkaFU0VnpZZFBzTGlCSks0bGZkNFEv?=
 =?utf-8?B?UUF0TW54eTJkNEZNS2RkSVFCb29DYnRpTk5ycXV4WDBYMGlKNDdHY1daN0NN?=
 =?utf-8?B?UThEUDJNZ21VcEs3SjVIRFU0WXBqQUFpbzlrOWpKWFcranQ3OU8wQStGeG9P?=
 =?utf-8?B?dUxZeVBhL2pxUE9XYVcrTmUwbTNoNUJPZllhZWVKOUtYemFBb1U3NFZvSExT?=
 =?utf-8?B?a2ZFaytwMFJNMDFoTmVnWU9qSU9ZclVQbEs4Wkh1OFJtZUhBODZXWlBseFlF?=
 =?utf-8?B?Znc3dmx3dDB0dnJFZWgyRXpWT3VEOUtkZHBmMEdFZHlBNnc2bzVDTndmZ21F?=
 =?utf-8?B?RFlQaStzWWxzTmhiK0dtTGdpNkdUeHZqajYweWJoQWpOUUtCdjRFN3RkK1BK?=
 =?utf-8?B?VjYxY2JDZmJZSkp1OVdkajJzdkx5Q285U25HQkxOYXpVMG9BUDFHSzVHMi96?=
 =?utf-8?B?and4RUpJY3VtakhMSUJ3Vk5seDlNbGhpQzFFM29MSlBMWkRUTHVLblBncVBu?=
 =?utf-8?B?c2x0RmZsT1VwUG1aa3hmY0J1K0RZRVNpaWk5SXFIV21YRThyMmZFTDI2S3Nw?=
 =?utf-8?B?cnpUUDROSE1aNTRPOFppTlRpQTZwdnl0eTByekw3SC9sT3E2ZG53WjlhZEpy?=
 =?utf-8?B?UnhTNzJ1alJ5OEFjdXFHZTB4N3BiWjZzOE9FM2NmQnd0YThLKy9mUWpIdE11?=
 =?utf-8?B?bHgvS0psNG1pRjU5ZzhINC80NEJmazYxaUdyL1RBNmJ2RWx0YkUxbEpvMU8v?=
 =?utf-8?B?N3E3YXUrZ0dYMjdkdHl4ZmhsY1NLMi9vd0h6ZjhpMkFBNXhNOXpqV01yYmxY?=
 =?utf-8?B?Qm5OeGNlRnBNWkliM0I4bTJWQ1pQbDhqVUtjcE8wVHJIdjhTcUZYNzA5U3kv?=
 =?utf-8?B?MWtYcTZwU3FML2w5UHJGMkZSNUp6TnB0K3pPMEl3YU9zbGFHcWR4WU5MTG1l?=
 =?utf-8?B?aTRNYUY4T1dlVkIvOW1OeUJGUFkxaC9DSmJQd2hyRjdtdDRxcEhJeHFZYnY1?=
 =?utf-8?B?V0Y0MEJVMW1ZOTZLck1sM1NwVnlMalpESkUzT1AyVkZZa1o4ZWJScmJsenVE?=
 =?utf-8?B?UjIwRUV1NTNFdlhBMW1nSFhYV2xzVm5KWldPUVJ1Q2E3UkNTWmREY1NpTGlo?=
 =?utf-8?B?SnQ1MllXZi9pMGtWWjh5OFNGYmxBVk9VZHFpTHFPbkF3MGpIMG1YSGdZeVFK?=
 =?utf-8?B?MC9LOEFEYzNpQ3ArV1FvS0FTUnlJbW9zSmdWUUNQL1ZMT2MrQ1oyYmFneTJq?=
 =?utf-8?B?bFV4YXc4Q29NTzd4Tjh5cnNSTHFDcklzalF6MkYxb3laL2RuWFQyQnp2cHlr?=
 =?utf-8?B?bGtndGRQdjNnaGZuaEJ1TUttRXZDMk1jU0drSzBEVnVMR0ZFOE9ZeklsaHJB?=
 =?utf-8?B?L21yRlY4QkdmY1BZd2JhOFg1N2hJcXRkOVVWOHgramZZN1hXRzZuRWY2U21M?=
 =?utf-8?B?OU43UGJYcDAydEg0c3FtaHV3UWh2L2EvMXFTZXdLS0wzekdqZXNaS2Q0Vm4y?=
 =?utf-8?B?Znc0NmNSQlhvWFB2dE9nSzR1Q0ZmbVdiZFhZK2x2b0M2YjNmWnFnNWk2OGY1?=
 =?utf-8?B?UzdJVGF4Zzh2VlJGRkZiNUJ4NEZjb2hTQzZtbGh0U0Nqb2NlblovcjNudTEy?=
 =?utf-8?B?dWlnOXFMZStPU2xsMzk0TWZydjQ5VFhNSkxXY095MW93YmVWLzJNcDlQc2Rs?=
 =?utf-8?B?MFB4STBUZFZ4bVliQktzdEkvWkFmVFdrZUJtajFxVkd4N0dLY2x4RjRIUzlo?=
 =?utf-8?Q?r0ZrtxuG/aQ7yP0TZK9mOXwzs=3D?=
X-Microsoft-Antispam-Message-Info: H07faqv8DvTFgJFI+199P14oLZeP2a/eZFJjGxgQWTAFnfBNABBDxptVmA1o34XozALyqvGcp9Rl7eCNCGxMX+egbpEBoLpvLU5ePEhkR2DZh65Nw2NnkdKgoAICKM2kng3ybAhmE4mhnbghGtegF7wWPE2LvzZM8ZKEODYB4uah0wvafFsL9mcXWDV7+uF0T4V68GomRyS/GOeq/66T+q6XWUt1U0hzo4n28yQYjr/VVx8kc5I6o1Hdryz9mRRfs4Ltwwb3OhS0qjNdRlJpMS9tCgcJnBPch8hpecJmDFHH6S2QWbU29mB+p2u+IhTDYzGgsNfz1vp0T4nSvJLu979i7UHSoIDlSV96LStSIts=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2450;6:bbvVZQx7zbyVk7aH0Dn8/PtH4Bv7Z549xRyRHKnhsXlGJRyJ+hIXZJ41B8KaUh4jnRX8Ph9qMfzL7JRBbMmzALND13flRCaXJ8EKcBx6775PycHh3GaFJFC+g2y5qeBVc8Spb92Lku4SNw6J6u804GQk/V54UrxpBrsXh+cyteGpyTtHWt8sMEIOxUjQYuvLUeiQe9cf7GlO5d8VTWwd4Dd8w/takZ0x/lcm4srTNc4PZU99dmBLzSlafhpXWDhzkJAlJVMfHJux+Su6MeziOqH5+rG2uuDM88auAEEcdrmDsFT0q1r52/NP3O1t5/iDi9581a17AUof5KV4bqGrWxM2HsBMIQE1y4gYRp7mVO+6s7vpTS0315N2UwrIuk4Lsic5mlx1XOSUSIlQ7xzoDo5juXpmeOX3fnsUkSt85TSo96EezhnY92iN6LO0Cbw7fG4R2L90+xvnQXN86pon/g==;5:UjIWDFdmhv1yo9QYoPbs0697aH5uJf8q/EX5hheazF/mhCtNSnUMqd7kAQUe4KDmL92qRWrLl5ydGXBmptCNtaYfRoYIA6OGV3PW7fQYhjfsPJydjBzLhxAs7E3UaPKuN/5PsQajspS7wrj11MVb/CTamble5UJmJxn2SZwUBV0=;7:i015wiohQ6YIcudbcjunC0GI/UjA3VIZK958W/XFVCur69Dt7JUDfDGln3qnUU7XIT77UxkOgjwewIP0IHv0RH4ennJ6wzUv6793YlYMPvbGLV4a4Y6+//O9EXkiFlyjWAgA+BaFLUtvB568cyKDM0fBMVgaEpjd8Hs0E+1FTG2cPIFDjrHs1ibPUnq889CC4Mp3XzU0lZc7czi0nTOuOJBZh15fup82VRGSl3KoDYH4sxqCpxZE/gYIB/zZwXMQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2018 00:23:21.8436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eaa1c7c-e902-4bfe-71b6-08d60fa12118
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-01 00:56, Janusz Krzysztofik wrote:
> Most users of get/set array functions iterate consecutive bits of data,
> usually a single integer, while processing array of results obtained
> from, or building an array of values to be passed to those functions.
> Save time wasted on those iterations by changing the functions' API to
> accept bitmaps.
> 
> All current users are updated as well.
> 
> More benefits from the change are expected as soon as planned support
> for accepting/passing those bitmaps directly from/to respective GPIO
> chip callbacks if applicable is implemented.

> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> index 401308e3d036..e28ddc20000d 100644
> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> @@ -22,18 +22,16 @@ struct gpiomux {
>  	struct i2c_mux_gpio_platform_data data;
>  	unsigned gpio_base;
>  	struct gpio_desc **gpios;
> -	int *values;
>  };
>  
>  static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
>  {
> -	int i;
> -
> -	for (i = 0; i < mux->data.n_gpios; i++)
> -		mux->values[i] = (val >> i) & 1;
> +	DECLARE_BITMAP(value_bitmap, mux->data.n_gpios);

Picking a random driver for this comment, it applies to many of them.

I think this creates a VLA? Can't you, for the bit-count, just go with
BITS_PER_TYPE(unsigned)? Or whatever is appropriate for the driver
in question.

Also, I find that where you use DECLARE_BITMAP, the _bitmap suffix is
just noise and I would very much like to zap it.

Cheers,
Peter

> +	
> +	*value_bitmap = val;
>  
>  	gpiod_set_array_value_cansleep(mux->data.n_gpios,
> -				       mux->gpios, mux->values);
> +				       mux->gpios, value_bitmap);
>  }
>  
>  static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)
> @@ -182,15 +180,13 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
>  		return -EPROBE_DEFER;
>  
>  	muxc = i2c_mux_alloc(parent, &pdev->dev, mux->data.n_values,
> -			     mux->data.n_gpios * sizeof(*mux->gpios) +
> -			     mux->data.n_gpios * sizeof(*mux->values), 0,
> +			     mux->data.n_gpios * sizeof(*mux->gpios), 0,
>  			     i2c_mux_gpio_select, NULL);
>  	if (!muxc) {
>  		ret = -ENOMEM;
>  		goto alloc_failed;
>  	}
>  	mux->gpios = muxc->priv;
> -	mux->values = (int *)(mux->gpios + mux->data.n_gpios);
>  	muxc->priv = mux;
>  
>  	platform_set_drvdata(pdev, muxc);
