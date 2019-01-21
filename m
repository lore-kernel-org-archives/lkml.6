Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B28EC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555CB2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078780;
	bh=49B9kZ8784qSxfoxckcyREZYnVG3H2dZ6FYw1ksB2i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KUu/h6Z3j5Bbc1xYLYdQQqwY7brqFArC5hsPZgLmnodSvMnIPaFJsbiQtWJnWFtx8
	 1pVEWY+C78V+ZRQjfeRmiO9FYIxDbNfyW1BEZTVkYqemapJ52NP90B+GknVnKDV+BC
	 w0P8PwqzqYY2HDRxxo6TCImaCUauZzolE/lCtmzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfAUNw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:52:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730650AbfAUNwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:52:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3FA2087F;
        Mon, 21 Jan 2019 13:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078774;
        bh=49B9kZ8784qSxfoxckcyREZYnVG3H2dZ6FYw1ksB2i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KySHKzea01VSvnNgVBBBMsx5gl/W/mkaB8glehPehv32xM2iGeYTWQ34pnDPhRDPY
         Paa1kQfB2ciiopE6bG5jQpl6i0grJsegwXuoGmsf1dmYVAafqNaicgYlsqS6h/Xd8a
         cJDHeNAZsBsIwUcCDWcxwjjqje+UV5v2yqaIeFYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Jiri Slaby <jslaby@suse.cz>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Safonov <dima@arista.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 4.14 02/59] tty: Hold tty_ldisc_lock() during tty_reopen()
Date:   Mon, 21 Jan 2019 14:43:27 +0100
Message-Id: <20190121122456.758306744@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Safonov <dima@arista.com>

commit 83d817f41070c48bc3eb7ec18e43000a548fca5c upstream.

tty_ldisc_reinit() doesn't race with neither tty_ldisc_hangup()
nor set_ldisc() nor tty_ldisc_release() as they use tty lock.
But it races with anyone who expects line discipline to be the same
after hoding read semaphore in tty_ldisc_ref().

We've seen the following crash on v4.9.108 stable:

BUG: unable to handle kernel paging request at 0000000000002260
IP: [..] n_tty_receive_buf_common+0x5f/0x86d
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 [..] n_tty_receive_buf2
 [..] tty_ldisc_receive_buf
 [..] flush_to_ldisc
 [..] process_one_work
 [..] worker_thread
 [..] kthread
 [..] ret_from_fork

tty_ldisc_reinit() should be called with ldisc_sem hold for writing,
which will protect any reader against line discipline changes.

Cc: Jiri Slaby <jslaby@suse.com>
Cc: stable@vger.kernel.org # b027e2298bd5 ("tty: fix data race between tty_init_dev and flush of buf")
Reviewed-by: Jiri Slaby <jslaby@suse.cz>
Reported-by: syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com
Tested-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Tested-by: Tycho Andersen <tycho@tycho.ws>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_io.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1266,15 +1266,20 @@ static int tty_reopen(struct tty_struct
 	if (test_bit(TTY_EXCLUSIVE, &tty->flags) && !capable(CAP_SYS_ADMIN))
 		return -EBUSY;
 
-	tty->count++;
+	retval = tty_ldisc_lock(tty, 5 * HZ);
+	if (retval)
+		return retval;
 
+	tty->count++;
 	if (tty->ldisc)
-		return 0;
+		goto out_unlock;
 
 	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
 	if (retval)
 		tty->count--;
 
+out_unlock:
+	tty_ldisc_unlock(tty);
 	return retval;
 }
 


