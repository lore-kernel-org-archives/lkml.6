Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CCDC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9267213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5t66BKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9267213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbeJKXQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbeJKXQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:16:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9685213A2;
        Thu, 11 Oct 2018 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272906;
        bh=BmzFZUJ9nSh9OGYRdf+5p2GHlxrVlzB4hue/YjKoR7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5t66BKE/vWGVlQal1cd8TGFOItJ+6pKHynX1/BJMfH75QK+G6PG4F+MY4jyWLWFs
         nW8b70SjmslUrzUjdctchEcgLMHxkmrvGYf+XEKwHsGFQXGuKtv7GoWbwwcdL76bnK
         VpoKiRzsSX+FKTMUw96bSqiKr0uQ/upSVAFaZ0Ng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 4.18 34/44] tty: Drop tty->count on tty_reopen() failure
Date:   Thu, 11 Oct 2018 17:40:12 +0200
Message-Id: <20181011152453.935481410@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Safonov <dima@arista.com>

commit fe32416790093b31364c08395727de17ec96ace1 upstream.

In case of tty_ldisc_reinit() failure, tty->count should be decremented
back, otherwise we will never release_tty().
Tetsuo reported that it fixes noisy warnings on tty release like:
  pts pts4033: tty_release: tty->count(10529) != (#fd's(7) + #kopen's(0))

Fixes: commit 892d1fa7eaae ("tty: Destroy ldisc instance on hangup")

Cc: stable@vger.kernel.org # v4.6+
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Reviewed-by: Jiri Slaby <jslaby@suse.cz>
Tested-by: Jiri Slaby <jslaby@suse.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_io.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1264,6 +1264,7 @@ static void tty_driver_remove_tty(struct
 static int tty_reopen(struct tty_struct *tty)
 {
 	struct tty_driver *driver = tty->driver;
+	int retval;
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY &&
 	    driver->subtype == PTY_TYPE_MASTER)
@@ -1277,10 +1278,14 @@ static int tty_reopen(struct tty_struct
 
 	tty->count++;
 
-	if (!tty->ldisc)
-		return tty_ldisc_reinit(tty, tty->termios.c_line);
+	if (tty->ldisc)
+		return 0;
 
-	return 0;
+	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
+	if (retval)
+		tty->count--;
+
+	return retval;
 }
 
 /**


