Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeECJpk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:45:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:52023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbeECJpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:45:32 -0400
From: Chengguang Xu <cgxu519@gmx.com>
To: akpm@linux-foundation.org, ericvh@gmail.com, rminnich@sandia.gov,
        lucho@ionkov.net
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [V9fs-developer][PATCH v3 2/2] fs/9p: detecting invalid options as much as possible
Date: Thu,  3 May 2018 17:44:36 +0800
Message-Id: <1525340676-34072-2-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525340676-34072-1-git-send-email-cgxu519@gmx.com>
References: <1525340676-34072-1-git-send-email-cgxu519@gmx.com>
X-Provags-ID: V03:K1:Kbp36WcdSVRXZf1r7dKpijA8VjF61OLAGRu64XEExjwwyGJjLJB
 LmDs6u28fCfbwqwsCXJwtGC+j+xHXOXKOX0YQEPxQ4nXO9MgzHz5DHqaRMIz/OufvX3c4d3
 HmRjeDZpMylwf57D/wA1e0mruutWow7tKp8U6ILrdAo6tDuxT1BmN9SCOO565JkgLlh52/m
 1l1i8ce2GAMkrDzmrbSqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vhlUq6m6WZc=:dAjLnfvm3k6eS+ev/YLtP3
 GDZxB9pskiJT9ssAGIJJEKWr01kCmNNT3fbNhYuhllOM9JWVn0U8qw2dvrcGCn4VRzfmXopNk
 It9ND2BsXgd5HzzxWjvFSb/MT7tIhKSezC2nHgi11xYfP7r6UP8wR31pkuGBlqTdqLq1F3txC
 N0562nQTPFQKez3u+tpY/CKxavjDt+0yPSX0PcBN2tTmkRUoBjLBROZXo9G6YT6drotmHNSR+
 l/TPzCucbhX66uQHqsSvc5rKxCaGYuMqJvEGlL+fTRcis3phi377bF3jDdRdhT362I/9l0bU0
 lE9KQsTCxfDuipjHT6PJc8Wyjia/cCaK/UHZHp6Nx6WEfdYWy/KIUwlmdHhZlnhftejyrqm2L
 wF9PFoYzdTykIxvHoZJYpVvsmLIUDOSgrXJleGWy/7pV637K6dp9B3uSiPVMP5sJwDfamp2qV
 E/jK8rWJ9Dn2mXSICKu5sLhOzMk+hQuI55k0J9mb7iOnRPJW0QVn2IvX6iPM9HCs0lWG/q7sz
 RSu4fa9emhsxnIyUS6nhaPc7O7Zru39MeC7ynrf18kKV6oVlKzZHCo9oc5mJREH9E6o/Z3KbW
 AVtRyEQaudgnaKyAkEup84g7Gr2En4mYKFzDxuIwem4AukI4cdpgdOqZRKgjmQAh0eG53vYQc
 2l3cugknLTvmFnBXPuGIDllb/5ElEtaEgG05mnGclfrrKtNLfV8nflJPVBijO3QBFbs1wqx2P
 BJ0gEusv0YLZSZJ9J8RYdHa8Z6YEzWydg2+BLcKJLxn3Mm9EWqalZz+cvA4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when detecting invalid options in option parsing,
some options(e.g. msize) just set errno and allow to continuously
validate other options so that it can detect invalid options
as much as possible and give proper error messages together.

This patch applies same rule to option 'cache' and 'access'
when detecting -EINVAL.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
Changes since v2:
- Introduce a new temporary variable to avoid overriding error code.
- Delete redundant continue in error case.

Changes since v1:
- Do not change behavior when detecting ENOMEM or unrecognized options. 

 fs/9p/v9fs.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index e622f0f..0429c8e 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -210,12 +210,12 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 				p9_debug(P9_DEBUG_ERROR,
 					 "integer field, but no integer?\n");
 				ret = r;
-				continue;
-			}
-			v9ses->debug = option;
+			} else {
+				v9ses->debug = option;
 #ifdef CONFIG_NET_9P_DEBUG
-			p9_debug_level = option;
+				p9_debug_level = option;
 #endif
+			}
 			break;
 
 		case Opt_dfltuid:
@@ -231,7 +231,6 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 				p9_debug(P9_DEBUG_ERROR,
 					 "uid field, but not a uid?\n");
 				ret = -EINVAL;
-				continue;
 			}
 			break;
 		case Opt_dfltgid:
@@ -247,7 +246,6 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 				p9_debug(P9_DEBUG_ERROR,
 					 "gid field, but not a gid?\n");
 				ret = -EINVAL;
-				continue;
 			}
 			break;
 		case Opt_afid:
@@ -256,9 +254,9 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 				p9_debug(P9_DEBUG_ERROR,
 					 "integer field, but no integer?\n");
 				ret = r;
-				continue;
+			} else {
+				v9ses->afid = option;
 			}
-			v9ses->afid = option;
 			break;
 		case Opt_uname:
 			kfree(v9ses->uname);
@@ -306,13 +304,12 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 					 "problem allocating copy of cache arg\n");
 				goto free_and_return;
 			}
-			ret = get_cache_mode(s);
-			if (ret == -EINVAL) {
-				kfree(s);
-				goto free_and_return;
-			}
+			r = get_cache_mode(s);
+			if (r < 0)
+				ret = r;
+			else
+				v9ses->cache = r;
 
-			v9ses->cache = ret;
 			kfree(s);
 			break;
 
@@ -341,14 +338,12 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
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
-					kfree(s);
-					goto free_and_return;
 				}
 			}
 
-- 
1.8.3.1
