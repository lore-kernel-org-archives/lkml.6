Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21091C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5ECD21A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WtTkU8kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5ECD21A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933655AbeGCPJj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:09:39 -0400
Received: from mail-db5eur01on0123.outbound.protection.outlook.com ([104.47.2.123]:31104
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933039AbeGCPJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGwDrx1nn6aZhN7pKlGi7jUOUb4d2BKvdbnM2cvitkk=;
 b=WtTkU8kljaeNHqg7B5shFa00tWkGTIzcluaVmeeFs0XDGTNLxEblbR1v8MVU+xTEHC+kXhNYELJz+Kyzw/1KcUTmtUbBofm9GzqIMNtEOb6GRGWl0NeQfOOMkQUV1MxsA49waQ4zMvxeW4YmXa6dWFSSLSiq/wmLmQznid2YCB0=
Received: from localhost.localdomain (185.231.240.5) by
 DB6PR0801MB1334.eurprd08.prod.outlook.com (2603:10a6:4:a::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Tue, 3 Jul 2018 15:09:29 +0000
Subject: [PATCH v8 05/17] mm: Assign memcg-aware shrinkers bitmap to memcg
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
Date:   Tue, 03 Jul 2018 18:09:26 +0300
Message-ID: <153063056619.1818.12550500883688681076.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P193CA0011.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::21)
 To DB6PR0801MB1334.eurprd08.prod.outlook.com (2603:10a6:4:a::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfac2bf8-4bbf-435e-07b0-08d5e0f6fa94
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;3:/qxvYNCrkQwkaMiujbzFCMb/QadDRlrkB/zpTif7N4gj2U3pXQfN0+P70aOP6BbXEq2pmMUBiy5qkdzIku37h8UPGfJWEYKvS1rdiYNIuZMk61D+h2IqWpS9Gk64q4R4B53gtk2R7uUPZbMZF7oZ1oaKHP7MatfSnUsj3drVMpn7KYx634myqjdrJU7PLQEorqfmwgCm2mH+4wdSxVQ36mBJlCiV4LmkHAn1obM//7UXUxQ/D9DbvzWTdW7oFFsx;25:gk19Uhpx5/zmlQsogppaTuP5ieIayiDdjWvEVvJ6vg+JSFBG6WaXhh1zzgQEpdGIseuPnHRzWgfBub0bgccXsVQETFC2Iqcb8XspyCeK27Z2pDBkEhJJW5smroi42Wusxv3QBjoYRgLIp3BJ8ipmO/VbfM2ByqjKS3fpj2U1+gmUj+ovBMOwm3udqU5DUGIeMYSPZ7IqJi/ICciEXhzykL0SUCj4nYdL2+StF4K73oYrhz4x8FvLvco6eqg49RIX/23fkt4xZ6u1InBL0zdaxJXfam+g8UlvOrqn/4B+SMC3vjKMDOYuhKeAaWxCTQxKB/v9DKCHLwzMXMRYEGQAqA==;31:G/gQvE9H/cSuDHaeKS8HGhvzrFnINY9KsojJOJ/puWZ5QOzw4oP5HDosZkteNfarPwM1eDZLZTsAZcN33DKocpatyUdtWsk/mixmDCLL4l74Kq+SVomPyzCSwVdwCUE4SS4i3EcCwuMye2g8S4E0JiVorMpqlpQHSz6biMQwJFVp5C/PJNHDguGE1DuGgWcwHK0wZh5f6xs5Dj3kEkEeGmxYs4WlZMi+Uk7Ans2FcYY=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1334:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;20:YA779x2g1IPjjOvgb+VUTZI2XnaoPC85NMXiwbAyHMOIVuuNo4JV5nxl5t/FJDd5Ywp98U4Tg39pqZBKCUIgI0eHguyYCx96GtQRnvCDSwlPgpGZnbsZ55WPBs/qZ+u2H3bBSD5+WfqESg2YFhlpL/xZnXOQJ17wVGFkQIdSd8G5TrgwztohNAAFICw1NShvrPtCVGzkkuiyQG1q0Gmq3jGKiGSbdyzN/35YF7T5afFieH0eNuSXgCkEe8J20a/947+eCBxiN2dza7O8sNyH3YmOEJxhqkF8Yb6ZwqTGgoGfJW5Q3LZ4BGFxZSYWgqiYcRNrS65fXIBrSyzMuTSRXdfLBkAYYNMRJdfL7Aomu+C4guvi6t2K0o6o2SngKqmGxC5aPEH6z+co48Z4JxZmkh1D+OuXt2HZ2TxWaWrrimG5vvh7pOX/A0gEu9w3Zj/TEWO1F34/+RmoqQseWZHGhljHyQY1irX/dcC8w39a+N2vsakoh7hDRXgjP7C7YUE6
X-Microsoft-Antispam-PRVS: <DB6PR0801MB133405733D08CA3C13E4A131CD420@DB6PR0801MB1334.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(131327999870524)(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231280)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;4:NvZ7bQ4+/pBUOI9oYjno7WqrXWCOFcnVh6S9mu3OjW9xv52GatfWPeHW6T7EtFzgprDO60o3vMXeZy59ydekBfJom54qFln+r5n8DrWJzESFryD7vbvsnTJjfuaSGHzZLtXM/0iXR7MHw0BKUkE0E3S1/6UqDZ95KggIgmplbWI993Ed+lQQlC6lu09ErHoEQHn/+U2IIqThOYXIgdIGC+xoS08xWdpKco4WlWcJX6xZYh0K7DaNCR5xX+T3gf6NAERnA7OdUlRZPJQ9r1M8xPrReQ1KLQUdZqR9stZMynaRWQBN8NUu98wvWOK4t1Mb0Siv+B2HK1KGWuiCTBDYCQmMspKuVWOppTpgNOlcQJedKRxxXAJLTZOfAMpPfKS+VF0Jc/hcOQBrNXbFsUYHZSeZcp+U6nfOyiZtqVQxdWVZNVRuYEgy4yw7OBlgqueASvi4bSF18mCiTJKcR5ZQmg==
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(376002)(366004)(396003)(39850400004)(346002)(189003)(199004)(53936002)(5660300001)(39060400002)(6116002)(3846002)(106356001)(23676004)(316002)(2486003)(86362001)(478600001)(33896004)(7696005)(105586002)(52116002)(76176011)(6666003)(7736002)(50466002)(8936002)(305945005)(7416002)(81156014)(81166006)(230700001)(386003)(25786009)(2906002)(6506007)(8676002)(66066001)(103116003)(68736007)(97736004)(14444005)(486006)(26005)(186003)(956004)(58126008)(16526019)(9686003)(61506002)(47776003)(55016002)(446003)(476003)(11346002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1334;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzQ7MjM6cjZudU1MOVZrVVVFVTVrSVc3TFhSZGdW?=
 =?utf-8?B?ZFp2Y2NUN1k0dU5rcDdXVktGbW04RE56d3dUWkRGeWNIZjlva0tCL09YVmFw?=
 =?utf-8?B?eUNvVXJ1RCtkVncwQmZIYmlpS1BwcVBXN3VxNlNWbnVkbUpjRFdBZUVzZ0pm?=
 =?utf-8?B?bDNPUUh0bHVLSTdHQkJ3d0ZHWTh4UjZvUmc2NGthbkF6TEMvZUVkQ3pLMWkr?=
 =?utf-8?B?VmpwOFhDUnpBTU5DK2hia3huYVQ2WkZYTFVoNWRxa3hlU21VVHVqSHVTbnJT?=
 =?utf-8?B?dlJlbkIxajFRM2VaUithbCtxUkcxTEdRWW1vVXhVelVYam5yWUM2a3B3bHFZ?=
 =?utf-8?B?R3lZdWljTVEwdk9RKzN1dzlxajcvNHF4QkNLRWtxYW40c0pmWUp2TFZ3WUhF?=
 =?utf-8?B?ekkyZ1NtUGRBMUJTOG1mODBPZStSQ2tiVWNNaUsvWjdmT0NxVmo1ejljMjcy?=
 =?utf-8?B?aGJ6TU9SMWpXdHV4ZUlPQyt4citvWUIzUjd1MDVGWWZ0TXFoNDhEcWhYa1RX?=
 =?utf-8?B?OG04dmFoS2JMSkZ4eEIzMkN0dTZINnFwVjFEaDYxNUVnZGd6NUZMSW1WNmdC?=
 =?utf-8?B?Q0JWWXFvd0VlRnFYbVdmcHR2QnI4R25oWWs1VjJaWDdwTUNGc1hxZGg1VmJM?=
 =?utf-8?B?TTJCWjBhTVZtWElTOXQyY3dhLyt4dVRReFdNTnVDM3c5MDJPY05IcWt2SjJP?=
 =?utf-8?B?OXViaU81dkIvVC9lOVBWbUlLSnJjU2NQU1dCSTZtUnl5UVJhc0lmb1ZGcGFT?=
 =?utf-8?B?dWgyWVVMMmlOem1vSmVNQ2pQZ043WURYTlhzYlZmMHJlNS9jZnFTcFliVTVX?=
 =?utf-8?B?alAvV0tNTElvei9NVWRWS0daS0xNTEtodVVGcFpZZlFsWGJKVFptU3dhaHB5?=
 =?utf-8?B?SFdjNDN3LzI2anBHQkxZZ0p4WmFiWG9rUENhcC83NE1BWkZtbTJnbmpxQ2lH?=
 =?utf-8?B?Vkdtc1BybzA2N2Y2eExZTUVwT3p1VFRQc3ZYYU1zbHl1QTdnV3ZWcFpkSkow?=
 =?utf-8?B?YURqbkMycFpZcndlb2JyTTQ3d25Nb1JJZkVZMDFaTWJZUGxpdURjVHdLbGZS?=
 =?utf-8?B?aVpHYXVJeldtVVZaUmF3TFRpVzBXOG1XbW4rcm1MQmZaQlEwUXp0MVlXNlA1?=
 =?utf-8?B?RE1kaGN1c0pMYWNFQ252clBtY1EvUWlwWDhuY1p5T1BHSVpzeEdvbTFkM29h?=
 =?utf-8?B?c2pHTC9HZHlKUmpnR1hCekkzYTkyd3JYYXZ5aWxEd1B4RUpvNzk4QXlxaFFm?=
 =?utf-8?B?ZkJ3OFVKRmV0VkRPT0VkUW1pbSt4L3gwcDRiT0xRbUs3bTh6enhkU3Azd2RK?=
 =?utf-8?B?LzB3bFc5UVNqKzkrMG1UbkcyOFJUUDlacjdPYk51MXVCREgybVc1MlNxWW9t?=
 =?utf-8?B?NWZMSmY2dWx5ZHp4b2dHMUpzRnU3eXJRdUs0VkxWTk1OUTNTdzFmNmFLQkRz?=
 =?utf-8?B?NlNiUXFVaU5TcnM5SjJJbkVuQk5UbjJqbkRlS2Zwa3diTzBkNjRPZjRXRHE3?=
 =?utf-8?B?c1JnZjZ6SG9rck11VXdPYmE1b1R0S1llRktsTi9NSkRRbUtJeGFRaiszVWg0?=
 =?utf-8?B?NlFOZzJvVUh5d29Vai9lVnVldGVBVTJoSWNhdW1yZzNYZkU3RkhQT3k3QUx3?=
 =?utf-8?B?QVBHdEU4Mm9NLzZTelB4d29tUmgxK21zUjRxcWRxN2gxaGtBT01zb2Y2RXB1?=
 =?utf-8?B?OU5KbXRyRURJcVFjZExyMkZ4U211OGhkZ1REREUrVVlUMUVieWF2aGVhQ2tX?=
 =?utf-8?B?Y2FwUnZRdFpGSFVnN2p5aE13PT0=?=
X-Microsoft-Antispam-Message-Info: qNwvVKQLdbyqzVIFxPGdhmE7W3Wh9l0ODoAodMagEuwmZHiuO4BnwG9bjE0EQaE9gv6TyHas/qG3S0zpBfQUXe2DFrGBcVp8Z51s2whN+XCs57SzgJY+nwBzE8CFyt8G4TDxjwd5elYbdoGAwKDrz3mtxQGOlu4Bpn33ioEAUsITOc9c/afm1l12L89PpBKYRpVtnpkjuExDMdxjCnbu8Aa4n+NxSlgEWFjeWK2qWBtlvvV8ydQqhqrSwHtnLjAQPGLgJCHfOzaf0qhvX+V/S2WQpdr+TKHayp+jYtNLaoW7R+W9lSI78IkhfvFaChh+jyxtTY1P+M7ZJM1XvCb/tgy/qVkOfm32yjIWt01mBlg=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;6:19IBr08oPvax1mFM7XNec1Dy89Blpqn9+wEJH11CwvFwLl/+MzewypV1+WuPpqJPMu7x8NO+C3wASpprJS+LlgCHUOLSHWiloWITgTZQ71gKAlaK5wZMuWvLpTBlHacEPeoe0+m9IDNrWwCRiBVUlsRR4fM6fuToB9j7NBOVvisP/ZXzikPKzONQ+nryKtpH90Gwzg0hiCu+Nqfp15AL3gY1V7V51NQjczaNjfvF8gsAcozPrX4bn4hlobFkKI2TI05BAdqaXIwOie/HxKXqBq/eG1kMq27A+FWssnbxP0kMYfBTSS1MR//o1fcQ8Nu0MY9YaNerM4POpa/ZCqBRigUoETNNSLLBH1+Ghk6Xc1oSO+vrkIB58yNIYgDCUAb1OPQbgCpca7yliv0/lmazexD/bYXqC+OpcH2axdWvgp6BbGLqGEUJ0E7KeOh6GSFRxFRMhrQNK6Ra1oCFiVkIhQ==;5:x3M3p55NwXgdGd3WCA0bmq5khje10klv8hbyxi2WB+Z7aEtmhfJuFg+aa5T1nJNxmzlyZwzWRoPoG1L2P+QzIBFtbPtsLDs7dUFYEN0dv9/Z8YzT+ZNnZrZng8iOryPd5jR14qRvY5WOi4mIQ0enEvRhj0odlvLYXLc9MUwe6dw=;24:uAe1vqTJFBF/VLWT2OW9Ds8F4oe5RmIiyf7GLN5C0ipagMRnL8MRUVo/GkMRuL1Jxt67J4n6UfXdzFxv4uwQhOWJs766WFw6BoJZkq14He4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;7:w5tJzWdLHegT2yLsC7641EU95mhi407AlkJJNcae1ds44UfXTSbHW48Gnrj/3teF8LNG8kAKlmEW46xL0jsTaFsQuofLzIywhe0sSRyEuNRzYlAGlbNvV2eGS8AGKYYgCmSAPCBJBWg92Urtf7nZUD71Mh3KPd7IHsooXkBtd446RAyO1SaNh2bx5CiOAuJKIn1ARVN2UC8CUNua1t5OyjYdoFlFG2xhIQzKIug1xwhBMf8zReb516YqRh4gohlG;20:ibgISA9XDYW8noq1jS1cxlwT55iKZ5GDRkD6o9xXcSfl8+bUPspR6vxbEjCv1ASUh3WRVPEyntU+mI5wWWCxxHnx9s0wlOZnApyy8IfD8UMfgWl9XxvV8DghCiHB1TEqTAGeRfz4ck3IFIJ1f93kWPiGIlf/TUkgDPclcU0v4X8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:09:29.4509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfac2bf8-4bbf-435e-07b0-08d5e0f6fa94
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Imagine a big node with many cpus, memory cgroups and containers.
Let we have 200 containers, every container has 10 mounts,
and 10 cgroups. All container tasks don't touch foreign
containers mounts. If there is intensive pages write,
and global reclaim happens, a writing task has to iterate
over all memcgs to shrink slab, before it's able to go
to shrink_page_list().

Iteration over all the memcg slabs is very expensive:
the task has to visit 200 * 10 = 2000 shrinkers
for every memcg, and since there are 2000 memcgs,
the total calls are 2000 * 2000 = 4000000.

So, the shrinker makes 4 million do_shrink_slab() calls
just to try to isolate SWAP_CLUSTER_MAX pages in one
of the actively writing memcg via shrink_page_list().
I've observed a node spending almost 100% in kernel,
making useless iteration over already shrinked slab.

This patch adds bitmap of memcg-aware shrinkers to memcg.
The size of the bitmap depends on bitmap_nr_ids, and during
memcg life it's maintained to be enough to fit bitmap_nr_ids
shrinkers. Every bit in the map is related to corresponding
shrinker id.

Next patches will maintain set bit only for really charged
memcg. This will allow shrink_slab() to increase its
performance in significant way. See the last patch for
the numbers.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |   14 +++++
 mm/memcontrol.c            |  120 ++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |    5 ++
 3 files changed, 139 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 62309f180ee6..d8c38eafa251 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -113,6 +113,15 @@ struct lruvec_stat {
 	long count[NR_VM_NODE_STAT_ITEMS];
 };
 
+/*
+ * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
+ * which have elements charged to this memcg.
+ */
+struct memcg_shrinker_map {
+	struct rcu_head rcu;
+	unsigned long map[0];
+};
+
 /*
  * per-zone information in memory controller.
  */
@@ -126,6 +135,9 @@ struct mem_cgroup_per_node {
 
 	struct mem_cgroup_reclaim_iter	iter[DEF_PRIORITY + 1];
 
+#ifdef CONFIG_MEMCG_KMEM
+	struct memcg_shrinker_map __rcu	*shrinker_map;
+#endif
 	struct rb_node		tree_node;	/* RB tree node */
 	unsigned long		usage_in_excess;/* Set to the value by which */
 						/* the soft limit is exceeded*/
@@ -1284,6 +1296,8 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 	return memcg ? memcg->kmemcg_id : -1;
 }
 
+extern int memcg_expand_shrinker_maps(int new_id);
+
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 74247a580cdd..f81581e26667 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -320,6 +320,120 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 
 struct workqueue_struct *memcg_kmem_cache_wq;
 
+static int memcg_shrinker_map_size;
+static DEFINE_MUTEX(memcg_shrinker_map_mutex);
+
+static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
+{
+	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
+}
+
+static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
+					 int size, int old_size)
+{
+	struct memcg_shrinker_map *new, *old;
+	int nid;
+
+	lockdep_assert_held(&memcg_shrinker_map_mutex);
+
+	for_each_node(nid) {
+		old = rcu_dereference_protected(
+			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
+		/* Not yet online memcg */
+		if (!old)
+			return 0;
+
+		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+
+		/* Set all old bits, clear all new bits */
+		memset(new->map, (int)0xff, old_size);
+		memset((void *)new->map + old_size, 0, size - old_size);
+
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
+		if (old)
+			call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
+	}
+
+	return 0;
+}
+
+static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup_per_node *pn;
+	struct memcg_shrinker_map *map;
+	int nid;
+
+	if (mem_cgroup_is_root(memcg))
+		return;
+
+	for_each_node(nid) {
+		pn = mem_cgroup_nodeinfo(memcg, nid);
+		map = rcu_dereference_protected(pn->shrinker_map, true);
+		if (map)
+			kvfree(map);
+		rcu_assign_pointer(pn->shrinker_map, NULL);
+	}
+}
+
+static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	struct memcg_shrinker_map *map;
+	int nid, size, ret = 0;
+
+	if (mem_cgroup_is_root(memcg))
+		return 0;
+
+	mutex_lock(&memcg_shrinker_map_mutex);
+	size = memcg_shrinker_map_size;
+	for_each_node(nid) {
+		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
+		if (!map) {
+			memcg_free_shrinker_maps(memcg);
+			ret = -ENOMEM;
+			break;
+		}
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
+	}
+	mutex_unlock(&memcg_shrinker_map_mutex);
+
+	return ret;
+}
+
+int memcg_expand_shrinker_maps(int new_id)
+{
+	int size, old_size, ret = 0;
+	struct mem_cgroup *memcg;
+
+	size = DIV_ROUND_UP(new_id + 1, BITS_PER_BYTE);
+	old_size = memcg_shrinker_map_size;
+	if (size <= old_size)
+		return 0;
+
+	mutex_lock(&memcg_shrinker_map_mutex);
+	if (!root_mem_cgroup)
+		goto unlock;
+
+	for_each_mem_cgroup(memcg) {
+		if (mem_cgroup_is_root(memcg))
+			continue;
+		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
+		if (ret)
+			goto unlock;
+	}
+unlock:
+	if (!ret)
+		memcg_shrinker_map_size = size;
+	mutex_unlock(&memcg_shrinker_map_mutex);
+	return ret;
+}
+#else /* CONFIG_MEMCG_KMEM */
+static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	return 0;
+}
+static void memcg_free_shrinker_maps(struct mem_cgroup *memcg) { }
 #endif /* CONFIG_MEMCG_KMEM */
 
 /**
@@ -4541,6 +4655,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	if (memcg_alloc_shrinker_maps(memcg)) {
+		mem_cgroup_id_remove(memcg);
+		return -ENOMEM;
+	}
+
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	atomic_set(&memcg->id.ref, 1);
 	css_get(css);
@@ -4593,6 +4712,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
+	memcg_free_shrinker_maps(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f9ca6b57d72f..d8b1958c751d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -182,6 +182,11 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	if (id < 0)
 		goto unlock;
 
+	if (memcg_expand_shrinker_maps(id)) {
+		idr_remove(&shrinker_idr, id);
+		goto unlock;
+	}
+
 	if (id >= shrinker_nr_max)
 		shrinker_nr_max = id + 1;
 	shrinker->id = id;

