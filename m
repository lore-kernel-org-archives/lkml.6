Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeEVKOe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:14:34 -0400
Received: from mail-ve1eur01on0110.outbound.protection.outlook.com ([104.47.1.110]:53179
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751763AbeEVKIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:08:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v7 04/17] memcg: Move up for_each_mem_cgroup{, _tree} defines
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
        penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
        longman@redhat.com, minchan@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
        lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Tue, 22 May 2018 13:07:55 +0300
Message-ID: <152698367509.3393.9093345957882703581.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR0201CA0004.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::14) To DB6PR0801MB1335.eurprd08.prod.outlook.com
 (2603:10a6:4:b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1335;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;3:mnphus1yJIu25Cbwhc8CKVT9RJMhjREqnJ54kJqA8byhd+ZVWOoVaaP1+ILLyiZUzPxLluNcx7F2g52vtmf3MRRSnuZ4WRZQqlk+6wt9wMxSFXjPZRZDR+QCF8rqCNdet1BaSHlFQLjK+p+WK6WZwangJo0yujEjmfVipAomrENbAGkuYqLjuUvhqA62p0KmsjGbfw7W9LDoLXDyY+qPpiL2h4vqnmENcLxbG/ZUm35n0UffIkT8+10TZFeE4ltS;25:yk/WSKNw8UOzGi9HWYOwiFncEZmW4uhpUTG5hyqTpuERtXjSYy3OR+UWpT8WvubMVwiQGExH8PuuOQu3yNIT7X/ZetPHvqP9aIscL6a6x1rcfSi0Xv5H7W4YFHZUeuYLBgUC8YaFTAQGBK8D2yMPP76FknZJdGfDECBEeroXFqga69/L2ZqI3GSXeZTTv33ZIB/ENodeV5VaYIh17P2Pvd/lP8sjBNNey+Sm3tZvG+Ip2mOsRxhbsmIELVg1eIwwkybt2k7g1FZq0QKjQelo93gepFp7DppJ7sMC9P0ppyV6kxrhzoKFrEIZVLxgLeQavXUc0VJjR+PgVHS4r+/2Mg==;31:FOr9p68B0zm2aUfHM7H9br0ghyxDvnzi1R0qJwZWWPbzuXk3tHejUAxLlTwx4grNUmyUoybRYgUG3KkObOdMFHc0Rq9VAeQRle0rO41RCYVxNWhsPuXleCj4wQdAVFaL1qkzWGh/4+w+toKvDYYHjm7X76iO2P3g44/xGdrpQyui9mWhuK57+lEVzpTMbUtGgdDtpIvbENS9FFxGlvQraXskVE4Esa/0EekM0uTT4s0=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1335:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:rgTcMJSDDUFynLZB/xi690LM2BB/NqD4Mo2FzvqSP231J6ShHcpGiaXDxjPwXx2vN+C91kL8CuR57z2UsJVWre2bRJPv9uFm3ykium7eWCCNDKfuWwkus7J0Vo3ty9bBikJK7mn6Fsr74bwf1G15q6Bu9OEwjWPmsQrQY/QCdKfg1U/D5qQrB1elcFNzBiGdg9Q3JJwwnEGCQ8hb4MODMYUMvOdIrt7RdawW/DK0Bcs+GxMMJVBcwf3sidQJVK+Y4WCAPaTxq0AgesVIFdE8lGlNF3HAnnyTImegWOsVwv57Bf033lH69LMTCTIjh8NHhoZZ8KPyk1CacaOQ1zlqSTDXcZW1kLllTZmNLWnqCbrqYpGC5mKK4nrS5KhjdgeiGO7OwVimi/t8X5T3XCgk7x0HcanHix1EiRGYWH+Y3qUsuhoob4DiC8Okhvj+hYR6Ipf/so07OQ6UJuGOnraIQfvKn+z6TBZRZnWZ8Z1edvJhAIxMJxJe1EUrPMUhUfa8;4:BQ4XHFfCer2aJooEojc4E/wySzLT9piSPl+RHXdeIhl2GsT1ch5Wwxb1EY85M1W5e5/FwACeMaFbDpxws+EcVa4qU7Jprg5+UkvYc3u08e1nwYdgQN4P5Nu2hYTO0NAPBjRKOUVtL3PLW++sulS0YHNM6LjJU/Dnf+TnbnyDxYm8t0sK/PxYFFviflNqMzExnlCUuUDW77v+OuRobLYJBfB0ZTEJDQrxCKH7R44EPIIE6zd39GQ5NRL95gPk8R86mpJ3Zg8Ikj0HwgEwGoLyrw==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13350DDCEFDAA7E1DE2D0C3DCD940@DB6PR0801MB1335.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1335;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1335;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39380400002)(376002)(346002)(396003)(39850400004)(189003)(199004)(25786009)(50466002)(47776003)(86362001)(26005)(478600001)(97736004)(2906002)(2486003)(186003)(6636002)(16526019)(76176011)(9686003)(55016002)(61506002)(66066001)(39060400002)(53936002)(5660300001)(7416002)(230700001)(386003)(305945005)(55236004)(33896004)(3846002)(6116002)(68736007)(446003)(11346002)(6506007)(476003)(956004)(8936002)(7736002)(58126008)(7696005)(52116002)(486006)(103116003)(105586002)(81166006)(106356001)(8676002)(316002)(81156014)(23676004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1335;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzU7MjM6YVlSbnNFRkx6K2lKcytBQ1dqRjJhbzVH?=
 =?utf-8?B?dHdTaC80ajY4TFZINmg1bmlhdXZJWjIwbUNMTWpaU05la0xiZFVQRzdERzhw?=
 =?utf-8?B?MkU2WDJESkw2TTY5aENCM1J4Z2xEQlFQcmE0cjA3dDJxY2VEaVJBc3VOaU11?=
 =?utf-8?B?TlFFQy9YVi9DMXdaaExyZ2tKUmJoSGtrVlE2ZkhEbEF1OVREVnloeWdRcG15?=
 =?utf-8?B?SCt5ZGNHeHdpYkZJNndJdXo5YVU3VDc4THM1Z0pscWl0SGxzdGFlaERnNTlM?=
 =?utf-8?B?MlRjaFA2UEM3b0VNbE9GL3NXeWZvZGxtdzM2MEUyTGFHL2FwWVFIbFZtRUZw?=
 =?utf-8?B?MWVSU0RYbXNsU05ZVTNUVGh2VmlJSTY5NFJKQ2NIbFJZSkxlZ3ZQdi9PbTVY?=
 =?utf-8?B?ZjJaWnFjSGZPdlN0ZXNvWExCN1NQQ2puZU5FWHc0cGhjZW9WUHRSVmFxSmY2?=
 =?utf-8?B?MkxRdldLOVB0YkN2UGhwQlZ1aEEyZDFYd0VrSkp6WGJUZXdWQzF6SVhZTEps?=
 =?utf-8?B?djJkVmtCYUFlbThqYmhzV0dXQ24rMkdCbmxCejBrcFpzcUY1OE5Oa3ppSStn?=
 =?utf-8?B?bW9wRnNyOTJLN2l6ZUZYSzFOK1lOdFdOSGJMZ0NXRXZBeVh4M0w1ak5IQXV4?=
 =?utf-8?B?bE1UZmo3ekVvSDhaVld4UDhqejFTSi9OcHlPcDN3RmhZTnhPN0Y0UmpvUGlx?=
 =?utf-8?B?Q0tud0tHY2pRcnp1YWpISXFwN3ZvWlJBeU9CNnA2dnYvSks0SWlLVXA5bnZw?=
 =?utf-8?B?Um93ZnZyMHlLdEN5UVRVTUJ2Ky91bmM1d0JRNUpnWDU5bHpOZnJteXZCUW9l?=
 =?utf-8?B?MW5EaW1xYzF4Tk5xM2krZWExajR5WGtETmVpdE5wdytyODZ5WWdEK3lIdjNO?=
 =?utf-8?B?dElkN3V6RW9yUFd2L1FpYlBxZHJFKzZzMVptZEFzd3gyeTNLdXpQMG5wcSt6?=
 =?utf-8?B?T2dkcU9iR1dTM1dNSllNKzZMeWtDb0RNV0hhVHZjQlhXNjNkSGNrWXRiUWxH?=
 =?utf-8?B?Wnd4WEVjdEVic1NpTXBQaXVwOE1Sc202dWFmMVlBNThuWnJ0Nk5FTTEvNDR2?=
 =?utf-8?B?NlVQSjMwaWpmNHFzZHAwTE9GbUZQYVVwOGE1SHN6dDF6QW01NVRhU3FPeDZm?=
 =?utf-8?B?bXYyMGJ1ZzZONjAvZXZobnpMRWkzbkNLRjRwdHNHYWNmdGxTS05VRnRSK09R?=
 =?utf-8?B?Y2JaOW1nM0gyakVwT0lieGxhbFBiS2xVSFFNbHFPV2dZVjZ3ekQzTEx3NzI4?=
 =?utf-8?B?MTJ6L3VqS0RjOUZ6ZXkxejVMdUxQZW9URlRBYjhya1Y1ZEtvVnF6QUprU1FM?=
 =?utf-8?B?Mmg3YW1PUW1KcDk1UVljdHhsZSttanhqV2pHRTIvSzJoWFM4QlhLNXN2c1o4?=
 =?utf-8?B?TFJFS1huRWNZUGhTeFlUb0lydm9TRTl1enM5YlRvVXRJMDZyYmkxZmtiSzRi?=
 =?utf-8?B?YVNUVFR1S0w0NmlCRno0NS82SjFBRm5jOXdrYk05NDhhUmlyMjM4RGlSMHJI?=
 =?utf-8?B?ajJOcGVOWmVDVElGVERlSWo4UkFhRHNCUXdLNVVzeDJaUDNlQ2hkNWl1NFl2?=
 =?utf-8?B?clZwd1BaZE13VFkxamg2Sno5NHdQbFRrbVdaRkxFRFpnUktNSmlnVWxWclpQ?=
 =?utf-8?B?bVJ3d3g0S2h1dm5HRWlDbnIvcFlEbUh1aU5nSFJuTTFSVkZIUDE0TUZFdktF?=
 =?utf-8?B?ZlpHaGxiMk01VGd2emdtNkY0VnkydzA0aGZiSmZEcDlCK3F1REluTTlzbzdV?=
 =?utf-8?Q?OQyryH0fW7ShIFVayQsdrryF3h2YJNO8u9c4Uoo=3D?=
X-Microsoft-Antispam-Message-Info: UsYzMCRUtrrIQLSXBH967npAJkfJdSYdjeCyOuePy+q8bHX3udWcQza71OqCLInfci1DE7L3ss/vxp+wMWF/Rk7RfgGzk5ck+a6+Xs2xbV0Y3IRfwMGHkgC1e0llhCLGdYAMy2Z42DYcmHm/WvCFk/DEo1wOI4LgVfwXaXBjgFDPNIVIcmUSLZzre+XVVmOL
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;6:JKEEWz69CATLQAp9fbVfyACPzbBspPH/U/8biynsOomAdQbppWoAVEEcqiSyObqw2hcsYfoadkcmuCyy5kkPNXXz+v2V88w4vusUVm+dT5ikQEkcm5gg1jtAwUHULVJXiupowK4JHmHWNxvlKD+89xEDj7kH9sFuSqeQGTxRah/URxZ2trew3a838mpjs+cymqcoLUaWVxV6JD5vgkWwY5+Rss+mph3+91Foy0KCBcUVMaMpfjpF99kGClAPcYy6eBxgcqb/jDWkb93Dho0zFbTcC1jRry/jyTvvxVgs7NzhZ6U9AyAXjVTiUS5JztB0DOASe4P8/gUODMcnsz6Wz7TooCekV04NCHpf1FTjQzC8oaDM1eNMlok2FUz+aunMzmZqFa2GK7+PP6xpKXSFC57yii8BnQ6aOX0OsLF3Lzu7QLmVhsmdJUKN/eBCHYStK2I3tv7WlVMt2HR1bNKOhg==;5:8B8M1zXkQcBgOJE+NtNz4NLBYec3tU6D0zGRWwt7jm4xhP2upF1RZnM9S6PCEcX26gLXirutOpW2odTJ+nrFk4yNw6CykOvU6Yn2zhGOgetTg0XqvYYSWQzdDEEcnktM/XIDRLuQaae8oT0x2W2WvJC5M2fsNKA1a60otx8BGRk=;24:Giam0LJWyjW9o0acfve1hVCP1YWMuJmt10+zsLP/0sYfccQeWFoOZYHDLtHU+Er4d2zO2aT0AEPGSa0zFAIcKpRGEGwVFWQ+IdmErW31aSs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;7:WOx1SPAd2o4uGTMXj205QcXkvrlgO8fih6GT05HXHjtVnRivO+vwFOvu5DZzv1nezuqMR1DaqnivcrjmMq5pUCjpVP1s18Vb1yLfAg2VPOA9JM9GTJ6CGnlTG1z386kWnz9ocrNSA2qnvE5ePzbHf88Hmqq/TE6t2XTUAb/UFZz6/r2wT/RCe0mHJW/6I5B2L3KzLG3kvDGgGZ0QdF+1XWb1wIJJ+gTQdlzzQLQuEIJNTgsv/OUnWNWg2XOQRtzA;20:prcy7ooxWKu77xrpX6WJAh7VRH/GIteLwC6MwdquJ1jw/J/cwAaeJ3AfZoYBXmhtodAewCjDEYyNC9467hyx2AOUwpw8qIKFWNi/8675rMyuSY4F82NaJn1Jiqb49Y9AdwLVkN0PZyGC/1py4gjUjdoPw0IY6OnVC/Vs6qtzl54=
X-MS-Office365-Filtering-Correlation-Id: 3d265698-d016-4b10-fe63-08d5bfcbe598
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:07:57.6098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d265698-d016-4b10-fe63-08d5bfcbe598
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1335
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next patch requires these defines are above their current
position, so here they are moved to declarations.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/memcontrol.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fc67e43849eb..023a1e9c900e 100644
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
@@ -867,21 +882,6 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
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
