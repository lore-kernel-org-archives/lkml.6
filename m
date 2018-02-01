Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbeBAW4k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 17:56:40 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55522 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751967AbeBAW4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 17:56:31 -0500
Date: Thu, 1 Feb 2018 22:55:50 +0000
From: Roman Gushchin <guro@fb.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH net] net: memcontrol: charge allocated memory after
 mem_cgroup_sk_alloc()
Message-ID: <20180201225542.GA13072@castle>
References: <20180125001911.15597-1-guro@fb.com>
 <20180125.120302.1117695034222616751.davem@davemloft.net>
 <20180131215401.GA8956@castle>
 <20180201.101655.1316424669256047119.davem@davemloft.net>
 <20180201202158.GA11477@castle.DHCP.thefacebook.com>
 <CANn89iLBOUZNxNqrECvZ7ktX8uu0j3REiZaqTwr=SP-U=vAPpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CANn89iLBOUZNxNqrECvZ7ktX8uu0j3REiZaqTwr=SP-U=vAPpQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [2620:10d:c092:180::1:8960]
X-ClientProxiedBy: DB6PR07CA0186.eurprd07.prod.outlook.com
 (2603:10a6:6:42::16) To DM3PR15MB1082.namprd15.prod.outlook.com
 (2603:10b6:0:12::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f003849b-dfb2-4087-8ec0-08d569c6f7f1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM3PR15MB1082;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;3:l5yBbjsIJ9eucs5jdSvzNprbgLOgUE1AiFb47mIbo9lCorJNPbOJ9ueTdJTnlmLS2SsP1RUlt9BYr5hgxYOolaZNJpX+TeDbTfumPlgJBQa5qxAVSsaQ5QxPPvlQrQ/qriIj2HfdQvoZ0Zl7HpZbeKdkcbiKg+YjPMMpMta+UWGYxqT1eQMBGTBWdy/O18fW5v/Ye0OMApwX5jUiUUKAwv0eR8JxTZd9scyKOhadzls5EaRBcpbzqkaAp/ZBAN59;25:a1Ibne4sla43oJm9JolarF9Ka1puu2KbLPfOtTRNg0vEfg06PNUmMsu4Jky1iqApg0/ZDbTHJkbbtHWElqe3SI0BaqnssWTDizdH50k23UZ5tjfNtq9O4npV1UFyNZn+87z54TufCaST0DrO+MJ0WmlMvKA3+biunuUIe4B/S7f23QqlY/RO5+87F+WkCZY3YHHe8nyKQzqk62c9/wwzTPq8LZg90MysEutA0/ZhQZJVsiAm0JmKE7Vu7Qy/osDxCDj9L4YMsJpGMG7/0qXYugI0mceECHc+HfpDvGmMlUFy2fy3nQtUt5xgX2AlulNqisRfs+qWGvKFPxpfAwRiiQ==;31:1RFhDj7AtZwvmd2xWYFUW0OwHTu7dkLuwfdqNPrGDHGrlQMx2CqUg0MQIdRkgvOthvEo9ttJJPq27/zmhHUi3A1QWJ14Zgue7ViTq01yGLMED4l9I6cUmgZZv8lT2tlgCvXbt86xxe64G/eiMzjb8aIbImYySxCQWQsVayguUwydoL5x3s311WufeaBCzK2hlODjnkJ9G4pEesjJaJ7WVH5ZB3GpnXelDKNhiFnN24A=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1082:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;20:3YqbWbnbyYAb1WcsJe9LTzk80/EUjjP8acdqzyG8AsFFahARn+F7YderT/SUz7W70vEErMeyWTcTNiCfcfrNPWwCPEP8o3GQihSUziZMh145FjzvmhG5PTqyPzeNJBll2jGAMH6dXBdaev+RR1HdRnApbhMRvZgxiJVjXaJcAWyRf7v8NuxepkUScsluMt8rO/R/GLXLiOxptV+Cf9TVaGYe1+fMygGoPIpNcvqc+Qfyg4g5KEQUj3dBrqLyZgGS2kY5No8LvR4hTnJoZwj//gue1cnSzAGTEqTZQ57nI//xMXwUfz/LXfDUpsBJ6uAz1IR7y2HafB52MirvmzilPLAxCxcFuN4VsBinAQqS8uKS26CZfXqsUnAj36uJg1zzS8VwZxoZjO5W7VJg6H6tOVK7qd/IlYF5n5758nE27k/rCIumzS6p9+1icLLf7oG1moO81njUAE7IhkkGqwnau/1F2fh1yq6aQfSmFgIejteA/0hlGcNeN5+nimLHU6D8;4:/hyGLWb1WocSDpBnrVgKYEQYlnQVUebJBlNYFwjGj0l7PMJVjgfbA6l7Qa836T/Tx2G7rsSr1OHOsdZecwJzrh6V9Kcn9tO8+MK0kRPbvZ9UzLywQOze93VAT5oZ7yNueeE8CCpONjXO+kPiIlLKe3IbpXbdGVTRUAAt0QswKESD/XbzdLkKYuysQVOVffPP2Hq/gX+/XdUU9JutSysjl4Qy3hDZJxYidKki9cEVqGmkACTW2sEmYlve/KBQ511VoSKIizbjjFES1QALo5kzHtUUZux9z9bS5uc+TDw6drIblrDlm6THmbOHsN/P3aS7
X-Microsoft-Antispam-PRVS: <DM3PR15MB1082BE2EDAAFA704390F4ACBBEFA0@DM3PR15MB1082.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(11241501184)(2400082)(944501161)(93006095)(93001095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM3PR15MB1082;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1082;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(39380400002)(346002)(189003)(199004)(76104003)(6246003)(33896004)(6666003)(52396003)(7736002)(59450400001)(53936002)(33656002)(229853002)(6496006)(53546011)(52116002)(305945005)(5660300001)(83506002)(9686003)(386003)(6916009)(55016002)(76176011)(478600001)(2950100002)(4326008)(6116002)(106356001)(25786009)(86362001)(316002)(58126008)(54906003)(50466002)(23726003)(1076002)(81166006)(81156014)(97736004)(8676002)(47776003)(68736007)(186003)(16526019)(16586007)(93886005)(8936002)(2906002)(105586002)(33716001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1082;H:castle;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1082;23:Xcb5EF5asciBrwNm26mY84TwOip1kkGgM+joO6VM6?=
 =?us-ascii?Q?E5LiPYvEVSGiEjbJJRaZSrqkf/7N/ez2RNVVV3tYLj9xvEATOvB7qvU044aq?=
 =?us-ascii?Q?dPVBWMQTHEoxJMSkZhqIDQ7A68B941DOUISpEi8FV1Yg/OPHa1iUId2P+Ycg?=
 =?us-ascii?Q?rR6JA7of4a2s96kVs/7QP0wMdJPjqB92gRqs2zbmYWwHqM6lgh9NEI/ytrOp?=
 =?us-ascii?Q?sUjNRCca2W5IkRX1dhFHhCWosmZe8yXIN1I7xR1Z7NnnxwUAOg976OSdKLBh?=
 =?us-ascii?Q?Z6lE4G+Xssb3GRl9YIz8jz63AcRFynLhUD580OleJxh/3wJGbd2T9PQOHKRJ?=
 =?us-ascii?Q?y6AUV3dNEExMedSrpvpC0MbiDZQdN/01rTS3UOq79juvv9A/y0i484e9JWTx?=
 =?us-ascii?Q?L6s0TLM6I9EVoOOAZtaeDcy+GyFREVGT5Efr79MNWUIyG6G/1wYwTIq5SwZF?=
 =?us-ascii?Q?scWkIXiNYuRMfmM835KIdfkvgMOqsW1oNtBolGDNsbDrNqPDd6Y8A7E9CnrH?=
 =?us-ascii?Q?YGjGtVznJ9RnH8T9/+7afJz+2wRF3BIh+TAbQ8/7mhu95+5iZou83URUCH6T?=
 =?us-ascii?Q?xqQTAGYySNUZKGgup6+UjR0UNcqadHKH/B+ug+anTHu8xdB7hVUGmVZZSthC?=
 =?us-ascii?Q?by8jvcDnPZ8MMlJN/ZGML3smUtHWSqyuimGlBfTfje5HdX5S/6Hlneei2Jg8?=
 =?us-ascii?Q?bpZu4GrKTuSj+u7V2yP50H0tUP/aDOtfOp/Uol+uZgW+ukRJFR5+C/Imnxie?=
 =?us-ascii?Q?rtD4Fx5q/3+aG52Jv4UTssyyzLRykYhZ8+W3XnK3rtJFLeXh4t3uSlkuqM/K?=
 =?us-ascii?Q?Rmbc9Lb8cwQPPvwRFryuv3utfG39EuP8p2INiaUKSResx+3BeVYj6C4B+Oea?=
 =?us-ascii?Q?cHXxfq7P9n2ddGbzDsmfgY3Uv9sCJIUjzIrANBlMynT9WH/7/k7BL9o0vnLH?=
 =?us-ascii?Q?hu+r9/f0GTvz++3CRx6J9Ow0xQ/HO0JWKPFozhPngn10wVA7Ut79NelsSKoh?=
 =?us-ascii?Q?sK/IYiZWPfR4MabRZJLn332oigZ48YyH8tciNYjiKD4OsTmiL2OeSjjgAD1V?=
 =?us-ascii?Q?PG+zh2dg9CDFMX4BVOEbl+7RxH3arqFAxNfgG6ZPKIzvarTb/l6YbYHoiEBv?=
 =?us-ascii?Q?DBV/un0IhlOlcknFnNZpeCQHt2+bjCgcwW+jTdAbO4Gz1ypVXwRQfFoq/Ng8?=
 =?us-ascii?Q?qgdiwzvy8XdkrjeaXamwBZHI4WTfrGerMbrZPUU4k9+zCK7MX387Y0cQ40Wg?=
 =?us-ascii?Q?lxxPBRm16vpcon0aIZPBmncPma5G7DbMJD5QaHdupFuf2bVnovL9jIZj3YYw?=
 =?us-ascii?Q?I7o0lmJC6rzHqZAE7B5s9Wh5IncZnV1Y6+MmOmF39ZP?=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;6:rBeoNZUb8mZaPfnScdqIWbVL+a3Y4pFRrP6wzmi2cAYB4yZX8JSYKkrLTNmkDK7b2xFq5/f9vzkagShMHYiTTFm01Tgq9otuspXDFA5vc3jXvwrhzuEH+x0Ofrdt82SDphhP2xcl+l5J3OzFsytWkFrrw+LTtV7V8q98XlQyyhJd0/hhBGg269on7Z6anSXaH2PPBLHQabZpoUczjmX8l7iPs41wDRve2cFcG1pfgh0xFHD36YhRb/N4r+n7Czr1kU+OiDIjk739uH94MjhsRf0s4SIrDBFGKiH2ccovxSl1u3fC/F0EbkVSwRNv8jafCQfoFCuUVzU73aRG/C5gMf7j+SgjiiG9V5UkqRSGLuk=;5:0uWaI4TXmYzsNsHipzFm81CXp7YCPx72msVNQVvSoQNN/hyLH8zfjJt66r1X1GHjQ0Ug885htjEE/xcoyo4yOTeEPVwLXfoYxmMZ5f7YIOo0+w7N9I9htyuaCDWdZLvBqZ+SpIkcao7A2UAlbx1Ltm9SweG8gGhy1kVBcZn2eSw=;24:dCLem60e0eC81Rly/TizL5p0Exk0zMIbgrCvybhJ+nhVz/y1BwmCu6Mj10wCPqCMwLxcIdyvdRCSqEDWkJJM5UYEY19BCSIOtt19Vy+TsiM=;7:qKmSSK5jSvGUU6aFgZ0IkctwdHbIUZpueaQiWuOAXoRM4taWDvHs9+qEbx47kkliPpw7QizLTWdgQRV5psisU6P2EoNVUv9onrBi+FN+zjoBHUb/WZcg/gUle0s3mDcAwD2i1h1KIxpNpOmakLM1f/EMHvshw7yiT9zAtCsPLFfXnOyxStI+GR78/zCJmzuFHByo9P8FwFytWzgbADwUvtmXRj9+NMLsm6iaIhC+4qyYuYOybqc/mEjpPyChTPkY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;20:kif8rYG0OjSw23rGVBmyr3xBO17gadXYB0bI28arOGXWaopd/DoWtPp3gn2QuQiAKWgpT4WMLivnTsGEj3BKxB2fstoO4uE5/osaD3ePXS4MuU3VPP8uWAXeHP6opP5vtNLLLMEEwkvJhlF7TIIHrAAmclmCswZbQ59pRl37zPs=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 22:56:01.4224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f003849b-dfb2-4087-8ec0-08d569c6f7f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1082
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 01:17:56PM -0800, Eric Dumazet wrote:
> On Thu, Feb 1, 2018 at 12:22 PM, Roman Gushchin <guro@fb.com> wrote:
> > On Thu, Feb 01, 2018 at 10:16:55AM -0500, David Miller wrote:
> >> From: Roman Gushchin <guro@fb.com>
> >> Date: Wed, 31 Jan 2018 21:54:08 +0000
> >>
> >> > So I really start thinking that reverting 9f1c2674b328
> >> > ("net: memcontrol: defer call to mem_cgroup_sk_alloc()")
> >> > and fixing the original issue differently might be easier
> >> > and a proper way to go. Does it makes sense?
> >>
> >> You'll need to work that out with Eric Dumazet who added the
> >> change in question which you think we should revert.
> >
> > Eric,
> >
> > can you, please, provide some details about the use-after-free problem
> > that you've fixed with commit 9f1c2674b328 ("net: memcontrol: defer call
> > to mem_cgroup_sk_alloc()" ? Do you know how to reproduce it?
> >
> > Deferring mem_cgroup_sk_alloc() breaks socket memory accounting
> > and makes it much more fragile in general. So, I wonder, if there are
> > solutions for the use-after-free problem.
> >
> > Thank you!
> >
> > Roman
> 
> Unfortunately bug is not public (Google-Bug-Id 67556600 for Googlers
> following this thread )
> 
> Our kernel has a debug feature on percpu_ref_get_many() which detects
> the typical use-after-free problem of
> doing atomic_long_add(nr, &ref->count); while ref->count is 0, or
> memory already freed.
> 
> Bug was serious because css_put() will release the css a second time.
> 
> Stack trace looked like :
> 
> Oct  8 00:23:14 lphh23 kernel: [27239.568098]  <IRQ>
> [<ffffffff909d2fb1>] dump_stack+0x4d/0x6c
> Oct  8 00:23:14 lphh23 kernel: [27239.568108]  [<ffffffff906df6e3>] ?
> cgroup_get+0x43/0x50
> Oct  8 00:23:14 lphh23 kernel: [27239.568114]  [<ffffffff906f2f35>]
> warn_slowpath_common+0xac/0xc8
> Oct  8 00:23:14 lphh23 kernel: [27239.568117]  [<ffffffff906f2f6b>]
> warn_slowpath_null+0x1a/0x1c
> Oct  8 00:23:14 lphh23 kernel: [27239.568120]  [<ffffffff906df6e3>]
> cgroup_get+0x43/0x50
> Oct  8 00:23:14 lphh23 kernel: [27239.568123]  [<ffffffff906e07a4>]
> cgroup_sk_alloc+0x64/0x90

Hm, that looks strange... It's cgroup_sk_alloc(),
not mem_cgroup_sk_alloc(), which was removed by 9f1c2674b328.

I thought, that it's css_get() in mem_cgroup_sk_alloc(), which
you removed, but the stacktrace you've posted is different.

void mem_cgroup_sk_alloc(struct sock *sk) {
	/*
	 * Socket cloning can throw us here with sk_memcg already
	 * filled. It won't however, necessarily happen from
	 * process context. So the test for root memcg given
	 * the current task's memcg won't help us in this case.
	 *
	 * Respecting the original socket's memcg is a better
	 * decision in this case.
	 */
	if (sk->sk_memcg) {
		BUG_ON(mem_cgroup_is_root(sk->sk_memcg));
>>>		css_get(&sk->sk_memcg->css);
		return;
	}

Is it possible to reproduce the issue on an upstream kernel?
Any ideas of what can trigger it?

Btw, with the following patch applied (below) and cgroup v2 enabled,
the issue, which I'm talking about, can be reproduced in seconds after reboot
by doing almost any network activity. Just sshing to a machine is enough.
The corresponding warning will be printed to dmesg.

What is a proper way to fix the socket memory accounting in this case,
what do you think?

Thank you!

Roman

--

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c51c589..55fb890 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -276,6 +276,8 @@ struct mem_cgroup {
 	struct list_head event_list;
 	spinlock_t event_list_lock;
 
+	atomic_t tcpcnt;
+
 	struct mem_cgroup_per_node *nodeinfo[0];
 	/* WARNING: nodeinfo must be the last member here */
 };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 19eea69..c69ff04 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5623,6 +5623,8 @@ static int memory_stat_show(struct seq_file *m, void *v)
 	seq_printf(m, "workingset_nodereclaim %lu\n",
 		   stat[WORKINGSET_NODERECLAIM]);
 
+	seq_printf(m, "tcpcnt %d\n", atomic_read(&memcg->tcpcnt));
+
 	return 0;
 }
 
@@ -6139,6 +6141,8 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	gfp_t gfp_mask = GFP_KERNEL;
 
+	atomic_add(nr_pages, &memcg->tcpcnt);
+
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
 		struct page_counter *fail;
 
@@ -6171,6 +6175,11 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
  */
 void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
+	int v = atomic_sub_return(nr_pages, &memcg->tcpcnt);
+	if (v < 0) {
+		pr_info("@@@ %p %d \n", memcg, v);
+	}
+
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
 		page_counter_uncharge(&memcg->tcpmem, nr_pages);
 		return;
