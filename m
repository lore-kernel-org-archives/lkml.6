Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753916AbeEWC5G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 22:57:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753888AbeEWC5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 22:57:03 -0400
From: Dong Jia Shi <bjsdjshi@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com,
        pasic@linux.ibm.com, pmorel@linux.ibm.com
Subject: [PATCH v4 3/4] vfio: ccw: set ccw->cda to NULL defensively
Date: Wed, 23 May 2018 04:56:44 +0200
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180523025645.8978-1-bjsdjshi@linux.ibm.com>
References: <20180523025645.8978-1-bjsdjshi@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052302-0012-0000-0000-0000164AAC4F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009069; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036291; UDB=6.00530123; IPR=6.00815419;
 MB=3.00021250; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 02:57:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052302-0013-0000-0000-000052E4C534
Message-Id: <20180523025645.8978-4-bjsdjshi@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230025
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's avoid free on ccw->cda that points to a guest address
or an already freed memory area by setting it to NULL if memory
allocation didn't happen or failed.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 262f969b3b33..63c3df1c2ff2 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -491,7 +491,7 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 	struct ccw1 *ccw;
 	struct pfn_array_table *pat;
 	unsigned long *idaws;
-	int idaw_nr;
+	int ret;
 
 	ccw = chain->ch_ccw + idx;
 
@@ -511,18 +511,19 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 	 * needed when translating a direct ccw to a idal ccw.
 	 */
 	pat = chain->ch_pat + idx;
-	if (pfn_array_table_init(pat, 1))
-		return -ENOMEM;
-	idaw_nr = pfn_array_alloc_pin(pat->pat_pa, cp->mdev,
-				      ccw->cda, ccw->count);
-	if (idaw_nr < 0)
-		return idaw_nr;
+	ret = pfn_array_table_init(pat, 1);
+	if (ret)
+		goto out_init;
+
+	ret = pfn_array_alloc_pin(pat->pat_pa, cp->mdev, ccw->cda, ccw->count);
+	if (ret < 0)
+		goto out_init;
 
 	/* Translate this direct ccw to a idal ccw. */
-	idaws = kcalloc(idaw_nr, sizeof(*idaws), GFP_DMA | GFP_KERNEL);
+	idaws = kcalloc(ret, sizeof(*idaws), GFP_DMA | GFP_KERNEL);
 	if (!idaws) {
-		pfn_array_table_unpin_free(pat, cp->mdev);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_unpin;
 	}
 	ccw->cda = (__u32) virt_to_phys(idaws);
 	ccw->flags |= CCW_FLAG_IDA;
@@ -530,6 +531,12 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 	pfn_array_table_idal_create_words(pat, idaws);
 
 	return 0;
+
+out_unpin:
+	pfn_array_table_unpin_free(pat, cp->mdev);
+out_init:
+	ccw->cda = 0;
+	return ret;
 }
 
 static int ccwchain_fetch_idal(struct ccwchain *chain,
@@ -559,7 +566,7 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
 	pat = chain->ch_pat + idx;
 	ret = pfn_array_table_init(pat, idaw_nr);
 	if (ret)
-		return ret;
+		goto out_init;
 
 	/* Translate idal ccw to use new allocated idaws. */
 	idaws = kzalloc(idaw_len, GFP_DMA | GFP_KERNEL);
@@ -591,6 +598,8 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
 	kfree(idaws);
 out_unpin:
 	pfn_array_table_unpin_free(pat, cp->mdev);
+out_init:
+	ccw->cda = 0;
 	return ret;
 }
 
-- 
2.16.3
