Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeCLWhM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:37:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46342 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751312AbeCLWhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:37:10 -0400
Date: Mon, 12 Mar 2018 22:36:38 +0000
From: Roman Gushchin <guro@fb.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH 3/3] dcache: account external names as indirectly
 reclaimable memory
Message-ID: <20180312223632.GA6124@castle>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-5-guro@fb.com>
 <20180312211742.GR30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180312211742.GR30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:180::1:afa0]
X-ClientProxiedBy: DB6P190CA0013.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:2f::26)
 To CO1PR15MB1080.namprd15.prod.outlook.com (2a01:111:e400:7b66::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24c0cee2-7d6f-4e2e-ee7f-08d58869c16a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1080;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;3:5OBNlEm0dgyFeIk4DNhV8u9N12YlUdFxVuRtuzzy7vJuBCxTAqGi0lq8SVG8zSjexodQBPHHlwfI91BHixGTsgKilbD8M1m89dV2Q6o1+wjLHrZSnFi8kpxs03XP6YPNChBXIb13nWFnqf8WV+GrmrVkPizC1Z9i3TqQDb4aiojEl9maR4QWjwD0NuGE/LDwe4oiHCTljWvN/8D3B714jLpnFE9DGnQLjQzbufshXdzeVK/h1KXchiPL0+bF6dff;25:61d7h8Z9Yi9oI3blKdr5K4inRPjztxc2Cvd//CEurmadDHXIecnDwOAkW3zshaWJSWCgTkwsXoUPFX/xO+bfcGMCyslivU8/84kS1JHE6DpVKoTBNSKrnEcyL5yN9M0+kNL60XCKCrECLLiccy1RN+uKLnz/WqA1qiw+U9Vul8Dbxr6WNa21KN/Q1tI+2WidgOdEJ3u6dY+42VZwdWG2prxXp1PF3DNn2ERjTxS2OvF71WNkwvmyOL0EqUxIzn4XjzXejYLwWatVb1UFx6nCXislkSgdYWDWsdTCR3mYa+OQzKViITLl7GpdyYeg3MsqwdGImUskyHUcRwZC1ZL76A==;31:0A+WIyd1cBicAQmAKYE4ZUixz4+cIB/FCwZ3U6PAbb7Q5Vb4CGkKYGJQxwbnA63G0bVgOe/PtRlYoP2L6lTIm32pKofSmy5hE19FOTtVwCsCs86iLidvmX0IzodxvvOy7IZN01++H+SecGLBInDkoTSvoLwvTwvtrvrtdIR70FkhTUqH6GFEecws7BndwI7ila1cBHXEFBgEBglJT/Ew5HRusDWBhMbhaM55H5St3Gs=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1080:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;20:+qvcwUBo6C9HwDPoqTfBbXGo9ylEuGWdDeeqL8cbnQaQLYBr2KfPyErT2e+WlClWlxkkX8EUXgNidv53ZXGEksFvBwYH/cDA5qpd2atmaUPUVc2T1ZD2g7vLGtnFKc+5hlM9CaMpEC/6bbKgXGfSQ5RDYJCsmPicfNtKFVvurghC8L3j9FJAI7d4FYa35MO6PVsW3ilzuQHPhS/G3SRsJQMNfCTSiGshPXFChZsoMj0TouOR8lrDiUgJxx47by0TJF9Vk+wSWUrKjjDp4+8b3SMSankdD4BTsAK0dFYzqb+eoa+wkm+i7RRUSimxVjoHrbzt6EIi4PbpQyKzUt412kztNmm1HeoJ21JRF+/E8Irj0Xgp+H/FULOf7Yh/zz0FbDsc/L+ysUKNgVRZLcOZaPvrY5jcXMXhBLPj5LSfbv8+LQMXwtXzmfuIc1T1kgic0F1/l/oLPEOlNBbP3JxqtjsUVwcRK5FEFqTgmsb98V/mv84NnFDdBUYuupOHe0wz;4:zYumDFKvnqOi7G4Fqm57GLRm0b4LGYq5hmOyi41sbttq7YsB8BGYCpbuNToUKz0qBY8kWDCWUKW7NEJ8J58GCW5gDTDeH9Gjz0UZbb8Pg0OUIVs7UIs45EnWVOs2W+007gYvIWcm6gmOMDARSiHA2QTpBTPJHlOsJsQA+uBk8ZjqlcocVOERVYp1NDOc58NY93N7oaahF8gbDQh3rA9rLQ6p9MuE2SVNYaIK/BLpzLuxb+9L5guhHzWS4xZNHJ9Mu+MwS02xdN21AuKAUqOr8hquorR8gEfDi9G7suzjT6jQykKIYCZOcsdpCFBklzPT
X-Microsoft-Antispam-PRVS: <CO1PR15MB1080AAA284BB77425BB26C09BED30@CO1PR15MB1080.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231221)(11241501184)(944501244)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CO1PR15MB1080;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1080;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(39860400002)(346002)(39380400002)(189003)(199004)(7736002)(305945005)(86362001)(9686003)(229853002)(55016002)(16586007)(58126008)(54906003)(6116002)(316002)(15650500001)(23726003)(1076002)(33656002)(47776003)(6246003)(6916009)(2950100002)(25786009)(478600001)(106356001)(68736007)(33716001)(53936002)(97736004)(4326008)(6496006)(52396003)(16526019)(46003)(33896004)(59450400001)(50466002)(6666003)(2906002)(52116002)(76176011)(105586002)(53546011)(386003)(186003)(81156014)(5660300001)(8676002)(81166006)(8936002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1080;H:castle;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1080;23:SRN1dayvIcfD4KTgAEsnGSmLEbGcKqBSQmaqZGsH8?=
 =?us-ascii?Q?oikpkmGD/q2MaadgiopKRX/RRHAD1DiDAmOCTW7sCrvxbJgz1ZFKMHQCKdhy?=
 =?us-ascii?Q?9BiUceir0plFkKb7x+NFq9jBWRJC//CiqRM4EwQY0kSHo1lJhAo2OVC8C0oi?=
 =?us-ascii?Q?WbzDIeFZOpzIuqTSvTTDnPDjI57fbIhLu1LAbexwwwYrN3ZGdM18YAAda7oM?=
 =?us-ascii?Q?su00Ry+UZ+OtFTZenLlWNMBJojbE/DbZcoQmAFHM3p7NpgmDhqieCsAoREuI?=
 =?us-ascii?Q?El51n/sXjI9hdlPHyWa6wA3pk8OevAyFqy0sQdSfGMlBv12sVgqpHXUxHxf9?=
 =?us-ascii?Q?MLx1bTNkDLNE1AB5IccI3cEoZpOwsLMXgm1TrnEn9Yl4InqIEzPoYTM4aNVo?=
 =?us-ascii?Q?3abLb44pE5ic/0VQw8vi4EsSxd2Wwo3eRiEeFk+55TfQozkY2NF4SMOdj51+?=
 =?us-ascii?Q?WguNwaz11qzpV0hmJL4oV2RmlG9+SOFZ5moGlVYx9lFVnohqh5b1HXEChgFQ?=
 =?us-ascii?Q?CFeO74nSBJK1gZvwfqMsqXEvFyHTKR69XTJ0fo6ZttYqQM7T/Zkn2HUEY3L2?=
 =?us-ascii?Q?lKHSPHV4Dqbthn0SqB5oKf5ifcExpS/S1g8Io7wy4w+giH4teux4hyHRwrqr?=
 =?us-ascii?Q?EyF4NWO1iLsyjZybjOGkA8DZGTYk02wyHWlvUEccaLd2XgDvXJuwReFlbVDK?=
 =?us-ascii?Q?Dg/smd4Bx8rMVt1fqGTC2mgratUw9RKB3jnxoUETzuYclHY0i+QvskUhPTb1?=
 =?us-ascii?Q?JDdER6w16Fqq8hbvXj4pUtxjyurFQESvSwFLiKo8saSIrBNBSzTrRI7eqUIo?=
 =?us-ascii?Q?2NYh+lb+s8oXcZtcSkwDnMv7viLAPW3cEIVu4pPih8EUP9LnpkUr6aiFhIc+?=
 =?us-ascii?Q?nzzOKIeDD1Z/XKBXJx7ylhY/6LVKcUQLz6FsVTPqUz53uZmzGYziMj+A7ceo?=
 =?us-ascii?Q?4yqTwBkE++2a33jLMQuOpw07FtUAoAm3YIjixEjbfZ14YKt708eMNeMoDNFM?=
 =?us-ascii?Q?Ua0oXO5rYIOu+G6VJszHDWP4UvEWv9a3tdfcHpWqtYk1esxAA1hxUhdi6wNO?=
 =?us-ascii?Q?Hr46d6Q1JaRan1kd4xwEOSeq4Api9QFe8EsB5GC5MgG0WC5vfqG7SLUd5hBm?=
 =?us-ascii?Q?ViRkPX0jE2QTwYQnc21ullF9VGoXcqOuaQASiPnRAZgIy9jc5HVZ3+HDHjwy?=
 =?us-ascii?Q?HLYGgiWJOKg9L8ib3gl6HFbkuVcRRx1C/zAo1r7/LdgYeNBQpxzCssiZZYfR?=
 =?us-ascii?Q?rFNG2ooE/OTiaQiYfbJgP/li2GDgY2jOnzYXAV1RI4oRBLfNSaKyq4zsL0It?=
 =?us-ascii?Q?VzDQFxSiCfS1JMcDzHmTSo=3D?=
X-Microsoft-Antispam-Message-Info: CYKsruExV5xuQ3vixVSrRxxwBwf7zsSgoUjiaYhRxwqDPbR6BQCTac2wJIzE6OFKoQG1bXisv95urnY12q6KjsPfUt+Chxxj97/4khsNY8fzowiHrgEwVRTtv7+nZqe1bfLDh0nuPByfyrF7N+q2bR9/g/k4uv+qUuKlZaSIoYwNW5Ej3LVZ/QQFbnNXDb1C
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;6:Uh6uDYl2Jb4pxafv7VsYIy0CkLUPLT+obJIOlhaLVp+jGlu4X9mb2fyqu+NVvr4Slou1qBruTPMkmBkzt3uwH1/wQzcQ+GCoQMo4PYv4Sw1rR7eFwkjsykh0XfrllkHCu4KcdcpCUz6sMfBfxZXmT9MUR/xwEmYbTNgC49foARdA6b1+7cW3hHUf1J6U/DBY1/WSzOKF//ya5f2XiNo81eSqySXjZzttq++Rc3AMVg3aAJlNmzvNtmwLUIYybgGa1vyVXoS77QPVzQbwFFjudFqSSc1Jr61iUYiJwo75faELXBqfGExKe/4OKtXQPlRbEBNM+yLvzQeXdz6QLaxiVzM89OBqCG+eyKgTEZre/b4=;5:16RM6qI5fZ2wjjRHlGck8w0OEimpowZME8ko31dK4BdBn5Qfw15eOlsjNaH0blEWriWZWg4qim7/sXmKRh0vBs1WOzd4A1XWWv1d6bR8sjAqVs8vhtkdezj83dedwlBBd6OooZBzNtcoOTottfi+hQ3IRRClTrlFgLAPDYuYVeo=;24:Q/pOQOkrrEtcA6eC6v2g1DqiziOBqQaGKIlYL2KpqktFO4+j6vAK78LIJ96srmwA74gk4TtVWsAugurI3DDddQcAcCdCjkbkYHQM+DdGZP4=;7:TtE5NUiF3fS9FwPflxHQF7hczYLzIPnnWxP7HWxkISaE7qZ+rwIEU7ZNUvOa6IZtEqOHbif0+sXJnl6byA+dW7fnSBtrPdtQcQCmG1e0DGsZgNVqjyGhxt9/7A/wjBtELYDt1lmPvmBLB4hG6CoiAibYqSh8/A/aw+0B0JTPVeYxxNI20HpCGvOo0ousVmmi/QTrTJbB9kF4TVYdfaS2XRLOwztej/iXLizf+eJHAvwDp1Sv+ecOsNRmXWtHE40k
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;20:/XkxGP/PtWO12TFheaUlHnFgPnbHGzKOAAsiyfwMQy1AhJ+8idpE7xYAmUsOs0oBJj+blgZ66f6FPUYCma7l2J+c6QX8BcSZn5l08+R/zhxOuCXwnFgAHwgvafnOSMPfSbMwEv6sQgaNqg1TDKuA7EH10kxi7EwNgAarRoKeTzw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 22:36:51.0746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c0cee2-7d6f-4e2e-ee7f-08d58869c16a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1080
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 09:17:42PM +0000, Al Viro wrote:
> On Mon, Mar 05, 2018 at 01:37:43PM +0000, Roman Gushchin wrote:
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index 5c7df1df81ff..a0312d73f575 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -273,8 +273,16 @@ static void __d_free(struct rcu_head *head)
> >  static void __d_free_external(struct rcu_head *head)
> >  {
> >  	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
> > -	kfree(external_name(dentry));
> > -	kmem_cache_free(dentry_cache, dentry); 
> > +	struct external_name *name = external_name(dentry);
> > +	unsigned long bytes;
> > +
> > +	bytes = dentry->d_name.len + offsetof(struct external_name, name[1]);
> > +	mod_node_page_state(page_pgdat(virt_to_page(name)),
> > +			    NR_INDIRECTLY_RECLAIMABLE_BYTES,
> > +			    -kmalloc_size(kmalloc_index(bytes)));
> > +
> > +	kfree(name);
> > +	kmem_cache_free(dentry_cache, dentry);
> >  }
> 
> That can't be right - external names can be freed in release_dentry_name_snapshot()
> and copy_name() as well.  When do you want kfree_rcu() paths accounted for, BTW?
> At the point where we are freeing them, or where we are scheduling their freeing?

Ah, I see...

I think, it's better to account them when we're actually freeing,
otherwise we will have strange path:
(indirectly) reclaimable -> unreclaimable -> free

Do you agree?

Although it shouldn't be that important in practice.

Thank you!

--

>From ad9d6c627c2b9315de1967c40a1f4fa68705cf9e Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Mon, 12 Mar 2018 22:24:28 +0000
Subject: [PATCH] dcache: fix indirectly reclaimable memory accounting

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 fs/dcache.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 98826efe22a0..19bc7495a6c4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -266,6 +266,19 @@ static void __d_free(struct rcu_head *head)
 	kmem_cache_free(dentry_cache, dentry); 
 }
 
