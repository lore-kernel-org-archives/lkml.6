Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeCOOFb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:05:31 -0400
Received: from mout.web.de ([217.72.192.78]:56531 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbeCOOF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:05:29 -0400
To: netdev@vger.kernel.org, Ganesh Goudar <ganeshgr@chelsio.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] cxgb4/cudbg_lib: Use common error handling code in
 cudbg_collect_tid()
Message-ID: <caaea20d-7f22-a315-4fa0-9370a9743a2f@users.sourceforge.net>
Date: Thu, 15 Mar 2018 15:05:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:t/8pTXmJpyxZOIS6rhoe9xOdVhZshH42l7z0QVhPSV8Lv0WQXOF
 mwAkpuU5cLBqsZVH8uS87ejIYkPi73G+3oYCt17oVG1usQ6wDlnDyLgEMRfx/Vd5E2Lz3B9
 NDSqW7ZNA3734ErLUd9ZTHxCqS0NIVRL0bMREAjT4NKwksgGgZlIHneP/i1sGUwFKDWCqba
 PtjEK25pOeE78t306kpQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zryzHwHZpQ4=:crxXGia6b+HpHlafy3gce8
 RZpXWINIn3+23bGZSQdzpt71EJho8lOelyc7uAV7BXBcCwoYxDkrLCxuQ5pX08TySjFGW1gg8
 rmOd9S5H4a8FLnhMEUjtcpJRTLKkLAVCfZEdVWbjVD2YUkE3MJrLahgZ/7qFQLvX30Of/6Iem
 DfWzWczGxFeO3FgLSxoYMKCZTnvTUPj6rlk21qp5kwkXb9n5oz0M9wmm4fvS6WppCXg5xkLvz
 rwqCNTiQ2IIBXptS+pzk1KIRH2eFk7B/ya7C5h+gcBAuUuZ4dOUdRznHHJX+75jsSJzb3Zxjf
 iLn0Gi+Kapr1WmTwetJpJDBuzndABQNlV4TmDe+cpguEGdeQgPcQQmw6UWSOMjQIDo5T4Zb5v
 1aChme+vluoCmthgf1q4jO5XvApCi/Q9QsxJ4diSHlyD/AoU3P0Tk7QOyLlY2Os8RlFTA+Fys
 YJvHZdCX/jGCJ0vzi9LEJahfC3zbNaVZCBDKMmBwTpCDgYY9LtIJmcNJhYa+R1rd+xRLW0/mg
 pFzGSfLtTOkauvPVn9Berkm53Wxr+O76Vikc25/Q0vSMdsggQ4ACStKU1k/pJYu8wHEfKjD21
 QmF+xAiLiNDPZq7AUP0Gi0KUPJ31OsD03zmAOi8N6Pe2tvPJsIGMlD37zTE/isqfVQ4ODz5Sz
 znkIuBfYeZDfU51U1cU9QjGzxrm4ruBXeLza7Im+K12Oc5YB21tcTnbBhlRMK5I97j5wZxXPj
 BhBlS1RHxM0XpEE8oH+jKzruUoF25AynG2URTLGNDSJg7jTeAWjCCtaKRsKJPm5SbuNbMKuA3
 xq3FWopivWyo7u40kHyZA/JeDohIejcw3y5dz8hFlKYiO3HuD4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 15 Mar 2018 14:56:10 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
index 9da6f57901a9..d5b5b6221d1f 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
@@ -1660,11 +1660,9 @@ int cudbg_collect_tid(struct cudbg_init *pdbg_init,
 	para[0] = FW_PARAM_PFVF_A(ETHOFLD_START);
 	para[1] = FW_PARAM_PFVF_A(ETHOFLD_END);
 	rc = t4_query_params(padap, padap->mbox, padap->pf, 0, 2, para, val);
-	if (rc <  0) {
-		cudbg_err->sys_err = rc;
-		cudbg_put_buff(pdbg_init, &temp_buff);
-		return rc;
-	}
+	if (rc < 0)
+		goto put_buffer;
+
 	tid->uotid_base = val[0];
 	tid->nuotids = val[1] - val[0] + 1;
 
@@ -1679,11 +1677,9 @@ int cudbg_collect_tid(struct cudbg_init *pdbg_init,
 		para[1] = FW_PARAM_PFVF_A(HPFILTER_END);
 		rc = t4_query_params(padap, padap->mbox, padap->pf, 0, 2,
 				     para, val);
-		if (rc < 0) {
-			cudbg_err->sys_err = rc;
-			cudbg_put_buff(pdbg_init, &temp_buff);
-			return rc;
-		}
+		if (rc < 0)
+			goto put_buffer;
+
 		tid->hpftid_base = val[0];
 		tid->nhpftids = val[1] - val[0] + 1;
 	}
@@ -1711,6 +1707,11 @@ int cudbg_collect_tid(struct cudbg_init *pdbg_init,
 	tid->ipv6_users = t4_read_reg(padap, LE_DB_ACT_CNT_IPV6_A);
 
 	return cudbg_write_and_release_buff(pdbg_init, &temp_buff, dbg_buff);
+
+put_buffer:
+	cudbg_put_buff(pdbg_init, &temp_buff);
+	cudbg_err->sys_err = rc;
+	return rc;
 }
 
 int cudbg_collect_pcie_config(struct cudbg_init *pdbg_init,
-- 
2.16.2
