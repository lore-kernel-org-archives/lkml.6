Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbeDFNvv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:51:51 -0400
Received: from mail-eopbgr40095.outbound.protection.outlook.com ([40.107.4.95]:48960
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752623AbeDFNvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:51:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] mm-vmscan-dont-mess-with-pgdat-flags-in-memcg-reclaim-v2-fix
Date: Fri,  6 Apr 2018 16:52:15 +0300
Message-Id: <20180406135215.10057-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <CALvZod7P7cE38fDrWd=0caA2J6ZOmSzEuLGQH9VSaagCbo5O+A@mail.gmail.com>
References: <CALvZod7P7cE38fDrWd=0caA2J6ZOmSzEuLGQH9VSaagCbo5O+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0343.eurprd05.prod.outlook.com
 (2603:10a6:7:92::38) To DB7PR08MB3260.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2807c1e9-d055-4b2c-4b82-08d59bc587e2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3260;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;3:pF7+kgY1lvj/AOL6LWVQT6uCqs+Q2g/6MS5yOPMAlNBU6mFrFLlbYUY1Ppp/G0yCu+UQ1lQ0iEnmG6o3R2PXHXIcOc75KNivuQL0Wh1NyGnt2Tj8wJdhLLyR/ohI8lf/RLHZUGVUBGM3QWcfP4UeiCl1ttXBW8QpU77g4QRWTZROjmEl5O714zseI2vaxMKQ9LipzLSO5SZPiMeguF5S5XKQT8LEMycXzdH2SlvVPSHa1AtsO/5JibytelHqtIPI;25:YaExreGEVkcRxIvXpvk7yzPxBj0rSTaX8y/lbGnHAJkimqYg1jQA08xEdE/cF8q94ef9Jj+DH1oClN/c2Ji0oV93qrKxGubIB2SSJdlNMsgkb5vdMOLFAY3+skR7W5Atsy+YWkObvVF8ErLcQGyuBWWDKLnHLyBHCtp7d8n03C3Zi0rxIDXmiBSH8DdBOkIU0xpZxiywrbIZA2FLu+5kZGkowssAAS/hR8wf2JAARVOokunbPgrmJK8yJQqZJQjUGa7k32BU6p7pBP7b1VosXLyc9m2U+XbzGe/Peky1giScjryeo+v58SSiIXeaBpRIvL+xsECs3MBTnXMy7VtoQQ==;31:IWBQTt+FJIdR24ZbsWCdGBBRMtITmwzic/C+02Hng7qW31sVxbLgR2iMQaL52Pg/eHEXntyPqXPfaaEK6IZgYmJ0iELBqdr9ELlTlkFuKJ+3IBkwuPQEdhZiedaRTOC+HM0Wxr1+6RIaikBPFKVEFDXTvhqiKrMy7muZWe0ecCwaFW2OJ+fVlTnbN4LpWKdoPTJ9Pw3KiLk0NNPtTIa1YISSFv6GJn+exHl7dvDYB5E=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3260:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;20:N/i72MmQwZgBHxleep1tZRKXkrdHR/HVjuEW9sNgwKDXE/oEz7WRgBSYTXnCXiIr0gfYmIOFMLZRRx/KNTYNo7MtYnqm6ga1YdqQH6Hldnxdttn3RSzTq4BKvnOzOqTOE6JUi//Z56wfFMXx75CYxVafFCAhe6KGFw6nFErRDUWaq6IX6T8B5U7simcngVoJUyn65Obbb1or5nOo7VXonaHslcZ3j2LO05Hiqi80Em4xWcjSleYf6ZXBXtow7ywojI3lCVGpAWXzVuDYk5C9pB52MeFN4HoUGlGrP1JpOhvfO8SgIxQT2AnlY1f2ck068Soea4gNlK5du+++y0fr+CUAyTaWjbAMDzYF2S4vs9Pm+fKESj4KYtkyWkeBBxnZ/N9QEomqux7UIA+TuSydKr3sXJzheES9yMs8IVaHsyFs/R/hkX3yOZ/fzQn4mP/xMVHItO2CrcYIemd+eYpiYj7dD3HOeTIZfyByQtU7GVaNfHay3uf9+jQUzdATycto;4:o4oyFUtLtepvfkSnYOfh7kFXeCS1syrKYI1otMVZCIBmPH2buRQyFvKUIv4+kCzpbkNEqhhCGSppT0tjULrVFVQWQhlYbf6hzFSQROELxX0ZkG1sSF3G7dp3sVOE4+xskIZhA8EfHPGfYUGRl2Pwc4MBRGCs+f6muXQhYxXHyWxG+pftVD+Uc3w3WRy9aGy6iiCYWycLNXkPTi3zDMP78Mq83IDZYfnoKjOnoyJpnjLrAJiaHyqF3PJqyepRF5M9HRr2x0TDBjvbncOGLHcViA==
