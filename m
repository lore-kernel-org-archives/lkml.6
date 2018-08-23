Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8878CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E28E208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E28E208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbeHWMkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:40:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbeHWMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:40:02 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EF4D7BBF;
        Thu, 23 Aug 2018 09:11:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matthijs van Duin <matthijsvanduin@gmail.com>,
        Aleksa Sarai <asarai@suse.de>
Subject: [PATCH 4.18 02/22] pty: fix O_CLOEXEC for TIOCGPTPEER
Date:   Thu, 23 Aug 2018 09:56:28 +0200
Message-Id: <20180823074759.356816641@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074759.234685844@linuxfoundation.org>
References: <20180823074759.234685844@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthijs van Duin <matthijsvanduin@gmail.com>

commit 36ecc1481dc8d8c52d43ba18c6b642c1d2fde789 upstream.

It was being ignored because the flags were not passed to fd allocation.

Fixes: 54ebbfb16034 ("tty: add TIOCGPTPEER ioctl")
Signed-off-by: Matthijs van Duin <matthijsvanduin@gmail.com>
Acked-by: Aleksa Sarai <asarai@suse.de>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/pty.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -625,7 +625,7 @@ int ptm_open_peer(struct file *master, s
 	if (tty->driver != ptm_driver)
 		return -EIO;
 
-	fd = get_unused_fd_flags(0);
+	fd = get_unused_fd_flags(flags);
 	if (fd < 0) {
 		retval = fd;
 		goto err;


