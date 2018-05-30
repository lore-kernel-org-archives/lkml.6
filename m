Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeE3QqS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:46:18 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:51167 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753816AbeE3QqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:46:13 -0400
Date: Wed, 30 May 2018 09:46:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        jdelvare@suse.com, Avi Fishman <avifishman70@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Patrick Venture <venture@google.com>, Joel Stanley <joel@jms.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 2/2] hwmon: npcm-pwm: add NPCM7xx PWM driver
Message-ID: <20180530164604.GB8270@roeck-us.net>
References: <1527588141-18639-1-git-send-email-tmaimon77@gmail.com>
 <1527588141-18639-3-git-send-email-tmaimon77@gmail.com>
 <20180529165617.GD2162@roeck-us.net>
 <CAP6Zq1h8_n8R=dqmBxC_bK_YstLt1kkE6UCp2OVsNpKp=RK8og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP6Zq1h8_n8R=dqmBxC_bK_YstLt1kkE6UCp2OVsNpKp=RK8og@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 06:44:58PM +0300, Tomer Maimon wrote:
> Hi  Guenter,
> 
> Thanks for your prompt reply!
> 
> 
> On 29 May 2018 at 19:56, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Tue, May 29, 2018 at 01:02:21PM +0300, Tomer Maimon wrote:
> > > Add Nuvoton BMC NPCM7xx Pulse Width Modulation (PWM) driver.
> > >
> > > The Nuvoton BMC NPCM7xx has two identical PWM controller modules,
> > > each module has four PWM controller outputs.
> > >
> >
> > I don't see it guaranteed that all future NPCM7xx devices will be PWM
> > controllers, much less that they will be compatible to the chip really
> >
> 
> Actually all NPCM7xx family have PWM and FAN modules support,
> 
> 
> > supported here. NPCM750, I presume ? I would suggest name the driver
> > accordingly.
> >
> 
> The compatible name can not be a family name like nuvoton,npcm7xx-pwm, only
> a specific chip name. (in our case the NPCM750 is the full modules SOC)
> still you think i should change the driver name? (note: all of our NPCM7xx
> unique modules drivers are named npcm7xx-*.c or *-npcm7xx.c)
> 

drivers/watchdog/npcm_wdt.c contradicts that statement.

Please discuss with the pwm maintainer. In hwmon, wildcards in driver file
names are discouraged and will not be accepted. Our recommendation is to pick
one chip from the family and use it as part of the file name.

> 
> > As a generic pwm driver, not specifically tied to a fan controller,
> > this driver does not belong into hwmon. It should be added to the pwm
> > subsystem. Copying the maintainer and mailing list.
> >
> > In the NPCM7xx we have PWM and FAN controller modules,  usually in the
> aspect of our BMC clients the two module
> are used together to control the fans.
> 
> But because in the NPCM7xx the PWM and the FAN controller are separate
> modules we
> thought to do two separate drivers in the hwmon
> is it possible? or you think it is better to do one hwmon driver for the
> PWM and the FAN controller.
> 
That depends on how closely the two modules are intertwined. If the pwm module
is generic, it belongs into the pwm subsystem. It only belongs into hwmon
if it can _only_ be used for fan control, eg if the data reported by the fan
module is used by the hardware to control the pwm output based on some
fan speed <-> pw value mapping which is programmed into the chip, and/or
if the pwm output can only connect to a fan and nothing else, and if the
relationship between pwm output and fan input is well defined.

If both end up in hwmon, I don't see the benefit of having two separate
drivers. That means two hwmon devices for the same fan or set of fans,
one being all but useless in respect to output from the 'sensors'
command. You'll have to convince me why that would make sense; I just
don't see the point.  In that case, I would also not see the point of
having two separate devicetree nodes; to me, that would be similar
to having two interfaces for a single serial line, one for receive
and one for transmit.

> note that we were going to submit soon also the FAN controller driver under
> hwmon.
> 
No problem with that as long as there are no wildcards in the file name.

Guenter
