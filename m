Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeCWPUP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:20:15 -0400
Received: from mail-he1eur01on0107.outbound.protection.outlook.com ([104.47.0.107]:19840
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751686AbeCWPUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:20:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v2 4/4] mm/vmscan: Don't mess with pgdat->flags in memcg reclaim.
Date: Fri, 23 Mar 2018 18:20:29 +0300
Message-Id: <20180323152029.11084-5-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180323152029.11084-1-aryabinin@virtuozzo.com>
References: <20180323152029.11084-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0101CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::21) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a2ce2df-7c32-401a-8b1d-08d590d18d80
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3253;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;3:h6eD6XXGglMVg/zV/L8FYYYUc38rrzKwKrEvw/7WxxQ3/4uqdK2sITXgiKrFWpHT4pmQnU4isDOxd8Fc+iyuAHK0cpF6E+B2lZ2D7nC6Y3DLhqz1RCher6a3Ihz6/hr51vZ1ZV/5/6pXDEAV3nYDDvidx8zYnbp26GFWUIe25QQYpkgjo3Cbgq++kHcXEO61UZuVvCccgU5HfOqzdir7AQgPMwFQef8hO5aVK5HK/V8ixSFP8nky1o6pbb95ggtZ;25:cK38gwET6Ww88yn9hfDcZwmfwIfK0f4PH7nOH1LOcStx9kN8ammZXrTUA86SZYkhIe0pfSgCo6tsGof/nSKfKeibzTPWsOoCk7hSoHX64dhNkM2lxtUQG1rg+kYIbz5bwGZAYrnE0XPzrr0HAdyLI/pwyRVkQ9+UPCHp42gh4YyPJgCiRNH54QYgG9NzFJK7edZFBnq9k/fAeCBktlnkGKl0OKa+9IfEY+CxamTZo8gUSrKl6xWZGnT3SNn5hDrTPU9HfqTbw8H1i7tbxXYV6bm3Q+CN+TGm7z9fUHIV2gKHS8U/sK+tvhHCVNzCdwjGph5smaBnX7ObuUXn99WQ+w==;31:w2zrDE//27g37ymMXYQHU9NmMH44ukHXKOCbRrcXS8LkneHJ8wju8KBWb5lhUhXTF6YzJTDjHJLVq5KOvV8lko+/UsAiY9Sn8hem2KeM1Xszgw86/vCxv2cbeGXsws8ooG0QYwoObTPdCbpbV+1/N/fFp9X60BxCeM+xvD/C5NOW1KE0U7F5IQMgguVv+Uah6iOLYrNHgRadS9z5jcexRtr+EIxiZu0BtntvDezifbE=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3253:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:jF9ygfcayKMzy6PNsF1CEmpj3gslOUpPbOwXoIVgkB7G5NhcE9GXKRppLl6zs+2n0m8gH0XNIY7mB4VzZ4Hbi6zeREHxwgXc42Te+XUg6UR0YHab2osXeKsrd5nrd1dHuVKFo9rR/TQw0cS+XFEW55dcl29NJK0CEub5y4x2d0CtUP7z2J+dtjpkLkhkKHWVHi8y+tLHd4k46T6qKQprHZl/GwKc/Rxp+6aB9uz3jporAEB6vzM0gR8LMbXR6Gn2NaMJV+5Gjc4HTwNutfBiQdr/lbIPejg08mv26jgW92+MX1lI9iPfUCI5iY6tlT4NDJ37qbdVuD1OwIYzBqnzVdkKhAJR7pd+CJxnCykGFy07F1Oc0B/IRTSSW2ZlD6OgC8t4Hba2Ak3rj/RiV/2KUzhL3jToYlfjGoq6xmsIhbA481tRTyP7brsz4+EYx+TcOUg1VTY8/6krUnrA0FRs4kj1ogH3P1TMuKSRDn4i9qhOL46BB5n2voUPUpezAeu/;4:rkq0J54HLr1sAR89OH3hg+aUYzVYorl6dsLpozKBcZpKO4T0civNy7QSwfGPXbPQYYrUfvCLBITfSC9PlYiilFZElH9MQgG7MjBLl3/FvQpv6cdkURP3A2Q/sZKMP6zb34VTSOQ5orAeaE2KT89KB/thWskl9KXg/vnV/TvFEmUsByFrKXRXYkdl4/2B/y3LoBRsFFBFm5tSTwFcxADggsecIn9r0TwPIs3SE3P/Y4NF6JbpfOJWHZO18cZw4uljZVb+dq71GIAw7OVuiLRPJQ==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3253B50261D9BD049D2BAE49B0A80@AM6PR08MB3253.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM6PR08MB3253;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3253;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(39380400002)(366004)(396003)(376002)(189003)(199004)(36756003)(25786009)(186003)(97736004)(1076002)(3846002)(53416004)(478600001)(48376002)(11346002)(50466002)(66066001)(47776003)(105586002)(106356001)(53936002)(305945005)(6512007)(4326008)(7736002)(50226002)(575784001)(81156014)(8936002)(52116002)(6666003)(54906003)(76176011)(81166006)(386003)(86362001)(6506007)(7416002)(2906002)(59450400001)(51416003)(316002)(68736007)(55236004)(6486002)(446003)(6116002)(6916009)(5660300001)(16586007)(8676002)(26005)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3253;H:i7.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3253;23:+FEZRthZUDeqs8XlLjiNmqT/O7iq38oV0yj7jMUpB?=
 =?us-ascii?Q?MDouzUYbS089J/x7M99ve66h8VjSdPUg42TjVBUtFIsbniApiTe5lQvMWHL3?=
 =?us-ascii?Q?oPoCzVhJlXjx///Fbu4FIwb+6FEzwhgKfV9rRAUA/pGAjTNSehretenA5u1I?=
 =?us-ascii?Q?4z9j0D8IahdLHsbCsZbq7xc+LG/C1+Du80zKdaNIHKSnASqEp15+vOQNTyi+?=
 =?us-ascii?Q?1DBDu8koiMb4JhDQc/ZTfmahqWTecE7YKwxmZon+RxkOHQ36hD26NmwuJ7oW?=
 =?us-ascii?Q?qCQXj568K4isMQnp1lQwi4oWILJvi2EhQaECtRX0uJMbF+aGkfAE5BKa6JhO?=
 =?us-ascii?Q?Kd/X0FAaKRe1HK3dakj1oZ+CZ60bqR9xKTVJF8buHbfIkLWYPeXmOYNqA7LJ?=
 =?us-ascii?Q?2QcWeQ2By5/qTyWFn8FVPtrK59pLIMD9KYY8gN4N+1URrhnWh38FCL4Iw1Bo?=
 =?us-ascii?Q?Fw3lj/utJNK8qV/axqE6Gv2nPOtkVkXLLG22IoH4dtAC3kzws7WzFFsKX36R?=
 =?us-ascii?Q?CyhQxOHc39JQcqbrG95rvEFJrgmft1gkghBsYS3ERZif6x/7yk9O5TSgc6XD?=
 =?us-ascii?Q?qskrjxtEhTcQlak8GXYyEXZN7P7QVeyYXBA1/7w3HIFHag5cO7crHa3pUu4y?=
 =?us-ascii?Q?l01ncStR4rpIBNhhvu5hHHFDumhSSWyrdTBGYtsm/xBoF3z/HHdE5L4UEC6q?=
 =?us-ascii?Q?P0m75I2qBpNTCTyrLcTp/XFxEHhFRjQhICKWSiMObL6FUX97N4TVaB4qVl5j?=
 =?us-ascii?Q?TgbWsKHxx2z79or6K7h1URU8lJ0WdKfUhtR+w/FX0n4xo5kRR0F6f5/XXkSc?=
 =?us-ascii?Q?w21AKlg45JSwobuC/je4bVok1tLgRkpUxej13mee5dP50AOLBUVOZCZGTodU?=
 =?us-ascii?Q?HlIjZMBTpkFIGvtpQktvIaU2ooQQQJyfDs/g8tW0UYu36+/VArqEd/ESFOD8?=
 =?us-ascii?Q?Iy5rc1J6pmctMPuBQ6lyawp9v6FyOWdsmYcSdRC6xYYoX8AfgpN+9Jlp+uwc?=
 =?us-ascii?Q?gpdXFe9V0LRWpb7mSw+XvSRLcfjdJXJ9NOkrEXdZ13UegMuB84T6fx3xLbNS?=
 =?us-ascii?Q?RKMnHSPDvFiXMe078gQF+R4AHZZXvFwUr6Z1K5/ckVLcSPaMgEy8RONjUAyM?=
 =?us-ascii?Q?Bnd6DB0QbOUAyT+BkdvXbhR7RD4G2Q51WgIgTQUm4VChZ5LUYkVJFYEMkD1Z?=
 =?us-ascii?Q?lmyrHJDHWlazcRgkqczBmpImu8JtCWDWBeBWmTSfsLreMImE2o5GbKwJ8b6G?=
 =?us-ascii?Q?ceVrYZjRh6p663AygdWUSZLtxNG7HShle0qbPDC?=
