Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22692C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CC820846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="Ve0cuMbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CC820846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933066AbeFTIuX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:50:23 -0400
Received: from services.gouders.net ([141.101.32.176]:55601 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932891AbeFTIt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:49:27 -0400
Received: from lena.gouders.net ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w5K8gRCc013731
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 20 Jun 2018 10:42:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1529484158; bh=6NL1EFwGkIcT/x/3Mr1VNv19qKolHcJ28+B9DaBP5Mc=;
        h=From:To:Cc:Subject:Date;
        b=Ve0cuMbzVPgsxoJ8XoDdVBbYAUKpldejHO1tMMtBT/5cz/PfUjixrFtiXyV3h5g6q
         Su/irfo7gL4Q0m9s5PuWKZEIE/vLdOUfWrzeQoA5HXw8AdmP7+SQWODGTcEtnxAETt
         Q276iRCI8MjBMVFnNtKeiqhukLtx8rKdzExQhwBg=
From:   Dirk Gouders <dirk@gouders.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Dirk Gouders <dirk@gouders.net>
Subject: [RFC v8 0/1] mconf: global i-search in menu prompts
Date:   Wed, 20 Jun 2018 10:42:16 +0200
Message-Id: <20180620084217.8597-1-dirk@gouders.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Randy noticed segfaults with the last version and although that could
be fixed, this version got rid of the additional data structure,
because it is not needed to do the traversal.

As everything is in place more or less now, it became rather
forcibly clear that the tree traversal can be done with just a short
helper function (see commit message).

What I meanwhile noticed is that a search for 'retpoline' did not
match any prompt, whereas the same search in config symbols gets a
hit.  That made me think if i-search should search the symbol names as
well but in this case, it would not be immediately clear to users why
menu items produced a hit...

Anyway, this time, I provide a sample Kconfig file that can be used to
easily watch the traversal as shown in the example in the commit
message (just repeatedly search for 'a' from any position in the
menu):

config a
       bool "a"

config b
       bool "b / a"
       depends on a

config c
       bool "c / a"

menu "d / a"

config e
       bool "e / a"

endmenu

config f
       bool "f / a"

Dirk

Changes in v8:

* Get rid of flat_array and use a short helper function
  menu_get_next() for tree traversal.

* Correct typos reported by Randy Dunlap.

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

 scripts/kconfig/lkc.h                |   1 +
 scripts/kconfig/lxdialog/checklist.c |   2 +-
 scripts/kconfig/lxdialog/dialog.h    |   3 +-
 scripts/kconfig/lxdialog/inputbox.c  |   2 +-
 scripts/kconfig/lxdialog/menubox.c   | 181 ++++++++++++++++++++++++++++++-----
 scripts/kconfig/lxdialog/util.c      |  45 ++++++++-
 scripts/kconfig/lxdialog/yesno.c     |   2 +-
 scripts/kconfig/mconf.c              | 173 +++++++++++++++++++++++++++++++--
 scripts/kconfig/menu.c               |  28 ++++++
 9 files changed, 398 insertions(+), 39 deletions(-)

-- 
2.13.6

