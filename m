Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BF8C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 12:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE721208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 12:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="ABa4CvmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE721208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936772AbeFQMWv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 08:22:51 -0400
Received: from services.gouders.net ([141.101.32.176]:34912 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933343AbeFQMWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 08:22:49 -0400
Received: from lena.gouders.net (ipservice-047-071-023-039.pools.arcor-ip.net [47.71.23.39])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w5HCFcFg006472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 17 Jun 2018 14:15:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1529237750; bh=UdIEEo4CPb3Qp/y/fVZU5FcZOTYlw1d7e7SDyda2bts=;
        h=From:To:Cc:Subject:Date;
        b=ABa4CvmQk0nh+UEMRBlXetK9d+U3F0zKPkv5PXcoi9rnhNoyOiSWUj74jeG0vKYDY
         rSdagBnoHbSzBrPizmvCt/HVGwpcyuVuRl+GvcyTvjWM7hkn/RlfVb+K3NRdxKNN7h
         qfGkGqy5b0g6ALu5fQuU1UE9Xa9h48X8crjzw+Ek=
From:   Dirk Gouders <dirk@gouders.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Dirk Gouders <dirk@gouders.net>
Subject: [RFC v7 0/1] mconf: global i-search in menu prompts
Date:   Sun, 17 Jun 2018 14:15:33 +0200
Message-Id: <20180617121534.4809-1-dirk@gouders.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I reworked this RFC and checked it against submitting-patches.rst so
the quality should have raised.

In that document, I read that permission of the person should be asked
for before adding a Suggested-by.  So, apologies go to Sam.  I
removed that line from the commit message and am now asking for your
permission to add it.

Most noticeable changes are that the exact starting position before
doing i-search is now remebered and i-search stays on the current item
if a character was added and the new string also matches this item.

Also, compiler warnings were eliminated and A_UNDERLINE was replaced
with A_STANDOUT to mark active menu items when the focus is on the
buttons, because I tested mconf on a tty where underlines were not
visible.  For a complete list of changes see below.

Dirk

Changes in v7:

* make menu_isearch() return void

* Suggested-by removed, ask for Sam's permission

* Rework i-search instructions text

* Remember exact starting position in menu

* Stay on menu item if it matches pattern with a character added

* Fix print_autowrap for short texts

* Focus on buttons: use A_STANDOUT for current menu item

* Fix compiler warnings

* Don't exclude comments in searches

* ESC also clears search string

* Remove the last parameter of print_isearch and use focus_on_buttons
  instead

* Document changes to print_autowrap and conf() in commit message

* Rework comments in the code

* Rework commit message, add a motivation part

* Free serialized menu array on exit

Changes in v6:

* The modification of the function print_autowrap() was reworked and
  is no longer a separate function.

* The i-search navigation was completely reworked and now works on the
  whole menu tree.

* Hotkeys are back, because they do not interfere that much with this
  version of i-search navigation.

Changes in v5:

* More thoroughly tested code

* Hotkey navigation concept completely dropped

* Printable characters except special ones form the search string

* Focus-sensitive help text above menu

* DEL erases search string

* Matching string is highlighted in selected menu item

* README help text adjusted

Changes in v4:

* Prototype: consequent i-search navigation concept

Changes in v3:

* Use current git tree to make the patch apply.

* Eliminate debugging output to stderr.

Changes in v2:

* Additionally to CTRL-s, \ can be used to start isearch.

* Raw mode is off by default an can be enabled by an environment
  variable MENUCONFIG_RAW_MODE.

* I also added a variable for toggling raw mode but did not implement
  anything else.

* The isearch indicator is now displayed as soon as isearch is
  started.

* Any key except \, CTRL-s, alphanumeric characters and space
  terminates isearch and -- except ESC ESC -- is further processed,
  e.g. ENTER terminates isearch and is then used to navigate into a
  submenu.

* Problems with mismatches and matches above the current position were
  fixed.

Dirk Gouders (1):
  mconf: global i-search in menu prompts

 scripts/kconfig/lxdialog/checklist.c |   2 +-
 scripts/kconfig/lxdialog/dialog.h    |   3 +-
 scripts/kconfig/lxdialog/inputbox.c  |   2 +-
 scripts/kconfig/lxdialog/menubox.c   | 181 +++++++++++++++++++++---
 scripts/kconfig/lxdialog/util.c      |  45 +++++-
 scripts/kconfig/lxdialog/yesno.c     |   2 +-
 scripts/kconfig/mconf.c              | 202 +++++++++++++++++++++++++--
 7 files changed, 398 insertions(+), 39 deletions(-)

-- 
2.17.1

