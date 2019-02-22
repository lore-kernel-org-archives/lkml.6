Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6312FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5842075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfBVOLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:11:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33092 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfBVOLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:11:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8DF1A78;
        Fri, 22 Feb 2019 06:11:02 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C82FA3F690;
        Fri, 22 Feb 2019 06:11:01 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:10:59 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernelnewbies@kernelnewbies.org
Subject: Re: arm64 Kernel build for qemu-system-aarch64 ?
Message-ID: <20190222141059.GJ42419@lakrids.cambridge.arm.com>
References: <CAOuPNLhDtRJDBnwuV1kQ47Zd9B00qh2bXDNQvh9tXfTyYqAWDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLhDtRJDBnwuV1kQ47Zd9B00qh2bXDNQvh9tXfTyYqAWDQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 07:17:00PM +0530, Pintu Agarwal wrote:
> Hi All,

Hi,

> I want to build Linux Kernel 4.20 for arm64 and use it on qemu-arm64.
> I see that there is a defconfig available in arch/arm64/configs/defconfig
> But I am not sure whether it will work for qemu-arm64, and by default
> which machine type is supported.
> 
> I already have working setup for qemu-arm for both versatile and
> vexpress machine. There is already a defconfig available for these
> under arch/arm.
> So I can build the kernel for it.
> 
> But, whether these defconfig are supported for arm64 ?
> If anybody have setup for qemu-arm64 kernel, please share the steps.
> About rootfs, I am planning to use the arm32 version of busybox itself.

The arm64 defconfig is intended to work for all platforms.

I use that with qemu's '-machine virt'. Assuming you use virtio-net and
virtio-block, no additional drivers are required.

For example, I can boot a defconfig kernel using the followign QEMU options:

qemu-system-aarch64 \
        -m 2048 -smp 4 \
        -net nic \
        -net user,host=10.0.2.10,hostfwd=tcp::65022-:22 \
        -nographic \
        -no-reboot \
        -machine virt,accel=kvm,gic_version=host \
        -cpu host \
        -hda ${FILESYSTEM} \
        -snapshot \
        -kernel ${KERNEL} \
        -append "earlycon root=/dev/vda panic_on_warn"

Thanks,
Mark.
