Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeCNMRt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:17:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51946 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751372AbeCNMRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:17:46 -0400
Date: Wed, 14 Mar 2018 12:17:06 +0000
From: Roman Gushchin <guro@fb.com>
To: David Rientjes <rientjes@google.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [patch -mm] mm, memcg: evaluate root and leaf memcgs fairly on
 oom
Message-ID: <20180314121700.GA20850@castle.DHCP.thefacebook.com>
References: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com>
 <alpine.DEB.2.20.1803131720470.247949@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1803131720470.247949@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:aa00]
X-ClientProxiedBy: HE1PR09CA0056.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::24) To BL2PR15MB1075.namprd15.prod.outlook.com
 (2603:10b6:201:17::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1936918-1006-47fd-f1ec-08d589a58985
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1075;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;3:lmgQSLUK9IWXKeGHYBjEc7KeXPCLzBKbQ2NFdn0/6yoq0O57upsoAy3hDsOKGBtho/shSz/EEyw5KiTOdKOzrkzGFVBYqlIUaFDbZSA86YCa4YescPN6STcEjQfIc8gmuDwFD8wY8x4pbqeM1DSFeCEBNwVIRdNUzL3aOxmDf2UvFJ2kbegA3oi3uDrsCpoJlKpmev41utkonqR3Nb/DrGw4kwu+VBjG/AqQntGjGrRFGKCMplx9H6yFjcfIWYus;25:QQAKyeY94asiGXIKOdAVDA2cdd7voxDN8c91hNWojyWM0hh2Vvs2HuOYsXZT5YWYb4EKbFVzBvd3Fj4ifvBNFDwi2uGGXUkxK+xLEECzqCiS0GhuJ70UTsbjRRYy31wUaD9DfsCWH/uCZPOf2cfr1OftM1nXEvTX5iP7hrl4tElNMZuEiuhcO80CCOez0NZ6fqR6DRa3XNn13offLnnIuO2wIALBe1bq0Dgi6mVuXnnI1spItRKJFdn3IhQMLGrBXmurNLxss6ZZeuJ+RXtxJ6OeD39yPIsCi3lzFZjNXr0zZVNB0zACXC2SuRtaV42Ji/5YzGKq3jEcJ2phQuMfiQ==;31:ZEhU/rbTT+ksa4Qm9qZ6puUA09d39dsd99QdvFdoIx7DuYfkkVfDGN8s4DEzb8Ua5hx2qfyydC+4+k3AVugZ7+8othlTAp7QDFB6aNVzeNb21QK8l8GbEluEIYUj8pxZC3T8RpB2ZwTXjM9YqX75mIBfksnlbcTtDkdh3MeELZzzsR79B8Pyw/1GkGMPQvNXwsMM0yfpV59nbwU70Zhd54Uss352F7/aockj5Dg+gHQ=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1075:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;20:8NUyII33zsHhpxVhlEO5vHzcryckG+NjD6JAc1rQ3eNOVwt53uJ6vNgyrTK5ixGoaYa9MYSNJPzSGiubHb4I/EFt6tg2x/wCZzkhCPff254KfJoExvagZMtDedk0p0bE1paOghnmpy6RCRT4BkjlbAN0Gv4EoD4qFNukmME2zNeEFazR9UAlov87/glDK9fkb9soxHBlXqIlpPsn4znRneykgpcoPM5gy32Q+ypgWwRrdzBCwoFkshfsg6veiJtYo5LqL+P7sIb/zBx4k464dJu+Web+dsAkKsiIGS9Rs+87GNWxyHeuAAOXNYCQQDc5VWAZtmYJxdySitFVL+PN6JvXQvf1TedSIwiYRAdukgzCAtyMUiA0Z1xz+z+kcpGXc7oHa1hyVIomGtQbVjEzsFuLAPDhu3j0w0/qMH+Ohqx+RTHSYTw1eytoVxnxcVcRYlKUgxyLsf2TNwETmFiyTji8sMDoWgoEdgCKPpWUShVSIxRUpp/s/R3fawp/fGu3;4:agka33AyTxjLTq5TBTFPZrSnOpaLt9akzd/Uumy8wR6kC7RFq2jTcEBuSZTbWwg9xjbiG/FjVIIbVehOqVKWZHAuncBWZwRTVs9QfjYEwNN8+iV4rYGsmC42B4oslDwPxnJ54lErHWd9Kdt5aL8/No8kKWZDnUXlwoqxvjK3zdS7HHmA5nhtrMJBUWHefE0FhO8RKc9lgMlrHtZ1oG2jU/Mshn1cisjV6HGWsy6jqjlZm1ySeSijNu2HCmZ6J6PlFptZLTOpVHdDrFRBqa9TK1uuJfrCChh5UXdB+IigsGR5Wb+tfba8jKDqpLl5SG99Vyfl1+OdCzC2IcW2zmRNU5JxFrqE+qnmiyDUvaWH77k=
X-Microsoft-Antispam-PRVS: <BL2PR15MB10751AC097E2ABE462802CBBBED10@BL2PR15MB1075.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(11241501184)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BL2PR15MB1075;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1075;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(39380400002)(366004)(189003)(199004)(61484003)(33656002)(8936002)(6246003)(53936002)(6506007)(229853002)(4326008)(386003)(59450400001)(5660300001)(551984002)(39060400002)(50466002)(25786009)(97736004)(5890100001)(6306002)(86362001)(9686003)(2906002)(6666003)(55016002)(6916009)(76176011)(23726003)(81166006)(52116002)(81156014)(58126008)(7696005)(8676002)(478600001)(1076002)(106356001)(16586007)(105586002)(52396003)(316002)(47776003)(966005)(305945005)(46003)(16526019)(54906003)(186003)(7736002)(6116002)(2950100002)(68736007)(18370500001)(42262002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1075;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1075;23:93XY3VUN2Kmo0ngLFD5W/WEueIEaFDLOLGVTpZQd4?=
 =?us-ascii?Q?BovaXOJ/oUUeCbRGR1inL144XR9K0XMm4ET37JCyQgnD2lpAWkjcmQbh3J28?=
 =?us-ascii?Q?iDn7uFTajspnHHPwRM4ux0LIiHigoB+Vuo5J98wM13Q0oy0KIAZGmbQjmIx2?=
 =?us-ascii?Q?cLuIGHfSTdw2WntO/gJPRfL/IYBTQVheVTsz/G2xAxtRhrEWOe3HAg742qrm?=
 =?us-ascii?Q?oCEAEHh3opv6dVqwsIDB/1tRbNvF5COSarxgfYFWWpDxuVw6Eibxje80z4m+?=
 =?us-ascii?Q?+busZKtkLktn6TwsIdp41YDOhm6Nuj2oNsfU+ZArudk3Xaz6Q26fYesRA8pr?=
 =?us-ascii?Q?uulFcPykc9zrHZdBoNDiNAN/J7moiEipXrHXHeibLpWrHAyjDMqwQxdn6jJU?=
 =?us-ascii?Q?bxLvndbT3fPTPXlncEmiNTptwEkIoWG6W+CwxL4NMXjdWWKMbckfYak8nIzq?=
 =?us-ascii?Q?NHtIXoFrJctylh8RUZnqo8WnBpV8yFfb+1JGcR52DAt4wCr7bwuN2RtgNNE9?=
 =?us-ascii?Q?FUnEIkuib6DCYwZMaknUSAN2JaDWbbGeShw1FPcyNR1Vz/d8/K4gFHidPsX3?=
 =?us-ascii?Q?tGXql+I7dUSMGvx3gMn2+DlxPWHGCKAiiqqfZclTs0d+KeP7OhQEBzW3Mz/y?=
 =?us-ascii?Q?ewAPx92MUwoTLIPDHdHSXs23o8L0nML0EoWcwl2g6czDu6gk2ONjmB3jd4iu?=
 =?us-ascii?Q?jUMc6za5pshHxKKlqNw3Cl35RbU0N87ddcWgrxuuZvFT+ScxMVXcPOPk7POv?=
 =?us-ascii?Q?FkZLxRpfWW5lx6PcVsbtjjyfmNbGKX7ssN8j6MxPYEeb5s3A+e6SSACf4mQG?=
 =?us-ascii?Q?G5NAsd2819oCrrxFdZyDlh0ODg1OEYAFd5OSNh7t8bq9ZprTHa+XFlK7h8ee?=
 =?us-ascii?Q?SilJw67e28FL/rtOxBN/69VzFBsl2wAWCrZZlYLwtXenmB7HpAEOECgqEcaW?=
 =?us-ascii?Q?v0tvQaHVYU/u2czcyuo8B3ncXqgEpJN0aPZm4odzFdnSweI7XeWUq9Rsl5lK?=
 =?us-ascii?Q?ONkSMq/aWR6+cMykpx26PD4SvVJ2E8scPtZxX7zdgjn1CvlOMaxHrxa9MULO?=
 =?us-ascii?Q?8UvNgp7peLr7W95qer8hD5rcgMLWmE2AOlfac4zkDM8oR4sPKwmXeQdNrhk2?=
 =?us-ascii?Q?E5iKQj1kz4C7R8Ddb00RMctRakDSerK/Io0/9P/RgsmXxgxunKpfIiVVxds6?=
 =?us-ascii?Q?rERMnwcH/3dr9QSV0edED/79YeE3lsxqjVAPzlMZL1LGmSSGUvojy2uCDM5W?=
 =?us-ascii?Q?92zai3r78O39qZEBx4PiWfrgOQ7erMgFWK/B75z8YEUNuFUK74Kl5IB4EkKm?=
 =?us-ascii?Q?bpY3XhiZibouCozctOCrST4ve2+ZLJlkuuhN7y5izWxM8qLVhzKhVBW0Totc?=
 =?us-ascii?Q?4Wkf1eE8gc7SzUwhKNMaM7VVzDfjdnutU2xdCyM5JxUpMrW?=
X-Microsoft-Antispam-Message-Info: nQLjApdu31Co/2P16RsP4S7/nN5oUOeip2ZPEQmLqsJ5fE4EteThtVC/2t3SfRhtF2LJ3xWlr9drYNA1amtLmmAoLyqNPPYSpuS7d+QGXMrzDbf9aW/ADfqmhUGNrlTFZogAVkV8Mhz/6Kni4QmuRvIZbpOtivDI6bvgPYQ52k1qAmizAzW+oXIenVYt+1WT
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;6:qJlRQqajSBlSTp4Lb9rjNj4vOPbQSfIrySHxqCZuw0KylW3sd/N4XYPKjMERz5kUd4fmxggAQy0ry8XZCVo7nAoBTbKrJlRlc+YO/uXU8iIO+K3k5LNUCMydCvrcaj0G3mZeNPw1mDFR8fzfF48j4r7PxA1L3uWp5eAcWdru+iO6QxTsvOGqJ4OWQ3ZJ7BxEsmfq+BOjOozBCJ1vCq3olxDBIur8vJXDNwNBA4eEBeCont6j57xsu+P/OHzRDMCbI4NpjNc+2ypjp6YkG6xmB/RBxtELJBHilFRjRtUFBZEArp3tjfsaERjOSza8yJ7xECLaLu0Ebrorqo5k3UJu4L2SQrkiZqXygEPl0se+mJM=;5:K6fVl2XWzqy591q98wmMTGflh1W9r5gbUBvV6fVXhONu/Eaqdtz9GDl6MmhSyftg5UJsauGACMjBMthSnpYroAPxhoSMosG6mIAocU40m05pxpF1/YSqj9/wpbsLIktD0bEOExennt0jcxVtlDGCGrpe687JRs+ErQBFB3/qUrc=;24:PE/6W8Rr8mxU7LTvgHm7ZLFlNOKlaaow0s/QvNxg28gbgazQRigfi1SVIOx5ivx0qJy7lxLUJD8TphcAyJDt/C7Rh7ZZkGNvkLk0YykT3zk=;7:0q+iyl0Aq5mk/0O/THqo/m0ttLWddtwux32M7akSZujHdvcfIvSEoTIlgHyZwF6bchB9meDILyUlLtPK7d7PZ3ghbVawTUd7dKcRixPPj53ClWQSewNLeCmxMlzlGnFsfxZDa1YLFKZ/KV8xHVwePv38DZYYAdzKd2KuSZbyqqY3Me82Uv01R9a/qAyXnYaDh/O12GU0iHmnhSNGO7MX+D42pBdvihXptA3VA9lLsxN4YSjdNmUWEyPlG5PqHc2t
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;20:3QzQQ5J3Rp5bI1GdnWFga6ABClBrfMSMaHNP6Dc7kdzmXZJY8eqWADhVqIV7jbdwld8UJbpn5Spx0BrbpK8FAXpMQdLDvvkgXGVq188cES7iHzAWXTD4MFWgpk/LP+7cE0CZb6FGCxTzK1GatlxZ/bhtGb7VG+BL0WQMEQAovcs=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 12:17:19.4845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1936918-1006-47fd-f1ec-08d589a58985
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1075
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David!

Overall I like this idea.
Some questions below.

On Tue, Mar 13, 2018 at 05:21:09PM -0700, David Rientjes wrote:
> There are several downsides to the current implementation that compares
> the root mem cgroup with leaf mem cgroups for the cgroup-aware oom killer.
> 
> For example, /proc/pid/oom_score_adj is accounted for processes attached
> to the root mem cgroup but not leaves.  This leads to wild inconsistencies
> that unfairly bias for or against the root mem cgroup.
> 
> Assume a 728KB bash shell is attached to the root mem cgroup without any
> other processes having a non-default /proc/pid/oom_score_adj.  At the time
> of system oom, the root mem cgroup evaluated to 43,474 pages after boot.
> If the bash shell adjusts its /proc/self/oom_score_adj to 1000, however,
> the root mem cgroup evaluates to 24,765,482 pages lol.  It would take a
> cgroup 95GB of memory to outweigh the root mem cgroup's evaluation.
> 
> The reverse is even more confusing: if the bash shell adjusts its
> /proc/self/oom_score_adj to -999, the root mem cgroup evaluates to 42,268
> pages, a basically meaningless transformation.
> 
> /proc/pid/oom_score_adj is discounted, however, for processes attached to
> leaf mem cgroups.  If a sole process using 250MB of memory is attached to
> a mem cgroup, it evaluates to 250MB >> PAGE_SHIFT.  If its
> /proc/pid/oom_score_adj is changed to -999, or even 1000, the evaluation
> remains the same for the mem cgroup.
> 
> The heuristic that is used for the root mem cgroup also differs from leaf
> mem cgroups.
> 
> For the root mem cgroup, the evaluation is the sum of all process's
> /proc/pid/oom_score.  Besides factoring in oom_score_adj, it is based on
> the sum of rss + swap + page tables for all processes attached to it.
> For leaf mem cgroups, it is based on the amount of anonymous or
> unevictable memory + unreclaimable slab + kernel stack + sock + swap.
> 
> There's also an exemption for root mem cgroup processes that do not
> intersect the allocating process's mems_allowed.  Because the current
> heuristic is based on oom_badness(), the evaluation of the root mem
> cgroup disregards all processes attached to it that have disjoint
> mems_allowed making oom selection specifically dependant on the
> allocating process for system oom conditions!
> 
> This patch introduces completely fair comparison between the root mem
> cgroup and leaf mem cgroups.  It compares them with the same heuristic
> and does not prefer one over the other.  It disregards oom_score_adj
> as the cgroup-aware oom killer should, if enabled by memory.oom_policy.
> The goal is to target the most memory consuming cgroup on the system,
> not consider per-process adjustment.
> 
> The fact that the evaluation of all mem cgroups depends on the mempolicy
> of the allocating process, which is completely undocumented for the
> cgroup-aware oom killer, will be addressed in a subsequent patch.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  Based on top of oom policy patch series at
>  https://marc.info/?t=152090280800001
> 
>  Documentation/cgroup-v2.txt |   7 +-
>  mm/memcontrol.c             | 147 ++++++++++++++++++------------------
>  2 files changed, 74 insertions(+), 80 deletions(-)
> 
> diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
> --- a/Documentation/cgroup-v2.txt
> +++ b/Documentation/cgroup-v2.txt
> @@ -1328,12 +1328,7 @@ OOM killer to kill all processes attached to the cgroup, except processes
>  with /proc/pid/oom_score_adj set to -1000 (oom disabled).
>  
>  The root cgroup is treated as a leaf memory cgroup as well, so it is
> -compared with other leaf memory cgroups. Due to internal implementation
> -restrictions the size of the root cgroup is the cumulative sum of
> -oom_badness of all its tasks (in other words oom_score_adj of each task
> -is obeyed). Relying on oom_score_adj (apart from OOM_SCORE_ADJ_MIN) can
> -lead to over- or underestimation of the root cgroup consumption and it is
> -therefore discouraged. This might change in the future, however.
> +compared with other leaf memory cgroups.
>  
>  Please, note that memory charges are not migrating if tasks
>  are moved between different memory cgroups. Moving tasks with
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -94,6 +94,8 @@ int do_swap_account __read_mostly;
>  #define do_swap_account		0
>  #endif
>  
> +static atomic_long_t total_sock_pages;
> +
>  /* Whether legacy memory+swap accounting is active */
>  static bool do_memsw_account(void)
>  {
> @@ -2607,9 +2609,9 @@ static inline bool memcg_has_children(struct mem_cgroup *memcg)
>  }
>  
>  static long memcg_oom_badness(struct mem_cgroup *memcg,
> -			      const nodemask_t *nodemask,
> -			      unsigned long totalpages)
> +			      const nodemask_t *nodemask)
>  {
> +	const bool is_root_memcg = memcg == root_mem_cgroup;
>  	long points = 0;
>  	int nid;
>  	pg_data_t *pgdat;
> @@ -2618,92 +2620,65 @@ static long memcg_oom_badness(struct mem_cgroup *memcg,
>  		if (nodemask && !node_isset(nid, *nodemask))
>  			continue;
>  
> -		points += mem_cgroup_node_nr_lru_pages(memcg, nid,
> -				LRU_ALL_ANON | BIT(LRU_UNEVICTABLE));
> -
>  		pgdat = NODE_DATA(nid);
> -		points += lruvec_page_state(mem_cgroup_lruvec(pgdat, memcg),
> -					    NR_SLAB_UNRECLAIMABLE);
> +		if (is_root_memcg) {
> +			points += node_page_state(pgdat, NR_ACTIVE_ANON) +
> +				  node_page_state(pgdat, NR_INACTIVE_ANON);
> +			points += node_page_state(pgdat, NR_SLAB_UNRECLAIMABLE);
> +		} else {
> +			points += mem_cgroup_node_nr_lru_pages(memcg, nid,
> +							       LRU_ALL_ANON);
> +			points += lruvec_page_state(mem_cgroup_lruvec(pgdat, memcg),
> +						    NR_SLAB_UNRECLAIMABLE);
> +		}
>  	}
>  
> -	points += memcg_page_state(memcg, MEMCG_KERNEL_STACK_KB) /
> -		(PAGE_SIZE / 1024);
> -	points += memcg_page_state(memcg, MEMCG_SOCK);
> -	points += memcg_page_state(memcg, MEMCG_SWAP);
> -
> +	if (is_root_memcg) {
> +		points += global_zone_page_state(NR_KERNEL_STACK_KB) /
> +				(PAGE_SIZE / 1024);
> +		points += atomic_long_read(&total_sock_pages);
                                            ^^^^^^^^^^^^^^^^
BTW, where do we change this counter?

I also doubt that global atomic variable can work here,
we probably need something better scaling.

Thanks!
