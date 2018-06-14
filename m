Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6A1C6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B239208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B239208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754822AbeFNIWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:22:04 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:8068 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbeFNIWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:22:02 -0400
X-IronPort-AV: E=Sophos;i="5.51,222,1526342400"; 
   d="scan'208";a="74640716"
Date:   Thu, 14 Jun 2018 10:21:54 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Hooman Mirhadi <mirhadih@amazon.com>,
        Amit Shah <aams@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 119/268] xen/pirq: fix error path cleanup when
 binding MSIs
Message-ID: <20180614082154.froqupxpmory2f4i@mac.bytemobile.com>
References: <1528914431.2289.163.camel@citrix.com>
 <1528915730.2289.166.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528915730.2289.166.camel@codethink.co.uk>
User-Agent: NeoMutt/20180512
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 07:48:50PM +0100, Ben Hutchings wrote:
> On Wed, 2018-02-28 at 09:19 +0000, Roger Pau Monne wrote:
> > From: Roger Pau Monne <roger.pau@citrix.com>
> > 
> > [ Upstream commit 910f8befdf5bccf25287d9f1743e3e546bcb7ce0 ]
> > 
> > Current cleanup in the error path of xen_bind_pirq_msi_to_irq is
> > wrong. First of all there's an off-by-one in the cleanup loop, which
> > can lead to unbinding wrong IRQs.
> > 
> > Secondly IRQs not bound won't be freed, thus leaking IRQ numbers.
> > 
> > Note that there's no need to differentiate between bound and unbound
> > IRQs when freeing them, __unbind_from_irq will deal with both of them
> > correctly.
> 
> It appears to me that it is safe to call __unbind_from_irq() after
> xen_irq_info_common_setup() fails, but *not* if the latter hasn't been
> called at all.  In that case the IRQ type will still be set to
> IRQT_UNBOUND and this will trigger the BUG_ON() in __unbind_from_irq().
> 
> [...]
> > --- a/drivers/xen/events/events_base.c
> > +++ b/drivers/xen/events/events_base.c
> > @@ -764,8 +764,8 @@ out:
> >  	mutex_unlock(&irq_mapping_update_lock);
> >  	return irq;
> >  error_irq:
> > -	for (; i >= 0; i--)
> > -		__unbind_from_irq(irq + i);
> > +	while (nvec--)
> > +		__unbind_from_irq(irq + nvec);
> 
> If nvec > 1, and xen_irq_info_pirq_setup() fails for i != nvec - 1,
> then we reach here without having called xen_irq_info_common_setup()
> for all these IRQs.
> 
> In that case, I think we will still want to call xen_free_irq() for all
> IRQs.  So maybe the fix would be to remove the BUG_ON() in
> __unbind_from_irq()?

I think your analysis is right, and I agree that removing the BUG_ON
from __unbind_from_irq seems like the right solution.

I can't see any issues from calling xen_free_irq with type ==
IRQT_UNBOUND, but I've already attempted to fix this once and failed,
so I would like to get second opinions. Also I'm not sure of the
reason behind that BUG_ON.

Roger.
