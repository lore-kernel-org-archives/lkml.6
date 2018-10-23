Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCF4C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024B820651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024B820651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJWM3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:29:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34586 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJWM3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:29:33 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEnz5-0003B4-27; Tue, 23 Oct 2018 04:07:59 +0000
Date:   Tue, 23 Oct 2018 05:07:59 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] tty ioctl cleanups and fixes
Message-ID: <20181023040758.GT32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	compat_ioctl work related to tty ioctls.  Quite a bit of dead
code taken out, all tty-related stuff gone from fs/compat_ioctl.c.
A bunch of compat bugs fixed - some still remain, but all more or less
generic tty-related ioctls should be covered (remaining issues are in
things like driver-private ioctls in a pcmcia serial card driver not
getting properly handled in 32bit processes on 64bit host, etc.)

	Posted, ACKed by tty maintainers, sat in -next for weeks now.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.tty-ioctl

for you to fetch changes up to ce5a983191ce466cbe35e240ac09e28cca3e50c9:

  kill TIOCSERGSTRUCT (2018-10-13 00:50:53 -0400)

----------------------------------------------------------------
Al Viro (53):
      presence of RS485 ioctls has been unconditional since 2014
      move compat handling of tty ioctls to tty_compat_ioctl()
      tty_ioctl(): drop FIONBIO handling
      mos7720: bury dead TIOCM... in ->ioctl()
      tty_ioctl(): start taking TIOC[SG]SERIAL into separate methods
      simserial: switch to ->[sg]et_serial()
      fwserial: switch to ->[sg]et_serial()
      greybus/uart: switch to ->[sg]et_serial()
      amiserial: switch to ->[sg]et_serial()
      cyclades: switch to ->[sg]et_serial()
      ipwireless: switch to ->[sg]et_serial()
      isicom: switch to ->[sg]et_serial()
      moxa: switch to ->[sg]et_serial()
      mxser: switch to ->[sg]et_serial()
      serial_core: switch to ->[sg]et_serial()
      rfcomm: get rid of mentioning TIOC[SG]SERIAL
      usb-serial: begin switching to ->[sg]et_serial()
      cdc-acm: switch to ->[sg]et_serial()
      ark3116: switch to ->get_serial()
      f81232: switch to ->get_serial()
      f81534: switch to ->get_serial()
      fdti_sio: switch to ->[sg]et_serial()
      io_edgeport: switch to ->get_serial()
      io_ti: switch to ->get_serial()
      mos7720: switch to ->get_serial()
      mos7840: switch to ->get_serial()
      opticon: switch to ->get_serial()
      pl2303: switch to ->get_serial()
      quatech2: switch to ->get_serial()
      ssu100: switch to ->get_serial()
      ti_usb_3410_5052: switch to ->[sg]et_serial()
      whiteheat: switch to ->get_serial()
      usb_wwan: switch to ->[sg]et_serial()
      complete ->[sg]et_serial() switchover
      synclink: reduce pointless checks in ->ioctl()
      take compat TIOC[SG]SERIAL treatment into tty_compat_ioctl()
      kill capinc_tty_ioctl()
      isdn_tty: TCSBRK{,P} won't reach ->ioctl()
      dgnc: TIOCM... won't reach ->ioctl()
      kill the rest of tty COMPAT_IOCTL() entries
      dgnc: break-related ioctls won't reach ->ioctl()
      remove fallback to drivers for TIOCGICOUNT
      dgnc: leave TIOC[GS]SOFTCAR to ldisc
      dgnc: don't bother with (empty) stub for TCXONC
      gigaset: don't try to printk userland buffer contents
      vt_compat_ioctl(): clean up, use compat_ptr() properly
      gigaset: add ->compat_ioctl()
      compat_ioctl - kill keyboard ioctl handling
      pty: fix compat ioctls
      synclink_gt(): fix compat_ioctl()
      kill TIOCSER[SG]WILD
      change semantics of ldisc ->compat_ioctl()
      kill TIOCSERGSTRUCT

 arch/ia64/hp/sim/simserial.c          |  24 ++--
 drivers/bluetooth/hci_ldisc.c         |   1 +
 drivers/char/pcmcia/synclink_cs.c     |   3 +-
 drivers/input/serio/serport.c         |   2 +-
 drivers/isdn/capi/capi.c              |   7 --
 drivers/isdn/gigaset/interface.c      |  13 +-
 drivers/isdn/i4l/isdn_tty.c           |  19 ---
 drivers/net/hamradio/6pack.c          |  21 ----
 drivers/net/hamradio/mkiss.c          |  21 ----
 drivers/net/slip/slip.c               |  25 ----
 drivers/net/wan/x25_asy.c             |  19 ---
 drivers/staging/dgnc/dgnc_tty.c       | 218 --------------------------------
 drivers/staging/fwserial/fwserial.c   |  66 +++++-----
 drivers/staging/greybus/uart.c        |  47 +++----
 drivers/tty/amiserial.c               |  90 +++++--------
 drivers/tty/cyclades.c                |  77 ++++++------
 drivers/tty/ipwireless/tty.c          |  36 +++---
 drivers/tty/isicom.c                  |  72 ++++-------
 drivers/tty/moxa.c                    |  79 ++++++------
 drivers/tty/mxser.c                   |  97 +++++++-------
 drivers/tty/n_gsm.c                   |  11 --
 drivers/tty/n_r3964.c                 |  22 ++++
 drivers/tty/pty.c                     |  14 ++-
 drivers/tty/serial/serial_core.c      |  43 ++-----
 drivers/tty/synclink.c                |   3 +-
 drivers/tty/synclink_gt.c             |  19 +--
 drivers/tty/synclinkmp.c              |   3 +-
 drivers/tty/tty_io.c                  | 229 +++++++++++++++++++++++++++-------
 drivers/tty/tty_ioctl.c               |  16 ---
 drivers/tty/vt/vt_ioctl.c             |  31 ++---
 drivers/usb/class/cdc-acm.c           |  41 +++---
 drivers/usb/serial/ark3116.c          |  38 ++----
 drivers/usb/serial/f81232.c           |  36 ++----
 drivers/usb/serial/f81534.c           |  38 ++----
 drivers/usb/serial/ftdi_sio.c         |  48 ++++---
 drivers/usb/serial/io_edgeport.c      |  37 +++---
 drivers/usb/serial/io_ti.c            |  47 +++----
 drivers/usb/serial/mos7720.c          |  86 ++-----------
 drivers/usb/serial/mos7840.c          |  39 ++----
 drivers/usb/serial/opticon.c          |  43 ++-----
 drivers/usb/serial/option.c           |   3 +-
 drivers/usb/serial/pl2303.c           |  29 ++---
 drivers/usb/serial/quatech2.c         |  42 ++-----
 drivers/usb/serial/ssu100.c           |  42 ++-----
 drivers/usb/serial/ti_usb_3410_5052.c |  74 ++++-------
 drivers/usb/serial/usb-serial.c       |  20 +++
 drivers/usb/serial/usb-wwan.h         |   6 +-
 drivers/usb/serial/usb_wwan.c         |  63 +++-------
 drivers/usb/serial/whiteheat.c        |  42 +++----
 fs/compat_ioctl.c                     | 169 -------------------------
 include/linux/tty.h                   |   2 -
 include/linux/tty_driver.h            |   3 +
 include/linux/tty_ldisc.h             |  10 +-
 include/linux/usb/serial.h            |   2 +
 net/bluetooth/rfcomm/tty.c            |  12 --
 net/nfc/nci/uart.c                    |   1 +
 56 files changed, 779 insertions(+), 1522 deletions(-)
