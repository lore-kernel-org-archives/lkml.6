Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69D4C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F10724AED
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Iim7h0fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F10724AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbeGBJLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:11:05 -0400
Received: from mail-ve1eur01on0111.outbound.protection.outlook.com ([104.47.1.111]:35219
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751443AbeGBJLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdUOEUNK4r2bmIXlvEDowYq7ig3gMvhJv9rtkB+c/7w=;
 b=Iim7h0fbXU0GF0YjT2pqDEPStL6+GS+9x/mrMlzH9wIyB5VceaVms3oU8Y4sDlSdQJ/wuxAaTS8CF0C4fWoOe5HRD8qkhR3q1vmOS/+BwiDblfWlnw4o9fAwfpcoSfUtsKlKH0geAsvD1uJydm7xAM6MLeUO4NlQPMWkuZUTu9I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.5] (185.231.240.5) by
 HE1PR0801MB1338.eurprd08.prod.outlook.com (2603:10a6:3:39::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Mon, 2 Jul 2018 09:10:52 +0000
Subject: Re: [PATCH v7 REBASED 00/17] Improve shrink_slab() scalability (old
 complexity was O(n^2), new is O(n))
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, Andrew Morton <akpm@linux-foundation.org>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <46d951be-d3c4-91a0-0e33-711591914470@virtuozzo.com>
Date:   Mon, 2 Jul 2018 12:10:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR0701CA0056.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::24) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5344b638-bbb5-40fc-bc0e-08d5dffbb6c8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:h9t68pjK9R6Gp5wppTq0L8kpSMo6k9ujY0vv2HqDZ146+Q9AyucCXbYFXySObjPANZG2WPU5XkjkcLAYRdcWTf58DIPraLPxAIzcdQZrWm4osUtjiXsr6jPExvcy3UXvGBNRRRwyybV06PBwWEddOYbR7+K4/Pkp/C/GJFaPDulJSn/22KKdcEJ5usSwSO4JAnQqM/awS45Nt1DVkBk7Ej0pAMWDQjafA9xJZrwAkI1Cb0lBeE24Ny0uR48NSITx;25:LfN+XNGDqY35dShfytw1rw3KCzLDHMtTaGr8pwffX3kIvzrXU7vKonKLVcW8phOfPTvSYGmTGpab3purp4NIRyGcP+VS7mp2zhHr59pi8lige6xm9qV1Yhy6N21yYcv5O7EuNkyFCb3JnYKZED+eCNJassoMn6i9QUaA1wxb3NRB4k0e+0NzSgeaPxgiusYxi9q6SSYZ0G2a1OAVuqkIpbfKjhmiezU1IHszbWe/i3/DiPAzm8UbYpSvR20FkM5gt7cvn3pS+lHXjlyaewYuDxOoP9hFxRz+An8Wz9csnK+CVQA2zC9XbGO9iYwsv9sRI4BHEyxuo85nm16Zv/dBBg==;31:9oabArige4I35NUpMBLiTKo/Lzab/hpP9BtX2v3jeucrR64v88qAnF4HezFXo8uYjH1e5yWyCzWTGop+/W4cJTtP7v765xbH0wxCZGIdW8GlxnDslDksZ7/DD8SK/E5wRX74UhPlbgP1x7LtZOojGzCwQAezg3Cu9XDWLKBvGQEPN4Uvp2jEwZiVqeHhHVHGYtiSYaegF4kO9tD3Oxc8lBXOew8pSpC9Ysoh1O5cc6o=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:eM5j06ebP6nnvsYLpjbFo7YIVY1pT0vzYS82Z3ghW/+MY+0gBJ9FMmlvyEOxm9KtL+SjJKInQem7xja2JKHDnChfXEtLUGSYx2zNNL+QtY4xGPSgsXDJj1fjbR0SYWeRVJkF7oNXhgtRju07cY0J2qYGDENxvlvtmbzcFshBLnHFzs2LcaUgIJP48u5mykRJiuwe3FrBgCsfQq3pgEyKmCwb+fukwcxM41/c6gbTgRhT6yqy79JxV4GW2he0f0P+3K8Z+SMsjvlrLGGaRZIoY9kgqQFY9NsY9tUAIiJCmdbT9KObYr4sHXNf7oiUdRjxj4g0DfsaQG3uBT4Y8La47HApU2xgCwY+kIgcfh87rDTLZpay13esrb4HjMRD5OK9zwouwa7rMqIu1+rcJqAbyKpFVbIKPqCQLpdyFBdPc/n+d1AP8ai43HFGtbWZMb+y8Xo2nQOg4CAOperHQDCwXgvq7hclRGi+aGFGrWZ0IAoVLLItiIIA0aq+76l3Jk5r;4:TSoOUTNf95yQZU/y318VeqhiOiT5HmHKp4Q51gSm5NXb8vjTBrPfkF0CNq+76ouGKqInN822KFzWs313mWvRqD74HjGfvdrL+q7dIuwe4VsgBwWscZUwXgbxjIuGj8cUeX0uNdWGhZEkeTetWSJeK6PZpfVeCnUTKd4NGvOvtTjqvEQwFaG8IlF7ElogvSjoVh4kdKiDGMlk36qoYL4+21vgKmt7mGQcoFtT1AReyo/F6bYKII2zJKpJCIb37nhBsyQ1vDtPZzTCP7ADlO8Gy/uG13XTY/kD3f2DQ/YqFLhPT4dMfuuEQgqAgi2a6W8wslXrlfnSriAfEqTIRg4b/K3yjzt9nbPehGAY9cJAp+Elca9cXTHF4RskXrXyoh9D61ikvWbFHZP3DHyHX9LEWXaGxEWaO6WUr1ZBXt56a24=
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13385C7E6F6D1AD8A0C456D5CD430@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(396003)(39840400004)(366004)(346002)(376002)(199004)(189003)(6916009)(956004)(486006)(50466002)(305945005)(47776003)(53936002)(229853002)(65806001)(105586002)(6246003)(6486002)(25786009)(66066001)(76176011)(65956001)(39060400002)(106356001)(476003)(446003)(6666003)(2616005)(23676004)(52146003)(11346002)(52116002)(2486003)(68736007)(64126003)(16576012)(5660300001)(8676002)(478600001)(16526019)(81156014)(81166006)(8936002)(2906002)(7416002)(65826007)(86362001)(31696002)(26005)(230700001)(31686004)(53546011)(386003)(14444005)(6116002)(58126008)(3846002)(186003)(36756003)(7736002)(316002)(77096007)(97736004)(921003)(81973001)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6L2NpeUViOEZUc2JJYzJTbkczbVFDNHhl?=
 =?utf-8?B?TjFHcWNnRWNpNHpwWlhtelIvK3RkeUY2WFQzSlBJVzRpbmJ6S3V4S2xhZVNE?=
 =?utf-8?B?WjQ1VVpJaVNZalUvM25IbGU5WFZOTjNFR2hIS2d4V1ZZSWlxbVpwRUJOdEFu?=
 =?utf-8?B?UHRNUG5XOHNNdFB1c2JwcU1FMHlnZkpEOW1BNHBUQURtcE5ONlJXY1FSV2dr?=
 =?utf-8?B?Z2ErU0xkVnNKck1FU0hIcDBxZUIvcnlHNzhsVkVOelBJTldycCtXWEVkM05O?=
 =?utf-8?B?ejN6Rmd2SUdnQ0RKZTIwYUZjc3gvUWcxSjdrMzB3aE5veE5EZ1JIUE1Yb3VF?=
 =?utf-8?B?M1ZlcktsK0JWUnA4MU1nRFJBR1kzcStiLysvbEQ5dDN1Sy9VK1duTFprUGdm?=
 =?utf-8?B?eFM3ODk1eEpmY1I5eEc3a0RNREh1U0djZUFLU2d3ejBPak1DbFZJcVVnVUhm?=
 =?utf-8?B?UTRISFlkcmdHRXlrWVVtUEVocDdsdnJEcmZSOUF6cFhpaFRIVjArZzIzVjZ0?=
 =?utf-8?B?YzBQRzBrVVN1OXR0R056SEllMVhBVkRQVTgvenNtZGYvaS9QcnhyU0FwRnNB?=
 =?utf-8?B?M3VWbHhUck1jS2ljUFMrOUpidW5JbmJrRlhQNGdHSzdBYkQ4azRuWkFLYzJX?=
 =?utf-8?B?Rk5NNUNxSmxMeVVKNzhlRjBnVkVjeWRPR3Z5WGt6VCszaEo1UkFPMHoyb1Yy?=
 =?utf-8?B?cm5tSVd0M1pLbmJRRmIwL3E1YjI1c3plazFDSG5ISjdFYytFTWlQNE1jRVNr?=
 =?utf-8?B?LytybTIvdmNZYjhNYVFTVVBFcFdGSm1Pd3RBd25jL2FzdDlCL0doemRlNmsy?=
 =?utf-8?B?SjlzYUc4bURYRGNBb3p2bi9GL1JuTGM0a0JXNmw3T1dZVlp5WGdONVptVnFm?=
 =?utf-8?B?cXdGdGtFOHh5RXROcS84UjZhamNVSnNQOWVCeHFTUHFGK3QvRTh5Q0lhWVl6?=
 =?utf-8?B?MTl3SngvUUJxYWJST3kxZzFKMDRRRE5HOXl0eFpHeVZML3ZJZFhqRmtPUU5Y?=
 =?utf-8?B?aVBtdkRVeUozR0xJOVQ5ZHR2REVzODhWSVZNRFlLMnVEVWFTZ2ZsVzJyNGpj?=
 =?utf-8?B?WW10bE5nei84NWZ6RXAvaHRvREIzMlpNWTJDeldHTHRROWRsNFJEbjR5bFRt?=
 =?utf-8?B?My9mTFYrS1FoL3A2UUF0S1M3c3dVbU4xcFZWMGhvN3pReU5ianJaL3JHdUQv?=
 =?utf-8?B?UkhWV2FnUlRGenQwK09wQ1RkYXlRdHhVbmJtenBHM2g5NWNmTjRQdFZvVkRo?=
 =?utf-8?B?S2Jxays4QWM5VU5tWmFlNU5HcUVvdytGZU52K2xkYjRKTWhBeXpRYThXZlZh?=
 =?utf-8?B?ci9VVjc2Mk03dWk0K01MclgyckVVQTRsaWVKRVlrVG96OXBMSEpjWlFWL20v?=
 =?utf-8?B?alpYdTNCLzlYcVpWRk5qN1JtemhaVmRzK3pJRGJTMXZZemtaL05JMEZ3UjE0?=
 =?utf-8?B?Umk2L3lIVGhmRUl5ZTRlb1NDL0c4SHlncmVmU1czWWtRdjk4dTRxUVBFOG5X?=
 =?utf-8?B?VWxkUXpVZVRaVlA3c0JwOXAzTXpXSEJ6eHFiSkRRaGxjQ1dPbFJXL1lQY3I5?=
 =?utf-8?B?aGswaThxbEp0Y3YxMUFaV3BWQWxadWQ5UjFsSng2aTZMWW5GaGFZS2JJSDV2?=
 =?utf-8?B?YlAwWkpRdWpEeFJCMFZ5MVFMaDVnekRTYnBHamZBeWJ1dmdmUDBnZkQrR1l4?=
 =?utf-8?B?RnE3TUVTT0kzbjNkWHN4MlQ1aXI5R3FEbkRFNnhlVDdxYkJJZS9zUnRCR1pN?=
 =?utf-8?B?ckgwWWxaNjR1N2FsKzlqa2plT1NYMGJNQ1Jpbm4rM1NKWW9WSFlKVVowKytY?=
 =?utf-8?B?SE5LV3QvTTFyZEJjM3A3THhrY2xtR2h3dzM1c0VHZmtzRXJjVEwvanFHZnFM?=
 =?utf-8?B?eTIvVXBQV25sRndoUktjaGg4NXNCNTV6czlmYjVQOFhqbjcvRC9UZlNDQmJQ?=
 =?utf-8?B?RmJMamlFTnV0cGdJY1RsRTVNaG5GQzNMazFnT2VBd3UzdzMrQzhWaDA2K1gz?=
 =?utf-8?B?WWprbDJMUXRVRGZ0VlpJVVp3dEpIaks1aXZyMUdTUDE5U3Q1TEw3YlVEMnJm?=
 =?utf-8?Q?5LRZsU=3D?=
