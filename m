Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbeDFSCh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:02:37 -0400
Received: from mail-ve1eur01on0115.outbound.protection.outlook.com ([104.47.1.115]:29668
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750807AbeDFSCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:02:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v3 2/2] mm/vmscan: don't mess with pgdat->flags in memcg reclaim
Date: Fri,  6 Apr 2018 21:02:54 +0300
Message-Id: <20180406180254.8970-2-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180406180254.8970-1-aryabinin@virtuozzo.com>
References: <20180323152029.11084-1-aryabinin@virtuozzo.com>
 <20180406180254.8970-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR07CA0047.eurprd07.prod.outlook.com
 (2603:10a6:7:66::33) To AM0PR08MB3251.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcd32830-ef1d-4ef6-ff8d-08d59be889f9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3251;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;3:ZAi7E+MpDWliViA8biQugPNJf8SSahrPgq5OMSBJnrEiCN02Mx9GSOs2aPHZ3OSUUz1FqL4ncrK8KYgjXlVdkWMgH3FlCpG+AtE2KMu/CLBWk50DJFCtb9l6hjOirwIeHTXT3vr2VbcIYy2u2OUOREGjmoHmUc/jnu4I9VWavlqm96cRxayLfWXUyDAzBgbjlX376fZJSxJBNKmOBOeDtaR0CRi6q3IWxzIMxUyq5JQfyTTbZtux414IazKl8b//;25:xkOsYpi6WO7KoMhtX0eSxyAsaKHQmApja0hpzAY6r9C5ufK15J6mG9gjuLsm3jzADXN0OZU0ewSvSHelFucZiFVBv7fXzTtfGJ5ja3xZC0YPIJUiDR2xe/7tloIemg7fbmr6YMVcwVXkC+YBl2mJ1LqMyxOwM9evZj7+yRA2DB/oZZG9+2g2Gk9M2u8xAW9YnktvXtzjw2sgJh6IOl+b1W1fSvEq8DlNa8k3VgiiHvC3bUGayJbiMtqMsbjCfw68gCYeFRYuc9TpelsD2mhMxLwOmlDyserP4/xxlumZJZS8lMZyBUuY9st0x7p4gAValLLeW1WlanXgyVsdqWWZ7w==;31:cehamMOJidb9qyeyr9CZCAM9VvxT7j6PC7MSJrPCPXgu1aeaoe58zmUq4Qcmih35wObLqlM5PAy7wX3ODweG5sDkhVKuoYDiBanxlvRK9PlHJliAHVNJ50X2AFX9Q+uAzqGYPBHnsYibf4ccuA5/mmXwldXNUifUReRsnwEoKyjqVFQ2tQ2+eN4BXu6iqFZEdLwjltIm8V63QIxEwMDIdpltrAAxZIzEPgiFeffWXVs=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3251:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;20:pRu1sLWntRjQP0sWB24y8xXH/sYFhx4LyDWWschHvUF7AKWZEETuEpseEdFK3HNONvutkeuojbX4+oNvX8fVXcU6i6j8Vob3q4a4w8AaaPM7zWSbfGkvh8lm1W0mY/9GpkfNEjfVb11I0nj+Ni6AHaVP1rmXOTpm8wgo54dBKHn+dryuqv+3g565KqSov7SfmVwC6vsizYEr24md8H8e+nvalOnfPfhFoSp+uxOk73GDTphN0D5JcoFiVzIcr9H14TIyV8vzk0J+nAfdC8uklAnZVUAbjyc1/BgWer30P8gCX1+LTxEQhCeqqzdhVte4OnDR7ubOSvEfsETMylHMksMVgc4WYfT7zR2//wfXKB9K9jT2Uqz1U1C4XMZN0WJWEiDEWKi+qXU7xeztwMc/ZcI6t3A8TwxVIn5bTU5fZcFnTRptYzTj/3T0QS1rrmsqIhPQcvqa8E3OaaRVX5G7JrQcEk9GsoXKGDDa8cMoV8mGDjLLu2HCkNKlxNrSWUgt;4:KHHPPEm5HH+Om85SDF/sfGRilAx3sy051KI9b7sD1DmFI8Lm8+CAjB6VA6UVvCWISoqw7BGZzdHD1sTjLW7f3zCUA6sme7a64YZidcG3DqzEPEC25AVf9RL42Pn7bUP08NVYdN0I18SXwbiJvlssMAfudwMWdmh59lcEIZEoYjUpW4IfC+R4BUR116SrBCVPMU5YDc8uX5JRe6pJwws8wFqTnlinzgSbvjFDcJhT2Iu1HCqpShJdeA/EG0WeCy6Lv/rsLNnEXl4qTu9iyhkxxLCyNHJDgO6AZv8XtEnWqez/wCyj28kr4OEGk9D463zT5MQJh6lInKjvprzPDjRbOPDqju3rAGUqUIJNy9iXN1c=
