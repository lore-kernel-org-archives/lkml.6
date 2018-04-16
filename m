Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeDPHtG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 03:49:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:56245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752952AbeDPHtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 03:49:05 -0400
From: Chengguang Xu <cgxu519@gmx.com>
To: ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 1/2] net/9p: detecting invalid options as much as possible
Date: Mon, 16 Apr 2018 15:48:28 +0800
Message-Id: <1523864909-4337-1-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:xCnl0/ii3Gf/nkzjeFxGu1P4CKxb3ZLXxx6DmZFYiSHRJ0BpjTL
 kvFxRSG5iSz5C4cEFTdPWg9B6R2trYRD8kLGGi2yUOd90cP+b2Z1Vc6Lb5+Z64L+v/DYpWU
 dq83nF4hW7SIsb0w+T2HDh6EjLIcNOPmldDA5nCoBUp3wEyol4BUL4n23fj+WUjdKiaQyD5
 i93ohJ7aE6qRlqmQHR3PQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r//izYjWjS4=:9DK6hbTlBHXAWNvTAQv3wZ
 n+/j8IoDbiDnxGJ2LeU4rixVVNNcSxjF3Semk+nlV0ZtpJZASUQC0vq1lbXU92HJtRrnbL9QP
 COffajtxjpzA/swMRxqA1RNiaBfqAgnQydetNIEG8tLuk73dsHl4uLvywKGlHu6Lc/19mYO+1
 Tmv8C6USt3TQP9jkMyeXGfgMFI5tabAsYoaucm3B8UQm01OMPgcn3gaZdEBtjfMG/QEJ3Fg6W
 qWIm4y485PaWY6bQk3X68tfq7KPOSOW07bdAKYKf8UKPjzHsZX7457hyU7sWyu0d3GhvtG2Ug
 UgxGpkhPWFk3UuXPksGa0LxoRF2v1UdscEXuFO+xMnybTiVzaIsm0ATHOQZjdL+lVg1a5ftR5
 VP4EnfctihdrQWBHGZ+sZxQjJCJaLKDM29E9tQCXuGEIb1h9d0z72yv2MzOexdLDcxDQFJqcU
 cewTpy7NMeaSn8W8ysX3AEppmwjA6hqobKw8HgrNGByhtVuIvM+KmSeGOILnPbpzth/3HhXjI
 X+t8S8zEmOHhnCD18VP6HKQBgsy3BJ2IC2wUypeuk5zqM8OrYJZ6/dMRwIsVg/DrxVVQUuQ/c
 tIJZWqY6Ge8F6hrrreH3P5AjGe1uJ0/FdU1MnU4lgtm/cZTF0lIdMTnCvF8HuGRvQs7cWHCI/
 BT/ic6G9g6QcG0wXyvXKkbRWC/SB0nNZ4W7KAEIserAxfRbooQ2ADIz9Vrb6cfVuEcbkzb4Mk
 q11Agwg/fG25KgAfw338syt6F5HcK271YtrM2lJH77lDAKI2KRVlMUpti9tF1C7cRPf1K9XEA
 yyOFHqlPB2nnEJPS837ILYI8yyisw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when detecting invalid options in option parsing,
some options(e.g. msize) just set errno and allow to continusly
validate other options so that it can detect invalid options
as much as possible and give proper error messages together.

This patch apply this policy to all options and the case of memory
allocation error in option parsing.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 net/9p/client.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 21e6df1..066f136 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -186,10 +186,11 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 		case Opt_trans:
 			s = match_strdup(&args[0]);
 			if (!s) {
-				ret = -ENOMEM;
+				if (!ret)
+					ret = -ENOMEM;
 				p9_debug(P9_DEBUG_ERROR,
 					 "problem allocating copy of trans arg\n");
-				goto free_and_return;
+				continue;
 			}
 
 			v9fs_put_trans(clnt->trans_mod);
@@ -199,7 +200,7 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 					s);
 				ret = -EINVAL;
 				kfree(s);
-				goto free_and_return;
+				continue;
 			}
 			kfree(s);
 			break;
@@ -209,25 +210,28 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 		case Opt_version:
 			s = match_strdup(&args[0]);
 			if (!s) {
-				ret = -ENOMEM;
+				if (!ret)
+					ret = -ENOMEM;
 				p9_debug(P9_DEBUG_ERROR,
 					 "problem allocating copy of version arg\n");
-				goto free_and_return;
+				continue;
 			}
 			ret = get_protocol_version(s);
 			if (ret == -EINVAL) {
 				kfree(s);
-				goto free_and_return;
+				continue;
 			}
 			kfree(s);
 			clnt->proto_version = ret;
 			break;
 		default:
+			p9_debug(P9_DEBUG_ERROR,
+				 "unrecognized option \"%s\" or missing value\n",
+					p);
 			continue;
 		}
 	}
 
-free_and_return:
 	v9fs_put_trans(clnt->trans_mod);
 	kfree(tmp_options);
 	return ret;
-- 
1.8.3.1
