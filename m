Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93254C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5374C2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549963591;
	bh=ysHZxKCnEN9zAVAou8yL6w4CmGfb4oV0SD0WEMvfYZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SoLJpvEp5xZ+ljAgGEOMB7FsCo7Qbogb76YJf5smA2/sKAo9+pWREiQswfB3TBft6
	 PasbgK/sM1dliMbpMhZcsr8cODnZ8/NGQyUysuqMIGMlcAi1xnduBWo+4pcbXTG1OT
	 bUHFwQH6cXqR9G0CU4d+1FYD12n3aCawSoJXhbro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfBLJ03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:26:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfBLJ03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:26:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 760B221773;
        Tue, 12 Feb 2019 09:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549963589;
        bh=ysHZxKCnEN9zAVAou8yL6w4CmGfb4oV0SD0WEMvfYZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wxi9tLEi/Tn69+Xq4v5JZyxDZgX1lo37VvG1AA6OV8tIL1EhamNjegi74nIwA6A+p
         Yuk8RxnT8WXE3DjREbglgg+ahN3WAfy/DBwQUgOqFoOZzG8Y1iCgSB2/t7yJDh8UEv
         Md1IoH+hx2l8xQ1W+SYfVHFqyUc+PSUmQf1R1vjU=
Date:   Tue, 12 Feb 2019 10:26:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/nozomi: use pci_iomap instead of ioremap_nocache
Message-ID: <20190212092625.GC27450@kroah.com>
References: <20190210171212.GA22758@behemoth.owl.eu.com.local>
 <20190210214500.GB22758@behemoth.owl.eu.com.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210214500.GB22758@behemoth.owl.eu.com.local>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 10:45:00PM +0100, Hugo Lefeuvre wrote:
> > Use pci_iomap instead of ioremap_nocache in nozomi_card_init(). This
> > is a cleaner way to do PCI MMIO (performs additional checks) and
> > allows to drop the manual call to pci_resource_start.
> > 
> > pci_iomap relies on ioremap for MMIO and thus has uncached behavior.
> 
> there's still something unclear to me about dc->card_type being used as
> size argument to ioremap_nocache().
> 
> dc->base_addr is the sum of all six io region lengths, not the size of
> region 0 which we are trying to map here. Why not using the size of region
> 0 instead ?

No idea, that might just be how the card is layed out.

> If the goal is to map all six regions "at once", I'm not sure how this is
> supposed to work. Is there any kind of guarantee that all six regions will
> be adjacent?

For some reason, it must happen that way, otherwise the driver would not
work very well :)

> If this is a bug then this patch "somehow" already adresses it since
> pci_iomap calls pci_resource_len itself. Otherwise this patch is broken.

Let's apply it and see if anyone screams...

thanks,

greg k-h
