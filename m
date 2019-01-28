Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3821C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA362086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692077;
	bh=XoZThTwQYKGp6aDThnnD3ouVS4EItO7DNNDX5WBaliM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F3xd/TjofqvcAsBtMyD4O0Xxm4g346mW+/XpaNHFcqh8E9u7Er0LCedzcwHI6u6VN
	 ngqp2rauX1gK28FmJ8u9cAwZbQQvmAU63xAT7ZyHfxwGqdiQjpitb4tHmmE6JGfA/Y
	 LEk4rYo2zwLAwyC9mM1BfI2vA8e4EKe+eQbq//No=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbfA1QOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:14:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732985AbfA1QO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:14:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD12D20879;
        Mon, 28 Jan 2019 16:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692068;
        bh=XoZThTwQYKGp6aDThnnD3ouVS4EItO7DNNDX5WBaliM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDSsN6n3GLfCDemyWE3wv/3kfX5GutGIFy6qOBJWdpoRrfcVGiYyVK3fMwl+qtR8c
         gz71ItQAflQAjPLrlfOhkYatC7FiZSZgadq6brEGpZK6V0GvJS0e9tCXXb97kGL2g/
         dWdJcftnHEpRdGbHwJmuuKLVhNAMzqaLVlq/X/H4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 058/170] s390/zcrypt: improve special ap message cmd handling
Date:   Mon, 28 Jan 2019 11:10:08 -0500
Message-Id: <20190128161200.55107-58-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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
index 137ef473584e..b9fb42089760 100644
--- a/arch/s390/include/uapi/asm/zcrypt.h
+++ b/arch/s390/include/uapi/asm/zcrypt.h
@@ -161,8 +161,8 @@ struct ica_xcRB {
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
index 13df60209ed3..9499cd3a05f8 100644
--- a/drivers/s390/crypto/zcrypt_error.h
+++ b/drivers/s390/crypto/zcrypt_error.h
@@ -65,6 +65,7 @@ struct error_hdr {
 #define REP82_ERROR_FORMAT_FIELD	    0x29
 #define REP82_ERROR_INVALID_COMMAND	    0x30
 #define REP82_ERROR_MALFORMED_MSG	    0x40
+#define REP82_ERROR_INVALID_SPECIAL_CMD	    0x41
 #define REP82_ERROR_INVALID_DOMAIN_PRECHECK 0x42
 #define REP82_ERROR_RESERVED_FIELDO	    0x50 /* old value	*/
 #define REP82_ERROR_WORD_ALIGNMENT	    0x60
@@ -103,6 +104,7 @@ static inline int convert_error(struct zcrypt_queue *zq,
 	case REP88_ERROR_MESSAGE_MALFORMD:
 	case REP82_ERROR_INVALID_DOMAIN_PRECHECK:
 	case REP82_ERROR_INVALID_DOMAIN_PENDING:
+	case REP82_ERROR_INVALID_SPECIAL_CMD:
 	//   REP88_ERROR_INVALID_KEY		// '82' CEX2A
 	//   REP88_ERROR_OPERAND		// '84' CEX2A
 	//   REP88_ERROR_OPERAND_EVEN_MOD	// '85' CEX2A
-- 
2.19.1

