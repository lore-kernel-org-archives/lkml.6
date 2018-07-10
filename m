Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEEAC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6B52083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6B52083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388459AbeGJSbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:31:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388445AbeGJSbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:31:46 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7BCA5EEB;
        Tue, 10 Jul 2018 18:31:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Rosenberg <drosen@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.9 39/52] HID: debug: check length before copy_to_user()
Date:   Tue, 10 Jul 2018 20:25:07 +0200
Message-Id: <20180710182452.938266092@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182449.285532226@linuxfoundation.org>
References: <20180710182449.285532226@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Rosenberg <drosen@google.com>

commit 717adfdaf14704fd3ec7fa2c04520c0723247eac upstream.

If our length is greater than the size of the buffer, we
overflow the buffer

Cc: stable@vger.kernel.org
Signed-off-by: Daniel Rosenberg <drosen@google.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-debug.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1152,6 +1152,8 @@ copy_rest:
 			goto out;
 		if (list->tail > list->head) {
 			len = list->tail - list->head;
+			if (len > count)
+				len = count;
 
 			if (copy_to_user(buffer + ret, &list->hid_debug_buf[list->head], len)) {
 				ret = -EFAULT;
@@ -1161,6 +1163,8 @@ copy_rest:
 			list->head += len;
 		} else {
 			len = HID_DEBUG_BUFSIZE - list->head;
+			if (len > count)
+				len = count;
 
 			if (copy_to_user(buffer, &list->hid_debug_buf[list->head], len)) {
 				ret = -EFAULT;
@@ -1168,7 +1172,9 @@ copy_rest:
 			}
 			list->head = 0;
 			ret += len;
-			goto copy_rest;
+			count -= len;
+			if (count > 0)
+				goto copy_rest;
 		}
 
 	}


