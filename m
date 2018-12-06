Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B18C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E16420661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107565;
	bh=xJ04k7vH5tlOLEYa1HTQPi3sIe5pgdsb7/A0h3nF3rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gttlNI0zQC0AOkj3keavkMQlVVxXFyfu4jNiFCqElyCD3m3wiXiSUS4K+uy/YofH+
	 OB72y8G7qigBGrzeVDbKeQj4Or9wWLVb05uL1CztQ9fpi3rhbW+Wy2+YrMUdFK7gTF
	 SskjtW8ZgBJ3ROgDBkgLOffGYktJemEdCdXjbJ2M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E16420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbeLFOqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729878AbeLFOqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ABCE214DB;
        Thu,  6 Dec 2018 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107559;
        bh=xJ04k7vH5tlOLEYa1HTQPi3sIe5pgdsb7/A0h3nF3rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8O4MLXuqFerBTBICnLr2qzLDZk7mIxpviRItHtjZJ56OXfupay6lJaxtZV/Mw+lE
         BTkGQ8ao6+iUre6AN3JpKy8Xh43BZ71OhqZMEVgfjnIAyzk7qFiCGF1fPUoDGTWDwS
         l3XBGKsdd7GGajKubdvWNlRGvHts58ifjDoY4w8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 053/101] libceph: factor out encrypt_authorizer()
Date:   Thu,  6 Dec 2018 15:38:52 +0100
Message-Id: <20181206143014.617154520@linuxfoundation.org>
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

commit 149cac4a50b0b4081b38b2f38de6ef71c27eaa85 upstream.

Will be used for encrypting both the initial and updated authorizers.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Sage Weil <sage@redhat.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/auth_x.c |   49 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 13 deletions(-)

--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -286,6 +286,38 @@ bad:
 	return -EINVAL;
 }
 
+/*
+ * Encode and encrypt the second part (ceph_x_authorize_b) of the
+ * authorizer.  The first part (ceph_x_authorize_a) should already be
+ * encoded.
+ */
+static int encrypt_authorizer(struct ceph_x_authorizer *au)
+{
+	struct ceph_x_authorize_a *msg_a;
+	struct ceph_x_authorize_b *msg_b;
+	void *p, *end;
+	int ret;
+
+	msg_a = au->buf->vec.iov_base;
+	WARN_ON(msg_a->ticket_blob.secret_id != cpu_to_le64(au->secret_id));
+	p = (void *)(msg_a + 1) + le32_to_cpu(msg_a->ticket_blob.blob_len);
+	end = au->buf->vec.iov_base + au->buf->vec.iov_len;
+
+	msg_b = p + ceph_x_encrypt_offset();
+	msg_b->struct_v = 1;
+	msg_b->nonce = cpu_to_le64(au->nonce);
+
+	ret = ceph_x_encrypt(&au->session_key, p, end - p, sizeof(*msg_b));
+	if (ret < 0)
+		return ret;
+
+	p += ret;
+	WARN_ON(p > end);
+	au->buf->vec.iov_len = p - au->buf->vec.iov_base;
+
+	return 0;
+}
+
 static void ceph_x_authorizer_cleanup(struct ceph_x_authorizer *au)
 {
 	ceph_crypto_key_destroy(&au->session_key);
@@ -302,7 +334,6 @@ static int ceph_x_build_authorizer(struc
 	int maxlen;
 	struct ceph_x_authorize_a *msg_a;
 	struct ceph_x_authorize_b *msg_b;
-	void *p, *end;
 	int ret;
 	int ticket_blob_len =
 		(th->ticket_blob ? th->ticket_blob->vec.iov_len : 0);
@@ -346,21 +377,13 @@ static int ceph_x_build_authorizer(struc
 	dout(" th %p secret_id %lld %lld\n", th, th->secret_id,
 	     le64_to_cpu(msg_a->ticket_blob.secret_id));
 
-	p = msg_a + 1;
-	p += ticket_blob_len;
-	end = au->buf->vec.iov_base + au->buf->vec.iov_len;
-
-	msg_b = p + ceph_x_encrypt_offset();
-	msg_b->struct_v = 1;
 	get_random_bytes(&au->nonce, sizeof(au->nonce));
-	msg_b->nonce = cpu_to_le64(au->nonce);
-	ret = ceph_x_encrypt(&au->session_key, p, end - p, sizeof(*msg_b));
-	if (ret < 0)
+	ret = encrypt_authorizer(au);
+	if (ret) {
+		pr_err("failed to encrypt authorizer: %d", ret);
 		goto out_au;
+	}
 
-	p += ret;
-	WARN_ON(p > end);
-	au->buf->vec.iov_len = p - au->buf->vec.iov_base;
 	dout(" built authorizer nonce %llx len %d\n", au->nonce,
 	     (int)au->buf->vec.iov_len);
 	return 0;


