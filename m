Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeEIEEE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:04:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:49021 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbeEIEED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:04:03 -0400
Message-ID: <3117a5230fe7849e66d2d354f04ec3f24fccca0f.camel@kernel.crashing.org>
Subject: Re: [PATCH] hwmon: (aspeed-pwm-tacho) Use 24MHz clock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lei YU <mine260309@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Hardware Monitoring <linux-hwmon@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 09 May 2018 14:03:04 +1000
In-Reply-To: <CAARXrt=ZA7sz_CvNUxHRvie3YfErU-5d5ewHry=mgxb6Uz-+TA@mail.gmail.com>
References: <1525772367-20627-1-git-send-email-mine260309@gmail.com>
         <8a801894-4293-d2e8-4673-3d9ff5c2a5bb@roeck-us.net>
         <CAARXrtmO=wsPK6bfO0E7fvAkqEJUV1kQSYK1gWXkUhmKytq42A@mail.gmail.com>
         <c5770e4a-9445-d4ef-cc1f-a7a84599c4a1@roeck-us.net>
         <CAARXrt=ZA7sz_CvNUxHRvie3YfErU-5d5ewHry=mgxb6Uz-+TA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-09 at 11:50 +0800, Lei YU wrote:
> On Wed, May 9, 2018 at 11:43 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> > 
> > I am not going to accept this change, period. This is not one, it is five
> > steps
> > backward. If "aspeed_set_clock_source(priv->regmap, 0)" changes the clock
> > speed,
> > or the clock source, read it later, and attach to the correct clock. If that
> > doesn't work, fix the problem in the clock subsystem. Hacking the driver is
> > just
> > plain wrong.
> > 
> > Also, if the idea in DT is to provide a different clock to the watchdog on
> > purpose,
> > maybe the call to "aspeed_set_clock_source(priv->regmap, 0)" is wrong.
> 
> Exactly!
> My first change (not sent to mailing list) is to remove the call of
> "aspeed_set_clock_source(priv->regmap, 0)", instead, checking the clock
> source, and use either 24M or the memory controller clock.
> But that make things a bit more complicated and Aspeed suggests to use 24M
> clock. So I sent this simplified change.
> 
> It's OK to not accept this change, the fix in DT will fix the issue as well.

Another option is to give *both* clock sources in the DT, since in HW
they both eventually reach the IP block, and have the driver select
which one it wants to use (that itself can also be in the DT).

That way you can select 0 if you want and still use clk_get_rate() to
know how fast it's ticking.

Cheers,
Ben.
