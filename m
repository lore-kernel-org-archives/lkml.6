Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeDELXw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:23:52 -0400
Received: from mx.socionext.com ([202.248.49.38]:17274 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeDELXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:23:49 -0400
Date: Thu, 05 Apr 2018 20:23:47 +0900
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] ata: ahci-platform: add reset control support
Cc: Tejun Heo <tj@kernel.org>, Patrice Chotard <patrice.chotard@st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20180405095429.GA7506@ulmo>
References: <1521768653-11824-1-git-send-email-hayashi.kunihiko@socionext.com> <20180405095429.GA7506@ulmo>
Message-Id: <20180405202347.2803.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On Thu, 5 Apr 2018 11:54:29 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Fri, Mar 23, 2018 at 10:30:53AM +0900, Kunihiko Hayashi wrote:
> > Add support to get and control a list of resets for the device
> > as optional and shared. These resets must be kept de-asserted until
> > the device is enabled.
> > 
> > This is specified as shared because some SoCs like UniPhier series
> > have common reset controls with all ahci controller instances.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
> >  drivers/ata/ahci.h                                 |  1 +
> >  drivers/ata/libahci_platform.c                     | 24 +++++++++++++++++++---
> >  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> This causes a regression on Tegra because we explicitly request the
> resets after the call to ahci_platform_get_resources().
> 
> From a quick look, ahci_mtk and ahci_st are in the same boat, adding the
> corresponding maintainers to Cc.
> 
> Patrice, Matthias: does SATA still work for you after this patch? This
> has been in linux-next since next-20180327.

I assume that I use "generic-ahci" driver directly, and this driver has
no way to handle resets, so I sent this patch.

However, also as far as I look, some hardware-specific drivers handle their 
own resets, and call ahci_platform_{enable,disable}_resources(). 
Surely there are paths to call reset control twice in such drivers.

Identically, when the driver also handle their own clocks, they have same issue.

> Given how this is one of the more hardware-specific bits, perhaps a
> better way to do this is to move reset handling into a Uniphier driver
> much like Tegra, Mediatek and ST?

Since it's difficult to write the resets in general with ahci_platform, I can prepare
hardware-specific driver for our SoCs.

> That said, I don't see SATA support for any of the Socionext hardware
> either in the DT bindings or drivers/ata, so perhaps it'd be best to
> back this out again until we have something that's more well tested?

I'm about to use the generic driver, and prepare our phy driver and
DT bindings for our SoCs, but not yet.

Then it's no problem that we can back this out.

Thank you,

---
Best Regards,
Kunihiko Hayashi
