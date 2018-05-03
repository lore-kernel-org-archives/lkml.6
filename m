Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeECJpo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:45:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:38779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751160AbeECJp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:45:29 -0400
From: Chengguang Xu <cgxu519@gmx.com>
To: akpm@linux-foundation.org, ericvh@gmail.com, rminnich@sandia.gov,
        lucho@ionkov.net
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [V9fs-developer][PATCH v3 1/2] net/9p: detecting invalid options as much as possible
Date: Thu,  3 May 2018 17:44:35 +0800
Message-Id: <1525340676-34072-1-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:N5FBsrGKC4PMvW6gLQ0PdzTNmWNEQqh5gUegPbtdbfLM9MD0xI/
 O+2mPSrCVRxufT2vQhzXUR2XHFr1Ln6naolUS0b0hI4I1eTWKGfl2uLKF/WCtuUrBMXpJ0r
 +KFoq47LelmKmAZjrfRJv3SEtPtlyu8t0nA44/D9PVxkqsRpJ86jndGMQAxvgaLvHBsW+8o
 aD24Of4WukTXZ+BIq89tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M3uHICW6JVw=:1X+8fFLCljsaTQFB/qNwfb
 UHkzL4BaJ9qL0p1Cdwc7y+0eVrZEoe8kjcD7Kd0XqCY/kGasCIrqNcMD/n7KgegEfb4hANZsr
 ge67s+CqF8y6gbZ082JzYvEZifexkqdrekp/vJAN3VLxgF32EqvLE1thpE2AJ0KDkZVCWvsX2
 URTXPupyftbhzH6IKkiUupnIGDXVb97aEaKzId2tofs9n7cVsOte5NS7kvTGJRdY4E7bjIAyM
 LpftVi4WUUsX/7AClMq7y1hNIp2r0BaWAyUXxinVNZ0yma0m4CIjwVZ552m8I37Jqam5wy2h8
 t5TTqmqvIhlg7YStrh7YQatN0gfP3ftI3tKIFoiuL1UiG9j3vGwLhFnUrjJ43QfcFuDJhuoAv
 OaHE4WOY4NOJ63DmuatTNrZsYg4mbMU0eTrDow6kpHi+YQ2vMMyPQnLRqVaIIF2BNbk7BX5rg
 1dnNfDyFSrgOlinsNv80da18Z9fA914KS0/OljDK8Yl2DZXjQSTzBzTNOXBFG5QvxG/ijEXbf
 Cw5SXKyMeJXQ8eFk86pteStmCcMaUaIXX8FJ5AGutT876IrNt9QTlEh/q/HNpN3nPxQVOXE92
 H8o9pJ6aMy6DgAa1rOF944VdM41DuVFF3Ub0UB7mjRGOlpfjgGXguCXeiFL/62hRt9bP9fXJD
 PZd9hbVi6sSa4YAimGAQt8zomb91kBTwmQo5RzkucM6IHFKfOuaMpY2qCt/+cVRSgzJmfpa5u
 rr55vWxpx3jiPKNh5fgBvjBEp3HJVxrsTiPQFSggnyKceSYTzEUf14OJz8E=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when detecting invalid options in option parsing,
some options(e.g. msize) just set errno and allow to continuously
validate other options so that it can detect invalid options
as much as possible and give proper error messages together.

This patch applies same rule to option 'trans' and 'version'
when detecting -EINVAL.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
Changes since v2:
- Introduce a new temporary variable to avoid overriding error code.

Changes since v1:
- Do not change behavior when detecting ENOMEM or unrecognized options.

 net/9p/client.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 21e6df1..18c5271 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -198,8 +198,6 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 				pr_info("Could not find request transport: %s\n",
 					s);
 				ret = -EINVAL;
-				kfree(s);
-				goto free_and_return;
 			}
 			kfree(s);
 			break;
@@ -214,13 +212,12 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 					 "problem allocating copy of version arg\n");
 				goto free_and_return;
 			}
-			ret = get_protocol_version(s);
-			if (ret == -EINVAL) {
-				kfree(s);
-				goto free_and_return;
-			}
+			r = get_protocol_version(s);
+			if (r < 0)
+				ret = r;
+			else
+				clnt->proto_version = r;
 			kfree(s);
-			clnt->proto_version = ret;
 			break;
 		default:
 			continue;
-- 
1.8.3.1
