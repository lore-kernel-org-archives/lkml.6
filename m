Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeDSNqu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:46:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50722 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753050AbeDSNqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:46:47 -0400
Date: Thu, 19 Apr 2018 16:46:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lee Jones <lee.jones@linaro.org>,
        Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mfd: tps65911-comparator: Fix an off by one bug
Message-ID: <20180419134634.GA19793@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8867 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=874
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804190123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tps_comparators[] array is used in two places.  We only access the
COMP1 (1) and COMP2 (2) elements.  Unfortunately, we're accessing the
wrong elements and also one element beyond the end of the array.  There
was supposed to be a zero element at the start of the array which is
isn't accessed but makes the math work out nicely.

Fixes: 6851ad3ab346 ("TPS65911: Comparator: Add comparator driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I can't actually compile this code...

diff --git a/drivers/mfd/tps65911-comparator.c b/drivers/mfd/tps65911-comparator.c
index c0789f81a1c5..35d7380f6fad 100644
--- a/drivers/mfd/tps65911-comparator.c
+++ b/drivers/mfd/tps65911-comparator.c
@@ -42,6 +42,7 @@ struct comparator {
 };
 
 static struct comparator tps_comparators[] = {
+	{	.name = "COMP", },
 	{
 		.name = "COMP1",
 		.reg = TPS65911_VMBCH,
