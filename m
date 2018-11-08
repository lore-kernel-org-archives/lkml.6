Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD6CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D862089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JErX63rV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D862089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeKIHda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728812AbeKIHd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:27 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAEE32089A;
        Thu,  8 Nov 2018 21:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714160;
        bh=uKCIDrk/EsSLiz5boZ5mABleRHvz/p8T3t56HGkV5MI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JErX63rVPYvWoZaSWgUjWYP9r3Zmd2CDcxYADw5CEUpy8JQgMg599XERMtIhgP6/H
         WH+8RmuinX/yIbn9igm0MD9/nnGCykjzYpu2zmv+HORNZ+FBlSVb2EAMy3mek0Q3+6
         cIKBxjCmWxHT9rujXmseRzFsQMwPTObK6mluqjE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Francesco Ruggeri <fruggeri@arista.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 063/144] Revert "tty: Fix pty master poll() after slave closes v2"
Date:   Thu,  8 Nov 2018 13:50:34 -0800
Message-Id: <20181108215059.438511082@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2ce3c10c0c3e0d418c1a7a4c838319ba42c75388 ]

This reverts commit c4dc304677e8d566572c4738d95c48be150c6606.
This fix is superseded by commit 52bce7f8d4fc633c9a9d0646eef58ba6ae9a3b73,
'pty, n_tty: Simplify input processing on final close'.

The final close now waits for input processing to complete before
destroying the pty, so poll() does not need to special case this
condition.

Cc: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/n_tty.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 6acdd553b707..0ed99ad74bee 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2472,17 +2472,12 @@ static unsigned int n_tty_poll(struct tty_struct *tty, struct file *file,
 
 	poll_wait(file, &tty->read_wait, wait);
 	poll_wait(file, &tty->write_wait, wait);
-	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
-		mask |= POLLHUP;
 	if (input_available_p(tty, 1))
 		mask |= POLLIN | POLLRDNORM;
-	else if (mask & POLLHUP) {
-		tty_flush_to_ldisc(tty);
-		if (input_available_p(tty, 1))
-			mask |= POLLIN | POLLRDNORM;
-	}
 	if (tty->packet && tty->link->ctrl_status)
 		mask |= POLLPRI | POLLIN | POLLRDNORM;
+	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
+		mask |= POLLHUP;
 	if (tty_hung_up_p(file))
 		mask |= POLLHUP;
 	if (!(mask & (POLLHUP | POLLIN | POLLRDNORM))) {
-- 
2.17.1