X-Microsoft-Antispam-PRVS: <AM0PR08MB3251B58C8174279F84626B74B0BA0@AM0PR08MB3251.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM0PR08MB3251;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3251;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39850400004)(376002)(366004)(199004)(189003)(54534003)(386003)(81166006)(86362001)(478600001)(76176011)(6116002)(53416004)(3846002)(66066001)(486006)(105586002)(956004)(2906002)(16586007)(1076002)(446003)(2616005)(11346002)(6916009)(316002)(6666003)(47776003)(16526019)(97736004)(476003)(25786009)(52116002)(59450400001)(4326008)(5660300001)(81156014)(8936002)(36756003)(6486002)(55236004)(51416003)(54906003)(53936002)(6512007)(7736002)(6506007)(50226002)(48376002)(68736007)(106356001)(305945005)(50466002)(26005)(186003)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3251;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3251;23:heVAdB8fV+PaqB5U0D++igdTVHPyGjOjFmJfJ0/QB?=
 =?us-ascii?Q?+LiEgbLH0iA4tpECKf3jVJl5ZQevSGnwxrso7w3oOdyGKdccna7H/qhAhUIa?=
 =?us-ascii?Q?ChtQUoVMkHAO8xWpU03zffIqoRc2rVcbR/YeA1uXCt9hRIAvuvSiyBlIxcn7?=
 =?us-ascii?Q?22TFlmn+ELdPYLJ4ukR3+tujvCDnzTAP27xOQFT6q5et8ovQjwMFfH3pDei6?=
 =?us-ascii?Q?Aar9DaYLmr336RBwmJGBgg6nE7u+TFbZHRrPhLqoaVHFV48NrdbLzNe43XZB?=
 =?us-ascii?Q?mb2bIpoAb7Rj5CtP1LFJrQB25hvMSYvr8+Um78cbRhLkDP5TcwXckjbST36A?=
 =?us-ascii?Q?U0/0z1yx3u6lqMbSFIRxrYhKUt9NqCu3vcOat8IUDPRmxYDas+BYlN5+n8on?=
 =?us-ascii?Q?Aj6b3gSjHfxUOt4ke9b3FsUIfXBZ+BHsOxDSD2YpR+T03z4UujbXTxBk/GwV?=
 =?us-ascii?Q?UCwg+l6KPL5D4inmNA0x7ol6zTMXWd90UXglRT+9gB1vlj8VoQi6twdaDYh2?=
 =?us-ascii?Q?fSnG24H8orDppJUNN0KnJkeAnR77lZkgFUgbvXbBb8qhpE/A0NHGNHoaVAeg?=
 =?us-ascii?Q?IujAVa45qUCBXYIsJ+YE/IIZdD0z2NMIqz4aH2zMXvH+g/NNuvaWmNpif/44?=
 =?us-ascii?Q?oFst6i9+Gf7ECTAxrb84R52GVqlwu4UuIpdUAee8tFOkA7mXYFYdy/nwPll3?=
 =?us-ascii?Q?wnryFBl0EcfzIBaeRQY3p5O7JUSDimMcmB2ZMkhfbeWAjr6l2ty5IxTkWpJw?=
 =?us-ascii?Q?Ai2RwLSqQbCbPYVjdNk94hpdQ0NFAusPDco9Y+KJjW2Lfsunteeuasdn7Ih8?=
 =?us-ascii?Q?i9b1l1fgbch1Wr2NXS9/rqbJGuqlFyoLAuGtL99rJwicAoa6VU8X6o08a4oz?=
 =?us-ascii?Q?QYbP9ushG2dk5vTzw/egEPE8lfQlyX0b+f/FY8MMRi7aFMEdwojUaJGzE6Zb?=
 =?us-ascii?Q?rNLzXQ97koh5bNLpq2c2BNaarCBtnlj4so6Y24bI7688LAC+PHgiCRPmUcsB?=
 =?us-ascii?Q?rlhbj6DoCgutHbzbiQRiuHyxttqUAxu0ZRX+R3I0mf+SKQr9c/njtZyL6WWZ?=
 =?us-ascii?Q?5LFqjGkOo9JbposvYl7283NI+XTNUYAFHR7zis1Dtv/b6qKJWrLr2QfmtI3A?=
 =?us-ascii?Q?Z84ln98f5/tgtJfIsjB4DR/Tkgbmn81Cw7BXcektMpv433e2Zpz21jnj79cO?=
 =?us-ascii?Q?mOn6ogU5P+Ozkp6Iwe76u7A/sIyvlpgsANmRs8yJcNzaxay2/+jlgkylcfaf?=
 =?us-ascii?Q?jkhI9uxFVSCq0GeGxUWYJT4ZrhMVeQmMEYAr7wtYVW0erqJ03n/4MThRxHLx?=
 =?us-ascii?Q?zyuZGISk2NiugrBVvZe0Fs=3D?=