X-Microsoft-Antispam-Message-Info: IE5clFF7/OY7o67EH+JarRgFnJLMsg+SPSuwLdg0YQioVboy2Ea9wECQvcyL7FGYiwOA8suIM2NHtidHxgzExvwix6js4hYLI1ec7x7jGx3bOSmDoW1S1/I15MVBZ++DcypFvQxN55103uLw3LeqUZXPCYDAXd+Cn2YbSKYGU31GahS1r4LubNMu6HjYKFey
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;6:z52v2ET7jX2beNyqrtfUhHubuPsbCvrK6zwyYko7rhTNppiHYklx2+JmbqHgdWDphPafcsQ8apK3yGzTzk1qOGHXFqGoDkTRqG7PZIAW07FaSjFzPakzyixsIBnNPs0JQUWB82CBzfTcgrHFbWyHbgunckJg8Rs9M0RcFyiGgiCNOcS7q7g1LAqF38DODTr6J25oONd0459qQnQU9cNc7e2ZIl96abhBZj7b6+jHEIDmk+cNc/8HVbsMm/BJw7zGe1LxqaLV7tKKsufojk9PrHH4yn9u3kAWyuupdJYZr4CLEDCPRF3iWGEcPPkgKnmQKHj5TY6rUbXHojG2mnFY4HRDZB2HEhT+2qzILjqPO8/tgGLTNtoiNaSOuKvGvAgziseKemKqZOc0YCeiHllSsDA8z1s1o4U5LBRlVnnnpN/N65707I65nlKUbBQeaZ9NcuvQxe1PRI/ibLMe+W19LQ==;5:hy5RNEYhSpw99fRv5D3idLluACnhDQ+PcyuIVIEeGxl2AG0kypWsG/FeMxtv/dtYV25rWdP0sacVYPN7urIku7kLQi0F5UOq9KAcO0PLVkENKdNRDmJkOaR7N34GxVOYpWVyS867W70+cB4AOGuzOoOiE9WvnslXCLHxH6Dzw9E=;24:hXpEwBy4cs8uOOUKL0IJcOFJW5Qi1ZKbD6NeBVyCET+hurRkmir4PSDTxgfX3liMtaNnFHMkqzICxP2i0BOVa1MdY358Nurju63WnwkTqk8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;7:ri7IGIe7hUHBK1I0zh1jvUe+Bg8G0al+k+wQ2OOtRQZmd6gP/MRhF7h9vfNtStjD6XFCv4MnA2ZBvBXJqCiR3/wcRieMF0qolqhMfsoiYu3IfzxdGxikf5MGo8dFSSXNEncjOo39qRyriyJoQ8WZ+E0cgHqJpE+lMYm49mrJLyviXq30bXnxNWqJZ0TfD0oL9b07Vi1kJ5bVQbPOMtR+hj8DNqHcajyd3eHkPFyxTfqcKw3FZeFAb24ects3Fivw;20:5+pczcbE44VYzFeMLjoha+DECcqx9I58qijLsI7Rzje/hpD/jffFmWdP79ExQFYW36C/ddQckoGCgS3gSeM/NUJ66WVtDjcsvSDhHpWURHAtMIUeOKfxim4TxffWOv6rOoH3TWVq111CTvZ6H2lofv5QOHMCWGtPG0HwcLIxVzI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:20:03.1869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2ce2df-7c32-401a-8b1d-08d590d18d80
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
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
pgdat, only kswapd can clear pgdat->flags once node is balance, thus
it's reasonable to leave all decisions about node state to kswapd.

