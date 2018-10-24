Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1168C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8BD2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8BD2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeJXVdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:33:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:25390 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbeJXVdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:33:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 06:05:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,420,1534834800"; 
   d="scan'208";a="100281727"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 24 Oct 2018 06:05:05 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gFIqO-0004jP-PY; Wed, 24 Oct 2018 16:05:04 +0300
Date:   Wed, 24 Oct 2018 16:05:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan O'Donovan <dan@emutex.com>
Cc:     linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>
Subject: Re: [PATCH v2 0/3] UP Squared board drivers
Message-ID: <20181024130504.GU10650@smile.fi.intel.com>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539969334-24577-1-git-send-email-dan@emutex.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 06:15:31PM +0100, Dan O'Donovan wrote:
> Hi all,
> 
> This series adds platform support for AAEON's UP Squared, a x86 SBC
> based on Apollo Lake [1]. Specifically, it enables control for the board
> pin headers and for the LEDs, as both of these features are only
> available behind a FPGA-based platform controller.
> 
> This is structured around a MFD driver that provides a regmap interface
> to that platform controller to each MFD cell.
> 
> The series is carved out from an out-of-tree support patchset, initially
> written for the original UP Board [2] and then extended through the past
> year to support new entries in the lineup (UP Board, UP Squared and
> UP Core) [3].
> 
> Here we only submit support for UP Squared to simplify review. Still,
> the driver is designed so that it can easily gain support for the other
> boards.
> 
> V1 was originally submitted by Javier Arteaga in April 2018 as an RFC [4].
> This V2 aims to address the feedback gratefully received from that.

Are you attending ELCE in Edinburgh?

> 
> [1]: http://www.up-board.org/upsquared/specifications-up2/
> [2]: https://lkml.kernel.org/r/1467648434-29080-1-git-send-email-dan@emutex.com
> [3]: https://github.com/emutex/ubilinux-kernel/commits/upboard-4.9
> [4]: https://lore.kernel.org/lkml/20180421085009.28773-1-javier@emutex.com/
> 
> V2:
> * Rewrote regmap r/w handlers to avoid duplication and improve readability
> * Simplified data passing between MFD parent and child device drivers
> * Removed incorrect __init attribute from probe functions
> * Moved MFD cell definitions into same patch as MFD driver and simplified them
> * Promoted some dev_dbg instances to dev_err for probe error cases
> * Decoupled MFD cell reference from ACPI driver data
> * Miscellanous coding style improvements
> * Fixed license mismatches
> 
> Javier Arteaga (3):
>   mfd: upboard: Add UP2 platform controller driver
>   leds: upboard: Add LED support
>   pinctrl: upboard: Add UP2 pinctrl and gpio driver
> 
>  drivers/leds/Kconfig              |  10 +
>  drivers/leds/Makefile             |   1 +
>  drivers/leds/leds-upboard.c       | 104 ++++++++
>  drivers/mfd/Kconfig               |  17 ++
>  drivers/mfd/Makefile              |   1 +
>  drivers/mfd/upboard.c             | 344 +++++++++++++++++++++++++
>  drivers/pinctrl/Kconfig           |  13 +
>  drivers/pinctrl/Makefile          |   1 +
>  drivers/pinctrl/pinctrl-upboard.c | 519 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/upboard.h       |  44 ++++
>  10 files changed, 1054 insertions(+)
>  create mode 100644 drivers/leds/leds-upboard.c
>  create mode 100644 drivers/mfd/upboard.c
>  create mode 100644 drivers/pinctrl/pinctrl-upboard.c
>  create mode 100644 include/linux/mfd/upboard.h
> 
> -- 
> 2.7.4
> 
> 
> ------
> This email has been scanned for spam and malware by The Email Laundry.
> 

-- 
With Best Regards,
Andy Shevchenko