X-Microsoft-Antispam-Message-Info: 9+NPxP+vUqkg0M7+GJOdS+W87gz9mTRjxZEjMS4w2kZQPSGsoJa2wATp/1hfEeM5F5sAUJvIfrQefQN4NiOguDrtArjij2HQup6v+vNy7Bn/WnChl66jRQedtwFEIDW5hCmGffK9JX7JrocYAj8098CStTqq9nLCEVlM4YIMYRzxZhSutaNHtoVatSsCXt+u
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;6:Cf7ytg6yHkr0x12sVO1AYh1rihFSGHvi0laG95/EFyrE9kiAe3sEniazFP7jPzC3voNTarVRbo+5CbIHOvMXMfFYaQ+ZvXyzR4MMDtcGsGd3z22Yrqy+FGRtCXskpRj0B2kcV2J8T2DBjA8ry0MEMEQSisYNsAOXAxaZp+3SUoyx3n55Vz4Z29YPl7eWxUMD+21E7MjFpCtM1A7jPs7NZpTpKCqzQUA7BYFW43fDkVWdoy5NTsxqkyaVEuRp26i30bubBmCPM09DPx28DXVDU/FLWPYw3HzT+veJbljEhAe4zyJNCxkvMMxVfSXl9tKe7LkEZqD0PUyEWlVyVyjE0rwEjRaCMPwm9D7gFGJ1CYrztsBxr7e2EiQNsq2ZrSa0TpGjfLpeD4+B98RQuK+tTEt3GIxrlqH4+ZIunAJN0GQe3aNghkF6JFVIFxF3zX1u87VAaMYWr4dNeCPVrOK0hA==;5:evgCKtRyheNpRl7EPE0sKfj9E5Jkb3TqkDs7x7v6+LZWYMGKFQUVzQLbxkGOowTP4sFFSPE0HmLuIR82Dgy7ul6BRqk0KIMvJlYW5n+dMREqYxGI9c4zTcqH3chCNFOzgtZ39EwA0ty6WCebmVvrDJgIbd4KU4an5kWI/ZbHQ0g=;24:xlnfOExsi84kW6XUTDlSdTKNb4vAKmtTigxxv4dpZuDIiXAllIjbXjTTq+vYWSAFg9WcjOhsoENEK62EIhf5MNBi7xIlJmdJpN+0xJmBAgQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;7:M6fRuPox5ol36iCz2H/XTKJekF9PT65O3myj4kI9EoyVeF0jhfT2YJ0KAlUsafpTcrmbTaStKH1nVq+H8jqvHnnSTO9Tj/bwRYi7DdysZhrsN3UXrrsI8SRW7F+l0i0xCdoq0oE9rmXweiHi4nAW+06C+g8vHpaOb5ySQAMNrsiu8zcXV44lyjiQyAnFD2XpFLNwgHPFPhGnF5qgE1a8U3//yAQTytPmhuhz3Y4eivE3TmJiaImibxtJt7thQNaR;20:lPEYXPe7X0PbSytZiJ6ZTFp+QtNf7+S2b2XXKfaKmIfmG0NLwJWPpoJqUEUod6PqBjhL5aYpfoYLV7gr1KOcS6FwOAZ7FgOHb5sUEhGmjrIQ7qZBehcWzXuTD7o6cJtM7/IZCzbUTczqz23EDT+CI5121/AiDZhj9HncDXgyHEg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 18:02:18.5029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd32830-ef1d-4ef6-ff8d-08d59be889f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3251
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcg reclaim may alter pgdat->flags based on the state of LRU lists in
cgroup and its children.  PGDAT_WRITEBACK may force kswapd to sleep
congested_wait(), PGDAT_DIRTY may force kswapd to writeback filesystem
pages. But the worst here is PGDAT_CONGESTED, since it may force all
direct reclaims to stall in wait_iff_congested().  Note that only kswapd
have powers to clear any of these bits.  This might just never happen if
cgroup limits configured that way.  So all direct reclaims will stall as
long as we have some congested bdi in the system.

