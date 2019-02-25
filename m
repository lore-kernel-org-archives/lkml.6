Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7F4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522B720C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="ciQjUELq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfBYQoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:44:06 -0500
Received: from tomli.me ([153.92.126.73]:38580 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbfBYQoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:44:05 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id fe172d3d;
        Mon, 25 Feb 2019 16:44:02 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:3d30:359c)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 25 Feb 2019 16:44:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding; s=1490979754; bh=t/bB+YE5fPUbLxlwyf3lZ49YrKiMqhxAqMwXLYGtHZo=; b=ciQjUELqnBgHlmgOv7sjb0FLgu+mj6CYhSJZYoOssx17IiNyHCBg/e+uRlT4a9JslYq0rvTYmbLYY40lbFreTqHHVkNbFeBVfCPITn5KPw1eRzYDhy5kK7arChjDtnYqjzIZzfeCX+A1pdrKci1KMYAeY98HOhWlo9dLfNiqNRFkd58actvpv8NipS4Zz2NI5mzWa975kRASfyP0nFwopgdOxeUCbI1zIQOKvCY/3dhHRmjeR2IjAXKpBKe8ubXlzTKGHnGzV4F8cB48cPcVQk9a7gcZ3zfqMEVmqErgoZFJsrPUQQ3Xb37wLaDJxQQJOwbHd3nvH7CRQPXYMS2M2g==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Yifeng Li <tomli@tomli.me>,
        Mike Frysinger <vapier@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [RFC 0/1] Fix TIOCL_BLANKSCREEN VT console blanking if blankinterval == 0
Date:   Tue, 26 Feb 2019 00:43:45 +0800
Message-Id: <20190225164346.1359-1-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, in the userspace, it was possible to use the "setterm" command
from util-linux to blank the VT console by default, using the following
command.

# setterm -blank force

According to the man page,

> The force option keeps the screen blank even if a key is pressed.

It was implemented by calling TIOCL_BLANKSCREEN.

	case BLANKSCREEN:
		ioctlarg = TIOCL_BLANKSCREEN;
		if (ioctl(STDIN_FILENO, TIOCLINUX, &ioctlarg))
			warn(_("cannot force blank"));
		break;

However, after Linux 4.12, this command ceased to work anymore, which is
unexpected. By inspecting the kernel source, it shows that the issue was
triggered by the side-effect from commit a4199f5e ("tty: Disable default
console blanking interval").

The console blanking is implemented by function do_blank_screen(). It can
be called by the inactive timer "console_timer" with the time specified by
"blankinterval", or by the IOCTL call TIOCL_BLANKSCREEN. The variable
"blank_state" is used to indicate the current status of console blanking,
it can have three possible values, blank_off, blank_normal_wait, or
blank_vesa_wait.

When do_blank_screen() is called by "console_timer" or TIOCL_BLANKSCREEN:

1. If blank_state == vesa_off_interval, it means the console was already
soft-blanked previously, and now it's the time to use VESA to put the CRT
into a deeper sleep mode. When we're done, blank_state is set to blank_off,
means the screen is now off, return.

2. If blank_state == blank_normal_wait, it means the console was previously on,
waiting to be blanked by the inactive timer. It will set blank_state to
"blank_off", means the screen is now off, and it then blanks the console. The
exception is that, it also checks if VESA powersaving is on, if so, blank_state
will be set to "blank_vesa_wait" instead, and the timer "console_timer" is
reinitialized to call do_blank_screen() again after "vesa_off_interval", for
VESA blanking, see Step 1.

3. If blank_state != blank_normal_wait at this point, it means the screen is
neither on, or VESA blanked - it must be blanked already, so return.

The problem is, "blank_state" will be initialized to "blank_normal_wait" in
con_init(), if AND ONLY IF ("blankinterval" > 0). If "blankinterval" is 0,
"blank_state" will be "blank_off" (== 0), and a call to do_blank_screen() will
always abort, per Step 3. Even if a forced blanking is required from the user
by calling TIOCL_BLANKSCREEN, the console won't be blanked.

In other words, the screen cannot be blanked if autoblanking is disabled,
unless we set a "blankinterval" beforehand, and the confusingly, the ioctl
will not even return an error code.

This behavior is unexpected from a user's point-of-view, since it's not
mentioned in any documentation. The setterm man page suggests it will always
work, and the kernel comments in uapi/linux/tiocl.h says

> #define TIOCL_BLANKSCREEN 14 /* keep screen blank even if a key is pressed */

The absence of an error is also misleading.

Personally, I consider it is either: (a) a bug of the implementation,
"blankinterval" shouldn't be a kill switch for manual console blanking, (b) or a
bug of inadequate documentation.

In the following patch, I suggest making a minor change to the console blanking
logic. We introduce a 4th "blank_state" - "blank_normal_notimer", it indicates
the console can be blanked, but not automatically by a timer. Then, we made a
change to "con_init()" - if (blankinterval == 0), "blank_state" will be set to
"blank_normal_notimer" (we have similar changes to "do_unblank_screen()" and
"poke_blanked_console()"). Finally, we change Step 3 in do_blank_screen() - now
it will return if "blank_state" is neither "blank_normal_wait" nor
"blank_normal_notimer", thus allowing the console to be blanked even if there's
no timed autoblanking.

Dear maintainers, please review if my proposed chance is appropriate.

Thanks,
Tom Li

Yifeng Li (1):
  tty: vt.c: Fix TIOCL_BLANKSCREEN VT console blanking if blankinterval
    == 0

 drivers/tty/vt/vt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.20.1

