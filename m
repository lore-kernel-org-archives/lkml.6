Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeDQGq3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 02:46:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:41359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbeDQGq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 02:46:28 -0400
From: Chengguang Xu <cgxu519@gmx.com>
To: ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [V9fs-developer][PATCH v2 1/2] net/9p: detecting invalid options as much as possible
Date: Tue, 17 Apr 2018 14:45:01 +0800
Message-Id: <1523947502-6103-1-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:91hXpPINVW/K4BPfhQj696ffX2RXy9Ppc586SyUgUhCme9ri47Z
 tNRHyGBH/9qmD7d7AeW9TZDZPWAm7dG4nrC4lYsx1Bsu2+Q8KrDRwdIYZFLecxuDLgRDKbh
 pNaUE/ATFYxNdbz4TS3km77Oj0HSrILTR1lqUTd410qKhJeSfyemKL5j0GXSPxqht9bHwR2
 5tTBJhKP7xg/P/XFwzvuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G6XMO349ftE=:eQ7aGIcEbFCyS7NQ/bSNue
 YgqgJCrWQ3wjgjbE8NNLoijVYOBZqBA9qS+zcOaxMYh+Axiu2C9ZimFLqqYYR2H5i6vvM8+ZD
 yo2uD5RRctg/gciA8rcGWANGR4OPlH801ZCxne+pXdHk0G4QMGHEqNKPLnivhtbqjAnQu+Wqw
 SxzGqEWDo4eJLcLSBgvt5ahDhW2fXbMM0fG7oy1xS1i4cbLwaCWUkNx/fy/z9dEyJPv72t3zU
 uYR9nqHOBgfXAwqQStb3D19dcMGcZHr9lLjHXUFfgLHD0m6fS4NKzWrJnCpTsFso/lU+Ms/Rl
 +WcqL54IZIVHEMfYRbODobQVJGqIR5jC7Cx7QRaO5rs/eZakjOC8GOpHPrhdG5nqVotxPb2Kv
 QAGxVeHzpcdkEb6YOzyZXwNDpReirn3AeQHEo6JJr4VEdJkU9eIcDDpN5g3uOz6NWzaPiwhjn
 FtG5zEiwKum36TLdzL99q3LnHBXE0n31TLPGc+JYS3CVpreMgwBA2kFfkEKcD1symGV1zbAfx
 v1+AwPsya0o6eF2LZlk5KvMT1wTsgmptdBWLbHTODHmQ4NM0DoyDCq5znehivifLDnMr4r94/
 WZy4KutA4R5Zk5DtWctAkTjoxdgiVOp6kX11G+600LDTRKSXDW8xjiJyDOlSFqmGIcxxlCWgg
 2QbN4T8D10v8YkOaZQLX5RcNuUaiqfQRlDVBQsNGhyEb4nk35SiN7iGcEKFySZb+4F1Z49Vfi
 5hSQL74qLhZB76bM3KhZIAUY6uTvdmwaAM5vI8dTrRCc74fvFeX15bsExk1pDKNDBuBnlwA4N
 Q+CXa3M7DCgsGwGGSfSSE2bKafC1g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when detecting invalid options in option parsing,
some options(e.g. msize) just set errno and allow to continuously
validate other options so that it can detect invalid options
as much as possible and give proper error messages together.

This patch applies same rule to option 'trans' and 'version'
when detecting EINVAL.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
Changes since v1:
- Do not change behavior when detecting ENOMEM or unrecognized options.

 net/9p/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 21e6df1..38b02fb 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -199,7 +199,7 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 					s);
 				ret = -EINVAL;
 				kfree(s);
-				goto free_and_return;
+				continue;
 			}
 			kfree(s);
 			break;
@@ -217,7 +217,7 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 			ret = get_protocol_version(s);
 			if (ret == -EINVAL) {
 				kfree(s);
-				goto free_and_return;
+				continue;
 			}
 			kfree(s);
 			clnt->proto_version = ret;
-- 
1.8.3.1
