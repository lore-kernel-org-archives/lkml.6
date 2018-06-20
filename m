Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E716C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55C320872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGqsSx6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55C320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbeFTMPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:15:42 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36570 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeFTMPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:15:39 -0400
Received: by mail-ot0-f196.google.com with SMTP id c15-v6so3443918otl.3;
        Wed, 20 Jun 2018 05:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+xrto0QlIR5enLqpIPAsYRpQK+ouUxgsRI0+fKaNzxs=;
        b=SGqsSx6c0KbIZHSntz1Q1b5IpM7Ugt3bX+JKQqpr/2+bIohzLXgPNiRBa9ePQq2Upm
         ww0r6EG9X6IkyGgWbvPvsflm2MM/ycOlcYgddXDRQqVSDS74Rb+ooQYqyYfSqLcvGsUf
         inVfeqT7HbWc21ah5pXDCc4Ks7gxkOgXZlTp+54gVvpjGS7sZUj3/pZ9yWNkmG/qQ4Wy
         lNXthweOYg7XnJSjV/Q9Hlznio8vw3xvBOfM7zlff5Jc3f3Fdpuh93KyWUI0ZN4u/puk
         uZjZ0elR6hOJdVhiMYZkw+u6ZijIvk1c9Btcj8tRFphF1iWmkI/CW/XhcKdqA7qayFBJ
         XEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+xrto0QlIR5enLqpIPAsYRpQK+ouUxgsRI0+fKaNzxs=;
        b=lqWDsjcO6uRjQtWJ5E9tqcj5J62OY0A0VRX7D+4g9LNNEw+Edem1de2MNXXrruWhhq
         f8OTmuHvU0irt37xrqFMg64E3vhAuUtNMeVEvSOJiEabBZ/DQCgQfMm3gfLhoa11Rfp5
         E3q/9Xq8EgB2YV1qd9Ci3InhWqToqvgLqAxvVK+0DE8oFy66q9adihFJEEaoI7qfU3Z9
         ZUoHK2xLnxCKZPs2RuLOQvPCd7God0KSYZDeP1nCd/TZxYGYX+fnEYMCGvu3BvPiY6vi
         UdbnlZpBVtOCW9+RqX8yt9yzoFt/uFRh2ZPd8NfQGrlcTEuMPRpXqOG9QRIW5oIG9Rx/
         mDfQ==
X-Gm-Message-State: APt69E23XKB5hXH6UwngZwSrTdYBa/OKyKPsVtgvGiPK1Ls7eOAVbhdc
        7iadF4s7yeRukmcmqcQUbhGZUWkwI9Pg8sKe4PU=
X-Google-Smtp-Source: ADUXVKJ/BjY3tPVAHDJORIsWYAuWe9MWZk1DnAJ4LOC3emHshpw0Uf90y+kuXYGud5TwGvE55FNOUhUi9RC0oy8DjBk=
X-Received: by 2002:a9d:3e4c:: with SMTP id h12-v6mr12184316otg.150.1529496939196;
 Wed, 20 Jun 2018 05:15:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 05:15:38
 -0700 (PDT)
In-Reply-To: <20180620103558.GA6242@sirena.org.uk>
References: <20180619135518.8990-1-geert+renesas@glider.be>
 <CAJZ5v0gGuTDCf8Bsefyj5R6mF=SXZDrt7JacNU5vBZOf84QsvA@mail.gmail.com>
 <CAMuHMdWgdsSS7qcfPmHnvL-XmXzyoS=bMGgc6q0urcvO5upWvQ@mail.gmail.com>
 <2523505.Jaak4fIuPm@aspire.rjw.lan> <20180620103558.GA6242@sirena.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Jun 2018 14:15:38 +0200
X-Google-Sender-Auth: v-EROXyAlrkIG1rdxmD_AhXXl_A
Message-ID: <CAJZ5v0ju3F7qWxMUDuCyWBzFQGyrmxVo90yytFbKnCmENvRuew@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:35 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 20, 2018 at 10:02:41AM +0200, Rafael J. Wysocki wrote:
>> On Tuesday, June 19, 2018 5:22:06 PM CEST Geert Uytterhoeven wrote:
>> > On Tue, Jun 19, 2018 at 4:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > > On Tue, Jun 19, 2018 at 3:55 PM, Geert Uytterhoeven
>
>> > In v1 (https://patchwork.kernel.org/patch/9996567/), I had a
>> > driver-specific "backup_mode" sysfs file.
>> > In v2 and later of the driver series (https://lkml.org/lkml/2018/4/18/345),
>> > I changed that to use the standard "wakeup" file in sysfs, in response to
>> > a comment from Mark Brown.
>
>> Well, I'm not convinced that this is the right approach, though.
>
> The original description of the changes made it sound like this
> controlled if the power switch would make the device resume from suspend
> or not which seems like a wakeup to me.  Honestly as things are I've no
> idea what the hardware designers were thinking or how to explain what
> this stuff is doing.
>
>> > Do you still prefer a driver-specific sysfs file?
>
>> Yes, I do.
>
> The flip side of that is that either suspend and resume or poweroff are
> broken for userspace unless they know about this magic sysfs file which
> isn't great either.

But to me that isn't that much different from an RTC wake alarm, say.

Enabling it to wake up the system in general isn't sufficient, you
also need to actually set the alarm using a different interface.
