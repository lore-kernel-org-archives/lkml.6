Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29D8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6123120645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6123120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeIJPSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:18:38 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:45239 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbeIJPSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:18:38 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id A473B30002230;
        Mon, 10 Sep 2018 12:25:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 811E010751; Mon, 10 Sep 2018 12:25:14 +0200 (CEST)
Date:   Mon, 10 Sep 2018 12:25:14 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] MAINTAINERS: Add Lukas Wunner as co-maintainer of
 thunderbolt
Message-ID: <20180910102514.tjwortosyb32n5me@wunner.de>
References: <cover.1536517047.git.lukas@wunner.de>
 <76fccab34a66023c08b71a864a9fea77daac9742.1536517047.git.lukas@wunner.de>
 <20180910093333.GI14465@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910093333.GI14465@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 12:33:33PM +0300, Mika Westerberg wrote:
> The reason for making the driver less verbose comes from direct feedback
> from the community. For example:
> 
>   https://lkml.org/lkml/2017/10/31/864

I am not opposed to muting messages to KERN_DEBUG severity which merely
report what the driver is doing such as:

    "control channel created"
    "control channel starting..."

However messages should NOT be muted which report register contents
or register changes unless those registers are *fully* documented and
register changes are known to work *reliably*.  The URL you're referring
to above provides an example where that's not the case:

    "disabling interrupt at register 0x38200 bit 12 (0xffffffff -> 0xffffefff)"

Something is broken here, the register was read as "all ones".
This doesn't seem to work as reliable as it should and in that case
please don't mute the message until we know it's fixed and always
works.

Also, it is quite customary and serves a useful purpose to report
devices at KERN_INFO severity as they're enumerated.  E.g. the PCI
bus logs messages for each enumerated device, pciehp logs the
port's capabilities on probe, and so on.  Therefore please do not
mute the enumeration of switches and their ports.  If you find the
messages too noisy, feel free to condense the data reported for each
port to 1 or 2 lines.

We currently print "Port ..." on enumeration, but use the syntax
"<route string>:<port number>" for other port-related messages
printed with tb_port_*().  It might be beneficial to use a single
syntax consistently.

In one of the patches I've posted yesterday, I'm logging unknown
data that is stashed in the DROM for PCI ports.  To make sense of
that data, at least one line for each port needs to be logged.
(Such that we know which data pertains to which port.)

I don't really like spamming the log with this unknown data that
needs to be reverse-engineered.  I hate it.  You would do everyone
a favor if you could divulge the meaning of such unknown registers.
Then we don't need to log it in the first place.

Thanks,

Lukas
