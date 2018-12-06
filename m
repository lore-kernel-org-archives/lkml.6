Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA86CC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E9320850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107945;
	bh=wKB4lH7HY4LwE6YVrSN19qerz8Arc4wjWPmdZkmUiZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yE6PKvVIR12+BGHv+mnikw3QBa2bMdEFyo3qj1e//nQQ04b6wRnM4/KxGVnVqF47k
	 t4cHJOE4kCzi8jJC09QQ3xlNAxZqiDKuoBu5Hx4pYDC4ZcdxNtoPWiXJgIQgXm16Jf
	 huT8pzW1aZH+7yK6GFJYF8YX3Qa0KFjmRK95VY94=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E9320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbeLFOwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:52:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731189AbeLFOqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 010F320661;
        Thu,  6 Dec 2018 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107568;
        bh=wKB4lH7HY4LwE6YVrSN19qerz8Arc4wjWPmdZkmUiZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvVn1xSt15YAiq39dss8zpVIBQk8fG0J1u4LAZLX8e0OAe1CdvfomzLTGg2jyhP4j
         IBEZuAsG6btwMqpGkDVqhM+zxYVusL7f+YmxxVu3VUZ+YUUWhBqMRmfVqzF4/94IPe
         XFjTMfl/W+3AZhjdUdjy98F74eHpS134/mkFhSAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 055/101] libceph: implement CEPHX_V2 calculation mode
Date:   Thu,  6 Dec 2018 15:38:54 +0100
Message-Id: <20181206143014.720460465@linuxfoundation.org>
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

commit cc255c76c70f7a87d97939621eae04b600d9f4a1 upstream.

Derive the signature from the entire buffer (both AES cipher blocks)
instead of using just the first half of the first block, leaving out
data_crc entirely.

This addresses CVE-2018-1129.

Link: http://tracker.ceph.com/issues/24837
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Sage Weil <sage@redhat.com>
[bwh: Backported to 4.9:
 - Define and test the feature bit in the old way
 - Don't change any other feature bits in ceph_features.h]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/ceph/ceph_features.h |    4 +
 net/ceph/auth_x.c                  |   77 +++++++++++++++++++++++++++----------
 2 files changed, 61 insertions(+), 20 deletions(-)

--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -76,6 +76,7 @@
 // duplicated since it was introduced at the same time as CEPH_FEATURE_CRUSH_TUNABLES5
 #define CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING   (1ULL<<58) /* New, v7 encoding */
 #define CEPH_FEATURE_FS_FILE_LAYOUT_V2       (1ULL<<58) /* file_layout_t */
+#define CEPH_FEATURE_CEPHX_V2	(1ULL<<61) // *do not share this bit*
 
 /*
  * The introduction of CEPH_FEATURE_OSD_SNAPMAPPER caused the feature
@@ -124,7 +125,8 @@ static inline u64 ceph_sanitize_features
 	 CEPH_FEATURE_MSGR_KEEPALIVE2 |		\
 	 CEPH_FEATURE_CRUSH_V4 |		\
 	 CEPH_FEATURE_CRUSH_TUNABLES5 |		\
-	 CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING)
+	 CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING |	\
+	 CEPH_FEATURE_CEPHX_V2)
 
 #define CEPH_FEATURES_REQUIRED_DEFAULT   \
 	(CEPH_FEATURE_NOSRCADDR |	 \
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -8,6 +8,7 @@
 
 #include <linux/ceph/decode.h>
 #include <linux/ceph/auth.h>
+#include <linux/ceph/ceph_features.h>
 #include <linux/ceph/libceph.h>
 #include <linux/ceph/messenger.h>
 
@@ -799,26 +800,64 @@ static int calc_signature(struct ceph_x_
 			  __le64 *psig)
 {
 	void *enc_buf = au->enc_buf;
-	struct {
-		__le32 len;
-		__le32 header_crc;
-		__le32 front_crc;
-		__le32 middle_crc;
-		__le32 data_crc;
-	} __packed *sigblock = enc_buf + ceph_x_encrypt_offset();
-	int ret;
-
-	sigblock->len = cpu_to_le32(4*sizeof(u32));
-	sigblock->header_crc = msg->hdr.crc;
-	sigblock->front_crc = msg->footer.front_crc;
-	sigblock->middle_crc = msg->footer.middle_crc;
-	sigblock->data_crc =  msg->footer.data_crc;
-	ret = ceph_x_encrypt(&au->session_key, enc_buf, CEPHX_AU_ENC_BUF_LEN,
-			     sizeof(*sigblock));
-	if (ret < 0)
-		return ret;
+	int ret;
+
+	if (msg->con->peer_features & CEPH_FEATURE_CEPHX_V2) {
+		struct {
+			__le32 len;
+			__le32 header_crc;
+			__le32 front_crc;
+			__le32 middle_crc;
+			__le32 data_crc;
+		} __packed *sigblock = enc_buf + ceph_x_encrypt_offset();
+
+		sigblock->len = cpu_to_le32(4*sizeof(u32));
+		sigblock->header_crc = msg->hdr.crc;
+		sigblock->front_crc = msg->footer.front_crc;
+		sigblock->middle_crc = msg->footer.middle_crc;
+		sigblock->data_crc =  msg->footer.data_crc;
+
+		ret = ceph_x_encrypt(&au->session_key, enc_buf,
+				     CEPHX_AU_ENC_BUF_LEN, sizeof(*sigblock));
+		if (ret < 0)
+			return ret;
+
+		*psig = *(__le64 *)(enc_buf + sizeof(u32));
+	} else {
+		struct {
+			__le32 header_crc;
+			__le32 front_crc;
+			__le32 front_len;
+			__le32 middle_crc;
+			__le32 middle_len;
+			__le32 data_crc;
+			__le32 data_len;
+			__le32 seq_lower_word;
+		} __packed *sigblock = enc_buf;
+		struct {
+			__le64 a, b, c, d;
+		} __packed *penc = enc_buf;
+		int ciphertext_len;
+
+		sigblock->header_crc = msg->hdr.crc;
+		sigblock->front_crc = msg->footer.front_crc;
+		sigblock->front_len = msg->hdr.front_len;
+		sigblock->middle_crc = msg->footer.middle_crc;
+		sigblock->middle_len = msg->hdr.middle_len;
+		sigblock->data_crc =  msg->footer.data_crc;
+		sigblock->data_len = msg->hdr.data_len;
+		sigblock->seq_lower_word = *(__le32 *)&msg->hdr.seq;
+
+		/* no leading len, no ceph_x_encrypt_header */
+		ret = ceph_crypt(&au->session_key, true, enc_buf,
+				 CEPHX_AU_ENC_BUF_LEN, sizeof(*sigblock),
+				 &ciphertext_len);
+		if (ret)
+			return ret;
+
+		*psig = penc->a ^ penc->b ^ penc->c ^ penc->d;
+	}
 
-	*psig = *(__le64 *)(enc_buf + sizeof(u32));
 	return 0;
 }
 


