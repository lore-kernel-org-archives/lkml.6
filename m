Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DF3C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EF2214FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="udYus3au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EF2214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeHUKIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:08:37 -0400
Received: from mail-eopbgr20112.outbound.protection.outlook.com ([40.107.2.112]:8731
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbeHUKIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4E1Gww2EHl2QSmK2lArdPIHlQx5vQl/zcFjP/U8HyW8=;
 b=udYus3aux9fyUWOOzNe98/x9MUI4WJBh76rb0OQzgWPydi8UYe5yn+ingNxIReXe/MTSYuL1JGVM0iPmYnAq/U4yOXhCBp5KgpT5SDQKt8Tbmg9gX7tJnrjkniSwrk252CrD3giW8qiyb4RhhyD6dJwqWfL+0b/r4a2XHopoDiU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2459.eurprd02.prod.outlook.com (2603:10a6:3:82::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Tue, 21 Aug 2018 06:49:30 +0000
Subject: Re: [RFC RFT PATCH v4 1/4] gpiolib: Pass bitmaps, not integer arrays,
 to get/set array
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
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <0e79bdc3-ca20-6823-c86f-5e9da7dafbc9@axentia.se>
Date:   Tue, 21 Aug 2018 08:49:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820234341.5271-2-jmkrzyszt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::16)
 To HE1PR0201MB2459.eurprd02.prod.outlook.com (2603:10a6:3:82::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5a14a19-4e03-439b-348f-08d607323f64
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;3:rxgkx3kkIWIecjoZtMdHHJ3mmIOP0dzS6ezlafKcwBYOVRI/Ke4BqlhqT4po7UR7VSt8o7uUfcAhJrhM0pH7J2ZUBmo9jq0/v6UD0v5U/KYQ7yP6c8yWQeIa2gb6a8n0XDVVdpjRceSuSs2oNE9XY9nujVk6TV5xnDpTqh2f/AVugbm9ENMAG03+oOUFuDwQ+mxQ+rqj0Ek0PVjpcGK8+VhDh/nrcKdKpAz3RQjwSydchLmQt1tztTa9ZN9//0Qi;25:pW8oMbK61E+gHruPjgKxney5QwPgvHX/JcFDITryy6DH10vNzL4bCz1za7/FTGEwUmz5acPkOIoW/CkVnhMlR2a2ZWCPjeNhctOVYRwFipuY4Q1c8TULjGkV72x3/VvEI27SEfWAgbIUfoLWC4fZzRRnpW3vMAU3OOyaS4pvooH8LtlydBRGjrFIgDcILPiGsjFyxAxw5P3WPZz3HliGyTGyKe17da5o6rGp3uWytIS4j5HSWuWcC3e0kFUOKNMBg3Bluabf1oG9NmAkhkutN3sngIZfg0Y34Uctbx7AeMgGptasuJ3gZClJQ3FSj/ih2X2BQ1lehiSXtXHpcw1kmA==;31:+t/qd6MqqvWYr2syqEv7A4T5DBdvNYPdLD2ewrzSXDQY6cgnzX1aExQ2ZObkM4T72KrSXq2xScqwH6dhNZjHQTFGHP6uvwzhMyPkpHEXD7M9DikORjRfSWWboIusD3oeYRyidH1247sjMY8Inpr8/7+TuRePiMLfenywkUub36uK+Jr9FOTbd2byDIvcqiO/dpWdncRbQjxTpSh5//2fMfyNDWyte9aIjAQ3+tQJYTs=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2459:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB245925144C36BF48E9165ACFBC310@HE1PR0201MB2459.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2459;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;4:+xt5zfdXrYS3HxNHGDdqoTpWmP1Jekgc4Y/jvZVlXktgOZCpj0hs1oCiZPMg9AftoUaoXxFvzDwZ2InDtLXDtaCDPnU2k6DMRZwt4Lk4m4a9o70E4y3o7et05XyFL5jFPMFgDN7OflDJtkIn5zid8dZAchB8g35u4MEHhDQ1+wU0wLnAqDcGm+Kk2lIO5ubSkFIUzNzrZ3oxsR+JUVSACIAqUKg1HxN0ZXr2QCB/DZU8WsAtrAyG+zWpSU8OKNPwW+I/q37ke4DzprbFpum0DIrRCmbfTVbiR8Co42osFhU/y/ojn7qM9MeAUfxwlXBi
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(136003)(376002)(366004)(39830400003)(346002)(199004)(189003)(50466002)(5660300001)(97736004)(68736007)(230700001)(65826007)(86362001)(316002)(106356001)(7416002)(478600001)(58126008)(110136005)(31686004)(16576012)(66066001)(47776003)(65806001)(186003)(65956001)(105586002)(54906003)(16526019)(8676002)(74482002)(6486002)(486006)(229853002)(36756003)(26005)(3260700006)(25786009)(6246003)(77096007)(575784001)(2616005)(53936002)(31696002)(11346002)(7736002)(81156014)(476003)(4326008)(64126003)(305945005)(36916002)(81166006)(217873002)(6116002)(23676004)(76176011)(53546011)(2486003)(39060400002)(6666003)(386003)(2906002)(52146003)(3846002)(446003)(956004)(8936002)(52116002)(117156002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2459;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTk7MjM6Y29pRFRjZTRpRW45ZEdVb25udWZjemZ0?=
 =?utf-8?B?NWNvcG1jU1FyWHdHNjdUNWNMbHZOVGhsbWFDRnNRRzd3Y0dpdDNXRVp3L3Uv?=
 =?utf-8?B?UWZHdHBiSi9KOHNPUVJxWXJRQmF3YUN4VTRHS1JJWkNaUUtJNFozT3cxOU40?=
 =?utf-8?B?QjI5QVhhVmxSZFZDdzNLUlFoMWNMdVk3VTdGSjVqbkhVS2JUU0lFL1M4enZF?=
 =?utf-8?B?QkhIV3ZkQWpqL2UwOHpybks0VXhGaW41b1dqQ0ZJakpQUkt2endpL2N6Q0pV?=
 =?utf-8?B?UXVFN28xdTh3Z2gxYW4vN1pJVk9xeDFEWTFIZHpZZlNwdjhuREpPV1ZzOFlm?=
 =?utf-8?B?RVc3R1gwSlZyR1FjODFPL1VIclVtVU4vM1FzUEdsck5LaEJIV0dHd0g1Mlk1?=
 =?utf-8?B?eXhMbU5RZyt4NFVhUGQrNTZLczFHR2E1S1FzSDlEV3grUWIzM3lLdjUybWNQ?=
 =?utf-8?B?ZjlvOG9rRXpMVStHSzV6UXZIYktZZFpXOUlOZEN3cUFBLzM0NG1ISmpHNmN2?=
 =?utf-8?B?bnpRUE9GSm9YcHp4KzVDelQ3MlJJbVNBRXptMzZHWUNtaXR6UlFtdk9QZnBw?=
 =?utf-8?B?cmpPY0VJQmRWeW0vWnVsTTdUUVlLbVB0UHpaM0FOTXR5NzN4TW8wTmtwbFln?=
 =?utf-8?B?ZFNtWDhlU1lLVGg0Nk4rK2tDMXgrYnovMk4zNy9UMlUvWm1SeFJZanFvWkVq?=
 =?utf-8?B?eEVFU3FoR2NIMENkOXFjS214NVp2V1QvWkd5U2R0NCsrMHZNWUlRVUNTTDVp?=
 =?utf-8?B?TW5BQ1dQK0xOdW1uSmM2ekcwMlZyNjVPdHRXeGZGMFFlbGJkNERkb0QzTkty?=
 =?utf-8?B?Qzl1RHI3Q29ITzF5bFFXeVl6UHJ3enREbXJRVzJWclFsNW93YS95SkQwVndS?=
 =?utf-8?B?dHhkY3kxaVJjNExsUlhjOU9RYUdYc1htZzhMTThXZ1FsUC83aVJ6Sk8xZWZi?=
 =?utf-8?B?NUhIWXJ0NXVadFFmMUpyYmZrc01sUkNhQWRvWDdzZWUyZmVubkRuMXhNcitL?=
 =?utf-8?B?blFuV1JsVkxHcXlZREpyaXFGRXYzRWpHc0N0c2N1ME1RM0tPYnIreHhTbk1G?=
 =?utf-8?B?am5XVE5rNzZZYXZsalpwR3BSeVYrRXRhcTNZRlpXUzRycUVadDk0SHVLaEk1?=
 =?utf-8?B?eTAwUTdSSDQxbVExU0NtVDgxSXNTL3I2YThKK2Q5RGdObzFrNHJ1MGFLZGRX?=
 =?utf-8?B?OGdQY0xZM1pHMnlpa2NQdEJXUlNzYW90ZWY3UkVNcWRFVU5rR0ZxR1JSaUdr?=
 =?utf-8?B?blNpSUp5V3cyYlBmd1Fobm9tME40bURnT0JpZXVNMGIyR3hQRWpTRkh4dmJr?=
 =?utf-8?B?cFdYVzhublpsaUhKTlR1cTRDMW9BVXJ5MlhRaUtGcVhreDdyaTdhNDlDOXlo?=
 =?utf-8?B?QW1EUDBaWDFsS1M4SWJPN1dZRjVsL3BpNmQ3TkhsT0F5ZkxWUURNWEZKVHVs?=
 =?utf-8?B?SS9RaXJWelVqMC94bWhIK0JUMEIxL3QzVmMraGVGcFFzcnlzb2cwcnUrejZp?=
 =?utf-8?B?ZVdjVWtKbGVFZk5Jc2xqeUo3MWhoazNuMm8ybUk2MXFQeUErYnpMTE5CNURi?=
 =?utf-8?B?NnV3NTd4ell5WDIyL3NGeC9mQUJtMFpxNkZiYTZRd2hTYjJKQkVhQmlZU3Qv?=
 =?utf-8?B?b2pvR1dGSFM0SFUwQ2RCSnBqMDVTNFliWVRWUURta3Q3SXBudmJRaUdTUTR0?=
 =?utf-8?B?cFVJWEdSVkNSL0RXR3c5UzRMU1QvSGl4NzRCYXFvWktGR3BiREhwQjRKcmEx?=
 =?utf-8?B?TXRWL054K0JxaGR3UUxDbGpXc0M3WFZrOTFjUGJia0hnK3UvbWRrWHRCN0Y5?=
 =?utf-8?B?cDBoaXNTeDRCKzNuZGY3YTZYY3I5TXNZSFJsUkhkbjl1d1ZiRDhYMGVsSHlJ?=
 =?utf-8?B?TStHc2I0Nzd1RUswRlJDTVNBK24yQzdreStGZm51alVTNEJSaG5DbDlQN2ZS?=
 =?utf-8?B?a08vRUQyVTVLYU54VVZyVExtS2tvYUxlMVAyZGRzdVUyMEhzRkNaN1owSmwy?=
 =?utf-8?B?NGZKNVJrcmVUWllmRU1CL2NLbGN5NkpnMitvTyt1dGhBOGlGb0VXaUdsWkhL?=
 =?utf-8?B?NXdGZm42dUkxRlRZOFpuT3VuYmgvejdkNkxDS0QvcjFJNVNqcWRYZFA4VFhi?=
 =?utf-8?B?MzBxWXZ1cEYwUmNudmN5NzNLL0RReEU0ZzNSTTBPd2szWUlhY3ZycFN3TXFw?=
 =?utf-8?Q?IN4YgnvAWYdn67D8mIb4GPN4CekMvGmcLxFj20Hrf95c=3D?=
X-Microsoft-Antispam-Message-Info: HDVCSEoADxpzaFT/s4rIGuNEavZC25Y/1fQ4pvI5Z3fudCXVmnGIbJZNiv74XrhCNTPs7rsIUePYsQk0LHSnnB2qEAH5Ql93CkaGWtLU3cLkjpTcOyd05qod1eZNTlKI/6Vs0RsXvDVgpJ2Njlf14mgWDum2uMyqmpNw3qar994vh7JCoHgRugQXSXansMYkhKUgkFk3jyuAnWxUSPWWPTKa0C91WzpeqstBxI5kZnSwblLN1kLzhURFIZEGSajj07bS9neWiN7USX51Ul8tFNarNQwu2ETkPkmbwzenxdoQpq8TdgjXWdX3O7JsX9DJ1v14cOL8ccOWgOPLtuUFixlfMUJKdw1LZ6NYCiBKl4M=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;6:fStb6OnH3aQ3v3Anotl7ToNEOZXA1IQ0PGvGiFSlG+N44XOeKsTsf1pSvRfeyZyxYNE8tr3dBmjeTkJjx60CoSi2SH9BUxtsReStUGBN9BFmYuJFnkWMqP0BB1kCRFxf76S4spApIkb0WrPIa/WEdZTeRef7JAaLf++aDIdUUFRSPDozRkfHFZwWlKsotCYUAqn6l2VmKO0kJDfLIo5ICkI/nyOoqS399gKoNtA67KqjCZy1sjl7zkEhhCrAwyr8rjuJZYzX3njgEI7Pcq4ytE3kA92ctgYYGFeLWlgIRWzJuYt+z73g4qYfxuJnzjGiUWkcasXNzmKiCTL3UI24XK0Kwba9Cd4JVqCQMFBV1ru/E73b0jzNzTfND0YBgLGUqNAXxQyKOKrIk7KdfRWE8WfvazELGIoo3Bx0meaEDmKUUwBDia/7TO1UWiOYmt1chWmOfklL8wPBUZBlvi6Hxg==;5:RZDSVWm3WeOZkzl2lBUaSfR2B28wMxoaKz7WGmocP8P4qwbr8vHG2DRLSFKYUatE8UYLWsN7GFwKMBXg0tKU+CeICmTpdFIwh7x7364yN/2/Xv67H6fKcY2iZJveFt0+wmkThq9DRgVz4dwWjbcTYWwv/oG5pF29OnKBQdC07cI=;7:qoCYddMWEQkwmmN4IIPP+meaB8tV+XYJy+KxEsxDL05pZiqw7s/7MFe9W66KdTRVwCZYOb1k73BEVkGTtPFsZhyyTOy4g21LwhKqRqLpCJE5xTdM85/mNlFpTb/EXJSisHPjGs7mjJy+RVk80J5Yumisvul7Piu6YhbCxU3iysJpdXfyKkenHbbSZUAIdFXD6Ray5koaUGCxxV1FEoV2oceVd25OQbtmhkRnFMjjVQwB+MUoO4PQ7+UYHqoaLCKJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 06:49:30.6069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a14a19-4e03-439b-348f-08d607323f64
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-21 01:43, Janusz Krzysztofik wrote:
> Most users of get/set array functions iterate consecutive bits of data,
> usually a single integer, while or processing array of results obtained
> from or building an array of values to be passed to those functions.
> Save time wasted on those iterations by changing the functions' API to
> accept bitmaps.
> 
> All current users are updated as well.
> 
> More benefits from the change are expected as soon as planned support
> for accepting/passing those bitmaps directly from/to respective GPIO
> chip callbacks if applicable is implemented.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  Documentation/driver-api/gpio/consumer.rst  | 22 ++++----
>  drivers/auxdisplay/hd44780.c                | 52 +++++++++--------
>  drivers/bus/ts-nbus.c                       | 19 ++-----
>  drivers/gpio/gpio-max3191x.c                | 17 +++---
>  drivers/gpio/gpiolib.c                      | 86 +++++++++++++++--------------
>  drivers/gpio/gpiolib.h                      |  4 +-
>  drivers/i2c/muxes/i2c-mux-gpio.c            |  3 +-
>  drivers/mmc/core/pwrseq_simple.c            | 13 ++---
>  drivers/mux/gpio.c                          |  4 +-
>  drivers/net/phy/mdio-mux-gpio.c             |  3 +-
>  drivers/pcmcia/soc_common.c                 | 11 ++--
>  drivers/phy/motorola/phy-mapphone-mdm6600.c | 17 +++---
>  drivers/staging/iio/adc/ad7606.c            |  9 +--
>  drivers/tty/serial/serial_mctrl_gpio.c      |  7 ++-
>  include/linux/gpio/consumer.h               | 18 +++---
>  15 files changed, 138 insertions(+), 147 deletions(-)
> 

*snip*

> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> index 401308e3d036..d675e0ca2fa4 100644
> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> @@ -27,13 +27,14 @@ struct gpiomux {
>  
>  static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
>  {
> +	unsigned long value_bitmap[1] = { val, };
>  	int i;
>  
>  	for (i = 0; i < mux->data.n_gpios; i++)
>  		mux->values[i] = (val >> i) & 1;
>  
>  	gpiod_set_array_value_cansleep(mux->data.n_gpios,
> -				       mux->gpios, mux->values);
> +				       mux->gpios, value_bitmap);
>  }
>  
>  static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)

Please take the opportunity to completely get rid of the values member
in struct mux_gpio. It no longer serves any purpose.

*snip*

> diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
> index 6fdd9316db8b..cc2d5f50472a 100644
> --- a/drivers/mux/gpio.c
> +++ b/drivers/mux/gpio.c
> @@ -23,14 +23,14 @@ struct mux_gpio {
>  static int mux_gpio_set(struct mux_control *mux, int state)
>  {
>  	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
> +	unsigned long value_bitmap[1] = { state, };
>  	int i;
>  
>  	for (i = 0; i < mux_gpio->gpios->ndescs; i++)
>  		mux_gpio->val[i] = (state >> i) & 1;
>  
>  	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
> -				       mux_gpio->gpios->desc,
> -				       mux_gpio->val);
> +				       mux_gpio->gpios->desc, value_bitmap);
>  
>  	return 0;
>  }

Dito (but the member name is val).

*snip*

Cheers,
Peter
