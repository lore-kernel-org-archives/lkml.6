Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZr7K/eacxo0/AjIYPnwv9cZC5s7n0Nl+YpGlMDJKXVSH95F+dpbbaVPgqI5hBwDwthAkJg3
ARC-Seal: i=1; a=rsa-sha256; t=1525867116; cv=none;
        d=google.com; s=arc-20160816;
        b=Y/AwnUr+pXg9YxUBnCiVqRxcPCZ/YqHvzkFKNlxmRdfbvDEfhAp0Kq3EARXE2Vs6i9
         MvpOVW5Y8CAvKm1MR55ssUmoEg1CsA3/UY0dvxh44JleA8fqaOPwJJfif453Rwgpykhy
         DUhwbiQYi91RgmaF6qH63vrfgZGGCMYHK2Numzum00JcJLSdyFVvjk+lZVdOOLwe2Dcg
         6Rfidldcgx90+9PqQUc8fthejNIyand2UhB1jL3seM6amhStXLf0G4KyuYTrA7mnZ+yX
         FPLkf4AG780cuGB+nxA1cHB7RCeW5SO+Hnf4+vbCpLthVFBVPe5551M93KY4SnVcE8sD
         9YQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=VPXNrYVvRsBOwJ6oLfLagyddZTcE+4Uvu/85pcJPVTU=;
        b=LhnF5IaIHMa7taVVfxXsiGatPDpG8mZcKIrYZGd/CY80viwElfL/uSX3psuDvY/VyT
         JIbbmVdqJnnZsTeJJV6s8qH1i+NoyhS/XgOjZUFPD5A/TyBpRPa74xbpe0L1QubVyP1Y
         rw5KPn8t7peQwXe+pAy9VVf4BDbc8mxDmdYEFQPl0HhYx2OZ3FjXEIMXK4Q7am9pYTQi
         VQZkfhuXFlHa5mUHkIdUTpe250GtcLbxbanWQ+NAMEF3/OxV01m/GV5dVyBwDM9mOVDG
         UYX6i0TABh7JP2EE0UF274R6DzNBR7aLmxm326eQx7889nCIVj/V1KFbkoQ9caKehpK5
         8IIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=CYwS3MwX;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.97 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=CYwS3MwX;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.97 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v4 10/13] mm: Set bit in memcg shrinker bitmap on first
 list_lru item apearance
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Wed, 09 May 2018 14:58:28 +0300
Message-ID: <152586710832.3048.5849744392387674244.stgit@localhost.localdomain>
In-Reply-To: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR1001CA0014.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::24) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:Dd9091RkwspXoA6yZmCg62xVrz7WO7oip03c+BDMJX2f1a/mfhv453NuEVL593401iXT6WSYOwmgO3lGJOVuVs6t7kGU5Z7YGyRwjuOsaqrFgO3aWKj0FKgtVssTwlE9F/L5YLLnEUNeLDMo2ezAp7Z+t+2rs3STsIXDj06itvf/DW46tsnCTxa2/G3172f1JGL+VkiMwIRdtz0El5uZIlrgNe4QbCH3x+/wkzpOPSKj8UE7s/o6gXlX6GN+6HXk;25:VymuBA41ejmf/3csalg2aoeQCkzg00mEoanB8TRx8nc7hAf8P6AlWjuMjnNeGbxukkdyeOFD5JC7chgq9fIENk8ql/wXE8yIy4+q1JIY8ypG5RPBR0pq4uYMGtyEpplSSviWYN1/Clt13LDf3N/W/4xo9QqUM859m07RqmObbZ3riGqmt9caM0UDvSQ0Ss2kosyQ6ZotU2x1gdNWbnM6v/4+n1ESvgUJUsEINaThKn0zCyL4Lai7dVBwu8uEc4fopajpe+tqQwQn654isyttZQQkGSCogc6b5VqS29EWGnIhzQuRI6gDonrv8bz2nCtQzEjhUrE57H5FiTy3gOAc6A==;31:/VPt2DIcJvT8XyLTWs5oYfgdHyExQp2c/Cy6OylPZ5pNHembF5bZ+eccRn9Jl7vpjaof/WzMIHAKhIEXm6CzoN/ZM4MSuzSYaz4Ni2wMlQ1FnkJN/gvgRPSl+cYxuv64gsXAJQYbSmNo4y0icDjx2ABH+IXEW4l8h4sKizwrRxfK62PF6U1XwFsjyT39BASsdryH5btX1x3IqENxjarYOmbqIZj9rKPSMyI0P1vK3FM=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:bds9ux3fFH8V0z+Q5S290UDwHl+tVSl2fzwJLc0Gc4wP49YOP4VSO5/Q756vkL5e5z7CdXEtNbB6BiLUQ+nkydWK1q+WVtJmqYyocydL5jTjonD1yQv+y7496T3lzHSlbqqRH5KCltY/hVL66vnYyqoA/rVV4bllWmfjXdtrR4yB7uuhGFWDr8tipiahgiRE6boCINMnrmFwpgK2XapufEibpzPetJX5gLWT/Ov6QfN7EwqWDTF4mfl/IZDrQpwAMfjKLuze3w1OSfS9mWxPL77farr9o5FECPmmfLrh2gVdpIKKl5CFOMQDFYIVbJ6pWPe1XNCmsW46gOEFxfTEr1OyMiaxGuB7DGoZvTlNoBzOPPxVUPSrYZ0d0JMHwU/NpGldecL6d4vfjYoq6ZW9fFGXk4i+7Yf+d0YA9TY6fTIeAqznRSH8M+e48VhWgDTlr/YThkNxxwqwAfIxqezVoZxtmEEPoiph/KFY0+tArzGAirfbo9DJVV2WREoV8G6e;4:ryNoqopviYOeBuKpAF4vnXbF6yjFvC0Xwf8I8tHHVPb2CQWysFNw2MXwgFLdZwV+LojNAgzwM3pxIsF5OKQ6MAHwZa1lKTEzJFNUwVoVKrPJ39KJ03qdzZsCOBMwwlEJBc5lEwSiJP3vAAC2iNx4NKm5FoPOGKGaST1e4sGm7rllx2OKIHZaXJnaJhBBwnhGxByQTgAlVLNRiemn5Nx2yx6AUYhTV5g9toqe4X6rX9mzEIIocMnS6sZgjhCrBJEIL2whJOwKu52ZJ3H1e/JKrw==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13305F78FE3023043631FA42CD990@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(376002)(346002)(396003)(39850400004)(366004)(199004)(189003)(2906002)(186003)(230700001)(575784001)(305945005)(103116003)(86362001)(6636002)(7736002)(478600001)(11346002)(16526019)(58126008)(53936002)(476003)(6506007)(106356001)(39060400002)(956004)(105586002)(68736007)(5660300001)(7416002)(2486003)(446003)(25786009)(486006)(61506002)(316002)(97736004)(55016002)(23676004)(52116002)(7696005)(81156014)(81166006)(47776003)(8676002)(59450400001)(8936002)(50466002)(33896004)(26005)(386003)(9686003)(55236004)(6116002)(76176011)(66066001)(3846002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6RkhVRVRLcDU0Q3krRUIwUVNib3lSMHJw?=
 =?utf-8?B?UnlFeWliMVJiT1JCb0psazdPQkcySTlGclFJUEI1MkRyZEgzM0J1UzBReFpz?=
 =?utf-8?B?c1Z0RDhYYzNZcWswQTVZT2E0ZEE0UDVIVEhGdlVEZWo3SUYzV1I1Vlh3UHJI?=
 =?utf-8?B?dklUQkdjUlhFRVNqdXdEaEdDOFJnbCtXQ0xiaE1ZRmlzL1phdkE0cHJyV2ly?=
 =?utf-8?B?TkF4eXBpeU1DV3psVWlLOTIzR280K0I2KzJQK0FOUFBsb0lubEhqWjhnWk1t?=
 =?utf-8?B?RG5yRlBKYzVZeWJlbzliZjNOYWc3NW9TR0pTcjJCT2UxeWljWmlpZ0ZLRW45?=
 =?utf-8?B?NVU3SXRoYnpzL09ESU9mcUZuWjliREQ2ejVzTmsvd09aRU81QmhZRThndTdj?=
 =?utf-8?B?eS9Yd0pNOEkzZzgxWHRiV2FFUndLZzNqY1k3S0c3TFhzNVlLOHdjSkJKL1Nl?=
 =?utf-8?B?OVVnMnI0UFNQcVhOc1ZaNWVOdkh5cVdoWWRHNTUxRll4aXlvOGpvN0NDU2d3?=
 =?utf-8?B?VmE1TExxWStWTGRUYkFjWFZTaFd4K01PTWpCMXI3c1dNQkpRYjQ4NTFldEYx?=
 =?utf-8?B?REdwQ1ZqRWdUVEUvTVZBTTRnTWFDZ1loc3gvUzE4MTFNcThEMEJySVgxRTNt?=
 =?utf-8?B?cGh2TnFJcnFHTy8zcHUyOHNDQlNUdDFxZWFzbUkyM1ZnRllFNlhZYXJHUTJq?=
 =?utf-8?B?R004ajFiVXFEamg2MkwxVFMwemtidnp4MnN5UmpVR2FxSXRySXVJS2RHbkRE?=
 =?utf-8?B?SWZaVUtFYmJjeUcwRDhWd2NLWnJkWFlUS3dtYS85akpMeVdGbGk4dy80TmF4?=
 =?utf-8?B?b0tJSlc4bzZiVVFhUkM4RmhwbUJsQ0ZsaWVjMk9rMFNzcnF2TE9qV1JMc2E0?=
 =?utf-8?B?N05INWdXZVljNlI4bmVCOWlnc3B3ZXNobjg2dngzcWs0V1A2S0plV0d3MTBa?=
 =?utf-8?B?VHBUdnVES2dyQ1FnY05IdjNGZGQ3UTI2VGNtMGJ3dnJhQ2lrR2NqaE8rQks1?=
 =?utf-8?B?QzZuenhDeGt5aXE2TlExWTRMYXYrUWFUb1phajRPRE5BV3RoeUVlWmxiNFR2?=
 =?utf-8?B?MmxTYkNSNVhYTHhLZ3R2LzgvUVdoTEk3RjU1RDBNd2xGU1Z2ckRGaHZ4elNt?=
 =?utf-8?B?Z3ovVTBFYnVNTFptZUczcjFpdkhtQXJ0cXZpVi9qRFFNbXlOL2xublVBZnRi?=
 =?utf-8?B?Mk4vRy81MDRHOXdjN1g0WWRxdWx4TmdJTWdic1cyQzBnUGJWQUhWTWh6aXBq?=
 =?utf-8?B?Rll6dXQzamkrVHNLdFQ1RHNwOVlYNFVxOHIrejNWTytzMVVDYmNmbEoxYTA5?=
 =?utf-8?B?NUQ5V092bXJFWmdDYXdvL0I3VkhDbzdkK1NxcW9kK1VYUXR1RTdkS2E3Y0lC?=
 =?utf-8?B?MGpFWVZENExxRldpWjF6WmxFQzVSUlJxVG1iaVFvbE5rVjhTUDJxcit4QlJ2?=
 =?utf-8?B?cnBJRWVxbjhmNWZ4bEsyZWd0ejZmVEwrVGpnVmdsZWxzWTVtVFRKQXBzRDgz?=
 =?utf-8?B?Z0pFSXNTUENsNXRYQ1BzTkx6S28xU202VjFyZWV6OUMvOFZQTHJpQzZJczB0?=
 =?utf-8?B?SjN0cVRuOXZsMjRrbEExNHFrZnNocHhLQjFSQjZUeTlIRmV1Y0QrSGljVmpu?=
 =?utf-8?B?TmFKZjBpSERKSG8vOWdLRDJ2anR6dWYxa3FOcE4yOEdDeEtRYklLb0Q0N0k0?=
 =?utf-8?B?MGFxbkovQ1BjWXc1MWhHZkdVRFRiNmxieGhEcEx3NE80NThFYzdrSWhrcWE1?=
 =?utf-8?B?MWswWHd0My85aDJOTHRsaThOVmxsQy80R1dXUGtweXNQODc3eVlpTXJhQ1g0?=
 =?utf-8?B?QXBrb2pjaXhyUys4aUZIZHJuMWRpUXdZT3ZwN3R4WW9oYzRpQT09?=
X-Microsoft-Antispam-Message-Info: 2EqJtp4NI7PuVypQZzkKLekmc1xZ1ZEaTlSiWqKkFF1DHP6C1NTGrv9yAvwZnHDPQUS0Kd4bLnh4Q4XAAELDpmHmtfTSZeeBzPF4xjTD2zKHJ3cHoa6oLBXTIFITGc3rJsieY8Q/Dst7TlwqEp5oHPR0sUi5Ov38p/FrDubWEGiwgFh0tvGz3y5qTnnbdy6D
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:s02wFbF5pfCi4Ybh3xYLK/pZ+TvMnKOiAoDEdeYCVj7Qy0YslX0Kdsj9DQVk8CCTTfLLRJCzLGd/1J7cTr541xS84J5V6ms3u7CFH0N/3mg69iTCmJs+2EItxrgu8rHHU0AhGLaNqxawNsbBMyX572XHdIJodu7cIFRueV5vWDwbatl6wssPZJCN0SkXdzriarWDqHO1T3tfQH0HTZJuSDw1zp6XTqcpe8WG168sWAn58vWLdGKu3rl0OUC1559QR0e6dkXcHDxE+erhZf8CyMUsMbWy7KmehE20BvN5caaOfthcTnXg/1cGFhzRcuL87WTzp+njZ+89TrKCySl9PuO54UHuUPpBNCU8WNjgQFwigOv39DxipPpUtzwoq5SM27aCaXbiY6/eRBF47CGtgreDGUd8ZTiDRxNMM8efBeDm/z8Brt4u0XLwXQ8n6w1wjLKgFI/DTgfkkfVdTwNZKQ==;5:WVk9x9VfB+j8BZNqNg1p7DN6HzkVH2BkGdRPCbIQhoS11o1HqM/4kruzpptWxt/1ZFn1z3EVUFkYrdQ0kKBBkirdmFI6MAF2PQCjvIsjhpKfjtGEDc1Rmeo9Ar2cGzMZHRIvPjWLRqnXwYtbnZAYevALrbk6sf8YU7MAQpucSQE=;24:an5+AVHHI6Z+AUTCIWBOXzRr7uMDvLPKSAMUqM11Ve3qOgS6kZBFP/qPzj8XM+UH+GYfeW0/qT9h2Yn7KufZa5WNTzA0zqR++YVwoALlFwY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:m5/N1947PIhCHWEM4BqjIwBBZtj7OkIiTIsa1bJfi0UzR+olqrLi1gwHu310n7c2OV1PTMr7XLiLHy2AKXbJbntkJcdWoDQy9bpbTStjPVdpOcLKOUqLdYHedN+iqj/jt3c7rh5yo4dmKJGSZ4CsY/57/MrFPpfu0PFZwVRXALsToebdo8ATkN3uFUd1OXiKhoTvlUVZO6CZalRO1cCAQoxqd5h09k4sAc6MqlHBozfRkL8XurT3TkbmV8Kjwi7c;20:/WxsQxJUBOBwb8hi6EJdwFCEZsgu35MXzORzPM2r772+3EOkqq9gtDAF35ghnOQ1sRHlW+egOr78Bu2cL0rAIO34W9gTxFgtdPnNpUmr72f4qtkFWqGHKCZ8d2X0JH7iQonm66emfq++pp6Cvy2oqrPFJR8mRSODRI2vh8GR0JI=
X-MS-Office365-Filtering-Correlation-Id: 0b1fe75a-1136-4081-42cd-08d5b5a42ff8
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 11:58:30.9672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1fe75a-1136-4081-42cd-08d5b5a42ff8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987637974363224?=
X-GMAIL-MSGID: =?utf-8?q?1599987637974363224?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce set_shrinker_bit() function to set shrinker-related
bit in memcg shrinker bitmap, and set the bit after the first
item is added and in case of reparenting destroyed memcg's items.

This will allow next patch to make shrinkers be called only,
in case of they have charged objects at the moment, and
to improve shrink_slab() performance.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |   13 +++++++++++++
 mm/list_lru.c              |   22 ++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c159f3abe168..1fb2f96dc2f6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1247,6 +1247,17 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 
 extern int memcg_expand_shrinker_maps(int old_id, int id);
 
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int nr)
+{
+	if (nr >= 0 && memcg && memcg != root_mem_cgroup) {
+		struct memcg_shrinker_map *map;
+
+		rcu_read_lock();
+		map = MEMCG_SHRINKER_MAP(memcg, nid);
+		set_bit(nr, map->map);
+		rcu_read_unlock();
+	}
+}
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
@@ -1269,6 +1280,8 @@ static inline void memcg_put_cache_ids(void)
 {
 }
 
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+					  int node, int id) { }
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/list_lru.c b/mm/list_lru.c
index ed0f97b0c087..478567332746 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -30,6 +30,11 @@ static void list_lru_unregister(struct list_lru *lru)
 	list_del(&lru->list);
 	mutex_unlock(&list_lrus_mutex);
 }
