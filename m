Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56475C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A84214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895120;
	bh=DrV65zrKwH/sv9GZ3Anv8n2YUPa/YjTcWzuX2qNIafk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KXnTnA36ydpOed1qy9GRvSEnTJRS/UYSJ6g9/tAGkbQtT7gGbCg+N13YHr553EYV9
	 UU7Wvzrtfwb49H/jw3Pi0h5RhiSd77SUciXnkAJ6IYVgC+mpZj6RM5WA3Ta2PJf14A
	 wMcjX5ptQErXU24goJNoa/JnVPG4XpNIYCCi4zz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfBKOZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:25:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbfBKOZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:25:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08BDD20821;
        Mon, 11 Feb 2019 14:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895114;
        bh=DrV65zrKwH/sv9GZ3Anv8n2YUPa/YjTcWzuX2qNIafk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNiU5RXfOeEQL17JT6/8XBznlggjhBWkzaxxnmPN+m1xpvM8WRRg9LCblA2MwkRrI
         8hOPa8wbW47iCrJA42AlPz+EaseuqFRp112k2LuFFan9QxORL5LMuW4ZoEvke1yC+o
         DafNuwpzLeQdkUgQviW/mI2/We/+W+yIUrJd0mu4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Harald Freudenberger <freude@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 096/352] s390/zcrypt: improve special ap message cmd handling
Date:   Mon, 11 Feb 2019 15:15:23 +0100
Message-Id: <20190211141851.957203560@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 42c81a95e97b..494c34c50716 100644
--- a/arch/s390/include/uapi/asm/zcrypt.h
+++ b/arch/s390/include/uapi/asm/zcrypt.h
@@ -150,8 +150,8 @@ struct ica_xcRB {
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
index 240b27f3f5f6..f34ee41cbed8 100644
--- a/drivers/s390/crypto/zcrypt_error.h
+++ b/drivers/s390/crypto/zcrypt_error.h
@@ -51,6 +51,7 @@ struct error_hdr {
 #define REP82_ERROR_FORMAT_FIELD	    0x29
 #define REP82_ERROR_INVALID_COMMAND	    0x30
 #define REP82_ERROR_MALFORMED_MSG	    0x40
+#define REP82_ERROR_INVALID_SPECIAL_CMD	    0x41
 #define REP82_ERROR_INVALID_DOMAIN_PRECHECK 0x42
 #define REP82_ERROR_RESERVED_FIELDO	    0x50 /* old value	*/
 #define REP82_ERROR_WORD_ALIGNMENT	    0x60
@@ -89,6 +90,7 @@ static inline int convert_error(struct zcrypt_queue *zq,
 	case REP88_ERROR_MESSAGE_MALFORMD:
 	case REP82_ERROR_INVALID_DOMAIN_PRECHECK:
 	case REP82_ERROR_INVALID_DOMAIN_PENDING:
+	case REP82_ERROR_INVALID_SPECIAL_CMD:
 	//   REP88_ERROR_INVALID_KEY		// '82' CEX2A
 	//   REP88_ERROR_OPERAND		// '84' CEX2A
 	//   REP88_ERROR_OPERAND_EVEN_MOD	// '85' CEX2A
-- 
2.19.1



