Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935354AbeEIRhC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:37:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934953AbeEIRhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:37:00 -0400
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>,
        "Dong Jia Shi" <bjsdjshi@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 1/1] s390: vfio-ccw: push down unsupported IDA check
Date: Wed,  9 May 2018 19:36:47 +0200
X-Mailer: git-send-email 2.16.3
X-TM-AS-GCONF: 00
x-cbid: 18050917-0040-0000-0000-00000457D1BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050917-0041-0000-0000-000020FBDEDB
Message-Id: <20180509173647.61367-1-pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090165
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is at least one relevant control program (CP) that don't set the
IDA flags in the ORB as we would like them, but never uses any IDA. So
instead of saying -EOPNOTSUPP when observing an ORB such that a channel
program specified by it could be a not supported one, let us say
-EOPNOTSUPP only if the channel program is a not supported one.

Of course, the real solution would be doing proper translation for all
IDA. This is possible, but given the current code not straight forward.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
---

QEMU counterpart comming soon.
---
 drivers/s390/cio/vfio_ccw_cp.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 2c7550797ec2..adfff492dc83 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -365,6 +365,9 @@ static void cp_unpin_free(struct channel_program *cp)
  * This is the chain length not considering any TICs.
  * You need to do a new round for each TIC target.
  *
+ * The program is also validated for absence of not yet supported
+ * indirect data addressing scenarios.
+ *
  * Returns: the length of the ccw chain or -errno.
  */
 static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
@@ -391,6 +394,14 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 	do {
 		cnt++;
 
+		/*
+		 * 2k byte block IDAWs (fmt1 or fmt2) are not yet supported.
+		 * There are however CPs that don't use IDA at all, and can
+		 * benefit from not failing until failure is eminent.
+		 */
+		if ((!cp->orb.cmd.c64 || cp->orb.cmd.i2k) && ccw_is_idal(ccw))
+			return -EOPNOTSUPP;
+
 		if ((!ccw_is_chain(ccw)) && (!ccw_is_tic(ccw)))
 			break;
 
@@ -656,10 +667,8 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 	/*
 	 * XXX:
 	 * Only support prefetch enable mode now.
-	 * Only support 64bit addressing idal.
-	 * Only support 4k IDAW.
 	 */
-	if (!orb->cmd.pfch || !orb->cmd.c64 || orb->cmd.i2k)
+	if (!orb->cmd.pfch)
 		return -EOPNOTSUPP;
 
 	INIT_LIST_HEAD(&cp->ccwchain_list);
@@ -688,6 +697,10 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 	ret = ccwchain_loop_tic(chain, cp);
 	if (ret)
 		cp_unpin_free(cp);
+	/* It is safe to force: if not set but idals used
+	 * ccwchain_calc_length returns an error.
+	 */
+	cp->orb.cmd.c64 = 1;
 
 	return ret;
 }
-- 
2.16.3
