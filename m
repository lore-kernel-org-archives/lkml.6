Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbeDPHtI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 03:49:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:44045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753299AbeDPHtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 03:49:06 -0400
From: Chengguang Xu <cgxu519@gmx.com>
To: ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 2/2] fs/9p: detecting invalid options as much as possible
Date: Mon, 16 Apr 2018 15:48:29 +0800
Message-Id: <1523864909-4337-2-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523864909-4337-1-git-send-email-cgxu519@gmx.com>
References: <1523864909-4337-1-git-send-email-cgxu519@gmx.com>
X-Provags-ID: V03:K1:4E3qBia6Z85szOg6SZU1D63mSQ93nEgy5h6qrUzgr0kACBajSie
 UliZZOpUHDLImAPh/wYr4KiA180FQeS+ygXWfd6sajxZ+Bn75QfIccwjX7wfzVPAyJwJ3CX
 wzX0aR685e1RtWekFXIA5pjTjktiMvFmV0NHtfx5Vt9SaLP/4jHVlAEzbqGJqOU0tgqYWtc
 V4YOzbb44XarmT8xIihoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k/wUnz9Se1s=:um2uhtqJPA0egRhBsEvhqp
 5caA02hwF5Ph63u+HnOp64dvN0G2WcUF7CfGAoQjurtbkti/ZQLHit8OE/nI9rEVONuLw3IDH
 jVQfiXTNpclultKh8ezKdhYhIJCMtkI2sNgTHNiknonjtuNuNj+rhMGcMroG+tt1aQSq9e82r
 AuXVzoo9uhDxWJUX5Mof81MZbovcyZMCtqfahIQ7IRVeU+IoxlxuoKs7cDaF/ki/Ko3rCExFe
 WXfeD6mSGKuSao4WnvkXrBbl70ADBbpz9DIqsrCGMsZxJ1gizrR59B5LzyzJRO+VJbduuorTz
 m3CAhlzw9R58CgN5INrBeyXJi2arDldlqIiwEKL29TecUJCdazFhs/411VXF1j2gUQbs77ahe
 XoqrTKYXMbbyMrzTrTecJnnOE07Gsk6mr0t33K0nyBzP6HBqyIxFRaJygmjfScdfZYsgjc3ek
 CbDF0nP8f1RMuA+qXVqxwdKu85X8eoL5Mq3gdfFxzWDunfbm/Eo41cUaKybI0Tu/Rl1qHEUUv
 K2hqKC394N+1WVwJfMsXWdZxhMKYEkXmq0soHJNVVW+otqds4rNQ8accKNpPfc4ATvLtu7a7z
 qi82tRK0/7gi+eLyNpZOohSalbc36moRugkq1CpjmPYVwlcNHkoSYUOdiYRZJi0WmqFKZors8
 bPjv89dhOBHMy+FDEXjpsJ1A4UTWTOBMTADMcEPauLUEQw7acC5X6z1PLwDUy1tlXO0p+E2AY
 kxs4Iexi/04U3bZcnC/PyysQcXKBgezUgBiUz3CkSXEYu7cZm9fiJjgYvet6cwSrqFKoQJmrr
 89B6tYdL80jS4TOcYzKPv4xko2DbA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when detecting invalid options in option parsing,
some options(e.g. debug) just set errno and allow to continusly
validate other options so that it can detect invalid options
as much as possible and give proper error messages together.

This patch apply this policy to all options and the case of memory
allocation error in option parsing.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/9p/v9fs.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index e622f0f..29ba937 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -192,10 +192,9 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 		return 0;
 
 	tmp_options = kstrdup(opts, GFP_KERNEL);
-	if (!tmp_options) {
-		ret = -ENOMEM;
-		goto fail_option_alloc;
-	}
+	if (!tmp_options)
+		return -ENOMEM;
+
 	options = tmp_options;
 
 	while ((p = strsep(&options, ",")) != NULL) {
@@ -263,18 +262,16 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 		case Opt_uname:
 			kfree(v9ses->uname);
 			v9ses->uname = match_strdup(&args[0]);
-			if (!v9ses->uname) {
-				ret = -ENOMEM;
-				goto free_and_return;
-			}
+			if (!v9ses->uname)
+				if (!ret)
+					ret = -ENOMEM;
 			break;
 		case Opt_remotename:
 			kfree(v9ses->aname);
 			v9ses->aname = match_strdup(&args[0]);
-			if (!v9ses->aname) {
-				ret = -ENOMEM;
-				goto free_and_return;
-			}
+			if (!v9ses->aname)
+				if (!ret)
+					ret = -ENOMEM;
 			break;
 		case Opt_nodevmap:
 			v9ses->nodev = 1;
@@ -292,24 +289,24 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 #ifdef CONFIG_9P_FSCACHE
 			kfree(v9ses->cachetag);
 			v9ses->cachetag = match_strdup(&args[0]);
-			if (!v9ses->cachetag) {
-				ret = -ENOMEM;
-				goto free_and_return;
-			}
+			if (!v9ses->cachetag)
+				if (!ret)
+					ret = -ENOMEM;
 #endif
 			break;
 		case Opt_cache:
 			s = match_strdup(&args[0]);
 			if (!s) {
-				ret = -ENOMEM;
+				if (!ret)
+					ret = -ENOMEM;
 				p9_debug(P9_DEBUG_ERROR,
 					 "problem allocating copy of cache arg\n");
-				goto free_and_return;
+				continue;
 			}
 			ret = get_cache_mode(s);
 			if (ret == -EINVAL) {
 				kfree(s);
-				goto free_and_return;
+				continue;
 			}
 
 			v9ses->cache = ret;
@@ -319,10 +316,11 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 		case Opt_access:
 			s = match_strdup(&args[0]);
 			if (!s) {
-				ret = -ENOMEM;
+				if (!ret)
+					ret = -ENOMEM;
 				p9_debug(P9_DEBUG_ERROR,
 					 "problem allocating copy of access arg\n");
-				goto free_and_return;
+				continue;
 			}
 
 			v9ses->flags &= ~V9FS_ACCESS_MASK;
@@ -341,14 +339,14 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 					pr_info("Unknown access argument %s\n",
 						s);
 					kfree(s);
-					goto free_and_return;
+					continue;
 				}
 				v9ses->uid = make_kuid(current_user_ns(), uid);
 				if (!uid_valid(v9ses->uid)) {
 					ret = -EINVAL;
 					pr_info("Uknown uid %s\n", s);
 					kfree(s);
-					goto free_and_return;
+					continue;
 				}
 			}
 
@@ -365,13 +363,14 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 			break;
 
 		default:
+			p9_debug(P9_DEBUG_ERROR,
+				"unrecognized mount option \"%s\" or missing value\n",
+					p);
 			continue;
 		}
 	}
 
-free_and_return:
 	kfree(tmp_options);
-fail_option_alloc:
 	return ret;
 }
 
-- 
1.8.3.1
