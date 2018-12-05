Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16A1C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7205820850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7205820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeLEJhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:37:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:57528 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbeLEJg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:36:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 01:36:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; 
   d="scan'208";a="104989232"
Received: from mylly.fi.intel.com (HELO [10.237.72.59]) ([10.237.72.59])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2018 01:36:53 -0800
Subject: Re: [PATCH] USB: serial: console: fix reported terminal settings
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Florian Zumbiehl <florz@florz.de>
References: <20181204155904.GC18087@localhost>
 <20181204160036.24625-1-johan@kernel.org> <20181204161518.GA17941@kroah.com>
 <20181204163155.GD18087@localhost>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <4e395eb4-739a-05df-e14d-e32f9cfefdd3@linux.intel.com>
Date:   Wed, 5 Dec 2018 11:36:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181204163155.GD18087@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 6:31 PM, Johan Hovold wrote:
> On Tue, Dec 04, 2018 at 05:15:18PM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Dec 04, 2018 at 05:00:36PM +0100, Johan Hovold wrote:
>>> The USB-serial console implementation has never reported the actual
>>> terminal settings used. Despite storing the corresponding cflags in its
>>> struct console, this was never honoured on later tty open() where the
>>> tty termios would be left initialised to the driver defaults.
>>>
>>> Unlike the serial console implementation, the USB-serial code calls
>>> subdriver open() already at console setup. While calling set_termios()
>>> before open() looks like it could work for some USB-serial drivers,
>>> others definitely do not expect this, so modelling this after serial
>>> core is going to be intrusive, if at all possible.
>>>
>>> Instead, use a (renamed) tty helper to save the termios data used at
>>> console setup, so that the tty termios reflects the actual terminal
>>> settings after a subsequent tty open().
>>>
>>> Note that the calls to tty_init_termios() (tty_driver_install()) and
>>> tty_save_termios() are serialised using the disconnect mutex.
>>>
>>> This specifically fixes a regression that was triggered by a recent
>>> change adding software flow control to the pl2303 driver: a getty trying
>>> to disable flow control while leaving the baud rate unchanged would now
>>> also set the baud rate to the driver default (prior to the flow-control
>>> change this had been a noop).
>>>
>>> Fixes: 7041d9c3f01b ("USB: serial: pl2303: add support for tx xon/xoff flow control")
>>> Cc: stable <stable@vger.kernel.org>	# 4.18
>>> Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>>> Cc: Florian Zumbiehl <florz@florz.de>
>>> Signed-off-by: Johan Hovold <johan@kernel.org>
>>> ---
>>>   drivers/tty/tty_io.c         | 11 +++++++++--
>>>   drivers/usb/serial/console.c |  2 +-
>>>   include/linux/tty.h          |  1 +
>>>   3 files changed, 11 insertions(+), 3 deletions(-)
>>
>> Ah, messy :)
>>
>> Want me to take this through my tty tree?
> 
> If you prefer. I was planning on including this in a USB-serial pull
> request for -rc6 since it fixes a user-reported regression, but perhaps
> taking this through your tty-linus branch (which already holds a console
> fix) is easier/faster.
> 
> We should wait for Jarkko to confirm that this fixes the problem he
> reported first, though.
> 
Great, this fixed the issue for both pl2303 based adapters I reported.

Tested on top of 0072a0c14d5b ("Merge tag 'media/v4.20-4' of 
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media")

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
