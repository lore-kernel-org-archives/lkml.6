Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87638C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554162064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554162064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeJCABo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:01:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60094 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeJCABo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:01:44 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1AD11EBA;
        Tue,  2 Oct 2018 17:17:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com, aszlig@nix.build,
        gmazyland@gmail.com, torvalds@linux-foundation.org, w@1wt.eu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] tty: wipe buffer.
Date:   Tue,  2 Oct 2018 10:17:07 -0700
Message-Id: <20181002171708.1311-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002171708.1311-1-gregkh@linuxfoundation.org>
References: <20181002171708.1311-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

After we are done with the tty buffer, zero it out.

Reported-by: aszlig <aszlig@nix.build>
Tested-by: Milan Broz <gmazyland@gmail.com>
Tested-by: aszlig <aszlig@nix.build>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty_buffer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index c996b6859c5e..ae3ce330200e 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -468,11 +468,15 @@ receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
 {
 	unsigned char *p = char_buf_ptr(head, head->read);
 	char	      *f = NULL;
+	int n;
 
 	if (~head->flags & TTYB_NORMAL)
 		f = flag_buf_ptr(head, head->read);
 
-	return port->client_ops->receive_buf(port, p, f, count);
+	n = port->client_ops->receive_buf(port, p, f, count);
+	if (n > 0)
+		memset(p, 0, n);
+	return n;
 }
 
 /**
-- 
2.19.0

