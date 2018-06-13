Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9EDE2C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546A8208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546A8208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935374AbeFMSs4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:48:56 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49975 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935070AbeFMSsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:48:55 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fTAp9-00065C-Kh; Wed, 13 Jun 2018 19:48:51 +0100
Message-ID: <1528915730.2289.166.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 119/268] xen/pirq: fix error path cleanup when
 binding MSIs
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Hooman Mirhadi <mirhadih@amazon.com>,
        Amit Shah <aams@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Date:   Wed, 13 Jun 2018 19:48:50 +0100
In-Reply-To: <1528914431.2289.163.camel@citrix.com>
References: <1528914431.2289.163.camel@citrix.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-28 at 09:19 +0000, Roger Pau Monne wrote:
> From: Roger Pau Monne <roger.pau@citrix.com>
> 
> [ Upstream commit 910f8befdf5bccf25287d9f1743e3e546bcb7ce0 ]
> 
> Current cleanup in the error path of xen_bind_pirq_msi_to_irq is
> wrong. First of all there's an off-by-one in the cleanup loop, which
> can lead to unbinding wrong IRQs.
> 
> Secondly IRQs not bound won't be freed, thus leaking IRQ numbers.
> 
> Note that there's no need to differentiate between bound and unbound
> IRQs when freeing them, __unbind_from_irq will deal with both of them
> correctly.

It appears to me that it is safe to call __unbind_from_irq() after
xen_irq_info_common_setup() fails, but *not* if the latter hasn't been
called at all.  In that case the IRQ type will still be set to
IRQT_UNBOUND and this will trigger the BUG_ON() in __unbind_from_irq().

[...]
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -764,8 +764,8 @@ out:
>  	mutex_unlock(&irq_mapping_update_lock);
>  	return irq;
>  error_irq:
> -	for (; i >= 0; i--)
> -		__unbind_from_irq(irq + i);
> +	while (nvec--)
> +		__unbind_from_irq(irq + nvec);

If nvec > 1, and xen_irq_info_pirq_setup() fails for i != nvec - 1,
then we reach here without having called xen_irq_info_common_setup()
for all these IRQs.

In that case, I think we will still want to call xen_free_irq() for all
IRQs.  So maybe the fix would be to remove the BUG_ON() in
__unbind_from_irq()?

Ben.

>  	mutex_unlock(&irq_mapping_update_lock);
>  	return ret;
>  }

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

