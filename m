Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEFDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AED42086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NtJit/A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AED42086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeH2M3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:29:14 -0400
Received: from mail-eopbgr30125.outbound.protection.outlook.com ([40.107.3.125]:42176
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727133AbeH2M3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmewPucmCjSf793Nd8+f6Ewx15MkpRucwmygE7Wc5Do=;
 b=NtJit/A+7XZErZJNsTuM1OrMfhSvJjdqH+1npVv7H23B6kBR5PZBpmmdNcqXKl62o6mBno5XWmeMbYcrPrLGxUPZpeTSBt1Y3/mtlTAgGimZbjniDy7aI9dOrLWlbfT3NNg8Njgsh8TJWp0VctSHul5h+tRwQPRSOPBJoUt6HhQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 AM6PR08MB3253.eurprd08.prod.outlook.com (2603:10a6:209:47::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 08:33:23 +0000
Subject: Re: [PATCH v2] x86/entry/64: wipe KASAN stack shadow before
 rewind_stack_do_exit()
To:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>
References: <20180828184033.93712-1-jannh@google.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <73efb4f9-b2f8-703d-f1a0-eefc070bdefb@virtuozzo.com>
Date:   Wed, 29 Aug 2018 11:33:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828184033.93712-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR08CA0126.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::28) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99a3c491-272a-4348-6436-08d60d8a15a4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3253;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;3:bcmfpboWaFKO3D7aE8tRjpBaBW2+BEw2DVE+kmVbFBLHlhrr4nK23bphlHLB0KOWVkW3pMJXKPe2Iqq3VO9uv3zZHePn/Ps0pCeCIYe9eauvf2hpJHTppM/5FTz0SHve8I+OAM1ygqoQwVV70WcmGfid214wKTvsB1VESj3cF1hhUQTLQmdMcmJWJci94vSL3p3Q5QjwLyj0Rb0KPKMhbY5xHMq7PniMH+3CWOubcZ12F13tAgtRS3+1z1ngoffY;25:cTYi3V6mCg3tz+y40J1D6nzN/4FzzqyzxLH+pR2ZnEqIhq/Op0quwFOcy7+2pp2WYYkXHYgTwteckjeq3HZogBqToOynjBMXEZ8lVh9bO5jpr3oTtJvCF1XrzcAYUL6Nz38i9CUp2/ytISeRSSRVqtPfOITxlSy0jcDjFy1y0wuI8s1nsJa0FQFfpuWyfhTxQS6Qs4KmgU06/sqQXeka01S0aegvV3tOl5Fd5Mj4rfQJ69iNthgBjidhX8UPFqAdYgVZWgxeGhYaJiw02cqU3tvtkM/YouI8tdIcxvAN4ZTqL1gVgyUlTZlp46ENiQqtBcHF3oTN6xN++Yz2CDwq4g==;31:2w8kILJ1snD6dPxWGdgSPr9MSXurcELqPd7bSUvS2ilVGyZhuhmO1kmAk2wAS7gmk6WIp4UVHOFIShBfLy/XY9SdzZd7xO1UJOMUY5LKYvVL22ap3V8I08DDdkR/6mQ7Xaae9svkSTeU9+vNtY7MoEi88lEVLsFpvsCJ15fFm+DjyQaXleEg0BeXUc1qUNfuY+lMLVmHCeL8dxaujbvsuI3ZoRIjfnZgg7KOQmxYyxs=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3253:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:jLR2S6CskoewWnoi27IK+vCDDrLHfuQfQsymck2OZx/JPoBCOZCalML9o3KAcOBW/z/GpOSboUjVHxiwIweyJp4/b51kYX5gE0TTB1JtsDHP1pu8w42XwnMjtuqq/Dzm6cxZDth1GgC1f+6cIww3IHOdzUmPc7wD5hgRkdIy4pyn2Bqojip6OarX5hpblH1iD25mjoAIOuTPomSk9NbR92nsdTAL9s28euxWrbJjbt+czj4dVxCtXigaus8MDKnEcEX4C/1BSyxPpiKA5qQyMhZTCTBD9rWy6L4m53k/lSBcySCC67kkX0HqZBtMxWWTMZ7HUMq8l0aS8VAM9qFV+T+sxti7rZnWOGl78Q4h0N3WcZhL8y98YV+QayHpVOzSW5F813pIow7GfObSh0wW+0sTrvpGx2/cOi3IYJO9GpcregoFKZqdShF1Fm5WVhu6C98M6sp/T4vXfufwPVLxjYhwZ3efzT3mUY7+vMC1x29e7HNiKOvygcgJvvkGA1jD;4:hHRqDXH9LcZqhmXmsl772GDInTA9uAd+pKR3UTE8/EQJXt9sM4/Lo36LW1nOLOpOFY3UN89pYaVbVz85PeywfecaGwaXGP4c7Fz9t/wycuBagW+4X2F+sswNKikd5jFAwqEsvf3oGZh16ZUv4gPOvpJngeuyAO7Ko/mYtI6ilILDT3ENvM8QCfk14xxOqDf85G3SQu6XmsBBet8315eq/DeqI9lhZ6m5LN67WhY/N8CyQoH0LSGAlePpOQ9MRMBX8XLSmfgrBUhLN4vckQVsw8DyN29QsYr+/cjbl5nTkNH1ZMftjBLM7yRPzJSSNPsK+e9D0dhCQkVMfI1j6umycRCfSz/2C0vZWhmJ5cPd/n5mEhIOjfU7E0Tf/KfrAlf8
X-Microsoft-Antispam-PRVS: <AM6PR08MB3253459AFFF43A2A69239C98B0090@AM6PR08MB3253.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:AM6PR08MB3253;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3253;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(366004)(136003)(376002)(39840400004)(346002)(189003)(199004)(58126008)(229853002)(47776003)(2486003)(16526019)(186003)(305945005)(77096007)(23676004)(54906003)(105586002)(8936002)(316002)(52146003)(76176011)(106356001)(52116002)(26005)(16576012)(64126003)(25786009)(6486002)(110136005)(86362001)(36756003)(65826007)(4326008)(53936002)(5660300001)(31686004)(8676002)(97736004)(486006)(7736002)(230700001)(81166006)(956004)(31696002)(81156014)(476003)(3846002)(446003)(11346002)(2616005)(478600001)(66066001)(65806001)(2906002)(386003)(50466002)(6116002)(53546011)(6666003)(65956001)(68736007)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3253;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjUzOzIzOmZ5UjJhc3Y0aUNkMm16aGdzNUtNM1pPVlRC?=
 =?utf-8?B?VGw1a3picXRwbUU4VTRUSm1KSkNBS0picmxnZ0lMa3FwTWxxT3kwb0VXSkRQ?=
 =?utf-8?B?a3g3NzVpUDNJRUZlemZzVUpLckJ3UFYxMnA5bEt4cC82eGppTGx4SkJXTjhJ?=
 =?utf-8?B?cURGR21yRHVmSE54VXNhbTFXNFdwWEdSa21MOFdVV1ZxeHdHTDRHSU42N1dH?=
 =?utf-8?B?aWlYN2p3NzF6Mk9HOXdCc05IeUEyV2dEV3ljK0d4RllpNWhFZVRaYjFid0cx?=
 =?utf-8?B?Qk9ib2xXRE1zUFNQZDhOeGlRRjU1QWFPOXNOVG1QakQzYytadS8rU2JCaHpI?=
 =?utf-8?B?RFFrMm4rYklGVUFZYUxJbTEwRVlWMkViV3Jpblp2YnhaV09Ta0ZCZ3ZjU0kr?=
 =?utf-8?B?MFU3b2hKU2xEam1QNW1kQVNXem5Na2ZtWW5iZHp3VlVoWi9aUGFybDF4OG4y?=
 =?utf-8?B?ZFhvbGt4bnNOa3FTY1JUMndIdTRrUnNMVmFQR0RIUTY2VE1zeWFpL2JmaVBy?=
 =?utf-8?B?bDZZalNNeHBobndHbm50QU1GMitGc0ttbmtYdTRITTdka2lzdnBuc3luL1ZU?=
 =?utf-8?B?Sk1Pemc4cTF3NXcvcGdxbjJSQ0tVNENwcWw5ZTljR0ljR2t2RE1GVUhlRWRi?=
 =?utf-8?B?UUpnRTlXd3FGdDJ3WnlVVDNlMjdxOHJrYnBkOUt5MyszYkJXbEk5TU1tWFNL?=
 =?utf-8?B?ZlA5Uklyc0Z6dTZMTXBXZWtJMlY3Rkw2V2ErVFRZNGdoTGpxU3RGdWtSNi9u?=
 =?utf-8?B?dWlEQ1VnOTU1QmZUVjlSMnVBRHdncldLd3R5eHg3UnRIY0dZRWtxbTQxcklm?=
 =?utf-8?B?VDdZTkNSR1ZaQ2h0emdCNHpIVUpNaDdnM3VqLzVtaytIck9LbUo2QkxsSG1r?=
 =?utf-8?B?SHVINVlVSFhxSXFKa1RxTTZxcGEza1duSjUxQTNjdWFjUk5iU3lldm9wL0gz?=
 =?utf-8?B?bnB6RmkxSGpEaUoyMkFSZjZSZktQdGpUQUFXSEh3dDh6TkNuRGZRM3VtTjRH?=
 =?utf-8?B?TVVlblZhalloVG9nSHh2NCtHM0lXY1F3M29OTnhwcmY1ZmdETnJTa05mc2JT?=
 =?utf-8?B?TWtxMEh2ZEsxSFdCeWJqMENKZlFncHNQS0V5dlZDV3pObndiME93Q09HQ2l3?=
 =?utf-8?B?YW5IMnE1YTJ3Z2JHZnB6eW1XQUhXL25XcFg0T2tNZ1pzekxMSEF2VFdGYUVZ?=
 =?utf-8?B?Mmh1NEZXVlVIZENJTzVsNW11dnc2cFpyNTZRQ2lwZUorYndST25YMVE4aHBi?=
 =?utf-8?B?Ri9GMHRkV3JjZzRTMmE5c1F5T09VWmRUUlZMMFhMTE5LcDVnOHlTWEIrUWZt?=
 =?utf-8?B?d0d2SVJiKzJ4ek9qZWFjTU84TjBkTmNxWGlJZVNUVjlseDhCUzR3dW1ncFMw?=
 =?utf-8?B?N0FxbGM2WDVUNjBWKzlYRGRuZXlPbWdFRjVHckc3SGxZcCthYW8wTE5zOTVX?=
 =?utf-8?B?RFNJWWkxdW1MMlc2UFVKbUMwT1ZLT1BtZ0ZUSCtzRmxnU2pMRmFLdFJadHN1?=
 =?utf-8?B?cEJUNHpXcUZYRHdwdUFuT056aGRsODArazEvM3hqRkVDRWNxWU5KLyt0K0c0?=
 =?utf-8?B?a3hwbEYxTjk5ekl5ZlpRZ0daa1JxTWFzUW5XSFFnMmtRUzBoZDI0Z0h0STc1?=
 =?utf-8?B?cjhBR1djeGx5NHF5WFpERitvc2J2OXVFMzBCeFFKV3ZUMWtlR0t2ZUhvdEZT?=
 =?utf-8?B?UlhOYmF3aWFETFFFMmQyTFo4NmxtSDlTN2VwTkMxaU5zejhDRU9ZR3NBRDl3?=
 =?utf-8?B?cTUrcW1HYVVLc2tET0hjSCtVenlsRkNyN25LaFNNR0dLR241U1QvNkgrUjVj?=
 =?utf-8?B?dzJmQjJHeGgxZDFkV1dFVWk2VUg0Z3lOSzVnQk4yRCtaWTE5UTZ2R1hKZVJ6?=
 =?utf-8?B?dlRib29Cb2dGVFZ4a3kzMjJjYmV3SEJETE8yeEk0UHZNUHNsTFdkUlh6L1Fw?=
 =?utf-8?B?NW0rRjA3MHp3PT0=?=
X-Microsoft-Antispam-Message-Info: 7l0ZGVtAZinGjkERvbNADeFc1pp9E/s6do1ndjPHBzwqrTUoZJ3QLXTHtta620LGNikxNk6Z9ZI72lUO9g6Om7hmXDFm/08cXgV5vRpwQMgASDzRD4Q499x2gH7bQvPMbTzoTu72Z54zS17Fb5pRXzUJI50BjVe5iTuu1Q/B9c41uPKk1kKw9H5bbeEdKjvyxgFy8OM9M9KV9RMUFJUxufJTSKWaU9vzg3SVkkm4wju0iE6Si5WnP003bb6ccN2G41FkL1H9BBuFKDChHdnvyWJO1vbwUyl5xOwxRBEoq1cMOQ0RcTdmheOrZqU8Z27qKA4NVFCx9DCcZMVRtGJdsxyVgnta9SJe1LmcN8V80Es=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;6:v0jXumJgkfIHPa9mx4XNUcgLUqexnLcb4jPf+FmMPcGIycuqNghAtDpHNX2ALogV/DTTlCwQUy2e7KdYOz9xBaZJEkTk+KLtOsK6IfWJDyuDovBMmTzQv3nIozrZDE4IyQsiERorzPUA5c24N6+QoY42gGeO9Yba1jRMCUMDoLXnvH9/vak4jNS7g2oAqHnxy4Ncf/CVKYvIpYOcpKP1FmG4ySZgcHEX1ef/tjA5sxIyJ7h8d6SsBpAQHHHkfMdTnIcFDZqLfvXprf4keGMI5F8TOKzEIwA5zfTlRlRBHIZC+/pLaIOtyPI8jaAjZ5bYfa5wASRzO0yTeNNiNOP6Xg4eyA1v13+qPQ23cW5PWMWAOm17YNuQf2F1EugarkVqXjfsCVz8NEeNbWcUAHHgwE1zyHkzGqmiKLlvqShpEQZDBxwVk1zpv4hbVPAj+EhiOkfO9chzZyUjnlYQYuYxgw==;5:P8jnHHzPe1O3/bwA10X0BYIzXBe4WiteWA1aKEVKhrUbMkA6Y6glug3cyfw/bLoHM7YXrA52ZYMf8F3tjOfXIs5irFxyuerYYUZWNbwA7xmrUe4Z76Z2P1VLVLe7YO3rOUITeZFw54BMh4vCbSZUk/zb+N41D8epF+hTW8Vwtnw=;7:i/tIL5Ve6gjNFX571FnywukDsV/9YHPAf4VYz1o5U3o4/Kg6D3KewYRUV9g5TxBfvTBvRP79jtcprKFrB1iTZI7KqiZX6vYUr0peyfj+0oZRfHyz56gLQHmQTnvqnxvewIBBvZFcMI0PXbRmv/rF9j4NJc5oCIa77mPSb0WWaUm26SIaaFo9pfgxcF5XRZmctkF10UhENP6w8I0uo6tU3NkrS73s30SvPhxkyhQ+Rm0MDLyHc1V1mWnjJ3hIsioN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:4opN6lNLTUhQdRhYKPik17dG/tN/fSY5NIea1QUebSxHpEdfNhry5YKcITLmUIzc1euueIGhVt1GwNsaE2RDuOfQ2ksNXVGQO2gsBPkwhyNy1BkScUlvanG3ks0kxRHmmwUBjnai3eURiCYNoFMPPZ0MarXY7+nnB28pnrqRoXo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 08:33:23.0965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a3c491-272a-4348-6436-08d60d8a15a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 09:40 PM, Jann Horn wrote:
> Reset the KASAN shadow state of the task stack before rewinding RSP.
> Without this, a kernel oops will leave parts of the stack poisoned, and
> code running under do_exit() can trip over such poisoned regions and cause
> nonsensical false-positive KASAN reports about stack-out-of-bounds bugs.
> 
> This patch does not wipe exception stacks; if you oops on an exception
> stack, you might get random KASAN false-positives from other tasks
> afterwards. This is probably relatively uninteresting, since if you're
> oopsing on an exception stack, you likely have bigger things to worry
> about. It'd be more interesting if vmapped stacks and KASAN were
> compatible, since then handle_stack_overflow() would oops from exception
> stack context.
> 
> Fixes: 2deb4be28077 ("x86/dumpstack: When OOPSing, rewind the stack before do_exit()")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
