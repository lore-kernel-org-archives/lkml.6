Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeDNMT1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 08:19:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:42481 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750883AbeDNMTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 08:19:25 -0400
From: Chengguang Xu <cgxu519@gmx.com>
To: ooo@electrozaur.com
Cc: linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] exofs: fix potential memory leak in mount option parsing
Date: Sat, 14 Apr 2018 20:19:08 +0800
Message-Id: <1523708348-683-1-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:/jlOD7RWLsFf0yuRpYqlxx9UCvVwx2n4dkU3O2/4EzrroSFyFTP
 7q7Gnw2X03XKRTsUfK09yO4ys3390D9Xl97Y4G0GFqx2hRGJkWXATF6dCEXxN/lTQNZWKUn
 MJuSiOEMKAm1YDZZ5LdsqHTro7X5/UKsfIwc2fo1gO7lFsb/CjTanah2dCVCIoolf/fQ9OA
 5MVXsG34DVtXN8uJuKtVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:okHqiABKilc=:a3LQdyDfOBgCi/pBxZBTBU
 Tgci1JzASmPqYxYnzCUmYTdg9L6E6h0hiv6jXbYLCFGkyM0bK0nvLYOmB0rpHIdA6IEk++tPI
 ED+D9kWTnwcLFdQtByjDBDCDP3X8SrXSXNgw45ytOCSXUhePUp2X+ZSWUlkpKivehOe2mEYw9
 k476D0JBpRfnY0xtZ6iuDRJPWLmQ5fV8ELWRwNEJ9NdMAX2mH/UVhVZhQUaj84tkwBzbc9YE5
 evDNdhl2Cqu0aI0/arjYmu2tJjh+5t67dmNraiGidiA2TVuV8CNfVqy3WSs+H6PIYrcugSaPM
 2fRbXEk5LwtSefh4V1d427haMjer4aiQELyYObxhIWl3Wt7wyugI2WXaH8FEpiJ8qVymLDy4y
 kMesFcgp+Bd/9D5LkvaXzvpzAZcxivVKFolPEttDZKfEB1N+bQa3K5cvZzfG+RdjNo4gfDUcC
 FrWiCQXVRLaD6amR85rwragWLBffDMLTwAlMfIZJutfwhwU9sucse9tNeRtyP/u3CUMoaGGQ3
 kH4SV4yuX0icMuRNQIiSuEdivtwQwfa7xpnRCBx2fss/PHG7IqaJSoLahF/x/VOUdPGK1VyOH
 uPEfAYvQZRdp48MMrq7jAwmQrpbD8ewmdwSX37OAORm78N2kv+Hiqm7qdu47EfTCdVvIYZP6s
 UnIO3LyUENkNDxW2jy2+SMtjAHskVklEOoCfCaicaLv7WlHics+BqYsynCSgd0pcp9+mhOKlP
 tipkNvIiCF91p/JlkOXYNl3In51un82Fb4RtU5iAwXhm1epMPdtigrAAzMOJyOahNQuGuF/bh
 C6EltcY91Y1+PTvMF+pbuciakrQ9w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When specifying string type mount option several times
in a mount, current option parsing may cause memory leak.
Hence, call kfree for previous one in this case.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/exofs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exofs/super.c b/fs/exofs/super.c
index 179cd5c..106b818 100644
--- a/fs/exofs/super.c
+++ b/fs/exofs/super.c
@@ -101,6 +101,7 @@ static int parse_options(char *options, struct exofs_mountopt *opts)
 		token = match_token(p, tokens, args);
 		switch (token) {
 		case Opt_name:
+			kfree(opts->dev_name);
 			opts->dev_name = match_strdup(&args[0]);
 			if (unlikely(!opts->dev_name)) {
 				EXOFS_ERR("Error allocating dev_name");
-- 
1.8.3.1
