Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F1421EFB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LyUmVH0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F1421EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933711AbeGCPKB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:10:01 -0400
Received: from mail-eopbgr60102.outbound.protection.outlook.com ([40.107.6.102]:51968
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932777AbeGCPJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YepmwfPVtO1jv08Lja1MGQtIYqCg9v2S8dRI+tZxdYE=;
 b=LyUmVH0rsvxhdRAxWFrtkhOpgaS9VjAnBbX1E/0d0ZK1KRPNZcmvFFfsogvcQ8+UUYfBt1PVcnvk60QatY3MO+SprHQvXAnv9SvWuEFenz/8nIYfAfG9/SYhhXNzuwAxAUyP08R02SFX3ADCvV4qIso4yscwXED9paeE/8ZL2iE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 DB6PR0801MB1336.eurprd08.prod.outlook.com (2603:10a6:4:b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Tue, 3 Jul 2018 15:09:49 +0000
Subject: [PATCH v8 07/17] fs: Refactoring in alloc_super()
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
Date:   Tue, 03 Jul 2018 18:09:47 +0300
Message-ID: <153063058712.1818.3382490999719078571.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:205:1::48) To DB6PR0801MB1336.eurprd08.prod.outlook.com
 (2603:10a6:4:b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ef2dfaa-771b-4ca4-f893-08d5e0f706e2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;3:I3/h+Tiw6hNgszws3WYvJMWwWv6fQOHWrXD6BWMlQDmPaWvWEFt10HiuVDC7JIQR4BenzTiBaGeaQJ52y1Z9DQXe4lNOtqH2LsUN8EcDSJQlFCWvrP22HglxtNf+dOze0+uqh0rWjKKpUmq6sJHAwPSPuYTb70E+WqBQc1LMwYkfdNGy4tj46d2AnnAIhIgzBW+2GXl9yQbxZIAMktTdNR+4f7q/3Zvg2IOFuPlUbjjGJZRaZqq5YozbSXf9s8h3;25:TMEBXIyhN5Wumpz7iUk5/T4hPj+udNjAFwokDZCmrlc+ZmXSQ/6FfoVdrrxNkkcMnO3dfoQpHYo9NgwhQbJnLcHgrnGyEeL7J7X2ubg97J4gr+1n8qWrS81yFoWS//j9jdNzom9A6/nuQ3DYvUoGMtYy1Zjf4x8CWelntM/qnR063piNvfZQtY8MyszetrMgnfRv2vgFiP0Ss9Da7TnCEEOrsysmQNML1lzMTG4v8saPWQXVXDJRU6f3gT5o4+0soEbN5lj/HOnu7aH+kQi18gmwe5s1F8eABhe2uE5bM7BeWMepGy0R36JGKqX1hbIEq4R067bWWGjT+PXeZtUoug==;31:HGVEv19FwZjmG+jXdFi6maC1cPMCuBo89Qbaj7wMjYMa2MTMTDaegcbsO8ERAdVMcHVe+ztfM2vp4O8HHHiwMMnZQx2of7ZNqRur2ojpTZX5q9rB11RwNkqSDjI9TrINAeYxvaV4GtUPDZUMd2owvIjsJ3mFQDrXH85GLmFbrxgeBtiD20BOck9IkifR7uNdN3xueegg7Z6KosOlRJsnYg22FVoTybhJZOEsMkhvJ2c=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1336:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:Va9/uJKux4a/EwxZqmJNfyaZPI247Z10diUxkY1RkSRkLJNUHhDxVJw443KymmyLnytlC2BNtSksHOK25whP0+/Ms53w2FKBAQqLLA0t/7Gc9QrA9ppm1Hd0Kv7o/anFWhljg55sOeZIroVs8cjnijFieBAXr0wTC6qlCbekNUwgFn5qc5h/oXzDMsDINb0No/DcMQXQrBVfZ9G5sJhPnhYQcJtF3RflUFUgTrQ0Oa2XOicN8RSsLp+jDLbEIJrm8wFz9QV/PkCamQFv7Potiy08IcZlj+GJR70eHpmqY+ULdsI6ZJIGJp0RfmkQ9OGcMIo5tnGnDDGSjE4UTN/nxkdiBPpYw76MBTaG/BaqZvUpO/spQxgOlkQMG7r07HSXYiSC3VE0ebf4XkDhDkaMEvlYNhgDGFEKn9hc5eBadZ1Y+h1VTj+8BSD/IcFIq0eUkAEmHYHzxWzOJjiUlSmKvJP3qOEAumOTqTGc406lO3Xfz5HzbjERoL6LWEzX6Oo6;4:hj+DAXkhoV021H01QUs78RVAyUcSJDNlwaTMy2jpSmXt9NAdFvIJkJ5p4q79jFvVVdCosnblINq6eaGQFYTN7jM55HoZsxxQjBJQHY0Vuo0p3ms3thknBNB0AaLC6ydJQ1oKupe8gwoHaw6/i0avsJDrW6tmCjGLMOnDLVz6G88Ly7huI8azhnYw6HLm0uAK+2QXUd2woQiMKS80JJKETvA7SjBwdLBhycEfALtHmYKe9B0KCuXU3mOQvhQ8AD3YcXeBlLgeXOVa1Zsho5GGgmJTN6j6DYzIdf2JRuBseVGih7DUZJ6qfxU//OtojCpYHgHI4kucLODoiw83upzWfHVrRXpm1Jr8CGOeHSwOaUZNCpMzD8wxFrIEMwAmQTSD
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13367ACCB21AAA3F6E8519D9CD420@DB6PR0801MB1336.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1336;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1336;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39850400004)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(26005)(16526019)(2906002)(23676004)(14444005)(103116003)(39060400002)(186003)(66066001)(47776003)(2486003)(7696005)(53936002)(55016002)(52116002)(6116002)(105586002)(25786009)(106356001)(3846002)(5660300001)(8676002)(97736004)(50466002)(68736007)(8936002)(316002)(956004)(476003)(7416002)(81166006)(446003)(11346002)(230700001)(61506002)(9686003)(76176011)(386003)(7736002)(81156014)(58126008)(305945005)(486006)(86362001)(6506007)(33896004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1336;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzY7MjM6dEZnWHRVOURQbDNXSWNkNWZ5VHpUMVlk?=
 =?utf-8?B?V0ZERjdFbWVBc0tRWE94eGJ5bkNESEZWc1AyTm5zYUlBVXlPMTlYZEZNR0Nx?=
 =?utf-8?B?cVprczhVbS9OQlNHSXovYlVlT2JaVUdxUEY5NlRSZXBVWmd3ZHNDajMrZktr?=
 =?utf-8?B?UUM0UGtrY1NvbHJPNThIZkV6Q0pkNkJCaCtVRmhaTjdkRDY0MW01T28zM2Nw?=
 =?utf-8?B?WFQyZDJqbkhtam9iT1dnaEw1OFNYOGZDR01oZThoN0ZjM3ZEZGhyMmJ2U0dX?=
 =?utf-8?B?QkxPYlRjUGlaaFNDZzQ5VFVVT09CZllXZHFQcHdsUWIwVE1DUjRFeHhBUVFS?=
 =?utf-8?B?bGM3bVVXWGprdkQ4K2tzTHRGbmN1cUxWc2c4QzYrbkNMMjlZTWhhZHFyckRv?=
 =?utf-8?B?Rm51ZUdZV2Y2K2JIWmp6N09UYXRCME95emlQbmlUYjloU2ZxdWhJZUV3L0dt?=
 =?utf-8?B?bXA2MmZSSGVTWmRZY2hUN1Z1OXcvL3RIOTBxK3dueVBQc1dKSVVIT0VWSFIz?=
 =?utf-8?B?Mng0MTJMa3VMS2lUa2puUlIwbGhKNHZLWlNUaitsWklwUk5UZUV6WWsrWCtJ?=
 =?utf-8?B?MDRUZ3A0d0pjNWtMVWNuSWtWWHNHUVEyZVhuRUhmL1pXN1lBeEZRbmFURnVT?=
 =?utf-8?B?cGx4N2dVOVF5MWlSb1psSnREMVFha0xWTHRFT1lRMCt2ajdJQ1pBR0pQWnRT?=
 =?utf-8?B?TzY4SzRrd2oydXQvcVVEUUFrKzEvUEY1UkF0bm84dVNHajhvV3dwNmMxVjFF?=
 =?utf-8?B?TEpuOEs1S2UvSDVRa1JhcjB0UFhLak5LWVBudlU3dE5BdndwSnpRUjFyR3pl?=
 =?utf-8?B?Y2RqWEhlZC9sOXZRK0VHZW9qaUI4TjFoaDhQanpja3A5ODh5aFBiK1dJRG9s?=
 =?utf-8?B?azlBWEhYdmIxT2t0K1h2WjNOdkt1bDZzUDFqbkZTcWtyZlc0dEhKZGlmdU9s?=
 =?utf-8?B?WlYreHlyK3NmRnA0dTVPRXFDbHZoaWIzU1NQUC9JazM5VEZOYUtSdG1ITXpN?=
 =?utf-8?B?RnpCbWtnbEN1K29wU081UkIxS0tyQ3hFUXFBSE1xNHpIY2VuZEF5T2pXMG1Z?=
 =?utf-8?B?ZUNQR0lXYXNUN24vQjcxZFVjSWJsR3dySTVYcFFFd1VHeURGQm5aV01SMFpD?=
 =?utf-8?B?NEtGUW9jc3M2VDlTbHBCUjZSSjBZb09aRlYwVEhVVHVMaGl0NkIzcCtIZTlk?=
 =?utf-8?B?SElVSm5mNGNrL1loSlZrcXVHNE9sRE83UnNBQjlQQ0dQenBCZDBKVkRmS0gx?=
 =?utf-8?B?cWVEeGtkbFVteE5qUGFITHlPSThRZlgzeVBGWSt2NnFLOEtKMHM5UWRqbXNP?=
 =?utf-8?B?bFB4L05XYjE5VzVWZWFSclZqUUZsWE1vVEduNDRQazJWMjIwV2dJd0JuMW5M?=
 =?utf-8?B?VlE5UG9mZUY4WHlGNmFveHVjWlJmbENScjBhcnRObGMxdDR2RktsMjF3Tnd5?=
 =?utf-8?B?RW5TTnpmQllSRmVwdm90cnV4YUp0TTVjOCtLNGJNcVdCQ0NEMGRvQk9wSjNo?=
 =?utf-8?B?OWlKcWR5RkQwSVJ1U3h5YUpDR3R0SHVSTnRJclprTytLRGp6allMOTFVWFpK?=
 =?utf-8?B?Q0w1cDNWZ2h4OWE2VXljbDhqTzRMbzUwamZKUUtTdGMzYTFhMm9QVEdpQmt5?=
 =?utf-8?B?dkVsQURNTUc2aTJ2K0QzcHNwbUNKcEhleFVneHIrUnUwc1RiUEpwUGZPa0M2?=
 =?utf-8?Q?kO0gIYsQppoT1ctY6zuovD0KeTFTnRuH21yqLmEfk?=
X-Microsoft-Antispam-Message-Info: MLHTDt3I0vVVYbcJZWMf6y7P9wz3r77+PKL62qB3xvFi21kFsBavVmZ34T0+bhS4MeLOKVxSbzm6JaqdzNes9enWT+GqblVaGQ03hdxs15Ia5Y9lZKgP5vCvvYGZ7iD+fETJ6rooJClAl1/Vdidj69+gTEfclFjM8puBIBPCEOdVOOAI8Y91qOAjI3lfRvm2HsBFtMRw/yrpQu30V7Zs1DYEoMdLv4ApxyRDX9a1Qc8hjDkH9RKLv1APLwRfh7zvfs/3T3Xpl01EsH2RoAZzA3xNAq4sYO1g1pXisuI3ukSOxSKm0G+HXWUU3hbvD2XSL3yi/K5E5U4zNeRsRXIdb8We6TxyLeOsaGgGB8XS3vw=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;6:d1xVT1Md52pkebRgdlfmRkvgKWGpj9+UajrJIOcytRgEcqTuy89DMz5gc4zhsb7CmOwwTEsbH96bFJnhBV5w8jFbf40dmBXAJH8hWB2I/LzIlB22ybafRiRUd5x/hMUrCTfF8hxDW+Xvc0GtDHOD3kIR041Yl1tCQ1kS23OIxUKWstPmr/kRuHamlbhekKbHm6lJOYgOlmvaY/NCYNnvVcd8V8tQ4zTVVGM55M4kLYtxuR1i28GQyPrA4QXG/CySQOHqYRYt7xTxAlOTKd5x9BhOuCDuXvAM4D/AT0dAjxKZ+EXwUYUkr9RXqHed8Is0byhMMxA2onW56+DWn9bUVVNT/ySFq9ClVbytXVnG5lpOQCB+/iRpMpc0LVN7SyhIUEl/urkF6kyWalVxVaPyD/U4qflFl1FnH6lDpJaOcFgpWIuE5C3Qkxodwy/QgchD/3ZZgmFuK8EiAdDMUuIaTA==;5:sT73OuTjvrK890cv98oXM9kRWJpQwLNVOEz6YOJzbMTwr0hgMtNYMJXqaR1vgY4Mt6f5AADenjVkj2TqMpH7cAn5XOpZ6GjOAqmoJ+yRVr7OgOvU+5khzqL9SezfN5WEhL0qRMTDk5h7104QDMc5klr2zQpH6jcjryb31y7OYI4=;24:mAi3I1QmWV+GV4JxhXPJOYWsS5bSY587/aHBcw5cYmNg22GZINFGLAEgEj0Kz/U5NGhDys38E0UZLhRlnmpu7HZaRd5loqQ255VMoDCfq5c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;7:2KRgsY3ucqqUk3ZI23cYGFeZCwXq5ejxpaXeOXDpgR1JTqLNuxt7vwAL//LcliUsnR08jVMTaVwhrS27RB/NwgU9xOJfO3q/kzz9HKTtE4timM/u8J5RFigpcYcWJ3Ps+8OmNsjv/c9MDOj+7/YDb2F32ghta+XqAaka9W48PM198B7k711LU2a5agGjwKeD3ykeH7zp43SsRwsUQ1X/G9OuCXRMHvMFbU5n7EqRTGSYNwuas4EQ42DzHMNPYo7o;20:8EDgpNs6ig0QQPrxRAJ16pa88w+x4jd+tle3+6ASeYLMtyfK3wb0xNDWxGKc8KpWLA23lofq0+0nzUjpzzrZtBqWmlSQ7kChUFH7ycJM+8B55dRgjs0yaDJn4E3OZKPozbvhruusB0zNPd4xLCXUgBXojq83PjtkRWhMOL9f0GM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:09:49.7256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef2dfaa-771b-4ca4-f893-08d5e0f706e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do two list_lru_init_memcg() calls after prealloc_super().
destroy_unused_super() in fail path is OK with this.
Next patch needs such the order.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 fs/super.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 43400f5fa33a..002e46d874da 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -243,10 +243,6 @@ static struct super_block *alloc_super(struct fs_context *fc)
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
 
-	if (list_lru_init_memcg(&s->s_dentry_lru))
-		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru))
-		goto fail;
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
 	mutex_init(&s->s_vfs_rename_mutex);
@@ -264,6 +260,10 @@ static struct super_block *alloc_super(struct fs_context *fc)
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
+	if (list_lru_init_memcg(&s->s_dentry_lru))
+		goto fail;
+	if (list_lru_init_memcg(&s->s_inode_lru))
+		goto fail;
 	return s;
 
 fail:

