Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF3BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4333C20817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4333C20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeKSUSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:18:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbeKSUSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:18:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35C0C30820D3;
        Mon, 19 Nov 2018 09:55:23 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F0465D9CD;
        Mon, 19 Nov 2018 09:55:18 +0000 (UTC)
Date:   Mon, 19 Nov 2018 17:55:15 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     lijiang <lijiang@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181119095515.GC14045@dhcp-128-65.nay.redhat.com>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
 <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115103959.GB26448@zn.tnic>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 19 Nov 2018 09:55:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 at 11:39am, Borislav Petkov wrote:
> + Bjorn.
> 
> On Thu, Nov 15, 2018 at 01:44:07PM +0800, lijiang wrote:
> > At present, the upstream kernel does not pass the e820 reserved ranges to the
> > second kernel, which might cause two problems:
> > 
> > The first one is the MMCONFIG issue, the PCI MMCONFIG(extended mode) requires
> > the reserved region otherwise it falls back to legacy mode, which might lead to
> > the hot-plug device could not be recognized in kdump kernel.
> 
> Well, this still doesn't explain it fully. Let's look at a box:
> 
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000997ff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000099800-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000065642fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000065643000-0x0000000067fb8fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000067fb9000-0x00000000689e8fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000689e9000-0x0000000068bf5fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x0000000068bf6000-0x000000006f7fffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000006f800000-0x000000008fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec80000-0x00000000fed00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000001007fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100800000-0x000000603fffffff] usable
> 
> this one has 8 reserved regions. Does that mean that we need to pass
> them *all* 8 to the second kernel so that MMCONFIG works?

We just copy 1st kernel memmap (/proc/iomem) to be used in 2nd kernel
e820,  I'm not sure we can get the exact memory range and pass it.
Because different io devices may have different ranges, it is hard to
get all the use cases. And there seems no easy way to get them.

Another thing is it is not worth to get the exact info, the 1st kernel
reserved part is just fine to be reserved as well in 2nd kernel, no 
side effects.  Actually there might be some obscure use cases we
do not find which rely those reserved memory ranges so it is better to
have.

> 
> Or is it only one reserved region which is needed for MMCONFIG?
> 
> Bjorn, do you know what the detection logic should be to map the correct
> reserved region (or regions) for MMCONFIG?
> 
> Now, even if we don't map that reserved region and MMCONFIG falls back
> to legacy mode, why is that a problem for the kdump kernel? Why does
> the kdump kernel need the hotplug device? What would be the use case?
> Hotplug a SATA drive to store the memory dump to it ... or?

According to an old bug report only devices on PCI segment 0 fall back
to legacy mode, those devices on segment 1 do not fall back, they just
do not work, and this seems not related to hotplug.

I found the old bug report, copy something here:
'''
When doing a kdump, the kdump kernel failed to boot due to not finding /dev/root.  The root drive is on a LSI Megaraid disk.

...
[    6.869903] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3.1/1-1.3.1:1.1/input/input1
[    6.885358] generic-usb 0003:046B:FF10.0002: input,hidraw1: USB HID v1.10 Mouse [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:1a.0-1.3.1/input1
[    6.901927] usbcore: registered new interface driver usbhid
[    6.908145] usbhid: USB HID core driver
......................Could not find /dev/root.
Want me to fall back to /dev/disk/by-id/scsi-3600605b0049fac9018513918775bfc13-part4? (Y/n) 
y
Waiting for device /dev/disk/by-id/scsi-3600605b0049fac9018513918775bfc13-part4 to appear: ..............................not found -- exiting to /bin/sh
$

The basic problem is that this device is in PCI segment 1 and the kernel PCI probing cannot find it without all the e820 i/o reservations being present in the e820 table.  And the crash kernel does not have those reservations because the kexec command does not pass i/o reservation via the memmap= command line option. (This problem does not show up for other vendors, as SGI is apparently the only one using extended PCI. The lookup of devices in PCI segment 0 actually fails for everyone, but devices in segment 0 are then found by some legacy lookup method.)  The workaround for this is to fix kexec to pass i/o reserved areas to the crash kernel.  The patch will be attached.
'''

And here is some old patches in kexec-tools for fixing this:
http://lists.infradead.org/pipermail/kexec/2013-February/007924.html
(patch from SGI, later reverted)

http://lists.infradead.org/pipermail/kexec/2014-April/011710.html
(patch from Chaowang)

But apparently we missed this issue in kexec_file code..

> 
> > Another one is that the e820 reserved ranges do not setup in kdump kernel, which
> > could cause kdump can't work in some machines. To know more information, please
> > refer to the [PATCH 2/2 v6] patch log.
> 
> Yah, I still don't understand *why* we need the reserved ranges in the
> second kernel. Once we've figured out the *why* we can look at the *how*.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

Thanks
Dave
