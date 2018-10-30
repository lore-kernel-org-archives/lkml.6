Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27CCC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD0B2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD0B2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeJ3XBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:01:52 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51332 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726563AbeJ3XBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:01:51 -0400
Received: (qmail 2865 invoked by uid 2102); 30 Oct 2018 10:08:13 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2018 10:08:13 -0400
Date:   Tue, 30 Oct 2018 10:08:13 -0400 (EDT)
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
Subject: Re: scsi_set_medium_removal timeout issue 
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED1F19F1CF@dggemm526-mbx.china.huawei.com>
Message-ID: <Pine.LNX.4.44L0.1810301005200.1515-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018, Zengtao (B) wrote:

> Hi 
> 
> I have recently met a scsi_set_medium_removal timeout issue, and it's related
>  to both SCSI and USB MASS storage. 
> Since i am not an expert in either scsi or usb mass storage, i am writing to report
> the issue and ask for a solution from you guys.
> 
> My test scenario is as follow:
> 1.Linux HOST-----Linux mass storage gadget(the back store is a flash partition).
> 2.Host mount the device.
> 3.Host writes some data to the Mass storage device.
> 4.Host Unmount the device.
> Both Linux kernels(Host and Device) are Linux 4.9.  
> Some has reported the same issue a long time ago, but it remains there.
> https://www.spinics.net/lists/linux-usb/msg53739.html
> 
> For the issue itself, there is my observation:
> In the step 4, the Host will issue an PREVENT_ALLOW_MEDIUM_REMOVAL scsi command.
> and and timeout happens due to the device 's very slow fsg_lun_fsync_sub.

Something is wrong here.  Before sending PREVENT-ALLOW MEDIUM 
REMOVAL, the host should issue SYNCHRONIZE CACHE.  This will force 
fsg_lun_fsync_sub to run, and the host should allow a long timeout for 
this command.  Then when PREVENT-ALLOW MEDIUM REMOVAL is sent, nothing 
will need to be flushed.

Alan Stern

> I found there are two methods to workaround the issue: 
> 1. Change the timeout value of host scsi command PREVENT_ALLOW_MEDIUM_REMOVAL to
> to about 60 seconds from 10 seconds.
> 2. Remove the fsg_lun_fsync_sub in the device's Mass storage gadget driver.
> 
> Thanks
> 
> Regards
> zentao

