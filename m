Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F383CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C864320883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546962121;
	bh=gL3eZlgLiao5BI/NFvLeEEo4CLqKI7dbNQXD+1fOR3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UWkCfP0AtRU/HmBoqjEktKn2xTRThnZFNyNS5EMtUXtqT5AuSBjmCUV/BuF9xPmnM
	 MyrKFAKJvr/LH1GjH5F3lar1IUeT6uvygYI4eTZu5Jf2lCy4YiT7eRb29cDqO7xwc8
	 siw+3e/1QOpdLtyEi4DzZ2LVfSWlQnHPRpHAic8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfAHPmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbfAHPmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:42:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B2D20883;
        Tue,  8 Jan 2019 15:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546962119;
        bh=gL3eZlgLiao5BI/NFvLeEEo4CLqKI7dbNQXD+1fOR3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrkiTLj3tC7qP75D5SPWVakCMMbc9xutG8o16tlYH4FbZWp9AI+F3x97OSbz0VgSk
         +7afYSER1cNT7gzG3GpvYH4eiq3vNgVmIWyTda4wtsxy/S6oX89MnsXVsAfAr+mres
         pMJ2CS97qjX48GFnmAMY0Tg/koTykM92dp7V0rZo=
Date:   Tue, 8 Jan 2019 16:41:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] USB: Don't enable LPM if it's already enabled
Message-ID: <20190108154157.GA20561@kroah.com>
References: <20181203102643.22690-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203102643.22690-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 06:26:43PM +0800, Kai-Heng Feng wrote:
> USB Bluetooth controller QCA ROME (0cf3:e007) sometimes stops working
> after S3:
> [ 165.110742] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [ 168.432065] Bluetooth: hci0: Failed to send body at 4 of 1953 (-110)
> 
> After some experiments, I found that disabling LPM can workaround the
> issue.
> 
> On some platforms, the USB power is cut during S3, so the driver uses
> reset-resume to resume the device. During port resume, LPM gets enabled
> twice, by usb_reset_and_verify_device() and usb_port_resume().
> 
> So let's enable LPM for just once, as this solves the issue for the
> device in question.
> 
> Also consolidate USB2 LPM functions to usb_enable_usb2_hardware_lpm()
> and usb_disable_usb2_hardware_lpm().

I thought I asked for this to be two different patches.  One that does
the "consolidation", and then one that fixes the bug.  You are mixing
two different things here together, making it harder to review.

Can you please break this up and send a patch series, with the correct
"Fixes:" tag added to the second patch that actually fixes the issue?

thanks,

greg k-h