Moving pgdat->flags manipulation to kswapd, means that cgroup2 recalim
now loses its congestion throttling mechanism. Add per-cgroup congestion
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
---
 include/linux/backing-dev.h |  2 +-
 include/linux/memcontrol.h  |  2 ++
 mm/backing-dev.c            | 19 ++++------
 mm/vmscan.c                 | 86 ++++++++++++++++++++++++++++++++-------------
 4 files changed, 71 insertions(+), 38 deletions(-)

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
index 2134b3ac8fa0..1e6e047e10fd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -199,6 +199,18 @@ static bool sane_reclaim(struct scan_control *sc)
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
@@ -209,6 +221,17 @@ static bool sane_reclaim(struct scan_control *sc)
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
@@ -2472,6 +2495,12 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
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
@@ -2554,29 +2583,28 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
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
-		if (sc->nr.writeback && sc->nr.writeback == sc->nr.file_taken)
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
+			if (sc->nr.writeback &&
+			    sc->nr.writeback == sc->nr.file_taken)
+				set_bit(PGDAT_WRITEBACK, &pgdat->flags);
 
-		/*
-		 * Legacy memcg will stall in page writeback so avoid forcibly
-		 * stalling here.
-		 */
-		if (sane_reclaim(sc)) {
 			/*
 			 * Tag a node as congested if all the dirty pages
 			 * scanned were backed by a congested BDI and
@@ -2599,6 +2627,14 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 				congestion_wait(BLK_RW_ASYNC, HZ/10);
 		}
 
+		/*
+		 * Legacy memcg will stall in page writeback so avoid forcibly
+		 * stalling in wait_iff_congested().
+		 */
+		if (!global_reclaim(sc) && sane_reclaim(sc) &&
+		    sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
+			set_memcg_bit(PGDAT_CONGESTED, root);
+
 		/*
 		 * Stall direct reclaim for IO completions if underlying BDIs
 		 * and node is congested. Allow kswapd to continue until it
@@ -2606,8 +2642,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		 * the LRU too quickly.
 		 */
 		if (!sc->hibernation_mode && !current_is_kswapd() &&
-		    current_may_throttle())
-			wait_iff_congested(pgdat, BLK_RW_ASYNC, HZ/10);
+		   current_may_throttle() && pgdat_memcg_congested(pgdat, root))
+			wait_iff_congested(BLK_RW_ASYNC, HZ/10);
 
 	} while (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
 					 sc->nr_scanned - nr_scanned, sc));
@@ -3047,6 +3083,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 	 * the priority and make it zero.
 	 */
 	shrink_node_memcg(pgdat, memcg, &sc, &lru_pages);
+	clear_bit(PGDAT_CONGESTED, &memcg->flags);
 
 	trace_mm_vmscan_memcg_softlimit_reclaim_end(sc.nr_reclaimed);
 
@@ -3092,6 +3129,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 	noreclaim_flag = memalloc_noreclaim_save();
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 	memalloc_noreclaim_restore(noreclaim_flag);
+	clear_bit(PGDAT_CONGESTED, &memcg->flags);
 
 	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
 
-- 
2.16.1