X-Microsoft-Antispam-Message-Info: Nnh8oW3o9bs0nxSMMfDCBdKg9lQgNenuqEPPbyH4HF96TNFbtI0SDYzA269//MFiQtZTqFZ9c8q2DqJnqI1QcWHHyUXTtNzLPHuWQ6kNR9hQPWuNfUJy8S8xtp139tJuBQ19RZrn9waKqKHpsXSFeQpmlKfoB8Av41eNMDmZ9H0B96tpog9EJiQJ6KVffv+GrrjInXQIRa03sAQPv0bdCSRCwDy6VCMVD3O8mRZcA218Je0Tl6oEVVzEgRKZUcfAUDGf4HlQkTWfJpzgZlohhFoVOczdLRZfnhO281MLtpTXLciq3UqZ34Qko6OjIssB+/cnJ2QJ1e86mKBsaysW0OcMfIRPg0VN9L2Z+zPtpOg=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:AYCTnirXbtNePGxafMbjpOPRj5lYQSntsFX3Csit45q17tjXK4po/M+71LpzN7UAzhnPphdDJOkog9yC0hF69SvDdL3cx7OgvKhumTJ6OQXOfZ/2ZDeXRBjYaxaRL0F+jGPsA7O8RPqnF3ZRmB6sJP7knrpDsE2oo7tH3aB8y1h6JFC1trUtERpHblbMEVu1SNDsADUzuOHHu7204fIh2NhcHp05kfLKNbb9KahBPEXATvVGrFVL09/Gxf1tlfaFFDk+FCy2VXbfLnqjdvTQ1QuZhaDL02Yjl1iRw/3550k+cR3s4Dh7USggTZaoQZ0/oSTinJHry2mFBV2DJTWve2lE7zlTC/4vr91kfJRNlxeg718Ty1pOOBwOMJbxzRqZJ52l0NgKOkc/y6kcQ4vWgXkowy3F2A/h5tCTZZgaCITFjex0vfv0Ldxp+DZQCE72ZQ6CxIIVv4JS6ayLNIqjAw==;5:8w0VM2FA8Y/rPxtCDyrKsDP/HoE4LLsWBi7nWX9rP1QlANHtR9DUZ0MHJIeLsInujT0cDc4tDV5jMXlYuARH4CK0EArBR4sHeoLdWdHODFyE64FOrdZJTRnTXgbWG4XiGd3OFaS1AhN3GDDnUP7t/Hiilz9aNOxrEdmunC92670=;24:BZHGkla86scR2Paq3ffPJlxkPkxhn4zg7xKNsuw+gSGbO4fR5EVOhhaM2Q9uQ3HwqTNUy9zyBI8hyWUmpBDIER+FEEEJIRe+kZQL7UC7oN8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:BGFMQ43IbdWi9FtRn+pTwBvbhvv2AGmUsilc3bC/aEvXs0bLXm4F2y1Y1QJldI/4xZltBTOgMpM5zP7CvgOOhtiWryird7qJgkh7Pz7nhr8o98VnJj64mGvB3M+IoFrMBrmAdkoq8ZkFbqh65Rq8kaMLEmnV07AVMBb6xlDHdAX4thPJ2blZh054joOBcoTqnrxPFcxD6gi46k7eR25iCguY8eF1U8XiydTwMvsnvlBp7bOJ0Xevdh+w/XYZ9XQI;20:ramlsPt8u5GccQa6i7b5gkU1JW1neZxHfQ4QPqDM1Pny67ngyKpB7scB8VZOWWNVS2/anAlp2rLumLlziwC1KYdLwJ63K5LPtod0DO8uAo1mi44YrCj21Hp4Fq3PuCyGvQ3atqJneiIu3Jcsf/NxmJ9zONYd79aAjeIMdWh6ZTE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 09:10:52.5280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5344b638-bbb5-40fc-bc0e-08d5dffbb6c8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

