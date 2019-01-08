Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB034C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E8720827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfAHReS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:34:18 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:53914 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728658AbfAHReS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:34:18 -0500
Received: (qmail 3940 invoked by uid 2102); 8 Jan 2019 12:34:17 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Jan 2019 12:34:17 -0500
Date:   Tue, 8 Jan 2019 12:34:17 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
cc:     Greg KH <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] USB: Don't enable LPM if it's already enabled
In-Reply-To: <98BF2E31-2F7F-47FA-B591-40B2FFBC65F1@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1901081230560.1355-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019, Kai Heng Feng wrote:

> > On Jan 8, 2019, at 11:41 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Mon, Dec 03, 2018 at 06:26:43PM +0800, Kai-Heng Feng wrote:
> >> USB Bluetooth controller QCA ROME (0cf3:e007) sometimes stops working
> >> after S3:
> >> [ 165.110742] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> >> [ 168.432065] Bluetooth: hci0: Failed to send body at 4 of 1953 (-110)
> >> 
> >> After some experiments, I found that disabling LPM can workaround the
> >> issue.
> >> 
> >> On some platforms, the USB power is cut during S3, so the driver uses
> >> reset-resume to resume the device. During port resume, LPM gets enabled
> >> twice, by usb_reset_and_verify_device() and usb_port_resume().
> >> 
> >> So let's enable LPM for just once, as this solves the issue for the
> >> device in question.
> >> 
> >> Also consolidate USB2 LPM functions to usb_enable_usb2_hardware_lpm()
> >> and usb_disable_usb2_hardware_lpm().
> > 
> > I thought I asked for this to be two different patches.  One that does
> > the "consolidation", and then one that fixes the bug.  You are mixing
> > two different things here together, making it harder to review.
> > 
> > Can you please break this up and send a patch series, with the correct
> > "Fixes:" tag added to the second patch that actually fixes the issue?
> 
> The consolidation itself is the fix, so I am not sure how to break this up.
> 
> In reset-resume case, LPM gets enabled twice, by
> usb_reset_and_verify_device() and usb_port_resume().
> 
> If it’s a normal resume, LPM only gets enabled once, by
> usb_port_resume().
> 
> Since all three checks (capable, allowed and enabled) are merged to
> a single place, enabling LPM twice can be avoided, hence fixing the
> issue.

One approach would be to have the first patch add the new functions and
change the code to call them instead of the original function, but
leaves the checks the way they are now.  Then the second patch could
add the checks to the new functions and remove them from the call
sites.

I'm not sure if it's worth the effort to break things up that way, but 
it might make Greg happy.  :-)

Alan Stern

