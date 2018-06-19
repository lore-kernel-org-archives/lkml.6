Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1362C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5156020883
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="kuCdUIZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5156020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966110AbeFSNGP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:06:15 -0400
Received: from mail-eopbgr10120.outbound.protection.outlook.com ([40.107.1.120]:22368
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965740AbeFSNGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYViSZ41v0T6qbPQOpHaHaWpBbhLsqjvTTO1h/3mrqo=;
 b=kuCdUIZeFgfXBJH8BC62hxpwaXwf18R3PdHRcaujdf9K5/wjzwAjTxBs2Nf+432poze6i8l56uPvfHAhe1x+I7WEuxFpqSpa1/Ricd2mzK2g+JqZXnG1AUEnypti16CsmuRBXuROc7f8NTnqNDQ15+hS8W/AbqPR875wEMhrArc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2462.eurprd02.prod.outlook.com (2603:10a6:800:54::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Tue, 19 Jun
 2018 13:06:01 +0000
Subject: Re: [PATCH 02/11] tpm/tpm_i2c_infineon: switch to i2c_lock_segment
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
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
        Wolfram Sang <wsa@the-dreams.de>,
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
 <20180615101506.8012-3-peda@axentia.se>
 <20180619125618.GB5609@linux.intel.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <eb583028-dfcb-7f1b-c2a1-236ad4c5c2b5@axentia.se>
Date:   Tue, 19 Jun 2018 15:05:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619125618.GB5609@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0401CA0068.eurprd04.prod.outlook.com
 (2603:10a6:3:19::36) To VI1PR0201MB2462.eurprd02.prod.outlook.com
 (2603:10a6:800:54::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8f99beb-be5b-4a66-632f-08d5d5e569ec
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;3:VcR6PhPJnIuKNMX5EYq9eFSoJY0x+xNyqOnheCJ+B61Ylc1v7Uxo1AfkVTCo0yhXK1E0dK0d4n8kG6o0iKWV8Oa8pDRxMKvMo3Ojj8rm+QpG0ve3cUL9b7UYaWAxCq3G8ferkSSMlwO0ATIYzsC/htxsBfokokYxenlpM7OL1hzoGyAJdhtGq26U9WwYG3XEI3CIi4sdnq4JNpqFGOAR1sBUNBlduGtHoxskhrJn54ubDqNvAYubcXryZ6d9gzfo;25:R1/whu3cyIJtcAnBRvdfmNwYCH5xhr0O9VTc2JmeW5dbZy47ycYwCTOxKu1dU/V5xr4VMisi+LpP5H0ZJoG4O/kb/SPvy1mdZHRjPnfqjGeUmfhuvJjDbwA3XwdB7KyZsRTGLWtlkh76XhZBfPXS+0AQrUzBYf5vgEObR03KCIjopcOyQgQdPgTLNJke8HvG510nwiK3yjSxbX0i7GNgG7KpbBGNH+vpz1uNR2O4L4c9VzwDk4mykI9EBbxS5j10WQCN62tvLXDlqxd8TfQwU2j1VwKXAJgN/j2bbP6MoHURxiizouWvFlFwfYE80o/DYT9q2M7FCRqbD6U4dLBWyg==;31:M4KcC2OD1Y7PBvj90OiOoVQaR1r6vNRvxciYMRczUez0W+ng5B86JFw8/ra7/dkkr0CxBRMU/ISd3Iqov1HXLhu0WawJSHONH8SZNpzpShgekQ0sr9C5PVrQ/4FQrszfw5GyS0ppdbJxa4UviS/pxBASDKaCvtpUtPc8v4CFDEl6BtjukD+YLG95CYp6DiyjQcUtxRFIebsiICWBhUWBigGUCK7/OAwd+fVqIBrdN/s=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2462:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2462532F8194645303CD3665BC700@VI1PR0201MB2462.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2462;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;4:+Xqkii/diOnTmjwaJArxPxlA8drDJVNW6ei6CqOEUE6uWhgj1qZjCSSUf389PYmdkwQDezF6SpmOTfYEPIrlh9z9/h/Y0UuE45JFdoi9du/tsieIzRISb7qHEe5n7wIwVAaZh2Ft+xB1gTREuQGkIkaSfqUYVrJZ6mtpjZu7BDp/etWmOK8mNoW4dmlmN4J13CGXKwyy12pIXWNTKt5qjwH2HgVoegfKj4r7EUd6o5IHMen6X0CxuMPfWQsVZW/d3fbNzFg4xRfxApjdmCitXg==
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(346002)(376002)(39830400003)(39380400002)(199004)(189003)(105586002)(68736007)(64126003)(7406005)(65826007)(5660300001)(47776003)(31696002)(7736002)(7416002)(97736004)(305945005)(66066001)(65806001)(65956001)(31686004)(81156014)(50466002)(81166006)(8676002)(106356001)(230700001)(8936002)(86362001)(6116002)(3846002)(2906002)(486006)(6246003)(39060400002)(117156002)(36756003)(478600001)(53936002)(3260700006)(25786009)(16576012)(4326008)(74482002)(446003)(956004)(2616005)(476003)(11346002)(386003)(54906003)(59450400001)(15760500003)(52116002)(58126008)(26005)(76176011)(6916009)(316002)(52146003)(186003)(2486003)(36916002)(229853002)(6486002)(53546011)(77096007)(8666007)(23676004)(16526019)(6666003)(70780200001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2462;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjI7MjM6K09Rck1YRVhCMW9YMHM2TldQN3lscUdx?=
 =?utf-8?B?bmo2aDlsVy93MThVNFRlMDlaVmU3bGR6NUlTRTQ2RTlaZ1E0VFZFUGRxZDVP?=
 =?utf-8?B?L0x1YUZaWW9wVlBPUTlDdGJBK1BjSU5HdnlhOCs1L0w3dEpnb1cwMnJqeVlD?=
 =?utf-8?B?NFljcnZoUFhVMFA0Vm5KV0tzVHlYa3FZcWQ5QUtUdzlRZDIvVUM4Q3ZLNFNR?=
 =?utf-8?B?YmtEM3BDRGNQLy9RYlhxWXUxaXNYU2JWNlRqaUZSRWtyWEd4L3JmVEphOFRB?=
 =?utf-8?B?RmRpazVuSGRhdmNSelVTKytLaG9LbGFaQ08xNUVCSWJXdDBmY2ZlYksrYWtw?=
 =?utf-8?B?Y1k5Yy84VktsUW93c2RLUjdhc3l5SWhvT0xFVno2SERuQjFVcmd3VnZ3MXNQ?=
 =?utf-8?B?Z1NjbHBHZFBUaWtKV2tBb1k3ZmJpaGtwL2E4Nzlvc1FtU1VTODl4NGhZNldo?=
 =?utf-8?B?QkpVVUtTUU8wMmhHN3FkK0Q1RzdtSVNhaWx0WGt1djJlUkRORXMzekxjUHEv?=
 =?utf-8?B?eHBDczBYV0R2T01PMExmU2ZmMHAwQTdwNnBCendqS3h1c201Qjc5QVlHU09F?=
 =?utf-8?B?MGlQN29PRVU0MW9ISXlrVjVhdCt2MFlMN0w4ODZxczVEZHBid21VaGhiRmJ5?=
 =?utf-8?B?cVp6NVVVVU5MVHJKaHJqazZkR2tjS2RQcFp5cXZqakZiQUNrMjc5NExIbXZ4?=
 =?utf-8?B?UnZQNlM4WDVMSmd4UGlOZUtycmpGeW0wWGMyaDZhK1YwcFBZU1VCUU52SW9v?=
 =?utf-8?B?dXRYME5jK1RnOEY0QXhNVkNrN3o1VVFjemkwcTYraElSeVNEdkdlZTNpRGtt?=
 =?utf-8?B?THZjRTc3SXdaMUova3MzSCsvdjR1bnR2OWo5dHdmTW5KaU5RNU94Q0U5YXBL?=
 =?utf-8?B?SDJnMUx3NUxscnlvdUNYVTNNSmlDL2VzQThSdmtuenR5RVhrcFI0NEJPYm8w?=
 =?utf-8?B?Nld0NUIvNWkyUkcxNjRtTFg1QktOOU1sYjljZk9taWhmekFOLzI1WE5HOUgy?=
 =?utf-8?B?N01Cc0JxWXV4U1JJYjE3cWZLTmI4TDFBbjJXN0I0VEo1OUw0WWhHSHRHZjFO?=
 =?utf-8?B?QSs5Ym0xT1Uyd1g5bGlKQUpXUnY1QWhaRE9WOGNNcjI1OVpnUm83WVR2TWts?=
 =?utf-8?B?SzU0Z1pZTjVtblhZVXZkUWpsMVM0SzZRZFovaEhkYnRzdmxkaXd4UXlncU9y?=
 =?utf-8?B?a3UrN3dIYTVXWStXYmgwOTdDMDk0cEMzYW8zTFdKRnoyYVJ5SUtoYWorNnYy?=
 =?utf-8?B?WjZJa3hwYWp0RHB3dVRxREt1SzlXU0ZYWnkrbk1PTmY0dW80dEJBd2t1MmVh?=
 =?utf-8?B?Y3MveTJuQ0N6Tkl1L3Yrcm5YOGFnK1BrVEFsQUdNZXFtV2lnbnZTbHpzdzg3?=
 =?utf-8?B?ZUJoOENpYmk4cHkxOUtSTTBKZEFEcUZEbnVWKzA4Y2M1azFlbzZtTUpRUTNI?=
 =?utf-8?B?M3RabnRaRDMwbU5TWTBpQWthV2pRYXJrbkNLb1hQaTZteERDMEhBNlFRcXFV?=
 =?utf-8?B?QlF5WGVhM3ZMa0ZXV2owR3JOdjI1RFZRcktwWHh5cE1Fc0h2MGpIK1I0T2x5?=
 =?utf-8?B?ZHZTdVRYU2R4bFVLWXVLLzZIRHJYcG5MS3F2eHJDWWowTW5JYjB1SUR4WGVZ?=
 =?utf-8?B?eHoxV1JYQURwanczQUhvOTFxenhLM2NDL3dTbUtGTk1haGtNTmp3eDFqOTFV?=
 =?utf-8?B?aUtUNDJsWkh2YnNTbjB0ZnhaSGwxdENGT0hGVE9neVFNbWxEUUR6cDdqRUZ4?=
 =?utf-8?B?NVB2bTRYSzNLbHpLWUxmaU9FL3BMbENhb3JZdGdBV2dTSytoazNnUFc2dHVr?=
 =?utf-8?B?RXdBQnNTcU5wZ0Q0Vk1WR2JGTFJ5eXVvNm03K09pT1ZleTdlUTFsd0tOcDli?=
 =?utf-8?B?M3VmR3M3Y0M2ZkpLVVA3cWE1N0JYWWFZb0xVRjZxT0h3Qlp5ZVg1RU10dFlw?=
 =?utf-8?B?RkRSNSsxdE5vSFJBNnpReXZoTk1UdXNuZElhZW84Y2QyMU5ZMTQ0L0tvUXpt?=
 =?utf-8?B?UDZkMFI5SS9VZFNMNnY0YlR5SWtIK0JoQXp4RVdxUnc4QnpldzVvSTh1UEYr?=
 =?utf-8?B?R2UzckZhWVZGaFBsZmc2WGZ6V21vMlNyN0xRSk9mWnBFSXlHcTNNUnhRbVcv?=
 =?utf-8?B?QlNyeVR5R3ZydE5WNi9CMUNyZDNXZmxFMDVqQms4RUx6cFJ4N3kxNHVHcmVm?=
 =?utf-8?B?RmdwUTJpc2UyY015dzQ3aW5ZY2h0aVNVR3Y4U1l5YWUvNGk4N0tjeXpvOGV1?=
 =?utf-8?B?a3pQVjFyT01Xa0Jxc2lNVzlBSTlFeGJJL1EveitOcmUzNDUzUlFoRW51bHVy?=
 =?utf-8?Q?57udTxomusudz1LPx8=3D?=
X-Microsoft-Antispam-Message-Info: pAGyOh8JN4pwBCESPvpf5yBLXKG3NoeYEX6fMX6hv0ADzk0vcNU+4pWXxSP2etlhSlBNv5SuQSeZZkrtPwZWVfN+VAdhS5yNbfaLWZfMtcWVpPfleaFVIV9CeKisM5JUZMWJxIZsWMjQhUk7HYkk59O8Cs0862W+zHAH119v3MVrfkM0191gi06BAnyGMGcnYqeh4T4fazlxHAvFEEFm8/YjUIUIVOSIMyn7V5u6Qxr1Gnxjw6BKVKsk9M7LITSouAcz/nN5k3fX2+gSl7KT4vS68ZMQuRZnzGHOpXnZu+jL94v9eRtXWxiI9dUQ6RYN/4pIfYaAWiBsx4u6sjm20g==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;6:WpKYCpCL2s6vDrBHUpFq68tyZSZhOgs2pnfrBrsHUkWUsMNFzDRqpvFajllIOhuV06lS4m8AeU+0yyTQ6X2uxAA4Y104mMz3u5jJB86jX+nxDbUghbt3KF1vyKuKb3WTpx6eJ8iHxeF5XQnoAG06sDzqmb5D2AuxfeESm6AG6JiixBVTphKGFbh/7cPKMt1XbQ022LYjXJ4hVIKN0fil4SHI3CJn+TGve3BJfMOZ2sWtMVhb5CvwGplHbscIe35GieR6zYy04Ub89wiRrKUM5rnJ2CklRWL+eEj01uW/aVX52ndbigNavN7hjPrZlM7+TvhGiH3gMCV7oKPLIgbdb0nA7xP8lxPVuCTIN/4go+uaDxNDwuWBTDiV5YIbO9Duqvsb746HwXSfwIkoSPdN/VdlWKRRVCDBcAuczGstZeoVQqZCPoG5lCBiblqb+ZBDU+LTHwI+iGrQq3N8zs59mg==;5:1d3pagPAotnfXBzHbmwP73i092t7SlRMYIRFbc7vUAafoD9Riq78HgoFXemPrMRRU+x/WEz2Q/RXkoY+NysCHBmotuBHTBdQ+JV1W0onqxBMZ+EP9+i5IumtTyRFn1Km3UNbQsV6sFbW6bny0dl915nYjCTAza+3R+YpdAjlzKE=;24:QJPRS2xzu9xfrngu4zYXr5mSkd4tyIFHKqOob+PM/aPR/S5da0WDMdrApORcYgyf6jgu3o0SVrDlpkd5kAychnI9AGvL3WBMtGOaJozni50=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;7:2irMF5UxdDel/tgsqKJGn5nPgYYOnMpkaurLQRfOKVrybAoEkBlFUZ09MuGVrYTF2rpELH58zUnDE5UP1FrgbNZQHr9sY6v7tf0NsK7K1MHrOIrQ8OQJ6+Yf8qrtDwKoJC2E9b+FAMpuMTKbMWz7iN8c1wdlqO8TDEpmEnEG+qY3LSqsMdZnlc98N8lPfiL3O/j4ZmCRF7e5PZAb3kjLyOZrRyIbdSuMXr28m6CWfijeNBsD/DXMLDXPY4Nb/rCX
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 13:06:01.7607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f99beb-be5b-4a66-632f-08d5d5e569ec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-19 14:56, Jarkko Sakkinen wrote:
> On Fri, Jun 15, 2018 at 12:14:57PM +0200, Peter Rosin wrote:
>> Locking the root adapter for __i2c_transfer will deadlock if the
>> device sits behind a mux-locked I2C mux. Switch to the finer-grained
>> i2c_lock_segment. If the device does not sit behind a mux-locked mux,
>> the two locking variants are equivalent.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Can you quickly explain (or give a reference) the difference with these
> functions? Not an expert in this area. Thanks.

There are some words in the cover letter. If you need more, there's
always Documentation/i2c/i2c-topology. Hope that helps, otherwise I'll
try to explain better...

Cheers,
Peter
