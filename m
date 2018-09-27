Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2030C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA4A20836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA4A20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeI0P3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:29:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55296 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbeI0P3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:29:03 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1B74F10A4;
        Thu, 27 Sep 2018 09:11:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Pelletier <plr.vincent@gmail.com>,
        Mike Christie <mchristi@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.18 57/88] scsi: target: iscsi: Use bin2hex instead of a re-implementation
Date:   Thu, 27 Sep 2018 11:03:38 +0200
Message-Id: <20180927090307.718143161@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Pelletier <plr.vincent@gmail.com>

commit 8c39e2699f8acb2e29782a834e56306da24937fe upstream.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
Reviewed-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
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
 static int chap_gen_challenge(
 	struct iscsi_conn *conn,
 	int caller,
@@ -50,7 +41,7 @@ static int chap_gen_challenge(
 	ret = get_random_bytes_wait(chap->challenge, CHAP_CHALLENGE_LENGTH);
 	if (unlikely(ret))
 		return ret;
-	chap_binaryhex_to_asciihex(challenge_asciihex, chap->challenge,
+	bin2hex(challenge_asciihex, chap->challenge,
 				CHAP_CHALLENGE_LENGTH);
 	/*
 	 * Set CHAP_C, and copy the generated challenge into c_str.
@@ -289,7 +280,7 @@ static int chap_server_compute_md5(
 		goto out;
 	}
 
-	chap_binaryhex_to_asciihex(response, server_digest, MD5_SIGNATURE_SIZE);
+	bin2hex(response, server_digest, MD5_SIGNATURE_SIZE);
 	pr_debug("[server] MD5 Server Digest: %s\n", response);
 
 	if (memcmp(server_digest, client_digest, MD5_SIGNATURE_SIZE) != 0) {
@@ -411,7 +402,7 @@ static int chap_server_compute_md5(
 	/*
 	 * Convert response from binary hex to ascii hext.
 	 */
-	chap_binaryhex_to_asciihex(response, digest, MD5_SIGNATURE_SIZE);
+	bin2hex(response, digest, MD5_SIGNATURE_SIZE);
 	*nr_out_len += sprintf(nr_out_ptr + *nr_out_len, "CHAP_R=0x%s",
 			response);
 	*nr_out_len += 1;


