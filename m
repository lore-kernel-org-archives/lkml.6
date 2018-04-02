Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeDBOts (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:49:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751131AbeDBOtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:49:47 -0400
From: "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, rosattig@linux.vnet.ibm.com
Subject: [PATCH v2] nvmet: fix nvmet_execute_write_zeroes function
Date: Mon,  2 Apr 2018 11:49:41 -0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18040214-0012-0000-0000-000015FC2D34
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008789; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012065; UDB=6.00515770; IPR=6.00791337;
 MB=3.00020376; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-02 14:49:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040214-0013-0000-0000-0000521E8C97
Message-Id: <1522680581-10220-1-git-send-email-rosattig@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804020165
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to issue write_zeroes command against TARGET with a 4K block
size, it ends up hitting the following condition at __blkdev_issue_zeroout:

     if ((sector | nr_sects) & bs_mask)
                return -EINVAL;

Causing the command to always fail.
Considering we need to add 1 to get the correct block count, that addition
needs to be performed in the native format, so we moved the +1 to within
le16_to_cpu prior to converting to 512b.

Signed-off-by: Rodrigo R. Galvao <rosattig@linux.vnet.ibm.com>
---
 drivers/nvme/target/io-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 28bbdff..5292bc3 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -173,8 +173,8 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 
 	sector = le64_to_cpu(write_zeroes->slba) <<
 		(req->ns->blksize_shift - 9);
-	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length)) <<
-		(req->ns->blksize_shift - 9)) + 1;
+	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length + 1)) <<
+		(req->ns->blksize_shift - 9));
 
 	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
 				GFP_KERNEL, &bio, 0))
-- 
2.7.4
