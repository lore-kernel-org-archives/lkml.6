Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbeDBQbt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:31:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753013AbeDBQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:31:45 -0400
From: "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, rosattig@linux.vnet.ibm.com,
        rodrigorosattig@gmail.com
Subject: [PATCH v3] nvmet: fix nvmet_execute_write_zeroes function
Date: Mon,  2 Apr 2018 13:31:39 -0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18040216-0048-0000-0000-000002541E0E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008790; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012099; UDB=6.00515791; IPR=6.00791369;
 MB=3.00020377; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-02 16:31:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040216-0049-0000-0000-000044A2A667
Message-Id: <1522686699-26894-1-git-send-email-rosattig@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804020183
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
needs to be performed in the native format, so we moved the +1 right after
le16_to_cpu prior to converting to 512b.

Signed-off-by: Rodrigo R. Galvao <rosattig@linux.vnet.ibm.com>
---
 drivers/nvme/target/io-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 28bbdff..cd23441 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -173,8 +173,8 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 
 	sector = le64_to_cpu(write_zeroes->slba) <<
 		(req->ns->blksize_shift - 9);
-	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length)) <<
-		(req->ns->blksize_shift - 9)) + 1;
+	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
+		(req->ns->blksize_shift - 9));
 
 	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
 				GFP_KERNEL, &bio, 0))
-- 
2.7.4
