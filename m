Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x225fF5eon57R+5aUPri2gVtDYyMsoKUFuE4MgmVpoFh8mG3Mrb/4Rb/kXHmTFQ8zm1RQyWXT
ARC-Seal: i=1; a=rsa-sha256; t=1519592835; cv=none;
        d=google.com; s=arc-20160816;
        b=nrCDSwF6ZQ+RjEKWV/vCFsT83Q0kv4hQjPEyGgvaYx6FTptRzRynMjliPPEJmlYf73
         X/xnZjC5GnOTy6bjtGVPCB1yWj7cCRnOS1CRx4znDuRndxYo7ss+RbMRqR0lA0M6GhbA
         uvv/I0DSw/+q2TvAv83ze2HPjKOrGWvNJJzWi0WVzGjuWdRUWVOLyFDgCJGwwg2MmwMB
         2Pzn+3AoSDpQiFlWrZI9xN9ssN4YjJap9ChybAbhuBLtOgoWpcc4fkXdYCEstq7qWshX
         Cuhb3/Wy2/jdXh7epXjM6jE9gQNXvxThp5hF+gPESbEiLH0hwzq4YVe2VtA+idMX1eoe
         8UdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=S55ic6uuHkY5uqnpQ4WF2S+UCsttmh5Sf5+9Cyjx3MM=;
        b=y8ufECvOpx83cSfHf0dMhdsnt0ULTAE8s+7SmoTZt6hJWe5srd9YiAfBok17EhB4XO
         xD+k5Pyw/XxQ1TDBov4vJc0IbDBa7gq2lL2E3pHp70ByAzDosmmThIgfgPH9aqR0prq4
         N7VnLJSUZe5Ti4mkuI8gVZQD5W16NUAf6H0M/HpgPRWE62b8oVLfkybOiEwSyjCSU17x
         b7NY1kBuMQWknaBe3HOAWi7+ulBo3Oj3SsTbulsP4RcOGiG4r2kJM3XRhsKHw6H746U7
         MwafwHgx7fhavouYSy9hFH5+6yMnfk5OQP7U3W+a6s42Sa0krv6fp5ccNJXO8cPvsiVh
         qJCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Pl/LzMdI;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Pl/LzMdI;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH v3] drivers/virt: vm_gen_counter: initial driver
 implementation
To: Or Idgar <idgar@virtualoco.com>, linux-kernel@vger.kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org
Cc: oidgar@redhat.com, ghammer@redhat.com, Or Idgar <oridgar@gmail.com>
References: <20180225155525.25436-1-idgar@virtualoco.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ae751fe8-c21e-3569-e71c-5a25ee5f1632@infradead.org>
Date: Sun, 25 Feb 2018 13:07:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180225155525.25436-1-idgar@virtualoco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593375847957640337?=
X-GMAIL-MSGID: =?utf-8?q?1593408577148634194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/25/2018 07:55 AM, Or Idgar wrote:
> From: Or Idgar <oridgar@gmail.com>
> 
> This patch is a driver which expose the Virtual Machine Generation ID
> via sysfs. The ID is a UUID value used to differentiate between virtual
> machines.
> 
> The VM-Generation ID is a feature defined by Microsoft (paper:
> http://go.microsoft.com/fwlink/?LinkId=260709) and supported by multiple
> hypervisor vendors.
> 
> Signed-off-by: Or Idgar <oridgar@gmail.com>
> ---
> 
> Changes in v3 from v1 (v2 lack of patch changelog):
> - replaced GPL2 section with SPDX line.
> - including linux/kobject.h for hypervisor_kobj.
> - using acpi_os_map_memory instead acpi_os_map_iomem.
> 
>  Documentation/ABI/testing/sysfs-hypervisor |  13 +++
>  drivers/misc/Kconfig                       |   6 ++
>  drivers/misc/Makefile                      |   1 +
>  drivers/misc/vmgenid.c                     | 140 +++++++++++++++++++++++++++++
>  4 files changed, 160 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-hypervisor
>  create mode 100644 drivers/misc/vmgenid.c

$Subject says drivers/virt/. Please choose one.

> diff --git a/drivers/misc/vmgenid.c b/drivers/misc/vmgenid.c
> new file mode 100644
> index 000000000000..6b7ec9bd45e8
> --- /dev/null
> +++ b/drivers/misc/vmgenid.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Virtual Machine Generation ID driver
> + *
> + * Copyright (C) 2018 Red Hat, Inc. All rights reserved.
> + *	Authors:
> + *	  Or Idgar <oridgar@gmail.com>
> + *	  Gal Hammer <ghammer@redhat.com>
> + *
> + */
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/kobject.h>
> +#include <linux/acpi.h>
> +#include <linux/uuid.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Or Idgar <oridgar@gmail.com>");
> +MODULE_AUTHOR("Gal Hammer <ghammer@redhat.com>");
> +MODULE_DESCRIPTION("Virtual Machine Generation ID");
> +MODULE_VERSION("0.1");
> +
> +ACPI_MODULE_NAME("vmgenid");
> +
> +static u64 phy_addr;

Minor nit:
I would prefer phys_addr since we also have PHY devices that have a phy addr.

thanks,
-- 
~Randy
