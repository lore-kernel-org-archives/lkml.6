Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932587AbeE3V2a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:28:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57115 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932364AbeE3V2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:28:21 -0400
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] have the vt console preserve unicode characters
Date: Wed, 30 May 2018 17:27:40 -0400
Message-Id: <20180530212745.10997-1-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.17.0
X-Pobox-Relay-ID: 5EC85C38-6450-11E8-95E8-67830C78B957-78420484!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vt code translates UTF-8 strings into glyph index values and stores
those glyph values directly in the screen buffer. Because there can only
be at most 512 glyphs, it is impossible to represent most unicode
characters, in which case a default glyph (often '?') is displayed
instead. The original unicode value is then lost.

This also means that the /dev/vcs* devices only provide user space with
glyph index values, and then user applications must get hold of the
unicode-to-glyph table the kernel is using in order to back-translate
those into actual characters. It is not possible to get back the original
unicode value when multiple unicode characters map to the same glyph,
especially for the vast majority that maps to the default replacement
glyph.

The 512-glyph limitation is inherent to VGA displays, but users of
/dev/vcs* shouldn't have to be restricted to a narrow unicode space from
lossy screen content because of that. This is especially true for
accessibility applications such as BRLTTY that rely on /dev/vcs to rander
screen content onto braille terminals.

This patch series introduces unicode support to /dev/vcs* devices,
allowing full unicode access from userspace to the vt console which
can, amongst other purposes, appropriately translate actual unicode
screen content into braille. Memory is allocated, and possible CPU
overhead introduced, only if /dev/vcsu is read at least once.

I'm a prime user of this feature, as well as the BRLTTY maintainer Dave Mielke
who implemented support for this in BRLTTY. There is therefore a vested
self interest to maintain this feature as necessary.

Patch #1 has been picked up by Greg already (commit 4b4ecd9cb8 in
linux-next) but it is included here as well, as the rest of the series
depends on it to apply properly.

Patch #5 was used for validation and is included for completeness, however
if people think it is unappropriate for mainline then it can be dropped.

This is also available on top of v4.17-rc7 here:

  git://git.linaro.org/people/nicolas.pitre/linux vt-unicode

diffstat:

 drivers/tty/vt/vc_screen.c     |  90 +++++++--
 drivers/tty/vt/vt.c            | 366 +++++++++++++++++++++++++++++++++--
 include/linux/console_struct.h |   2 +
 include/linux/selection.h      |   5 +
 4 files changed, 429 insertions(+), 34 deletions(-)
