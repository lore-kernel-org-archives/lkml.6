Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF98DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA5C21A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QEjGmspf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA5C21A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933982AbeGCPLz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:11:55 -0400
Received: from mail-eopbgr10128.outbound.protection.outlook.com ([40.107.1.128]:59518
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932440AbeGCPLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhY7pptvrdQUeAPyxm77YPIKeedaC6A5DJ1M8SDYr7A=;
 b=QEjGmspfSYb5kbUYL6v631ZXxu5++SN5Vv8eVKY9sY/FB6+EkgfKAUa7S2FyFRoyn7XGEmuVcgVEaOGOLaaTRSXYa9AxP16OwM9rkIbqd38Skwe8UfBmvZUaH8hfm9+ySOWXzyHlRk95b1wmKKGAg95YhHRjQdHIbE3egFz6vkU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB1338.eurprd08.prod.outlook.com (2603:10a6:3:39::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 15:11:39 +0000
Subject: [PATCH v8 16/17] mm: Add SHRINK_EMPTY shrinker methods return value
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
Date:   Tue, 03 Jul 2018 18:11:35 +0300
Message-ID: <153063069574.1818.11037751256699341813.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P18901CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::22) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b81fc3f9-e750-4c97-4083-08d5e0f748f4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:U8+KieqN1Q7+wqSrJMm3F4+sGlKvpQxAKd3/URcNVY0LrvLsjXSz2WxxKD8lQjv5hVhQdYNkIUOCBdLu7VD0qhsApYPEplThdjo3wg3/fyNyFHNDIgovJXn3rt3goxQ+9R/QrG05LKSX5XHmxb9J3BjMOkxafMPMSSm5QJCBAaLdMPj1cxvGhClaqyJf5SraLrtYRzVV2YiRw3CIkG/VI7i+SzUUMCP0sAWoGNwhrWqFw64P2zO8I9iiMRlmgCWi;25:80sf3XkoONspNFHacbuuRKJCxkvNW3xmnDGONlZIXoFodTNwP05OdLPxSav/T4O8CnDlKPZmEdgmfnG88SUXXuabqzCfsvmC44U+3EMEsQMvJyHaL32el53Gv7iCZQKbi7sqrVylnN53jlM6w+EVyl62x5cLKdvNzrmcvbMTSnYgZQ1loo9oO1xryPr3wUJMc+FoFYB9+aAzkx6NKweVLeTiA4t2BBj3oNKKxZudnEtGfiZsUwjz/kZDD6lPQlSPS3CFnvJiuupF2DgV3c3Chzy+x0Jd7236bMvrJMtIAiA4b4177HwQbEJ6p98ACAboVDNC80pRzg3LrrmMWYYVDA==;31:6WzY2SroTO3APaaFrvbLHnpNT7nvo9M/7zqTtMg9nuhyKlMWEs5TejHl/MI0kPh5SyjmbucUE3TSb+KErLfiXuBT8x7bIeqjt7XXU93J4PuC2MEu1xeL91MZ3EF4d0LnfAEL+SW6VFjloeN524zdbU46ZbLOzs5Y6CAUbHx/mn1X1BLFwRpeyNpu0Zg5bkH8pYAxJyu3ue2Dmxlbv4sO83szhwubJVSUHlK0lnyonkE=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:1RrFhcVqwmtBeEPUKoYOrW2husH17O3lavw6h2Dw3Iwo9IjesCTCoj0tnw8/DvkupRqmFsTTsw8Juzn7McmQeo9U4fYHcG44P9Lwq2Bdx/qAm0YWROsoi3NyacklWfWMfqNhIwRTSZGiW8SObhrnM7BFYbBap+UH5gwFA99S5yv6fNm0PQVrBuizcM/84DzRNouhs6kXLO/Dn1+WLX9VCpMZwVBLSKRiMw4kpTLXTuD0En59Bw1KL/gicchsTqpoEakp+cVDuc73PEATRHA7y63IhchtIqridDR9n6ToTTUyAQ3Vs2Wdv1J/f27HUUctk8f+ajZ1hi4x7SFgP46FPMGxX7WnbXgsyHWWl2X+DsiXv14CNuK64nTLtrdnGbekVIzQ2mxDs6nnJfe9rTyNAOCyw2brY5T8vPNMszwegDhIYiJCd5iSz8SPc6bN7waa5v1V2I445UQS/B/EYk+2yqqeiTmB0ezUAzxTTSYP/u9HhidgojAOvb8w0tRYs2oX;4:rAI+6upW4So9ZQ0iQDX635IcylZHlt9Up7k/nWLQatD9QHpp5owqaIUwY4lYjpapJ4hHXDn0GC504u1jnVi9rrRC9eAbvxaiF6Z/3HzWQNJcKbOGC6t6TFWJb1egh6e1wRcrxh19K2OvdrW59E/3FqxNVJAHeAomaXTUw169YTcU4NobNXexGGpGLfOWVCcAsu4UMkKuQIgU/wG6KW5Ae/erP+FspnxO7PcKkl/VhVZ9uF4dlqCOwt5ELWpNhHYhluddJWb9BhDqVa7m9vExFtRS0Tn8s5F+UiwG0yU/b/DluaKZ0qKBx2Z8IvSTaW2267TQ/FYH/FNI3kys/FLz5dWLPzJnKvfCQsow7YcEiqwb+TcvkYTDT0lBz8fvH/Mi
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338FADFC66A9648A13AF3F7CD420@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(136003)(396003)(39850400004)(346002)(376002)(199004)(189003)(7416002)(9686003)(53936002)(2486003)(23676004)(7696005)(52116002)(33896004)(478600001)(76176011)(186003)(55016002)(25786009)(26005)(575784001)(86362001)(446003)(11346002)(14444005)(58126008)(956004)(476003)(316002)(486006)(66066001)(61506002)(16526019)(39060400002)(3846002)(6116002)(47776003)(2906002)(103116003)(68736007)(97736004)(106356001)(8676002)(386003)(6506007)(230700001)(81156014)(81166006)(6666003)(8936002)(305945005)(7736002)(105586002)(5660300001)(50466002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6dG5TQjE4SFYzZUJidG4reitiWFhNVENm?=
 =?utf-8?B?ZHFjNzc4Zk9tVUh6NXBQWFMvZFlIRmNWeXVmS0F0eDRjNDd1M0IwdEhMVm1O?=
 =?utf-8?B?TlJJUGtGb1ZTRXVIYXVUalNDbFFYNGVvZDNTVFFBRzlVSlNWdzRwSlFRQTNK?=
 =?utf-8?B?TjBVbVYybE1pVDRnYml4MmtlaE8rNUlkbXI4USt4R0ZGNVZ3djZkZElLdlRS?=
 =?utf-8?B?RlZPT1RCYzJyL3RxSEtTbWFHT2sxQjkyTEoyK00xNHdpZzVsMytkZGhNK0s4?=
 =?utf-8?B?dnYzLzdlck92MTkxYkV1SHJzY3J2bCt4UzBEN0pOV051ZFFYUDVzdSs4OHBa?=
 =?utf-8?B?OEszY0NuSzlVd0JXYTNoRUpDcGtyT0dPc0FWT0d6cDVLcmF1Uy8yZU5mSkZu?=
 =?utf-8?B?ZlJjanRHYlFSVkk4ZElxNlh0cWNkMjJxd0hRU2F6cDI4amJVVEtibnRlYUQ0?=
 =?utf-8?B?d1RkL2NhcHBpbFhERlZZdEpFbTl5V2tUUXBwSWNqWFNwcDZRamxiMGJZaUs1?=
 =?utf-8?B?M3lZb1dHQUFBOFRSdkV1OExWVXVSVm1QUlRVSEMyZU1zb2xyZmFRalg5WFlU?=
 =?utf-8?B?b1JxR2VRNTQ4TWM2am1pL0ZtSFoxKytSNUl4RW4xUmZnZkVlaHVBMG1jdStI?=
 =?utf-8?B?MVVTb0VaOXl3cHFXa3VEbVFJSnViSmlvdVRMR0FXL21tYmw5Sk1LaStiZTBp?=
 =?utf-8?B?VzJjUnU2SjByZCtvOUNrSGRiQy92OXQ5WE5mSjdVK0MrMStZZ21icFk3MHFY?=
 =?utf-8?B?bExTMFhtck90ZlJHYzc4bThvL3RwL1hTbTJEb0lHL2o5L04vRUNrNmNQMTFY?=
 =?utf-8?B?V01mbmdmRU1uVzRWbGZrcDlnWXJrMUJneWZ2N0pGTnFHOXdFdVJXZnRTODFG?=
 =?utf-8?B?b1UzYThLZXd3WnlVMy9ZS2prbGFseVJDQk4rbjlGdW45UXJvTEFTbWhTdW5j?=
 =?utf-8?B?cnJUOGlHOHVVVzZmUEZablQ4ckp0WEJaNm9EaUZUTTExZkNHeExRMTF5VDVa?=
 =?utf-8?B?N1BSREp0bWFmYTNsQjQxdzIrdHJBL1RFMzE0citHQTQ4ZXRGQkVCNjB3WXI5?=
 =?utf-8?B?VXI3Q2lxWEY1eGRtSnhwcnNEeU45WUo5YzZTdHllTHc2S09xT2xzQ09idWpO?=
 =?utf-8?B?eG1wdEFteEFoeXRBcXJBSDJEL1RDVXdHdy82K1BWZ1JxaTdLSmM1M0t5Slpw?=
 =?utf-8?B?Q29ZdkgyN09OZzU2WWxJSXlLcGNuL1dGeDYwKy9VNVdxeWVjeDlCOVN4VWtY?=
 =?utf-8?B?Yy8rZENXNFF6MkZlY1owNTBhaXhVKzJuZ0NXRytXa3RsS1pEOVU3NXJTeGRz?=
 =?utf-8?B?SnF5dEdLbkRpUW1pSzJXMVFHMitCYXlweGVGajVxSHJ3Wk1FTC91Nk9OZHlU?=
 =?utf-8?B?U3dDQnBrRkRsL2Y5eFFrQ3MxNVJkSVV5c3NYSFEra0tvdWtrYmhJUHdqelU2?=
 =?utf-8?B?MTFuUkVDYjBHWUlpRVRGb1pGSkMybTNpRXFneDA1VmZzaEI5eGgzQ2RVRTRB?=
 =?utf-8?B?eVRRcUNkUnBWUGh0RC9hVmt2a1JxREQ2TDh1RUxBL0gzMElDRWdXVDQ3VWVp?=
 =?utf-8?B?K0ZCK01LVmV2aUhXMEIxaTVOek0vVVJITGNGN3NDZVJGTFB5Y1d6bmc2Sy9Q?=
 =?utf-8?B?N1BRR0tnanQ1NDdQOERyRmtjNU5WTHVzSDg1VDJUR0E0bkNhWTBnaHczS0ov?=
 =?utf-8?B?UVdJdHNVNkNXQnZjL1lReGE4OCswdGxCejFJc2Q1TzdFN0xzRGZGaFFUNkpG?=
 =?utf-8?Q?DRg/RR9aLdT6c2YRCdflhPSmUqigvmdr7c80e8I=3D?=
X-Microsoft-Antispam-Message-Info: 6rv9IviVRu6+7BLSMI+UI7iuD6y0Vvq4t7OrI28fkyUJmJsmTbUZeRNZ62CpX2ePD/q56ZrBtYEpunl/KR9pFMnxF41KkDRsrucFIKYnawK2pyJOaLi0rleqIpSiuGATfOJcWtKRZB4Cxbz+ZDT3SExOxtwI9BmHNED9TSOZZm/w2tqthaKyi1pa7lzM36jDMyoNMAb9nOXBP6sXh80T1m1ze0vzxjTkf1XwcD+0VVnZA/trg/P0kf6zJgTQLo0Pb4ffEPi8/I3eXAneIFAAwGxJD972LrRtm0EwPLAGDP9xjWJOB5KcZMgavqdqz4Xjk4QZ2n0KXum+HymFjYynOIZRhK/HHbWjQSdx0Gyg5D8=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:VS5TJ8joypc9JD9MbhiOlq8mxcqRWWQ0x8ySQBRAR0RDE5YuHlgevvyNz/ngDxSccaVE8NKDvq7Q1fwu17wfduBreQBrQjVCJspwSFxqMxso3Es6u5yLedhyQgReAgFTi/4eTRf3oBOoXpeH1KmVrjvjzEZ9U3xODLe+b6/nX2Z0mf/MI/+ljT6FT/64SzAaHL4uzGhFy+LZMSkQkiDUwola1Nz/ksWBTawsxd3/obZHUWO3O033fBJfbXECYiAmjXAfP38/3mb1s0LeSDWVCnHa75yA1/CRc6jIW/cg4sUKPq5IYaeKpkyhrj/yKS6wBAClaX55YewSa+WwJbLYuE6lLgeW+Zcz28byaFHZf+/uzuK811ZYG48d/ouF6QN1RBS7yGWAQdXhAQHZDt7uMQQOtkRK9yMsjqEXzz6J9suOkhXGdwXtcBOxiP/ULTnRBrsENbBCfMZ91kbsjoJdwg==;5:JaIqKbTjmmd/ooikBjKZKZiDhRppyvZRAW4uGCcbKc3U25sY57CZGdLNduu/IgCUO/FVkD9iWVtvk+i9LIJa0FySMupfIG6Xjibwi9YewnqzfRxHjLqGrTvSfZCaLUbqZKFdCqVI0GEgyXp+IsCd/4Osjn56Bj8JZUaPxd/6in8=;24:XP3x/f5h89AHbskOR8kfYfrQS1Vk5zZDLoQfc7Hm5Njkr9/veJQr84rMMgHla5h6QSJ3qxtYrFNT+d3vW4NKRwCsZkCXYrISciMcpnCW7J8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:cruQ6W0iNUeCezpCAnXdoc6gPnAkUTCYraNpP3eBBxPrFbEVzxaVnsYagF0U0hzEBNyj/M1jczV6J+cNhDUzkjo7JHlbgr6NVwScv/cVtXlswl2yAbaTp3qsFeoPDG/wE+6mVrf+U9xjCXDBL21zBAY+15hilZcc3ZOIwFOkodKpEEDnH6FelyQy8YMwcj6LvtHuL1dB6SqwBHcHPB4ornVbU//Zm96/2MYNHW73W0KChSPKinQdqihF0u/7lT7a;20:uDfpUbDd9Dv6rA4vj3NAHtZya8M12r1lg92CfzTiHjXKCtzwfbD+a51pMihuwzXW30CckwjSQFJnFRPYCA1NBs1FCq/TFCqA+FYH1aDuI8RlQUc/GINVANtKA2Vz4SFMRL8yZeva4boaLwwUFj4zKTpQRuKRiv1NaBQWVbfg6Eg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:11:39.9084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81fc3f9-e750-4c97-4083-08d5e0f748f4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to differ the situations, when shrinker has
very small amount of objects (see vfs_pressure_ratio()
called from super_cache_count()), and when it has no
objects at all. Currently, in the both of these cases,
shrinker::count_objects() returns 0.

The patch introduces new SHRINK_EMPTY return value,
which will be used for "no objects at all" case.
It's is a refactoring mostly, as SHRINK_EMPTY is replaced
by 0 by all callers of do_shrink_slab() in this patch,
and all the magic will happen in further.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 fs/super.c               |    3 +++
 include/linux/shrinker.h |    7 +++++--
 mm/vmscan.c              |   12 +++++++++---
 mm/workingset.c          |    3 +++
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index f858178f74fe..00b0154487df 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -146,6 +146,9 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
 	total_objects += list_lru_shrink_count(&sb->s_inode_lru, sc);
 
+	if (!total_objects)
+		return SHRINK_EMPTY;
+
 	total_objects = vfs_pressure_ratio(total_objects);
 	return total_objects;
 }
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 7ca9c18cf130..b154fd2b084c 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -34,12 +34,15 @@ struct shrink_control {
 };
 
 #define SHRINK_STOP (~0UL)
+#define SHRINK_EMPTY (~0UL - 1)
 /*
  * A callback you can register to apply pressure to ageable caches.
  *
  * @count_objects should return the number of freeable items in the cache. If
- * there are no objects to free or the number of freeable items cannot be
- * determined, it should return 0. No deadlock checks should be done during the
+ * there are no objects to free, it should return SHRINK_EMPTY, while 0 is
+ * returned in cases of the number of freeable items cannot be determined
+ * or shrinker should skip this cache for this time (e.g., their number
+ * is below shrinkable limit). No deadlock checks should be done during the
  * count callback - the shrinker relies on aggregating scan counts that couldn't
  * be executed due to potential deadlocks to be run at a later call when the
  * deadlock condition is no longer pending.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 39f0ba75f7f7..96279b5f1f6d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -453,8 +453,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	long scanned = 0, next_deferred;
 
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
-	if (freeable == 0)
-		return 0;
+	if (freeable == 0 || freeable == SHRINK_EMPTY)
+		return freeable;
 
 	/*
 	 * copy the current shrinker scan count into a local variable
@@ -597,6 +597,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
 		freed += ret;
 
 		if (rwsem_is_contended(&shrinker_rwsem)) {
@@ -642,6 +644,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
+	int ret;
 
 	if (!mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
@@ -659,7 +662,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 			sc.nid = 0;
 
-		freed += do_shrink_slab(&sc, shrinker, priority);
+		ret = do_shrink_slab(&sc, shrinker, priority);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
+		freed += ret;
 		/*
 		 * Bail out if someone want to register a new shrinker to
 		 * prevent the regsitration from being stalled for long periods
diff --git a/mm/workingset.c b/mm/workingset.c
index a682306db49b..8350b6ec76ce 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -397,6 +397,9 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 	}
 	max_nodes = cache >> (XA_CHUNK_SHIFT - 3);
 
+	if (!nodes)
+		return SHRINK_EMPTY;
+
 	if (nodes <= max_nodes)
 		return 0;
 	return nodes - max_nodes;