Leave all pgdat->flags manipulations to kswapd. kswapd scans the whole
pgdat, only kswapd can clear pgdat->flags once node is balanced, thus it's
reasonable to leave all decisions about node state to kswapd.

Why only kswapd? Why not allow to global direct reclaim change these flags?
It is because currently only kswapd can clear these flags. I'm less worried
about the case when PGDAT_CONGESTED falsely not set, and more worried about
the case when it falsely set. If direct reclaimer sets PGDAT_CONGESTED, do
we have guarantee that after the congestion problem is sorted out, kswapd
will be woken up and clear the flag? It seems like there is no such
guarantee. E.g. direct reclaimers may eventually balance pgdat and kswapd
simply won't wake up (see wakeup_kswapd()).

Moving pgdat->flags manipulation to kswapd, means that cgroup2 recalim now
loses its congestion throttling mechanism.  Add per-cgroup congestion
state and throttle cgroup2 reclaimers if memcg is in congestion state.

Currently there is no need in per-cgroup PGDAT_WRITEBACK and PGDAT_DIRTY
bits since they alter only kswapd behavior.

The problem could be easily demonstrated by creating heavy congestion
in one cgroup:

    echo "+memory" > /sys/fs/cgroup/cgroup.subtree_control
    mkdir -p /sys/fs/cgroup/congester
    echo 512M > /sys/fs/cgroup/congester/memory.max
    echo $$ > /sys/fs/cgroup/congester/cgroup.procs
    /* generate a lot of diry data on slow HDD */
    while true; do dd if=/dev/zero of=/mnt/sdb/zeroes bs=1M count=1024; done &
    ....
    while true; do dd if=/dev/zero of=/mnt/sdb/zeroes bs=1M count=1024; done &

and some job in another cgroup:

    mkdir /sys/fs/cgroup/victim
    echo 128M > /sys/fs/cgroup/victim/memory.max

    # time cat /dev/sda > /dev/null
    real    10m15.054s
    user    0m0.487s
    sys     1m8.505s

According to the tracepoint in wait_iff_congested(), the 'cat' spent 50%
of the time sleeping there.

