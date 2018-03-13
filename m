Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeCMM6w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:58:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46314 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751776AbeCMM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:58:50 -0400
From: Roman Gushchin <guro@fb.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
CC: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@ZenIV.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>
Subject: [PATCH] dcache: fix indirectly reclaimable memory accounting
Date: Tue, 13 Mar 2018 12:57:01 +0000
Message-ID: <20180313125701.7955-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c091:180::1:de17]
X-ClientProxiedBy: MWHPR01CA0044.prod.exchangelabs.com (10.172.172.158) To
 CO1PR15MB1079.namprd15.prod.outlook.com (10.166.30.137)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c82ae9eb-ffa8-40a2-7220-08d588e22019
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1079;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;3:nY5DGT1vx0s/D6SGw1iOYg7fcSTRoOOe8e6ioNd2WhJbMHpmbiAgBsg+jQ6uWjlKmYqs12ECtVafjMXBU4SgTFrRJxPz/Hj123z7ADscpT8o/7f7COFkniQ2X7vnJUOTaVMDxXS8kJL3SfZs1c1E3n3yQdHLaAcXkt1eg5UFmI8TwNeGDqx8EKQ8F2G+m/NlJsqJ+WwcWjoN04JIDrh0Y/i3M2YM9KY+8vGMkBnx+IqjDEBB3OqRmfDJsipoMOlv;25:qxTiGZLL5iFt7ABl4DZ8aZVG/2XnZoCbCuc4/HK9Y7MJZd+xA46wskcOkEbe2pCJ5RyYy207bKLv9M1XVr7r9/Kz/b6BVOUfehabX+bHTyfVReXzpNowhyAvF+unpyAf0KwN87rvRMXc4zL0fxnVVdOPtoaivaDtbgohmg6iZvnaWuV6yvG+tHIOvL+r3RlI+st815i+fXQjzy08bp5K3i7YRrmgm2ghhGoGE6rtqSQCwvMpaiODmIWTsXnRIiYRP590o/ccHdHTuxjBoHPCPWWiYR7qKOSkWvjBwO9NE3eaRbU/SKxfQRuZfscSvP6dmHrOh+yA+P+ZniUHSqd4zg==;31:Hh6Q3absvcbhgfrth/8VvH723FW8bKy6U2FfUtpqZE/ZCXT1AQWNW73A7OMGN0jaGCPq689AEdHdqm2S2VgF7yKSH9vnLxAxKex4aghUsCMaMaa4EcEfEdpeOdgw6LpR9xVSjqSk7oN25qBvs2CWrkKywUvpeqHgp8oBKUzThxDDKiaIuty7GU2IEZoUj/en6UvckvscjrNgwravFxHl9sQw/hiLfWQAl7oAKJ4pChk=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1079:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;20:ykPbq0msSmafQumXDZrY6pUkuixDYT/lWkUHbaYUfxhZfsD9ekCr802XW+63c2tgHYe4Ew+7zkSQDSzCaFuG2xIx30RmdLPpYuUbrpsOTzFTzc3obw3+mU14GVk1PrGx2nGo0NvWTzhC1I0XDZwNKy2Ivb675zu/A7KPPZXCBZYGvrsMOdlvHmTJhtq0sVjMqdYdcxwDWd8uaJrXJE/1mKJBGq2B39gttxdtgqsFgrd+gWNNJN5AMErxG3ZcIoA5ce8HAhXa6RClgk5Id6mDyktVCiS7FqQ8EfKkVM62i9LMHsuRBiCN7wdWN7Z5PTVYvpVeEKkZk8NgAu0pWOW5rLwEfV7tsVOkczmY1Q9PkBGbcxLRbmVMPL2SXLFQSdMgBxshZR/3gay1/vGCISwbevZcOzkgAgue5E8CcLfPxmTHuHs5USX/FNQzSe8WSEwQTUT8rrYe5Mya5/4ti+wgDRtvxF0vA1rcxzPh5HByJMEY9wSrHwcgaMu3v14mbKDf;4:9c6i+Nh0t7vYNq8feMJ1oDHgLfugDCWCw8bKYrzXQORY/iKPd0DmCjvdcWrVy4Zu0jbacnbADfQObRxLLj686sjb3yazVXYJe4Fr5fnI0/iHEpD2x9NFbrGPSTdN4EYfagaAtEIROAShIToht7nQa57ppJzjdYA/xhrrqVl7vzHkLoTgYiul+5fPLc/mRR/nkmvI0Q2qlbBli8vG89quHIbWAv83Mt6Z5fpLG7iJWKk3zM4PeF87VMXJh0kx8y2kX3j66OgW6+f1oO/HG6l0Y2bm0rMClaPXItwqCZyMeBEpSWe/v5eQw5oQZhFI0DKRawvgXUkPOZMA2lA2MPlBRAVRXbb1lKGhGUFL6IPx4IQ=
X-Microsoft-Antispam-PRVS: <CO1PR15MB1079AA6BAD5BD499A2E102D1BED20@CO1PR15MB1079.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231221)(11241501184)(944501244)(52105095)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CO1PR15MB1079;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1079;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(376002)(39860400002)(346002)(366004)(39380400002)(396003)(199004)(189003)(54906003)(25786009)(478600001)(6506007)(386003)(59450400001)(69596002)(86362001)(6486002)(4326008)(6116002)(15650500001)(2906002)(1076002)(50226002)(97736004)(52116002)(81166006)(81156014)(51416003)(8676002)(8936002)(52396003)(50466002)(316002)(6916009)(16526019)(48376002)(186003)(16586007)(6666003)(7736002)(36756003)(105586002)(46003)(53416004)(106356001)(47776003)(5660300001)(305945005)(6512007)(68736007)(1857600001)(53936002)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1079;H:castle.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1079;23:nQk5/ZVJ2ZHt1hTKvse1L8bEXqivI1IfUArbRO5mA?=
 =?us-ascii?Q?pBlyb+J9PnbefW5PjeGXLdL0P/L29WZv/Qh8VeC3gJTJjWYW/9Kyf1mv4cgS?=
 =?us-ascii?Q?ZqKqOHO+LK+n0o6wTnERBzD9Jw+N/LIcv55WVM9VO2cjBjKj5RrcvF/DdA9y?=
 =?us-ascii?Q?/MvdzIiGsEatThKbfpef+khrvAgPnEr/lkEQ+4jxD3qEcs92mc41M7V685/P?=
 =?us-ascii?Q?OUtEJpvXvNVhbzad6UuxRq04d1/+USQ+aJ2Q9n1dpcNCU9pvZg+njHoqJdqm?=
 =?us-ascii?Q?QUH3ITQI9peowywYd98vdPk4RazlVZ50+d3juZ2H57H/VJ3tVPLRwydIXYgS?=
 =?us-ascii?Q?84F5xk9tpiE7lM0bU3AnhZ4yGOt+mXHQeTgFGad+Yw5/if0TyVeAENROC3ee?=
 =?us-ascii?Q?gSWgeaVIyDgrbJMYBw/kEk5BjqNj2thZZ06A8TdIP3BMlIieXxp8iCf3EoC4?=
 =?us-ascii?Q?ViOUugVS08BhVB0pNeeFP7ZAumG4ob7G9qUraGMJcMvoiN8J0ogDIHNk0ziV?=
 =?us-ascii?Q?oMubccdChhJK7CRs1fZvDVpgr9Z+2etkIyG7hnlqja/bwL6Nbc8qxIpcvcBu?=
 =?us-ascii?Q?xL9hGYh4O0BMqm7G/Rl/VMQcZkjS+sU5/ChJPCYtWn1PoSm2dEMfv9V3zNT7?=
 =?us-ascii?Q?MqKSUqxE2CxElZjHxzEdIaW6LGiea2ROzYZqOlTKUFFKM0kV5FPg8uSdnAfb?=
 =?us-ascii?Q?u2QbjrANifpYFjHHXvAbq+qHxcLG/29BIQOSvNDVv+rvVRIZaVjl6PvgtSZN?=
 =?us-ascii?Q?wEWDfHOQVjwPli6mH6/MqfRK+9/RtcyIrDT1A3U6waAK4LzA2nWLP7qEPUvQ?=
 =?us-ascii?Q?LRb51uMQczKAQPybG4gGlFyhbMBD13AUGa6FacC0HYq4C0gPvhaeAdTkuEZi?=
 =?us-ascii?Q?aD01JECWPSiIe0PSjE7EiWQX56MNabbV9IfyqIYJRrSr+2b5xbcqRaF3WUVk?=
 =?us-ascii?Q?wALtybu3CyBkx++ipmlUN6OGbGi8K/v47Pa2P72XTytN9HpNb/gsMXpOgAjR?=
 =?us-ascii?Q?tH7Vr7LiIWieDdnsc+AXKo4zIn2ExFEbXkWCps9hGnmLN98EFf1yPts+dyID?=
 =?us-ascii?Q?nWWIMxbeiFrlRG607nanT2sP4F2EZor/IzodAccUZxQcWAG+f0MZZ9D7aFGu?=
 =?us-ascii?Q?h35QX+doEsSxc9e+r8GmN10E60LAgMjHCTmzNcmMDPK2M9P+VkMR6Uo2Tk02?=
 =?us-ascii?Q?4Ea8ePw8SrhZGeq3ihDIISD28AyiT9M0mPOcPrsk5HoE5GcIM7idpzfDoVQI?=
 =?us-ascii?Q?7h1P4GlO7orFZTkZh5iqxQ4pDfSBItqe51LBJbauiIDu4Ng8BHuYbUO2/1ia?=
 =?us-ascii?Q?awoCZrLw22IURn0JK9+ff4=3D?=
