Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06DFC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9732E20864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cuTMXhag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9732E20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbeGIIiP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:38:15 -0400
Received: from mail-eopbgr00124.outbound.protection.outlook.com ([40.107.0.124]:44064
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754438AbeGIIiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1hK7Awiu67JMCzeHuPcwbgMi2b3Go7RVSSEhIrcM5g=;
 b=cuTMXhag6aYgbss2fKZV4rWnocO50yiBxWSJTKZ1mwEJm3M7+LRscKv5GmB/heW5JOIL8O27gV6dFNw24VnrApPZPq53STSjoz8BO0C7GmeOBQ07N0TYZAEtouvUOZql4Ttpw7td47RBZO1k39iYxvny1Rnx2LIAZvYk/Q2YHfg=
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB1340.eurprd08.prod.outlook.com (2603:10a6:3:3a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Mon, 9 Jul 2018 08:38:02 +0000
Subject: [PATCH v9 04/17] memcg: Move up for_each_mem_cgroup{, _tree} defines
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
Date:   Mon, 09 Jul 2018 11:37:59 +0300
Message-ID: <153112547964.4097.16307061428829910984.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0701CA0015.eurprd07.prod.outlook.com
 (2603:10a6:203:51::25) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8f33e97-f062-4709-cc04-08d5e5774a1a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:iEg67L2BQKbPVamEKV2nEGWhy3kJlN7sJwswIgYegqCunJY9p0XOEPd6ZdhKP5Ngxja0NJh+f85lHDAh53SN/5or+OxO12JvbBkS+XyCIqaMPzHYXLhmVkNlOtx3OnIR1kx7lcWgAoqf1b8UNRUX3bq0/eTUWMio7W1/11kOd78H0tgCgIEMrSUD/XzwMchD6cBWRl0R4mFWT9DdyCzENDeIENtka2TmrVjD0lNvED73iS8w/dSiR7B4+paOVJ+l;25:OH8MUPQ/02riB7+Lj5nEB7KsE3lFPEHjRScfw8umB0COXJwEpitqdvHSLdgzC13CyfEh4OeaTQ8FqtrfYAMd7OlKJIwOazTH98cKCt7sWhtnb3xHPDSq+nW2TatzIDY8yDQkCuVusuGsZFFeo2N/pC1iL6jDqCutuEk89NOZLu9/vvQIRreZwZyQbGR7WBfo+NdvpXlLF7SwW+8gKywOMSsK7N82Aclf6JB4V0U/owPM98+QbtnvsRlxT9x8gsnVQEcPdinja7jyGAboexWG77n97iAArb824bt96dAAlUuurz8La2a1WDQirlN3QBOd9z6uy/NvM+DC5EsW2ZX8lg==;31:ozB7TlBkpsy68/pKtSVG0rgg2L7MiO4kBW0uNJ+QtPiPafgvp+t71z0PlvXy25sQA53cd0yE1O6NM5HW3x18cIuaGmQsWQMMsBdJm8viDfUA1RbIOe3fXvMSSYQScPh9zRtZ+yWDrQjG4SVUCl6EPJIx08DNpomC3eNu1l123epwEJIOokuiTKsFBeZjNw/z0hCaqRZ18WOTKyzF8DxOitp4WYV6PucGc6LEjyg0iNQ=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:OP42gz8nJ+4jjC4jZ8tFjWbZMxrXL3z4zKgRf2aBEw17u7sn2oLiNF5mfJPkQIR4ZuxuvdYjac6nY9f78gv/ENaK+zUPmImUrT/TLBVQpDjYtGkZf6dt/UrRAUMN0E0Z0xZtWcIxA9tRSZz8jd1RvAneE0W49EUE+5TXSZB+2FaojxP+c8VJ0GMNjI29DsDNqSDjldXP12HTM5pWZCyBBhlkKazvi1duUN9VtqCtFEn5tXJsfG5lusnIPHlcLTfB+CAwvukkq5EUelYNMkACNt3+d7YYzCWbD7qjlQz5RH49EIlY74knLtzIMWzAhDzevF/E3PX2GeEGkvUwIJKhcQPYVuo0btEnqVkMdVMOu+DXdtRH4jJWVPagKtbJv9ttDOvhU+TR+7xs0VyBGa8AgAmOxcTWXnYKqeE/DCdSBCnGfMjoytBZP7T9PjmlRrJDAUOTCnfYoJXpygeqmkls6e2kA8/LnsM0mzsSsyYJ1P9fMGgJebzEWPoXK/noZVWU;4:R5+wIdK+FEa1JEbxJ3LSVyQ+C7dgWAbg6wn9z3JuMM1muyqPgn4pVBOFsW/Qp3DTtv38fJm4y6bcpdMtKg8Ik6Zx0VPIABqcxSKxx2cBU5/2iVcjmgATMKIbLe98z7ne1O0njesuX1etZCnZXGa8LOhvoc38OqURRp8C+yNDgigZ2q3YXqs+GHjDBzJ3oKrNJKuPy+o5icxxvZyZ0Ej/PytF2mZJ3Vvq3nny+EC1iDoAZDaQEUHI/XDRDsEKFeyZH2/HZoc/n09X50TRwq2ApigsSQiCf7qeVDp1EQT1Seqg9QTEEcF0PruJ3FCun99nAPUUW3/QHkDG0ml2+4Vk8Vogo6WhMz3yr/LUmBqZmjN3p6lz9oR2JGzu3Lb7ZUM6
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1340914C0D7DAF6517D0B10ACD440@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(396003)(366004)(376002)(346002)(39840400004)(189003)(199004)(86362001)(105586002)(61506002)(66066001)(316002)(55016002)(575784001)(58126008)(478600001)(53936002)(47776003)(39060400002)(9686003)(25786009)(68736007)(106356001)(2906002)(23676004)(2486003)(305945005)(7696005)(26005)(103116003)(33896004)(486006)(3846002)(186003)(16526019)(956004)(230700001)(50466002)(11346002)(97736004)(6666003)(6116002)(7736002)(76176011)(81156014)(52116002)(81166006)(8936002)(446003)(6506007)(386003)(476003)(8676002)(7416002)(5660300001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6VlYyUzFTc0trUis0aURmQVF4R2JwQmxB?=
 =?utf-8?B?ZVJoMVlldENmTCt5QU9EOHhEcm1iTVpBNG94WWVZZXJlalRyNlJyakZmTjZa?=
 =?utf-8?B?NCtCQk45MFJXMnFRbnZXQktHMy9Odzh0UEljTk82ckF0QktkdzdVTXpNL0xW?=
 =?utf-8?B?Rm4zZmFVTWhFdFhoTlBNUCtaUk12YVZPdGNKS1plTlVFSkpCdkZ3a3dxbVBx?=
 =?utf-8?B?c1ZocElxc21yWXNQWGNaUk9EZjNZTU1LMnV0ZWlLVXE1MmxDVGhzaE5Mdi9w?=
 =?utf-8?B?TWsxdXdFZk9nMUxhVlRKNHR6OWNONEJVTTZMdGxGbU9pUWh1V0pVc0ZBdVJ3?=
 =?utf-8?B?a2QvRUl5a29ySVhka2tLN2c5ckRYaGpQaUZNTUVpWVFGL3FHRW4yd1BOV2x3?=
 =?utf-8?B?SWtSNHcrNmNyQ1F0NkppL09ZR2JXUnRDVjBoY2FKQ1ZMWUZIMTVmWWJncmRy?=
 =?utf-8?B?eUJmbzhYR0g1VUxTYUw2Z0lkLzVQdkFwb2QvUGpBWFJaeTVtclFoa3Z0b2x0?=
 =?utf-8?B?VTUyRkNQZTdNVGNMakZjZ3l0dVZzYjY0L2VJaHdzU0JlWVdWQUM3cTZsYWQz?=
 =?utf-8?B?SlR1dHZGdlVDc1ljRm9oMUw3Z3JWYXhjbUx5ZW5tcHh0L1I4a05pWWVLUGxk?=
 =?utf-8?B?dVowR0VFZlY1VzJVRW44eWwxM3B0R016b3ZTQ2MxbTJ2blNSbnRJdzRiNCt2?=
 =?utf-8?B?WEdnVVYzRGl6TWkzSUZLMDNJWXFtMU1iUVZCOENPT3VpNjVDWTRzcEk1a2Vh?=
 =?utf-8?B?SElONDlBN3kzK0V3dHlmc3R1eW9aS0VDcTRYbk5oanN3S1FxRzdocy9OUE1k?=
 =?utf-8?B?QUxVMXk3RC9ab2FPWjdoanU5UlJEcGxRMytuRE4vNWJ5VjFmMUVvV25mTFdV?=
 =?utf-8?B?bnhaTzdEbndCTXhSZkdQMFY4R2pGTDhWWHdmeTF5OFE2UFRrQ3RCeFlvbHhk?=
 =?utf-8?B?dVRxdnRwN1RrRGhpZWwvOGs1aG5tY2xDbS9nc0xMSjVEN20yMUJ4cHlvTFI5?=
 =?utf-8?B?ZUpJSHg4Umgyd2lnYWxnUzVwM0x0Q05OK2VnVDkrNTRyVnlhaGNVNnVBQ200?=
 =?utf-8?B?a09CYkZ2QjdQT3JVSzdGR3NsNEREcXhObExaZ1FKL0Y0bllNWmNrR2p3UWZx?=
 =?utf-8?B?Z1NaM1Q5L2RyaTcyQTJUSXJJVGlFSW9TUXEzNHZoeDF1SjE1bllpWnNkMWlD?=
 =?utf-8?B?MDNmUldheHFjZ2xtWFloRTV5L0RtVlR5U256OHZEZ3d3eUlidXFwVjN0ZnR5?=
 =?utf-8?B?Y3hQaWQ1QTNITytOUkZodDJBSW5uTkhQeW5aWWVQSUxCaFBKVkRQMklUWmYr?=
 =?utf-8?B?RHlGbVdTNHpDVHhVaXhpRGJ5ZnNBR09rTjlqVzl0RW5BZDZRaG5UdWIxRGwr?=
 =?utf-8?B?S1kyTWtZeXdMcHdUMDJmNmMzSFdlTkRSTkcxeTFIUHpDQUgyem9vYi9kZmRX?=
 =?utf-8?B?YzBFTStWNW1Cc0o3QTRxSGdicjBhVTNrV2RwNXlQcmtwS2p4WFh1UTI1Rldz?=
 =?utf-8?B?eEZkMGxzVjJuY2JpVFpXQlF2K3Jpb3dPeGJFOFA2aWY5T3Rwc1UxSnFveU1E?=
 =?utf-8?B?U1ZRT2F5TDZ1cUFTQnZpbWxteFpWSWhzNHFNYmIvRTJoYlRVdDg4RmlEL3BX?=
 =?utf-8?B?TnY5aEFDNU5zZHdnNHJwNUxmVEMxS0FnV0diZlpLZy81SVhGNWpmdGpFSmM4?=
 =?utf-8?B?ck02VUpZcUZnYzJwKzlKRzJkRUNNWk5XSUZubjQ4ZGdJbUxjdE54Y1EzQ3kv?=
 =?utf-8?B?NkR3aVNWVWpJMnByVDIxeXhBPT0=?=
X-Microsoft-Antispam-Message-Info: r5Fdjp8cAmEI1LqYQvyFvuUusRcBFCZeF8zSpWO38A4Nx/VLtoxyEicjFkxMbgFEy9rCu0XXoPyEJd8+rvcjo3wz7uoG0RjJk+3YF+FWiG6+gLlOylTyDaz/5cnNamAMWVh3q0VwCNSQOFTAUbMliTyijFSwrHDNV3UU7P20ycjP3Fx5n3wtXrNj7SVjnJpO34g96sjMBYh1o58hiZs0o0KJMQNreMREb/jay3NHXtmB95ojZi1EYH6oJOnsJocTXhF0gFDQN7k7u1QSMzBNRcBaCgjO7eQbGMitef1/eWRGEi6t1exrXnTnfYEI7BBoVBVFd9U1GRYV0D4glQkCc3FjR6nJs4+UeQS44lpohUA=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:OyULnYtmCSWhnKhdcV5zPw5mvlIpEfpp4jfhZAPReQ9HlSucAuGsocvEAEdLWQe0iYKYtZN5F4SxWPdftUZsmt4Fptj/BMly+2IJ6s1gA2Zn5HPM3bN9VFjWsKOCPon7q7eJfC9b91/KRkPvY4780oAJddekV36adoJVLIEQ/R9k10AegfxauvfA9Xhwh1x9D9gYG7srTlC3D8IZDcU4t6L1UO12+sUCXOOX2Btg+SntfPqLyLomf00bz+QeBXuPDF5iVDqhEoEy5lX7WbB1AdNg/RRvkNFVmfUrOoOEISPE2yksf7ZxZJ3+wgyxo9C7Z8vKDD6qpQHdETKr4r0fJQYfvqK2OpV3Gv48ZkkcKTkY3hEeneZ8EISBibFhWx3pf/m8mJ2aBAHZHDlKshqSBl7n8qePE4qvMfHatHfoup8dxGsWPjEPmUfo5vqkY27jp7szB2Lf7kzlS182uV5Dgg==;5:rieMa7tYwJmtqRkZCcR/bOr09kY9EBF+5+Rrnr0jZGC3LIVnZC53EkMo2V2YQ5PqUasFItJl08JUWVJQgfX+zw8AqS/b/HlipQm2enNkkIkyBM9nI4bpO/yKBafb/mjgKa2xXTg3HtwmF1BP8slcfbUj27GeMNFEKBscYh16j+4=;24:wE3oUUrIAf/sEDdD3bISylELz6nzQaATUihiNWd8Z9vSdaYkw4IFrFJUDTBDnVSaqHgmLFL4h8JggChCqjE7kEA8Uli3s+vZgOOjB93d6bY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;7:9z4ohoCSvZBJ1vGe9VeIDt+oeuPWjSercHLVqNPlKdI8RpC6HxjJLwzcM/1CNEuzxFNtPgyp3zbWSiKHaCyAtR8r56z9NfAnPAnqQpJG+Q7DCCcBZyR1brCICwRrtyExsXDJCes29nE6HCTc0Qv9T//gt0m6mBsNeIyXM2yoOEkDWq6d5dIRAgSRJZ9+6LZ0yMRiyPhmWY6PMJ2LIWBCIKCGv8j2NXOWZELMO3aWSu47rUvOMaFt9KceM/Ld9XXr;20:XGc7nWt1cy9/HPTk7+5BOfo/ZSJaOdlTwZp5vG/CIghjt1o91BTBlSkJCUf2w+v7cDXZ4rJyqolSAj0nPjM+vQaOdNKi77g5b2kGBgRP4OSSjEycwDJRIJs70Oe0Rkeq5nuQXvqOm/y5Vv8RM3ZGdj2hKueX42EOiV3NrGt8ikg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:38:02.7524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f33e97-f062-4709-cc04-08d5e5774a1a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next patch requires these defines are above their current
position, so here they are moved to declarations.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 09517a0da93a..4e81f056ca60 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -233,6 +233,21 @@ enum res_type {
 /* Used for OOM nofiier */
 #define OOM_CONTROL		(0)
 
+/*
+ * Iteration constructs for visiting all cgroups (under a tree).  If
+ * loops are exited prematurely (break), mem_cgroup_iter_break() must
+ * be used for reference counting.
+ */
+#define for_each_mem_cgroup_tree(iter, root)		\
+	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
+	     iter != NULL;				\
+	     iter = mem_cgroup_iter(root, iter, NULL))
+
+#define for_each_mem_cgroup(iter)			\
+	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
+	     iter != NULL;				\
+	     iter = mem_cgroup_iter(NULL, iter, NULL))
+
 /* Some nice accessors for the vmpressure. */
 struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
 {
@@ -862,21 +877,6 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 	}
 }
 
-/*
- * Iteration constructs for visiting all cgroups (under a tree).  If
- * loops are exited prematurely (break), mem_cgroup_iter_break() must
- * be used for reference counting.
- */
-#define for_each_mem_cgroup_tree(iter, root)		\
-	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
-	     iter != NULL;				\
-	     iter = mem_cgroup_iter(root, iter, NULL))
-
-#define for_each_mem_cgroup(iter)			\
-	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
-	     iter != NULL;				\
-	     iter = mem_cgroup_iter(NULL, iter, NULL))
-
 /**
  * mem_cgroup_scan_tasks - iterate over tasks of a memory cgroup hierarchy
  * @memcg: hierarchy root

