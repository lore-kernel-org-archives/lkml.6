Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C40C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30AF206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30AF206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=whitequark.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeIESvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:51:12 -0400
Received: from uruz.whitequark.org ([188.166.218.19]:50816 "EHLO
        uruz.whitequark.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIESvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:51:11 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2018 14:51:09 EDT
Received: by uruz.whitequark.org (Postfix, from userid 1002)
        id 87707207FE; Wed,  5 Sep 2018 14:13:29 +0000 (UTC)
To:     Mario.Limonciello@dell.com
Subject: Re: USB type-C altmode support for UCSI
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Sep 2018 14:13:29 +0000
From:   whitequark <whitequark@whitequark.org>
Cc:     heikki.krogerus@linux.intel.com, mika.westerberg@linux.intel.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <4df3faaee8904d81bf7737b5f2daaff5@ausx13mpc120.AMER.DELL.COM>
References: <1e8398f2c1790890f40b69f12e2934e3@whitequark.org>
 <20180903140623.GD15112@kuha.fi.intel.com>
 <28522bb57c5d8f49416b9174b19b1625@whitequark.org>
 <20180905132429.GB25121@kuha.fi.intel.com>
 <4df3faaee8904d81bf7737b5f2daaff5@ausx13mpc120.AMER.DELL.COM>
Message-ID: <a2f79cc4d9a0aab4a832de31b7ddc52d@whitequark.org>
X-Sender: whitequark@whitequark.org
User-Agent: Roundcube Webmail/1.2.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-05 13:50, Mario.Limonciello@dell.com wrote:
>> > (There's also an UCSI bug where no notifications appear when connecting
>> > a device, only when disconnecting and only once, but it can be worked
>> > around by reloading the module, so it isn't critical. Not sure what's up
>> > with that either.)
>> 
>> This is indeed a separate issue, and you are the second person that
>> reports it. Either the (EC) firmware on those laptops is not
>> generating the connection event as is should for some reason, or the
>> EC driver in Linux kernel fails to deliver the event to the UCSI
>> driver. I don't have XPS 13 that I could use to reproduce the issue
>> unfortunately.
>> 
>> Mario! Can you help with this?
>> 

First, thanks everyone for spending time on this! I really appreciate 
it.

> 
> I need to know which system this was and which BIOS FW package to try
> to reproduce
> if I can pass this to the right people, 9360/9370?  Current FW?

Here is all relevant system info, taken from dmidecode:

System Information
         Manufacturer: Dell Inc.
         Product Name: XPS 13 9360
         Version: Not Specified
         Serial Number: J5NCSF2
         UUID: 4C4C4544-0035-4E10-8043-CAC04F534632

BIOS Information
         Vendor: Dell Inc.
         Version: 2.9.0
         Release Date: 07/09/2018

> Is this happening with all type-C devices?  Or just Thunderbolt?  Or
> (worse) just that TBT device?

Unfortunately this is the only TBT and (native) USB-C device I own.
Non-Apple TBT3 to TBT2 adapters are very expensive, and I wanted to
avoid that by getting this Apple adapter.

> > This laptop doesn't support SET_NEW_CAM command so I can't do anything
> > laptop-side. I can probably modify adapter firmware if I know what to
> > change, but I'm not sure why this doesn't work in the first place.
> 
> I don't really see any problems with USB Type-C here. The PD
> controller seems to take the steps that it should take when a device
> is plugged to the connector: It checks the identity, SVIDs and their
> modes, etc. I don't know based on that sniffer output has the
> Thunderbolt alternate mode been entered or not, but I would imagine
> the PD controller does not try to enter any modes unless the
> Thunderbolt controller explicitly tells it to do so.

The Thunderbolt altmode is not entered, there are no attempts to do so.

> Some Dell XPS systems do not support that TBT2<->TBT3 adapter. I think 
> I
> tried this on XPS 15 9550 and XPS 13 9365 and in both cases it is
> rejected. I think it has something to do with the PD controller
> firmware. Same goes if you Plug TB16 dock and to that dock then connect
> the adapter + device.

This is my understanding as well, however I'd like to fix this issue.
 From looking at the BIOS image I can see that the 9360 uses a TPS65982
USB PD controller. The adapter uses a TPS65983A (confusingly remarked
by Apple as CD3215B). I've seen reports on the web that there is some
inherent incompatibility between TPS65982 and TPS65983, however TI is
for some reason extremely secretive about TPS65983 and I wasn't able
to get anything definitive about it.

Anyway, I've reverse engineered a nontrivial part of the TI TPS6598x
firmware and register layout, however my understanding of Thunderbolt
and USB PD is not sufficient to proceed.

Mario, do you think you could get in touch with the people at Dell who
work with USB PD and ask if:

   (a) the adapter advertising an altmode with SVID:0x8087 VDO:0x00010001
       is the problem here, and
   (b) whether configuring the register 0x52 Intel VID Configuration in
       the adapter's USB PD controller to set TBTModeDataTXSOP=0x0000
       would help.

-- 
whitequark
