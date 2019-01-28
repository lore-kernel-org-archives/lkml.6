Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0148C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2957214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696123;
	bh=fPivsdV5upi/vCuMtLQDGAkqjaG+iNpBlweUYNNgI7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pfL4EjcSBf03L1cpPjMfdffDhfU419yI94bxpZk5A6CawJ5+2ltvQZgXp/Jrwdiec
	 HfXhwg+E4/vR71iTN9CgdF1AOtSXPE0R36mjueAuiTtqCk9n8wKEhDsMK2DqaKB+g1
	 sH48xZIMd7VIGLBTuZcCo7sD31XBuDMc2D1yIEZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfA1RWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:22:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbfA1QDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:03:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F082175B;
        Mon, 28 Jan 2019 16:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691422;
        bh=fPivsdV5upi/vCuMtLQDGAkqjaG+iNpBlweUYNNgI7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BiqgwSDBkDbFZ37qjFMOlF9oropsZwzrba4e8wh5KVXFLfEUgQhO36P7atonulB7i
         PlShxAjMKPxV0C1+y63PcsXU0wbRpqFKUl6++gTMSR0o158/rW8fZEzTH9932lHrS3
         tbbCX9z3+a3JQ5M81uSYbqzuxstFpghF0cS7nBik=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 089/258] s390/zcrypt: improve special ap message cmd handling
Date:   Mon, 28 Jan 2019 10:56:35 -0500
Message-Id: <20190128155924.51521-89-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Freudenberger <freude@linux.ibm.com>

[ Upstream commit be534791011100d204602e2e0496e9e6ce8edf63 ]

There exist very few ap messages which need to have the 'special' flag
enabled. This flag tells the firmware layer to do some pre- and maybe
postprocessing. However, it may happen that this special flag is
enabled but the firmware is unable to deal with this kind of message
and thus returns with reply code 0x41. For example older firmware may
not know the newest messages triggered by the zcrypt device driver and
thus react with reject and the named reply code. Unfortunately this
reply code is not known to the zcrypt error routines and thus default
behavior is to switch the ap queue offline.

This patch now makes the ap error routine aware of the reply code and
so userspace is informed about the bad processing result but the queue
is not switched to offline state any more.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/uapi/asm/zcrypt.h | 4 ++--
 drivers/s390/crypto/zcrypt_error.h  | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/uapi/asm/zcrypt.h b/arch/s390/include/uapi/asm/zcrypt.h
index 2bb1f3bb98ac..48c784f2101a 100644
--- a/arch/s390/include/uapi/asm/zcrypt.h
+++ b/arch/s390/include/uapi/asm/zcrypt.h
@@ -147,8 +147,8 @@ struct ica_xcRB {
  * @cprb_len:		CPRB header length [0x0020]
  * @cprb_ver_id:	CPRB version id.   [0x04]
  * @pad_000:		Alignment pad bytes
- * @flags:		Admin cmd [0x80] or functional cmd [0x00]
- * @func_id:		Function id / subtype [0x5434]
+ * @flags:		Admin bit [0x80], Special bit [0x20]
+ * @func_id:		Function id / subtype [0x5434] "T4"
  * @source_id:		Source id [originator id]
  * @target_id:		Target id [usage/ctrl domain id]
  * @ret_code:		Return code
diff --git a/drivers/s390/crypto/zcrypt_error.h b/drivers/s390/crypto/zcrypt_error.h
index 6f7ebc1dbe10..2e1a27bd97d1 100644
--- a/drivers/s390/crypto/zcrypt_error.h
+++ b/drivers/s390/crypto/zcrypt_error.h
@@ -52,6 +52,7 @@ struct error_hdr {
 #define REP82_ERROR_FORMAT_FIELD	    0x29
 #define REP82_ERROR_INVALID_COMMAND	    0x30
 #define REP82_ERROR_MALFORMED_MSG	    0x40
+#define REP82_ERROR_INVALID_SPECIAL_CMD	    0x41
 #define REP82_ERROR_INVALID_DOMAIN_PRECHECK 0x42
 #define REP82_ERROR_RESERVED_FIELDO	    0x50 /* old value	*/
 #define REP82_ERROR_WORD_ALIGNMENT	    0x60
@@ -90,6 +91,7 @@ static inline int convert_error(struct zcrypt_queue *zq,
 	case REP88_ERROR_MESSAGE_MALFORMD:
 	case REP82_ERROR_INVALID_DOMAIN_PRECHECK:
 	case REP82_ERROR_INVALID_DOMAIN_PENDING:
+	case REP82_ERROR_INVALID_SPECIAL_CMD:
 	//   REP88_ERROR_INVALID_KEY		// '82' CEX2A
 	//   REP88_ERROR_OPERAND		// '84' CEX2A
 	//   REP88_ERROR_OPERAND_EVEN_MOD	// '85' CEX2A
-- 
2.19.1

