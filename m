Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6303CC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B492087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HfNBau18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B492087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754645AbeGIIie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:38:34 -0400
Received: from mail-he1eur01on0125.outbound.protection.outlook.com ([104.47.0.125]:10992
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754077AbeGIIia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zyuJ+eNPZEhjg7qXlTNia1Qkvv65fieNCXY6msZzPs=;
 b=HfNBau18giVVLbA4y2s+3C2dVubkKQaGI6s1znnYBKnfW1f+d3SMmQ8B41O2L/GKEQZB1GPJ4BWALPfZwMDw4ZL52g14hoTCnmNyTYr8bQcNYBTpH82yjCYAaZX+XEJ+siWOtxd++lqFbToeW98W7Sht3WTiAs6HSP+lR9DJ/Tk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 AM5PR0801MB1329.eurprd08.prod.outlook.com (2603:10a6:203:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Mon, 9 Jul
 2018 08:38:24 +0000
Subject: [PATCH v9 06/17] mm: Refactoring in workingset_init()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date:   Mon, 09 Jul 2018 11:38:21 +0300
Message-ID: <153112550112.4097.16606173020912323761.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR04CA0095.eurprd04.prod.outlook.com
 (2603:10a6:803:64::30) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 631e91e8-b2a7-4345-93c3-08d5e577571a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:pDfrSkhbUiXC5SCJpigKpxdIe8zC4b29Aaz13lKaQPCzUL6VeiJRFyMfHKJaxFkPszxbtHFwchfh9L/AZTUVl19HJyhrDrXJBH9+Jdq9/ILX7M9aMv4vDGnjSaCcX4wSfp8GR5KSBHN0+CKA/AP8B2H8G6OEjvsD2jlokCvbnmSueCjykjkkqmka6AYOOA7TdAk6RHJrDh4r2sc0f+PlupOy87DrqVBJbkVBUEgOEwdCfe28D876M1NPuwN/zkFp;25:/H4outggOxMNVDq05MEpyab+myCEEHORkzMHvuvf3ie7RmXXswiscyH07oF+iC/kIscnrAj2xCYdtGTYkR09fmu5LW34QTtzkSUFI035B7z4ub7C9c6q/3NgzrLNt+CJEe2BtH/m4STI18CzBNGb3RO/3J8F/1gVNdWWur3wWOURe45OT8xZ8Zmnb/qQaug5x0L1FpAQAbhOphQkGNSRzeh48gWhT/4gA1PWZSOWi1bdfXIZeb8jdMHLYMPNFgrVVCS34wSzr9nDXnh8avFP1PLn7+TnfqpIHKiROv/fDf2t4lfIZapYj+7qMFJYn61psJPDP/G5dkgEr1+/sNo3oQ==;31:vfX20ajqEG0XmGyEmrazZxs9yP3lok55OmtN2az58isDWJw7l5xrKyD/S3lfcaEYJ1Uf4AjxB+tRvtD4htq3ahHNnB0hglV9IYMdyY2AyWiz/FSj0WfEdyjeSmcZar8LcISFn9XrK9aSRjC0ZGy0MP5GgRa6BB4Vi35gljX6y2M2EAeowdhloOwKUva1uqUJ15iDXopeNKZNqyme5Rvrm5YJIHo5hxIPc7XYoLOFzoY=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:lAh3CPlwrzEcWnj7jiqa/RNgGO3S/JMCd+JSA3bCb8mJkPXM8cl5neIikgp8brcHZVxUDXcIxF7xL7yLUgEc1bC9TBZpZzdoTsXUDYqgKpIe59gmTNpk1QtIzfRla/fvFktOZt/r5cwbMgQwXZKhmb5xe6VN5er46JnSBUTxNSFzfXyQPCN519AhnhP5LFMYiHdTWUOpaBVml/GPQm9tFeR+zsYRLzRx6R1r914ZHFFgoQxnXVp71i1zYshgHgy9Dusuz5CGAGNEDIiChOE7xzHDHbLr46bKxOwYUOTaC6lcugtEARfCAes8avoe2/4Q7gAZfk2/vfIOhx/cwFxxSTL2eKJKnSwEfazhWeCPkxrdfPOPkKZk7kLwygWfOgJeRngs7vnX6llA3g3DTKzwiP+isjqpkchL4F1h9QKuawUFP+0GqCDXmnpE28KzZsUItVcCTXM67gIhUg4Tn8mbxEr3qDE248TLd4aGTozthey7iAUGsLodIeN/beEFoVLE;4:vzq3XGve/iwXObeTyQh3se8qt5VFnIB/oYgvLlxxMe/fAtobRMRfPL/1JgephzJXgAljRnFjKgJGDhBBhQVT8QEGUNn9IeIxKfozUiyPQF0yQldItvxh9fyqewqsHM/sqec6dFN+CPqSVnr2xbtsx+KV5kGVFly4/e8gs9JD5Td7ereEOCZBir8xRpjRFmxJJOhCnkW3aIx9etLv0R5S5tfn3QTUuW3U9CTlfgero/rKt++BL4H7pSYvPG8AiL+1LaIR6UCh/xXaA8UjaJMgomegkTehKWy6aB5h6UHr8wV3Z9XYXHFiYa/GjnQDov2FxYCr022mE6MR8bRHwnmHp4g9ijl7ty514l4abVGhHNt571lNsozBiF4QNldoTHLN
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1329E8AF8DFBDF4056ABE710CD440@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(376002)(366004)(346002)(39840400004)(136003)(189003)(199004)(476003)(305945005)(97736004)(55016002)(9686003)(486006)(956004)(86362001)(575784001)(7736002)(103116003)(11346002)(53936002)(6666003)(230700001)(68736007)(2906002)(7416002)(5660300001)(6116002)(3846002)(316002)(33896004)(61506002)(7696005)(52116002)(2486003)(8676002)(81156014)(81166006)(8936002)(23676004)(50466002)(6506007)(386003)(58126008)(39060400002)(25786009)(26005)(186003)(16526019)(14444005)(105586002)(47776003)(478600001)(76176011)(106356001)(446003)(66066001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6NVc0S2JpT0ZscDN3WnliNDJyTHFBQUhi?=
 =?utf-8?B?YW03QTlwSkNySTlHalQrTDVnYjJxYUV1M2MxR01HQnFHaFR1dDlrWVBTZUt1?=
 =?utf-8?B?empYQlhuTVVHdTRvZ0ZGYlVBYTQ2dklBMTl5b29rSG5OcHZ1U1l0ZHBqWEdZ?=
 =?utf-8?B?M0xySElxNlAvOGZmMEpoQ0M2S0x0TWhNY2diQXpKcXhXRWc3TktQcmROMDJu?=
 =?utf-8?B?Wjg0QmhHQ3VGdUllV3JrL2h4dkUwcTJtcWk0SkhPNml2cVV4RUhpbHZwMXlD?=
 =?utf-8?B?ZDQweitPRUdPR1YxcEcva2Z4RmQyblRmZGJta1ExUHV1VFJzT296Z29OTTlI?=
 =?utf-8?B?THpmbGN6TUt1ckl4cUsxd0svbEYxTUUwd1FMSU96alphZzVXOXhYNFFJQyth?=
 =?utf-8?B?dmpRK3JGNlVaN2dmN0hTOG40ZmR5VWRTQk5aYzlCbEtUbStoQjZEOXdhSGtQ?=
 =?utf-8?B?WWlXYkRLWHY5UVFxUy91WmZ6MjFTYzZqZmk1VXNlVzhMbTBJWW5xK1gwSmpq?=
 =?utf-8?B?R3JuM2xTTlJoZXo3cTErRm50aWtHQ0hMOG5qRFFscnM5RjdIMG1zNnM1UEcw?=
 =?utf-8?B?cEdPOG12OFJQSGd1YXMxazVPSFRvUW5xZFlsZmZ5bHBJdGFlTTYrZU1DcHhl?=
 =?utf-8?B?Z05lUHVtSkZFcXdFaEp1QTFNaHpvbFJ6Nzd1cVpXSllPWWEyK0FpRGlRNVRn?=
 =?utf-8?B?SHVTWkVRR1kveWJVYXJUbEU4K2hJcFdaS29xZVh5OUliQ1VtL0kzZEFRRE14?=
 =?utf-8?B?L0k0M2p5eFJPQWJTM01tWmpGclFGWE5VUk9lczlMbjRQZ1NsYXYyQmlraFhz?=
 =?utf-8?B?SFM3NFJ1QzNYcTFaVmtud2thNnpkL1BMMkorcW82R3dEemhWb3FPVUZXZEpm?=
 =?utf-8?B?SkhaQStNVkFmQ2VzRWtvNThqb0FjaHpVRGRTc1BTcVRWRFpnMXo0WmdTR01V?=
 =?utf-8?B?YkJ3R3NNcHNkM2JLZGdNRTNtdjRnbHpsSUtUUXNKQU50dGZRbHpGZitiVGlw?=
 =?utf-8?B?VERDYzFQRXl5aGVFSXlyajRLelo1L1dyMDFWcXN2emJMWUhsUDVYb2FjZ2lW?=
 =?utf-8?B?NUtvY3Zjajc0UkxYNnM5VEVKdGFmZURDMzQ2cGliSUpoU1ExM0xrVUlFaU1r?=
 =?utf-8?B?eWIrMzlyUURCSjFsNzFGS3czWHI5L1lpb1Q1dU1rTko2b2FNWHNiYy9lcWhS?=
 =?utf-8?B?TXRxTEk5Z0kwZVFBTHdtYlVxNFJJNGVlQVJoTTJ6OTR4R05mSEFIVjhoNXBQ?=
 =?utf-8?B?bzFWbWZ3cWxMd0NTVDRiS3RuZnJSdUZ1SDBTNXRWVXdneGVJbi8zSFRlbGdJ?=
 =?utf-8?B?Sk93eUJUYWh1RC9waHBMNmVGVW52SjZrSnBubmxGd3M3dFFiNnRUZEM1eHp3?=
 =?utf-8?B?WkdVcXJPVkZwbHF1NmcxdDFFdUJLQkJsVGZlUnNzQS9EVld3VlRkY3RTbTZh?=
 =?utf-8?B?bUl5dTRxZU9XbGZxZEdvVVpTMDljVzl1UEVON093RllqaGc1Y3Z2dkJ3Ymhm?=
 =?utf-8?B?QUk3ZHVmTWhkWXRka0U1MWVFTnFhR0hXeS9Wd0IzRDI2UUJBL1pQb3Y4OTlQ?=
 =?utf-8?B?aElqSmlncHFmTjJrK2ZyVEFyR0VZU1VLR3Rmb0RzUmVCMTQ5YjQ5cWhQdUIr?=
 =?utf-8?B?Wlh4NXZvSzE5MWdFL3NCR2s3OHNmc3V6S3cvMnRsR25veGhBRjJkRVBTbmhE?=
 =?utf-8?B?MkwwblVnQjkrblhDQ2JkaVJ5MTVyZ3hmNjUyd2pUNDFOQmZ1a0tmOFlaQWRP?=
 =?utf-8?Q?8GQrbDjAyE6qoUDXDUggbyWAz1WMZiuGMyPxFPI=3D?=
X-Microsoft-Antispam-Message-Info: 2xpHNb4elw6O7tzSkBbTZOAtul2gn+fpM7aNrIhuiHROifwRFwc9hzoK+/bsaNhGTQBHrJwlETUMJ9KRhclYs7B9SkIqyB1dW/DJ2X1kkxbJRKLMkwVAhq3C8VvYJ8yslPliw2/lQjfBguqbuIcjbYlDWNM5ZZBxieNbZSjZ9z/HtdbStqdBt1jVh2IQymUiW83AoF3jY5k1CmNRJCt/ciBQgElCsmjh30T8MPmaqEPkTYd7BNvNIs89Wp3/7uNELq48WsnGOa0NDWoSWWH/8pYVNi92Zryzn+YODsV2GSD0qvM+kfW1FwbXMRB+mBQ8znZjGPC0NQC3sR8GG1AQgGA1hYy1wWKzf7pv1TZfrQk=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:Wz9rFfhZiZf3PBhea63thqOnZszF6kKVrQjc7T1lFonnCVwwMb0n/y8kNNE4g+t2IrAeJ0b+yuoSd15L20UVCe2EagC2cV8+thIQPrek6EOMRO1X/pAFXThz165wL6kiOpDQ5syObdsypsEmD/jz0r6HjddtjGEsAg0zqE/JW/DEO0ZlQ9leRxPK6T4BW2y2/LP1HfTC6NpjU0riOeJVPm4WEcXaKk3qaoNUfp4JjO5IAmQZK7qYOgG1DvV/UmZlK1o1UC9DvuTK9A+s+P67WbhcdkgK5of74Z3dea8l7Mjrvqh/aLtRrsBxraObQEJ9g2a55PrQ5Lc21kE1oxop/xNkSrcFZxZ6fqt7rI6F2gopGRvont0uVBqv4Y74V57ajsgY0FDmtGgh4YCCwfSnKSiTlqki2a9QCEEUEfTqNOqfZrCT30sqHAwPW5phNurivTuQ+DBnGv50IaDsneESdw==;5:UDmoE4okdAyfP/9hlB5Uh6wuKFdUrz+6RPcJr3bZpuDPnxAXVrYGUtlowGnaLcjtzF9T7I7g3nv+5Vgv5juC1W5Sw8CXck85Ez4MQ/lYt45wA9Tm5NLBXr8rCBtw62Zf1czG+bKaALm7bfLyfuwOTAlu93dDnzE0+cJfWiqeYyA=;24:/4foZy0s4gNTQvvagiAH2sWHBBp5own7zt0g938HW4/z/LM/V0QrQYtTSuJDU79kMF7uWAd19TMMa6yVTmKkYEUkaQZaj9DVfMi69FGiVqs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:0hwcU8duwFOBEoj1InUi1lBRr3KEv4uR56vQ9j16geIGmQpxlcQyfh3CMDqKe+w/A67HDcRcIz96Os28OhpdA4PwTc26s7LnrxKX/2wEVAV/XP3FzyZXNlW5wkzrtHpReiQ5XEPu/Q8XoJpTMf8r4EYYHTrcVvTZMBy7lC+Qd3Hx35YxmdlMG5BMvHe6uFK+rkyS04WaFTa1mfo09C4NqihduLm0BJPxSae3N4JRFRUBEoecw/CSaZC+HqfPYyIU;20:wfZ7BSLq1PEol4G71kgx8eqLVHS5FKMyCPJ7YFIxGHaDPGhIy5B6W+wLe6n/zN5BGZ7SBxhN6nOVGA9UyhStMduKE48eeoVscYgGL/1LmL+XArJinYS18DzVZYCtH73YGW9XolCJiyfZVIdsQ+Z8tbfPtzU9ZMD1cDBNBAgfNXQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:38:24.3177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 631e91e8-b2a7-4345-93c3-08d5e577571a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use prealloc_shrinker()/register_shrinker_prepared()
instead of register_shrinker(). This will be used
in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/workingset.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 529480c21f93..4e0b2523aae2 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -523,15 +523,16 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 	       timestamp_bits, max_order, bucket_order);
 
-	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
+	ret = prealloc_shrinker(&workingset_shadow_shrinker);
 	if (ret)
 		goto err;
-	ret = register_shrinker(&workingset_shadow_shrinker);
+	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
 	if (ret)
 		goto err_list_lru;
+	register_shrinker_prepared(&workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
-	list_lru_destroy(&shadow_nodes);
+	free_prealloced_shrinker(&workingset_shadow_shrinker);
 err:
 	return ret;
 }

