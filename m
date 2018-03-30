Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbeC3VTD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:19:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752753AbeC3VTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:19:02 -0400
From: "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, rosattig@linux.vnet.ibm.com
Subject: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
Date: Fri, 30 Mar 2018 18:18:50 -0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18033021-0024-0000-0000-00001827E5E2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008773; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01010755; UDB=6.00515008; IPR=6.00790033;
 MB=3.00020336; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-30 21:18:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18033021-0025-0000-0000-00004F517C3A
Message-Id: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803300214
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to issue write_zeroes command against TARGET the nr_sector is
being incremented by 1, which ends up hitting the following condition at
__blkdev_issue_zeroout:

     if ((sector | nr_sects) & bs_mask)
                return -EINVAL;

Causing the command to always fail. Removing the increment makes the
command to work properly.

Signed-off-by: Rodrigo R. Galvao <rosattig@linux.vnet.ibm.com>
---
 drivers/nvme/target/io-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 28bbdff..8d72686 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -174,7 +174,7 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 	sector = le64_to_cpu(write_zeroes->slba) <<
 		(req->ns->blksize_shift - 9);
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length)) <<
-		(req->ns->blksize_shift - 9)) + 1;
+		(req->ns->blksize_shift - 9));
 
 	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
 				GFP_KERNEL, &bio, 0))
-- 
2.7.4
