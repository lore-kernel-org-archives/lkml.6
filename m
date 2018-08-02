Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBB0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0723021566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0723021566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeHBVbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:31:48 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:41118 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeHBVbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:31:48 -0400
Received: from ravnborg.org (unknown [158.248.196.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 0A48A804E4;
        Thu,  2 Aug 2018 21:39:10 +0200 (CEST)
Date:   Thu, 2 Aug 2018 21:39:09 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [RFC PATCH v1 0/5] Add pardata bus + tinydrm driver
Message-ID: <20180802193909.GA11443@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=85nIN3Etu3eYjTezwu4A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an RFC - to get some responses on the overall design.
The code builds but has not yet been tested on any HW.
Before investing more time into this I would like some feedback
if this is the right way forward or a different design should
be pursued.

The problem to solve is that I have a propriatary ARM based board
with a display that is connected using a parallel bus.
The display is capable of showing graphics
so it is more advanced than what is found in auxdisplay/
I know there are others using a display connected
usign a parallel data bus, so this is not a unique problem
for my board alone. But I do not expect many users as
any modern design likely uses SPI or similar.

The old (proprietary) approach was to implement a char driver
and then let some 3rd party lib use the char driver to write to the
display.
The goal is to move to a more modern world where I expect
to have a simple Qt based program running that can
be used for a few simple things.
(I do not expect any high performance and do not need it).

Implementation:

A pardata bus is implemented.
It uses a platform_driver to hook into the DT.
When probed the pardatabus driver creates pardata devices
for all child nodes in the tree.

Within tinydrm the pardata support is used to implement
a driver for the display I have (Winstar wg160160).
A library module is used to implement the more basic
things allowing us to have a more simple driver,
and thus making it simpler to add new drivers.

The implmentation uses array support in gpiolib
to try to have some performance on screen updates.


TODO:
- Test on HW
- Add locking so there can be more than one user on the bus
- Improve pardata.rst documentation
- Add support for a sparkfun parallel data display
  (To verify that the library is generic)
- I may add a class if I see the need
- Likewise I may add sysfs attributes if there is a need for it

Any comments appreciated!

	Sam


Sam Ravnborg (5):
      dt-bindings: add parallel data bus (pardata)
      pardata: new bus for parallel data access
      tinydrm: add support for parallel data displays
      dt-bindings: add winstar,wg160160 display bindings
      tinydrm: add winstar wg160160 driver


 .../bindings/display/winstar,wg160160.txt          |  53 +++
 .../bindings/pardata/parallel-data-bus.txt         |  60 +++
 Documentation/driver-api/index.rst                 |   1 +
 Documentation/driver-api/pardata.rst               |  60 +++
 MAINTAINERS                                        |  14 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/gpu/drm/tinydrm/Kconfig                    |  13 +
 drivers/gpu/drm/tinydrm/Makefile                   |   2 +
 drivers/gpu/drm/tinydrm/pardata-dbi.c              | 417 +++++++++++++++++++++
 drivers/gpu/drm/tinydrm/wg160160.c                 | 298 +++++++++++++++
 drivers/pardata/Kconfig                            |  17 +
 drivers/pardata/Makefile                           |   5 +
 drivers/pardata/pardata.c                          | 282 ++++++++++++++
 include/drm/tinydrm/pardata-dbi.h                  | 257 +++++++++++++
 include/linux/pardata.h                            | 138 +++++++
 16 files changed, 1620 insertions(+)
