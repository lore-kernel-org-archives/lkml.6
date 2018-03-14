Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCNUIm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:08:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35674 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeCNUIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:08:40 -0400
Date: Wed, 14 Mar 2018 23:08:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] of: unittest: fix an error code in
 of_unittest_apply_overlay()
Message-ID: <20180314200828.GA10588@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=862
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803140217
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We accidentally return zero on failure instead of a negative error code.

Fixes: 39a751a4cb7e ("of: change overlay apply input data from unflattened to FDT")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index dede77a79820..bc03902693b7 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1417,15 +1417,13 @@ static int __init of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
 		int *overlay_id)
 {
 	const char *overlay_name;
-	int ret;
 
 	overlay_name = overlay_name_from_nr(overlay_nr);
 
-	ret = overlay_data_apply(overlay_name, overlay_id);
-	if (!ret) {
+	if (!overlay_data_apply(overlay_name, overlay_id)) {
 		unittest(0, "could not apply overlay \"%s\"\n",
 				overlay_name);
-		return ret;
+		return -EFAULT;
 	}
 	of_unittest_track_overlay(*overlay_id);
 
