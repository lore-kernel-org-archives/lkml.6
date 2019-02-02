Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A032C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2238C20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="IskOaKDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfBBGXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:23:46 -0500
Received: from tomli.me ([153.92.126.73]:45102 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfBBGXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:23:45 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Feb 2019 01:23:43 EST
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 3468cb94;
        Sat, 2 Feb 2019 06:17:02 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:7b76:77ab)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 02 Feb 2019 06:17:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding; s=1490979754; bh=scCXMJDrd+6xLDjthmupdszkJ7yXJf1fi44iHiFtkNg=; b=IskOaKDyYb4/Hq3ZTCQE4ABGpNo/oCz5pYrGHVXuFM/gHt8Yo+KpHM35YyvuF66Vr+YRflc4ax+lzCI75KzFzLUn74QK9wU1p6bgnYdK+Kdmpg55mY8oEJQN3DbebNQQaivjeC/UhaKzHL+C3e8ge7AQh3JivK2VOOVqaoCMxNQL8aAUT6FWnqk+wEe2VETs2pm3du3X5Hjc0XdI7xARXutA787SR2ImOfNabHoM7suxEj05LGceXSWWgMWk5wsh2WYPxFsnK2r9VX+zB8KG7GMclTluzHzIAb2HZehK1uHVL/Qrv0wsSdPpHSK1jFwZKMIhLmj94s1LzHs9n6wsFQ==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 0/8] fbdev: sm712fb: implement 2D acceleration w/ cleanups.
Date:   Sat,  2 Feb 2019 14:16:40 +0800
Message-Id: <20190202061648.30374-1-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, in staging/sm7xxfb (now fbdev/sm712fb), 2D acceleration
was implemented, but after its submission, a critical bug that causes
total system hang was discovered, as a stopgap measure, 2D ops was
completele removed in commit 3af805735a25 ("staging: sm7xx: remove the
buggy 2D acceleration support") and never implemented again.

It created a massive usability problem - on YeeLoong 8089, a notable
MIPS platform which uses SM712 - even scrolling a single line of text
on the console required an unaccelerated screen redraw, running "dmesg"
typically takes 8-11 seconds, and absurdly, printf(), became a significant
performance bottleneck that slows down GCC and "make", make the computer
largely unusable.

So I decided to take a look. Most of the my actual development was done
in 2014 in a personal out-of-tree driver, I did not mainline it because
2D acceleration was not working properly in 24-bit color. I discovered
the solution in early 2019 and now it's ready to be mainlined.

This commit reimplements the 2D acceleration for sm712fb. Unlike the
original implementation, which was messy and unnecessarily complicated
by calling a 2D acceleration wrapper file with many unneeded functions,
this is a minimum and (relatively) clean implementation. My tests have
shown that running "dmesg" only takes 0.9 seconds, a performance boost
of 950%. System hangs did not occur in my tests.

Currently, 2D acceleration is only supported on SM712 with little-endian
CPUs, it's disabled on Big Endian systems and SM720 chips as a safety
measure, since I code for myself without any monetary or hardware support
from any company or OEMs, I don't have the hardware and it's completely
untested. I should be also to purchase a Big Endian test platform and add
proper support soon.  If you have a Big-Endian platform with SM7xx
available for testing, please send an E-mail to me immediately! Thanks!

Also, thanks to Miodrag Vallat and other OpenBSD developers, this work
would be impossible without their code, that served as a reference
implementation for me.

Finally, during the development and testing of 2D acceleration, the
modesetting code of this driver received a minor cleanup, and many
issues about issues about the modesetting code and this driver in
general have been documented.

Yifeng Li (8):
  fbdev: sm712fb: update copyright headers.
  fbdev: sm712fb: use type "u8" for 8-bit I/O.
  fbdev: sm712fb: add 2D-related I/O headers and functions.
  fbdev: sm712fb: support 2D acceleration on SM712 w/ Little-Endian CPU.
  fbdev: sm712fb: add 32-bit color modes, drops some other modes.
  Documentation: fb: sm712fb: add information mainly about 2D.
  fbdev: sm712fb: Kconfig: add information about docs.
  MAINTAINERS: sm712fb: list myself as one maintainer.

 Documentation/fb/sm712fb.txt  | 123 +++++++-
 MAINTAINERS                   |   1 +
 drivers/video/fbdev/Kconfig   |   4 +
 drivers/video/fbdev/sm712.h   | 129 +++++++-
 drivers/video/fbdev/sm712fb.c | 574 ++++++++++++++++++++++++++--------
 5 files changed, 679 insertions(+), 152 deletions(-)

-- 
2.20.1

