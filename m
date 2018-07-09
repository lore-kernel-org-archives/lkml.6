Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4A7C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51FF20875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BAIXwSm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51FF20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754673AbeGIIjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:39:05 -0400
Received: from mail-eopbgr50109.outbound.protection.outlook.com ([40.107.5.109]:12826
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754214AbeGIIjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMQ/Ih9GdnkRuI8F87WrcF+0VyHz8hJYQX/0MCwyZRQ=;
 b=BAIXwSm3z727OAWlWMjvpwNNNStWBcW/WlesUM4/XFDFt6JNwo+6+N8rajaFY0UfGLvIyqYdBMu2DaGQYZEh54IRajFtutRFSDnTctzVU+oJE04mu2DQIxWXQVFRKZGr+pw/+0w2zYab3j4ttdjeIOmqbAtojFK3z4XGrQ74oJU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB1344.eurprd08.prod.outlook.com (2603:10a6:800:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Mon, 9 Jul
 2018 08:38:56 +0000
Subject: [PATCH v9 09/17] list_lru: Add memcg argument to
 list_lru_from_kmem()
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
Date:   Mon, 09 Jul 2018 11:38:53 +0300
Message-ID: <153112553378.4097.3204989884654871988.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR0101CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::16) To VI1PR0801MB1344.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5fe88ae-6af2-4938-64a4-08d5e57769b7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:9I8EXdIwStVuzlVoHFiNeqmVT1olGYd3/w8rZS6/wQOh8Dw4gGXHpzJkFnx6e3LSm7sjOqwh203/6YVYGgWpPeStBbHM6Yuvt3oEHwbkyYSAOzUBaMJD1RhHM+Crq9g3rg1bodkF/JKtw0fQjGhaeJdxZlE3zidumq3oDY9ZYVY8FxlbYw95v74oErG5Z4CrDQCNmuDdMIBJW77zE0glNQb7pad+Lfqne5CHOQG9bnxJRL11SzTPD8AY68fOdHCB;25:e9DLiLCNj81RYlGD8p/VKCSoD0Rwf0StVa1bFjV93SFSCEjed/GNosFfO1xjWFbp9ruQD0v+Qda78Yez6mQKe0D5vT//YDoBcf7RITbMuLU+nliuvvfkL6ZygHRm/Hn7Vx7RagZNpK+OFc01hNQ3lIELqN2+Nw8ZRxg+V59q7tK4sUgOe4Z7178LtoEqoaX9UKccOozIcKxGBI6XzITKHsywX6Ub1ep2xRZMOKZHo0j75pSgFlOK2s6FciXkb1nUCAnRU9jUwCekIFsEatEawLAdE5Vw8HiRqc48Gj0T4SoErZvdPzTkz/pBZJyP0Py0A37kBh6X5w1G9YXoNdoT7A==;31:7/cYhIEGBr/T4YZ0FBEMS7JqUz3fYBEQSYGVkTFQMIKvHTpKFJTKax8ENDscHyKaPtND6AREon7gfzKo+2ymaBgiGXslVPFbv3rahR+CZ7c7K0BoEY4NUU0WP3bnyXm4EiuOVG7xiDABRsMZPfmpTySUBhi+MVmZtCLmYUCDpgV/5ymohgyJ1aAAu0/VDy4z9t5JsJz7o79xXW6hCPI5vF5gMNqRDfKUzl9eBKW/3ug=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:031dJYEhoMvEx8aFhyOaf0w+lZYDIVUGVCzV1HkzWFKmx2XLVWo7tguoyk6TN++EPAJmu1NL6JR9vxmeHo3nn5IwnjZEpzeECMxC2DpyvwnRIAhovnqrYZEavcEAWbFq0L4Q/82A+CB2c1XwQDTQTgL82PEteh8T3aUC3epNbaB6y8ICfXHXpg8UvrjP+HYWDXKjaK2mKEGs9T9ys5AwRv2dGsS7idqTxpOz2S32rYp2agRo+XVJQBFByLEBaFHhOlxQiKMO4OBOuyeT3ypgEWPGuVwHhlmOjFLUZaxkdl13FLzNhQI1xNMFgJNxe6P5gl3U1pyy3sPy7sEidRqPb8zC0jmx04ue1w1YdJscoojgV86gAXmDf3ZSbgATlwYzKl3vio1VPU7wSavqHb6BFpDyxiUKs9EFdROckM6RgGgsZeYbBpEDDDTL1JeXhCVzxRt57Dq4mqU+m8BIeYPY5S+7TjGvTQ36GX8IrJV6lR1OcHVtd07KwnAfOcuFlETO;4:PnwGjOGX8i6dKGPPYJgYUEJpiMPWxGgIqN5EwxDkszB35lUhKMb5W9TSuuj9K5FKcpmpWD7urXP5dJdfxP80ixvSVe+vux4pS5ju//4F4XQYoHrdhSq70WeuKuw8mYs12KpEuNkvSBCQ5nj4oO0ArEzAwUcpMETTZTSePwf7qEOohJ+0Ngz6lpMskT0IV3jWCJk6zYKEvmqIt9MnqJoUekzJm3qEAPTtd2HbOZXW32wIFVCUo1VP6wARnUjxe4BWPPlEoKr9SHnNzWdsGgpsW30B29J1Hd67+z1njyWf6D2N1gT3Q9WzafHE+5QUjCD9Uieb7l+/Tppxmt/bjbcaTXMHFXiG4wFPPR981Bol9Gs+MUmc6Q5QSHZ9oIkCIOAM
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1344004269DF182B7291F4E3CD440@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(366004)(136003)(346002)(376002)(39850400004)(189003)(199004)(2486003)(7416002)(5660300001)(52116002)(7696005)(106356001)(105586002)(7736002)(305945005)(2906002)(23676004)(68736007)(25786009)(86362001)(14444005)(58126008)(16526019)(186003)(97736004)(53936002)(6666003)(486006)(50466002)(39060400002)(386003)(6506007)(476003)(61506002)(26005)(11346002)(76176011)(956004)(33896004)(446003)(47776003)(66066001)(316002)(103116003)(9686003)(55016002)(230700001)(8936002)(81166006)(8676002)(81156014)(478600001)(3846002)(6116002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6Vlo5Syt3UjZYeXh4K3VrNnZ3VlZIRThs?=
 =?utf-8?B?ZWdZb21ncmgyUUJrT0xqSENuUGNTb0R6RlIyOUZ5eHhST3R4SXk3YkJPMkQ2?=
 =?utf-8?B?UWJxTno5eDJSdm1oRStuMTIzcWQwMjR2Qm40MDBocjBNaTkyRk1vOHFDWG1V?=
 =?utf-8?B?dlRLSFh2cDY4NWsycUUwN0xpbUo3dTd5Q3lXU0dqTzJXQm9EcmM5RkFEaWNY?=
 =?utf-8?B?ckwwZjlOODV0NE9FTWpvazRMYVBJSk1GeXg1QUx0YjJYWDBWUlJBU3hkQkt2?=
 =?utf-8?B?dldsOU9USDIzcExMMDg5NjZ2ZTFWSmRlbWo3OXBlN2o4UG1yQ0w4L0pUTDVV?=
 =?utf-8?B?TzRiaUh2SndJSEh0bzZyWjBhQWExS2tHWGFpSEdGNHRBZGtnOW5GWVZHNk1M?=
 =?utf-8?B?dkluaERHQkU2V3A2REpSNHdqZDg3b0VEN3V2ZHYzcHdRUytNd0JpL1NrcWZR?=
 =?utf-8?B?bG1oU3Ridk1rREpJaFBxY2FqRHhuNmE1aFNWMmcxL2wxNGZJaVFkM2VWZ3ZR?=
 =?utf-8?B?NUJlanBhVFZlZVk2N0I0MXNJZzZJUWEwaGFLWk1ZN3RzbjdXdWFya2hlWkV0?=
 =?utf-8?B?ZzBSSlhrSkFJMUpmSWp6YWg1U1pwSnFLS1lBcWF4RDAvWUxlWVZESXNNTEwv?=
 =?utf-8?B?NEFkZDlkc25aRXBJaHhEL1N0cG1PSGRiNXRNYndWTi9adUN5WFNSMXdXWnow?=
 =?utf-8?B?VTN4K0ZxclZBYmp6Qmh6bHB6bDRUSmE2N3d4bXhndnhzNHVBRkRPeUdiSFhB?=
 =?utf-8?B?VUZ3YzF3UVVObnFuOURaL3QwNy9xU1ZvWGlITjE4NlMyNjVCUmJMMlJhUk1k?=
 =?utf-8?B?UkZQVUxPeXIzZzMwM1JTOVQ4SVR0eEsrWVBVTk5raFZUTWtOanFuOWtsMG9C?=
 =?utf-8?B?bHUyN2VCZUNibmpFUXZycmdLTHc4MmE0Vmg5K0VpSTBWVENTbFRzTDhrL2xq?=
 =?utf-8?B?TDJhV2xEcFY1QU02eFZITWVQV0VHNXovemtpOWw2ekdOT1FHdG41MXZheldF?=
 =?utf-8?B?Y3Rjb2N4SFFvQXNCS2x5MlZiQmx2cHYyT1F5cmtTNTdhMlorRHFnN051Z2ht?=
 =?utf-8?B?Y3BmZXQ5YkE3OGFaa3drR1hyR3BzV1dmVVY2VGJKQkxGQjdZV3ZweFpPSFFq?=
 =?utf-8?B?bzVQcmtkdXZpcWlqb2lGVEtoV2xaWkZzMGl6ZjhReHJ6ejc0cGEveC8xS1ZI?=
 =?utf-8?B?dm16bndHYkdvdlorRHhVNDRGazVwdkpJKzc4ZTJ3azVaMlA0cHUyeVo3dHdp?=
 =?utf-8?B?YUdJTnJRQ3NtMHFwYlFYQ0pDNW1QSkdZaVI4d3ZiMEdkQm9ERHhCMng4c3h3?=
 =?utf-8?B?aHpyQVl2UzJIc1Z5UzZjcVJNOTNIcmpla21EVEx3WnY4cTR0dS8yYVlGcDRW?=
 =?utf-8?B?MVZ1bEZGQUxmbW1MdlQ0QmxLdjRmWTBnd09UUm0vazBzRHRnRFVmUHFTWnVr?=
 =?utf-8?B?NG5BNkxMMWM0MHBpbmNCWW4rR2E2dmVaQ1pjc3NnVlExRTRPaEREd0V2R0hC?=
 =?utf-8?B?cnRNVVFpc0g4SU5zZkFNb01IOGdFMkFsT1VPVUk3MXFXOWlNejdxZ0NlQ3Zt?=
 =?utf-8?B?QmduV3VCZDhRM2dFRWR0TjFJOVZ2Nk1JWldtYnpBbW5sSkxOb1RCQWVPRHc0?=
 =?utf-8?B?UGxsUXNiWDJUWDNIWkxKQ2VvTGR5WitkQUlBdlp4THRxbVQ4Wk1CUGtmN05Q?=
 =?utf-8?B?SUVhMjl1b2lkb1I0aFQzTEVnSWtScktSc1NEc3ZTSW56dVZLQjBnTWxRckhR?=
 =?utf-8?B?Q3F6eko0YXlNVnRqR3F6SjVnPT0=?=
X-Microsoft-Antispam-Message-Info: YGF1inEgLNhm5V9IVsRQnWaaOesCkKHbqjJdQnuAetTcrtH2EY4vyY7uBS00LwS9UYBj2shiFESYoewvQxJMxh1GpbxGLAWhSA1pm6Xgp2YldtFB0Sn2EAiKjvs5kBGyWQlXzEF+pnphrzz403bAO6RGj/PAzDFHtF9dGKE6P4qSmnNtXL1hPOPl6GqFal7FGeIsx9lZbfNSDSvGQNCXr5WGIlhkQL2SSZ2vtHwgwcQ4Q40N7WPfwpkZRKeDKICyOWIlVjyhr6mS3oFg3JwMV1LgxWgPR0Plm4Il4ZAwidTiDz1xCviKqCIT5aHb1Qc2HcwtgLccqitRPxAT55PCpA0kWSUL1RONaxw7HDCLhy4=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:qPfItkloizqxzM4Yy/BBsruNRB+I98A51Ce1fc5sybEM/LGcKpeYXLiUUv5jNLuqYQ8BJOhkw9KiKwSJRM1tCflgdPaNB7kOihG5OqU6ltEYGbiT+3hGN6vq0yY+h0ob+O/kp+V/nUpOhhzsYpQ16QvHZ9Da+hTXGJK2iX7fKPyNMB7tpUfCstO/ibNmpPpWqQX3WcD94XzmXiZ4B3wnI+AxiW6237YZdfu3ArSq0GrxT27noIHGhjDjU3Ukv26jkAs7pib43+0b0I2om8mkRhInxDeEPzVaWT2mKtzLVsmmb5vDJwmPFg2iKdpfy8hFyze99KuwEpetW7Ofu09LQDBmHjcaEmv90mTzYc5sEBdbNZv+Z+psCDZx5SvPAubIRCepNkmlro/RzsK2yovg/C6cW1x6kJ+BEKKxTvSyDDpTqmdsltf7iaAAPORtwjnEtJDc84PFuSbBmLkmHtVfJQ==;5:8XXhHMj4Iza54UUs8qlaF40B1VEzqHXmqo6+rqJvx8WdOI2QVIC0rpYN6MTFTHc4M4BCJbCbQf10OV09tb0UPIpV/vtuqhL7vxpX100Zk2t/YBeEwbdWJWqZIh6JzQbH7RVKfeOS5ulCpj2FsI2hWCjALaROC6zu8ymDR/rWJE4=;24:GHboIUh8/tuRnws4itqG6Vc5471lnekyeAVCi55sFIx0rYUxuZyRK0pwv+Cv6dJB+ozTGdLCx/blHsV707LbaSrwThqVXaT4Ao7RCKlV8Qc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;7:8C3jc+WATIGgP4iazyMUHH8mXysHcXXVWy4PdkW1fKYfZYX507F2VHbCdnfmYVDxpJyKsrIKi3PcqQww5/hS5OCGZmvr5D8MeHVWV0p1n7VPJ6WcU7UhWZwiHYLRJFDq/yHn+7kSYUw18E7EeWjFSJpzlOGp0ww53QEiE2xaDcDHkLtLPTqoQBfrzIfNqeGQNUaJ9VykUsgaLfbHuPX6bPvaExiWHhOjm/LPjM+ecZRh0Rx4Ke9CrBQRS7m01A+d;20:no7FJjf18ycW/a45ExZeXYRalJfdW68ASCMr2WpA1nSUGtIun4ziIAHWWlt9CbKsk5ejemC2vImuk1f14q/tP4/e4EGAqMgx8cxfy2i10gsLwNuFQBWNP7eRQVT6fpC5+tSyZgfVEZgHWqpOzDqN9pgwPcRo6ypjSN+EoBCDjhs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:38:56.0542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fe88ae-6af2-4938-64a4-08d5e57769b7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just refactoring to allow next patches to have
memcg pointer in list_lru_from_kmem().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/list_lru.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 5aebbb9b2f5b..1fc5be746e69 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -65,18 +65,24 @@ static __always_inline struct mem_cgroup *mem_cgroup_from_kmem(void *ptr)
 }
 
 static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
+list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
+		   struct mem_cgroup **memcg_ptr)
 {
-	struct mem_cgroup *memcg;
+	struct list_lru_one *l = &nlru->lru;
+	struct mem_cgroup *memcg = NULL;
 
 	if (!nlru->memcg_lrus)
-		return &nlru->lru;
+		goto out;
 
 	memcg = mem_cgroup_from_kmem(ptr);
 	if (!memcg)
-		return &nlru->lru;
+		goto out;
 
-	return list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
+	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
+out:
+	if (memcg_ptr)
+		*memcg_ptr = memcg;
+	return l;
 }
 #else
 static void list_lru_register(struct list_lru *lru)
@@ -99,8 +105,11 @@ list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
 }
 
 static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
+list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
+		   struct mem_cgroup **memcg_ptr)
 {
+	if (memcg_ptr)
+		*memcg_ptr = NULL;
 	return &nlru->lru;
 }
 #endif /* CONFIG_MEMCG_KMEM */
@@ -113,7 +122,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item);
+		l = list_lru_from_kmem(nlru, item, NULL);
 		list_add_tail(item, &l->list);
 		l->nr_items++;
 		nlru->nr_items++;
@@ -133,7 +142,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (!list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item);
+		l = list_lru_from_kmem(nlru, item, NULL);
 		list_del_init(item);
 		l->nr_items--;
 		nlru->nr_items--;

