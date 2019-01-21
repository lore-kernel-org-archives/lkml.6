Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E20AC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D02620879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079759;
	bh=BFhvg3ywOlgVaVBMT9RDgyb9Q5HXTeQ099Sy7uwq5ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zT/LxMvDUPOM7BSixeTspY1kTPAfa7yt/GSQGh7WpZbEDppgG4SvWdZcMqTl/x/rV
	 9PxnL52vNXpYbeGYGKmcj9MKXA8dvwauTKu6yBfvuWxSkXK6/8muJpxE5F3LaqBVil
	 jzDKFghZiqyGKf27JRLKevTpovUjXAiXpJTuYr1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfAUOJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:09:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731709AbfAUNzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:55:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 622572084C;
        Mon, 21 Jan 2019 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078921;
        bh=BFhvg3ywOlgVaVBMT9RDgyb9Q5HXTeQ099Sy7uwq5ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J3Pb9SOaxuFLxa7DG+I90sLDS0ds3x/k7wcMNM1DrvrW9eblaSOXMKuRjxIjhFTqS
         HvHSrqb9/IBxzsJOkJa5RQunXI/biInBfZAyRkS2sYunRabZx8gAUCxwxZnUCGUqgd
         //jaAUd+orlgwYVYb6zbHSspimEg0DD1IEXVY23s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 4.9 03/51] tty: Simplify tty->count math in tty_reopen()
Date:   Mon, 21 Jan 2019 14:43:59 +0100
Message-Id: <20190121122453.907270360@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
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

From: Dmitry Safonov <dima@arista.com>

commit cf62a1a13749db0d32b5cdd800ea91a4087319de upstream.

As notted by Jiri, tty_ldisc_reinit() shouldn't rely on tty counter.
Simplify math by increasing the counter after reinit success.

Cc: Jiri Slaby <jslaby@suse.com>
Link: lkml.kernel.org/r/<20180829022353.23568-2-dima@arista.com>
Suggested-by: Jiri Slaby <jslaby@suse.com>
Reviewed-by: Jiri Slaby <jslaby@suse.cz>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_io.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1491,16 +1491,13 @@ static int tty_reopen(struct tty_struct
 	if (retval)
 		return retval;
 
-	tty->count++;
-	if (tty->ldisc)
-		goto out_unlock;
+	if (!tty->ldisc)
+		retval = tty_ldisc_reinit(tty, tty->termios.c_line);
+	tty_ldisc_unlock(tty);
 
-	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
-	if (retval)
-		tty->count--;
+	if (retval == 0)
+		tty->count++;
 
-out_unlock:
-	tty_ldisc_unlock(tty);
 	return retval;
 }
 


