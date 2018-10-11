Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CD3C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D61F2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC86RRQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D61F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbeJKXGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbeJKXGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:06:13 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB91A20652;
        Thu, 11 Oct 2018 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272310;
        bh=5q6bdqdCGviJlMJYf/9dyiI+v3nbKffFKdUGXiiAHV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cC86RRQqsz13R2BAPYc8Vy7pIogmQu+h8t95KxGisxdBKCFDNSIrN9qHgazw7G98k
         z4Wb5R7/IbSopnvSfaQPxfYdLt5kSSvrG6Dbo3Wi5iLZPY2PUoLmOJDGQobz4x0Aso
         XUe4sljpmZHpNvD3jTn8Ww5RRp0oozyG6dVO8u9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Pelletier <plr.vincent@gmail.com>,
        Mike Christie <mchristi@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 3.18 061/120] scsi: target: iscsi: Use bin2hex instead of a re-implementation
Date:   Thu, 11 Oct 2018 17:34:02 +0200
Message-Id: <20181011152552.286691963@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Pelletier <plr.vincent@gmail.com>

commit 8c39e2699f8acb2e29782a834e56306da24937fe upstream.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
Reviewed-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[plr.vincent@gmail.com: hunk context change for 4.4 and 4.9, no code change]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/iscsi/iscsi_target_auth.c |   15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -26,15 +26,6 @@
 #include "iscsi_target_nego.h"
 #include "iscsi_target_auth.h"
 
-static void chap_binaryhex_to_asciihex(char *dst, char *src, int src_len)
-{
-	int i;
-
-	for (i = 0; i < src_len; i++) {
-		sprintf(&dst[i*2], "%02x", (int) src[i] & 0xff);
-	}
-}
-
 static void chap_gen_challenge(
 	struct iscsi_conn *conn,
 	int caller,
@@ -47,7 +38,7 @@ static void chap_gen_challenge(
 	memset(challenge_asciihex, 0, CHAP_CHALLENGE_LENGTH * 2 + 1);
 
 	get_random_bytes(chap->challenge, CHAP_CHALLENGE_LENGTH);
-	chap_binaryhex_to_asciihex(challenge_asciihex, chap->challenge,
+	bin2hex(challenge_asciihex, chap->challenge,
 				CHAP_CHALLENGE_LENGTH);
 	/*
 	 * Set CHAP_C, and copy the generated challenge into c_str.
@@ -287,7 +278,7 @@ static int chap_server_compute_md5(
 	}
 	crypto_free_hash(tfm);
 
-	chap_binaryhex_to_asciihex(response, server_digest, MD5_SIGNATURE_SIZE);
+	bin2hex(response, server_digest, MD5_SIGNATURE_SIZE);
 	pr_debug("[server] MD5 Server Digest: %s\n", response);
 
 	if (memcmp(server_digest, client_digest, MD5_SIGNATURE_SIZE) != 0) {
@@ -431,7 +422,7 @@ static int chap_server_compute_md5(
 	/*
 	 * Convert response from binary hex to ascii hext.
 	 */
-	chap_binaryhex_to_asciihex(response, digest, MD5_SIGNATURE_SIZE);
+	bin2hex(response, digest, MD5_SIGNATURE_SIZE);
 	*nr_out_len += sprintf(nr_out_ptr + *nr_out_len, "CHAP_R=0x%s",
 			response);
 	*nr_out_len += 1;


