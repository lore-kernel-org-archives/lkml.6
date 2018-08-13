Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15002C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F6921721
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F6921721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbeHMN2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:28:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:35357 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbeHMN2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:28:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2018 03:47:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,233,1531810800"; 
   d="scan'208";a="65726335"
Received: from anshuma1-pnp-server.iind.intel.com ([10.223.107.119])
  by orsmga006.jf.intel.com with ESMTP; 13 Aug 2018 03:47:04 -0700
From:   Anshuman Gupta <anshuman.gupta@intel.com>
To:     oneukum@suse.com, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, anshuman.gupta@intel.com
Subject: Re: [Query] USB device autosuspend and its runtime usage count.
Date:   Mon, 13 Aug 2018 16:15:02 +0530
Message-Id: <1534157102-29526-1-git-send-email-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534146566.10070.5.camel@suse.com>
References: <1534146566.10070.5.camel@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 01:19:26PM +0530, Oliver Neukum wrote:
> On Mo, 2018-08-13 at 12:15 +0530, Anshuman Gupta wrote:
> > Hi ,
> > I need to test a functionality with USB autosuspend with latest kernel          
> > Linux 4.18-rc8. I am trying to autosuspend a USB key board, i enabled       
> > its autosuspend by doing echo "auto" to its "control" attributes.
> > I am expecting USB keyboard to go to autosuspend after autosuspend_delay_ms.
> > But USB key board is not going to autosuspend because its runtime usage
> > count is not equal to zero.
> > 
> > Below are the log snippets:
> > 
> > root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5/power/runtime_enabled
> > enabled
> > root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5/power/control
> > auto
> > root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5/power/autosuspend_delay_ms
> > 2000
> > root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5/power/runtime_status
> > active
> > root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5/power/runtime_usage
> > 1
> > root@intel-Kabylake-Client-platform:# sleep 60; cat /sys/bus/usb/devices/1-5/power/runtime_usage
> > 1
> > 
> > My USB keyboard runtime usage reference count is not decreasing to zero.
> > Here am i missing something regarding runtime usage count or is it some issue with
> > my kernel or OS?
> 
> Very hard to say without further information. Is the HID device the
> only interface of the whole device?
yes, HID device is only the interface for given device, below here lsusb -t log for usb dev 1-5.

root@intel-Kabylake-Client-platform:# lsusb -t
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/12p, 480M
    |__ Port 5: Dev 3, If 1, Class=Human Interface Device, Driver=usbhid, 1.5M
    |__ Port 5: Dev 3, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M

> Does the device support remote wakeup?
yes, from lsusb logs it seems, it is supporting remote wakeup.

root@intel-Kabylake-Client-platform:# lsusb 
Bus 001 Device 003: ID 04d9:1702 Holtek Semiconductor, Inc. Keyboard LKS02

root@intel-Kabylake-Client-platform:# lsusb -v -d 04d9:1702 | grep Remote
      Remote Wakeup

> Is an LED on?
Num lock led was on, but switching it off also does not help.
> 
> Usbhid does support autosuspend, but its criteria must be met.
> And all interface drivers must call the device idle.
All of its interfaces are in runtime suspend

root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5\:1.0/power/runtime_status 
suspended
root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5\:1.1/power/runtime_status 
suspended
root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5/power/runtime_active_kids 
0

> Or you have discovered a kernel bug.
> 
>       Regards
>               Oliver
> 

-- 
Thanks,
Anshuman

