Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754855AbeDTMp2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:45:28 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:63637 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754711AbeDTMp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:45:26 -0400
X-IronPort-AV: E=Sophos;i="5.49,301,1520899200";
   d="scan'208";a="716745722"
Subject: Re: [PATCH 1/3] xen: add generic fault injection facility
To: Juergen Gross <jgross@suse.com>
CC: <jakub.kicinski@netronome.com>, <hpa@zytor.com>, <mcroce@redhat.com>,
        <tglx@linutronix.de>, <ggarcia@abra.uab.cat>, <daniel@iogearbox.net>,
        <x86@kernel.org>, <mingo@redhat.com>, <xen-devel@lists.xenproject.org>,
        <axboe@kernel.dk>, <konrad.wilk@oracle.com>, <amir.jer.levy@intel.com>,
        <paul.durrant@citrix.com>, <stefanha@redhat.com>,
        <dsa@cumulusnetworks.com>, <boris.ostrovsky@oracle.com>,
        <linux-block@vger.kernel.org>, <wei.liu2@citrix.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <dwmw@amazon.co.uk>, <roger.pau@citrix.com>
References: <20180420104603.17823.31095.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
 <20180420104726.17823.40147.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
 <03a333dc-e505-e254-f39d-e68b1453a6f3@suse.com>
From: <staskins@amazon.com>
Message-ID: <74989e7c-4cde-81cf-c1ad-a3c19d477f52@amazon.com>
Date: Fri, 20 Apr 2018 14:45:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <03a333dc-e505-e254-f39d-e68b1453a6f3@suse.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3KCjXW5020929

On 04/20/18 12:59, Juergen Gross wrote:
> On 20/04/18 12:47, Stanislav Kinsburskii wrote:
>> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
>> index c1f98f3..483fc16 100644
>> --- a/arch/x86/xen/Kconfig
>> +++ b/arch/x86/xen/Kconfig
>> @@ -77,3 +77,10 @@ config XEN_PVH
>>   	bool "Support for running as a PVH guest"
>>   	depends on XEN && XEN_PVHVM && ACPI
>>   	def_bool n
>> +
>> +config XEN_FAULT_INJECTION
>> +	bool "Enable Xen fault injection"
>> +	depends on FAULT_INJECTION_DEBUG_FS
>> +	default n
>> +	help
>> +	  Enable Xen fault injection facility
> Why for x86 only? I'd rather add this under drivers/xen

Sure.

>
>> diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
>> index d83cb54..3158fe1 100644
>> --- a/arch/x86/xen/Makefile
>> +++ b/arch/x86/xen/Makefile
>> @@ -34,3 +34,4 @@ obj-$(CONFIG_XEN_DOM0)		+= vga.o
>>   obj-$(CONFIG_SWIOTLB_XEN)	+= pci-swiotlb-xen.o
>>   obj-$(CONFIG_XEN_EFI)		+= efi.o
>>   obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
>> +obj-$(CONFIG_XEN_FAULT_INJECTION)	+= fault_inject.o
>> diff --git a/arch/x86/xen/fault_inject.c b/arch/x86/xen/fault_inject.c
>> new file mode 100644
>> index 0000000..ecf0f7c
>> --- /dev/null
>> +++ b/arch/x86/xen/fault_inject.c
>> @@ -0,0 +1,109 @@
>> +/*
>> + * Fauit injection interface for Xen virtual block devices
>> + *
>> + * Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License version 2
>> + * as published by the Free Software Foundation; or, when distributed
>> + * separately from the Linux kernel or incorporated into other
>> + * software packages, subject to the following license:
> Please use the appropriate SPDX header instead of the full GPL2
> boilerplate.

Ditto.

>
>
> Juergen
>

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
