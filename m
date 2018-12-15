Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D5AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10642084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbeLOJEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 04:04:51 -0500
Received: from jablonecka.jablonka.cz ([91.219.244.36]:36997 "EHLO
        jablonecka.jablonka.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbeLOJEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 04:04:50 -0500
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Dec 2018 04:04:49 EST
Received: from twilight.vojtech.kobylisy.czf (unknown [10.32.148.9])
        by jablonecka.jablonka.cz (Postfix mail delivery) with ESMTP id E77D8603494B;
        Sat, 15 Dec 2018 09:55:10 +0100 (CET)
Received: by twilight.vojtech.kobylisy.czf (Postfix, from userid 1000)
        id D1F471549A6A; Sat, 15 Dec 2018 09:55:10 +0100 (CET)
Date:   Sat, 15 Dec 2018 09:55:10 +0100
From:   Vojtech Pavlik <vojtech@suse.cz>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, jikos@suse.cz,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [rfd] saving old mice -- button glitching/debouncing
Message-ID: <20181215085510.GB12930@suse.com>
References: <20181214232437.GA8310@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214232437.GA8310@amd>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 12:24:37AM +0100, Pavel Machek wrote:

> Patch is obviously not ready; but:
> 
> a) would it be useful to people

Probably not.

Mice already do internal software/hardware debouncing on switches. If you
see duplicate clicks making it all the way to the kernel driver, something
is very wrong with the switch, to the point where it'll soon fail
completely.

Hence the value of doing extra processing in the kernel is very limited.

> b) would it be acceptable if done properly? (cmd line option to
> enable, avoiding duplicate/wrong events?)

Well, for one, you shouldn't be using a timer, all the debouncing can be
done by math on the event timestamps.

You'd also have a hard time distinguishing between doubleclicks and bounces.

Since the mice already filter the quick bounces and there is significant
delay (100ms on USB, similar on PS/2) between updates from the hardware, a
real doubleclick can look absolutely the same as what you observe as a
bounce.

As such, it couldn't be enabled by default.

If you really want to go this way, a userspace solution is the better choice.

-- 
Vojtech Pavlik
