Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58954C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CBD2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXG9u/Tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CBD2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbeJYWwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730655AbeJYWwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:41 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA9D82085B;
        Thu, 25 Oct 2018 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477183;
        bh=rUrAf0FGpMb1NDQwbKCBgD7/1d8w8QOyBroHFGOrD10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXG9u/TcpkFu1i4CSIF9OYVKAOAExPI1jcvxGP8f10/K5cfspyyBvg3DkyqAbbIgV
         18IPxagLy0iYbUqrxepmUnwfrPuycmOwEmUkeloEmzB+qCcl2Fxwsie7C/Oeakv6+4
         NNNdd8SYGse9qiE41WYSQFxmHuPbWJYXKVSl5eUI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Hurley <peter@hurleysoftware.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 33/98] Revert "tty: Fix pty master poll() after slave closes v2"
Date:   Thu, 25 Oct 2018 10:17:48 -0400
Message-Id: <20181025141853.214051-33-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Hurley <peter@hurleysoftware.com>

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

