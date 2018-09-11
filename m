Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3389C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C1E20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C1E20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=triplefau.lt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeILBpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:45:04 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:42294 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbeILBpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:45:03 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id EF9DE3A9FF6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 22:16:44 +0200 (CEST)
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 8A80FFF80A;
        Tue, 11 Sep 2018 20:16:41 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Elie Roudninski <xademax@gmail.com>,
        Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 0/4] Add specific vt input's key map
Date:   Tue, 11 Sep 2018 22:23:55 +0200
Message-Id: <cover.1536695070.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a way to have a specific keyboard config (i.e.
keycode to keysym map) for a vt attached input.

Because one can have different keyboards with different layouts on the
same VT, it can be useful to be able to associate a different keymap
with a different input. In order to do so this patchset introduces
three new ioctls:

1) KDGKBIENT
	Get an input key map's entry. If the input does not have a
	specific key map the requested entry is fetched from global
	key map.

2) KDSKBIENT
	Set an input key map's entry. If the input does not yet have a
	specific key map, a new one is created with the current global
	key map content copied in.

3) KDSKBIRST
	Reset an input key map. The input does not use a specific key
	map anymore and keycode translations are done with global key
	map.

In order to keep old behavior compatibility and not waste memory, an
input uses the global key_maps[] array by default and KDGKBENT/KDSKBENT
ioctls still get/set entries in this global key map. The specific key
map is only allocated on the first call to KDSKBIENT.

A patch for loadkeys is ready to be sent to the ML if this patchset
seems sane to you.

Here are some questions I had while doing this patchset:

- Is it ok to add new ioctl to old legacy code ? I added those ioctl
  the old way in order to match the header style. Maybe it is better to
  use the __IO* macros ?

- I am not quite sure about the meaning of keymap_count. IIUC, it is a
  counter of used keymap function arrays statically or dynamically
  allocated. If it is not the case, the modificiation in kc_setent() that
  decrements keymap_count even if a statically keymap function is removed
  with "K_NOSUCHMAP" (in PATCH 2/4) may be wrong ?

- kbd_detach_conf is a bit clumsy because it tries to copy a shared sparse
  pointer array without using GFP_ATOMIC.

Remi Pommarel (4):
  drivers/tty/vt/keyboard.c: refactor getting/setting a keymap entry
  drivers/tty/vt/keyboard.c: add keyboard config for each vt's input
  drivers/tty/vt/keyboard.c: Make key_down[] bitmap input dependent
  drivers/tty/vt: add ioctl to manage input specific keyboard configs

 drivers/tty/vt/keyboard.c | 531 ++++++++++++++++++++++++++++++--------
 drivers/tty/vt/vt_ioctl.c |   9 +
 fs/compat_ioctl.c         |   3 +
 include/linux/vt_kern.h   |   4 +
 include/uapi/linux/kd.h   |   9 +
 5 files changed, 452 insertions(+), 104 deletions(-)

-- 
2.18.0

