Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBA1C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEAB20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079167;
	bh=XmAfEcltjVxSY9D5kU8caeP4+M0px1n5q7CYEd6BweM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DfR/JNKVUHi/8vkVxgcG9tTOQf6uYjYF4iZGRr3A4H4Cc/1y2FXBHHLaLr0FIvYri
	 B3ILvtk+YMnsbJ7jmabtaySGTElcgQEL8hujxKJQaP89eJFnZy6XY95cVMAtp3bkYO
	 7OhM8h1BlVQrifrz3ZBnbI9DkOpJatTXKR2ngRqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbfAUN70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:59:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732172AbfAUN7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:59:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B3820879;
        Mon, 21 Jan 2019 13:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079164;
        bh=XmAfEcltjVxSY9D5kU8caeP4+M0px1n5q7CYEd6BweM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOJNaLUZFJ9pC396+ZeQTFed2U55hK7jRDz49PmeozE9fOqX83qHtEXnkbdEVMNV0
         wBYTQ3H5HlPjKV52l+E3KmH0iAETCwfiKHj7gA4/VSk+MinTwqGqKPAp/yLb4uoDgI
         tvGn0TftRCuX1hZdJ59ZsUtrctuTu1bYOAHlROVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 4.19 03/99] tty: Simplify tty->count math in tty_reopen()
Date:   Mon, 21 Jan 2019 14:47:55 +0100
Message-Id: <20190121134914.048479004@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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
@@ -1271,16 +1271,13 @@ static int tty_reopen(struct tty_struct
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
 


