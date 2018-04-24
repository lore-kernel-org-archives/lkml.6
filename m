Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbeDXIkq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:40:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932850AbeDXIkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:40:40 -0400
Date: Tue, 24 Apr 2018 10:40:36 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To: "Theodore Ts'o" <tytso@mit.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG, PATCH] random: sleep in irq context
In-Reply-To: <alpine.LFD.2.21.1804231518060.1767@schleppi>
References: <alpine.LFD.2.21.1804231518060.1767@schleppi>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina?=
 =?ISO-8859-15?Q?_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18042408-0020-0000-0000-00000415329A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042408-0021-0000-0000-000042A9941D
Message-Id: <alpine.LFD.2.21.1804241037590.1601@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240086
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018, Sebastian Ott wrote:
> This happend once during boot and I could not reproduce this since, but I
> think the following patch should fix the issue:

I can now recreate the issue reliably. The following patch works for me:

------>8
>From 6bbfab86beae8fe8b6efeffd08c9ad43d1c2ba68 Mon Sep 17 00:00:00 2001
From: Sebastian Ott <sebott@linux.ibm.com>
Date: Mon, 23 Apr 2018 14:59:20 +0200
Subject: [PATCH] random: don't sleep during allocations

Since numa_crng_init() can be called from irq context let's
use __GFP_ATOMIC for allocations.

Fixes: 8ef35c866f88 ("random: set up the NUMA crng instances...")
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
---
 drivers/char/random.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 3cd3aae24d6d..98634b8025d5 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -795,10 +795,10 @@ static void numa_crng_init(void)
 	struct crng_state *crng;
 	struct crng_state **pool;
 
-	pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL|__GFP_NOFAIL);
+	pool = kcalloc(nr_node_ids, sizeof(*pool), __GFP_NOFAIL | GFP_ATOMIC);
 	for_each_online_node(i) {
 		crng = kmalloc_node(sizeof(struct crng_state),
-				    GFP_KERNEL | __GFP_NOFAIL, i);
+				    __GFP_NOFAIL | GFP_ATOMIC, i);
 		spin_lock_init(&crng->lock);
 		crng_initialize(crng);
 		pool[i] = crng;
-- 
2.13.4
