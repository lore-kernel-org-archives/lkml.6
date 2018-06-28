Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FECC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B83208A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B83208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932898AbeF1DNg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:13:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:58288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753060AbeF1DNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:13:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 31F05ACA8;
        Thu, 28 Jun 2018 03:13:33 +0000 (UTC)
Date:   Thu, 28 Jun 2018 05:13:32 +0200
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Kees Cook <keescook@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>, andresx7@gmail.com,
        torvalds@linux-foundation.org
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 0/2] Avoid firmware warning in imx-sdma
Message-ID: <20180628031332.GE21242@wotan.suse.de>
References: <20180622144951.17464-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622144951.17464-1-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 04:49:49PM +0200, Sebastian Reichel wrote:
> Subject: Avoid firmware warning in imx-sdma
> 
> Hi,
> 
> I grabbed the first patch from patchwork from an 2017 patch series. As far as I
> could see, their usecase vanished due to switching to sync FW API (that already
> supports NOWARN). This series fixes a kernel warning in imx-sdma driver, which
> works fine with ROM firmware (and already prints an info message about ROM
> firmware being used due to missing firmware file). This has been tested on
> arch/arm/boot/dts/imx53-ppd.dts.

Please read these threads about the state of affairs with respect to data
driven Vs functional API evolution on the firmware API [0] and my latests
recommendation for what to do for the async firmware API [1].

Then, recently I've come to realize that perhaps the best thing actually
is to *break* the cycle for the async API and make it more functional driven.

For instance the call to not use the uevent should be made a separate
call as only two drivers use it:

  o CONFIG_LEDS_LP55XX_COMMON
  o CONFIG_DELL_RBU

Using a struct would make it data driven. A flags approach would make it
more flexible and I although I think this is reasonable, if we wanted
to match the sync API, we'd have one call per variation.

It is therefore subjective whether or not to keep a flags based mechanism
for the async API or not. If we at least use flags, we'd just break away
from the sync approach.

I'll let Kees and Greg pick and choose how they would prefer to see this
broken down now as I am off on vacation today and won't be back until the
middle of next month.
                                                                                
[0] https://lkml.kernel.org/r/20180421173650.GW14440@wotan.suse.de              
[1] https://lkml.kernel.org/r/20180422202609.GX14440@wotan.suse.de 

  Luis
