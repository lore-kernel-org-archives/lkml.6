Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9408C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824D120864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HlPdZSaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824D120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932623AbeGIIiZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:38:25 -0400
Received: from mail-he1eur01on0139.outbound.protection.outlook.com ([104.47.0.139]:47008
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754346AbeGIIiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUHupGFabBwEbleZlH+WMmQacQFn+CRlTN9/kbdjXoI=;
 b=HlPdZSaZgc+BOaAa9jCQjLP6Sowpujc/YLKZkcN2yHAJH6EI4KG1svATYlXXelqgIjPV0j5Pv3nR+7IxlBofyEhIsiE61upa22QKJ9Bp0MytxwhbxCOlnHJB0Gaa8g2PKSXIRaB8fHdpI/RzsED743XvscEwo66VKBQnkJyzZUE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 AM5PR0801MB1329.eurprd08.prod.outlook.com (2603:10a6:203:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Mon, 9 Jul
 2018 08:38:13 +0000
Subject: [PATCH v9 05/17] mm: Assign memcg-aware shrinkers bitmap to memcg
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
Date:   Mon, 09 Jul 2018 11:38:10 +0300
Message-ID: <153112549031.4097.3576147070498769979.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR02CA0095.eurprd02.prod.outlook.com
 (2603:10a6:7:29::24) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36cd0179-2a68-492d-0d65-08d5e577508c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:uTkcmRSqeCCSu2Zbvfqf0bjqTJHe3BWkcRgmRvBC7rk0bscgftfu/LRzpBfAAA/GYjqhTjBmZjYhyTd6w1pHPIYnBE9GDY1mRCbKklt6yYbyCYWP9yPot/1Tu13/oxRx11e1WEgoIvLgUPRQold2VDCRm4CfYDZRbGR7sbLjWNR5dBs+kXP1ku1QiOchyKu73LYdG3an04EP6nBRGaMEdUGp5RPD/qXhpuSr+2OjbQmKssm8uTT1ng7ALK8yoct2;25:wLoOV5II7eZNpbKBD54P8lIQ8oZSkvuAG9WKI2yjIUH4uSryIE4pwq72LYQlfQDab7tyokCoFfCacNrN0l01XGTYEYKPWlY4mffZhBP0A0BVZYG6fNpJIkoFM1GGb/I8sxOmHJaooWldH5PvDioQdhMJrHMLhTWJAA0byksceBvkvwuQ/9NOSiS3qmDFwmkPTVW3ayr+jY2KmZx2+CcdYlM+d8zsw194cdwc933/hk5mN9FSsuaiXsoP7dlXufSid/JjKsqeiU3awxcXSq0AVSuMF2zx6JQPLMQtAju3etwwBm3/MvkZiKEm13doPrJZN8oBQnnp/lXr+8KOxC3Vhg==;31:cslQoeZhRd32ucdirKfM40viQzho9C5X8b5bWNTPCvP1D3ApUTW5u4lJAGO9nvW6t2smRupvtfcGoiQJMuGgdkfGLfvtZVZU8sGV8QlGkqLFBFSmiq+0c2NtinhWQsBp9lPIL5iXTvec0+Z0CIJ8mkzmwOoVR6J9Xd5GnrEkOJBo8qWeXWu0CEjEa2dWLbr9GuncCMxg40Q/SVzDlvO7YOMJoscG5lB5eHZPZI0Xnjs=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:WBwEQ5cQ8O0dKpUTPOT8O4vIh6Foi6i2ChKyPwC6FtJv4wMTFIn8tc2ktkPRnhFcxamxa3xuygE/Unxi7FmBmUDGKIznDemRqxMMRJZENGPJ1h/W1eDOHctQCEosTLa5CW4sgITY5r8bRlF7ru0MFOAWyE3/hgGW3gljTBO2myofRRMOKMPsC3JJCxT7aWLtb/h5d2Yl+wuuYgeAks6sEpnJsDwZqqDhB/hFSSsktsiSJdrFvcN6UGggnPuo13wIP72jjBbyWg+XRpvCGcuP/xjsvVTamFZk7hNE3YirL4hm1P/SPxPDdYSlgDUJxdgHNZ8y2m9xzsTN7BtPvpB65r236opkbRxjse87CY7uKHOy3pxxILB/ZIsIa2TVoH89W7ka1qqAS5H8Gcumth0n1oAzmuCloDSYy7DzezlREjr1N3GhrVukIWC+mvWzOXx+9lt15qQGFHrSCIwSPNWqyrdWwJek9A90AYXbu7ZDLSUA4nv1bLWxs32TwVkXn88l
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13299791860278BAA4E89054CD440@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(131327999870524)(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;4:yiO3O4ml5cY74nm+xJQGOpg13tz2GqrkksIIsPH6vNXFZgRXL5V65ERx2ZoOib/ZNQj6JiIRgLwfsAESQno5NNzaM2qzEDyHah+JUb4kMPEjc1DWRE0AEkvfCrSXQcl7ZFY/9smsv5qD26WqSf70SDXTy2D/r9TuXKmqw5/W1quh67Y//hU6kf5Ktdvx+LmbcY08q5ArCuCbVb5z1VcFrX+dFjMtEVlux369AB5dcSMH4TMBiyTS4GR/s9X18s6SnG3U+2/oKFwWHE32O3J2NL5T5UwXoqvtPZhIH9WsjFzZ8mrQGYovPfxSoTKHqUpZcPk0fp8roLpanJUEJq7Spwt0U+sltQl/EJobI2Go9UofHcUjvZAJG6Uy3QtMOIgcy6S+o8PYfaATUu9kwCS8qmZFcTO/NRXfwPTVrnAfFaTEb5mUTwrjxfd/F4hesjudFAm5LJCSI0Dv36GjWrJe1g==
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(376002)(366004)(346002)(39840400004)(136003)(189003)(199004)(476003)(305945005)(97736004)(55016002)(9686003)(486006)(956004)(86362001)(7736002)(103116003)(11346002)(53936002)(230700001)(68736007)(2906002)(7416002)(5660300001)(6116002)(3846002)(316002)(33896004)(61506002)(7696005)(52116002)(2486003)(8676002)(81156014)(81166006)(8936002)(23676004)(50466002)(6506007)(386003)(58126008)(39060400002)(25786009)(26005)(186003)(16526019)(14444005)(105586002)(47776003)(478600001)(76176011)(106356001)(446003)(66066001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6ZnM5eHBWMHdlQlV3aTNtcG1TRkpGM2Ur?=
 =?utf-8?B?eGxvaEVsWDlDb2pKRUMySXpmVytKS1RRelEwWDViaEE5RXZXTVRRckVhdi8w?=
 =?utf-8?B?bjM2bWZCZFVqUk9jNW94dFNkTVc5OVZVYzZCZVJiWk1YVUdFdnliQTc1R1NB?=
 =?utf-8?B?cHF5a0ZUOTZkNHk0blQycXZxMytoVkFrdER3Z3kwWHJwejEzcEZQMjRmOFVP?=
 =?utf-8?B?MVhzaFJWcnFqUGFZdzlCMkxHVmJTbGgvYzFhNlQ5cGtHVUw4R1JUU3paSURP?=
 =?utf-8?B?THN5eE9FMEtIbVpJSm9wYXJVaWFBQzd0ZDkrcVlmNlVEUE9wd1E2dnBXY0Zy?=
 =?utf-8?B?anY5Z2N1Z01jZmkva3Awd1ZyY0RodFQzVUU0alB5SVFwb1BVbGsreCs3NlN3?=
 =?utf-8?B?VFZSTXIxZWdPR3pFNW1YS3Y2Z0pzVmtyK0J1YVlhb0h5dWFFVzBnUU1lM1Y0?=
 =?utf-8?B?Z1pNNDZUS2pNS21xRmoxK3hRZlRPTmlQUDJrWFV5UGFYNGpMYlF4R3JUbFpT?=
 =?utf-8?B?Y0doWjh6ejJiM1ZCaFZTeTBRTFh6VzFUaE0xNldKVktQd0EwOWV5RVRZM3NQ?=
 =?utf-8?B?K1ZDb3dJOHFpdEV3R2lxVHRuQzJwbHI2Vm1Id0RCcTI0MzA0QnlIcUVQWVFw?=
 =?utf-8?B?bmVESWQvSXl3bW13MXB4RVhJUUcrajZaQTdxcGZoV01qcFQ2M2lscTJXdFN6?=
 =?utf-8?B?K21jamNNQ3hQRDE4NmJkcTFkU2daR0JKU0pma0tWRk9yNk5kWVJ3YXRCK01n?=
 =?utf-8?B?YzloMEYzZGpNR1d5a0ZOTGs0ZDJNYzh0TEEydmlDOGNCYkx5Z2J6NkpLMnR4?=
 =?utf-8?B?VFFjUlcvd0N6Wk5TRUE0QmZqSktMYU5IN2JMSzRTbnhENlQ1Wit6NXNlOTVW?=
 =?utf-8?B?RGx6VzFleU5DZmNwcWxwN2FIZDRvVlVNSCt2OXVDbkZQemEweTNUWGtlVjNZ?=
 =?utf-8?B?QnB6Sm1UQkw3emRVSVR2V3dza0x0V1FINUdTUVNPTFZ6OWdsYzVxOGptNWlu?=
 =?utf-8?B?SkxoTWdMME1FQVQzRWZMczB2eDJJVk9xOWpMUFlWMGJUNEdxN2o4azlZR2NB?=
 =?utf-8?B?YVUraVErTk05UGR2Y0RBZnd4aWp2NVJJU050RHlPbGNPZTdaQkFSK3I0dXZZ?=
 =?utf-8?B?TXBHbUo0Q2FPa000V1pmMmRzMjNFb1ZGZi8yMFBEQk1EOVJMWHF5NmFSWloy?=
 =?utf-8?B?OXEwcHBpeHVldFRzTVQ5UGpWUndXeEtybWxjQlJCZmhnV25BajlmVWhXajVj?=
 =?utf-8?B?aTBBN1BTV0FZR1cxcHZwNW9uQ01TSk05WTZjbHUwdC9vV0pRNVA0cVZ3cjZK?=
 =?utf-8?B?WkMzeFdKNG0vTmRRVjRieW9JQzZZWkR0OVJVYnY3cFAzQXJaNjljKzBtK2RP?=
 =?utf-8?B?cFRpamhMWXB4NnRrOXJLYjJkaXNHZ202SHdjRXhMTGo5alFzcmhaRVZBTGZO?=
 =?utf-8?B?NmtXV1pOVTUyK2dwWk14eXBoMUJ1VlNDV0YzSGZYUFVIM2IrdUZOdmY2RXFJ?=
 =?utf-8?B?QnVIQ3JLWXRCeWU3Q3dKR2NBMWVlQzI4cklGa1RYOTQ0QUl5RmR5MUdhMmZR?=
 =?utf-8?B?Y0k1bUM2cjJ4U2NwU2xHUU5kOXoxUmk3TFhzM2JrR2FqR2xvWG5oK0ZDbnln?=
 =?utf-8?B?TUxBa3RwOVpzRVpDNXFFdGdHL3FJL3RKZVJmRnYrWWpWTUh6MHhyVEZEdEpq?=
 =?utf-8?Q?BF1fQCreusaxDzsUBskDLHpCBTLmISrKm0MgTncLX?=
X-Microsoft-Antispam-Message-Info: +6T0YbPZERPttFSgCu2vSDWqCRkzpK+AG2BZ9WqOO7xlspIp6p/ooEoOnXwR/pmKp2rsTFX3+zja/rMsjZyXtHV+bKodmkC/D5uJcxfxfIVzzlyFVt2rHCPzhMrCP7bys+ANi0fOZUpK1kovdsh1mb3Eq9RC/Ksj3vE3qI9hQk2/DgsJt3jp4fsxIbn3u1kWlXQeH9u9lmPneJd3lBg35ZMan35TacCbrGmxyuBgMlmpJU4Ju9TKG8v1GbEG1qx4mYV1wPH8+zjtf79l0Lq0xMse5PVm0AhaJ6YWlxr82JRBWVwwLNSfwCsPtKgBvWDGTl4GS16VIFeUV2RE6XbBF546HZIHAiiypdizCMEfJjs=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:hTiLhXcBQH9djnijJ8zf8+kW3cKxgHqSBHPdrkFrRe0IiRiZntmHGoj/S7GlO5cAkH09g2/Xk7WOEtNcDKGow7yDJceERoIbSZjYjzVSudmSrru/DS1T5wCTH7Q1C04oi5pWXcGb/7Dp3vzF7XIxY/MgacjugyOUQ8HYJGeGInWDohjEithGCHyPUfPp033kd+MMpugF9v1SDyFu0zqrk2OeYaxbQuVVvDdsnT7oD6Y6mqYi4SOKPgRAwuWYgp4z4pAqjUolIKiS6EiRXtfneFqJNatwgOpIGp5IxPZOea42jhxVmKOYGrs34N4CPt0RmoZCZkbLbn7OHMalBQj+GYwS6IEvoZ1HIfmdFRxPEpN4gTDwB+HHAsumWiiEd+ThagUsPNVmcZzHU0D1Oitw2/jlWmrvPW/waSZAyPtohJn7uN8htM0RxmFa+RGgTZ3KLrfsblB/7duyeWftsoH7sw==;5:5WqhW/s6uoYQwWg122OkzaS+njFnwCHN1u8GDumUjfDA6pRdN7U2AgBtu2O9RXnTx2jKsN6QLfaS4veu2Jq0a9qhySynrxohXI5GCaO8uMlWfWeJX+7EDosv4B+JWgHMwl8w3DetYuDc9lz9mme3DIcXF/jqUcT02AHDk1jH7DM=;24:0MXOLyqA5G4ce4iDqL/uKCi0Yznn+3H9imCLuq6OyXNG2gNnguUSWWPokluJMkokNobsyJkc4GF3AWZvxTZ3ahgUy+PuBtyjoRIyneT62FY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:FEtun6ByK/cccrS1pvZqcCprh6aybPBAx+U6xIX8fjEorqCIojKJ6uDKuDfxQ6ZoCqiUB5NxBGNyr8qTpajSsfGvRPHHiAHdYg3PluW/bjDf/hj6xdHLTbpd7ui18Oliei3Y74FJHMmhulSoRGjbvvn/kLmx6C+p3h9G/v76vyMkHcClysmycpebSQovI0CCqFfFYrYtb7EvbryDV9OW5wvwSTdmNujwGq/sf7iDaNDnv/ih859MOsCdi2bBHWic;20:odZnA6Ufq/+rU+xeWo+rSRfUjvT1q+svvws1HXfloJGjLhmgrtt5bKowSpScurf6sA2DAeyHvi4Bzlr39ZF48JluBTDTs81GzvZVImo55gQW9UOXmIPCdw7DKvdILxb+Wdw+E5i7dVctb8KM5gv+nL29USJr2N3vObIGp0HzqNg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:38:13.5517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cd0179-2a68-492d-0d65-08d5e577508c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
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
 mm/memcontrol.c            |  119 ++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |    8 +++
 3 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 8b35b6903c85..7a04acfecd23 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -111,6 +111,15 @@ struct lruvec_stat {
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
@@ -124,6 +133,9 @@ struct mem_cgroup_per_node {
 
 	struct mem_cgroup_reclaim_iter	iter[DEF_PRIORITY + 1];
 
+#ifdef CONFIG_MEMCG_KMEM
+	struct memcg_shrinker_map __rcu	*shrinker_map;
+#endif
 	struct rb_node		tree_node;	/* RB tree node */
 	unsigned long		usage_in_excess;/* Set to the value by which */
 						/* the soft limit is exceeded*/
@@ -1225,6 +1237,8 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 	return memcg ? memcg->kmemcg_id : -1;
 }
 
+extern int memcg_expand_shrinker_maps(int new_id);
+
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4e81f056ca60..0cb2c7ca2086 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -320,6 +320,119 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 
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
+		call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
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
+	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
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
@@ -4305,6 +4418,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -4357,6 +4475,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
+	memcg_free_shrinker_maps(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5cb4f779ea4a..db0970ba340d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -183,8 +183,14 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	if (id < 0)
 		goto unlock;
 
-	if (id >= shrinker_nr_max)
+	if (id >= shrinker_nr_max) {
+		if (memcg_expand_shrinker_maps(id)) {
+			idr_remove(&shrinker_idr, id);
+			goto unlock;
+		}
+
 		shrinker_nr_max = id + 1;
+	}
 	shrinker->id = id;
 	ret = 0;
 unlock:

