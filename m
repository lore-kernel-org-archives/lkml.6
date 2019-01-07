Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB200C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EF12173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546877784;
	bh=uWjSlrvkw39gqwOG51hP7wzxnSNcL9yvELOQZCSvFZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E4STfUeAYZgRSdcXrFbt8eSU6Su/E++bszPipOJ+meZWFX3/h9SCM3b0JwTaV+rms
	 oBZ5gRpeqVXsTmNDN6Y/xp4aFhKdd0SfsxMZjiAfR013ujyMbc88z7L3m4tKhGpqnL
	 uLk8qjY1E1Er3EnqHoNDL/FOWCa7xVA7rqeaYaK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfAGQQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:16:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfAGQQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:16:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35EED2147C;
        Mon,  7 Jan 2019 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546877782;
        bh=uWjSlrvkw39gqwOG51hP7wzxnSNcL9yvELOQZCSvFZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JA5AR9PS3uG0GrnKgt0mliHtv7Bkuf7BTuOu5IwqK9IRE9zuTOw9fwcHuzF1DCFON
         a4niN5ksbF2gipkWm6kmiQugzG8CFR650/hElEAJJjULk7gMHeRiU5IYSYiTJYXfGe
         sNGXKuBr48Dpsq4oU8/iTiLZGlg6+vp8wRV4AYuU=
Date:   Mon, 7 Jan 2019 17:16:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] USB: Don't enable LPM if it's already enabled
Message-ID: <20190107161620.GB2292@kroah.com>
References: <20181203102643.22690-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203102643.22690-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

What kernel patch does this one "fix"?  Adding a "Fixes:" tag would be
good to try to figure out how far back in the kernel releases this
should be backported.

thanks,

greg k-h
