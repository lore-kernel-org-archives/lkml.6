Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeCUCJj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:09:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751521AbeCUCIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:08:32 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
Subject: [PATCH 1/4] vfio: ccw: fix cleanup if cp_prefetch fails
Date: Wed, 21 Mar 2018 03:08:19 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032102-0028-0000-0000-000009544C9D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008713; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01006058; UDB=6.00512229; IPR=6.00785341;
 MB=3.00020153; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-21 02:08:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032102-0029-0000-0000-00003A0C01A0
Message-Id: <20180321020822.86255-2-bjsdjshi@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210024
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
error by setting ch_len to 0 for the ccw chains those are not prefetched.

Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index d9a2fffd034b..2be114db02f9 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -749,11 +749,18 @@ int cp_prefetch(struct channel_program *cp)
 		for (idx = 0; idx < len; idx++) {
 			ret = ccwchain_fetch_one(chain, idx, cp);
 			if (ret)
-				return ret;
+				goto out_err;
 		}
 	}
 
 	return 0;
+out_err:
+	/* Only cleanup the chain elements that where actually translated. */
+	chain->ch_len = idx;
+	list_for_each_entry_continue(chain, &cp->ccwchain_list, next) {
+		chain->ch_len = 0;
+	}
+	return ret;
 }
 
 /**
-- 
2.13.5