With the patch, cat don't waste time anymore:

    # time cat /dev/sda > /dev/null
    real    5m32.911s
    user    0m0.411s
    sys     0m56.664s

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
---

 Changes since v2:
 - Make congestion state per-cgroup-per-node instead of just per-cgroup. (Shakeel)
 - Changelog update. (Shakeel)
 - Add Acked-by/Reviewed-by

 include/linux/backing-dev.h |  2 +-
 include/linux/memcontrol.h  |  3 ++
 mm/backing-dev.c            | 19 +++------
 mm/vmscan.c                 | 96 +++++++++++++++++++++++++++++++++------------
 4 files changed, 82 insertions(+), 38 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 3e4ce54d84ab..e6cbb915ee56 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -175,7 +175,7 @@ static inline int wb_congested(struct bdi_writeback *wb, int cong_bits)
 }
 
 long congestion_wait(int sync, long timeout);
-long wait_iff_congested(struct pglist_data *pgdat, int sync, long timeout);
+long wait_iff_congested(int sync, long timeout);
 
 static inline bool bdi_cap_synchronous_io(struct backing_dev_info *bdi)
 {
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c46016bb25eb..f292efac378d 100644
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
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index fac66abd5a68..2b23ba08389a 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1022,23 +1022,18 @@ EXPORT_SYMBOL(congestion_wait);
 
 /**
  * wait_iff_congested - Conditionally wait for a backing_dev to become uncongested or a pgdat to complete writes
- * @pgdat: A pgdat to check if it is heavily congested
  * @sync: SYNC or ASYNC IO
  * @timeout: timeout in jiffies
  *
- * In the event of a congested backing_dev (any backing_dev) and the given
- * @pgdat has experienced recent congestion, this waits for up to @timeout
- * jiffies for either a BDI to exit congestion of the given @sync queue
- * or a write to complete.
- *
- * In the absence of pgdat congestion, cond_resched() is called to yield
- * the processor if necessary but otherwise does not sleep.
+ * In the event of a congested backing_dev (any backing_dev) this waits
+ * for up to @timeout jiffies for either a BDI to exit congestion of the
+ * given @sync queue or a write to complete.
  *
  * The return value is 0 if the sleep is for the full timeout. Otherwise,
  * it is the number of jiffies that were still remaining when the function
  * returned. return_value == timeout implies the function did not sleep.
  */
-long wait_iff_congested(struct pglist_data *pgdat, int sync, long timeout)
+long wait_iff_congested(int sync, long timeout)
 {
 	long ret;
 	unsigned long start = jiffies;
@@ -1046,12 +1041,10 @@ long wait_iff_congested(struct pglist_data *pgdat, int sync, long timeout)
 	wait_queue_head_t *wqh = &congestion_wqh[sync];
 
 	/*
-	 * If there is no congestion, or heavy congestion is not being
-	 * encountered in the current pgdat, yield if necessary instead
+	 * If there is no congestion, yield if necessary instead
 	 * of sleeping on the congestion queue
 	 */
-	if (atomic_read(&nr_wb_congested[sync]) == 0 ||
-	    !test_bit(PGDAT_CONGESTED, &pgdat->flags)) {
+	if (atomic_read(&nr_wb_congested[sync]) == 0) {
 		cond_resched();
 
 		/* In case we scheduled, work out time remaining */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1ecc648b6191..e411385b304a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -200,6 +200,29 @@ static bool sane_reclaim(struct scan_control *sc)
 #endif
 	return false;
 }
+
+static void set_memcg_congestion(pg_data_t *pgdat,
+				struct mem_cgroup *memcg,
+				bool congested)
+{
+	struct mem_cgroup_per_node *mn;
+
+	if (!memcg)
+		return;
+
+	mn = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
+	WRITE_ONCE(mn->congested, congested);
+}
+
+static bool memcg_congested(pg_data_t *pgdat,
+			struct mem_cgroup *memcg)
+{
+	struct mem_cgroup_per_node *mn;
+
+	mn = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
+	return READ_ONCE(mn->congested);
+
+}
 #else
 static bool global_reclaim(struct scan_control *sc)
 {
@@ -210,6 +233,18 @@ static bool sane_reclaim(struct scan_control *sc)
 {
 	return true;
 }
+
+static inline void set_memcg_congestion(struct pglist_data *pgdat,
+				struct mem_cgroup *memcg, bool congested)
+{
+}
+
+static inline bool memcg_congested(struct pglist_data *pgdat,
+			struct mem_cgroup *memcg)
+{
+	return false;
+
+}
 #endif
 
 /*
@@ -2474,6 +2509,12 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	return true;
 }
 
+static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
+{
+	return test_bit(PGDAT_CONGESTED, &pgdat->flags) ||
+		(memcg && memcg_congested(pgdat, memcg));
+}
+
 static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct reclaim_state *reclaim_state = current->reclaim_state;
@@ -2556,29 +2597,27 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		if (sc->nr_reclaimed - nr_reclaimed)
 			reclaimable = true;
 
-		/*
-		 * If reclaim is isolating dirty pages under writeback, it
-		 * implies that the long-lived page allocation rate is exceeding
-		 * the page laundering rate. Either the global limits are not
-		 * being effective at throttling processes due to the page
-		 * distribution throughout zones or there is heavy usage of a
-		 * slow backing device. The only option is to throttle from
-		 * reclaim context which is not ideal as there is no guarantee
-		 * the dirtying process is throttled in the same way
-		 * balance_dirty_pages() manages.
-		 *
-		 * Once a node is flagged PGDAT_WRITEBACK, kswapd will count the
-		 * number of pages under pages flagged for immediate reclaim and
-		 * stall if any are encountered in the nr_immediate check below.
-		 */
-		if (sc->nr.writeback && sc->nr.writeback == sc->nr.taken)
-			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
+		if (current_is_kswapd()) {
+			/*
+			 * If reclaim is isolating dirty pages under writeback,
+			 * it implies that the long-lived page allocation rate
+			 * is exceeding the page laundering rate. Either the
+			 * global limits are not being effective at throttling
+			 * processes due to the page distribution throughout
+			 * zones or there is heavy usage of a slow backing
+			 * device. The only option is to throttle from reclaim
+			 * context which is not ideal as there is no guarantee
+			 * the dirtying process is throttled in the same way
+			 * balance_dirty_pages() manages.
+			 *
+			 * Once a node is flagged PGDAT_WRITEBACK, kswapd will
+			 * count the number of pages under pages flagged for
+			 * immediate reclaim and stall if any are encountered
+			 * in the nr_immediate check below.
+			 */
+			if (sc->nr.writeback && sc->nr.writeback == sc->nr.taken)
+				set_bit(PGDAT_WRITEBACK, &pgdat->flags);
 
-		/*
-		 * Legacy memcg will stall in page writeback so avoid forcibly
-		 * stalling here.
-		 */
-		if (sane_reclaim(sc)) {
 			/*
 			 * Tag a node as congested if all the dirty pages
 			 * scanned were backed by a congested BDI and
@@ -2601,6 +2640,14 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 				congestion_wait(BLK_RW_ASYNC, HZ/10);
 		}
 
+		/*
+		 * Legacy memcg will stall in page writeback so avoid forcibly
+		 * stalling in wait_iff_congested().
+		 */
+		if (!global_reclaim(sc) && sane_reclaim(sc) &&
+		    sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
+			set_memcg_congestion(pgdat, root, true);
+
 		/*
 		 * Stall direct reclaim for IO completions if underlying BDIs
 		 * and node is congested. Allow kswapd to continue until it
@@ -2608,8 +2655,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		 * the LRU too quickly.
 		 */
 		if (!sc->hibernation_mode && !current_is_kswapd() &&
-		    current_may_throttle())
-			wait_iff_congested(pgdat, BLK_RW_ASYNC, HZ/10);
+		   current_may_throttle() && pgdat_memcg_congested(pgdat, root))
+			wait_iff_congested(BLK_RW_ASYNC, HZ/10);
 
 	} while (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
 					 sc->nr_scanned - nr_scanned, sc));
@@ -2826,6 +2873,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 			continue;
 		last_pgdat = zone->zone_pgdat;
 		snapshot_refaults(sc->target_mem_cgroup, zone->zone_pgdat);
+		set_memcg_congestion(last_pgdat, sc->target_mem_cgroup, false);
 	}
 
 	delayacct_freepages_end();
-- 
2.16.1
