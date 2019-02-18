Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2092DC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2FD217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550506293;
	bh=4BmZoE0zzeafqbEhu70xChkibHvfm4As8S1KDnsprbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1fmAOGhwtTGQg2HqscBLFOcnCMAFDZCNBauGtRFYZn9catB+SLV/8jScj0krLYnNG
	 G+QuOW4xTAJh14TKbqtimbOkQR92N88HahUX79gTMxlW7F8CAsewbnLf3ObuwHztfg
	 x8y4e6e8htvOq1eYZa723cxHq2xeGtypduEoTlCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388967AbfBRQLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:11:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731321AbfBRQLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:11:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FD6A21736;
        Mon, 18 Feb 2019 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550506291;
        bh=4BmZoE0zzeafqbEhu70xChkibHvfm4As8S1KDnsprbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3mt4+W29ZGsI9d8Czl0N13phq+/qPGKYwBtR9MgOy9BzpfJFkNbn/IH1U2yJuLiU
         3XBHJGcew3/QTo6AgfJJUNIjEDCH/Ds/JBd8kLVX0B5joDcwdBl6wWTQzx9xy7d6qr
         9JgLZc2K4jsFxFH8U5utIqGPa0kLLNQitA0hDAhU=
Date:   Mon, 18 Feb 2019 17:11:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 4.4 091/143] scsi: aic94xx: fix module loading
Message-ID: <20190218161128.GA30288@kroah.com>
References: <20190218133529.099444112@linuxfoundation.org>
 <20190218133532.383171387@linuxfoundation.org>
 <1550503401.2834.1.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550503401.2834.1.camel@HansenPartnership.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 07:23:21AM -0800, James Bottomley wrote:
> On Mon, 2019-02-18 at 14:43 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me
> > know.
> > 
> > ------------------
> > 
> > From: James Bottomley <James.Bottomley@HansenPartnership.com>
> > 
> > commit 42caa0edabd6a0a392ec36a5f0943924e4954311 upstream.
> > 
> > The aic94xx driver is currently failing to load with errors like
> > 
> > sysfs: cannot create duplicate filename
> > '/devices/pci0000:00/0000:00:03.0/0000:02:00.3/0000:07:02.0/revision'
> > 
> > Because the PCI code had recently added a file named 'revision' to
> > every PCI device.  Fix this by renaming the aic94xx revision file to
> > aic_revision.  This is safe to do for us because as far as I can
> > tell, there's nothing in userspace relying on the current aic94xx
> > revision file so it can be renamed without breaking anything.
> > 
> > Fixes: 702ed3be1b1b (PCI: Create revision file in sysfs)
> 
> jejb@jarvis:~/git/linux> git describe --contains 702ed3be1b1b
> v4.10-rc1~94^2~18^2~1
> 
> I suppose interface consistency is useful, but under the stable rules,
> shouldn't this only be ported as far back as the bug it fixes?

Good catch.  I added it to the 4.9 tree too :(

I'll go drop this from the 4.4 and 3.18 stable queues and queue up a
revert for 4.9.y.

thanks,

greg k-h
