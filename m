Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1994BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BDD222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389069AbfBMPCb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:02:31 -0500
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:58769 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBMPCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:02:31 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Feb 2019 10:02:30 EST
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 5C39667ED7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:55:17 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 40A8667ECA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:55:17 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Wed, 13 Feb 2019 15:55:17 +0100
Message-Id: <5C642FD2020000A10002FAAA@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Wed, 13 Feb 2019 15:55:14 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <linux-kernel@vger.kernel.org>
Subject: leap seconds and 61st second in minute
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was currently following some discussion on the topic of leap seconds, and due to the basic role of time in the kernel, I'd like to send a "heads up" ("food for thought") with some proposal (not to start some useless discussion):

The UNIX timescale running in UTC had (I suppose) the idea that no timezone switches will affect it. Unfortunately leap-seconds have not been considered; maybe also because at that time everybody would be happy if the system's time was correct to a few seconds. I don't know.
However leap seconds are a kind of "time zone switch" conceptually.

Unfortunately the unix time scale does not consider them (as noted in the time(2) manual page). That's one part of posix. The other part of POSIX claims that during an inserted leap second there should be a 61st second in the minute. Unfortunately (AFAIK) there's no interface from kernel's leap second handling to glibc allowing it to actually return 60 as the number of seconds. (localtime(3) only gets a pointer to time_t)

OTOH in the NTPv4 clock model there is a TAI offset included (which can be updated by NTP). AFAIK the kernel also has the timezone offset for some time to handle RTCs that run local time. Obviously if the kernel knew the number of leap seconds (the correction to the time() timescale) conversion from UNIX timescale to TAI would be easy.

So roughly if the kernel exports the time and type of the next_leap second scheduled, some future localtime could actually return the 61st second in the minute. As it is now applications will all see some magic duplication of the 60th second. (Maybe that' why Google does "leap smear"). If the kernel API would also export the TAI offset, one could even offer a TAI-based time, or, maybe even better: The kernel could run on TAI internally, and convert to UNIX time scale as needed.

I'll leave exact specification and implementation to the really clever guys.

Regards,
Ulrich
P.S. Not subscribed to the kernel-list so if you want to talk to me keep me on CC: preferably


