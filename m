Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932261AbeCLTXa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:23:30 -0400
Received: from mail-by2nam03on0042.outbound.protection.outlook.com ([104.47.42.42]:44736
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751352AbeCLTXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:23:25 -0400
From: "Steven J. Hill" <steven.hill@cavium.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmstat.c: Fix vmstat_update() preemption BUG.
Date: Mon, 12 Mar 2018 14:05:52 -0500
Message-Id: <1520881552-25659-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: BY2PR07CA0018.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::13) To CY4PR07MB3607.namprd07.prod.outlook.com
 (2603:10b6:910:76::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b78cc204-0ab0-4f7a-7cbd-08d5884eb84d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB3607;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3607;3:wLgBnFGH925W4liqhIdBSDphLUTPab4CslWtK8MFqXzDgFwkgSL+0I38PnoSFTP7xvm2iC9f8FGQBdDG+9VkN+akrBbBtJcxVjd8vccLO5BXOw3AkOvdQnmgy8jCbX4NT4rrhGZJ3UV7hyLBj6YRDN2Tt7KlJc6XFGQn+DLhz0hZ5AEqRNF0LDefyFQB95XdEQk3NETBG4IVUeMLELiquXQkA3j4MhiyWvcuArZPzShyAIpzxapWuTuIeVMRGeZA;25:asqNA/Gp4Yz6R9dNWhl4JhUPGMPX9uDLEgFUEoxAXIbAEvNYC/tp+flQ4BiLBRat+zZ8Y5Zk34F2z6x7rLyhz5Maw0ye4Fu3YkjLqrLvfLTASHls2PFKI2BjzUXYL/M9GAnDDktDkarJsqzqwP0xbzYZIty4mzbRfcfPxJQRBkcW26+InNuybQgfAMLUuHdRimxMNIfeCN4NSZ14WTok0gg7bhNHZ1f98ilJVtabRbQR4JFVSL0W/l+5C2+0DuJ2BiJRoW/C/lDb5a9LK8J0amWVQNnsd31ntyDQvD7m6+3PBuIPeCYkP8K2qGWyfKlPLP8/zwHLUkWwgol0bqHOoA==;31:DqJRCbnC9z0mvp7F1sUnVjXCTMgYICF1wAxCgdi85JjqObtUE4CI3K8d2fNlgK9i2uITv/N88bWBM1Ue13zGuoOZocCCY4wGx0rfSqyKMMWeqiuPL1yfNv3ZKuEdRblW/APVdXKcJ+h5sWWyglmBOWOJ43Xvhi8Bpcsae6e6JBqwN7IgTAATwNfVdVIDtP6f7/F6ZqwFRUINI9/WY66nDzm95DNZ4YyPlnpRl9CxvJg=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3607:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3607;20:WOs6Z4VxMehpidY69J7/Au5aKP8cM+MtcI9fPA4744iI1CElYqxfE+1tN5Q4/i5vbALy0QP4CVDgt0kExszs3NVI2uDJiaxRdgd2A8XVcJXjiqiMN9fnbMYQRiPBSvOw9URIJ1XHeJTcKB2ZvFqiVr+7E/tc8jT+a/R7jAWBFrbBYbkvFS8xjuYj7KP3QpVLGHEVoM89DTN8qaMEAR5q7y6MFJsGZ2nhU02ozfKXoN5J2NKCu779IkoDyWni1Yd7rrLMCUOI6LdEo3YUHicsIAkmg4t5I9+mJGrPz0cyekYHLCYPCCqWkVP61aTD6bTOWGETrSiTWXingHFjBGOeC/t1RSPZMbOe57+zSkiRhkjf1CJQSuOmHFIn6mM4hHh8kd7tnwpdjB2Y54BWgLjqbe20MhZFPRusJ2o5lDS3LeupMJZACJm6bT9yT5OoAzb0LDHhhDgTPkuK0iNHFlMMIKW8gj3oepah110pM5GL2VvwACf2wEbysjB480dxf7jF;4:CrGQFv+44XJWAiYyxAwCJwJlapc7wGRGwV29l6sv9lBWSaFK1daZMm+IRK8pFCDB8b+npnEKHzCi/fcyQ4ysPOYbtAzIa/WD1MztFhetwF5ETFI0ZBy3W7jLJeIpur+P9ZbcBjGetPCXmEMQAT4nEdeWAzm4IvsOvfmNkL7zZGHc61KxJEcR6qDaR1rhGFnTfU1QaL1bWPS19TwBLfDoBAh8cmCyQlJdgcDo7DcN3OIvmlhFZuqqpxlErVodsAl1AQ72QW+XUvizfpUxt3PXCA==
X-Microsoft-Antispam-PRVS: <CY4PR07MB36074199AAC2FC9D351FB68880D30@CY4PR07MB3607.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR07MB3607;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3607;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(39380400002)(396003)(199004)(51234002)(189003)(81156014)(478600001)(72206003)(86362001)(47776003)(105586002)(6486002)(6666003)(3846002)(6116002)(66066001)(386003)(69596002)(51416003)(52116002)(8936002)(50226002)(16586007)(48376002)(6512007)(316002)(53416004)(68736007)(81166006)(26005)(25786009)(2906002)(305945005)(4326008)(5660300001)(8676002)(7736002)(6916009)(50466002)(53936002)(36756003)(106356001)(6506007)(16526019)(59450400001)(1857600001)(2361001)(186003)(97736004)(2351001)(19627235001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3607;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3607;23:DOI9YSNGEfNb2mGLXM7DXIc7qUAxbY0AYcIOryvFT?=
 =?us-ascii?Q?YtN6IlZDMUWSRuxonmQUu2PZJV56zK7enGqsnHfaO2yxWkmf1Aj2WRxy1BPz?=
 =?us-ascii?Q?FrJb07sSLq3mg+FPAKNO0MRopZeoIJ/UID/SL40E+16VlTmLfmYNLCrPEZee?=
 =?us-ascii?Q?7i1owM6Y11swNcEC6B547y/G0lJMIiyCRe/Zi97HKA1vdntw7egJj7i6QzcL?=
 =?us-ascii?Q?mAZ45M1KQOVO1n5AbqaqJquojGbk5L6BtNeV2DNV/isN8UARPao+mhBKh7/v?=
 =?us-ascii?Q?WnfG7fjh3bZ7OBg4fczLCw2myvieXr1MSv5YUWWNCCrdGfuCZNiNkU0FkGto?=
 =?us-ascii?Q?Mmus7qR9SMjmrFdK8csbJWRZh9ZiEBwLZxbaeYlR5g0x1HxCnE3RFeWQt2GT?=
 =?us-ascii?Q?WUzEvNKeiIRLC4NAAle8XlleSYfa3xgUOjB+eXLgAsHmIOwveNKQA0tCCP74?=
 =?us-ascii?Q?I+2cic3lx0Ii9b3e8Ki+PvTI0CVZtklhY6ehO04IlUd0o9cA8oojUCNAEQBG?=
 =?us-ascii?Q?yhb0dAAclpapgNaecprco0A8ZqZGsCSxXfgDsiBvR2LWtjIzBENpWewPVIp3?=
 =?us-ascii?Q?rVjf078gGOorxmIn484VN/u8pexbXcxkrIvf9Na3z2+bF9npRrdf6feG8huf?=
 =?us-ascii?Q?ltE3cM/qV4z2Uke80k34vzerY/20HofOL2d7iawe9DjhbxGxYPz1q5jv9J5Y?=
 =?us-ascii?Q?y7uhT3x52VwaLBv60jV6FaBk1RFeYKNORNUgIQjjLYS/RvK5fjiWjRvTH3bP?=
 =?us-ascii?Q?Jn7pPrNXJ6AqNoYbNH9VXvn48kUvYSKeGsZ5kfXSB4N1afyBw1ElXcCBzXP+?=
 =?us-ascii?Q?1ferR99buGGYFfp1sSuIlbJWZQWh0RChawJTd67AAVBJ1fTkvQWYV0rQy93e?=
 =?us-ascii?Q?T/5wM/aAnKAWjMW5NR5NnokmvIKjdDqeZcQb5Wg4Vtalg7T9yDQoYAFRAFQd?=
 =?us-ascii?Q?A1aXTdeW5DYzmX4vXh7szewHmDYMElcuAoRm3b12U3G2JobYJ6NwiIOKAsjy?=
 =?us-ascii?Q?c2pTXhlQB3K83vvHFA2TSUFIC81MqgP0mEKXysfPt6SVdaKsM/DXHODzSqOa?=
 =?us-ascii?Q?1tE2xoLMcMd+LUPuv/aTLL9qPa28cysAHOQxqTjl1qTxPU0R8xLf0wVpGqCb?=
 =?us-ascii?Q?Rlmng2+tlBNIbqP2xXlLV58n17OcN19SNeSXL5gDHem9BKpIrTV6Gupe08Ph?=
 =?us-ascii?Q?CN5BtTwSghwJY89bp6CTs7qkqWw7cIfVlXzMF0gicw3tTJRPd74aDdAbcmbu?=
 =?us-ascii?Q?aU8O1fxl4VCD4WrGcQ=3D?=
X-Microsoft-Antispam-Message-Info: i/ZoAG7HhC6Os7VrcVnJPZB95kdIGwPG1+xDsZSIuYnSgn12dLRM3DVwVvyT2OGzmqdxmM0QiZ5Or6Ny2w+H1wdzDiyJNwJsU993WexUSIEutDeZj9/EmMQkW+UAfV+bMIOYytYsfeHQ/y4rMUhAxLmq3dbLDOSyQIoH1ie76vEB/ISOR0GpKwdr1f2pd16A
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3607;6:aV35TSkUE+idh6R/XTbFKe78ni8zisiQsWP6UTDD6MpKRTlthvYvpnebgaQu15u2MmIfq85VG1IBNKCd9HEx6a6uST/yz1jDq6beDM3esi/CaJi0qVlZ7eeJF+HxflE9+IfNipLQw4Tgvekw7Oo4X+I6SwWzdfH21J0UgSRrYprsmWUFKlYfwLg5iYPgaK+BI9H/tKz2DYYkeBmbpp43AXD0MZt13+vjpZfOHgib2ccbHdudeIxsn5bvch4p3ildEsgKLSiBnVqVN5gspQQooC1bgzHtVj6HwZG4EtajF5tgzaGH4ZpF13FlVxfH6sWG2/GAqIvbaziAq8gnMYz5NcHgTjJ61PixPbq7BdhFOs4=;5:V9Xt5D6i8C0v3WUwDAavZQ5J1FpX0rGYCEBAA+30zOpvEwQLVUjnCItRzLTk89Is2lGfiprEwGuv3exutYZoKcCq9ya+yFs7z/MoIuBkyMlB7qxtuWVjQKU/U5uKAjsZ4qRY4xAAfm3lSc/6dnEyYQoJEfaoi97kQW8Gxmgdk1o=;24:JCY+ONLqqBzaBzawC0WK7Feqp4bB77B0JjikyGgXJn7ToZgoTfshqlkBGUFcxJ9Pndrt4y0oDNCyMeK5gCctee/c/a2TZmX1q+OaQf6mDJ8=;7:oweUdKzU9KaqKxmjWoJtSSNkkNDyTEg2G66K8avf1Ghfy73NElWt7nv3H9bGohU3wWxiEZwEUAz8Ne11dXm8J/sRfZmeR1tEBsJ/GLChVb0BXZpo0o9IIDS6mOw5/c4hjYX7e7vaf5KT1x0Bivz9CHXlnx76qrWB4XOXNsPtHvadGuSGlHL+LFeuU+hRL4tHXxgbYfcKWR10RVHN1gFmPOO9dZN4AuAKBRY8knr0UuyB0w/+o0WwbVfymwaCLytd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 19:23:21.9330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78cc204-0ab0-4f7a-7cbd-08d5884eb84d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3607
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to hotplug CPUs with CONFIG_VM_EVENT_COUNTERS enabled
can cause vmstat_update() to report a BUG due to preemption not
being disabled around smp_processor_id(). Discovered on Ubiquiti
EdgeRouter Pro with Cavium Octeon II processor.

BUG: using smp_processor_id() in preemptible [00000000] code:
kworker/1:1/269
caller is vmstat_update+0x50/0xa0
CPU: 0 PID: 269 Comm: kworker/1:1 Not tainted
4.16.0-rc4-Cavium-Octeon-00009-gf83bbd5-dirty #1
Workqueue: mm_percpu_wq vmstat_update
Stack : 0000002600000026 0000000010009ce0 0000000000000000 0000000000000001
        0000000000000000 0000000000000000 0000000000000005 8001180000000800
        00000000000000bf 0000000000000000 00000000000000bf 766d737461745f75
        ffffffff83ad0000 0000000000000007 0000000000000000 0000000008000000
        0000000000000000 ffffffff818d0000 0000000000000001 ffffffff81818a70
        0000000000000000 0000000000000000 ffffffff8115bbb0 ffffffff818a0000
        0000000000000005 ffffffff8144dc50 0000000000000000 0000000000000000
        8000000088980000 8000000088983b30 0000000000000088 ffffffff813d3054
        0000000000000000 ffffffff83ace622 00000000000000be 0000000000000000
        00000000000000be ffffffff81121fb4 0000000000000000 0000000000000000
        ...
Call Trace:
[<ffffffff81121fb4>] show_stack+0x94/0x128
[<ffffffff813d3054>] dump_stack+0xa4/0xe0
[<ffffffff813fcfb8>] check_preemption_disabled+0x118/0x120
[<ffffffff811eafd8>] vmstat_update+0x50/0xa0
[<ffffffff8115b954>] process_one_work+0x144/0x348
[<ffffffff8115bd00>] worker_thread+0x150/0x4b8
[<ffffffff811622a0>] kthread+0x110/0x140
[<ffffffff8111c304>] ret_from_kernel_thread+0x14/0x1c

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 mm/vmstat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 40b2db6..33581be 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1839,9 +1839,11 @@ static void vmstat_update(struct work_struct *w)
 		 * to occur in the future. Keep on running the
 		 * update worker thread.
 		 */
+		preempt_disable();
 		queue_delayed_work_on(smp_processor_id(), mm_percpu_wq,
 				this_cpu_ptr(&vmstat_work),
 				round_jiffies_relative(sysctl_stat_interval));
+		preempt_enable();
 	}
 }
 
-- 
2.1.4
