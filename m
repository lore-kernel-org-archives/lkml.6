Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662CFC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB4720883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfAHQTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:19:46 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44422 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbfAHQTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:19:45 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 73D4320763; Tue,  8 Jan 2019 17:19:41 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1CB0620763;
        Tue,  8 Jan 2019 17:19:41 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 0/4] Add device links to clocks
Date:   Tue,  8 Jan 2019 17:19:36 +0100
Message-Id: <20190108161940.4814-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While working on suspend to RAM feature, I ran into troubles multiple
times when clocks where not suspending/resuming at the desired time. I
had a look at the core and I think the same logic as in the
regulator's core may be applied here to (very easily) fix this issue:
using device links.

The only additional change I had to do was to always (when available)
populate the device entry of the core clock structure so that it could
be used later. This is the purpose of patch 1. Patch 2 actually adds
support for device links.

Here is a step-by-step explanation of how links are managed, following
Maxime Ripard's suggestion.


The order of probe has no importance because the framework already
handles orphaned clocks so let's be simple and say there are two root
clocks, not depending on anything, that are probed first: xtal0 and
xtal1. None of these clocks have a parent, there is no device link in
the game, yet.

   +----------------+            +----------------+
   |                |            |                |
   |                |            |                |
   |   xtal0 core   |            |   xtal1 core   |
   |                |            |                |
   |                |            |                |
   +-------^^-------+            +-------^^-------+
           ||                            ||
           ||                            ||
   +----------------+            +----------------+
   |                |            |                |
   |   xtal0 clk    |            |   xtal1 clk    |
   |                |            |                |
   +----------------+            +----------------+

Then, a peripheral clock periph0 is probed. His parent is xtal1. The
clock_register_*() call will run __clk_init_parent() and a link between
periph0's core and xtal1's core will be created and stored in
periph0's core->parent_clk_link entry.

   +----------------+            +----------------+
   |                |            |                |
   |                |            |                |
   |   xtal0 core   |            |   xtal1 core   |
   |                |            |                |
   |                |            |                |
   +-------^^-------+            +-------^^-------+
           ||                            ||
           ||                            ||
   +----------------+            +----------------+
   |                |            |                |
   |   xtal0 clk    |            |   xtal1 clk    |
   |                |            |                |
   +----------------+            +-------^--------+
                                         |
                                         |
                          +--------------+
                          |   ->parent_clk_link
                          |
                  +----------------+
                  |                |
                  |                |
                  |  periph0 core  |
                  |                |
                  |                |
                  +-------^^-------+
                          ||
                          ||
                  +----------------+
                  |                |
                  |  periph0 clk 0 |
                  |                |
                  +----------------+

Then, device0 is probed and "get" the periph0 clock. clk_get() will be
called and a struct clk will be instantiated for device0 (called in
the figure clk 1). A link between device0 and the new clk 1 instance of
periph0 will be created and stored in the clk->consumer_link entry.

   +----------------+            +----------------+
   |                |            |                |
   |                |            |                |
   |   xtal0 core   |            |   xtal1 core   |
   |                |            |                |
   |                |            |                |
   +-------^^-------+            +-------^^-------+
           ||                            ||
           ||                            ||
   +----------------+            +----------------+
   |                |            |                |
   |   xtal0 clk    |            |   xtal1 clk    |
   |                |            |                |
   +----------------+            +-------^--------+
                                         |
                                         |
                          +--------------+
                          |   ->parent_clk_link
                          |
                  +----------------+
                  |                |
                  |                |
                  |  periph0 core  |
                  |                <-------------+
                  |                <-------------|
                  +-------^^-------+            ||
                          ||                    ||
                          ||                    ||
                  +----------------+    +----------------+
                  |                |    |                |
                  |  periph0 clk 0 |    |  periph0 clk 1 |
                  |                |    |                |
                  +----------------+    +----------------+
                                                |
                                                | ->consumer_link
                                                |
                                                |
                                                |
                                        +-------v--------+
                                        |    device0     |
                                        +----------------+

Right now, device0 is linked to periph0, itself linked to xtal1 so
everything is fine.

Now let's get some fun: the new parent of periph0 is xtal1. The process
will call clk_reparent(), periph0's core->parent_clk_link will be
destroyed and a new link to xtal1 will be setup and stored. The
situation is now that device0 is linked to periph0 and periph0 is
linked to xtal1, so the dependency between device0 and xtal1 is still
clear.

   +----------------+            +----------------+
   |                |            |                |
   |                |            |                |
   |   xtal0 core   |            |   xtal1 core   |
   |                |            |                |
   |                |            |                |
   +-------^^-------+            +-------^^-------+
           ||                            ||
           ||                            ||
   +----------------+            +----------------+
   |                |            |                |
   |   xtal0 clk    |            |   xtal1 clk    |
   |                |            |                |
   +-------^--------+            +----------------+
           |
           |                           \ /
           +----------------------------x
      ->parent_clk_link   |            / \
                          |
                  +----------------+
                  |                |
                  |                |
                  |  periph0 core  |
                  |                <-------------+
                  |                <-------------|
                  +-------^^-------+            ||
                          ||                    ||
                          ||                    ||
                  +----------------+    +----------------+
                  |                |    |                |
                  |  periph0 clk 0 |    |  periph0 clk 1 |
                  |                |    |                |
                  +----------------+    +----------------+
                                                |
                                                | ->consumer_link
                                                |
                                                |
                                                |
                                        +-------v--------+
                                        |    device0     |
                                        +----------------+