this series is made on top of 4.18-rc1, while now I see "mm-list_lru-add-lock_irq-member-to-__list_lru_init.patch"
in mm tree, which conflicts with two of patches from series.

Should I rebase the series on top of current mm tree? What are you plans on this series?

Strange thing, I didn't add you to CC :( Please, say what should I do.

Thanks,
Kirill

On 18.06.2018 12:44, Kirill Tkhai wrote:
> Hi,
> 
> this patches solves the problem with slow shrink_slab() occuring
> on the machines having many shrinkers and memory cgroups (i.e.,
> with many containers). The problem is complexity of shrink_slab()
> is O(n^2) and it grows too fast with the growth of containers
> numbers.
> 
> Let we have 200 containers, and every container has 10 mounts
> and 10 cgroups. All container tasks are isolated, and they don't
> touch foreign containers mounts.
> 
> In case of global reclaim, a task has to iterate all over the memcgs
> and to call all the memcg-aware shrinkers for all of them. This means,
> the task has to visit 200 * 10 = 2000 shrinkers for every memcg,
> and since there are 2000 memcgs, the total calls of do_shrink_slab()
> are 2000 * 2000 = 4000000.
> 
> 4 million calls are not a number operations, which can takes 1 cpu cycle.
> E.g., super_cache_count() accesses at least two lists, and makes arifmetical
> calculations. Even, if there are no charged objects, we do these calculations,
> and replaces cpu caches by read memory. I observed nodes spending almost 100%
> time in kernel, in case of intensive writing and global reclaim. The writer
> consumes pages fast, but it's need to shrink_slab() before the reclaimer
> reached shrink pages function (and frees SWAP_CLUSTER_MAX pages). Even if
> there is no writing, the iterations just waste the time, and slows reclaim down.
> 
> Let's see the small test below:
> 
> $echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
> $mkdir /sys/fs/cgroup/memory/ct
> $echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
> $for i in `seq 0 4000`;
> 	do mkdir /sys/fs/cgroup/memory/ct/$i;
> 	echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
> 	mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file;
> done
> 
> Then, let's see drop caches time (5 sequential calls):
> $time echo 3 > /proc/sys/vm/drop_caches
> 
> 0.00user 13.78system 0:13.78elapsed 99%CPU
> 0.00user 5.59system 0:05.60elapsed 99%CPU
> 0.00user 5.48system 0:05.48elapsed 99%CPU
> 0.00user 8.35system 0:08.35elapsed 99%CPU
> 0.00user 8.34system 0:08.35elapsed 99%CPU
> 
> 
> Last four calls don't actually shrink something. So, the iterations
> over slab shrinkers take 5.48 seconds. Not so good for scalability.
> 
> The patchset solves the problem by making shrink_slab() of O(n)
> complexity. There are following functional actions:
> 
> 1)Assign id to every registered memcg-aware shrinker.
> 2)Maintain per-memcgroup bitmap of memcg-aware shrinkers,
>   and set a shrinker-related bit after the first element
>   is added to lru list (also, when removed child memcg
>   elements are reparanted).
> 3)Split memcg-aware shrinkers and !memcg-aware shrinkers,
>   and call a shrinker if its bit is set in memcg's shrinker
>   bitmap.
>   (Also, there is a functionality to clear the bit, after
>   last element is shrinked).
> 
> This gives signify performance increase. The result after patchset is applied:
> 
> $time echo 3 > /proc/sys/vm/drop_caches
> 
> 0.00user 1.10system 0:01.10elapsed 99%CPU
> 0.00user 0.00system 0:00.01elapsed 64%CPU
> 0.00user 0.01system 0:00.01elapsed 82%CPU
> 0.00user 0.00system 0:00.01elapsed 64%CPU
> 0.00user 0.01system 0:00.01elapsed 82%CPU
> 
> The results show the performance increases at least in 548 times.
> 
> So, the patchset makes shrink_slab() of less complexity and improves
> the performance in such types of load I pointed. This will give a profit
> in case of !global reclaim case, since there also will be less
> do_shrink_slab() calls.
> 
> v7: Refactorings and readability improvements.
>     REBASED on 4.18-rc1
> 
> v6: Added missed rcu_dereference() to memcg_set_shrinker_bit().
>     Use different functions for allocation and expanding map.
>     Use new memcg_shrinker_map_size variable in memcontrol.c.
>     Refactorings.
> 
> v5: Make the optimizing logic under CONFIG_MEMCG_SHRINKER instead of MEMCG && !SLOB
> 
> v4: Do not use memcg mem_cgroup_idr for iteration over mem cgroups
> 
> v3: Many changes requested in commentaries to v2:
> 
> 1)rebase on prealloc_shrinker() code base
> 2)root_mem_cgroup is made out of memcg maps
> 3)rwsem replaced with shrinkers_nr_max_mutex
> 4)changes around assignment of shrinker id to list lru
> 5)everything renamed
> 
> v2: Many changes requested in commentaries to v1:
> 
> 1)the code mostly moved to mm/memcontrol.c;
> 2)using IDR instead of array of shrinkers;
> 3)added a possibility to assign list_lru shrinker id
>   at the time of shrinker registering;
> 4)reorginized locking and renamed functions and variables.
> 
> ---
> 
> Kirill Tkhai (16):
>       list_lru: Combine code under the same define
>       mm: Introduce CONFIG_MEMCG_KMEM as combination of CONFIG_MEMCG && !CONFIG_SLOB
>       mm: Assign id to every memcg-aware shrinker
>       memcg: Move up for_each_mem_cgroup{,_tree} defines
>       mm: Assign memcg-aware shrinkers bitmap to memcg
>       mm: Refactoring in workingset_init()
>       fs: Refactoring in alloc_super()
>       fs: Propagate shrinker::id to list_lru
>       list_lru: Add memcg argument to list_lru_from_kmem()
>       list_lru: Pass dst_memcg argument to memcg_drain_list_lru_node()
>       list_lru: Pass lru argument to memcg_drain_list_lru_node()
>       mm: Export mem_cgroup_is_root()
>       mm: Set bit in memcg shrinker bitmap on first list_lru item apearance
>       mm: Iterate only over charged shrinkers during memcg shrink_slab()
>       mm: Add SHRINK_EMPTY shrinker methods return value
>       mm: Clear shrinker bit if there are no objects related to memcg
> 
> Vladimir Davydov (1):
>       mm: Generalize shrink_slab() calls in shrink_node()
> 
> 
>  fs/super.c                 |   11 ++
>  include/linux/list_lru.h   |   18 ++--
>  include/linux/memcontrol.h |   46 +++++++++-
>  include/linux/sched.h      |    2 
>  include/linux/shrinker.h   |   11 ++
>  include/linux/slab.h       |    2 
>  init/Kconfig               |    5 +
>  mm/list_lru.c              |   90 ++++++++++++++-----
>  mm/memcontrol.c            |  173 +++++++++++++++++++++++++++++++------
>  mm/slab.h                  |    6 +
>  mm/slab_common.c           |    8 +-
>  mm/vmscan.c                |  204 +++++++++++++++++++++++++++++++++++++++-----
>  mm/workingset.c            |   11 ++
>  13 files changed, 478 insertions(+), 109 deletions(-)
> 
> --
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
> Tested-by: Shakeel Butt <shakeelb@google.com>
> 