+
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return lru->shrinker_id;
+}
 #else
 static void list_lru_register(struct list_lru *lru)
 {
@@ -38,6 +43,11 @@ static void list_lru_register(struct list_lru *lru)
 static void list_lru_unregister(struct list_lru *lru)
 {
 }
+
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return -1;
+}
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
 #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
@@ -121,13 +131,17 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
 	struct list_lru_node *nlru = &lru->node[nid];
+	struct mem_cgroup *memcg;
 	struct list_lru_one *l;
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item, NULL);
+		l = list_lru_from_kmem(nlru, item, &memcg);
 		list_add_tail(item, &l->list);
-		l->nr_items++;
+		/* Set shrinker bit if the first element was added */
+		if (!l->nr_items++)
+			memcg_set_shrinker_bit(memcg, nid,
+					       lru_shrinker_id(lru));
 		nlru->nr_items++;
 		spin_unlock(&nlru->lock);
 		return true;
@@ -522,6 +536,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
+	bool set;
 
 	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
@@ -533,7 +548,10 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	dst = list_lru_from_memcg_idx(nlru, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
+	set = (!dst->nr_items && src->nr_items);
 	dst->nr_items += src->nr_items;
+	if (set)
+		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 	src->nr_items = 0;
 
 	spin_unlock_irq(&nlru->lock);
