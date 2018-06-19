Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7161C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A9520693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="mwbXHeJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A9520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967261AbeFSVaV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:30:21 -0400
Received: from mail-eopbgr50127.outbound.protection.outlook.com ([40.107.5.127]:55107
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756803AbeFSVaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxx3+znrExbH6ZdD40itVVWfrXqR1wNISvuxOqNe91U=;
 b=mwbXHeJwIB+jjT6wWg5VQx7nm3iiIb7krYdZEyVdP9WnTa6o3voYlaeimDBR5g56V/EyJZoWpaTxcMZ8U49OeITaQRZuXEpg6wtKo7pnjkHq6sETRUK5Dtho2yzNkHuSKMSy/q1rgi+061mPwDDTDRqHvDeo+W/ftL2pWLkZFPk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2457.eurprd02.prod.outlook.com (2603:10a6:3:81::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Tue, 19 Jun 2018 21:29:55 +0000
Subject: Re: [PATCH 01/11] i2c: add helpers for locking the I2C segment
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-integrity@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20180615101506.8012-1-peda@axentia.se>
 <20180615101506.8012-2-peda@axentia.se>
 <20180618110502.cb5s24srp4frahm6@ninjato>
 <b860025e-3d4b-f333-80b4-3831dd969757@axentia.se>
 <20180618115444.pgjmfntp767zuvmw@ninjato>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <4a721b58-d718-68c0-cca5-23b5b21ef100@axentia.se>
Date:   Tue, 19 Jun 2018 23:29:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618115444.pgjmfntp767zuvmw@ninjato>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0031.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::20)
 To HE1PR0201MB2457.eurprd02.prod.outlook.com (2603:10a6:3:81::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c52e6af7-0842-41c9-7366-08d5d62bcd69
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2457;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;3:7wUhcz/JoDxnIIfQ8L/s6lTeDHCZKQIwi4E9sksQhr7c/LHjd2ZbxedybsA1IAclblQzqSrENDFXpZIQmt909nGs68A4FwZzpqnkOiRU/h+pmP1/CKqzqJkx/BvvLCuBJ1Z9j9YeGfTWzX/9RotP7mX0mMNzSCFajNi0IhezAxkluvDWJgqIddFwqSYVYAUw1ci6AE52DtOoZnD8Ut5dOSzJkqdNKWw5K8tHdl34o3EUnbCgvOPHoOgquKeqxvCF;25:kngVfVGV/hWM10rciOkImSVoYz1UAE7THpVkIF5GJw0C0hxeu70JPnD16a9d9qtc54NZcPGlyC/G0w83Hzq6s9Rp9193a9JwbXBbilmyaYCDA7ZO6UAyP8kaaphw0YGJeWwm44mKy531pWHLam+nS3wgipwKUpJyxaNiAPwJ4yMtiIitcJF35xxPsH1YrDfKSF+7jcwVu3HJGJwSLZ8vN8czs9j7vMLOOBnc4P4rpTFvNXZcv7ON5qb7KX4Qbo0czC6taW3Dhk/3xrucfn2/uWp8ZrwXzhdYTeEIfoiunm3QExy7x4oTdCL1siD4+jeWPVgm6YYTISr9F1pqqsm/VQ==;31:u3nwcnZ/JgO7wvuRr2xq0CyqjYDB/i1ftezFt0vh+CNnGSjVu51lBrG5oe9thsdgu5iu3BGvkFJiifoR3io3qPyv8olRYkJ+vdA4aj0KlOGbMBVHqpWalvaZOvk4CCedofbGnSyBEtNlIolaowhUZUNsssAvyNi9DjFUAquKWFmPwAiT4kysgJnd3L36aAZNJ4+FfMfoqxCknw7QdUNkpUZCkc5pcpF39xRzFnEDUCE=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2457:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2457A08FB274639F6C03698ABC700@HE1PR0201MB2457.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0201MB2457;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2457;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;4:td+B62iROEt7ZAsM4YklKk+BR18vcQf6eWqTWDJgr+XdEW9YGZLkYta+FeRzGyEMh9YhnnfJqKM7zEBKaYYL0ZzVRnfhPhUn79AO+AwG6Hl85fCfg6ZP2uBcqBnbo0z4jJfgiDguQgtouSzwyRMNImpCNfZIB6P4SlrVQVTpzmKrbYpe83EtsIJPOIEtKyoPjgJjIB0h5RhxCvh8z0JabfDwf//WSBKn/LN5FOcYU4x7ypYUPYBdlsbMwFg0NZ1HlmwuW29LASiHUlOmdXJJaA==
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(366004)(39380400002)(39830400003)(396003)(51444003)(54094003)(199004)(189003)(31696002)(86362001)(6116002)(2906002)(74482002)(117156002)(8676002)(81166006)(81156014)(186003)(478600001)(77096007)(50466002)(68736007)(52116002)(8936002)(59450400001)(386003)(53546011)(36916002)(97736004)(76176011)(16526019)(26005)(230700001)(6916009)(6666003)(3846002)(93886005)(7406005)(229853002)(106356001)(65956001)(7416002)(8666007)(58126008)(446003)(5660300001)(6246003)(476003)(23746002)(11346002)(66066001)(39060400002)(31686004)(305945005)(64126003)(486006)(65826007)(16576012)(36756003)(316002)(65806001)(4326008)(25786009)(3260700006)(105586002)(47776003)(7736002)(2616005)(6486002)(956004)(53936002)(54906003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2457;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;HE1PR0201MB2457;23:2dzZ5OsXuvxI1Pb2iB2dn64t7IIlVIlzU2l?=
 =?Windows-1252?Q?+x7jnByz6NnanqSOHJ+VPhVQrSqqCq9vf9FZCJ4PL44hCNQR0OlibjQr?=
 =?Windows-1252?Q?zhgrZ0QSrm1E1w3/iv9xHRh8k7mtd7Zzxh/0CzTreYz8l0J1BXQgp1Ze?=
 =?Windows-1252?Q?pxNAlEpIK9TJh2fAcPFwT97YUeYMHlaZArYxn1u7GhWCfZxaU/5sbYKW?=
 =?Windows-1252?Q?+zJSK8ehhMS10ktngy/lJQXKwqHLIcDlItSrIWTNrWRBnY06xg3Sejou?=
 =?Windows-1252?Q?mjlpSPX00zbXTq27zTMyFT+5j97T7Tb8CP5Qdw3DIC0gpamasEcXJcqL?=
 =?Windows-1252?Q?NChNwQPz867PQpSQr8ngbqqtWjnn7DTu9pBP3aOwMGNhEuX2DSNjgREm?=
 =?Windows-1252?Q?pOkEk0vlaKrtcPDNd0T9LSJ7AEa9fpefaKd2VQmjzT8WBaILOR/Xq6Mh?=
 =?Windows-1252?Q?pEyumdlBZ+sfNyE2Nx/ukIHA8EB2bUXk/VR/tcehqmh6ZxrwkFqC3/aU?=
 =?Windows-1252?Q?+hB0K45mX24Wn+BC51wOo/ce7xbm9OfSHcPOVWSt/Q/tTAsbWTpky+VO?=
 =?Windows-1252?Q?b0Jb7IqKwb52pHe2naB9iHDwhkGTUukoLLYgyA01Fxktxad6iJmT7pN6?=
 =?Windows-1252?Q?u615Bpdr9GpOs2sbEPKBqsZVkyUACRAYDJx3jl+Ow0OcyN/EY8V0xaBI?=
 =?Windows-1252?Q?Jhpwx9LUAFSgvOasp+vcOvyiVEwtRnolQ6MHtHMDG30zG3yht5hpv+cy?=
 =?Windows-1252?Q?XLGikQvBrzzGR4J+ryPsVFQVC1bASS3mf7+nR3s26GWHk6uZft3wtWQD?=
 =?Windows-1252?Q?mXehEgpeZDxmwxsa3eqNV91xmDrDzgarGKp/En6Jp1pBxM6IKlnkdmzz?=
 =?Windows-1252?Q?kY3+BuS43Oa0r6UKOwuu6w3CWBJ2TXctRuNtbo0f+uili4kkg6jGQ/5b?=
 =?Windows-1252?Q?Jtlc87K6ZhHWduhMBbKanDmZge7Wyt3k1v2OKBnA7t6xXCKyfzZyiEPv?=
 =?Windows-1252?Q?ezUDNsZ7AmfX3bayB1YHHbuOaHgaHbE3NVCmVGGgx5py/CF026y9Fj7r?=
 =?Windows-1252?Q?/V/3XcrCPBQ6unAIN86S/4Wx38DqU3YFFKjVBpLGUmdlNvvwOd9t8hvR?=
 =?Windows-1252?Q?06HJPFGYSqdAivgvu/4C3WSDgrq95zTNoudMwGsB5rC07kRxYZKrZtVd?=
 =?Windows-1252?Q?s+2il6xjVlefz1yUK9+sLJKiDEMSzzc58RVLpsLuOiKocbBzdcdCrcGn?=
 =?Windows-1252?Q?xoGhRPBLq4NDoVgfu0cf/mXz/RVMIMdoYvps61nGADZ4bfp/BX5FCj+I?=
 =?Windows-1252?Q?0r3QlcEWPr+QshtEG3CmqpjEKRRXIltZ3i8AP59hC1WC1RE3v7oZ/bNf?=
 =?Windows-1252?Q?mtNUlKcJSmNd5KfqYzX/Zw8QKXZR4IFED1e2a1OkCarAX4GeHLT+QS5g?=
 =?Windows-1252?Q?MLgb3I/H8dWWXfwHSIe5K+sB/6sM+A8hskslDFP4psl+RWpWiJgyhPB7?=
 =?Windows-1252?Q?NzE19LceN4zQzOzDOWbgxE0ud+OyYX/zKi/S+CgRTTLyJsH77dXMj1or?=
 =?Windows-1252?Q?wNUn9gOrao04LhtoRPMishM0qtfk2jY5iMa+6uuDDsZ8uKPSJc7uJQaL?=
 =?Windows-1252?Q?ZmOOpCF9ZOLym2Ide7nO7p1otYpSpDoNzi/HJUO7mlgNbfu8wkM7z/D+?=
 =?Windows-1252?Q?MgXXV9+Es4GnRck3OO2lbylG3ffmRnogIegGbd7NmEkm83u0gLzwN+ai?=
 =?Windows-1252?Q?ktdqFtZ2iJJrVbq5sClrdXg1kSldN2B08n+zXCUkE7xmYkgy1S15OBJb?=
 =?Windows-1252?Q?KdbOcfUdbYf/l2+mvwQexnX5AXQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: zLjeJjeo0hP1lxu00wnBeJ1q1YX0Qwbd38GMrnPR478TtMJ8jgStQZ7tHJBtRYgilZJ8ryhdW7mSX967ju0Fp2jVEmsMezsLxNLRUMl+uwbOiVNnW9x2YFgtxiWubHNP3mE9bv2tuvxway9VeiDApY7gzF2Yfxsy+QnWx3zpCDP/i5z1XgmXS6Mv/tSmSbZ7ra+piWWheqh+FILvBAdLOzojlPSzqdVUMm/7x6+S41yaIuoBNx2FhNpjeIJmTF28OYfYtmkjeNhWl/Rm1bTg9sLIMzIEbwhL0cvPMecCYneUogBSlHTugc1FA2GReQCF93q74RtxfvTY9WBxAirc4w==
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;6:Wkh2KqZRMMNp3iyitm6bKu2f/fidk+EqmQEzRNQ9U347j607c4GhAcFZYa2qamp1lnYhS1aPPwCxejUg1Y8em+AdGjbTeu2ZZmPFstk0cw5Lc9x0IEwEUO/UZm+kh3RvYIJIeiGmELgdmohD8ylvma8JhxCbw/kDo8Con+DZUbNgCyO9soTpfMXp2QYYAX2LnEZcr2CjXgx1dWxpXwe/EYal8wcmboHSVdS91WB0YqErHijzKF2TvWxL6pm5bK3WUWMUNQDiYbyqKn6qPP1t5vhl5paEckSzIAMd8XGSTkPAeRCirccVFCTCANygYuJEh/DBdAduewf/L5A77KQTfWK6jQSierdTHlavzz3I7nZx9PQjM/q2VF8Rylyo4g3nPeL7p7znbhIuK+TnPylM0TfEuOjoFa/nkhhXS3KFBz43kavY2evMh3cSc21yxbYqIaIzNqncyNhOZ6hvqyBIUQ==;5:BN1Jvt/VcA480SZAVI3CkqtX47Cl2jaouOIX5hO3Oh3J/0OLqRHAwBQPKtTYairhXGHF1kVRS11mQVEzWl2PSu5KCxXyPSje3HWKjddcl6QrcbEe0ROcnXzL6oG3wLgry92QdXmh9pEUWuRdYoPOJdz+qbv+mxqoqfsRDyz1ds8=;24:kpYLAfb44V0Lo70AcSStsn/JQ3l6GA/ufbKuPwmfMdGNcq2AJhd9lQxS4g6QuMCLCYeiie0LDiVvU1VivTpBuX6jffZE/I4821LSsugOd48=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;7:Jal9ZfCc7xR8pbjFAlzIAEa2xo1Y23qgYI+1bLuiLQLJ2PwlYoRxhoNacpkToh1mI9zO34yAiSSTotBmIHz4LIu/CvQgjHeueR9CVMEJln3O2guBOzf+F7BBOfuaflm8vmxoqw6mQtMiDau1LAPsTw1j9NYGkf/DS5a8OCG0xGOugzPvxgfjVBli4ekwkAfM3jdISHF0DCTRs4sd5WXNDO++bTvud9pL1lCgZGRwRI1877pmEjFJe3qZ6aIDPk2Y
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 21:29:55.0502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c52e6af7-0842-41c9-7366-08d5d62bcd69
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-18 13:54, Wolfram Sang wrote:
> 
>>> I wonder if i2c_lock_segment() and i2c_lock_root_adapter() are really
>>> more readable and convenient than i2c_lock_bus() with the flag. I think
>>> the flags have speaking names, too.
>>>
>>> Is that an idea to remove these functions altogether and start using
>>> i2c_lock_bus()?
>>
>> That would be fine with me. I don't have a strong opinion and agree that
>> both are readable enough...
>>
>> It would make for a reduction of the number of lines so that's nice, but
>> the macro in drivers/i2c/busses/i2c-gpio.c (patch 11) would not fit in
>> the current \-width (or whatever you'd call that line of backslashes to
>> the right in a multi-line macro).
>>
>> Does anyone have a strong opinion?
> 
> I have a strong opinion on making i2c.h less bloated. And yes, less
> number of lines is nice, too. I think that surely pays off the
> whitespace exception.

Ok, I have rebased onto v4.18-rc1, killed the i2c-tegra hunk and converted
i2c_lock_root(foo) over to i2c_lock_bus(foo, I2C_LOCK_ROOT_ADAPTER) and
i2c_lock_segment(foo) over to i2c_lock_bus(foo, I2C_LOCK_SEGMENT). And I
of course killed a bunch of locking helpers in i2c.h.

I doing build tests now, will post a v2 in the morning.

Cheers,
Peter
