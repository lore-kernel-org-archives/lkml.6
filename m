Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeDQGqa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 02:46:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:54217 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbeDQGq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 02:46:28 -0400
From: Chengguang Xu <cgxu519@gmx.com>
To: ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [V9fs-developer][PATCH v2 2/2] fs/9p: detecting invalid options as much as possible
Date: Tue, 17 Apr 2018 14:45:02 +0800
Message-Id: <1523947502-6103-2-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523947502-6103-1-git-send-email-cgxu519@gmx.com>
References: <1523947502-6103-1-git-send-email-cgxu519@gmx.com>
X-Provags-ID: V03:K1:kk5Hsk+f/wxwV5eBgyPqAxvgnSWN+sN31LYcddfp6MElhODz1l2
 nY13khAqB8XCwUjVjhfnzPUwmOS4qsube2ho/xFrLtL1yLGKrWXyyhQkeGKZ7wG5uLab+be
 CbGYIeBhB4pzTrHwL/5L6OqJoPKyLxSQMh43sQDzf5ajM77JM1+3QBcKtKrwngS3ii41YJc
 6mRL4MfJFSuKcsmqd9w8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S6u/kWvtgvs=:L913qFNmDXcAZjYCkVrnjP
 ADdxBT2XxWUMxT9BTJVbkeMNKzJVEClHzAW4Lby2tR8JXSjs3/fzrAm3jOFd9aNCdr8mWW9DQ
 vsokdDE+q7nInTmAcn+xoFvBRH+5ieoKcWENGKqcSYPZgFhvxvdjG4D6GNdR/pKc9/XH4mGvJ
 BPA0G951Jbyd1I4XJOXOjxAPt1TeFuh1u/MIEHXHlEwLN0osEQHJHTOnxPGRFTEk0E9k2XZHN
 g+tVSwnuS2syNzG0ecKhmpQ3ZYf0al74vwXRQ43THfNXu5ruxSKoflaTQpfz9uLID/bPAQZ3U
 dIQKQd5ihycOvkViFmHixbxw2XP6uAfnptfD0r3gjGDXTvuluIbxW6WEOmC24iv68KR0Ufmba
 DAdJrUd/x2Hmv5TGYn7t057X1yXNir0kUBACxg8zYqbmk38TvKqs9h8YCtslmub6EIbxbEzgD
 OX3KCxmddgle7wItEOPOuK2AjCrthRQ14NvU/voVVL63ipKkVf+h3JOZAQD6l2mWeNfwVDPN1
 b1vycpA0+e0zrQaJxIOU+8B2v2btibea2wuUm3ypeB0JPERdRQOF6i4m70p/jziq18sVjd7hC
 UrI4g0pI7ZV7jmXNRSGVCAvDWHCit7HnY9Nno3FNdZ1xDu5V2it81DIKzpKMmUHffIhrwHHPB
 /XdDM0ANCZajI2ojKbnB1AUPlXfbyxWVgj8/7sKQEvfXpMt3Nmq3nQ1NJu/d1YRgQkpKWAUBi
 mQFShHmfohVjYHNVoxo3rwYymF4RQfABAsvCVJos5hi6BACWxHBfWDixeIqiyvbCbfncPQozp
 Kjx+1wwZjwApt+yLzM5GykI83It5w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when detecting invalid options in option parsing,
some options(e.g. msize) just set errno and allow to continuously
validate other options so that it can detect invalid options
as much as possible and give proper error messages together.

This patch applies same rule to option 'cache' and 'access'
when detecting EINVAL.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
Changes since v1:
- Do not change behavior when detecting ENOMEM or unrecognized options. 

 fs/9p/v9fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index e622f0f..2c7a0ef 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -309,7 +309,7 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 			ret = get_cache_mode(s);
 			if (ret == -EINVAL) {
 				kfree(s);
-				goto free_and_return;
+				continue;
 			}
 
 			v9ses->cache = ret;
@@ -341,14 +341,14 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
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
 
-- 
1.8.3.1
