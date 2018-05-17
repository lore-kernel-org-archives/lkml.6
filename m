Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeEQMW6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:22:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45934 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbeEQMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:22:56 -0400
Date: Thu, 17 May 2018 15:22:29 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] misc: kgdbts: silence array underflow warning
Message-ID: <20180517122229.GA7655@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8895 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=623
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805170115
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch distrusts simple_strtol().  I don't know the code well enough
to say if the distrust is justified here, but it seems harmless to
silence the warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 6193270e7b3d..e0508acaedaa 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -400,13 +400,15 @@ static void skip_back_repeat_test(char *arg)
 	int go_back = simple_strtol(arg, NULL, 10);
 
 	repeat_test--;
-	if (repeat_test <= 0) {
+	if (repeat_test <= 0 || go_back < 0) {
 		ts.idx++;
 	} else {
 		if (repeat_test % 100 == 0)
 			v1printk("kgdbts:RUN ... %d remaining\n", repeat_test);
 
 		ts.idx -= go_back;
+		if (ts.idx < 0)
+			ts.idx = 0;
 	}
 	fill_get_buf(ts.tst[ts.idx].get);
 }
