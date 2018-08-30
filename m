Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B02AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0852073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="nzLlQzEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0852073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeH3Iai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 04:30:38 -0400
Received: from mail-eopbgr10092.outbound.protection.outlook.com ([40.107.1.92]:55372
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbeH3Iah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 04:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18OiKOwoRhwmu3jH2QAmFbnTsBsjqlCNzqWvASJdSP8=;
 b=nzLlQzEQE2kDJOdlS8ZlL21GiMM5KaNWyMO47HR/euQmxa3lWEyEu7MPGVLazfx/8+gsIuvB8r1QnsEZQfkX74RcI4idCFvnA8YY1CtOP3jD1cZgi/hVPUee+BX+0ip71NZOSTmDAZcFx50zbBGd2Fe2Vz0LY4wHbVL4t2lhQNc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 DB6PR0201MB2453.eurprd02.prod.outlook.com (2603:10a6:4:34::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.15; Thu, 30 Aug 2018 04:30:15 +0000
Subject: Re: [PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to
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
References: <20180820234341.5271-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-2-jmkrzyszt@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9d9a4272-9a31-937d-720b-1946930dec09@axentia.se>
Date:   Thu, 30 Aug 2018 06:30:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829204900.19390-2-jmkrzyszt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0018.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::28) To DB6PR0201MB2453.eurprd02.prod.outlook.com
 (2603:10a6:4:34::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd88995d-3e62-4506-11aa-08d60e3149c4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2453;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2453;3:jS+GaeOJIbRXjvXsiaV0o+RQuSr2e0JghyExa4iLB3bXtyVkcd0HOU98RWhAgVmqXnNvdJoozBftxnGoq3ta7HoiDzt+CUZhoXAPK3tNlWVOJObWVjJPFuh8gl9eHjG3GdYbpQgTAUTqEMM794J+8W1J0gRZcnGg+ytqSt9gX57dPHk3mMDqEgr9E0B0IsVlfzUG1ZXUzu3+JjR0+JC9R8IaP7nwmlLhomE3GTwAqvHeLTvn5Oh0+8XNmFs7l8nd;25:mw7kAdHjuVR0TMzQ2cPMzdF3OZgSRUC8i+ZfZTkjDHSyaJeyhamNYccg8lg0z1YP1JBdehgNpCorfN6uEJ9x3lOCS8J+2kuqV3T9ZIHKkPbTTBBWexq+WRqfI/vUsC8pYOAWsfYuYXCpTez4jg7wXjAiJzWPVNvZEdPaTo7oY66n1QKL5muni83nJH10xDCb0P0MyOkYEDci05W2dQEFAfNbkII5GRNTwd/U6xtXLJt1RIC1j6hHDevB+IyZH4tMdIeXXDtNQvqhJz98wLPGejpJ1XVUaN8ppCJ1NwVxOmAPfitvouho8os0S4t5hU2GVpu4TMhCDY1pZzMkzjEgEw==;31:6+KAa67rOGLAPiHHCPDKXXoxr2SJDsYY7qNTJEHblICRFHB7NO7hiXjymTZ4YV5Sc7E9b0kB1QtCYR35IXFAoKPyYM01DEpjuboLOCLyb+l92bmoUgxoD32xnfnK+f0I1r5E8MWsKQ488YiqBwzasF29qZKVe3jXuF9AelE4xdhevPaaFBvYNzKsAM5GBXOhTARAADQaxa+0AdM/BfuwDkbqrXv2+sxhzWj8GqIW6YY=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2453:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB245390DCFA9BAF027841F1F4BC080@DB6PR0201MB2453.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699016);SRVR:DB6PR0201MB2453;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2453;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2453;4:iKCuOaB+D3EfBGLTlMBUW3prqdnFwucJZ25HkCeC0rNyn0hZpghDtJHN1+YAM0MNnn5O9vrkFW13kVvDIs8bAoroaAnU9/YptWxgV4D/IzNmo16mLokaSOb+udyOYy+RMYjd4/epTUJ0Bo+rUpIxZ6IKAxrQRzX7GC+tDTdNAf9mP7unK1R+QyXTYTiCx+M4buN/lvW2yTcF8ODiZ5TKg8RL2Qx9jVQkYXuNeP0mrdkFRIEynwWNvbysOtSduwrt/SHXmP4xmSjPEWo9bL9VyA==
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(346002)(39830400003)(136003)(376002)(189003)(199004)(230700001)(77096007)(7416002)(53936002)(36756003)(6486002)(65826007)(6666003)(64126003)(66066001)(65956001)(65806001)(47776003)(8676002)(14444005)(11346002)(6116002)(486006)(476003)(4326008)(2616005)(446003)(956004)(53546011)(386003)(6246003)(39060400002)(25786009)(117156002)(3260700006)(305945005)(7736002)(3846002)(229853002)(16526019)(26005)(81156014)(5660300001)(31686004)(81166006)(50466002)(8936002)(86362001)(54906003)(110136005)(58126008)(186003)(316002)(31696002)(105586002)(68736007)(106356001)(16576012)(23676004)(76176011)(575784001)(74482002)(97736004)(36916002)(2486003)(2906002)(52146003)(52116002)(478600001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2453;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDFNQjI0NTM7MjM6VU5KdkNDQnhUVVBTSXBLSnAyYVBFczl2?=
 =?utf-8?B?LzdZMjVnTHphNWk5a2NsSXlNc2JMZzgyc0daOGMrODRQUlhSZ0RLVjdGVzlh?=
 =?utf-8?B?TDRFei8rK0VGR3pncWtNSXhkQkRGY1dtUW0velBzd1hxbEpnYWl5a0R6bmdv?=
 =?utf-8?B?eG1wdU9zajdKd1JmQWhSM29wSXAxM3ZBNHpjNU9NbUFadTNCNUdTa3VONjZv?=
 =?utf-8?B?M1RJUGVpZDhmeDF3cXJXbWFBVCtqNkIyclo5cGdrcHQ5a3RZeDZCYS8wUHMr?=
 =?utf-8?B?SlB3bENtT1h4cllpZEMrRm1oZGRPMS85aS95WmNBby85ZU1KZ0h5bnNiUVZE?=
 =?utf-8?B?dDlaTXNQOCtBRDI4TmxDRmltZkdxQnpmYWpHZ2MwYVJPS0xZV05MQi9ycmFv?=
 =?utf-8?B?djBmUEJySnBoSGV4V2xtbE5kQUN5alZybzZ5SzZxQUlKbTROTGlVQ2E5Smhr?=
 =?utf-8?B?SnpvTm5temdlZkVvTVQ4L084VXB3V1hoYVdGdjBaNnpPeUdnaklQcVVhY1JI?=
 =?utf-8?B?eDJQUlBsZ1RaWDkxZG9GSEhrdTdnM2ZHa2NXVjBSdTk2eTdITnJUN1FjOHll?=
 =?utf-8?B?NUFNVzF0SEZuRFJkWGN6ZHBqdnJ1NmhwVnhlaGpFbTNqeGoxZlN6VXcza3RJ?=
 =?utf-8?B?eUpTQzVDQnJ4YVV3YWlPWDdkL2lLOElDSURWRXFzWXA0bkNKZzBZOHZKVita?=
 =?utf-8?B?djNnSUZRQWFzZzRjaVFTN2RWWXB1dGRUUlRKL1BLeDdhTmpKRUl2emdoajRu?=
 =?utf-8?B?YkIzeTZJS3ZxNllBSVl2SkhUNUpkSXFBaU8xeEFLSWdxUm4zMjlFYTF2bTNh?=
 =?utf-8?B?YUdsUjdVckFiNTRrYzNVOWdDTGphWnliN25BdTBMZHozRzlXY3F1bCt3SnNE?=
 =?utf-8?B?QlRIaUNkNURFYkxFOXBUNkVTRi9KdlFOcXFNVDU0QS9XMUZ1ak4ydnhJRU5y?=
 =?utf-8?B?WElhOXQwa1FWcHI3aWlOZTVtYXh3ZS9TbHhsWXpKRnN3KytKa1VIUk1ZZ1pW?=
 =?utf-8?B?eXlWMW50dmJvRDd1UjdWY1VVdTBrYk05NHAwRnM4MGtsRXAxaFZxbStoOGc1?=
 =?utf-8?B?ZU9Ga1hsbXJaUENkaVBmZHBWK01OOXhlc0lOVWRJdmh6TStWbCtRNC94WGVG?=
 =?utf-8?B?UkNEeW8wWFlZZ3owRUNvV25oOWlxb2tkL1Y3bG4zMHNYZlVvclE4MFhZeXE0?=
 =?utf-8?B?SDdWWnNzalVIeEhzL3ZEREZrNU9OYmZDeE55NFZGcXkrbjFWTGNlalIrcDR4?=
 =?utf-8?B?cWdDTUhFa3lFOGZRSFo1OW1QRVJSTXpQL0VTQnVoWUVSdUtjU1phUVJkT1lN?=
 =?utf-8?B?eFNFQXNhbE5tZmZpR1VMS3VweDdvTGF6bE9iTThQNXlRR0xpYTBXcmpnNldT?=
 =?utf-8?B?SEFZM05QRnhiM2MyOEgvdkcyWWlxeE9yRTFRSGRTZ1J4OGRLL2JyMS9mL3lU?=
 =?utf-8?B?cVpRalB6d21IMWtSTTl5M0psbXMrTkVjTWJ2ZnR1UVhFMDF0VTdMUlJjSWZH?=
 =?utf-8?B?bituTlV2UncwdmVLeEZEaDlaQW5OSXIvN0c2OGJkSzdEQTIzRnQ2VWltcTNR?=
 =?utf-8?B?b3hUMjVUaVlPRU5IQkQzZXRVVkxnekFvcmJBd2VCekJDVHVHZXlIUXoxL05G?=
 =?utf-8?B?WXhxZGdKNEZ2amh5cThBT3ppVjFGTjBnbjQ5cFFOckg3eWhadlloS3c2N1h1?=
 =?utf-8?B?clZNNDh6bUo1NHBRSXlpbVppYnQ3aVlQNlVkOHZ3SElQR0NrZUpjamoyamxV?=
 =?utf-8?B?cHZ0SFlQNGVqOHlRSkVCTlF0a09MVUhPaU8zR25zWVEyaElIbzVkYVo4ZldP?=
 =?utf-8?B?YWh0NFpBc3F3TkhTWUF2dS9ROUFWVjRybUtFcWJsYk5hYXBiQWVWN0doSlMz?=
 =?utf-8?B?OVFqMzNscGluYVZHT3B5Yk94aUkvOTlnU01ZZ09RcTh2RldXVzhjcTVKNWkr?=
 =?utf-8?B?OER5TUdpYVFZbHVINVJHYUJsWGRzM0s4K01YenJ1S1BTdno1dC9QQTAvU2NN?=
 =?utf-8?B?NUF3WHhXb1dwNy8raGdETS9zV3h0eWFSaGtqbnhoL1UrS2hJa1JHOHRCcmZs?=
 =?utf-8?B?OTlySWg5MU02dWtwTzJmTTg4dVB3QlNzdGVOUkRVZ3dTK2R2cWhFWHdTekFB?=
 =?utf-8?B?SFVJSURJTlBBT1ZxdXR3UnZSOGVhM1pMSWphblpJUStZWUFaQy9iSjJEWi9x?=
 =?utf-8?B?ZmZlbzVMbnBOU3dXNlptWkFLbnJnQmc9PQ==?=
X-Microsoft-Antispam-Message-Info: vvxslGNGCIxU5mGYWSINPa9W38PZ+FLbh30tGPVWgDUBSxnMOpvhch89A20HJLgY9w2szf4BSRNr4FDccK95E0XWEuW8TRkVfrv0SkLl5TrnxE68wc+GiHuyvh6bfr8X8dH0MT9/zZ48hszUJ4FUJDr3qMYqkj8F6oM2WyXv95Xvl7S/4wbkKzVJLPoJtGCMkew7i1shB5w/gzKhdgDgaO1enyJgXZ5/XWy4xTS874R+uxQIlSVOjqGFfBrCFafp1mRQafAjDn+pTMtx9av5IHuyPkV08VwC30bKFJZ95zPNCExSgQivsTcJc99zxefNTxlFPC9TrvdmBrRa/9tzHK3v8WgevwSEP1dAwEXLB8g=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2453;6:W1kq3Wrb/EFNrBHncDzj2ECQhoLJZXiZsYxhsD5PyKD1ZyULa2Mnb4GdWdURDw8r0net2zFfzIyqFodhOhsIu5z4vajasOas4Pkggp8XPRu4MW1DYtotU55mReUuPFFNJRcp7QRypgA8Pj4nMNwTZJGlp6EAG30110nyrjScrdpayxA3LIQLQblw8J1ixOXdB/2Jm769ZaiXoSKbHAE/gs+OgVnNltnGxls88/BtamUEKeznUDbm9BZRHuHsIlApmSVZ4UlgUqhQ1Ms/Gzb9Wq4dz0BQaCY8rwTJ4jdNWwewc7Nw1AZbh2tB7kU90fggEhkv9ZcZXeB0P2T34G1EDF+GoScJAwdGfBKrlbkNBGKn6j5hpRCMVjaDPyrKs/pTlT/fVmwWqh8psh5Ace+z8AmfJ9VErP+nJx8wizQOa7D2Sko//UGoo5r0De5GRhk85FydlYyBkcRqnVNjOLcuYA==;5:f+XEGOngPYMq0n2mkKZ0dq+vJ1aqn9k8j38ATNhpTNbPkNYRnEhHcGNnCXaYqvM9JnUgXcpmj9zT98V+xmL/C7vdJ57XrKErjl6PwP3KHb7XqqyqpCWky2biNubqe2S/JvcFtVJnvGZ2SAWRqLAWqSOPz953g+IdtcKSvq2tPrU=;7:rf0JnKS+Rw8rtMX3TXE+rYhtItxp1/XBd+9zF+SaU8p1c2bIFEzM/8prJu83+2RW/aScZYMNJA0QD5cPqnAihK5fq+sWSJl3pjAXUsG+TusPZBe+Y5zFRa8yWlMxtwCFT/ihm+En64UKe/WYlgMBzKDSGvSfas38vGT+KiffIphsNyMt531EJ4ziiHChTPSzPCm+7VkvZ8QM07PTU8wR564wtq3usfmXUteZpqcPCfS4QDFbWrggOgP/B0vGhr2S
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 04:30:15.2495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd88995d-3e62-4506-11aa-08d60e3149c4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-29 22:48, Janusz Krzysztofik wrote:
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
> index 401308e3d036..4e36e0eac7a3 100644
> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> @@ -22,18 +22,16 @@ struct gpiomux {
>  	struct i2c_mux_gpio_platform_data data;
>  	unsigned gpio_base;
>  	struct gpio_desc **gpios;
> -	int *values;
> +	int *values; /* FIXME: no longer needed */

That's a half-measure...

>  };
>  
>  static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
>  {
> +	unsigned long value_bitmap[1] = { val, };
>  	int i;

...and i is no longer needed. Hmm, I'd expect a warning about that?

>  
> -	for (i = 0; i < mux->data.n_gpios; i++)
> -		mux->values[i] = (val >> i) & 1;
> -
>  	gpiod_set_array_value_cansleep(mux->data.n_gpios,
> -				       mux->gpios, mux->values);
> +				       mux->gpios, value_bitmap);
>  }
>  
>  static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)
> diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
> index 6fdd9316db8b..734e1b43aed6 100644
> --- a/drivers/mux/gpio.c
> +++ b/drivers/mux/gpio.c
> @@ -17,20 +17,17 @@
>  
>  struct mux_gpio {
>  	struct gpio_descs *gpios;
> -	int *val;
> +	int *val; /* FIXME: no longer needed */
>  };
>  
>  static int mux_gpio_set(struct mux_control *mux, int state)
>  {
>  	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
> +	unsigned long value_bitmap[1] = { state, };
>  	int i;
>  
> -	for (i = 0; i < mux_gpio->gpios->ndescs; i++)
> -		mux_gpio->val[i] = (state >> i) & 1;
> -
>  	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
> -				       mux_gpio->gpios->desc,
> -				       mux_gpio->val);
> +				       mux_gpio->gpios->desc, value_bitmap);
>  
>  	return 0;
>  }

