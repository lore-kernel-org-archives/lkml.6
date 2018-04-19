Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeDSKIn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:08:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52664 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeDSKIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:08:41 -0400
Date: Thu, 19 Apr 2018 13:08:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] regulator: ab8500: tidy ab8500_regulator_get_mode()
Message-ID: <20180419100828.GA10724@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8867 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804190089
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The indenting here is confusing.

Also we don't check "ret".  That isn't likely to cause a runtime issue
because if it fails here fails then we'd probably return -EINVAL at the
end anyway.  But it does introduce a static checker warning since "val"
is only inititialized on the success path.

    drivers/regulator/ab8500.c:429 ab8500_regulator_get_mode()
    error: uninitialized symbol 'val'.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 83dba3fbfe0c..4fab417f1803 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -425,7 +425,10 @@ static unsigned int ab8500_regulator_get_mode(struct regulator_dev *rdev)
 	if (info->mode_mask) {
 		/* Dedicated register for handling mode */
 		ret = abx500_get_register_interruptible(info->dev,
-		info->mode_bank, info->mode_reg, &val);
+							info->mode_bank,
+							info->mode_reg, &val);
+		if (ret)
+			return ret;
 		val = val & info->mode_mask;
 
 		val_normal = info->mode_val_normal;
