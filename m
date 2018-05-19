Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbeESPGl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:06:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55967 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbeESPGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:06:39 -0400
Date: Sat, 19 May 2018 17:06:29 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/5] acpi/processor: Fix the return value of
 acpi_processor_ids_walk()
In-Reply-To: <20180320110432.28127-5-douly.fnst@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1805191704150.1599@nanos.tec.linutronix.de>
References: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com> <20180320110432.28127-5-douly.fnst@cn.fujitsu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018, Dou Liyang wrote:

> ACPI driver should make sure all the processor IDs in their ACPI Namespace
> are unique for CPU hotplug. the driver performs a depth-first walk of the
> namespace tree and calls the acpi_processor_ids_walk().
> 
> But, the acpi_processor_ids_walk() will return true if one processor is
> checked, that cause the walk break after walking pass the first processor.
> 
> Repace the value with AE_OK which is the standard acpi_status value.
> 
> Fixes 8c8cb30f49b8 ("acpi/processor: Implement DEVICE operator for processor enumeration")
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  drivers/acpi/acpi_processor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 449d86d39965..db5bdb59639c 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -663,11 +663,11 @@ static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
>  	}
>  
>  	processor_validated_ids_update(uid);
> -	return true;
> +	return AE_OK;
>  
>  err:
>  	acpi_handle_info(handle, "Invalid processor object\n");
> -	return false;
> +	return AE_OK;

I'm not sure whether this is the right return value here. Rafael?

Thanks,

	tglx
