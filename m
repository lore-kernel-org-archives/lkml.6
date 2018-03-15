Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932292AbeCOQqG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:46:06 -0400
Received: from mail-db5eur01on0091.outbound.protection.outlook.com ([104.47.2.91]:63912
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752167AbeCOQqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:46:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH 6/6] mm/vmscan: Don't mess with pgdat->flags in memcg reclaim.
Date: Thu, 15 Mar 2018 19:45:53 +0300
Message-Id: <20180315164553.17856-6-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180315164553.17856-1-aryabinin@virtuozzo.com>
References: <20180315164553.17856-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::22)
 To DB7PR08MB3257.eurprd08.prod.outlook.com (2603:10a6:5:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ea2b49a-9812-4296-2c82-08d58a94390b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3257;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;3:DtQI1plkldxodA+nwIImbwb4UV63tiduGbfqCOtiUbCqauFdLSuRy+tFk8Y17EnxyCK27q7MKOzXZQ3FCVWFBccCWHwBG8fuex6MRHmwK2OgP0bNlt1mSIm9yVcjBVsmYzYG8SJIFDY79pPUg4D5x+RvEKdP/Jfd7GMTuBTqJkTc3nxgO8gtHaqcIFbz/YC4i8HDVO8aLm4129cjDvbzyUTX/dMgx44uviHejWyMXJiva09//13GRhIZEyMwK93b;25:A/Equ+SPraLAc8KgOp3l5F50oi7MUrZl6AAAWPjteUQHLsBz/sjIdQaP7kh7nMEvieQgt4AwJbgSchRelca+v8f7OQfbObonoomtm7nqPfYU7eFp4/P0wt8IdXOS3oWQ0t6cOxOep9jDzFb1VYYMIfQ+qo8dct7yz3B/v/tr/G9U6n4ut6qE6ipmWyRBzTHBf0WtXi/jGrs0jxAvJFwD4N4+cayZrFam1lp2I7vkONaH+n1jDgNCwPBpmWhr9fik53MHQF/oOZA+wvEQWn2DTREalzH/IK754DBIoVqSzshI+6HTU92HA4IoEfMXTi3h51z+4dEdIPfyjykFbvDcGA==;31:e5fsDjnHY2vOI2teIY7FlHRPl95tFhx90dlRgV0rxDGSkG5edhEVtv2Pph6Y4GOrk013Dupk2TNoX+RYAkuzOod7llhXskaCIfgYet8HUexKrv19k8X3i6QKdHIKpWddwxBirmSMc/VLW9xWm0L7zmGHCsWQmxA2ec9A2qHI5hPmVBvcwklnwzkYHjR+ECCHcf3txI7mJwI52c/8lUyTPAXQT5YThQA7Wkt8So0yKd8=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3257:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:u8ZHYk8Xml28jTOKz2gYl50xpJh3f4xiGrJDtl6SBBdpwbD4q52fUx4T2rnzSEVvASfYEHCEdR90/xVeFiqzw3oYUENmnEBWarNSeITiXKGjqfP4XQnDGq9qf5i+6YgnSBXQTAdWRBDO64dTG5eQNmuoBYFiA3NVPWpOZDBGJMw08RMPRXt0POe1doRvevI7z5LAQRLfY0dBYcGFJGsf6Inqg3ibb5n/jydgFR6NWXvAKQRjWn4Ux+2RL0hUtzf8lfusVN0Wfc4T20EQdq7QhjfHD+ah5OPJGA3cLi3wEkc8+K29Dczl2eoXJLaInaASyb/ycL1uvhnePXw3BdFtUJPktKciYbUPFG5MjeBGj9kmi4QJNSRK3LQKsSZXjw6Wy0pVYzpdvBeN8t7uOXP+k4m+PBkomfUDI2te7vYqiWccJke6vFMU53Tj2CtIMgtWLWPT3pBLuYkaBV9WWB1cEqoSZNuwqftXNpJJ8DUViFnkAN05eDsXiDF/w9EFi7Wn;4:S3muraatrG+l8A6jm90c+h8WGst53yS0Fudc0EI8KPxuRWVQj3F7DJM9cpS0xaoKw4Y8T/QdyvDJKb+S4S4S3Y/1y6y6vJzpgxjIeBmDBf/ocPaZ+X/z/3MpdNQMrXzzzer3Kc+drJGlocI9WC2ptMbrATnt4aDrGOA1CNfCGlGlw/gUK9gL3+pxR/qPyZqWE4YgYgqtZYT+t7PRtVw/T2EkPmA3R5f7HzAyO5xasyzm00Zg2no/5N8zdG67tb2on41xKTzBkI28Rz1tLxDXPg==
X-Microsoft-Antispam-PRVS: <DB7PR08MB3257D0F7CBF822DC1C277FE7B0D00@DB7PR08MB3257.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR08MB3257;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3257;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39380400002)(39850400004)(346002)(189003)(199004)(51416003)(106356001)(8936002)(55236004)(59450400001)(36756003)(7736002)(6116002)(1076002)(6506007)(386003)(3846002)(47776003)(575784001)(6512007)(105586002)(16526019)(186003)(86362001)(54906003)(5660300001)(66066001)(305945005)(53936002)(316002)(81166006)(4326008)(6486002)(50466002)(53416004)(68736007)(16586007)(2950100002)(26005)(52116002)(478600001)(2906002)(81156014)(50226002)(76176011)(97736004)(25786009)(48376002)(8676002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3257;H:i7.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3257;23:VCsTgzvKgOGdgogw5aK3Xcx4bp1BM/PIHs9v3c0sq?=
 =?us-ascii?Q?T0ELOFujEgcgzLKSuOJ5rvTULI8wcwBd+s7TqKJ7aYKZwU8vmRM7Q2TzgcLF?=
 =?us-ascii?Q?Tq1WehBpa1Qn/frkmBsTi4n20sfCk3ObWnTLWhb9ouNPdop1kL4F1CGPo6ti?=
 =?us-ascii?Q?9UIhExEg8K/Ng9yG6wVVOGgp04g40a+J4v2oMktHmNgJGS2MEGdtv9RU3I0D?=
 =?us-ascii?Q?VU1Ch0s5NPzMcMgPvrrr87lcLTYAognu9eX5/73Av57VXWV6x4vp8QaLNgXZ?=
 =?us-ascii?Q?n/dTxBRAj+pBsCZl6TnO0TuP0DSuY0cag0ub4QXPU2xmNSzUqXmvZvspyHIs?=
 =?us-ascii?Q?Tuh3J+wWucFK+pYp48FYRxxU0hFhxFWdChTzhHxfWcwgHbF+AxRa6OmV93ho?=
 =?us-ascii?Q?sxPIxFhylnu4NuhF6nygY/jhQntUbKER77BGxckVyv1opsAFgUkU7moZIA4e?=
 =?us-ascii?Q?c7EPNYnXhif5hBjk9eF3r0owKwIFDXFPw/J3viDwLjCOu9UtOg/UAU2XNPZ5?=
 =?us-ascii?Q?bMieiE+FwPfe+MZY+/oPi0sS7Jy3h7UcqLSGs45a1yb0CeNBlUC9uaJh6rkm?=
 =?us-ascii?Q?sfFTRewe8DO5z4wExWVx7dX2dycLM8DC7fDIO/IUuLR2otfJeyT9GU32/NDK?=
 =?us-ascii?Q?YYvKJe/b//Dk6THmSsfxs7nOYpxNUB0YWu6whCIKQMs3okdsJu1RvtCwTLOK?=
 =?us-ascii?Q?OBnyq5llKf+Y4vBTNVQIiCnyrCoy//V8tg6mq990ueWBYBQREt2mgWJ+clIm?=
 =?us-ascii?Q?XnXWW/vMRgnAmkNKkNrPlvECNIfjHm9lNrMjqgE32S8qAupTdc1i3ONAFBKZ?=
 =?us-ascii?Q?IbUEwxCuzaOOp1TJtZZ4Y8KtG28rAPsSaZDVe1qlFCy4WK/+Wr2kbvHrViEX?=
 =?us-ascii?Q?iEKyJNljh6Au+ckgakWLUuHWONub/Ik4pWwVxS9Z0Y21drq7Cso0hiu26zdU?=
 =?us-ascii?Q?CZrAZCHvcgjKnuFOIWrPhZooUfSHB9hQ32CWx3+G9ZetQypb8qsRW+KRkAnV?=
 =?us-ascii?Q?D5P9EQPMglDhF1jEkPb07H2iVl4SdHBw7GwIONfLcDHYzRz75i6rwfKKKaD4?=
 =?us-ascii?Q?kSXphddP4HDddKg1Oc8ywIndNT/oX9hThNawr5VLjhFgOtCkuMTCZKw7Umy8?=
 =?us-ascii?Q?dJShWnTLB0dUIReoj0/lIVF1ZkZUirOrMiBprCRzTwvq478Q0RkSQH/Za3Ks?=
 =?us-ascii?Q?0dNGN2ec5+r8bRynIRTm+beV6+dAO0s54KL?=
X-Microsoft-Antispam-Message-Info: AnhXod3WbPUl3XswZPSgMUihDan3ILtbMZ14nPh00ujrMrbeV9lMcwauaEZemDNFPyIYcDGCN8YeL8+SLsvGyFfx/XrCaYQNqfK4DHNhYwFWoAcnf4JXTGqyfNkDSFHfLYzLj/4DtqiscmYjv9q1lU33YBxTrDv3Ym1Ih8rZQX9HIa3TM2hdGKfmqonP1MoQ
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;6:A8qzo/qRM4qKotjWq8rkCI/kPl89KdbABhxZnpJ2cwHs2zKA5aCijMt+8YNlGE5ZR7CUDONa49iX0SiJegcWOmWe8f6LKLWuGR5SXqelQ+nWVoHH5YnxsTaykhXeWstR7c/lCQRlm3EcwLSRScWH6F2+jUq7K82FDeY2at821CQYM7ZZGqcVlJyjip4yPqefqrGmP2r2+i7/15qxd3+fn1e8wc8FbxQG9dAduBZ1A7u4SfLrzArR7v+pM8t8PSRK42w60Uzm8I2DkBxEy7ZK1WHGtu7ZY0r2iX7PdtbWnRRNQFBTzmnWsHQL3VAStXoDeGl05lU09o7lHTS3xHwsGKVbTH7C1qnqoXjJ5EMk8CU=;5:mILekPuPf2lSwLuMLPiBGm4OO/Dy5bndxI76MHQIjgBAmzpHYCH3aqou1+hG/lGfEIgHR9JtsNUycz79SaRcb+Q4aBIl1tAK/19tNWjqF092bputGbDgdKukEXJmkQ7waEWgn9THsM7GxKGbpNQsUKzJMNrKc2XtWrpJQ+6dBzQ=;24:1lqWgsxG9PsJQ6FS84HGA9p7tBMiupLJP3+g/ZN3bnJXCGqXBQRUjkoJRksZU5JiyTj7Go0vf1oI8R0FgbCoD0LL4AMrk3MTTHV6kyTZv8I=;7:JvAF8wlPW3M6FhwCeDWOrIKUEmGUiA2bHC1mxMBMPneS9lIHv4lZ2VGCPXQAWGRdiKV/ymCfCkHAw+loYQ+MQzUWx+oNnKCSriKbCJEZ90FVv5nv9TW2yhee0V7Xuwb6QGz2EyqJkBQucD09O+6VtgB1eCB6yHbfEIxYO7STsWaN4aSQl7nQs4N+U6IzShKm8Vu6Q96GXcDJWVwIhFjPDy+zp8u09ZLHN3QEU5SMXPyxCpJxDII/xeJdV0sEiFkY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:xUD2FdtU59Cbo1pjgD+leiFJ549F1EODZsRUvk1rSCiPSOd12+PYzQJUVIN4L8o6KAWi9yDBIocaufr0nmeJrc6AC2wyM6kFlXcU+UfGmnqx2q6/av5gp2d/psX8KxtsEA/OpsBlhOJS5JzoqKFSFb063yNyFBg966KV4klyKZI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 16:45:55.1338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea2b49a-9812-4296-2c82-08d58a94390b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcg reclaim may alter pgdat->flags based on the state of LRU lists
in cgroup and its children. PGDAT_WRITEBACK may force kswapd to sleep
congested_wait(), PGDAT_DIRTY may force kswapd to writeback filesystem
pages. But the worst here is PGDAT_CONGESTED, since it may force all
direct reclaims to stall in wait_iff_congested(). Note that only kswapd
have powers to clear any of these bits. This might just never happen if
cgroup limits configured that way. So all direct reclaims will stall
as long as we have some congested bdi in the system.

Leave all pgdat->flags manipulations to kswapd. kswapd scans the whole
pgdat, so it's reasonable to leave all decisions about node stat
to kswapd. Also add per-cgroup congestion state to avoid needlessly
burning CPU in cgroup reclaim if heavy congestion is observed.

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
---
 include/linux/backing-dev.h |  2 +-
 include/linux/memcontrol.h  |  2 ++
 mm/backing-dev.c            | 19 ++++------
 mm/vmscan.c                 | 84 ++++++++++++++++++++++++++++++++-------------
 4 files changed, 70 insertions(+), 37 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index f8894dbc0b19..539a5cf94fe2 100644
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
index 4525b4404a9e..44422e1d3def 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -190,6 +190,8 @@ struct mem_cgroup {
 	/* vmpressure notifications */
 	struct vmpressure vmpressure;
 
+	unsigned long flags;
+
 	/*
 	 * Should the accounting and control be hierarchical, per subtree?
 	 */
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 2eba1f54b1d3..2fc3f38e4c4f 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1055,23 +1055,18 @@ EXPORT_SYMBOL(congestion_wait);
 
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
@@ -1079,12 +1074,10 @@ long wait_iff_congested(struct pglist_data *pgdat, int sync, long timeout)
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
index 522b480caeb2..a8690b0ec101 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -201,6 +201,18 @@ static bool sane_reclaim(struct scan_control *sc)
 #endif
 	return false;
 }
+
+static void set_memcg_bit(enum pgdat_flags flag,
+			struct mem_cgroup *memcg)
+{
+	set_bit(flag, &memcg->flags);
+}
+
+static int test_memcg_bit(enum pgdat_flags flag,
+			struct mem_cgroup *memcg)
+{
+	return test_bit(flag, &memcg->flags);
+}
 #else
 static bool global_reclaim(struct scan_control *sc)
 {
@@ -211,6 +223,17 @@ static bool sane_reclaim(struct scan_control *sc)
 {
 	return true;
 }
+
+static inline void set_memcg_bit(enum pgdat_flags flag,
+				struct mem_cgroup *memcg)
+{
+}
+
+static inline int test_memcg_bit(enum pgdat_flags flag,
+				struct mem_cgroup *memcg)
+{
+	return 0;
+}
 #endif
 
 /*
@@ -2459,6 +2482,12 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	return true;
 }
 
+static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
+{
+	return test_bit(PGDAT_CONGESTED, &pgdat->flags) ||
+		(memcg && test_memcg_bit(PGDAT_CONGESTED, memcg));
+}
+
 static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct reclaim_state *reclaim_state = current->reclaim_state;
@@ -2542,28 +2571,27 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		if (sc->nr_reclaimed - nr_reclaimed)
 			reclaimable = true;
 
-		/*
-		 * If reclaim is isolating dirty pages under writeback, it implies
-		 * that the long-lived page allocation rate is exceeding the page
-		 * laundering rate. Either the global limits are not being effective
-		 * at throttling processes due to the page distribution throughout
-		 * zones or there is heavy usage of a slow backing device. The
-		 * only option is to throttle from reclaim context which is not ideal
-		 * as there is no guarantee the dirtying process is throttled in the
-		 * same way balance_dirty_pages() manages.
-		 *
-		 * Once a node is flagged PGDAT_WRITEBACK, kswapd will count the number
-		 * of pages under pages flagged for immediate reclaim and stall if any
-		 * are encountered in the nr_immediate check below.
-		 */
-		if (stat.nr_writeback && stat.nr_writeback == stat.nr_taken)
-			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
+		if (current_is_kswapd()) {
+			/*
+			 * If reclaim is isolating dirty pages under writeback,
+			 * it implies that the long-lived page allocation rate
+			 * is exceeding the page laundering rate. Either the
+			 * global limits are not being effective at throttling
+			 * processes due to the page distribution throughout
+			 * zones or there is heavy usage of a slow backing device.
+			 * The only option is to throttle from reclaim context
+			 * which is not ideal as there is no guarantee the
+			 * dirtying process is throttled in the same way
+			 * balance_dirty_pages() manages.
+			 *
+			 * Once a node is flagged PGDAT_WRITEBACK, kswapd will
+			 * count the number of pages under pages flagged for
+			 * immediate reclaim and stall if any are encountered
+			 * in the nr_immediate check below.
+			 */
+			if (stat.nr_writeback && stat.nr_writeback == stat.nr_taken)
+				set_bit(PGDAT_WRITEBACK, &pgdat->flags);
 
-		/*
-		 * Legacy memcg will stall in page writeback so avoid forcibly
-		 * stalling here.
-		 */
-		if (sane_reclaim(sc)) {
 			/*
 			 * Tag a node as congested if all the dirty pages scanned were
 			 * backed by a congested BDI and wait_iff_congested will stall.
@@ -2585,14 +2613,22 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 				congestion_wait(BLK_RW_ASYNC, HZ/10);
 		}
 
+		/*
+		 * Legacy memcg will stall in page writeback so avoid forcibly
+		 * stalling in wait_iff_congested().
+		 */
+		if (!global_reclaim(sc) && sane_reclaim(sc) &&
+		    stat.nr_dirty && stat.nr_dirty == stat.nr_congested)
+			set_memcg_bit(PGDAT_CONGESTED, root);
+
 		/*
 		 * Stall direct reclaim for IO completions if underlying BDIs and node
 		 * is congested. Allow kswapd to continue until it starts encountering
 		 * unqueued dirty pages or cycling through the LRU too quickly.
 		 */
 		if (!sc->hibernation_mode && !current_is_kswapd() &&
-		    current_may_throttle())
-			wait_iff_congested(pgdat, BLK_RW_ASYNC, HZ/10);
+		    current_may_throttle() && pgdat_memcg_congested(pgdat, root))
+			wait_iff_congested(BLK_RW_ASYNC, HZ/10);
 
 	} while (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
 					 sc->nr_scanned - nr_scanned, sc));
@@ -3032,6 +3068,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 	 * the priority and make it zero.
 	 */
 	shrink_node_memcg(pgdat, memcg, &sc, &lru_pages);
+	clear_bit(PGDAT_CONGESTED, &memcg->flags);
 
 	trace_mm_vmscan_memcg_softlimit_reclaim_end(sc.nr_reclaimed);
 
@@ -3077,6 +3114,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 	noreclaim_flag = memalloc_noreclaim_save();
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 	memalloc_noreclaim_restore(noreclaim_flag);
+	clear_bit(PGDAT_CONGESTED, &memcg->flags);
 
 	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
 
-- 
2.16.1
