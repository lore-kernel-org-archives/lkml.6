Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7C2C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4882146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4882146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbeIMHim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:38:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43342 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeIMHim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:38:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HPb-00068t-PA; Thu, 13 Sep 2018 02:31:19 +0000
Date:   Thu, 13 Sep 2018 03:31:19 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCHES] tty ioctls cleanups, compat and not only
Message-ID: <20180913023119.GQ19965@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	See vfs.git#work.tty-ioctl.  Completely untested, should seriously
clean the things up wrt compat.  Remaining problems (aside of the bugs
introduced in it, of course):
	* TIOCSERGSTRUCT must die; it's present only in amiserial and it's
_vile_; look at what it copies out and weep.
	* synclink_gt has proper compat handling for its private ioctls;
other synclink drivers (with the same ioctls) do not.
	* dgnc definitely has buggered ioctls - structs full of longs are
bloody bad idea for passing around.  It's in staging, and I'd say that it
needs the userland ABI fixed.
	* cyclades, rocket, moxa and mxser probably have non-trivial
problems with their private ioctls; I hadn't looked into those.
	* n_gsm needs ->compat_ioctl(); easy to do, I just hadn't done it
yet.
	* ipwireless might or might not need compat_ioctl (PPP stuff in it);
not sure.
	* ldisc private ioctls need more work.  Hadn't gone there yet.
Generic ioctls should be fine - they never reach ->compat_ioctl() with this
series.

	There's some overlap with patches posted earlier - e.g. I'm fairly
sure that keyboard ioctl "remove from fs/compat_ioctl.c" part duplicates
one of yours; I'll be glad to drop and replace such duplicates with already
posted variants.

	Basic idea is to shunt generic ioctls that are reachable only
via tty_ioctl() very early in tty_compat_ioctl(), separately for those
that do and do not need compat_ptr().  That already simplifies the hell
out of ->compat_ioctl() situation - its instances won't ever see those,
so they can e.g. ignore the behaviour of n_tty_ioctl_helper(); whatever
they get in cmd won't be accepted by that one.

	Next we separate TIOC[SG]SERIAL into a couple of new methods,
leaving the copyin/copyout to callers.  That allows to take care of
compat for those in tty_compat_ioctl() *and* actually kills some of
->ioctl() instances.

	And then there's dead code of all kinds all over the place ;-/
The oldest one has been alive from Aug 1 1992 to Oct 18 1992 and had
shambled around ever since (FIONBIO), but there are other examples.
10 years dead is better than 26, but still...

	Shortlog and diffstat follow, patches in followups...

Al Viro (50):
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

 arch/ia64/hp/sim/simserial.c          |  17 ++-
 drivers/char/pcmcia/synclink_cs.c     |   3 +-
 drivers/isdn/capi/capi.c              |   7 --
 drivers/isdn/gigaset/interface.c      |  13 +-
 drivers/isdn/i4l/isdn_tty.c           |  19 ---
 drivers/staging/dgnc/dgnc_tty.c       | 218 --------------------------------
 drivers/staging/fwserial/fwserial.c   |  66 +++++-----
 drivers/staging/greybus/uart.c        |  47 +++----
 drivers/tty/amiserial.c               |  83 ++++++-------
 drivers/tty/cyclades.c                |  77 ++++++------
 drivers/tty/ipwireless/tty.c          |  36 +++---
 drivers/tty/isicom.c                  |  72 ++++-------
 drivers/tty/moxa.c                    |  79 ++++++------
 drivers/tty/mxser.c                   |  97 ++++++++-------
 drivers/tty/pty.c                     |   6 +-
 drivers/tty/serial/serial_core.c      |  38 ++----
 drivers/tty/synclink.c                |   3 +-
 drivers/tty/synclink_gt.c             |  19 +--
 drivers/tty/synclinkmp.c              |   3 +-
 drivers/tty/tty_io.c                  | 226 +++++++++++++++++++++++++++-------
 drivers/tty/tty_ioctl.c               |  16 ---
 drivers/tty/vt/vt_ioctl.c             |  31 ++---
 drivers/usb/class/cdc-acm.c           |  41 +++---
 drivers/usb/serial/ark3116.c          |  38 ++----
 drivers/usb/serial/f81232.c           |  36 ++----
 drivers/usb/serial/f81534.c           |  38 ++----
 drivers/usb/serial/ftdi_sio.c         |  48 ++++----
 drivers/usb/serial/io_edgeport.c      |  37 +++---
 drivers/usb/serial/io_ti.c            |  47 +++----
 drivers/usb/serial/mos7720.c          |  88 +++----------
 drivers/usb/serial/mos7840.c          |  40 +++---
 drivers/usb/serial/opticon.c          |  43 ++-----
 drivers/usb/serial/option.c           |   3 +-
 drivers/usb/serial/pl2303.c           |  29 ++---
 drivers/usb/serial/quatech2.c         |  42 ++-----
 drivers/usb/serial/ssu100.c           |  42 ++-----
 drivers/usb/serial/ti_usb_3410_5052.c |  74 ++++-------
 drivers/usb/serial/usb-serial.c       |  18 +++
 drivers/usb/serial/usb-wwan.h         |   6 +-
 drivers/usb/serial/usb_wwan.c         |  63 +++-------
 drivers/usb/serial/whiteheat.c        |  42 +++----
 fs/compat_ioctl.c                     | 169 -------------------------
 include/linux/tty.h                   |   2 -
 include/linux/tty_driver.h            |   3 +
 include/linux/usb/serial.h            |   2 +
 net/bluetooth/rfcomm/tty.c            |   8 --
 46 files changed, 744 insertions(+), 1391 deletions(-)
