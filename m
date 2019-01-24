Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB9DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081E921855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360412;
	bh=/6bSmZRmU5XBdQkov0x7CGBHi24RuIKxJNWisy6fIeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PUobDuuYS8y3XvefV4+QttGKoTqJSe/rwvKRXf4QeeAiGasXqziPtJGmlvM1YMhyg
	 Y4fwSXzKwUD1bV71pVgaW3ixE3qLKX0B++eOPAHXjXvTSVuFS/2x6GWsQjrbQqS5tX
	 eE4pnh5LjDIv1gBjWQ0MUMV1mpcv5gmFBklBK0Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbfAXUGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730954AbfAXTa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:30:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FF89218D4;
        Thu, 24 Jan 2019 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358226;
        bh=/6bSmZRmU5XBdQkov0x7CGBHi24RuIKxJNWisy6fIeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQxd6eR7b45DZSw4cSBIJ0jMAAy9YRtir59Rt1d/aRfSV8RbS5t7Vc6HuOOojvmuB
         l39VzNQe+g3nv1LIS1UZyOD86F8jEK3V7yOxqyeiGxZX4wj+KlqXQ/gX/4Z2BxoEiF
         so/F0tJd9zK7cMN047gRVC7QEGUV17qzZ4YsVKvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 4.9 38/39] ipmi:ssif: Fix handling of multi-part return messages
Date:   Thu, 24 Jan 2019 20:20:41 +0100
Message-Id: <20190124190449.721717915@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190448.232316246@linuxfoundation.org>
References: <20190124190448.232316246@linuxfoundation.org>
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

From: Corey Minyard <cminyard@mvista.com>

commit 7d6380cd40f7993f75c4bde5b36f6019237e8719 upstream.

The block number was not being compared right, it was off by one
when checking the response.

Some statistics wouldn't be incremented properly in some cases.

Check to see if that middle-part messages always have 31 bytes of
data.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: stable@vger.kernel.org # 4.4
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_ssif.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -641,8 +641,9 @@ static void msg_done_handler(struct ssif
 
 		/* Remove the multi-part read marker. */
 		len -= 2;
+		data += 2;
 		for (i = 0; i < len; i++)
-			ssif_info->data[i] = data[i+2];
+			ssif_info->data[i] = data[i];
 		ssif_info->multi_len = len;
 		ssif_info->multi_pos = 1;
 
@@ -670,8 +671,19 @@ static void msg_done_handler(struct ssif
 		}
 
 		blocknum = data[0];
+		len--;
+		data++;
+
+		if (blocknum != 0xff && len != 31) {
+		    /* All blocks but the last must have 31 data bytes. */
+			result = -EIO;
+			if (ssif_info->ssif_debug & SSIF_DEBUG_MSG)
+				pr_info("Received middle message <31\n");
 
-		if (ssif_info->multi_len + len - 1 > IPMI_MAX_MSG_LENGTH) {
+			goto continue_op;
+		}
+
+		if (ssif_info->multi_len + len > IPMI_MAX_MSG_LENGTH) {
 			/* Received message too big, abort the operation. */
 			result = -E2BIG;
 			if (ssif_info->ssif_debug & SSIF_DEBUG_MSG)
@@ -680,16 +692,14 @@ static void msg_done_handler(struct ssif
 			goto continue_op;
 		}
 
-		/* Remove the blocknum from the data. */
-		len--;
 		for (i = 0; i < len; i++)
-			ssif_info->data[i + ssif_info->multi_len] = data[i + 1];
+			ssif_info->data[i + ssif_info->multi_len] = data[i];
 		ssif_info->multi_len += len;
 		if (blocknum == 0xff) {
 			/* End of read */
 			len = ssif_info->multi_len;
 			data = ssif_info->data;
-		} else if (blocknum + 1 != ssif_info->multi_pos) {
+		} else if (blocknum != ssif_info->multi_pos) {
 			/*
 			 * Out of sequence block, just abort.  Block
 			 * numbers start at zero for the second block,
@@ -717,6 +727,7 @@ static void msg_done_handler(struct ssif
 		}
 	}
 
+ continue_op:
 	if (result < 0) {
 		ssif_inc_stat(ssif_info, receive_errors);
 	} else {
@@ -724,8 +735,6 @@ static void msg_done_handler(struct ssif
 		ssif_inc_stat(ssif_info, received_message_parts);
 	}
 
-
- continue_op:
 	if (ssif_info->ssif_debug & SSIF_DEBUG_STATE)
 		pr_info(PFX "DONE 1: state = %d, result=%d.\n",
 			ssif_info->ssif_state, result);


