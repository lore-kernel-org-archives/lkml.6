Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id v214GTRyHlsHAwAAmS7hNA
	; Mon, 11 Jun 2018 12:59:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 508B2607BB; Mon, 11 Jun 2018 12:59:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="jKyZ413b"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 86321601C3;
	Mon, 11 Jun 2018 12:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86321601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933160AbeFKM73 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 08:59:29 -0400
Received: from services.gouders.net ([141.101.32.176]:36280 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933082AbeFKM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:59:25 -0400
Received: from lena.gouders.net ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w5BCq6mj028784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 11 Jun 2018 14:52:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1528721540; bh=Pxcoe5KNDn1Lwvd2K0J51uJ5V+ChNW7fl2zW/X/EGHI=;
        h=From:To:Cc:Subject:Date;
        b=jKyZ413bbgjIyOSQnJ5gB2HBBVO9RV5caoeMq80nUoH/X/SUHthUYn3nL51uzF8Z3
         CFBxIueL2C+WqUMddj3eqf4r5fomhOkidlruErC69+v2wc/6P35q2yWNUeF2LEvxir
         ZIrbQFi2vhZ/IDoWmilv1tuX/YJQFXpUf9XV0GZ4=
From: Dirk Gouders <dirk@gouders.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc: Dirk Gouders <dirk@gouders.net>
Subject: [RFC v5 0/1] i-search navigation for mconf
Date: Mon, 11 Jun 2018 14:51:54 +0200
Message-Id: <20180611125155.21470-1-dirk@gouders.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I reworked the prototype for the i-search navigation concept.  It is
now more thoroughly tested and hopefully not a waste of time to have a
look at it.

For the focus-sensitive help text, I modified the function
print_autowrap() and for now called it print_autowrap_fill().  It
could replace the old function but does a bit more work than it.

With this navigation concept, mconf's behavior (in i-search mode) is
quite different from the known one, most noticeably the need to switch
focus to the buttons to be able to use <y|n|m|space>.   Ideas are very
welcome.

Interesting in i-search mode is the ability to not only search item
strings, but also their selection marks.  So, one can search for items
selected as a module, for example.

Dirk

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
  i-search navigation for mconf

 scripts/kconfig/lxdialog/dialog.h  |   3 +
 scripts/kconfig/lxdialog/menubox.c | 489 +++++++++++++++++++++++++++----------
 scripts/kconfig/lxdialog/util.c    | 106 +++++++-
 scripts/kconfig/mconf.c            |  68 ++++--
 4 files changed, 506 insertions(+), 160 deletions(-)

-- 
2.16.4
