Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0D5C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9A92146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107560;
	bh=6t903W8YieBXVB8S7S/OrC9gPH5xHWw4bwNCKdk3CRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MuhF8P4ErpjJ6PUqZZfyaooqS+1Vgm4fv58aYsRBJE5jDnyWaMpRQj6oU99Knf6ob
	 fXcT29qq99IRXGq+tSF1d6iIMvEc0Rur32p7Z8pqL01p9pVlJKVuZFB34l9KfV/QCe
	 gN2aOKZ1BdXWy/sj5k1OdL6KvS+L7rIzFMkySx7o=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9A92146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbeLFOp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730436AbeLFOp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:45:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC37C2082B;
        Thu,  6 Dec 2018 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107557;
        bh=6t903W8YieBXVB8S7S/OrC9gPH5xHWw4bwNCKdk3CRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ClgG3pGZ7beIiKxx24+Gf3KtbzMGYPh9aZHqwlqw2SVLbUXmp4skODO9oG88ruJQ9
         YbzacJQ7LHG7zXIXMd3jo70f4Ys1u2/QG6sZscsXC0uLpjM6W/qu3SG4rj4z4hRTkG
         6jxwE2NhdtfjPQ+Bf2UW1vpNV10TIsp+B4Pm/irM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 052/101] libceph: factor out __ceph_x_decrypt()
Date:   Thu,  6 Dec 2018 15:38:51 +0100
Message-Id: <20181206143014.552570407@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit c571fe24d243bfe7017f0e67fe800b3cc2a1d1f7 upstream.

Will be used for decrypting the server challenge which is only preceded
by ceph_x_encrypt_header.

Drop struct_v check to allow for extending ceph_x_encrypt_header in the
future.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Sage Weil <sage@redhat.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/auth_x.c |   33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -69,25 +69,40 @@ static int ceph_x_encrypt(struct ceph_cr
 	return sizeof(u32) + ciphertext_len;
 }
 
+static int __ceph_x_decrypt(struct ceph_crypto_key *secret, void *p,
+			    int ciphertext_len)
+{
+	struct ceph_x_encrypt_header *hdr = p;
+	int plaintext_len;
+	int ret;
+
+	ret = ceph_crypt(secret, false, p, ciphertext_len, ciphertext_len,
+			 &plaintext_len);
+	if (ret)
+		return ret;
+
+	if (le64_to_cpu(hdr->magic) != CEPHX_ENC_MAGIC) {
+		pr_err("%s bad magic\n", __func__);
+		return -EINVAL;
+	}
+
+	return plaintext_len - sizeof(*hdr);
+}
+
 static int ceph_x_decrypt(struct ceph_crypto_key *secret, void **p, void *end)
 {
-	struct ceph_x_encrypt_header *hdr = *p + sizeof(u32);
-	int ciphertext_len, plaintext_len;
+	int ciphertext_len;
 	int ret;
 
 	ceph_decode_32_safe(p, end, ciphertext_len, e_inval);
 	ceph_decode_need(p, end, ciphertext_len, e_inval);
 
-	ret = ceph_crypt(secret, false, *p, end - *p, ciphertext_len,
-			 &plaintext_len);
-	if (ret)
+	ret = __ceph_x_decrypt(secret, *p, ciphertext_len);
+	if (ret < 0)
 		return ret;
 
-	if (hdr->struct_v != 1 || le64_to_cpu(hdr->magic) != CEPHX_ENC_MAGIC)
-		return -EPERM;
-
 	*p += ciphertext_len;
-	return plaintext_len - sizeof(struct ceph_x_encrypt_header);
+	return ret;
 
 e_inval:
 	return -EINVAL;


