Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C6CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5018B21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfAVRMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:12:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:50986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729365AbfAVRMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:12:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57EBCB0B7;
        Tue, 22 Jan 2019 17:12:37 +0000 (UTC)
Subject: Re: [PATCH v7 1/6] fieldbus_dev: add Fieldbus Device subsystem.
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org, mark.rutland@arm.com, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
References: <20190122152109.30488-1-TheSven73@googlemail.com>
 <20190122152109.30488-2-TheSven73@googlemail.com>
 <20190122165658.GH26416@windriver.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <2f4406b5-9970-211e-beef-a8b6ad60b99e@suse.de>
Date:   Tue, 22 Jan 2019 18:12:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190122165658.GH26416@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.01.19 um 17:56 schrieb Paul Gortmaker:
> [[PATCH v7 1/6] fieldbus_dev: add Fieldbus Device subsystem.] On 22/01/2019 (Tue 10:21) Sven Van Asbroeck wrote:
> 
>> Fieldbus device (client) adapters allow data exchange with a PLC aka.
>> "Fieldbus Controller" over a fieldbus (Profinet, FLNet, etc.)
>>
>> They are typically used when a Linux device wants to expose itself
>> as an actuator, motor, console light, switch, etc. over the fieldbus.
>>
>> This framework is designed to provide a generic interface to Fieldbus
>> Devices from both the Linux Kernel and the userspace.
>>
>> Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> 
> [...]
> 
>> diff --git a/drivers/fieldbus/Kconfig b/drivers/fieldbus/Kconfig
>> new file mode 100644
>> index 000000000000..5c2bef950d04
>> --- /dev/null
>> +++ b/drivers/fieldbus/Kconfig
>> @@ -0,0 +1,19 @@
>> +menuconfig FIELDBUS_DEV
>> +	bool "Fieldbus Device Support"
> 
> OK, so the core support is NOT tristate, ie not modular,

Is that intentional though, and if so, why?

If possible, I would much rather see it changed to tristate and leave
all the metadata below.

> so I think...
> 
>> diff --git a/drivers/fieldbus/dev_core.c b/drivers/fieldbus/dev_core.c
>> new file mode 100644
>> index 000000000000..c816df3201bb
>> --- /dev/null
>> +++ b/drivers/fieldbus/dev_core.c
>> @@ -0,0 +1,348 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Fieldbus Device Driver Core
>> + *
>> + */
>> +
>> +#include <linux/fieldbus_dev.h>
>> +#include <linux/mutex.h>
>> +#include <linux/module.h>
> 
> ...you don't need module.h here
> 
>> +#include <linux/device.h>
>> +#include <linux/idr.h>
>> +#include <linux/fs.h>
>> +#include <linux/slab.h>
>> +#include <linux/poll.h>
>> +
> 
> [...]
> 
>> +
>> +static void __exit fieldbus_exit(void)
>> +{
>> +	unregister_chrdev_region(fieldbus_devt, MAX_FIELDBUSES);
>> +	class_unregister(&fieldbus_class);
>> +}
>> +
>> +subsys_initcall(fieldbus_init);
>> +module_exit(fieldbus_exit);
> 
> ...and the module_exit is never called, so fieldbus_exit is dead code
> and hence both should be removed.
> 
>> +
>> +MODULE_AUTHOR("Sven Van Asbroeck <TheSven73@googlemail.com>");
>> +MODULE_AUTHOR("Jonathan Stiles <jonathans@arcx.com>");
>> +MODULE_DESCRIPTION("Fieldbus Device Driver Core");
>> +MODULE_LICENSE("GPL v2");

Sven, as this code appears to be all by ArcX people, any chance you can
make it just GPL (SPDX GPL-2.0-or-later)? Only reason to have it v2-only
would be if this code was derived from v2-only code that can't be
relicensed anymore.

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
