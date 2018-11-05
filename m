Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FEEC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE3420862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wLqtWgRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE3420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbeKEWlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:41:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729498AbeKEWlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:41:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 435B72081D;
        Mon,  5 Nov 2018 13:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541424089;
        bh=EIrcgQsplAskFxhkpWPm/HY2blagq4cwC21Pe7Vdp44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wLqtWgRMVKqCNAhA9g1jNbxpujJ+4uv3gH4HvAEASgf4LiXnnuXF43u90FRpqCToB
         IgzudrIlCsm6g45w06UW707NbwiHUd5g1bJaSDfUT8R/IR9h/tvQ6IJAWdlPfsbcp/
         PluZdEKj3dhrGTxovzt9xx0QGj6qO3/TfgNkA7jI=
Date:   Mon, 5 Nov 2018 14:21:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: KOBJ_BIND uevent
Message-ID: <20181105132106.GB20797@kroah.com>
References: <f844342b-14fd-6ce5-55b0-5c224d0c841b@norrbonn.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f844342b-14fd-6ce5-55b0-5c224d0c841b@norrbonn.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 11:35:57AM +0100, Jonas Bonn wrote:
> Hi,
> 
> I have a question about the ordering of uevents, specifically concerning
> complex USB devices that present multiple interfaces/functions.
> 
> Before KOBJ_BIND, a USB device would typically present itself as:
> 
> add usb_device
> add usb_interface-1
> add subsystem-device-1.0
> add subsystem-device-1.1
> add usb_interface-2
> add subsystem-device-2.0
> 
> I have noted that the recently added "bind" actions, however, present in the
> reverse order.
> 
> bind subsystem-device-1.0
> bind subsystem-device-1.1
> bind usb-interface-1
> bind subsystem-device-2.0
> bind usb_interface-2
> bind usb_device
> 
> This secondary ordering could be useful in the sense that the final "bind"
> action on the usb_device is an indication that the kernel has finished
> enumeration of all endpoints and has bound all drivers that it could to the
> available interfaces... i.e. no further events for this device are expected.

Maybe.  Maybe not, as userspace might still be in the process of loading
new kernel drivers based on the add uevents that got sent out.  Then
binding would happen later after the usb_device was "bound".

> The question, then, is:  is the above ordering of "bind" events stable, or
> is it just a consequence of the current implementation and may change in the
> future?

Not stable at all, sorry, you can not depend on it.

Nor should you even try to, what problem are you wanting to solve here?

thanks,

greg k-h
