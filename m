Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB601ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDDE2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDDE2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbeGRPVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:21:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730627AbeGRPVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:21:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CE29401EF07;
        Wed, 18 Jul 2018 14:43:16 +0000 (UTC)
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 63A172026D69;
        Wed, 18 Jul 2018 14:43:12 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Wed, 18 Jul 2018 16:43:11 +0200
Date:   Wed, 18 Jul 2018 16:43:11 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: Re: [PATCH v2] KVM: Add coalesced PIO support
Message-ID: <20180718144311.GB6348@flask>
References: <1531360773-32304-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531360773-32304-1-git-send-email-wanpengli@tencent.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 14:43:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 14:43:16 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-12 09:59+0800, Wanpeng Li:
> From: Peng Hao <peng.hao2@zte.com.cn>
> 
> Windows I/O, such as the real-time clock. The address register (port
> 0x70 in the RTC case) can use coalesced I/O, cutting the number of
> userspace exits by half when reading or writing the RTC.
> 
> Guest access rtc like this: write register index to 0x70, then write or 
> read data from 0x71. writing 0x70 port is just as index and do nothing 
> else. So we can use coalesced mmio to handle this scene to reduce VM-EXIT 
> time.
> 
> In our environment, 12 windows guests running on a Skylake server:
> 
> Before patch:
> 
> IO Port Access  Samples  Samples%   Time%    Avg time
> 
> 0x70:POUT        20675    46.04%    92.72%   67.15us ( +-   7.93% )
> 
> After patch:
> 
> IO Port Access  Samples  Samples%   Time%    Avg time
> 
> 0x70:POUT        17509    45.42%    42.08%   6.37us ( +-  20.37% )
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * add the original author
> 
>  Documentation/virtual/kvm/00-INDEX         |  2 ++
>  Documentation/virtual/kvm/api.txt          |  7 +++++++
>  Documentation/virtual/kvm/coalesced-io.txt | 17 +++++++++++++++++
>  include/uapi/linux/kvm.h                   |  5 +++--
>  virt/kvm/coalesced_mmio.c                  | 16 +++++++++++++---
>  virt/kvm/kvm_main.c                        |  2 ++
>  6 files changed, 44 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/virtual/kvm/coalesced-io.txt
> 
> diff --git a/Documentation/virtual/kvm/00-INDEX b/Documentation/virtual/kvm/00-INDEX
> index 3492458..4160620 100644
> --- a/Documentation/virtual/kvm/00-INDEX
> +++ b/Documentation/virtual/kvm/00-INDEX
> @@ -9,6 +9,8 @@ arm
>  	- internal ABI between the kernel and HYP (for arm/arm64)
>  cpuid.txt
>  	- KVM-specific cpuid leaves (x86).
> +coalesced-io.txt
> +	- Coalesced MMIO and coalesced PIO.
>  devices/
>  	- KVM_CAP_DEVICE_CTRL userspace API.
>  halt-polling.txt
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index d10944e..4190796 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4618,3 +4618,10 @@ This capability indicates that KVM supports paravirtualized Hyper-V TLB Flush
>  hypercalls:
>  HvFlushVirtualAddressSpace, HvFlushVirtualAddressSpaceEx,
>  HvFlushVirtualAddressList, HvFlushVirtualAddressListEx.
> +
> +8.19 KVM_CAP_COALESCED_PIO
> +
> +Architectures: x86, s390, ppc, arm64
> +
> +This Capability indicates that kvm supports writing to a coalesced-pio region
> +is not reported to userspace until the next non-coalesced pio is issued.
> diff --git a/Documentation/virtual/kvm/coalesced-io.txt b/Documentation/virtual/kvm/coalesced-io.txt
> new file mode 100644
> index 0000000..4a96eaf
> --- /dev/null
> +++ b/Documentation/virtual/kvm/coalesced-io.txt
> @@ -0,0 +1,17 @@
> +----
> +Coalesced MMIO and coalesced PIO can be used to optimize writes to
> +simple device registers. Writes to a coalesced-I/O region are not
> +reported to userspace until the next non-coalesced I/O is issued,
> +in a similar fashion to write combining hardware.  In KVM, coalesced
> +writes are handled in the kernel without exits to userspace, and
> +are thus several times faster.
> +
> +Examples of devices that can benefit from coalesced I/O include:
> +
> +- devices whose memory is accessed with many consecutive writes, for
> +  example the EGA/VGA video RAM.
> +
> +- windows I/O, such as the real-time clock. The address register (port
> +  0x70 in the RTC case) can use coalesced I/O, cutting the number of
> +  userspace exits by half when reading or writing the RTC.
> +----
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index b6270a3..9cc56d3 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -420,13 +420,13 @@ struct kvm_run {
>  struct kvm_coalesced_mmio_zone {
>  	__u64 addr;
>  	__u32 size;
> -	__u32 pad;
> +	__u32 pio;

Paolo, do you think we can rename the field without breaking userspace
builds?

>  };
>  
>  struct kvm_coalesced_mmio {
>  	__u64 phys_addr;
>  	__u32 len;
> -	__u32 pad;
> +	__u32 pio;
>  	__u8  data[8];
>  };
>  
> diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
> @@ -149,8 +150,12 @@ int kvm_vm_ioctl_register_coalesced_mmio(struct kvm *kvm,
>  	dev->zone = *zone;
>  
>  	mutex_lock(&kvm->slots_lock);
> -	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, zone->addr,
> -				      zone->size, &dev->dev);
> +	if (zone->pio)
> +		ret = kvm_io_bus_register_dev(kvm, KVM_PIO_BUS, zone->addr,
> +						zone->size, &dev->dev);
> +	else
> +		ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, zone->addr,
> +						zone->size, &dev->dev);

This would be better readable as

	ret = kvm_io_bus_register_dev(kvm, zone->pio ? KVM_PIO_BUS : KVM_MMIO_BUS,
	                              zone->addr, zone->size, &dev->dev);

thanks.
