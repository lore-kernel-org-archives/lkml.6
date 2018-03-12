Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932246AbeCLTms (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:42:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53312 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751282AbeCLTmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:42:46 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Tony Lindgren <tony@atomide.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH] dcache: fix indirectly reclaimable memory accounting for CONFIG_SLOB
Date: Mon, 12 Mar 2018 19:41:40 +0000
Message-ID: <20180312194140.19517-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:180::1:3751]
X-ClientProxiedBy: AM4PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:200:89::18) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef2c8aec-0ad7-48a3-f591-08d58851576b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:QV+NCeycodwY8lIqAvPN1sN5tasSzvSCmrDcdVCYj2y2FbvbHRqdKD06EXAsbsgnqsIglZYgRRVyPa6stVl/TQqBIho/RsakdQqmRVaPqnGHvFDpNyqTDP2upuO98f3OKo/mTgqGp+FH0hoERqWlkWOdoEeF8XRt2ABZ+GvIFAw88GjkT83knAEUJ65meOymrBTuCJynEwThncwBlIxEFZvanlCblN8BnDOAGEcj9yyo+coee1ABRyO7ozihnqoe;25:DNlrt33W6unuYktwIAK4aWgA4LNvEE6zsvg08X1b8GBJ/22KAyLHTryaxu6IwkXZAfmKPMtRuDJtxH2sFItDyVJvmU+0BbJse5zraLOSuzJG5XJjE9+9KfwVo1slO4Ak/L3AdhSsb/QBYmTSOaSNHD8rCTcy5K9pT/szXu4lb70QlnMZFNReAz9cJR1HzgIVpiV1dReP99cTMbQ0F8a1nZsDEkYP1lnn/w2dltXtJNL4VEymai5qwCivkyVPyhkltxDLaOnPw1GdW2JPaOo0Whwvu2qU/Gttzz8OT9/bfhZbb3R4BA1fy0zzQJIcOVYueUZ3FHeQmUfRX0i0yONe7A==;31:3vx/AhW9eSJYz5ddgAxOTdUMKh+EDhHob4uaw3/EKW/D1r8Ng5rA8TXl2Z+QBhqGUxpXHROf5LSZKWJ4CBESCyREwZaRkSoyKAAnolcVEGAnIxS6S2nzZukj+WH0eORXytulb3dF6g6OTpQN+KtmcEROplK22Z2RVFOz03XnxHCXLid5kCMIkdIIsa3z1QE5sANfWNTCIHWgSC0bhhYmfLslI7EubDWxXO783qw5q5M=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:F+LoYQ3B/1BCt2l2FRF64gY76UC/MAaba0gC1OGhV0sChVtr9u9+9GdzETof2fMEp9Dksa6Qkq33dDF74DScAVdntuFKAWaYtjo1u1XsMERWWoHU2ZnKrklwUZfniVupjLSdJu0/I34TFEOHh1C7xBPV3IyNjcyULwjNibhY9zzS40HHhGDizpt0YNqahru2tDvJa4GSuNqBZ7Xy8YL78fNkbdGSmG5gn2VRhO1dfHFJh/H8RVd0J2uy4as6985x9ZTit7m1y8jKDhOv2RV2aBfMsto74Go75nDvJgdrWgheUyjNu1owAm+yg8bYQXWeyq8i+oSTStYfKCkz8/oMAjXZhl34NKqFItkFTIpfR29njTB6t5lnaxOhLD9RGnJ0Q26gR4MpbjtuJClOQ/VoMaCMrdjgCgBd5Ffe1jkLq7XlUJXNCz8jo+UkXXVc5ed3alRwAhOvojnsur35NDpTWAQ+FTgdeVHQbgvijoGAMoLAAGyBVTNNpajD8xCUfNQS;4:5yIrj1tpfgZHBJqcnFZcOGBsb/90cQm5CsjmAPG0GVHTAArKwEgTerzFV9MMu89GzzKL7wJNYjMB8TyL61bfXk54HC0TGZzPkv8byKak8SLMMISjqEDacxNOYFMQMT0o9haq4DLx7qmaecyyaqaSLsKJLpg8jU4ImFdAeb5f5BR5mVyITfNnXNo3XjKds6aPn3lk9l7l2fecyLjxHopdskiWoWP8JqqkzleJUYbVWVtdU0o+pcDnNXCDPhN4IeQtNRlE9rbDqri7UxRwvrePL78q4EmbBUt4yWFvbqUgmVxYlpraoJfQHVdQntD6DhtFb/E/yUzmcl8Q5/6aYkNFFgi3fEhFjqShIFyOVS0K4G0=
X-Microsoft-Antispam-PRVS: <CO1PR15MB1077D46D5E67119C596B0357BED30@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(11241501184)(944501244)(52105095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(396003)(39860400002)(366004)(189003)(199004)(47776003)(478600001)(2361001)(2906002)(6486002)(2351001)(53936002)(6512007)(106356001)(25786009)(68736007)(7736002)(15650500001)(4326008)(305945005)(69596002)(36756003)(6666003)(6116002)(46003)(97736004)(48376002)(105586002)(1076002)(6916009)(53416004)(86362001)(186003)(54906003)(5660300001)(51416003)(316002)(52396003)(16586007)(386003)(6506007)(1857600001)(59450400001)(16526019)(8936002)(8676002)(52116002)(50226002)(81166006)(50466002)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:W2DvJnB0Q/AK4l068/YKji5E34zr4cZeRFgebpICu?=
 =?us-ascii?Q?7cXzVA4+jfQm9usNQX5JAciIxuCRRHAEfr+oRsVQwJ2H5KdIOLzrPHiFx7C/?=
 =?us-ascii?Q?CbYXH8+tw9KfgQbmz7GAWbBh3RS70uSNyExhxpU7ugiyou51e8Waq7Aci9yW?=
 =?us-ascii?Q?ohziCBAzmV54Xc/Ca3hNfL3YAXzC9CCIfogzRGRYk4HdkvJos70UxFkTJWCq?=
 =?us-ascii?Q?rkgN2TX5ha9lB0k2KOzb7zWBRIaYEZbK5nAy1cvJB5544/LxQLeZ4uE1oDZI?=
 =?us-ascii?Q?Kphfj3EMjoNi6YXLmeG9qll0FC8Pc+RqZs4IoNkgo8NOwYP5wWUjnyZqBogI?=
 =?us-ascii?Q?EO25dPrFvTE/aDRUUsXK4M4tp/b+1HT9Q0tibvSXWYHLnXxsjakNNtZqvVqX?=
 =?us-ascii?Q?yePxN8+0Xopt1ZZx8/JpvpgQeaz5yYL5xI04/KD5InZvWtKc1m95Qa/blCLK?=
 =?us-ascii?Q?njdDppQoFcBdGY1QvhT6BFPs7aeYkCpOs+B9+JwCbPV7RvMN0o2x0XRGFGmY?=
 =?us-ascii?Q?yBI7+CTzO1WGYiPbr66uKNg9oPa5YNer/Y49qpZ07IKp+EVIglBGkGNJWl/o?=
 =?us-ascii?Q?8Cmwr8WfHNWAaYyHqlE4Xkv9rWyraF2/Fwy89jUY8T5xbQl8k0hHxrvjMI+3?=
 =?us-ascii?Q?yBwthfqIeyrOTDlhnjCRC7x2i2CEgripjalGzpFOX/qzZwMejOoBlWqep0dJ?=
 =?us-ascii?Q?1q0LqiZkolF7BhUfEGTs2osN/suXuXCUdAbY8ei2RUoRPi6hSEM3MMv4jauX?=
 =?us-ascii?Q?i3cy7TtCT/d0hvrZ9lTo21qbtOgKkvBN1wYKQ2z/D8nl/LHTsn/qaO5GWjO9?=
 =?us-ascii?Q?6hgWT0ib56ltJFNvvfHhTpga3QMj62CC6HqKIY94w4lprukAKUK4GL6lHnre?=
 =?us-ascii?Q?VhpYa9TKz85THad6HVzM/UlDVju8bF08hZQ0SAiQC5ly/+ikqqDBQgvxnNel?=
 =?us-ascii?Q?7qjF7vOoiLC0fHVjObueRPgm6EZFYkt17ZsT4HJDiO6z21Y51bySkfqWKgkI?=
 =?us-ascii?Q?rwHwusUbDmTSdbpHXpy3ZmoK+9KUuvMvnvopWl6lwxwaCiYp47oU5PBOmcXn?=
 =?us-ascii?Q?MmQ6slS5oHSlAZaAjJac/W23wcbji0eCWun4D9FduR9cQZytuubq5wJR/kRk?=
 =?us-ascii?Q?ATJ1I/AB5CkMOrzZr33kQCe0xmgzShw/gvLxQtPK6//6ow9fNB3sipmvLW6u?=
 =?us-ascii?Q?CFQfMaqV3jOfpMeC74zQGvWQdfB+VKoaD2Oy0FRAm1mfw/llUpW2xnRr1Bpm?=
 =?us-ascii?Q?EaQzRtJpTQK2FKZIzE=3D?=
X-Microsoft-Antispam-Message-Info: VXibV2BUH6zG++Al07BNuUUC3r2tP5lBKgyGMQbDsVPIdILdZzj9yuXEPu36oCn58KJAhuHhd87CRvgMnjSBnVJzrLztSWic6yLRWPVR0j/NluNy6NJ2PqFefrVCW/mqpZvNm5Zw+OIeGhWbqTMZ5iZMQrm1bSAZd2w2SmZi9lGkHFYZnUzIe7PqfKswZmFQ
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:aFhN5Y9fFqmotBHG/jijrMSV6sRw1famOel5d44hp5J1SyOB0/eIEdzCgeGfKxZkZgf6WhsNuQPgqCCxfcvBMjiPrak3YFR8yQpbo23/td+oCFH7czcpdQ3UQxQHO/OPDlpJix4N/GA881ghH5APSxgKtWDMqiMPNw8cQF9ZvB4H8H7I7scjSSKiQUJE9IPd51Nin2jPbtJWjtbSutITm1AkG+p2Tr01wYiyHdFsLacDQV5Zm27oebk+VafVNO9rDKT/l0oc9TPVmySYCjpoki32xKI486UNsB4SMTYc5HegK4RzfPZpLmR6vi5MGGUtK8XX+yz+rDNdiUkCUofTk8xWnzFFxvkMq7vowDuOSlY=;5:SKOBpPLlYwMPZZpH+wTzHGwQug/L5jsaSoZOJvzOYrgEUtECQgs8ccK7QbJK9CPdltTWr+IHmrdy8XpkQ4UnY/dQjBIR74drKz9AI7C23DQ2YEoPSPzzJffhdbTnPAypUl8/Eea1ql9hFeZUOWtR+UhTIGeyozQ9a803mQhf0Bs=;24:TQLLUkE+kTIm+cYkDZBFbsGh6AV5MdtBlvTS0ZNOYVTaKiA8gSOYFKYKT/ehBzp1HKA5W+N8X1Ae0SNu2cO80zNuMyXE5rKMQCG5vthck08=;7:dMTdp/eouhRVWAnA/TxPUD2jZP31SXFOytw6tb2IDNWEodubM0FAXyxhvDLzQBiD8j572RNYqrARZ6WDyGY1OuGJdhBrdqrDLqVD6d9YgxqzbPkZGdiwaJQFFElG09kOLd9s36H+NBhwvTcEhnqltcDdQE50aX7aHrvfImOQTSR+BUOu2D6Af4+we0FlIuJoJX40B3JvN80qmsza/nryUYQ4RNAit4Vw48J6wJVGKvYvrjKPlnwp0V7bXen7zf16
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:H5XJSzp620+cYSLNmC2s/V2UUVUrFHlndB3L846QlvjcDavdz5VOHzzdqPA4oIww2z4LKY3MNBOKSjzzHMvKxVeAFO6b37jc3mguD/cEKbyRo1hqo7b+EaNZOtVvkwVjxFvL5DMT530L30cvgr0qk/wmSGwJU5pzXbJ6oSnHyn0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 19:42:05.9307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2c8aec-0ad7-48a3-f591-08d58851576b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indirectly reclaimable memory accounting uses
kmalloc_size()/kmalloc_index() functions to estimate
amount of consumed memory. kmalloc_size() always returns 0
and kmalloc_index() is not defined for CONFIG_SLOB,
and so it breaks the build.

Fix this by using ksize() function instead.

Slub:
$ cat /proc/meminfo | grep Avail
MemAvailable:    7857112 kB
$ python indirect.py
$ cat /proc/meminfo | grep Avail
MemAvailable:    7781312 kB

Slob:
$ cat /proc/meminfo | grep Avail
MemAvailable:    7853272 kB
$ python indirect.py
$ cat /proc/meminfo | grep Avail
MemAvailable:    7616644 kB

indirect.py:
  import os

  for iter in range (0, 1000000):
      try:
          name = ("/some_long_name_%d" % iter) + "_" * 220
          os.stat(name)
      except Exception:
          pass

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 fs/dcache.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 135297a2d40e..98826efe22a0 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -270,12 +270,10 @@ static void __d_free_external(struct rcu_head *head)
 {
 	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
 	struct external_name *name = external_name(dentry);
-	unsigned long bytes;
 
-	bytes = dentry->d_name.len + offsetof(struct external_name, name[1]);
 	mod_node_page_state(page_pgdat(virt_to_page(name)),
 			    NR_INDIRECTLY_RECLAIMABLE_BYTES,
-			    -kmalloc_size(kmalloc_index(bytes)));
+			    -ksize(name));
 
 	kfree(name);
 	kmem_cache_free(dentry_cache, dentry);
@@ -1607,10 +1605,10 @@ EXPORT_SYMBOL(d_invalidate);
  
 struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 {
+	struct external_name *ext = NULL;
 	struct dentry *dentry;
 	char *dname;
 	int err;
-	size_t reclaimable = 0;
 
 	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL);
 	if (!dentry)
@@ -1627,17 +1625,15 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 		name = &slash_name;
 		dname = dentry->d_iname;
 	} else if (name->len > DNAME_INLINE_LEN-1) {
-		struct external_name *p;
+		size_t size = offsetof(struct external_name, name[1]);
 
-		reclaimable = offsetof(struct external_name, name[1]) +
-			name->len;
-		p = kmalloc(reclaimable, GFP_KERNEL_ACCOUNT);
-		if (!p) {
+		ext = kmalloc(size + name->len, GFP_KERNEL_ACCOUNT);
+		if (!ext) {
 			kmem_cache_free(dentry_cache, dentry); 
 			return NULL;
 		}
-		atomic_set(&p->u.count, 1);
-		dname = p->name;
+		atomic_set(&ext->u.count, 1);
+		dname = ext->name;
 	} else  {
 		dname = dentry->d_iname;
 	}	
@@ -1676,12 +1672,10 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 		}
 	}
 
-	if (unlikely(reclaimable)) {
-		pg_data_t *pgdat;
-
-		pgdat = page_pgdat(virt_to_page(external_name(dentry)));
+	if (unlikely(ext)) {
+		pg_data_t *pgdat = page_pgdat(virt_to_page(ext));
 		mod_node_page_state(pgdat, NR_INDIRECTLY_RECLAIMABLE_BYTES,
-				    kmalloc_size(kmalloc_index(reclaimable)));
+				    ksize(ext));
 	}
 
 	this_cpu_inc(nr_dentry);
-- 
2.14.3