X-Microsoft-Antispam-Message-Info: emiSDotvmj0glCcmZCilpW4lyxf1SirDgsrg7cUmYPTPOHF7YsDrA0phdnchpLLCaFXW4W0Q4R69vpTaYpQ/GxCgA9acPEwJVeg/NVGNXPcrrNnegQYjCJ5REyRy85p3eq1V8LKy7cnLA5qbBW2LjkQcdMrFSOd8+DoAY8TG9BF0gaZSft70XsbDRws9Qjvs
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;6:lEuh1w2SKggHR2m/Vjh6hyNSyAsKE8T2YpHpzD9ZYywZLJkZo0iLe2PjEg1kRWQ0HyM9Bi0YK/YbBn11PefjPcj6cA21KT9B9SmgdTgRxE/pOB3lUXqo3ejXzMqc1kg0gFOP69R+nIglLxBwX71IJg0d+EIrH0yxdzkVvu0zZCfqgHXrlpukO/WaoOFCSNPU2J5TRkH+ZQrIpx5hibQybC5o0Pu5/0bICNd6eng5AXfHbXv08A5gZYzrru1BwpM0QEuIHOPJSL1hy67Zt7tFi4gOYgSEGWPX6xSRb5q0q/MA2Q0AXeMcto1NPFv0Kv9EPjgZ/+LYCMJhuIBt9kH6f6U/BD8q0gnSYtVksOWco5Q=;5:XniWDpvpOjovgnsXdE+vJSd+Asfb4iEfddeYafknS7GbMonZDYyJdNcIZB0uyALYFTjb36LaAhGBzyaeMeCsBIHuGPL/kBUjQDWivA4OI2HwLo3MXI5kN1kYwC/13bf2za/YuuCZI1yw4itQFy+z/xXB2p9Io5m01ecQA7omZEE=;24:UhIU5Wda+gXElDpbWLu/VJ9lYGwL9aQp0LSh+cy9sgVbP2TIvr3+hPF3rr45cqFfS7SFEKX7resNDxJfLU4A9Dxov+JbA+IWCDW+JNZo8Eo=;7:qQHq6YERmRSwxXVZ9VYBQ6Ipmi0bA5zSnAJC69DV5P9QvIoPekBM/X4pnA0pjZsHzYbU2OSB9AF0EuH6/1rJbKNBDgujtn5nsPKDegVaoBotqFiTWEjGF1ZhJHVolUfIBI8Uy4FgHoTzf6TaPgEo5H2s1llRXQV8or8JpsAvZXF3hPZGSJKT6vvLMO1bDKDCUM43+SpGjmfZWK/rZOG+4SFnuWU41UzFZ7xakWxjbfeAmJ0Ck6DH2/qaRiv/+te3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;20:I8zsWbN4ZoVpmRTZFwqc+dWoY7ZW1YblF9n2Gj3z2J2JiUJfBAJfPMZ0xJCLN3dGrd1wxfz92aaGQ2IBPYrlstLC9G3owAP3VKSVfoUn/vdLyC1OBm2PD51Ev7GWrJ38/8Zl9i8XhqLOCc6zjRdNlOYdWypfNJsK3tPwxMYadRk=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 12:58:24.2190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c82ae9eb-ffa8-40a2-7220-08d588e22019
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1079
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

