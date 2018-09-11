Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E0DC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE93020839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE93020839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeIKOb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:31:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47392 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKOb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:31:56 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 14C8EEDF;
        Tue, 11 Sep 2018 09:33:26 +0000 (UTC)
Date:   Tue, 11 Sep 2018 11:33:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        James Wang <jnwang@suse.com>,
        Borislav Petkov <bpetkov@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Errors at reboot after 722e5f2b1eec
Message-ID: <20180911093324.GB10436@kroah.com>
References: <s5hk1ns1m8n.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hk1ns1m8n.wl-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 10:17:44AM +0200, Takashi Iwai wrote:
> [ seems like my previous post didn't go out properly; if you have
>   already received it, please discard this one ]

Sorry, I got it, it's just in my large queue :(

> Hi Rafael, Greg,
> 
> James Wang reported on SUSE bugzilla that his machine spews many
> AMD-Vi errors at reboot like:
> 
> [  154.907879] systemd-shutdown[1]: Detaching loop devices.
> [  154.954583] kvm: exiting hardware virtualization
> [  154.999953] usb 5-2: USB disconnect, device number 2
> [  155.025278] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.081360] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.136778] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.191772] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.247055] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.302614] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.358996] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.392155] usb 4-2: new full-speed USB device number 2 using ohci-pci
> [  155.413752] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.413762] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.560307] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.616039] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.667843] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.719497] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.772697] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.823919] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.875490] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.927258] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  155.979318] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  156.031813] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  156.084293] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> [  156.272157] reboot: Restarting system
> [  156.290316] reboot: machine restart
> 
> And, James bisected and spotted that it's introduced by the commit
> 722e5f2b1eec ("driver core: Partially revert "driver core: correct
> device's shutdown order"").  Reverting the commit fixes the problem.
> 
> He mentioned about Uncorrectable Machine Check Exception seen at
> shutdown, too, where it doesn't appear after the revert.  (Though,
> it's not sure whether it's really relevant.)
> 
> The errors are clearly related with the USB device (a KVM device,
> IIRC), and the errors are not seen if the USB device is disconnected.
> 
> We experienced this at first with SLE15 kernel (4.12 with backports),
> but later the same issue was confirmed on 4.18.y and 4.19-rc2.  Also,
> it's confirmed that revert works on the upstream kernels, too.
> 
> Does this hit your radar?

Ugh, no, I haven't heard of this before, Rafael?

So the need for the revert fixes some machines, but others need the
patch, this isn't going to be fun :(

greg k-h
