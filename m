Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755164AbeDWLDr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:03:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754707AbeDWLB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:01:27 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com,
        pasic@linux.ibm.com, pmorel@linux.ibm.com,
        Halil Pasic <pasic@linux.vnet.ibm.com>,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH v2 1/5] vfio: ccw: fix cleanup if cp_prefetch fails
Date: Mon, 23 Apr 2018 13:01:09 +0200
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
References: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042311-0008-0000-0000-000009A3F047
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008905; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01022058; UDB=6.00521638; IPR=6.00801293;
 MB=3.00020722; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 11:01:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042311-0009-0000-0000-000046ECC87C
Message-Id: <20180423110113.59385-2-bjsdjshi@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230116
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Halil Pasic <pasic@linux.vnet.ibm.com>

If the translation of a channel program fails, we may end up attempting
to clean up (free, unpin) stuff that never got translated (and allocated,
pinned) in the first place.

By adjusting the lengths of the chains accordingly (so the element that
failed, and all subsequent elements are excluded) cleanup activities
based on false assumptions can be avoided.

Let's make sure cp_free works properly after cp_prefetch returns with an
error by setting ch_len of a ccw chain to the number of the translated
CCWs on that chain.

Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 2c7550797ec2..62d66e195304 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -715,6 +715,10 @@ void cp_free(struct channel_program *cp)
  * and stores the result to ccwchain list. @cp must have been
  * initialized by a previous call with cp_init(). Otherwise, undefined
  * behavior occurs.
+ * For each chain composing the channel program:
+ * - On entry ch_len holds the count of CCW to be translated.
+ * - On exit ch_len is adjusted to the count of successfully translated CCW.
+ * This allows cp_free to find in ch_len the count of CCW to free in a chain.
  *
  * The S/390 CCW Translation APIS (prefixed by 'cp_') are introduced
  * as helpers to do ccw chain translation inside the kernel. Basically
@@ -749,11 +753,18 @@ int cp_prefetch(struct channel_program *cp)
 		for (idx = 0; idx < len; idx++) {
 			ret = ccwchain_fetch_one(chain, idx, cp);
 			if (ret)
-				return ret;
+				goto out_err;
 		}
 	}
 
 	return 0;
+out_err:
+	/* Only cleanup the chain elements that were actually translated. */
+	chain->ch_len = idx;
+	list_for_each_entry_continue(chain, &cp->ccwchain_list, next) {
+		chain->ch_len = 0;
+	}
+	return ret;
 }
 
 /**
-- 
2.13.5
