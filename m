Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562B6C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E81221570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E81221570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeHTUq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:46:59 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:40127 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTUq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:46:59 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9CD01100DA1A6;
        Mon, 20 Aug 2018 19:22:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4EEF5240DDC; Mon, 20 Aug 2018 19:22:13 +0200 (CEST)
Date:   Mon, 20 Aug 2018 19:22:13 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] PCI: pciehp: Ignore link events when there is a
 fatal error pending
Message-ID: <20180820172213.tg4fle6ugi7lkhxx@wunner.de>
References: <20180818065126.77912-1-okaya@kernel.org>
 <20180820092238.kvktwlovc64oa66e@wunner.de>
 <c207adfb-ba3d-700b-2935-aab2fe171e6b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c207adfb-ba3d-700b-2935-aab2fe171e6b@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 12:59:05PM -0400, Sinan Kaya wrote:
> On 8/20/2018 5:22 AM, Lukas Wunner wrote:
> > > +
> > This differs from v7 of the patch in that*any*  fatal error, not just
> > a Surprise Link Down, results in pciehp waiting for the error to clear.
> > 
> > I'm wondering if that's safe:  Theoretically, the user might quickly
> > swap the card in the slot during, say, a Completion Timeout Error,
> > and with this patch pciehp would carry on as if nothing happened.
> 
> Functionally both patches are identical. The v7 was still allowing
> AER/DPC to handle all fatal error events except Surprise Link Down.
> 
> Now, second patch (v8 2/2) is masking the surprise link down event
> as we have talked before. Therefore, there is no need to filter
> out incoming errors by reading the status register and masking the
> unwanted bits.

Ok, missed that.


> Just to clarify something, this patch will wait for only the FATAL
> error events to be handled by the error handling services only.
> 
> Completion Timeout is a NONFATAL error event by default unless
> somebody tweaks the severity bits.
> 
> Anyhow, all FATAL errors cause one sort of link down either
> initiated by software (AER) or hardware (DPC).
> Therefore, hotplug driver will observe a link down event and
> AER/DPC needs to handle the event as usual.

Thanks for the clarification.

Lukas
