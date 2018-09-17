Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D788ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32CF20867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32CF20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeIREZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:25:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeIREZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:25:43 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BE561CA0;
        Mon, 17 Sep 2018 22:56:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Wayne Porter <wporter82@gmail.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 09/70] staging/rts5208: Fix read overflow in memcpy
Date:   Tue, 18 Sep 2018 00:41:42 +0200
Message-Id: <20180917211649.955562162@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Micay <danielmicay@gmail.com>

commit 88a5b39b69ab1828fd4130e2baadd184109cea69 upstream.

Noticed by FORTIFY_SOURCE, this swaps memcpy() for strncpy() to zero-value
fill the end of the buffer instead of over-reading a string from .rodata.

Signed-off-by: Daniel Micay <danielmicay@gmail.com>
[kees: wrote commit log]
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wayne Porter <wporter82@gmail.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>

---
 drivers/staging/rts5208/rtsx_scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/rts5208/rtsx_scsi.c
+++ b/drivers/staging/rts5208/rtsx_scsi.c
@@ -536,7 +536,7 @@ static int inquiry(struct scsi_cmnd *srb
 
 	if (sendbytes > 8) {
 		memcpy(buf, inquiry_buf, 8);
-		memcpy(buf + 8, inquiry_string,	sendbytes - 8);
+		strncpy(buf + 8, inquiry_string, sendbytes - 8);
 		if (pro_formatter_flag) {
 			/* Additional Length */
 			buf[4] = 0x33;


