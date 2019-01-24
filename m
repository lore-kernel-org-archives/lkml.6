Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B968C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1E1218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358737;
	bh=nRicZzOIbwwmW/KBxAu2WihhNcseKElCokEEr6YPQ5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FKc+jsVkTULXPXZATX+zq3xfKza6x4H44xr+7c+CCtX/oIqj24NcUuTw8f6awz3Ud
	 qR6hO9GsBYOlWxfovirtygkzKuh0NaNNOE+nI34LWhii/9eBChmGjtxIjBE9bHQpuy
	 QUISEZKHrhwDCHiK0Ne52LCxiRFoazOUDFytYpvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbfAXTi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:38:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732037AbfAXTiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:38:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD3CC21906;
        Thu, 24 Jan 2019 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358729;
        bh=nRicZzOIbwwmW/KBxAu2WihhNcseKElCokEEr6YPQ5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEPDB6MW0kCEaiBMx/c5YEkJmvI1MFGno0nJofvTGzkGbOiA54GTmA8jnTn9W8MH1
         vAgWrQLa7eFLILzoGwQFGHWl9rHISc2qP7gi7xwDMvW8z+2wv63Gm56rJ4SJe59bg9
         yf/hPI3vxPU7Js3NBivPvmqSrAT5fU/KkksdTjnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 4.19 105/106] ipmi:ssif: Fix handling of multi-part return messages
Date:   Thu, 24 Jan 2019 20:21:02 +0100
Message-Id: <20190124190212.544830252@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -630,8 +630,9 @@ static void msg_done_handler(struct ssif
 
 		/* Remove the multi-part read marker. */
 		len -= 2;
+		data += 2;
 		for (i = 0; i < len; i++)
-			ssif_info->data[i] = data[i+2];
+			ssif_info->data[i] = data[i];
 		ssif_info->multi_len = len;
 		ssif_info->multi_pos = 1;
 
@@ -659,8 +660,19 @@ static void msg_done_handler(struct ssif
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
@@ -669,16 +681,14 @@ static void msg_done_handler(struct ssif
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
@@ -706,6 +716,7 @@ static void msg_done_handler(struct ssif
 		}
 	}
 
+ continue_op:
 	if (result < 0) {
 		ssif_inc_stat(ssif_info, receive_errors);
 	} else {
@@ -713,8 +724,6 @@ static void msg_done_handler(struct ssif
 		ssif_inc_stat(ssif_info, received_message_parts);
 	}
 
-
- continue_op:
 	if (ssif_info->ssif_debug & SSIF_DEBUG_STATE)
 		pr_info(PFX "DONE 1: state = %d, result=%d.\n",
 			ssif_info->ssif_state, result);


