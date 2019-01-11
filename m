Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F59C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6B5218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547235191;
	bh=WsNfx33BzIsjnY5yiFog9pEDVAqaiJ1DB5eYd1qgUdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jv8rwbRAetUPS+QeKebiKVhERY3s8REgGPOE6DjftRMkQAUaQ9+2LMV8BjvPIPtRA
	 mL80wL8tCVuh4wGZ28L8iFntfk2uveq+ur05tdHttLM4pO0iNkobEV0QHrVXwpDt7S
	 sg24vBEx502SBoYDTfh7aUBHR66P3UjyvJQVJzPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388658AbfAKTdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:33:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388593AbfAKTdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:33:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4468C218C3;
        Fri, 11 Jan 2019 19:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547235181;
        bh=WsNfx33BzIsjnY5yiFog9pEDVAqaiJ1DB5eYd1qgUdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PyPsXlSjGuj6393JasHvCtv+SI2rh3+81KfdhlJVXQ0QJeOF6bDlJ1r+4NoHKvAUJ
         eHJmPlkfyBmxMfprhj3nms5+fYXNRHuEkDMV64ScGKSd5KRN/RyOo1mr0H5wL9D2Zk
         rp3OnGi9Dv9gA7/68wcqngVaXRL6EFIZKgXwwGIE=
Date:   Fri, 11 Jan 2019 20:32:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Dmitry Safonov <dima@arista.com>, Jiri Slaby <jslaby@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tycho Andersen <tycho@tycho.ws>, Dave Mielke <dave@mielke.cc>,
        linux-kernel@vger.kernel.org
Subject: Re: commit 83d817f410 broke my ability to use Linux with a braille
 display
Message-ID: <20190111193259.GA14966@kroah.com>
References: <nycvar.YSQ.7.76.1901111239510.1512@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1901111239510.1512@knanqh.ubzr>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 01:33:09PM -0500, Nicolas Pitre wrote:
> I use Linux with the help of a braille display and the brltty daemon. It 
> turns out that the latest mainline kernel I can work with comes from 
> commit 231f8fd0cc. Anything past that and I lose the ability to read the 
> console barely a few seconds after the system has booted as brltty is 
> thrown a wrench and the braille display becomes completely inoperable.
> 
> Things get somewhat better with commit c96cf923a9 as brltty is not 
> longer incapacitated, but some programs would randomly crash. Even the 
> very first login attempt won't work as I soon as I hit enter after my 
> user name the password prompt is skipped over, just like if the enter 
> key had been hit twice. Then lynx (the text web browser) would crash as 
> soon as I switch the virtual console with LeftAlt+FN. Mind you, this 
> isn't easy to perform bisection in those conditions.
> 
> And the worst commit i.e. 83d817f410 is marked for stable!  :-(
> 
> Some interaction with brltty must be at play here otherwise such 
> breakage would never have survived up to the mainline kernel.
> 
> As far as latest mainline is concerned, I managed to reproduce at least 
> one of the unwelcome behavior change (hoping that's all there is to this 
> issue) with a very simple test case so you won't have to learn braille 
> to debug this:
> 
> # from any vt, make sure tty40 is allocated and empty
> openvt -c 40 -f -- true
> 
> # open it and wait on read()
> cat /dev/tty40
> 
> # from a second vt, simply open tty40 again
> true < /dev/tty40
> 
> # come back to the first vt and watch cat bailing out with EAGAIN.
> 
> Please fix.

Please try the patch below, it was just queued up to my tree and should
resolve the issue.  If not, please let us know.

thanks,

greg k-h


From d3736d82e8169768218ee0ef68718875918091a0 Mon Sep 17 00:00:00 2001
From: Dmitry Safonov <dima@arista.com>
Date: Wed, 9 Jan 2019 01:17:40 +0000
Subject: tty: Don't hold ldisc lock in tty_reopen() if ldisc present

Try to get reference for ldisc during tty_reopen().
If ldisc present, we don't need to do tty_ldisc_reinit() and lock the
write side for line discipline semaphore.
Effectively, it optimizes fast-path for tty_reopen(), but more
importantly it won't interrupt ongoing IO on the tty as no ldisc change
is needed.
Fixes user-visible issue when tty_reopen() interrupted login process for
user with a long password, observed and reported by Lukas.

Fixes: c96cf923a98d ("tty: Don't block on IO when ldisc change is pending")
Fixes: 83d817f41070 ("tty: Hold tty_ldisc_lock() during tty_reopen()")
Cc: Jiri Slaby <jslaby@suse.com>
Reported-by: Lukas F. Hartmann <lukas@mntmn.com>
Tested-by: Lukas F. Hartmann <lukas@mntmn.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty_io.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index bfe9ad85b362..23c6fd238422 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1256,7 +1256,8 @@ static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *
 static int tty_reopen(struct tty_struct *tty)
 {
 	struct tty_driver *driver = tty->driver;
-	int retval;
+	struct tty_ldisc *ld;
+	int retval = 0;
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY &&
 	    driver->subtype == PTY_TYPE_MASTER)
@@ -1268,13 +1269,18 @@ static int tty_reopen(struct tty_struct *tty)
 	if (test_bit(TTY_EXCLUSIVE, &tty->flags) && !capable(CAP_SYS_ADMIN))
 		return -EBUSY;
 
-	retval = tty_ldisc_lock(tty, 5 * HZ);
-	if (retval)
-		return retval;
+	ld = tty_ldisc_ref_wait(tty);
+	if (ld) {
+		tty_ldisc_deref(ld);
+	} else {
+		retval = tty_ldisc_lock(tty, 5 * HZ);
+		if (retval)
+			return retval;
 
-	if (!tty->ldisc)
-		retval = tty_ldisc_reinit(tty, tty->termios.c_line);
-	tty_ldisc_unlock(tty);
+		if (!tty->ldisc)
+			retval = tty_ldisc_reinit(tty, tty->termios.c_line);
+		tty_ldisc_unlock(tty);
+	}
 
 	if (retval == 0)
 		tty->count++;
-- 
2.20.1

