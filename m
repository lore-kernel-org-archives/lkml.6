Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8566FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB3520870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB3520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeIJRHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:07:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:34183 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeIJRHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:07:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 05:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,355,1531810800"; 
   d="scan'208";a="71756619"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 10 Sep 2018 05:13:09 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 10 Sep 2018 15:13:08 +0300
Date:   Mon, 10 Sep 2018 15:13:08 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] MAINTAINERS: Add Lukas Wunner as co-maintainer of
 thunderbolt
Message-ID: <20180910121308.GN14465@lahna.fi.intel.com>
References: <cover.1536517047.git.lukas@wunner.de>
 <76fccab34a66023c08b71a864a9fea77daac9742.1536517047.git.lukas@wunner.de>
 <20180910093333.GI14465@lahna.fi.intel.com>
 <20180910102514.tjwortosyb32n5me@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910102514.tjwortosyb32n5me@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 12:25:14PM +0200, Lukas Wunner wrote:
> On Mon, Sep 10, 2018 at 12:33:33PM +0300, Mika Westerberg wrote:
> > The reason for making the driver less verbose comes from direct feedback
> > from the community. For example:
> > 
> >   https://lkml.org/lkml/2017/10/31/864
> 
> I am not opposed to muting messages to KERN_DEBUG severity which merely
> report what the driver is doing such as:
> 
>     "control channel created"
>     "control channel starting..."
> 
> However messages should NOT be muted which report register contents
> or register changes unless those registers are *fully* documented and
> register changes are known to work *reliably*.  The URL you're referring
> to above provides an example where that's not the case:
> 
>     "disabling interrupt at register 0x38200 bit 12 (0xffffffff -> 0xffffefff)"
> 
> Something is broken here, the register was read as "all ones".
> This doesn't seem to work as reliable as it should and in that case
> please don't mute the message until we know it's fixed and always
> works.

That is actually already on my todo list. What happens here is that on
PCs the controller is hot-removed and the driver is removed but it tries
to touch hardware after it is already gone. We have a flag for that
already so I'm hoping to use that and skip touching hardware if it is
set.

> Also, it is quite customary and serves a useful purpose to report
> devices at KERN_INFO severity as they're enumerated.  E.g. the PCI
> bus logs messages for each enumerated device, pciehp logs the
> port's capabilities on probe, and so on.  Therefore please do not
> mute the enumeration of switches and their ports.  If you find the
> messages too noisy, feel free to condense the data reported for each
> port to 1 or 2 lines.

That I realized also myself after testing the patch bit more. We could
print some information that is useful upon device connect/disconnect.

But I don't think dumping the switch structure and ports are useful. I
would rather make it to follow USB and print the actual device that was
connected (this is the information read from DROM and which is exported
in sysfs as well).

So I'm experimenting patch that does something like this when device is
connected:

  thunderbolt 0-1: device 1:8003 connected
  thunderbolt 0-1: Apple, Inc Thunderbolt to FireWire Adapter

and when it is disconnected

  thunderbolt 0-1: device disconnected

> We currently print "Port ..." on enumeration, but use the syntax
> "<route string>:<port number>" for other port-related messages
> printed with tb_port_*().  It might be beneficial to use a single
> syntax consistently.

Since thunderbolt is now bus and all the devices include embedded struct
device we can use dev_*() just like everybody else is doing.
