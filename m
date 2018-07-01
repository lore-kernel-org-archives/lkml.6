Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E918DC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECDA24F83
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECDA24F83
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeGAQLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:11:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59690 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbeGAQLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:11:21 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 973B2AD8;
        Sun,  1 Jul 2018 16:11:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Easton <kevin@guarana.org>,
        syzbot+5022a34ca5a3d49b84223653fab632dfb7b4cf37@syzkaller.appspotmail.com,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 3.18 03/85] af_key: Always verify length of provided sadb_key
Date:   Sun,  1 Jul 2018 18:01:21 +0200
Message-Id: <20180701153122.502054724@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kevin Easton <kevin@guarana.org>

commit 4b66af2d6356a00e94bcdea3e7fea324e8b5c6f4 upstream.

Key extensions (struct sadb_key) include a user-specified number of key
bits.  The kernel uses that number to determine how much key data to copy
out of the message in pfkey_msg2xfrm_state().

The length of the sadb_key message must be verified to be long enough,
even in the case of SADB_X_AALG_NULL.  Furthermore, the sadb_key_len value
must be long enough to include both the key data and the struct sadb_key
itself.

Introduce a helper function verify_key_len(), and call it from
parse_exthdrs() where other exthdr types are similarly checked for
correctness.

Signed-off-by: Kevin Easton <kevin@guarana.org>
Reported-by: syzbot+5022a34ca5a3d49b84223653fab632dfb7b4cf37@syzkaller.appspotmail.com
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/key/af_key.c |   45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -437,6 +437,24 @@ static int verify_address_len(const void
 	return 0;
 }
 
+static inline int sadb_key_len(const struct sadb_key *key)
+{
+	int key_bytes = DIV_ROUND_UP(key->sadb_key_bits, 8);
+
+	return DIV_ROUND_UP(sizeof(struct sadb_key) + key_bytes,
+			    sizeof(uint64_t));
+}
+
+static int verify_key_len(const void *p)
+{
+	const struct sadb_key *key = p;
+
+	if (sadb_key_len(key) > key->sadb_key_len)
+		return -EINVAL;
+
+	return 0;
+}
+
 static inline int pfkey_sec_ctx_len(const struct sadb_x_sec_ctx *sec_ctx)
 {
 	return DIV_ROUND_UP(sizeof(struct sadb_x_sec_ctx) +
@@ -533,16 +551,25 @@ static int parse_exthdrs(struct sk_buff
 				return -EINVAL;
 			if (ext_hdrs[ext_type-1] != NULL)
 				return -EINVAL;
-			if (ext_type == SADB_EXT_ADDRESS_SRC ||
-			    ext_type == SADB_EXT_ADDRESS_DST ||
-			    ext_type == SADB_EXT_ADDRESS_PROXY ||
-			    ext_type == SADB_X_EXT_NAT_T_OA) {
+			switch (ext_type) {
+			case SADB_EXT_ADDRESS_SRC:
+			case SADB_EXT_ADDRESS_DST:
+			case SADB_EXT_ADDRESS_PROXY:
+			case SADB_X_EXT_NAT_T_OA:
 				if (verify_address_len(p))
 					return -EINVAL;
-			}
-			if (ext_type == SADB_X_EXT_SEC_CTX) {
+				break;
+			case SADB_X_EXT_SEC_CTX:
 				if (verify_sec_ctx_len(p))
 					return -EINVAL;
+				break;
+			case SADB_EXT_KEY_AUTH:
+			case SADB_EXT_KEY_ENCRYPT:
+				if (verify_key_len(p))
+					return -EINVAL;
+				break;
+			default:
+				break;
 			}
 			ext_hdrs[ext_type-1] = (void *) p;
 		}
@@ -1111,14 +1138,12 @@ static struct xfrm_state * pfkey_msg2xfr
 	key = ext_hdrs[SADB_EXT_KEY_AUTH - 1];
 	if (key != NULL &&
 	    sa->sadb_sa_auth != SADB_X_AALG_NULL &&
-	    ((key->sadb_key_bits+7) / 8 == 0 ||
-	     (key->sadb_key_bits+7) / 8 > key->sadb_key_len * sizeof(uint64_t)))
+	    key->sadb_key_bits == 0)
 		return ERR_PTR(-EINVAL);
 	key = ext_hdrs[SADB_EXT_KEY_ENCRYPT-1];
 	if (key != NULL &&
 	    sa->sadb_sa_encrypt != SADB_EALG_NULL &&
-	    ((key->sadb_key_bits+7) / 8 == 0 ||
-	     (key->sadb_key_bits+7) / 8 > key->sadb_key_len * sizeof(uint64_t)))
+	    key->sadb_key_bits == 0)
 		return ERR_PTR(-EINVAL);
 
 	x = xfrm_state_alloc(net);


