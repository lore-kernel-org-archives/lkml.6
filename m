Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAFAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5715205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="2aNsSdUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404786AbfAPPBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:01:09 -0500
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com ([46.30.210.185]:23952
        "EHLO mailrelay4-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393805AbfAPPBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=cQB9rzXu6IIyWGE4rBq3324xGrsxfBHHLKXsSOdVsE8=;
        b=2aNsSdUA+6s4XLpKs0tyfk2RWoBuIvUG/Cm7kAHGTn71db8iG2h65DxGeZsAUBNtfgnDzM1VyN9ur
         p4azDcPMxjB3Zw5miWjhIR/zf5kTlKF+1xdJ15FwWXm+E9fzmyM757EjJK6qTKUMUB2+8K8DgA9fch
         om8FyLLFuG70e1Do=
X-HalOne-Cookie: 0b32515dc14c55f8adf2817b6a7d371658f604a5
X-HalOne-ID: 4e1533be-199d-11e9-834b-d0431ea8bb10
Received: from localhost (unknown [87.49.44.116])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 4e1533be-199d-11e9-834b-d0431ea8bb10;
        Wed, 16 Jan 2019 14:45:02 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "linux-watchdog\@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc\@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "martin\@hundeboll.net" <martin@hundeboll.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: Re: [PATCH v8 0/3] watchdog: allow setting deadline for opening /dev/watchdogN
References: <20190116121432.26732-1-rasmus.villemoes@prevas.dk>
Date:   Wed, 16 Jan 2019 15:45:02 +0100
In-Reply-To: <20190116121432.26732-1-rasmus.villemoes@prevas.dk> (Rasmus
        Villemoes's message of "Wed, 16 Jan 2019 12:14:41 +0000")
Message-ID: <87pnsw3bm9.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Villemoes <rasmus.villemoes@prevas.dk> writes:

> If a watchdog driver tells the framework that the device is running,
> the framework takes care of feeding the watchdog until userspace opens
> the device. If the userspace application which is supposed to do that
> never comes up properly, the watchdog is fed indefinitely by the
> kernel. This can be especially problematic for embedded devices.
>
> The existing handle_boot_enabled cmdline parameter/config option
> partially solves that, but that is only usable for the subset of
> hardware watchdogs that have (or can be configured by the bootloader
> to have) a timeout that is sufficient to make it realistic for
> userspace to come up. Many devices have timeouts of only a few
> seconds, or even less, making handle_boot_enabled insufficient.
>
> These patches allow one to set a maximum time for which the kernel
> will feed the watchdog, thus ensuring that either userspace has come
> up, or the board gets reset. This allows fallback logic in the
> bootloader to attempt some recovery (for example, if an automatic
> update is in progress, it could roll back to the previous version).
>
> The patches have been tested on a Raspberry Pi 2 and a Wandboard.
>
> Changes in v8: Redo on top of 5.0-rc1 - in particular, adapt to the
> jiffies->ktime_t conversion (1ff68820 "watchdog: core: make sure the
> watchdog_worker is not deferred"). Add a patch to make the hardware
> timeout at the deadline as requested by Guenther - which was actually
> made very easy by the ktime_t conversion.
>
> v7 submission at <https://lore.kernel.org/lkml/1511865350-20665-1-git-send-email-rasmus.villemoes@prevas.dk/>
>
> Rasmus Villemoes (3):
>   watchdog: introduce watchdog.open_timeout commandline parameter
>   watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
>   watchdog: make the device time out at open_deadline when open_timeout
>     is used
>
>  .../watchdog/watchdog-parameters.txt          |  9 ++++
>  drivers/watchdog/Kconfig                      |  9 ++++
>  drivers/watchdog/watchdog_dev.c               | 42 +++++++++++++++----
>  3 files changed, 53 insertions(+), 7 deletions(-)

For the whole series:
Acked-by: Esben Haabendal <esben@haabendal.dk>
