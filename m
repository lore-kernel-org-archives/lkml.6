Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7D1ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706C32087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706C32087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeJTBcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:32:05 -0400
Received: from mr41.theemaillaundry.net ([109.169.43.45]:38108 "EHLO
        mr41.theemaillaundry.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbeJTBcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:32:05 -0400
Received: from mr40.theemaillaundry.net (mr40.theemaillaundry.net [109.169.43.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mr41.theemaillaundry.net (Postfix) with ESMTPS id 3F37B204C3;
        Fri, 19 Oct 2018 18:16:10 +0100 (IST)
Received: from mr301.theemaillaundry.net (mr301.theemaillaundry.net [109.169.43.93])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mr40.theemaillaundry.net (Postfix) with ESMTPS id 211583FE19;
        Fri, 19 Oct 2018 18:16:09 +0100 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mr301.theemaillaundry.net (Postfix) with ESMTP id AC7F380935;
        Fri, 19 Oct 2018 18:16:07 +0100 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mr301.theemaillaundry.net
X-Virus-Scanned: amavisd-new at theemaillaundry.net
Received: from mr301.theemaillaundry.net ([127.0.0.1])
        by localhost (mr301.theemaillaundry.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8CbXMfZw7ZW1; Fri, 19 Oct 2018 18:15:59 +0100 (IST)
Received: from statler.emutex.com (unknown [92.51.199.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mr301.theemaillaundry.net (Postfix) with ESMTPS id 3344180B37;
        Fri, 19 Oct 2018 18:15:59 +0100 (IST)
Received: from [10.10.68.81] (helo=dan-Latitude-E5450.emutex.com)
        by statler.emutex.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.84)
        (envelope-from <dan@emutex.com>)
        id 1gDYNS-0005CM-A0; Fri, 19 Oct 2018 18:15:58 +0100
From:   Dan O'Donovan <dan@emutex.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v2 0/3] UP Squared board drivers
Date:   Fri, 19 Oct 2018 18:15:31 +0100
Message-Id: <1539969334-24577-1-git-send-email-dan@emutex.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180421085009.28773-1-javier@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series adds platform support for AAEON's UP Squared, a x86 SBC
based on Apollo Lake [1]. Specifically, it enables control for the board
pin headers and for the LEDs, as both of these features are only
available behind a FPGA-based platform controller.

This is structured around a MFD driver that provides a regmap interface
to that platform controller to each MFD cell.

The series is carved out from an out-of-tree support patchset, initially
written for the original UP Board [2] and then extended through the past
year to support new entries in the lineup (UP Board, UP Squared and
UP Core) [3].

Here we only submit support for UP Squared to simplify review. Still,
the driver is designed so that it can easily gain support for the other
boards.

V1 was originally submitted by Javier Arteaga in April 2018 as an RFC [4].
This V2 aims to address the feedback gratefully received from that.

[1]: http://www.up-board.org/upsquared/specifications-up2/
[2]: https://lkml.kernel.org/r/1467648434-29080-1-git-send-email-dan@emutex.com
[3]: https://github.com/emutex/ubilinux-kernel/commits/upboard-4.9
[4]: https://lore.kernel.org/lkml/20180421085009.28773-1-javier@emutex.com/

V2:
* Rewrote regmap r/w handlers to avoid duplication and improve readability
* Simplified data passing between MFD parent and child device drivers
* Removed incorrect __init attribute from probe functions
* Moved MFD cell definitions into same patch as MFD driver and simplified them
* Promoted some dev_dbg instances to dev_err for probe error cases
* Decoupled MFD cell reference from ACPI driver data
* Miscellanous coding style improvements
* Fixed license mismatches

Javier Arteaga (3):
  mfd: upboard: Add UP2 platform controller driver
  leds: upboard: Add LED support
  pinctrl: upboard: Add UP2 pinctrl and gpio driver

 drivers/leds/Kconfig              |  10 +
 drivers/leds/Makefile             |   1 +
 drivers/leds/leds-upboard.c       | 104 ++++++++
 drivers/mfd/Kconfig               |  17 ++
 drivers/mfd/Makefile              |   1 +
 drivers/mfd/upboard.c             | 344 +++++++++++++++++++++++++
 drivers/pinctrl/Kconfig           |  13 +
 drivers/pinctrl/Makefile          |   1 +
 drivers/pinctrl/pinctrl-upboard.c | 519 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/upboard.h       |  44 ++++
 10 files changed, 1054 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c
 create mode 100644 drivers/mfd/upboard.c
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c
 create mode 100644 include/linux/mfd/upboard.h

-- 
2.7.4


------
This email has been scanned for spam and malware by The Email Laundry.

