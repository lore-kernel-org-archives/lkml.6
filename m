Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76A2C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6214720854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6214720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeIMSu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:50:58 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:54898 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728786AbeIMSu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:50:57 -0400
Received: (qmail 2102 invoked by uid 2102); 13 Sep 2018 09:41:26 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Sep 2018 09:41:26 -0400
Date:   Thu, 13 Sep 2018 09:41:26 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/5] misc: rtsx_usb: Use USB remote wakeup signaling for
 card insertion detection
In-Reply-To: <9C387477-5253-497B-8BE2-8245AB88C551@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1809130936350.1990-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018, Kai-Heng Feng wrote:

> I am working on the next version of this series, and the last missing  
> puzzle is to differentiate system-wide resume from runtime resume in  
> usb_driver's resume() and reset_resume() callback.
> 
> The parent device, rtsx_usb, has two child devices, rtsx_usb_ms and  
> rtsx_usb_sdmmc.
> pm_request_resume() is used in rtsx_usb's resume() to facilitate USB remote  
> wakeup signaling, so we don't need to poll the card slot status.
> But this has a side effect: during system resume the rtsx_usb calls  
> pm_request_resume() in its resume(), so child devices calls their  
> runtime_resume() instead of resume() callback.

Have you actually observed this?  It shouldn't happen.  
pm_request_resume() schedules a runtime resume on the PM work queue, 
but this work queue is frozen during system sleep.  It doesn't unfreeze 
until after all the devices have been restored to full power.  Thus the 
child device's resume() callback should be invoked before 
runtime_resume().

> So, is it reasonable to pass pm_message_t to resume() and reset_resume()  
> callbacks and use PMSG_IS_AUTO() to differentiate them?

It should not be necessary to do this.

Alan Stern

