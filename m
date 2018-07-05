Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B32C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9002413F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9002413F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeGEKmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:42:31 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51609 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753409AbeGEKma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:42:30 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 4ed70695bf1acbd7; Thu, 5 Jul 2018 12:42:28 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas =?ISO-8859-1?Q?H=E4nig?= <haenig@cosifan.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
Date:   Thu, 05 Jul 2018 12:41:03 +0200
Message-ID: <1999215.6UrMtQZ5Bj@aspire.rjw.lan>
In-Reply-To: <s5hk1qaui3w.wl-tiwai@suse.de>
References: <s5hk1qaf9hv.wl-tiwai@suse.de> <CAJZ5v0guCPET3gM-G_NAM-BjER2D3yW2i_CwR-5sHyNzCQ6R+Q@mail.gmail.com> <s5hk1qaui3w.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 5, 2018 11:50:11 AM CEST Takashi Iwai wrote:
> On Thu, 05 Jul 2018 11:34:59 +0200,
> Rafael J. Wysocki wrote:
> > 
> > Hi,
> > 
> > On Thu, Jul 5, 2018 at 9:05 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > > Hi,
> > >
> > > we've got a regression report since 4.17 about the behavior of
> > > power-off with the power button.  When a machine is powered off with
> > > the power button on desktop, it reboots after a few seconds instead of
> > > power down.
> > >
> > > The manual power down via "systemctl poweroff" works fine, so it's
> > > possibly some spurious wakeup by the power button action, and some
> > > ACPI-related change is suspected.
> > > The regression still remains in 4.18-rc3.
> > 
> > There are only a few ACPI commits directly related to power management
> > between 4.16 and 4.17 and none of them looks particularly suspicious.
> 
> OK, interesting.
> 
> > It looks like the power button state may not be cleared sufficiently
> > after it's been pressed which is now visible for some reason.
> 
> Hmm, where can such a state remain?  Since it happens after the
> machine turned off, some (ACPI) wakeup bits?

Basically, yes.

It looks like a GPE may remain active which then triggers wakeup after
shutdown.

On a hunch, I'm wondering if reverting commit

18996f2db918 ACPICA: Events: Stop unconditionally clearing ACPI IRQs during suspend/resume

(may not revert clearly, though) makes any difference.

Thanks,
Rafael

