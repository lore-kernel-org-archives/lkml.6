Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E1AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54732054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54732054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbeJaXRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:17:53 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41910 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729435AbeJaXRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:17:53 -0400
Received: (qmail 2083 invoked by uid 2102); 31 Oct 2018 10:19:39 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Oct 2018 10:19:39 -0400
Date:   Wed, 31 Oct 2018 10:19:39 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
cc:     "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "usb-storage@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: RE: scsi_set_medium_removal timeout issue 
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED1F19F98A@dggemm526-mbx.china.huawei.com>
Message-ID: <Pine.LNX.4.44L0.1810311018400.1531-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018, Zengtao (B) wrote:

> Hi:
> 
> >-----Original Message-----
> >From: Alan Stern [mailto:stern@rowland.harvard.edu]
> >Sent: Tuesday, October 30, 2018 10:08 PM
> >To: Zengtao (B) <prime.zeng@hisilicon.com>
> >Cc: jejb@linux.vnet.ibm.com; martin.petersen@oracle.com;
> >gregkh@linuxfoundation.org; linux-scsi@vger.kernel.org;
> >linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> >usb-storage@lists.one-eyed-alien.net
> >Subject: Re: scsi_set_medium_removal timeout issue
> >
> >On Tue, 30 Oct 2018, Zengtao (B) wrote:
> >
> >> Hi
> >>
> >> I have recently met a scsi_set_medium_removal timeout issue, and it's
> >> related  to both SCSI and USB MASS storage.
> >> Since i am not an expert in either scsi or usb mass storage, i am
> >> writing to report the issue and ask for a solution from you guys.
> >>
> >> My test scenario is as follow:
> >> 1.Linux HOST-----Linux mass storage gadget(the back store is a flash
> >partition).
> >> 2.Host mount the device.
> >> 3.Host writes some data to the Mass storage device.
> >> 4.Host Unmount the device.
> >> Both Linux kernels(Host and Device) are Linux 4.9.
> >> Some has reported the same issue a long time ago, but it remains there.
> >> https://www.spinics.net/lists/linux-usb/msg53739.html
> >>
> >> For the issue itself, there is my observation:
> >> In the step 4, the Host will issue an
> >PREVENT_ALLOW_MEDIUM_REMOVAL scsi command.
> >> and and timeout happens due to the device 's very slow
> >fsg_lun_fsync_sub.
> >
> >Something is wrong here.  Before sending PREVENT-ALLOW MEDIUM
> >REMOVAL, the host should issue SYNCHRONIZE CACHE.  This will force
> >fsg_lun_fsync_sub to run, and the host should allow a long timeout for
> >this command.  Then when PREVENT-ALLOW MEDIUM REMOVAL is sent,
> >nothing will need to be flushed.
> >
> 
> Definitely, I haven't seen the SYNCHRONIZE CACHE from the host, it directly
> issued the PREVENT-ALLOW MEDIUM REMOVAL, so maybe something wrong
> with the scsi layer or something wrong with the mass storage class driver?

Or it could be something else.  Can you please post the dmesg log from
the host, showing what happens when the device is first plugged in?

Alan Stern