External names can be released using kfree_rcu()
from release_dentry_name_snapshot() and copy_name(),
and it will lead to the imbalance in the indirectly
reclaimable memory accounting.

Fix this by introducing __d_free_external_name() and
call it from all release paths.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 fs/dcache.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 98826efe22a0..9008057a7460 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -266,16 +266,24 @@ static void __d_free(struct rcu_head *head)
 	kmem_cache_free(dentry_cache, dentry); 
 }
 
-static void __d_free_external(struct rcu_head *head)
+static void __d_free_external_name(struct rcu_head *head)
 {
-	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
-	struct external_name *name = external_name(dentry);
+	struct external_name *name = container_of(head, struct external_name,
+						  u.head);
 
 	mod_node_page_state(page_pgdat(virt_to_page(name)),
 			    NR_INDIRECTLY_RECLAIMABLE_BYTES,
 			    -ksize(name));
 
 	kfree(name);
+}
+
+static void __d_free_external(struct rcu_head *head)
+{
+	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
+
+	__d_free_external_name(&external_name(dentry)->u.head);
+
 	kmem_cache_free(dentry_cache, dentry);
 }
 
@@ -307,7 +315,7 @@ void release_dentry_name_snapshot(struct name_snapshot *name)
 		struct external_name *p;
 		p = container_of(name->name, struct external_name, name[0]);
 		if (unlikely(atomic_dec_and_test(&p->u.count)))
-			kfree_rcu(p, u.head);
+			call_rcu(&p->u.head, __d_free_external_name);
 	}
 }
 EXPORT_SYMBOL(release_dentry_name_snapshot);
@@ -2769,7 +2777,7 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 		dentry->d_name.hash_len = target->d_name.hash_len;
 	}
 	if (old_name && likely(atomic_dec_and_test(&old_name->u.count)))
-		kfree_rcu(old_name, u.head);
+		call_rcu(&old_name->u.head, __d_free_external_name);
 }
 
 static void dentry_lock_for_move(struct dentry *dentry, struct dentry *target)
-- 
2.14.3
