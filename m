Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68441C04AB8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15764214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15764214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbeIRTKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:10:01 -0400
Received: from cust-95-128-94-82.breedbanddelft.nl ([95.128.94.82]:34104 "EHLO
        cust-95-128-94-82.breedbanddelft.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727207AbeIRTKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:10:01 -0400
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
        id 1F2A413F7D7; Tue, 18 Sep 2018 15:37:21 +0200 (CEST)
Date:   Tue, 18 Sep 2018 15:37:21 +0200
From:   Rogier Wolff <R.E.Wolff@BitWizard.nl>
To:     Phil Elwell <phil@raspberrypi.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 1/2] sc16is7xx: Fix for multi-channel stall
Message-ID: <20180918133720.GE4791@BitWizard.nl>
References: <1536762716-30673-1-git-send-email-phil@raspberrypi.org>
 <1536762716-30673-2-git-send-email-phil@raspberrypi.org>
 <20180918130243.GA25253@kroah.com>
 <07ee2375-382c-154a-4c47-abb1a81b3351@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ee2375-382c-154a-4c47-abb1a81b3351@raspberrypi.org>
Organization: BitWizard B.V.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 02:13:15PM +0100, Phil Elwell wrote:
> I could add a limit on the number of iterations, but if the limit is ever hit,
> leading to an early exit, the port is basically dead because it will never
> receive another interrupt.

Especially if you print something like: "<driver name>: Too many
iterations with work-to-do bailing out" while bailing out, then
hanging just one driver/piece of hardware as opposed to the whole
system when somehow the hardware never indicates "all work done"
would be preferable. 

Under normal circumstances you never expect to hit that number of
iterations. But if the card keeps hitting the driver with "more work
to do" then you'd hang the system. Better try and recover, and provide
debug info for the user who knows where to look.

Best would be to ignore the driver for say a second and start handling
interrupts again a while later. Should the system be overloaded with
work, (and a slow CPU?) then you can recover and just make things slow
down a bit without hanging the system. 

Getting edge-triggered interrupts right is VERY difficult. In general
I'd advise against them. It looks like a nice solution, but in reality
the chances for difficult-to-debug race conditions is enormous.  In
those race conditions the card will get "new work to do" and
(re-)assert the interrupt line when the driver is already on the "no
more work to do" path.

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
The plan was simple, like my brother-in-law Phil. But unlike
Phil, this plan just might work.
