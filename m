Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeCUGsn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 02:48:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:36795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751459AbeCUGsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 02:48:42 -0400
From: Chengguang Xu <cgxu519@gmx.com>
To: ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] 9p: check memory allocation result for cachetag
Date: Wed, 21 Mar 2018 14:48:09 +0800
Message-Id: <1521614889-73446-1-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K0:iCw0FX3nZMFg319fY2Y2mDfPlk8WM+h73epFQSl+FQg9+SmLh4l
 6pvwLRIm+O9hpf8II//xwZ1n76sj7OukhRzRSXUGE0PHX2JdG7xlrIlvZAwPz8zJT8ULucQ
 orCiqFBrn36mHwws39DO8bp52gZyxMBuTXOmbcqQlCx+A3iuGPC1YyVWztBn2VQ4HbNsJmI
 GtaS4AJMHvgfozzIR/rDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tOabwKbytRs=:G0p1nCSYqe8slULC7KD6uk
 AUB7mdmfytJ0fgK9LjqWPlBT1Kt8tBNlqo0Kv7Z4E5/Aq6mECX5NwVAD+Qv2mjUwK5g7O2wsw
 Srf2BtM5mwdQzw1oefp94T/HgbgykFvJmTke0hBF2X3+5Nkomwjx7k7QBPqG31NZyztv0x3YM
 9OuGARnESgSchHRarxKnEEpWhEbg6E5rIFIY+Jw2wApIAKzvuSEsDXQP04dl7meNB/SBw+p+o
 XNFxR3BZsYlTHWHMp5CgMQbGROv851fPNW6aWNLy+ci7t/7+WDKIwhKA3kgAfj7g7qdVgG7lX
 xjnVOZCF8+NJnlZGypJngtDNCtE9ijdg2gtMyBss4VgLEHuRkYP3J96CIreODJfoJoLafWNX/
 2W1APKgrjBS3R+BbLcJBq4XnNj9+c8Fadt6WSqOi1loYUcJFp4Sa4RpkarLckgtZWV0q3BNNC
 5NFL4mTZhND4yJHBAvXyQTSmDXI3FOYX5uachZr9exY+8t/Nnc6n/fFBiJDfHjztXxfhtVfGr
 VnbVwgk7Hc/CkiMNSt1QDqMjSnGZlN//zjcw47L9vylroJQSpvLmTEaHopp4s8foipvk6NdHq
 Ib8zFzvbNXsl1jkOvuTqyR/hPLBzUul6y4B2LJxoqh3ovWe1cpqL6hrN2Q3qwIeMNEMGoYVbd
 vWG3LzYV79kxSn+QR+s2jbtfcgfzjxYl1ogWVSaQ060wntaFzNZh8kpTd2bUFL+9QRr17N8fp
 fQs+ta6VZrpGfjUgdpEq9EYk0fhzkrMQf+3x6wSdx9gkukw0dVZtDgJ68WHyDqaryS52SVp+k
 +I8/AVXwfBbloAwB7xuRZG03N/+VA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check memory allocation result for cachetag in mount option
parsing and fix potential memory leak in the error case.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/9p/v9fs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 8fb89dd..e622f0f 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -292,6 +292,10 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 #ifdef CONFIG_9P_FSCACHE
 			kfree(v9ses->cachetag);
 			v9ses->cachetag = match_strdup(&args[0]);
+			if (!v9ses->cachetag) {
+				ret = -ENOMEM;
+				goto free_and_return;
+			}
 #endif
 			break;
 		case Opt_cache:
@@ -471,6 +475,9 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 	return fid;
 
 err_clnt:
+#ifdef CONFIG_9P_FSCACHE
+	kfree(v9ses->cachetag);
+#endif
 	p9_client_destroy(v9ses->clnt);
 err_names:
 	kfree(v9ses->uname);
-- 
1.8.3.1