X-Microsoft-Antispam-PRVS: <DB7PR08MB3260AC524D1D280A56771F68B0BA0@DB7PR08MB3260.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DB7PR08MB3260;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3260;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39850400004)(366004)(39380400002)(199004)(189003)(105586002)(6512007)(2906002)(106356001)(48376002)(66066001)(25786009)(53416004)(50466002)(7736002)(478600001)(486006)(107886003)(36756003)(6486002)(186003)(53936002)(59450400001)(16586007)(81166006)(110136005)(316002)(6116002)(1076002)(305945005)(97736004)(52116002)(8676002)(4326008)(8936002)(81156014)(6506007)(54906003)(3846002)(5660300001)(446003)(386003)(86362001)(11346002)(55236004)(6666003)(50226002)(47776003)(16526019)(26005)(53546011)(51416003)(68736007)(956004)(476003)(2616005)(76176011)(1857600001)(192303002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3260;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3260;23:vwuT0XoDQW6hR5Kwpsn+4ckeXRbiDtyojIET1t0S3?=
 =?us-ascii?Q?g4S8dyPOvzn732K8lSbXxPeyOatV1ybjyqkl1uhDXYhj7YEI1NwIMwPZ6krj?=
 =?us-ascii?Q?MJ2utNhy4iX/GhggfmWZNb8ji+J2mM6RiBZJGB7ihkaCrivV/+XJlI83v4XT?=
 =?us-ascii?Q?sZYiB1/ccu0PTr2Mwc8XzAH1FIpUsSZ8F0kL72Qh9b0vrCmEkhTZzw192ZcW?=
 =?us-ascii?Q?EQkN/HQ3GPzGX3WAB2O70HaWGvDvbkSoF2zmxZY2R+dGkeEQmpw5QaQ0wFUL?=
 =?us-ascii?Q?DaXzRpeGI8+Cu2fM/F9pa0xo2JMoIGi481AoWxNUvTe+ENJKevxjW/RHCJKq?=
 =?us-ascii?Q?/RbtSnEZ6HmIM3LKmd1SYjFonvMxV2YSvBBLCFT8fMTF/dEyyP1e9maiMmPG?=
 =?us-ascii?Q?P/cXCqUFEHaCvoM1PpQ7D8P04ATg1z8BEPs3joKiaEbN1JwIJbx02ExuxUzv?=
 =?us-ascii?Q?RbXrYKs8ex+ALgR1wTCjGcHSOJbNwEsPZXpE9YYHeYd5czk5V7Z5ocvTq4DY?=
 =?us-ascii?Q?FXAG7Cb03cqLsqNLXGNQL89l70DQ7jnr+Ca2j5hdguital3LSXJQXOcHm56I?=
 =?us-ascii?Q?XLCY+CtPCJbezgCvUsbDu+wLtyeExgfX7idtwbny4fMywZfBGY938yi2Ry0q?=
 =?us-ascii?Q?Gi74CxicUWlDKGckj2ngKzn5+NKoFvyYnCRmsOGvUlIeWj3rrMGPBguJ/e2D?=
 =?us-ascii?Q?0z/O25EsHGLI9oC0et9OdO8qS8IobwDEUBgN8yo0aU1bdZdkbQrKykvDq1IS?=
 =?us-ascii?Q?mH89QJlRqobUKK7j7EZ3bu8CVrvg4IjJ75JondeCHblEiM9zp1cbsTLhiAj8?=
 =?us-ascii?Q?x4hY1ESoyWNjbgzoUTDevEJIT82fmy97RIFl0guLUwDcBy0YGzKriH0G/iGq?=
 =?us-ascii?Q?K8MvTLlfdbqoPsx1p+mkPYHSzraN1qDfi/qAXjyP7Dp9m+8pwdQFDyiwt7rk?=
 =?us-ascii?Q?MNHw0L3Im6tq+EkLxfgYXLfjRN1l3Rzew+eUm51QchGk+uEtr6a6jfpAnqvX?=
 =?us-ascii?Q?uIdH64CW5BhFiet/mpcEmr0waN2McbwY13nwq7JiqSZQBPN3SI6AupzWvrvL?=
 =?us-ascii?Q?2DSqjTEsMRt5+ZK1LRS1shLivM+Ty5oUaHvuiSGXHNkZ19S1ZPEsdhYlelIS?=
 =?us-ascii?Q?qrhBftRIOGY07KV3jaBOndeSmrKJbxebOjwYM5bIKcuxNkcnakdbg7FlvVyp?=
 =?us-ascii?Q?f8zicvKHaHPJzE5fcNUJoB8p79N0E6ufR79q366AUOzDmul8kivktXkd9ueB?=
 =?us-ascii?Q?P1D6rElIhw65S+zGDxxJuzBGVRajPUymdB4+Si4XcOtdFlBubZ9itB0ZUzdc?=
 =?us-ascii?Q?YFW8LMDt2F4A6300zEB+kVU2uFgko2pgk3JBlZhFMBwOcg/GkAuqvS3Kummf?=
 =?us-ascii?Q?VI9t3+D6F6Ie+aWl9re5XCdXNQ=3D?=
X-Microsoft-Antispam-Message-Info: i6oUfSnYJssq8oERaUsajdg9Cdyg0XICBbhNb5rPYgeLRS9cNOKnynDCFi9M5MUg6uvtYH8FaGkkU5iFtNwdj/uFu58oxnxb+WYVXIjtFTPcVlC5MxoNzNJMbTzrei8IZcAlD7Ckze9Zn0SZneulOrvAYjCiWTA++4v9vjwQvJgZNOXABOelM7mdDSdpiX8q
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;6:j5ufMWOPBtHMs/s2lKiGUjoBq/cvH3/sS38XxOwLlui8nGWqc6DHDrFxL6JbyQHEyfrDqmP3td7b6ggvxOGnTtC0B1Dk7b1hZFfELYd+nYfpiV4kcw1P7eOum+j+ZKf4eI9lR+n7VzBqRiChj37Ctx5szUsREZim+wArq1qXQo2AfpbSQhPcrEB/YCDzeO8IknbPQi2yvtb36izsdRCzq9mgXTz2mGb4FQsGCuCAYeG0VXncgF2LJxoaeJ2fMWWfVWDaC1xr6ibUEGdSn+aSkFodljTrjRwEhB4/0SwxF4/0UPCv0ZHD70DKQPMwm2lsxjWodPUn+rY3k7Xf5pZWYUQ0RpDyGSojvH8UsmqlK4MK9aBSwZFfOMORPcf37Xo+MOIjzi+WE5OsfPq2tm4ggW88cpbWQlaqRDz9X/Kl/osB/zeohLsi0wYdgkW7xVFNS/7h98G2rCX9jvlPeNk4LQ==;5:DHKJHNoDskeWepmbJsUUo77bjyUwLb8ELiRvNUHqzXmsvGqbfflOmYrsWBeprn5F2It3eONTNelMTB3lTXIv1zIJz23ja+pIXdbbKqsNx+MNmWUjWMtAfVMscj4TQnz3XtaQtAr5nx9z70KvjxQZD6H7OTyj0/kPEKj8XpWi49U=;24:bukO1tQ50s1bdq5SxmTw3CcTuaftfEESHikHjfc+80k28TVQoeVPJRq6bV8fWKmJaSUy11bn81FwlASnVysvbq9lj1/KsDnjWKC3t0mKRzI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;7:F5HWNUk3gqyZj5jWzk8CMdIdo8u5XllksFtKMGxoPCyPTGjKC0AMTGQMqNoxtZc1WO+c6YKVWWed4eETGklsZUn4wMpErMe8EpCsw7G0zRNcGfvkuhEIJGVRFgUWya/OTh/hRY0ir08KHPzmyVdCaqwOqHig4aa82fCZs1Sm7lB0w09mmtZYWN45zDQY7nqMCz4rbxR9MQfMaClBzcE1slwlg0qfvzE05QZxLGwGYWpCQ4i9zd8g/0fvqEA1P3Dp;20:XHoV54i0ZNvh57XXV6qkq2/zoZzUaqmDKFE9g+fepgm+0VHNkD81/yRDuneh+1LuSEl9x/i7cfF7LPszr8+q0lYs0TJwZ6n/o7d9V0OBt2g4xWPl3j1NDDcUw8yuKWOioEhlvASbV05Mlh8uCC4hm9QFki4qZMRIAiqRtER6x1E=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 13:51:42.4347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2807c1e9-d055-4b2c-4b82-08d59bc587e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3260
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2018 05:13 AM, Shakeel Butt wrote:
> Question: Should this 'flags' be per-node? Is it ok for a congested
> memcg to call wait_iff_congested for all nodes?

Indeed, congestion state should be pre-node. If memcg on node A is
congested, there is no point is stalling memcg reclaim from node B.

Make congestion state per-cgroup-per-node and record it in
'struct mem_cgroup_per_node'.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 include/linux/memcontrol.h |  5 +++--
 mm/vmscan.c                | 39 +++++++++++++++++++++++++--------------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 8b394bbf1c86..af9eed2e3e04 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -120,6 +120,9 @@ struct mem_cgroup_per_node {
 	unsigned long		usage_in_excess;/* Set to the value by which */
 						/* the soft limit is exceeded*/
 	bool			on_tree;
+	bool			congested;	/* memcg has many dirty pages */
+						/* backed by a congested BDI */
+
 	struct mem_cgroup	*memcg;		/* Back pointer, we cannot */
 						/* use container_of	   */
 };
@@ -189,8 +192,6 @@ struct mem_cgroup {
 	/* vmpressure notifications */
 	struct vmpressure vmpressure;
 
-	unsigned long flags;
-
 	/*
 	 * Should the accounting and control be hierarchical, per subtree?
 	 */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 99688299eba8..78214c899710 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -200,16 +200,27 @@ static bool sane_reclaim(struct scan_control *sc)
 	return false;
 }
 
-static void set_memcg_bit(enum pgdat_flags flag,
-			struct mem_cgroup *memcg)
+static void set_memcg_congestion(pg_data_t *pgdat,
+				struct mem_cgroup *memcg,
+				bool congested)
 {
-	set_bit(flag, &memcg->flags);
+	struct mem_cgroup_per_node *mz;
+
+	if (!memcg)
+		return;
+
+	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
+	WRITE_ONCE(mz->congested, congested);
 }
 
-static int test_memcg_bit(enum pgdat_flags flag,
+static bool memcg_congested(pg_data_t *pgdat,
 			struct mem_cgroup *memcg)
 {
-	return test_bit(flag, &memcg->flags);
+	struct mem_cgroup_per_node *mz;
+
+	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
+	return READ_ONCE(mz->congested);
+
 }
 #else
 static bool global_reclaim(struct scan_control *sc)
@@ -222,15 +233,16 @@ static bool sane_reclaim(struct scan_control *sc)
 	return true;
 }
 
-static inline void set_memcg_bit(enum pgdat_flags flag,
-				struct mem_cgroup *memcg)
+static inline void set_memcg_congestion(struct pglist_data *pgdat,
+				struct mem_cgroup *memcg, bool congested)
 {
 }
 
-static inline int test_memcg_bit(enum pgdat_flags flag,
-				struct mem_cgroup *memcg)
+static inline bool memcg_congested(struct pglist_data *pgdat,
+			struct mem_cgroup *memcg)
 {
-	return 0;
+	return false;
+
 }
 #endif
 
@@ -2482,7 +2494,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
 {
 	return test_bit(PGDAT_CONGESTED, &pgdat->flags) ||
-		(memcg && test_memcg_bit(PGDAT_CONGESTED, memcg));
+		(memcg && memcg_congested(pgdat, memcg));
 }
 
 static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
@@ -2617,7 +2629,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		 */
 		if (!global_reclaim(sc) && sane_reclaim(sc) &&
 		    sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
-			set_memcg_bit(PGDAT_CONGESTED, root);
+			set_memcg_congestion(pgdat, root, true);
 
 		/*
 		 * Stall direct reclaim for IO completions if underlying BDIs
@@ -2844,6 +2856,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 			continue;
 		last_pgdat = zone->zone_pgdat;
 		snapshot_refaults(sc->target_mem_cgroup, zone->zone_pgdat);
+		set_memcg_congestion(last_pgdat, sc->target_mem_cgroup, false);
 	}
 
 	delayacct_freepages_end();
@@ -3067,7 +3080,6 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 	 * the priority and make it zero.
 	 */
 	shrink_node_memcg(pgdat, memcg, &sc, &lru_pages);
-	clear_bit(PGDAT_CONGESTED, &memcg->flags);
 
 	trace_mm_vmscan_memcg_softlimit_reclaim_end(sc.nr_reclaimed);
 
@@ -3113,7 +3125,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 	noreclaim_flag = memalloc_noreclaim_save();
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 	memalloc_noreclaim_restore(noreclaim_flag);
-	clear_bit(PGDAT_CONGESTED, &memcg->flags);
 
 	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
 
-- 
2.16.1
