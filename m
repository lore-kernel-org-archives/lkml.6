Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754476AbeDTJVR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:21:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41514 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754193AbeDTJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:21:15 -0400
Date: Fri, 20 Apr 2018 12:21:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lee Jones <lee.jones@linaro.org>, Rhyland Klein <rklein@nvidia.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mfd: tps65911-comparator: Fix a build error
Message-ID: <20180420092105.GA28058@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420085938.ymf2jc46dswylxh4@mwanda>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8868 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=904
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200092
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 2012, we changed the tps65910 API and fixed most drivers but forgot
to update this one.

Fixes: 3f7e82759c69 ("mfd: Commonize tps65910 regmap access through header")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/mfd/tps65911-comparator.c b/drivers/mfd/tps65911-comparator.c
index 887409c3938d..90cfdd1f88c6 100644
--- a/drivers/mfd/tps65911-comparator.c
+++ b/drivers/mfd/tps65911-comparator.c
@@ -74,7 +74,7 @@ static int comp_threshold_set(struct tps65910 *tps65910, int id, int voltage)
 		return -EINVAL;
 
 	val = index << 1;
-	ret = tps65910->write(tps65910, tps_comp.reg, 1, &val);
+	ret = tps65910_reg_write(tps65910, tps_comp.reg, val);
 
 	return ret;
 }
@@ -82,10 +82,10 @@ static int comp_threshold_set(struct tps65910 *tps65910, int id, int voltage)
 static int comp_threshold_get(struct tps65910 *tps65910, int id)
 {
 	struct comparator tps_comp = tps_comparators[id - 1];
+	unsigned int val;
 	int ret;
-	u8 val;
 
-	ret = tps65910->read(tps65910, tps_comp.reg, 1, &val);
+	ret = tps65910_reg_read(tps65910, tps_comp.reg, &val);
 	if (ret < 0)
 		return ret;
 
