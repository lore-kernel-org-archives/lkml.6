Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ACBC64EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 03:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FE420841
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 03:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FE420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeJGKo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 06:44:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47557 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbeJGKo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 06:44:27 -0400
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w973bt80047549
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 Oct 2018 20:37:55 -0700
Received: from carbon-x1.hos.anvin.org (localhost [127.0.0.1])
        by carbon-x1.hos.anvin.org (8.15.2/8.15.2) with ESMTP id w973bneD224510;
        Sat, 6 Oct 2018 20:37:49 -0700
Received: (from hpa@localhost)
        by carbon-x1.hos.anvin.org (8.15.2/8.15.2/Submit) id w973bn4l224508;
        Sat, 6 Oct 2018 20:37:49 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-alpha@vger.kernel.org, linux-serial@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org
Subject: [PATCH stable 0/2] termios: Alpha BOTHER/IBSHIFT, tty_baudrate fix
Date:   Sat,  6 Oct 2018 20:37:46 -0700
Message-Id: <20181007033748.224461-1-hpa@zytor.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

It turns out that Alpha is the only architecture that never
implemented BOTHER and IBSHIFT, which is otherwise ages old. This is
one thing that has held up glibc support for this feature (all other
architectures have supported these for about a decade, at least before
the current 3.2 glibc cutoff.)

Furthermore, in the process of dealing with this, I discovered that
the current code in tty_baudrate.c can read past the end of the
baud_table[] on Alpha and PowerPC. The second patch in this series
fixes that, but it also cleans up the code substantially by
auto-generating the table and, since all architectures now have them,
removing all conditionals for BOTHER and IBSHIFT existing.

Tagging for stable because these are concrete problems. I have a much
bigger update in process, nearly done, which will clean up a lot of
duplicated code and make the uapi headers usable for libc, but that is
not critical on the same level.

Tested on x86, compile-tested on Alpha.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: <linux-alpha@vger.kernel.org>
Cc: <linux-serial@vger.kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: <stable@vger.kernel.org>
---
 arch/alpha/include/asm/termios.h       |   8 +-
 arch/alpha/include/uapi/asm/ioctls.h   |   5 +
 arch/alpha/include/uapi/asm/termbits.h |  17 +++
 drivers/tty/.gitignore                 |   1 +
 drivers/tty/Makefile                   |  16 +++
 drivers/tty/bmacros.c                  |   2 +
 drivers/tty/tty_baudrate.c             | 190 +++++++++++++--------------------
 7 files changed, 122 insertions(+), 117 deletions(-)
