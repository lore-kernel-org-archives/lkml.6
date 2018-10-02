Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAD4C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5882064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5882064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeJCFqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:46:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34554 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:46:22 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 343C11453;
        Tue,  2 Oct 2018 23:00:39 +0000 (UTC)
Date:   Tue, 2 Oct 2018 16:00:38 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Milo Kim <milo.kim@ti.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Breck <kernel@networkimprov.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCHv1 00/14] power: supply: Fix custom sysfs attribute
 registration
Message-ID: <20181002230038.GA11102@kroah.com>
References: <20180930220349.10515-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930220349.10515-1-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 12:03:35AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> Udev may not detect sysfs attributes, that have been added
> after the device has been created. Code doing that is racy [0].
> The power-supply class properly registers its attributes
> when the device is created, but some drivers add additional
> custom attributes in a racy way.
> 
> The first patch from this series adds native support for custom
> sysfs attributes to the power-supply subsystem. This feature
> allows cleaner code and avoids a race condition preventing udev
> from noticing the custom properties.
> 
> The following patches replace all instances of sysfs_create_*
> in drivers/power/supply to use the new feature and a couple
> of small cleanups.
> 
> TL;DR: This patchsets replaces all sysfs_create_* in power-supply.
> 
> [0] http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
> 
> -- Sebastian
> 
> Sebastian Reichel (14):
>   power: supply: core: add support for custom sysfs attributes
>   power: supply: bq2415x: fix race-condition in sysfs registration
>   power: supply: ds2780: fix race-condition in sysfs registration
>   power: supply: ds2781: fix race-condition in sysfs registration
>   power: supply: lp8788: fix race-condition in sysfs registration
>   power: supply: bq24190_charger: fix race-condition in sysfs
>     registration
>   power: supply: bq24257: fix race-condition in sysfs registration
>   power: supply: charger-manager: simplify generation of sysfs attribute
>     group name
>   power: supply: charger-manager: fix race-condition in sysfs
>     registration
>   power: supply: pcf50633: fix race-condition in sysfs registration
>   power: supply: ds2780: fix race-condition in bin attribute
>     registration
>   power: supply: ds2781: fix race-condition in bin attribute
>     registration
>   power: supply: ds2780: switch to devm_power_supply_register
>   power: supply: ds2781: switch to devm_power_supply_register
> 
>  drivers/power/supply/bq2415x_charger.c   | 119 ++++++++++-------------
>  drivers/power/supply/bq24190_charger.c   |  43 ++------
>  drivers/power/supply/bq24257_charger.c   |  15 +--
>  drivers/power/supply/charger-manager.c   |  62 +++++-------
>  drivers/power/supply/ds2780_battery.c    |  87 +++++------------
>  drivers/power/supply/ds2781_battery.c    |  82 +++++-----------
>  drivers/power/supply/lp8788-charger.c    |  62 +++++-------
>  drivers/power/supply/pcf50633-charger.c  |  17 ++--
>  drivers/power/supply/power_supply_core.c |   1 +
>  include/linux/power/charger-manager.h    |   3 +-
>  include/linux/power_supply.h             |   3 +
>  11 files changed, 172 insertions(+), 322 deletions(-)

Nice work, and it removes more code than it adds, always a win.

greg k-h