I assume periph0 cannot be removed while there are devices using it,
same for xtal0.

What can happen is that device0 'put' the clock periph0. The relevant
link is deleted and the clk instance dropped.

   +----------------+            +----------------+
   |                |            |                |
   |                |            |                |
   |   xtal0 core   |            |   xtal1 core   |
   |                |            |                |
   |                |            |                |
   +-------^^-------+            +-------^^-------+
           ||                            ||
           ||                            ||
   +----------------+            +----------------+
   |                |            |                |
   |   xtal0 clk    |            |   xtal1 clk    |
   |                |            |                |
   +-------^--------+            +----------------+
           |
           |                           \ /
           +----------------------------x
      ->parent_clk_link   |            / \
                          |
                  +----------------+
                  |                |
                  |                |
                  |  periph0 core  |
                  |                |
                  |                |
                  +-------^^-------+
                          ||
                          ||
                  +----------------+
                  |                |
                  |  periph0 clk 0 |
                  |                |
                  +----------------+

Now we can unregister periph0: link with the parent will be destroyed
and the clock may be safely removed.

   +----------------+            +----------------+
   |                |            |                |
   |                |            |                |
   |   xtal0 core   |            |   xtal1 core   |
   |                |            |                |
   |                |            |                |
   +-------^^-------+            +-------^^-------+
           ||                            ||
           ||                            ||
   +----------------+            +----------------+
   |                |            |                |
   |   xtal0 clk    |            |   xtal1 clk    |
   |                |            |                |
   +----------------+            +----------------+


This is my understanding of the common clock framework and how links
can be added to it.

As a result, here are the links created during the boot of an
ESPRESSObin:

----->8-----
marvell-armada-3700-tbg-clock d0013200.tbg: Linked as a consumer to d0013800.pinctrl:xtal-clk
marvell-armada-3700-tbg-clock d0013200.tbg: Dropping the link to d0013800.pinctrl:xtal-clk
marvell-armada-3700-tbg-clock d0013200.tbg: Linked as a consumer to d0013800.pinctrl:xtal-clk
marvell-armada-3700-periph-clock d0013000.nb-periph-clk: Linked as a consumer to d0013200.tbg
marvell-armada-3700-periph-clock d0013000.nb-periph-clk: Linked as a consumer to d0013800.pinctrl:xtal-clk
marvell-armada-3700-periph-clock d0018000.sb-periph-clk: Linked as a consumer to d0013200.tbg
mvneta d0030000.ethernet: Linked as a consumer to d0018000.sb-periph-clk
xhci-hcd d0058000.usb: Linked as a consumer to d0018000.sb-periph-clk
xenon-sdhci d00d0000.sdhci: Linked as a consumer to d0013000.nb-periph-clk
xenon-sdhci d00d0000.sdhci: Dropping the link to d0013000.nb-periph-clk
mvebu-uart d0012000.serial: Linked as a consumer to d0013800.pinctrl:xtal-clk
advk-pcie d0070000.pcie: Linked as a consumer to d0018000.sb-periph-clk
xenon-sdhci d00d0000.sdhci: Linked as a consumer to d0013000.nb-periph-clk
xenon-sdhci d00d0000.sdhci: Linked as a consumer to regulator.1
cpu cpu0: Linked as a consumer to d0013000.nb-periph-clk
cpu cpu0: Dropping the link to d0013000.nb-periph-clk
cpu cpu0: Linked as a consumer to d0013000.nb-periph-clk
-----8<-----

Thanks,
Miquèl

Changes since v3:
=================
* Rebased on top of Stephen's 'clk-parent-rewrite' branch. Stephen
  already updated and took the patch 'clk: core: clarify the check for
  runtime PM' so it is not present in this series anymore.
* Updated the code to fit with the new core. Kept the helpers that
  were added to clk/clk.c (turning them static) for more readability.
* While working on clocks, I discovered a typo in an a3700-tbg driver
  error message. A patch has been added to correct this typo.

Changes since v2:
=================
* Fixed compilation issue when not using the common clock framework:
  removed the static keyword in front of clk_link/unlink_consumer()
  dummy definitions in clkdev.c.

Changes since v1:
=================
* Add clock->clock links, not only device->clock links.
* Helpers renamed:
  > clk_{link,unlink}_hierarchy()
  > clk_{link,unlink}_consumer()
* Add two patches to pass a "struct device" to the clock registration
  helper. This way device links may work between clocks themselves
  (otherwise the link is not created).


Miquel Raynal (4):
  clk: core: link consumer with clock driver
  clk: mvebu: armada-37xx-tbg: fix error message
  clk: mvebu: armada-37xx-tbg: fill the device entry when registering
    the clocks
  clk: mvebu: armada-37xx-xtal: fill the device entry when registering
    the clock

 drivers/clk/clk.c                    | 50 +++++++++++++++++++++++++++-
 drivers/clk/mvebu/armada-37xx-tbg.c  |  8 +++--
 drivers/clk/mvebu/armada-37xx-xtal.c |  3 +-
 3 files changed, 56 insertions(+), 5 deletions(-)

-- 
2.19.1

