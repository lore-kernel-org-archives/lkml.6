Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754351AbeDWIHU convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:07:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49645 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754078AbeDWIHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:07:18 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH RFC] ACPI: disable extra P_LVLx access on KVM
Date: Mon, 23 Apr 2018 10:07:10 +0200
Message-ID: <1969294.enFTGV94N4@aspire.rjw.lan>
In-Reply-To: <1522431741-4678-1-git-send-email-mst@redhat.com>
References: <1522431741-4678-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 30, 2018 7:43:58 PM CEST Michael S. Tsirkin wrote:
> As documented by commit b488f021 "ACPI: restore comment justifying
> 'extra' P_LVLx access", Linux does an extra IO read after entering idle
> because on (some) chipsets STPCLK# doesn't get asserted in time
> to prevent further instruction processing.
> 
> This can never be the case on KVM, and a timer read causes an expensive
> VM exit in turn causing useless load on host system. Detect KVM and skip
> the read.  TODO: whitelist more hypervisors?
> 
> Note: very lightly tested.  Pls don't apply this yet, I am working on a
> _CST implementation for KVM and will repost this without the RFC tag
> when it's been tested properly.
> 
> Posting now for early flames/feedback.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/acpi/processor_idle.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index abb559c..8ae28dc 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -33,6 +33,7 @@
>  #include <linux/cpuidle.h>
>  #include <linux/cpu.h>
>  #include <acpi/processor.h>
> +#include <linux/kvm_para.h>
>  
>  /*
>   * Include the apic definitions for x86 to have the APIC timer related defines
> @@ -665,7 +666,8 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
>  		/* Dummy wait op - must do something useless after P_LVL2 read
>  		   because chipsets cannot guarantee that STPCLK# signal
>  		   gets asserted in time to freeze execution properly. */
> -		inl(acpi_gbl_FADT.xpm_timer_block.address);
> +		if (!kvm_para_available())
> +			inl(acpi_gbl_FADT.xpm_timer_block.address);
>  	}
>  }
>  
> @@ -687,7 +689,8 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>  		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
>  			inb(cx->address);
>  			/* See comment in acpi_idle_do_entry() */
> -			inl(acpi_gbl_FADT.xpm_timer_block.address);
> +			if (!kvm_para_available())
> +				inl(acpi_gbl_FADT.xpm_timer_block.address);
>  		} else
>  			return -ENODEV;
>  	}
> 

While I have no objections to this change from the ACPI side, I'd like someone
from the KVM land to comment on this.

Thanks,
Rafael
