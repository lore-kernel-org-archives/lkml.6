Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751052AbeEIMXJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:23:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55105 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbeEIMXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:23:07 -0400
From: Colin King <colin.king@canonical.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S . Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: nf_tables: fix memory leak on error exit return
Date: Wed,  9 May 2018 13:22:56 +0100
Message-Id: <20180509122256.16859-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the -EBUSY error return path is not free'ing resources
allocated earlier, leaving a memory leak. Fix this by exiting via the
error exit label err5 that performs the necessary resource clean
up.

Detected by CoverityScan, CID#1432975 ("Resource leak")

Fixes: 9744a6fcefcb ("netfilter: nf_tables: check if same extensions are set when adding elements")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/netfilter/nf_tables_api.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 6422eba367cf..a3d77aa0f752 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4098,8 +4098,10 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA) ^
 			    nft_set_ext_exists(ext2, NFT_SET_EXT_DATA) ||
 			    nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF) ^
-			    nft_set_ext_exists(ext2, NFT_SET_EXT_OBJREF))
-				return -EBUSY;
+			    nft_set_ext_exists(ext2, NFT_SET_EXT_OBJREF)) {
+				err = -EBUSY;
+				goto err5;
+			}
 			if ((nft_set_ext_exists(ext, NFT_SET_EXT_DATA) &&
 			     nft_set_ext_exists(ext2, NFT_SET_EXT_DATA) &&
 			     memcmp(nft_set_ext_data(ext),
-- 
2.17.0
