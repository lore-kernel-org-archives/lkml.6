Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5895DECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178B22075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178B22075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbeGRDhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:37:39 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:37584 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731138AbeGRDhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:37:38 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1ffciu-0007xu-Uf; Wed, 18 Jul 2018 05:01:52 +0200
Date:   Wed, 18 Jul 2018 05:01:52 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] vt: no blinking on console, 256/24-bit color improvements
Message-ID: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Here's a patchset with two entangled improvements:

* it'd be good to get rid of blinking where possible.  Even CGA (thus VGA)
  allows disabling it, rendering such characters with a bright background
  instead.
* due to my error, 256-color mode uses a much darker palette for conversion,
  resulting in behaving inconsistently with 24-bit mode.

The new code uses bright backgrounds when possible, enabled with \e[100m or
\e[48;m.

Despite the whole idea following a VGA capability, this patchset doesn't
change vgacon yet, just fbcon.  The reason being: ~80% of x86 users have an
nVidia chip, which means nouveau or nvidia-proprietary.  Nouveau implies
fbcon, nvidia-proprietary fails to properly restore text flags (as evidenced
by 512 glyph mode turning to 256 on switch from graphics).  You don't care
about the proprietary driver, but let's not break it pointlessly, and as
both nVidia cards I own work only with nouveau, I don't want to touch what I
can't test.

Thus, let's enable unblinking on fbcon for now.  We can flip that bit (in
register 0x10) later.

This fixes the display of catimg and similar tools.


Diffstat:
 drivers/tty/vt/vt.c              | 56 +++++++++++++++++++++++++++++---------------------------
 drivers/video/fbdev/core/fbcon.c |  1 +
 include/linux/console_struct.h   |  4 ++--
 3 files changed, 32 insertions(+), 29 deletions(-)

-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
