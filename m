Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D017DC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86822208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6gcyj6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86822208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966089AbeFNOMl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966052AbeFNOMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:12:37 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FBD6208DA;
        Thu, 14 Jun 2018 14:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985557;
        bh=5Q3S3HiozyMXqrWnQcq6QWNw14Gs1ZraHnTK9s6/e44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6gcyj6sJf3ijm8upJXxRWE+8gmsfQ6UX1RjwIyGmWPBxgFf4fWS8pfYiqyx5E8Ao
         h418P7pHy2OizH/bj5AiRxvvaWH42et3ijsPPt/omZsCzUlTuUhyhHXoAU43KREvAg
         66O/8La+RJ9/pWFR+v0nGFG8SFBpi0fT5SyG6Zug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Easton <kevin@guarana.org>,
        syzbot+5022a34ca5a3d49b84223653fab632dfb7b4cf37@syzkaller.appspotmail.com,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.9 06/30] af_key: Always verify length of provided sadb_key
Date:   Thu, 14 Jun 2018 16:04:47 +0200
Message-Id: <20180614132600.516455376@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132600.255515394@linuxfoundation.org>
References: <20180614132600.255515394@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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


