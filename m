Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC73AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECBF21765
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="JOGQ3JOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECBF21765
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbeHMNqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:46:10 -0400
Received: from mail-eopbgr680047.outbound.protection.outlook.com ([40.107.68.47]:62153
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728402AbeHMNqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LEdE+ECOdf1puifqntk4ppGANFeFxEkQwtwOglL1jE=;
 b=JOGQ3JOT8gsc0iy+qfdmombyFybp4QlCgTcDcdsvLfbQAT7JhYzpb54ctI+n0aVE3oMzS9Ka0rk79KqVJ5yS7nBCgcoTA83Zso1USj2PXUBjRqVddb93koQ7G6Y3QRUPKCU31ZGKpGdiQaLb0OR9Cc7U7IcbtvUeWua1J4T92tw=
Received: from BN6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:405:6f::16)
 by BY2PR03MB556.namprd03.prod.outlook.com (2a01:111:e400:2c3a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.22; Mon, 13 Aug
 2018 11:04:19 +0000
Received: from BN1BFFO11FD001.protection.gbl (2a01:111:f400:7c10::1:127) by
 BN6PR03CA0078.outlook.office365.com (2603:10b6:405:6f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1038.20 via Frontend Transport; Mon, 13 Aug 2018 11:04:18 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD001.mail.protection.outlook.com (10.58.144.64) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Mon, 13 Aug 2018 11:04:18 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w7DB4HSD021362
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 13 Aug 2018 04:04:17 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS8.ad.analog.com
 (10.64.69.108) with Microsoft SMTP Server id 14.3.301.0; Mon, 13 Aug 2018
 07:04:17 -0400
Received: from [10.44.3.40] ([10.44.3.40])      by zeus.spd.analog.com
 (8.15.1/8.15.1) with ESMTP id w7DB4GoK013143;  Mon, 13 Aug 2018 07:04:16 -0400
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [BUG] gpio: gpio-adp5588: A possible sleep-in-atomic-context bug
 in adp5588_gpio_direction_input()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f741be3e-bc4d-9ea3-a2a7-d05fdc9cef5e@gmail.com>
From:   Michael Hennerich <michael.hennerich@analog.com>
Organization: Analog Devices Inc.
Message-ID: <09f55bb2-f178-af95-8843-ff5fd25a4eed@analog.com>
Date:   Mon, 13 Aug 2018 13:08:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f741be3e-bc4d-9ea3-a2a7-d05fdc9cef5e@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(2980300002)(438002)(189003)(199004)(356003)(31696002)(305945005)(7636002)(336012)(86362001)(8676002)(246002)(6346003)(65956001)(26005)(186003)(53546011)(65806001)(47776003)(77096007)(64126003)(426003)(31686004)(50466002)(5660300001)(65826007)(106466001)(446003)(4326008)(229853002)(3450700001)(476003)(67846002)(2616005)(2906002)(15760500003)(14444005)(110136005)(44832011)(6246003)(58126008)(106002)(54906003)(11346002)(478600001)(316002)(39060400002)(8936002)(2870700001)(76176011)(72206003)(36916002)(23676004)(486006)(2486003)(126002)(36756003)(43066004)(31853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB556;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD001;1:wQVD5jxw6YjfBcqV3DHeGFNCj/Jf+m+KnF3jYotKJvWxVJhKt4BAcqZ4DGQJZgnhFT655bePpjpiAcnxmfHJ0SOYtmNlgbaljCOA2lMurhJL+LuIEO1m09d4NTu7QgoI
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62bd6bee-6550-4a11-fe3e-08d6010c841f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR03MB556;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;3:i6ZoNOuh9ohvHSRGgl6t5SpxGeCVOHdKfRFgj84O9ObD8DRbj5+m3FT3aWEI2AfB7shH+OIKehtqlPIxpQB7v4JHPB8D2+RVmxawYyXgsuupGRSnq6SzbziM30yNp5tbJZ/EhRpIC4NKfdsMxoXsN6gJ5mra2FvWfKHsyM50NnAOf00M/c6fSILN02Q301llvnmHbKfD5FCtPZbnx0+8tNH6ozTkTqxm+vye/GpxmTRj2irkVnGlEBSbJXpLHerjSJszCk5DQ0LNo76vH8VKxRx/lTQ92joXExUt9VnOUKudLvRl3KwCaYkBfaHNG5KZXIocmWoBVtktPdC7VpZb87MOB0I/Q8Y+IzIjgiB/tqo=;25:KF1YM7B0fonsxayocUGA5+QKTDriX9Zq1tUGb1gx+v0/+7acORnJqKX40dt0olGCfeiOkXNFqka7mnvmaKI3SuDT2TeCIHETqu1xEdsSKQ2JEe7C21BYCfHjDgc/q2rCJ4f8J3p4aEheyhSZC/H0TVraB7y6umqA9nB5BuwrTtiHBGco1O8HR3meyRVU1s+d0yKiPJ9CpKdn8/Zgz++s2TSBIJ2DdAnBMpLjSRiHHm22m6Xvu/PNKEUv/JSunhS1R2u0SwvaYc6tHHRN4EabPid9fGywIt47tirYACnXC/95PMUfG9yr6qImrApgyhwAFm5GqJt3Rdu9OYzL81xXbe9shokG0f835IaX2egnkKk=
X-MS-TrafficTypeDiagnostic: BY2PR03MB556:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;31:yNviXshTg/5qlOEsfaW4MuKf+dO75LbS4aoQ6bkFOMuaj5C8WAsM/U39ugPFF1CDCbTSVQPJbABeFOQ5wfyL5Rgbq63Jz0dJipi8EcW9IDYnIKUzZpL7kEDEhyc6kwV/ErqKaemDaQQ+QqGB1QRrrlULVc8ZJP6PLqCMmiEJXCbAem9g52GPBF0s4bdORZwJ7BgS7mAwH8ICC0W7esaxfO357/IG1u2YOVo9swXMn1w=;20:PRBWbQtmchfuR/7IVnV6+ue48FZZGWHVUyfKauXJFvyF5ByoDstWiY+pyBK9+jVfowOWPG2iI2iaLz9tOM8fhFJkEGpdFV6GLndqVlAK+x1rf9pDl0CdRTCVScsfKduwidIvHNYXnpkeZhTUoLRHcInXilngT7O8+GgNM35ls85VwmqUARnoV4HQPnRtrA3K9pgtruPDIteeq2HUyZcX3ev7RDugC0iEEeXVfeTuVjJxSx1s7ONd4cE1FS3XmROJzQ/diBDCGhJrjiZnKOMM7JhX0X6xRvSYqpm/myGHLBegpakqwuaj2nqMznCtqX9mH7zZzIUwfcRg0oRpwro15D2rp+eXZNemMf9gH5azMtzoSjTa3379fVfG6zPNxUtTjKT9e86vGhQ2z4a2Tg01okN4gRj4V9i/rAlnlb2Do5aCFKvI3F2WDb04FA9WkvaIoXjrLoHNzWtmJT6sV9ACDSHD7sIc9gd21nQhwIZQ6hUkmO7ti+LpsKmQD7qIkZ2v
X-Microsoft-Antispam-PRVS: <BY2PR03MB5562C04DD3E9FE65B0C1E328E390@BY2PR03MB556.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR03MB556;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB556;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;4:hSluz4JE+Ab6WIpDR+4zV7hfs8eRuXDXPmTUsChMI2VIrLX5luUMaM7URNAbKrRhb2mon3Ag8lcBNEQtDvIO/D1q9v8F/cENgYsx05uwNe5P/4XIgf+j141LWQojc+MA/2kCq/HG6ZC0JL5ZXXs3wKsOUL8VKBUWIynfeWnHEN75nNIg4O/0iAtV1LAEeQQMX7Nvs9S1OuvNwc5NUzVq2NFgHxa26SRYWlneEM4jx7peS0rZXGp3wdu40FRaoOp0nrW/NJBhW0ANBGHQwD4P9w==
X-Forefront-PRVS: 07630F72AD
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAzTUI1NTY7MjM6UG1aVWgzOHVVQnRTcUIxTFRXeWdJVHdNR1Fs?=
 =?utf-8?B?dTJFcW8wb0pmbU5ROVlobTVOZGZrcEFXNHp6TU8wS3puN25jSlR3d0M3eHhU?=
 =?utf-8?B?US9zUEFwa2VKUU14UVBiYldVNmo0V1lDTHZwV0hjTHNjTFQva2p3eHBIWFhy?=
 =?utf-8?B?UDRMeFM5ODVmeDEzQUhoTnArNzI1azhhOXBma1hUZC9PQjl3N1JaSTg1WVRC?=
 =?utf-8?B?NFFMTHFUaHA4a1hRR2gzeGNpUFRreWlrUHZJOWhWUzVRZVM4OXFWc0dydmll?=
 =?utf-8?B?Mm5kVWtZYWwvVVJnYXFTVFRNOVlrTFVYZ2hET2U1WThPU08ra01EaGFLMU5M?=
 =?utf-8?B?L1MzSDZDVml2M3pUS3NQZnNhdVIyYjVjdUlWRWpiMmlaNzZnd216TERCQXdy?=
 =?utf-8?B?Snd3aU8xejEwUnFLOXZ2MEVLZUZIZEMzMFpEd0ZsNk5pcTlOeUxZaFBIeTVl?=
 =?utf-8?B?VkZTcHhQNnNPWDJ1LzRTdXFUbURvLzAyKzVpYWo3WVMyN252T2lUdWZhOXhi?=
 =?utf-8?B?VVBhZzdRT2NjVGhpTUltdzhGV0ppanVCNHVvQUpNYUJjWFNDOG9odWl1SDJ0?=
 =?utf-8?B?SHY0QTFqM05mb2NJeTE5WTl0N2xmZGpZcWVLQkVVU1dDbHRINlRJUVhBNjFH?=
 =?utf-8?B?dzJwQ1RaZzB1RnNyRm9nQnhPczIyTDRCNlN1TnVCK0FjKzh5blRZZFpDT1V5?=
 =?utf-8?B?QUdCTktHbnllaFY0eXNmdGhOWkhiZTk1L2ZLZ1hadURnSFlLTWEvMXpIVW9j?=
 =?utf-8?B?elJTWm1TNmFUWjBtMlllYnpHYmJndjB4aHBrQVF3WTVabEdaaDlCN1N3R3dj?=
 =?utf-8?B?cVF3UDhmN250S00yS24yVXhPZnAzbDdpSDNWZzBRQ3BoU2l6UFhpWnJTVFR2?=
 =?utf-8?B?NlQ5bCtUTkZibkFLd3FsRnIvK3lTcmsxMzRjVlFtRWZJNnRsNkV1bWFMNy9h?=
 =?utf-8?B?LzNwM3VnV05ISHd5a3B1TTBKb0Q4dis5OExqM3l4Yko2Y3huYnFhRmd2Q1pi?=
 =?utf-8?B?akVOcnloWHNwRCtwOWtoeHN6Ump5eEVvU1N4d2QxeTdNNVFnM3YyZXppTmxt?=
 =?utf-8?B?TkVIZkExNTJmQlAydW5iTXhXWWVGNnRhVml0N3hCVnN3ckhoSml4d2c5eWV6?=
 =?utf-8?B?TGJqTXZrVDYzTzZ5dDU5bUk5WHZSWHloRmVjaVhuaUpBTlowNUVjaE1aajc4?=
 =?utf-8?B?eFVCOFNmRHVoeS9UNXBOeWVjQlR5cDFpRUh2Q0NUekRmT1dsT05yWTVVMWN6?=
 =?utf-8?B?UTRjSHdtZUtrbUE1SHVHNnhsUVE1VDVFQi9heEZjSVhRRFZ3bmRMVnZmakk1?=
 =?utf-8?B?S05rbmo0VWE2NG1JbzZKdkJnd0orNEdoQ0gzYXQvTUdnaEFaYXVQZmQxcGJx?=
 =?utf-8?B?NURMZEo5SFhnMjJIeFI1SmVsQ1JjR0VZSFJKTzV3M2doRFFOOURhdFQ5OEF3?=
 =?utf-8?B?c2FKdCtEa1pWd3IyNzlLbExsdkwxWFYwT0VNU1dzaXlhWCtlaWtQeDkrRUlq?=
 =?utf-8?B?L3ZUcWxsTVVvbzJuT2RCMzNvZVZ6NVlRczZ1ZE1XRmxtUDBleFphdS9JMDdh?=
 =?utf-8?B?cmVqVXVvaStPVlNQWlZkTXkxNHgzTlI3aG9TbVk4QmxqM2ZqbHh4aXYxelRO?=
 =?utf-8?B?UzR6MkUvWXlvejA1cFI1QzJvajdDaHptKy9tcUFSNS9yTjdFSE1vSSs2WVBq?=
 =?utf-8?B?cWh3Njk0SDJWb3lWbHphTXM1Rm5TclYvR1d6VWhwOExsWTl0d1lsTFpIczBa?=
 =?utf-8?B?U3oyU0JtS0lBaWN2blhQZGpvWStWMG84MG1TTDZ3RFcyaWFTbEJSTzk1Szk3?=
 =?utf-8?B?S3pPZ01OMWx6VEhUVmE3RHFKajFTbzNQMWtiZnAzRm0yR1dZK1BMaVU1cDNG?=
 =?utf-8?B?UXdZazQyQTB3anZtaXRVYWN2NlBIaFJ3aEpEWkZKalJRVGtMU3p3aTVDU2dJ?=
 =?utf-8?B?QktGQkdVN0E9PQ==?=
X-Microsoft-Antispam-Message-Info: fdFiKwI4G5HN2KDeycTLEWileG6SUmvKLqlFEqaJd0rec4KENFz+8i5mND/Qii2rZZECSg5ix0IJWOkmTuqSSqIpIOw8l5QrQCYG1h7FaKvrxYSgoJYEXU0iGb549BiEBH1wOgCGY77r73LKrmjkzd1gm+r5z5C7xlU/C/nGIqhjMXKRkX5tmrnfpLwsHtR5FnP6seC9P5UdTtgKAsYxqWE5UMzQ6HQ9FYaWqbtyrno5PPZHZQuhs6b+R4nKaZPoBd16TM3GW4ghafQwKMFzTadnZJnF0/rI4xaRclH77yIVLoythgnrCxAYzownvEgPbhgTobAKnEi29STCi24gaiOFF83v5ltAM5ttKwL3FdI=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;6:ZBr6XaXf4U9KSh2h4TnO8Q83KWry0BDzaiHQPcJWQjuyo39AHsWg27RBLRbtt8Qt+Wqo3bSD0t3uD/7Ks2MMpJaI7+Lpj8Wn4TWfFm/BRyPM/76m4MNSFCia3OI6b/xXizn1H95UTBC7nh6Yee4wSnKn6DQ9blEgy4B8/oxKJzr8FDX8R+9ua6SmddidxPoITflLvK5hUwEjbH7f3APZk+GUhTfqY9LE1h0gvVYyPYk8x/SlJLrgvFDM6EvmkbQE8pAWCSpdUQP3X20OQcg2XZulmc6kqCHiOPeNz8h5/LOGipsU7mFL6XukvPr6URY8IB4aA7pokGocLqO32Ntdfgi0m1ja2lZ0zszIu38NufJveH4ihS/NPSqXqyVkRb0yQFu0OypMFz+Q8/xOgO2TqBL3FsvWsvh+883y9EKcBFPIqOPEPXjk4b+4kzTjMKqUC6qM5p77pdqZSpuCKG4TBQ==;5:4t+hvfteaCG4dPDC3gFjXcJEM+XKffEnQOwqF4qa7Qacxf1j5ZmOKGlmpGANnVc1QHAGk4080G6062tJ7zmd/wmzGKLPvOPInwhv5PDsEDJ6sLVl1bNSU6l4z3AtqzHkq0lnJs9mY55XK+InaBWjosmVgMZmQkPkInB1wpm02sk=;7:fA+A4FPCJeow8tO6QM8lDDZJsVNvMlB4dZopxM7DR9mJLxqbkChPT+b0IQW6OJ/7i/OECFkQuuVHro5pgz4VYCzGPF4/XhhMQqFSPBu8NLRsliz0ETAFMES+UeX71pCd0BhCG6Yk0YCTMaz3AkYyLTsDU7OVwhU3RH9IiVGjaH6E1JWLJJGwBMqCaUlT9LfmLAGtlplpCwvNenSoSeiK1OIATVah32l/CSy3+YAjrDaE36tegaelaHs5frgUQdpN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2018 11:04:18.6178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bd6bee-6550-4a11-fe3e-08d6010c841f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB556
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.2018 04:03, Jia-Ju Bai wrote:
> The driver may sleep with holding a spinlock.
> 
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> [FUNC] mutex_lock_nested
> drivers/gpio/gpio-adp5588.c, 113: mutex_lock_nested in 
> adp5588_gpio_direction_input
> drivers/gpio/gpio-adp5588.c, 224: adp5588_gpio_direction_input in 
> adp5588_irq_set_type
> kernel/irq/manage.c, 686: [FUNC_PTR]adp5588_irq_set_type in 
> __irq_set_trigger
> kernel/irq/manage.c, 1350: __irq_set_trigger in __setup_irq
> kernel/irq/manage.c, 1238: _raw_spin_lock_irqsave in __setup_irq
> 
> Note that [FUNC_PTR] means a function pointer call is used.
> 
> I do not find a good way to fix, so I only report.
> This is found by my static analysis tool (DSAC).
> 

Confirmed - adp5588_irq_set_type calls are atomic context and hence must 
not sleep. I'll move this stuff to irq_bus_sync_unlock.

Patch will be provided.

-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
