Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AB2C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B31620896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="pUUWIWZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B31620896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756698AbeFOWg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:36:28 -0400
Received: from services.gouders.net ([141.101.32.176]:33583 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756583AbeFOWg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:36:26 -0400
Received: from lena.gouders.net (ipservice-047-071-023-039.pools.arcor-ip.net [47.71.23.39])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w5FMTCfH020007
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 16 Jun 2018 00:29:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1529101767; bh=M01q+/dgp1UXPKZAfgyUD9hBfKSMRu2W48WEQ5B24tI=;
        h=From:To:Cc:Subject:Date;
        b=pUUWIWZ06nJESG5C9r3fSyokZRUbDjz114LmBytwSSecztHbsZFOiENHBebxi2Ouw
         1mFWBC3TK/cecUoQDbSnCZWtzOJKPFnbugN/AEYIFAQJC3tRQ6BR5+2fw2/6+VzUUo
         qj/lKGDl/jYBvJ+celPISkJI4k7+DPIfbtfN/vqM=
From:   Dirk Gouders <dirk@gouders.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Dirk Gouders <dirk@gouders.net>
Subject: [RFC v6 0/1] mconf: global i-search in menu structure
Date:   Sat, 16 Jun 2018 00:29:06 +0200
Message-Id: <20180615222907.23449-1-dirk@gouders.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

version 6 of this RFC was mainly influenced by a discussion with Randy
Dunlap about a patch for i-search in nconf.

In that discussion I stated that it would be a lot of work to
implement a global i-search but while thinking about that statement
afterwards, I realized that most of the needed functionality is
already there in search_conf(), the search function for config
symbols.

The menu tree is converted in a flat menu to ease the implementation
of a cyclic i-search and the rest of the implementation does no longer
interfere so much with current menu handling.

Dirk

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
  mconf: global i-search in menu structure

 scripts/kconfig/lxdialog/checklist.c |   2 +-
 scripts/kconfig/lxdialog/dialog.h    |   3 +-
 scripts/kconfig/lxdialog/inputbox.c  |   2 +-
 scripts/kconfig/lxdialog/menubox.c   | 177 +++++++++++++++++++++++++++++-----
 scripts/kconfig/lxdialog/util.c      |  37 ++++++-
 scripts/kconfig/lxdialog/yesno.c     |   2 +-
 scripts/kconfig/mconf.c              | 181 +++++++++++++++++++++++++++++++++--
 7 files changed, 364 insertions(+), 40 deletions(-)

-- 
2.16.4

