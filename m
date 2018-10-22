Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339E9C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D364420779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="C9i7Y7dG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D364420779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeJVQva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:51:30 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:55373 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJVQv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:51:29 -0400
X-IronPort-AV: E=Sophos;i="5.54,411,1534834800"; 
   d="scan'208";a="22050520"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Oct 2018 01:33:56 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 22 Oct 2018 01:33:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2icGRQdo8Zmdlo4F4FRNd6z2f0V3++wTnDkZkKBJso=;
 b=C9i7Y7dGc/qb/Zigl7lnE61RFgHaITIHhHQ7exPo4ntVwcwAJj5E9otdgpblLhNcTnm/EaK/gbI1xbiNsqKWs4g1BtHbCc0NEyp/M7S/YzW35FmMEmZkR4X7ikzD+ojnMvzvQGAmH6jhq7AbP1nzM85ZinRVhjC6/VTvnWNFYgc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
Received: from localhost.localdomain (185.7.230.214) by
 BN6PR11MB1841.namprd11.prod.outlook.com (2603:10b6:404:103::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.20; Mon, 22 Oct
 2018 08:33:50 +0000
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "cyrille.pitchen@microchip.com" <cyrille.pitchen@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>,
        Mark Brown <broonie@kernel.org>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-2-tudor.ambarus@microchip.com>
 <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
 <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
 <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181017090724.12f2cd79@bbrezillon> <20181017091045.124e0266@bbrezillon>
 <20181017092941.3658bd9a@bbrezillon>
 <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181017115237.07310b74@bbrezillon>
 <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <c96cf515-3e9c-b775-38bf-51e85af96e32@microchip.com>
Date:   Mon, 22 Oct 2018 11:33:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.7.230.214]
X-ClientProxiedBy: CWLP265CA0265.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5c::13) To BN6PR11MB1841.namprd11.prod.outlook.com
 (2603:10b6:404:103::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5741f677-8df8-42cd-ee67-08d637f91901
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1841;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR11MB1841;3:LNXGb4pNNtGsLqYk4YL3Hwo7uOSsEnaA1axLm1Y9NL1GOjVn7E6vT579bwqXATouEJW7O/AVvMFCpZXbEe4oFlzoG3b5KLKOhASlli0nD0lTclO9dOfq6QbeTTSqAmfNNkQAKXUV0pUtFuCouxZlmyS8yaMu0qupJs3JAPKzpM87lgXDuuD3I02kmqOy00XfFeQLEIgiMRATJRNKmnHQTLLzJSCNZ/Rk1AqUXA6QmMufm9JJUcLy3HGeLehHOudo;25:k1FluSt+pfw9xSEMgNnqsznxKMwBEl2q14nPQI47CfgemlifrdsXDAAJLonChPwXnO3rkitR/nqxtY23gGbd5men8h3t3AeYmpYWlJn2M7Sgbbd/n9cceEYQks0B4rUUwc3k8IWKvuZ/IXuJiZ9PphfWKod1kmW86qRpkNW0zX3Js7bxBFIZtr19TILNDui7kNQqUOYL8GmxKSWJL2cpzAsUC/heuUNTUElfuTQdFFwXeHRGmYKV5jqf4RKl8I4PpfOXKZX1hOLGWMfV90acikIFhiVNCJFsQw0aTREguO83i5VKgiSpwuNqES1ZsUmjTPwyhfG7vOmSXqlLdmNiUQ==;31:IDVCkxC6yuTpuBdvkgZMdUaR8DnxH/9gCADvZ/9GuBj8Xlz+h5IFj2rw2YzbXOsXmlA3gpgS7HMbQj4G1384GO76iLUe0EwqFjGCzXEbmewqrFdrgAevBVKal+KfIfIOhbA7dfy7juYpyVv2DnqqrB2eSI7UtHoEj8pP8Nte5+9xIjQpKZnB9G3rPF6gokwxZGPYbUysHFFkDfcy4I68pgnHYihTHynGuJYSbJHG5ko=
X-MS-TrafficTypeDiagnostic: BN6PR11MB1841:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR11MB1841;20:m2fKQXNr6b9k9R+zrVwLtk63/TrCAyKUU2Gd6/oXPuriDETCaaSAu9AZQp9I2qs2+4elNNl37dgk4FUAJ3Xx4a7zAXvB89gs8n6Xt3KD6TfdqHpifVSLwXoCXI/7Wp2O8//a08RSStvsQxN65x3K8cno/nB9aX00quWR8Do0gh7ebN/8C/vSr2yGwcCCjk5DMx/N0M0XpJx0JkESXQI6dfQ+TJaqifNUq8H7X/U7ENTkKhdS/GDsMNWi1RuEAUgfIhtEVf9ey3BB+UvtgvNYij4p80OrQFU20ipiDjfmUJ7sJeklBgAFri6SmTW7hyyDqCf38k+AIdti9eyE9OQZFA0H59PMFEsesdCIqhFNFh07ZMhA+zdfpO2eW4/mQIfxfMSCDlRu6dL6+bmMQa8OIzGGqaqB8uUL1vcMjDrpcy8=;4:hE6VPUx2dnka9R77YJY116QWjM54KbwCx4ECrPzst1a0Ao0RGF5NkYPCMldLLovxqxLX+XFZ16B2zh76NoCGaywu3SPhBOys+y3wDIRhVBSfF7AwlnAjOR1PeH3BNG9/fYIAzH9Yn4O8SHrbrrvuUFlWrS1bI3VJRTtm4gX4ozpzs+NpDs4vYcKArBUYnd4r098i71+wsF3pED/ZAHclHPT/UIx7+pCA7ZYbLLquy29IjRHBTu0HfhEIVN7iQeG42h0Rbwkz4Uk3lrIeYL9a+g==
X-Microsoft-Antispam-PRVS: <BN6PR11MB18410AA63FBDEC78BEC55290F0F40@BN6PR11MB1841.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1841;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1841;
X-Forefront-PRVS: 08331F819E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(386003)(6506007)(6246003)(26005)(93886005)(2616005)(446003)(58126008)(316002)(47776003)(186003)(54906003)(110136005)(23676004)(2486003)(52146003)(65806001)(66066001)(65956001)(6116002)(3846002)(52116002)(36756003)(106356001)(105586002)(7416002)(65826007)(97736004)(25786009)(6666004)(305945005)(7736002)(478600001)(2906002)(5660300001)(6486002)(76176011)(53936002)(6512007)(50466002)(230700001)(68736007)(229853002)(4326008)(39060400002)(31686004)(64126003)(81156014)(8676002)(81166006)(8936002)(44832011)(72206003)(86362001)(956004)(217873002)(476003)(11346002)(31696002)(486006)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1841;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjExTUIxODQxOzIzOkIyUUJvYlJyTFdTeEQvNm1aRkpaSTB2OWM1?=
 =?utf-8?B?bmFzWmlMVXdiQS9Ib0Qrc09CRUlBMGRudkU5YWc1cXFCSWlYTEpSRjV5bnRO?=
 =?utf-8?B?NmplZW5pem9hTkh1cnpieVlzVkRwVkkxSWF6SEpmRVFYYTVWYU14Wk9UR01W?=
 =?utf-8?B?Tk13d1kxQ3I1N3MzQzFhTjRkRHMzeDFZVVdMRnBJa292VWxReUxrSUp0dXo1?=
 =?utf-8?B?b2laMkpTRzE1WmEybTNRcVJSSkJzUGx5cFhoeTcwS0JGN2c2a3EzdlZvY1BV?=
 =?utf-8?B?V3BJbkRiOGZKdGZIcytpSjRwakZpbEtaNXlORHV0UzlnSmRiSkhlaG1neHo4?=
 =?utf-8?B?RzVTOFd3Qk5EYUxYMy9mcDYwZHRKdGhTZlkyVjI1SHloOU9hMmJoREZuYVNI?=
 =?utf-8?B?Y0dxYk5leSthblYzK2ZJMGFKQVNmSzUyaXZNVkR3YTFnOU9PVjFQS21YYndm?=
 =?utf-8?B?Rm1sdzNpallvSnVXSVI4a3N3NWsvMUFQTUowVW82VytaYnJiSHJVMkZMMDFZ?=
 =?utf-8?B?T1lhaDNnWi9LNVcrbGtSdmVnVWxWWkU3Wk4wT3B0YTF5THlkWjViWDJjaHZV?=
 =?utf-8?B?NFdFYnFJOFJ6R3JFU3pCNHFUQUpaRCszOUgvZTZkZlE3cWlWdlhzMmtRRVV2?=
 =?utf-8?B?d0RKTXFJQlQrby9TdXlGTE1XbUQrLzMxNlZnVVVEeWdxdnk5a2YxWTFoK09x?=
 =?utf-8?B?QVoyZWNFaVRCOHNrRGJmYlRhRjN1MFg2OUgrQVlrSnlaS1ZDbTU4YTdaV1Ju?=
 =?utf-8?B?Kys5UTNPQzZIejNLbmdZN0oyK2hPaUh1WnlteDlEQ3pLYW1yUy91Y3hOUlJk?=
 =?utf-8?B?Y2JRQWx4Ym1FdnZPVUU3dVVYSTVDN1pMTmVCOXlYN0U4MC9GTEs5T1JLK2VD?=
 =?utf-8?B?a2htTmNRMjQ5ajBlN3RXMFlGLzBSRUZnOWY5MUlVQVZXSXkrbEtWSE9NTXUr?=
 =?utf-8?B?RXVhMUFHcFJqcUQ5VTJjSFpqMjJWV1RZeDFIbnN4blpyNFAwaHZUUDBmN2NF?=
 =?utf-8?B?UmhWS1hJb0l3RUZHYk4wYmJPTGZ6RmhzMjVDdHdoTDhiNTh1bk9Gb0g4U1lw?=
 =?utf-8?B?QVBuZ1J5R2VENDRyOVRHVlBWYXI4WHlEZUkxL1JEWU9neE1QbnVLVk9uOUtE?=
 =?utf-8?B?cFllNzVEcWRyOFhoMXNYSVRvblNad1VTaHFHeklldUZiRWg5K0hhN2hJOEs3?=
 =?utf-8?B?Rk9yNmlteGRRSzBrSWp2RVBPV04zZDRxcTI2b3dEd0QxK1NPYlVvSUl3bWlm?=
 =?utf-8?B?S1ZGd3JLSzlRRDZRNzlHbTcwdmJVS3VCYURTNGRMYWFkd2MrRWZ3QWg0aEhi?=
 =?utf-8?B?RW5zQzgwM3ZQNTN0TkdMWnBWTWxBWVA1VEpKeHdGQkdSM1dOaTI5amJYYS80?=
 =?utf-8?B?SGN3WlpVanVURm1WMk9tZWpRR3UvQ1E3dlczVFBHdHI2b3pBNGI3Y2xBaks1?=
 =?utf-8?B?UzduWWx2WTg3dUFMLzFzbm5Dell4RjBaenptNG1BVjVZb1ZCckFwRXdHUUUx?=
 =?utf-8?B?VFg4OTM4VjRtQXMxaUZJTVhIYmxTZk5ucEZiL2RjS0cxZUpyVmxJa2JEVlhR?=
 =?utf-8?B?WkVyTHV0UEtoUWtNaVFrY0VSc2g0U05FcFgyS0RlWXMreVFqMzJtelVyTW5P?=
 =?utf-8?B?UUUzM0haL0pmWFNHczJaSC9DWmtaYlRveXhlcjU4SkE3d1QzMG9FazJoQStF?=
 =?utf-8?B?L3N4SzlncWRPaDNlcXBXZXpkSCt2TG5jWmVXNFF1N0x6SUtXSzc5RTVoWmZp?=
 =?utf-8?B?bGZweXY1UUIrVHZiSjVuQUJ6Q3MrSk5yYVhDWThhNHkrQkJzVUwzdGc1Vmc2?=
 =?utf-8?B?ZG1jOXIzclRJWXBOSjNwSjFIcXYvYU9OQXdQYWFwSCtxRlhKYk4vOXlORlRW?=
 =?utf-8?B?YlNHcmM5NG56U25XRTNuVkgrQktvVWxKVXpJMkEwM1FIdmI4ZXR6MTR6L0VZ?=
 =?utf-8?B?Q3pRRWhOak91d2FNdjFFWmlkVUlRYkZ1MklpSjRULzRDTG1iTi9qK1BsQ0Q0?=
 =?utf-8?B?Y2RuN1NjcExvOTdSR1A4Y1RYb1o3OTdiU0FCNVl1b0laYlYyaVczb3Naa3U5?=
 =?utf-8?Q?FsF300HP3FXRuKji93wDFWcm0?=
X-Microsoft-Antispam-Message-Info: SNWyf4et2/P49VUwKSIJ61Jo5uuTaB8bZ9qqMGd0UWRso/x8lEhokNsZQ+e6/qUgvPJoIKj3C14L6PkLvccLPmvfw8C8Q/VPfLI8NvTKmAWto6zekzuBK3XqzMBEtzxtWXkLTPqsZNoPyyotu3UT+7c+cL72sMYBWXygAY9itc4OjhFi+W97kA7e9j8nvBGf25JvGd5mX/IczT5OWjB5H6c8S8a0b2+um70PUjVpyD4RFEaAq4GxEsIhyCLU6b5QeLVzxWcEnY5XO37hy1llHqg6LL/tT4lI/DU2wcHlU8hzvXwJKrzzjUqRibZX5zqICzNf4O9v1sO+25lUs7xjDiCC3OhWOlEXfP6asVJfdCA=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR11MB1841;6:Cyx42wfPMs2Kvsqz9BhC2rM6FV/y8lER/sILp+F+G6oVtgk5lnXqPzOEoU4/IL8Hie4XNf2+d/wEZnI4Pie90sDxDMwuhHMUALQZAh9jdXI4JvrtsiiZ/PVfnGSy2Q10Wsw7ITStdW2/N+tbi6pjsc+8nMLXujQL6vVvHFcag3PDfuxzHjgWpanHq8bB8MxxEGfmWD4jhbgdrb2pV5xwVr75MaPYEj/M3uqrNZeDAXfvrA/Lp5IjgXoh+J74Ti0d3S0fHW08PAKJJxeRTtHRnqCiKn572yG0EN3ZSgm4XzqH9SGcrHcAHLM78rkJMl4zsZhw1Z5KkJbl1hsGb6ComFJyKArUvI75PQAPCEFCbWUhFL0sJBHNGw56Da8YdjSjxmscVdC73KrahCo5k2YstXnnrInb+3Qs3aYBjA7XorgX9hgj/XVbiOI1i5u7XC97zLdYh746CUZbvUr89KguIQ==;5:CCYA7XH2YaovRpdNj607xJH8zbWVeEAfv9I4jwPa5dAG66an1ZwrTdiWxBybM8ixy35NmhUUS9XZWt3knXzq6LaKR0Phc7GOHgYDdk5qsoE2Sby9Aq3+PdnTFywcUX5DGFYM8+YDk6iWKMV3Or4qnA5wivZeLPvZRJ/qeblB1So=;7:qZiovOxvx9ib06YTVv6DeERv6oL22pUUairOahFEkI6p5ehpA5hA88adZ3FaBZ8oBBur5v/Gl6WxEfWJNxMTKp6nrgw2rsNGa5mTwWh5YoD8biova+T/b4cVp1AWKXQHo2udIAwBcCtIC77PgKnxuHOb/xIyX/m/XANpHd2RRa/KCgBga+28T7mZ/BY8HYhTldLqnNY5gC2DU4GZ6VdTpS1VUeQT6Rov62vfVfjG0ykBG+wLElLceHGM4nKsGKVH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2018 08:33:50.5914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5741f677-8df8-42cd-ee67-08d637f91901
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1841
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please amend this as well. Thanks!

---
 drivers/mtd/spi-nor/spi-nor.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 3a9b69e9ba6d..3019708696cd 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2887,10 +2887,15 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_nor *nor, const u32 settings)
 static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
 {
 	const u32 *ret = NULL;
+	u8 *dma_safe;
 	u32 i, addr;
 	int err;
 	u8 addr_width, read_opcode, read_dummy;
-	u8 read_data_mask, data_byte, map_id;
+	u8 read_data_mask, map_id;
+
+	dma_safe = kmalloc(sizeof(*dma_safe), GFP_KERNEL | GFP_DMA);
+	if (!dma_safe)
+		return ERR_PTR(-ENOMEM);
 
 	addr_width = nor->addr_width;
 	read_dummy = nor->read_dummy;
@@ -2906,7 +2911,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
 		nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
 		addr = smpt[i + 1];
 
-		err = spi_nor_read_raw(nor, addr, 1, &data_byte);
+		err = spi_nor_read_raw(nor, addr, 1, dma_safe);
 		if (err)
 			goto out;
 
@@ -2914,7 +2919,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
 		 * Build an index value that is used to select the Sector Map
 		 * Configuration that is currently in use.
 		 */
-		map_id = map_id << 1 | !!(data_byte & read_data_mask);
+		map_id = map_id << 1 | !!(*dma_safe & read_data_mask);
 		i = i + 2;
 	}
 
@@ -2929,6 +2934,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
 	ret = smpt + i;
 	/* fall through */
 out:
+	kfree(dma_safe);
 	nor->addr_width = addr_width;
 	nor->read_dummy = read_dummy;
 	nor->read_opcode = read_opcode;
-- 
2.9.4

