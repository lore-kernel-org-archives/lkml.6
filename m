Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB21C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1513F21A07
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1513F21A07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbeHFN2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:28:02 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47010 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeHFN2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:28:02 -0400
Received: from 79.184.254.16.ipv4.supernova.orange.pl (79.184.254.16) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 551e0353d895b89e; Mon, 6 Aug 2018 13:19:25 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: Built in PS2 keyboard in new ASUS/acer laptops can not wake up system after s2idle
Date:   Mon, 06 Aug 2018 13:17:26 +0200
Message-ID: <1631276.bMiRmflJ7r@aspire.rjw.lan>
In-Reply-To: <CAB4CAwcXg2ROwz17rZHzMpTEDYYfD1nteNgX=HE8EkOmyK3wag@mail.gmail.com>
References: <CAB4CAwfQ0mPMqCLp95TVjw4J0r5zKPWkSvvkK4cpZUGE--w8bQ@mail.gmail.com> <73029405.6ZXyByzer1@aspire.rjw.lan> <CAB4CAwcXg2ROwz17rZHzMpTEDYYfD1nteNgX=HE8EkOmyK3wag@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 6, 2018 1:07:25 PM CEST Chris Chiu wrote:
> On Mon, Aug 6, 2018 at 5:37 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, August 3, 2018 10:04:09 AM CEST Chris Chiu wrote:
> >> Hi guys,
> >>     We have some new laptops with Intel new Intel WiskyLake CPU come
> >> in and they all have the same problem. They all have the so-called
> >> "Modern Standby" feature which is s2idle in Linux.
> >>
> >>     The problem is the built-in keyboard no longer wake up the system
> >> after it goes to s2idle. Only the power button can wake up. It's
> >> different from the other laptops with old Intel CPUs (CoffeeLake,
> >> KaybeLake...etc). We found the difference is that the EC (embedded
> >> controller) no longer signals SCI event when in s2idle.
> >>
> >>     Confirmed with ASUS EC engineer, he also admits that the EC code
> >> for signaling SCI event in modern standby has been removed on
> >> WiskyLake models. Because the built-in PS2 keyboard can still wake up
> >> the system on WisksyLake+Windows10 RS4 combination without EC
> >> intervention.
> >>
> >>     Based on this information, we suspect that maybe the built-in
> >> keyboard wakeup on Windows 10 RS4 in enabled by default (although we
> >> don't know how to prove that). It's easy to simply do
> >> 'device_set_wakeup_enable' and 'enable_irq_wake' for the i8042
> >> keyboard port to wake up the system without EC, but it's nasty.
> >>
> >>     Any suggestion about how to achieve the keyboard wake up function
> >> on these new laptops in a generic way? Thanks
> >
> > What about echoing "enabled" to the keyboard's power/wakeup file in sysfs?
> >
> 
> 'echo enabled > /sys/devices/platform/i8042/serio0/power/wakeup' can get the
> keyboard wake up the system as expected. We considered to work out a DMI
> based quirk for this. But based on the information that EC would not signal SCI
> event for WiskyLake models, we'd like to know if there's any generic solution?
> Maybe a 'udev' rule to identify WiskyLake NoteBook then enable the keyboard
> wake up?

A udev rule sounds like a good idea to me.

