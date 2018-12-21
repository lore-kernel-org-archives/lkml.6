Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB647C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A732218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lOQCdo4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbeLUJKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:10:25 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34046 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeLUJKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:10:25 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBL992Mu012038;
        Fri, 21 Dec 2018 09:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=6QR3OMsY+mjwpsxcwVIxcSsY32wkGGxmahDt87x/VhQ=;
 b=lOQCdo4CYNQYKzCJE7ddJ7NFHgvpkpU5IjECXH1RvzouPNxoJvO2GnWkv3dYIta0rHGz
 Q3Fs3xklX1DDAi6ZOpOBEx/Nubbc+cM1TJ1RxQhjA/ZUvZTd0Uxf5nvuDBYBEHYyURhd
 qJJknQSzEH9tqvTgRb4KVvPu/1G7vE6L71kVZ2DdRsl4aTPfmXObHLAebuNJ733eGhG7
 Wni1tXkXq2BnHgIvILRO5aAzN0Bt2oFwFgUcAfGeVwtKVmpd/LBYkXIYkDTKLfFZR5sP
 RKygjaJZgR5TVYypAk94sSzGO+H4bTtVfappQwBd3hcfPADG3JwOMCVxHoZ17D6DE+KW nw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pf8gfn1dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 09:10:11 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBL9AAwt003258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 09:10:10 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBL9A82V010799;
        Fri, 21 Dec 2018 09:10:09 GMT
Received: from kadam (/197.157.0.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Dec 2018 01:10:08 -0800
Date:   Fri, 21 Dec 2018 12:09:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] smack: Fix a memory leak in smack_add_opt()
Message-ID: <20181221090958.GE2735@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9113 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=633
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812210074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is leaking "opts" on the error paths.

Fixes: 90e3b564ab93 ("smack: take the guts of smack_parse_opts_str() into a new helper")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 security/smack/smack_lsm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2adafc1018d9..4e9cdb942677 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -604,13 +604,13 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
 {
 	struct smack_mnt_opts *opts = *mnt_opts;
 
+	if (!s)
+		return -ENOMEM;
 	if (!opts) {
 		opts = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
 		if (!opts)
 			return -ENOMEM;
 	}
-	if (!s)
-		return -ENOMEM;
 
 	switch (token) {
 	case Opt_fsdefault:
@@ -643,6 +643,8 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
 	return 0;
 
 out_opt_err:
+	if (opts != *mnt_opts)
+		kfree(opts);
 	pr_warn("Smack: duplicate mount options\n");
 	return -EINVAL;
 }
-- 
2.17.1

