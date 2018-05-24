Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031862AbeEXKOV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 06:14:21 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50151 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031515AbeEXKOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 06:14:12 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Martitz <kugel@rockbox.org>, Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM / core: Fix direct_complete handling for devices with no callbacks
Date: Thu, 24 May 2018 12:13:30 +0200
Message-ID: <1553668.SPIWpq1Qe9@aspire.rjw.lan>
In-Reply-To: <CAPDyKFonGtpv+oEW5bm1XAO7VNuqRR7ZQ7NT5ow3OuoQJQPwmg@mail.gmail.com>
References: <6238546.EnOBWIOf9o@aspire.rjw.lan> <CAPDyKFonGtpv+oEW5bm1XAO7VNuqRR7ZQ7NT5ow3OuoQJQPwmg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 22, 2018 1:41:06 PM CEST Ulf Hansson wrote:
> On 22 May 2018 at 13:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 08810a4119aa (PM / core: Add NEVER_SKIP and SMART_PREPARE
> > driver flags) inadvertently prevented the power.direct_complete flag
> > from being set for devices without PM callbacks and with disabled
> > runtime PM which also prevents power.direct_complete from being set
> > for their parents.  That led to problems including a resume crash on
> > HP ZBook 14u.
> >
> > Restore the previous behavior by causing power.direct_complete to be
> > set for those devices again, but do that in a more direct way to
> > avoid overlooking that case in the future.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=199693
> > Fixes: 08810a4119aa (PM / core: Add NEVER_SKIP and SMART_PREPARE driver flags)
> > Reported-by: Thomas Martitz <kugel@rockbox.org>
> > Tested-by: Thomas Martitz <kugel@rockbox.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It seems like the resume path of HP ZBook 14u is kind of fragile,

Yes, it is.

> in case it *requires* dev->power.direct_complete to be set for devices
> like these. And that makes me wonder, that perhaps we should try to
> address that issue as well, no?

Yes, in principle.

But since the direct_complete handling needs to be fixed anyway, it doesn't
matter a lot in practice, because the resume issue on HP ZBook 14u will not
be reproducible anyway then.  And since the dependency clearly is on a device
with no callbacks, I'm not worried too much about that.