Dito for this driver. Just squash the following and be done with
it, no attribution needed...

With that (for the changes in i2c-mux-gpio.c and mux/gpio.c)

Reviewed-by: Peter Rosin <peda@axentia.se>

Linus, I expect this will will end up in some immutable branch for me
to pick up, in case I need to? Not that I expect further work to clash
in these two drivers, but...

Cheers,
Peter

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 4e36e0eac7a3..06a89a29250a 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -22,13 +22,11 @@ struct gpiomux {
 	struct i2c_mux_gpio_platform_data data;
 	unsigned gpio_base;
 	struct gpio_desc **gpios;
-	int *values; /* FIXME: no longer needed */
 };
 
 static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
 {
 	unsigned long value_bitmap[1] = { val, };
-	int i;
 
 	gpiod_set_array_value_cansleep(mux->data.n_gpios,
 				       mux->gpios, value_bitmap);
@@ -180,15 +178,13 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 
 	muxc = i2c_mux_alloc(parent, &pdev->dev, mux->data.n_values,
-			     mux->data.n_gpios * sizeof(*mux->gpios) +
-			     mux->data.n_gpios * sizeof(*mux->values), 0,
+			     mux->data.n_gpios * sizeof(*mux->gpios), 0,
 			     i2c_mux_gpio_select, NULL);
 	if (!muxc) {
 		ret = -ENOMEM;
 		goto alloc_failed;
 	}
 	mux->gpios = muxc->priv;
-	mux->values = (int *)(mux->gpios + mux->data.n_gpios);
 	muxc->priv = mux;
 
 	platform_set_drvdata(pdev, muxc);
diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index 734e1b43aed6..eb1798677dfd 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -17,14 +17,12 @@
 
 struct mux_gpio {
 	struct gpio_descs *gpios;
-	int *val; /* FIXME: no longer needed */
 };
 
 static int mux_gpio_set(struct mux_control *mux, int state)
 {
 	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
 	unsigned long value_bitmap[1] = { state, };
-	int i;
 
 	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
 				       mux_gpio->gpios->desc, value_bitmap);
@@ -55,13 +53,11 @@ static int mux_gpio_probe(struct platform_device *pdev)
 	if (pins < 0)
 		return pins;
 
-	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_gpio) +
-				       pins * sizeof(*mux_gpio->val));
+	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_gpio));
 	if (IS_ERR(mux_chip))
 		return PTR_ERR(mux_chip);
 
 	mux_gpio = mux_chip_priv(mux_chip);
-	mux_gpio->val = (int *)(mux_gpio + 1);
 	mux_chip->ops = &mux_gpio_ops;
 
 	mux_gpio->gpios = devm_gpiod_get_array(dev, "mux", GPIOD_OUT_LOW);
