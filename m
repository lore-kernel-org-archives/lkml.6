Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281BFC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F397B217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfAVQ7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:59:11 -0500
Received: from mail1.windriver.com ([147.11.146.13]:53426 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfAVQ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:59:10 -0500
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x0MGuxUv004932
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 22 Jan 2019 08:57:00 -0800 (PST)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Tue, 22 Jan 2019 08:56:59 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 182A42E0699; Tue, 22 Jan 2019 11:56:59 -0500 (EST)
Date:   Tue, 22 Jan 2019 11:56:59 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
CC:     <svendev@arcx.com>, <robh+dt@kernel.org>,
        <linus.walleij@linaro.org>, <lee.jones@linaro.org>,
        <mark.rutland@arm.com>, <afaerber@suse.de>, <treding@nvidia.com>,
        <david@lechnology.com>, <noralf@tronnes.org>, <johan@kernel.org>,
        <monstr@monstr.eu>, <michal.vokac@ysoft.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <john.garry@huawei.com>,
        <geert+renesas@glider.be>, <robin.murphy@arm.com>,
        <sebastien.bourdelin@savoirfairelinux.com>, <icenowy@aosc.io>,
        <stuyoder@gmail.com>, <maxime.ripard@bootlin.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] fieldbus_dev: add Fieldbus Device subsystem.
Message-ID: <20190122165658.GH26416@windriver.com>
References: <20190122152109.30488-1-TheSven73@googlemail.com>
 <20190122152109.30488-2-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190122152109.30488-2-TheSven73@googlemail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[[PATCH v7 1/6] fieldbus_dev: add Fieldbus Device subsystem.] On 22/01/2019 (Tue 10:21) Sven Van Asbroeck wrote:

> Fieldbus device (client) adapters allow data exchange with a PLC aka.
> "Fieldbus Controller" over a fieldbus (Profinet, FLNet, etc.)
> 
> They are typically used when a Linux device wants to expose itself
> as an actuator, motor, console light, switch, etc. over the fieldbus.
> 
> This framework is designed to provide a generic interface to Fieldbus
> Devices from both the Linux Kernel and the userspace.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>

[...]

> diff --git a/drivers/fieldbus/Kconfig b/drivers/fieldbus/Kconfig
> new file mode 100644
> index 000000000000..5c2bef950d04
> --- /dev/null
> +++ b/drivers/fieldbus/Kconfig
> @@ -0,0 +1,19 @@
> +menuconfig FIELDBUS_DEV
> +	bool "Fieldbus Device Support"

OK, so the core support is NOT tristate, ie not modular, so I think...

> diff --git a/drivers/fieldbus/dev_core.c b/drivers/fieldbus/dev_core.c
> new file mode 100644
> index 000000000000..c816df3201bb
> --- /dev/null
> +++ b/drivers/fieldbus/dev_core.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Fieldbus Device Driver Core
> + *
> + */
> +
> +#include <linux/fieldbus_dev.h>
> +#include <linux/mutex.h>
> +#include <linux/module.h>

...you don't need module.h here

> +#include <linux/device.h>
> +#include <linux/idr.h>
> +#include <linux/fs.h>
> +#include <linux/slab.h>
> +#include <linux/poll.h>
> +

[...]

> +
> +static void __exit fieldbus_exit(void)
> +{
> +	unregister_chrdev_region(fieldbus_devt, MAX_FIELDBUSES);
> +	class_unregister(&fieldbus_class);
> +}
> +
> +subsys_initcall(fieldbus_init);
> +module_exit(fieldbus_exit);

...and the module_exit is never called, so fieldbus_exit is dead code
and hence both should be removed.

> +
> +MODULE_AUTHOR("Sven Van Asbroeck <TheSven73@googlemail.com>");
> +MODULE_AUTHOR("Jonathan Stiles <jonathans@arcx.com>");
> +MODULE_DESCRIPTION("Fieldbus Device Driver Core");
> +MODULE_LICENSE("GPL v2");

And these are all no-ops for non-modules, so it is recommended that you
instead capture the information at the top of the file in comments.

You can find many similar cleanups for reference with this search:

   git log  --no-merges --oneline --grep='make .* non-modular'

Thanks,
Paul.
--
