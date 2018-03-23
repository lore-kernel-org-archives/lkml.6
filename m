Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeCWPUK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:20:10 -0400
Received: from mail-he1eur01on0107.outbound.protection.outlook.com ([104.47.0.107]:19840
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751400AbeCWPUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:20:06 -0400
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
Subject: [PATCH v2 2/4] mm/vmscan: remove redundant current_may_throttle() check
Date: Fri, 23 Mar 2018 18:20:27 +0300
Message-Id: <20180323152029.11084-3-aryabinin@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3eef8b2a-4bcc-400e-00cb-08d590d18bd1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3253;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;3:jkoGO6DJSCUCO20AOjUIiSnOijEb/ZLxy/XrQIDAfxkc7j40P6UkFpNcOOEoEuABQ0D4O9HUAAyi37g46NZAssaMsgsmoiy1PzxqLF9+5Nw320+1JFsPDYjKh+wFfqDs0SA3aSFqQcm3TSGNliiiw8nYBUCILyRNGjU3Axkpp/zXaNUwpKhIfwinGO+qPfryaV/63mHKS3kozdKL0aq0sKElHdY+2wiTq6azXLK6Z+iCnphrlPSCa7UCiZxHb0Wx;25:82L4EmUVABW5/fWrcPENXlPyhGCREtbE/odlqiNbF/ml7kz5sBaGYBFv2EjhRNTwLbOUy9bhOUuqJZXBn4X33vGxfu+zIs9mb3jcsliifWFtBxQ/YlPY7LIegmUNwLCRmXhhOFfibHh6kJNQNK37EH8+D/WjYggcYpa7fqG4MJRoeectTBdTmHN34qAoakadBNMqrbX4eshvMBSLMoG93rQaoi6+k7tqcZ+ZXQ7DVMsU+nR2GgkZKcHhJ/9ZfFrmMabfqmVHgSeO56vl2ZKznODk6Nb+gbmTKcqp0ZZK+mtQKummLMnag3G/Y/rMUvS29zVUNGvhx7ZwciFnnUWnLQ==;31:iHeDBtRxG3M9T1MVucAmwSzXhc5eY47lfhM22sBRe73+cqRFTJegheU1o9N2eEMbs4YGfwU8cIoSgMjJXrgGJd9CI42ymfr/yU6hfG6ETokOqx+biIybuGvNQXYPmS74VjbhPC+FjrSp+vbh0Mw8AF6q69cLRANJp/Ue8uTTbb4kV/2HVlEbQbM7iNSclbK5TJBCfBvyZMJsnuLJeb3LeU8pKHlQkEuK/nIntk4nRGQ=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3253:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:i03loRjXVeC5tUBStPg8YpAFGsH5/fO2nkZRcI9TDaI4NULT3aCkZ6YSfC/7OQyjGXj0rwsVLcWfO+1iDAH7WYz+2ci77Hx8jaKQpoU9DEhEeVW5gC/bCI/mfXfOEXN2lT/VSsGzdEV5n2WjGBHmmWC0ji9J+6sZiedJ4VFleZDHoWxbcTIEkq+FodedQHv/9DWamByh1wOJZpRydj6JB26/1g09P9rDYpd6CkAUBw3+znpYN/esYGIsod+l3cvCI4T661CDaXE32D/d8ryooYGwOwEz1NrA3qC0TWvo+jjYpQwwVWnjw7NmGQ0iEdyrRzKnLKj3PaM77gI0quh4H2OZYCLx2iz4d+Qg7NDOZbIIF5ORN59QTXpIr5+WvKVuspxbTU0PZts+3AcYN/cTcwa4l9YCToRDTzOOsuUmfxyybM7q+n4cNJGZA+i2lhM3M6ziGv4o9eb2BKpBin2uYiesJw+wcmprWlqWccPcH7IYYY+NDY5T5Nop5JazKzPz;4:Ey0PvH7kNhuixM4kRIigwTnlK4NnxIAlbqSPlNG9m+vcQkWl6/5e6khqVYYnYBx6cUzXuPzJnnB9Q+yiePw3juThD9Kvajmx+ALahPacQ2PRWKTML64VRogoYII1n8IAot/6rjcDHUKWpnqE0o8JERB9O+8IhNFsQs/AC+MO86+50z1xlo/scQkqUNw/c5At2W3MSZZeiIoz0gc2aix0AeQhabrvfdhLcyF8cfEZvARbOAPXayf7L8WAFQ0nTNfYXIQsws2FsmksM4lPaLk2Bg==
X-Microsoft-Antispam-PRVS: <AM6PR08MB32535628D1FC18C28FF31850B0A80@AM6PR08MB3253.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM6PR08MB3253;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3253;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(39380400002)(366004)(396003)(376002)(189003)(199004)(36756003)(25786009)(186003)(97736004)(1076002)(3846002)(53416004)(478600001)(48376002)(11346002)(50466002)(66066001)(47776003)(105586002)(106356001)(53936002)(305945005)(6512007)(4326008)(7736002)(50226002)(81156014)(8936002)(52116002)(6666003)(54906003)(76176011)(81166006)(386003)(86362001)(6506007)(7416002)(2906002)(59450400001)(51416003)(316002)(68736007)(55236004)(6486002)(446003)(6116002)(6916009)(5660300001)(16586007)(8676002)(26005)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3253;H:i7.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3253;23:pXV9Lh6I/NnY2nqbGYadDxYz5bKiAVn4gRcNKPoRd?=
 =?us-ascii?Q?IZ186IUEWklR2Alu8XIN8+jCUxuANYb+WcEr6itD7ti1I7zP5sUC4l8HfXuI?=
 =?us-ascii?Q?JVUrvrmHqNHj9rNVhjeClniWtIX7Lhq8xCkjgMLLNiLhjawBhVjDCWfgPTGQ?=
 =?us-ascii?Q?/2L1D4A4o8vDc3OaSOnd1XYO025jT7uoVG6z/bs7y++aoB18W6fMekgJNW2q?=
 =?us-ascii?Q?q0CMYWp7awm7CUpzJVyUYfVEWF8iX8uzBRnEBf24cVY/rOtdyhxtcV4xdQxL?=
 =?us-ascii?Q?ToG26GC1wH7/W4Lj6rzxa7OMKBI7jGlsa7Ls/woBAXkTevH2W9tcghGujLhc?=
 =?us-ascii?Q?L/mMwRqUO3+S69vCq07hPlyfjcakHMteSoWhXB5BIR4yl+8vjE69HOME6mYL?=
 =?us-ascii?Q?Zi2U71WnBlFzuEYSak2q+rQIa/BWWlCmZ5PfmkWjJ+f7qBA9Dqijj6q4YZMA?=
 =?us-ascii?Q?v3Nl0//c+eIpTq/rfYRD03lFkMZFX3GZWngIRmJuuY1f2ubLDBPl+vS85Bgi?=
 =?us-ascii?Q?7Blb5ZpuPA8D7qIqTqJYhML6P//S8Ukbpl3DFq77m7jMUkEcAoURB80p2dKc?=
 =?us-ascii?Q?EkMVCbuQJelo6xD043nlHPjSSxpvgl+YlhoQkFCopEOiIYZM14ujCHvMSYc1?=
 =?us-ascii?Q?OCp5H5Tvh65ak/TDF+WuvYaWRw/lqQuEyBIxJkkKZqtlABESdslNENAqJMjz?=
 =?us-ascii?Q?Pm5RXr0KBzutWCzJTO1enr5OZBJAs15B1N8sp51oStrPM1yyFjMpN2U0HnlD?=
 =?us-ascii?Q?swrPoK1VjC61anQu3o2pA4AzzA+qMOMKO4mXSDaZrw/4imbIXDa0GHGIhlyC?=
 =?us-ascii?Q?yFJ/7p9iM+ZvPl+4JJQqn+Cp5cTrKyQRJKRCz3V13I+njVMvIVeHsk1GOVBr?=
 =?us-ascii?Q?Kb39UkjGg45H92b7FycUA5zdcpjjcSIum0Jv5/gLVwlgaQ1qP7MK1qR/bua9?=
 =?us-ascii?Q?oe3t72PcObV3z9nIusTcUqjgDmE/c27jHQAaeLA47sb9UNa3z7ayAaazi9FU?=
 =?us-ascii?Q?l8ywv2rMWZhVFM6voZ47rCoUp+BByAbqaazxP789lF4WxuyAHLSduoCH1s56?=
 =?us-ascii?Q?jv8EhgLrS8FqIbNq5b6d+pSijfMFv+a1zLQVTTStT9EsqE+btFUeovincYPI?=
 =?us-ascii?Q?UsIDBgDu1T6r42oiWcTWEFjs9h6XqXvo6RxCff4+/t/Jn9/V/ePyaoyFJTfD?=
 =?us-ascii?Q?RECFiJYWsD8pj5oTfY9oHQGeBMIEDm93WgF7dqFuW4TxVREQXuD3+7c7qv0z?=
 =?us-ascii?Q?BQMwe1VuKRhMH8zbNc=3D?=
X-Microsoft-Antispam-Message-Info: yZ4KmyXYWzwX0mr8B0F1xrFUdzn30CjreZ0yvKqS9KhXy4LBGoqrO8sPHKUkio2clFHxK5x/6yr26ykjWPBhA05g6g83sfVvr66LMgozrojSDpi8z9DXzXVDSowBy95RHH+MUrFu07nJRNEHMnWxLc10k0NrHlXzGyuVHzDzTMOhxEMc0pTncBxhit7bGdaQ
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;6:ElpDxo7lceDpeYAJpqZ4V96EVcOjZduv5TGOu8SndIK4XyI6Lsy2+DZL9lPDYGx8l6SZ8xMjk2ODDr3akUy7B082HYm+tQoe/qlMY7qqx5nKAC4l7vP1Joi/o+3PVPZPwRnSt2SyKWyvmBJ4tyTpnHIMPAwmiS6PuDuWFncLxMsHPDdHO7n6jO6RZuA1ItidVm2+d5xIoGcncfaoOE5zW631Qtf9dR4aQuX1IJNj9jBCRGHWpQJXes3fgEP85sTPqncKLioty77AopwKjysRLM47ylR3UaDp9I9sVJ4Zq3vo0jw2jtRllr2bVckqfcvdgLo6W3Ixr0/gvC/SeqNGZBxb4TrpuQgTuZxwHJEnKBxOYBW2KE5zdyRXAIXiE8ST8wMcKV1oEBCTransIGsUObNuMwp7TTWyr8Z3vt6Q3r4cq/JmsSvTkfZkN9Y47NAlxGsiI5xATdek+GHmBF9ndQ==;5:DXl8CblAuuwpFDHvCEZy4FytN4Zl/7j3y6CNyToZHQcSG7+ikR1beP8P6MaxkbbD64cZRZonJa22coZ8poCkehDIYXmapeuky5PVfWOG5+Jno3q80cIBLpGmNm2hq2rKzjbIM/kyXBxosdIjthia878P+tg4IGrBzGwigmRpskU=;24:QcCl0kSZCqQ8kmLHAqmgkyyOWzDfoMULdiRKp7S3jzBVb1SPhzW6BugsM8wmOLnWuk/KcJ3pLS8KtPlzRFxuT9CF7cQp97e/p2OS3TPevGM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;7:Z2OQ3hFgSDDjIZNw3JKkxJ2+hyqEP6ewRhArgKq0O+L9KZGB9GFWKXV4nXD22SUejrS53gaTYViKEJBACwRIdTHbG8T4le3UVabxPZUeyySDg043b5Pgc+E92CjeaCCf8/dZ1zVOFA0mjK+P5BD/SveOoda+wRPFoAmuRHOrWgdKj999AzMXlZziIGTp0YWQj4+T6ldkMCDp8uxw4Pfmu4HrRqxa+FgjvuJSrJXYGoNU1yXXt/kBT2GIhssZEgop;20:kJ9QVb66DvN494g462E2Bi/QYaqlalueZ8MikpruZgw9ZaeIdvrdT569qSFd/k3k5Wr8V6I834aYPmAwnONMncodlmKjwjdosrIMq5zrWSEtKPys1DOT2Z41YYG0CPqlSkKnQZ25t77HkOv1R7B+O0G0LjZqyC8S1AA2AWaR7Og=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:20:00.3588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eef8b2a-4bcc-400e-00cb-08d590d18bd1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only kswapd can have non-zero nr_immediate, and current_may_throttle() is
always true for kswapd (PF_LESS_THROTTLE bit is never set) thus it's
enough to check stat.nr_immediate only.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6d74b12099bd..403f59edd53e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1807,7 +1807,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 		 * that pages are cycling through the LRU faster than
 		 * they are written so also forcibly stall.
 		 */
-		if (stat.nr_immediate && current_may_throttle())
+		if (stat.nr_immediate)
 			congestion_wait(BLK_RW_ASYNC, HZ/10);
 	}
 
-- 
2.16.1
