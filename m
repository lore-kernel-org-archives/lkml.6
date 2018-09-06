Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0FDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893702083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893702083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeIFNQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:16:06 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:57219 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbeIFNQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:16:06 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7ED5D3000253B;
        Thu,  6 Sep 2018 10:41:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5A403216617; Thu,  6 Sep 2018 10:41:43 +0200 (CEST)
Date:   Thu, 6 Sep 2018 10:41:43 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 1/3] thunderbolt: Make the driver less verbose
Message-ID: <20180906084143.sah4njyft7z5squb@wunner.de>
References: <20180903133304.70362-1-mika.westerberg@linux.intel.com>
 <20180903133304.70362-2-mika.westerberg@linux.intel.com>
 <20180905090510.fvryu6ivxagdzoyx@wunner.de>
 <20180905095451.GI2283@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905095451.GI2283@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 12:54:51PM +0300, Mika Westerberg wrote:
> On Wed, Sep 05, 2018 at 11:05:10AM +0200, Lukas Wunner wrote:
> > On Mon, Sep 03, 2018 at 04:33:02PM +0300, Mika Westerberg wrote:
> > > Currently the driver logs quite a lot to the system message buffer even
> > > when doing normal operations. This information is not useful for
> > > ordinary users and might even annoy some.
> > 
> > No, the verbose logging is done on purpose to aid us in reverse-engineering
> > the protocol.  For example ...
> > 
> > > -	tb_port_info(port, "  Unknown1: %#x Unknown2: %#x Unknown3: %#x\n",
> > > -		     hop->unknown1, hop->unknown2, hop->unknown3);
> > 
> > ... why do you think we're logging these seemingly stupid unknown
> > bitfields?  Because whenever someone posts dmesg output they
> > inadvertantly post the contents of those unknown fields and we can
> > then google the value of those fields on various controllers and
> > machines and deduce their possible meaning.
> 
> And the majority of people get tons of completely useless messages
> filling their dmesgs? No, I don't think that's a good thing.

As you know the OS-controlled tunnel manager is far from feature
complete.  I think the "majority of people" are perfectly willing
to accept verbose logging if it helps us fill in those gaps.

You make it sound like logfiles are spammed all the time, but
messages are in fact only logged on driver initialization and hotplug.

We wouldn't be in this situation if we had a proper Thunderbolt spec.
It wasn't *my* idea to keep it under wraps.

So please leave the messages at info level so as not to hinder our work.

As for your claim that the "majority of people" find the messages
useless", I rather suspect that you, personally, find them useless
because you complained about noisiness of the driver before:

   "I don't think we want to log anything with info level to be honest.
    The driver currently already is pretty noisy so adding even more
    information there just makes it worse ;-)
    I would rather convert debugging information to use tracepoints and
    get rid of the tb_*_info() things completely."
    https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1401181.html

And guess what I responded:

   "The noisiness has value in that it helps with reverse-engineering:
    Just google for dmesg output and check what other machines are
    reporting for unknown registers. :-)
    If there was public documentation available or Intel would be okay
    with answering specific questions (as you've done with the 0x30
    attribute id), then the value obviously diminishes."


> Anything running on Alpine Ridge and higher does
> not require reverse-engineering (even on Apple systems) because those
> are already supported in the driver.

Long term it may be worthwhile to move to OS-controlled tunnel management
even when ICM-controlled tunnel management is available as the latter
might not support features of the former, e.g. correlation of PCI devices
with Thunderbolt ports:
https://github.com/l1k/linux/commit/d024c6e7e80e

Thanks,

Lukas
