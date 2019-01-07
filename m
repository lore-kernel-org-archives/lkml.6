Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E20C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DFE2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfAGPGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:06:00 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:57352 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729090AbfAGPF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:05:59 -0500
Received: (qmail 2171 invoked by uid 2102); 7 Jan 2019 10:05:58 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Jan 2019 10:05:58 -0500
Date:   Mon, 7 Jan 2019 10:05:58 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v4] USB: Don't enable LPM if it's already enabled
In-Reply-To: <F24F822F-E721-47DC-9860-A2D0847C09DB@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1901071004430.1399-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019, Kai Heng Feng wrote:

> Hi,
> 
> > On Dec 3, 2018, at 18:26, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > 
> > USB Bluetooth controller QCA ROME (0cf3:e007) sometimes stops working
> > after S3:
> > [ 165.110742] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> > [ 168.432065] Bluetooth: hci0: Failed to send body at 4 of 1953 (-110)
> > 
> > After some experiments, I found that disabling LPM can workaround the
> > issue.
> > 
> > On some platforms, the USB power is cut during S3, so the driver uses
> > reset-resume to resume the device. During port resume, LPM gets enabled
> > twice, by usb_reset_and_verify_device() and usb_port_resume().
> > 
> > So let's enable LPM for just once, as this solves the issue for the
> > device in question.
> > 
> > Also consolidate USB2 LPM functions to usb_enable_usb2_hardware_lpm()
> > and usb_disable_usb2_hardware_lpm().
> 
> Please review my new approach, hopefully this can be included in Linux v5.0. 
> 
> > 
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v4:
> > - Use usb_enable_usb2_hardware_lpm() and
> >   usb_disable_usb2_hardware_lpm() to control USB2 LPM.
> > v3:
> > - Consolidate udev->usb2_hw_lpm_capable and udev->usb2_hw_lpm_enabled
> >  check to usb_set_usb2_hardware_lpm().
> > v2:
> >  - Check udev->usb2_hw_lpm_enabled before calling usb_port_resume().
> > 
> > drivers/usb/core/driver.c  | 23 +++++++++++++++++++----
> > drivers/usb/core/hub.c     | 16 ++++++----------
> > drivers/usb/core/message.c |  3 +--
> > drivers/usb/core/sysfs.c   |  5 ++++-
> > drivers/usb/core/usb.h     | 10 ++++++++--
> > 5 files changed, 38 insertions(+), 19 deletions(-)

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

