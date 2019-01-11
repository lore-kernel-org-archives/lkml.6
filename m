Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483CBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E3220870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547197933;
	bh=a5vdxkiCxGUC+CWiZ4OxDgPAJO9dU4j9H28OhIY1ne8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gvUn3SQ6DjUfObyUVxdwWRdUPd6iSOKCp+NaloVmuZG2dUOI7UoH9JCP5bxsVu3Ho
	 LRpDQnAhrDXjFU2oTQPuinDHPFaELwTSX2A3LjzFwzu7JlARyaLvOsOtFy2TJWrkO5
	 dE72MXre2AKOUUFKBeZrqxLGqGUa4yKcq9vseqtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfAKJML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:12:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfAKJML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:12:11 -0500
Received: from localhost (unknown [178.228.36.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CF1620870;
        Fri, 11 Jan 2019 09:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547197930;
        bh=a5vdxkiCxGUC+CWiZ4OxDgPAJO9dU4j9H28OhIY1ne8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MG2nfaeJ9VDaX+mrUM/veVXudH7F6LDfKEi02hmTB8AUTffVEhFUCHXrMZZKEK6g8
         MvTwd/mG7iHvIA+tsrA72G1O+QCl2xIY3ipDn7GvxkLYdf3xoh+zTEsIWcs8LV4frI
         86LD1fsxGwKTaH6K8G3L6aLhJNCt+k/qKkitSQUI=
Date:   Fri, 11 Jan 2019 10:12:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kai Heng Feng <kai.heng.feng@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] USB: Don't enable LPM if it's already enabled
Message-ID: <20190111091207.GE15610@kroah.com>
References: <98BF2E31-2F7F-47FA-B591-40B2FFBC65F1@canonical.com>
 <Pine.LNX.4.44L0.1901081230560.1355-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.1901081230560.1355-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 12:34:17PM -0500, Alan Stern wrote:
> On Wed, 9 Jan 2019, Kai Heng Feng wrote:
> 
> > > On Jan 8, 2019, at 11:41 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > 
> > > On Mon, Dec 03, 2018 at 06:26:43PM +0800, Kai-Heng Feng wrote:
> > >> USB Bluetooth controller QCA ROME (0cf3:e007) sometimes stops working
> > >> after S3:
> > >> [ 165.110742] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> > >> [ 168.432065] Bluetooth: hci0: Failed to send body at 4 of 1953 (-110)
> > >> 
> > >> After some experiments, I found that disabling LPM can workaround the
> > >> issue.
> > >> 
> > >> On some platforms, the USB power is cut during S3, so the driver uses
> > >> reset-resume to resume the device. During port resume, LPM gets enabled
> > >> twice, by usb_reset_and_verify_device() and usb_port_resume().
> > >> 
> > >> So let's enable LPM for just once, as this solves the issue for the
> > >> device in question.
> > >> 
> > >> Also consolidate USB2 LPM functions to usb_enable_usb2_hardware_lpm()
> > >> and usb_disable_usb2_hardware_lpm().
> > > 
> > > I thought I asked for this to be two different patches.  One that does
> > > the "consolidation", and then one that fixes the bug.  You are mixing
> > > two different things here together, making it harder to review.
> > > 
> > > Can you please break this up and send a patch series, with the correct
> > > "Fixes:" tag added to the second patch that actually fixes the issue?
> > 
> > The consolidation itself is the fix, so I am not sure how to break this up.
> > 
> > In reset-resume case, LPM gets enabled twice, by
> > usb_reset_and_verify_device() and usb_port_resume().
> > 
> > If it’s a normal resume, LPM only gets enabled once, by
> > usb_port_resume().
> > 
> > Since all three checks (capable, allowed and enabled) are merged to
> > a single place, enabling LPM twice can be avoided, hence fixing the
> > issue.
> 
> One approach would be to have the first patch add the new functions and
> change the code to call them instead of the original function, but
> leaves the checks the way they are now.  Then the second patch could
> add the checks to the new functions and remove them from the call
> sites.

Yes, that is what I was looking for.  That way, if the "change" really
does cause problems, it is easier to revert/fix.

thanks,

greg k-h
