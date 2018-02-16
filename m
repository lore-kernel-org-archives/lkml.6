Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933909AbeBPKoz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:44:55 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:44342 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933633AbeBPKov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:44:51 -0500
X-Google-Smtp-Source: AH8x224144JLnjBVkB4HVjllpcustss39BfUp1TYXVc1rdOrT8xy73Xxi0oucjnMyoGlxY6xHFJnWQ==
Subject: Re: [PATCH 0/12] USB Type-C device-connection, mux and switch support
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20180216104321.8259-1-hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <e45682ec-96e1-8e40-11aa-0fea5b3f85b6@redhat.com>
Date: Fri, 16 Feb 2018 11:44:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216104321.8259-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

Ugh, I had my .git/config still setup for sending AHCI patches, so
sorry, please ignore this series while I resend it to the right
people.

Regards,

Hans


On 16-02-18 11:43, Hans de Goede wrote:
> Hi All,
> 
> Some devices with an USB Type-C connector have a bunch of muxes
> behind that connector which need to be controlled by the kernel (rather
> then having them controlled by firmware as on most devices).
> 
> Quite a while back I submitted a patch-series to tie together these muxes
> and the Type-C Port Manager (tcpm) code, using the then new drivers/mux
> framework. But the way I used the mux framework went against what it was
> designed for, so in the end that series got nowhere.
> 
> Heikki Krogerus from Intel, who maintains the USB TYPEC subsystem, has
> recently been working on solving the same problem for some boards he is
> doing hardware-enablement for.
> 
> Heikki has come up with a number of infrastructure patches for this.
> The first one is a new device-connection framework. This solves the
> problem of describing non bus device-links on x86 in what in my experience
> with this problematic area is a really nice simple, clean and *generic*
> way. This could for example in the near future also replace the custom
> lookup code in the pwm subsys and the custom pwm_add_table() /
> pwm_remove_table() functions.
> 
> The other 3 patches add a framework for the different type of Type-C /
> USB "muxes".
> 
> Heikki and I have gone through a number of iterations of these patches
> together and we believe these are now ready for merging. Since merging
> infrastructure patches without users is not done and Heikki's own use-case
> for these is not yet ready for merging, the rest of this series consists
> of patches by me to make the Type-C connector found on some Cherry Trail
> devices (finally) be able to actually work as an USB port and not just
> a charge port.
> 
> The last patch uses the new usb-role-switch framework to also do proper
> devcie / host switching on CHT devices with a USB micro AB connector.
> This is also a big feature for CHT users, because before this they had
> to do a reboot to get an OTG-host cable recognized (on some devices).
> 
> Part of this series is an usb-role-switch driver for the role-switch
> found inside the xhci controller on e.g. CHT devices, this is currently
> implemented as the generic xhci controller instantiating a platform
> child-device for this, since this really is a separate chunk of HW
> which happens to sit in the XHCI mmio space. This approach may not be
> universally liked, given that in this new series the role-switch driver
> is much smaller and does not have any external deps anymore we could
> just integrate it into the xhci code if that is preferred.
> 
> About merging this series (once everything is reviewed, etc.), there are
> quite some interdependencies in it esp. a lot of the patches depend on
> the first patch. Luckily patches 1-10 all apply to subsystems which are
> maintained by Greg (most to the USB subsys). Which just leaves patches
> 11 and 12 once 1-10 are merged. Greg, can you create an immutable branch
> for the platform/x86 and extcon maintainers to merge once this is done?
> 
> Regards,
> 
> Hans
> 