+static void __d_free_external_name(struct rcu_head *head)
+{
+	struct external_name *name;
+
+	name = container_of(head, struct external_name, u.head);
+
+	mod_node_page_state(page_pgdat(virt_to_page(name)),
+			    NR_INDIRECTLY_RECLAIMABLE_BYTES,
+			    -ksize(name));
+
+	kfree(name);
+}
+
 static void __d_free_external(struct rcu_head *head)
 {
 	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
@@ -307,7 +320,7 @@ void release_dentry_name_snapshot(struct name_snapshot *name)
 		struct external_name *p;
 		p = container_of(name->name, struct external_name, name[0]);
 		if (unlikely(atomic_dec_and_test(&p->u.count)))
-			kfree_rcu(p, u.head);
+			call_rcu(&p->u.head, __d_free_external_name);
 	}
 }
 EXPORT_SYMBOL(release_dentry_name_snapshot);
@@ -2769,7 +2782,7 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 		dentry->d_name.hash_len = target->d_name.hash_len;
 	}
 	if (old_name && likely(atomic_dec_and_test(&old_name->u.count)))
-		kfree_rcu(old_name, u.head);
+		call_rcu(&old_name->u.head, __d_free_external_name);
 }
 
 static void dentry_lock_for_move(struct dentry *dentry, struct dentry *target)
-- 
2.14.3
