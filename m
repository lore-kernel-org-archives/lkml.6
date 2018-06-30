Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF26BC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 19:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9E924252
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 19:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yPcMhLP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9E924252
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbeF3TUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 15:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbeF3TUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 15:20:01 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E781C24252;
        Sat, 30 Jun 2018 19:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530386401;
        bh=gJH60u9w644c6KxbJcbYS7RXD6U9iir2wqBzLSTPN3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yPcMhLP/SF8H2Z644XzdF4n71KUQhp0UJ+1zQWGaxFOYt7w54oWZEdOejvVIWXJIc
         CI/ygDlNX3KWxdXHluqp1A5xL1Ucswl1SRlD+ZvwXCj4jAV8MEQE+yUy20vZlsDvBa
         MAyOrkZ3pE0/uC48S5ElMFNX4et7/wKPx3qGcnKM=
Date:   Sat, 30 Jun 2018 14:19:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     linux-pci@vger.kernel.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
Message-ID: <20180630191959.GB9547@bhelgaas-glaptop.roam.corp.google.com>
References: <1529460886-23722-1-git-send-email-okaya@codeaurora.org>
 <20180630004912.GI40928@bhelgaas-glaptop.roam.corp.google.com>
 <568634cf-54d0-c67d-b0f8-766b67def610@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568634cf-54d0-c67d-b0f8-766b67def610@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 10:45:21AM -0400, Sinan Kaya wrote:
> On 6/29/2018 8:49 PM, Bjorn Helgaas wrote:
> > On Tue, Jun 19, 2018 at 10:14:46PM -0400, Sinan Kaya wrote:
> >> A PCIe endpoint carries the process address space identifier (PASID) in
> >> the TLP prefix as part of the memory read/write transaction. The address
> >> information in the TLP is relevant only for a given PASID context.
> >>
> >> An IOMMU takes PASID value and the address information from the
> >> TLP to look up the physical address in the system.
> >>
> >> If a bridge drops the TLP prefix, the translation agent can resolve the
> >> address to an incorrect location and cause data corruption. Prevent
> >> this condition by requiring End-to-End TLP prefix to be supported on the
> >> entire data path between the endpoint and the root port.
> > 
> > PASID is an End-End TLP Prefix (PCIe r4.0, sec 6.20).  Sec 2.2.10.2 says
> > 
> >   It is an error to receive a TLP with an End-End TLP Prefix by a
> >   Receiver that does not support End-End TLP Prefixes. A TLP in
> >   violation of this rule is handled as a Malformed TLP. This is a
> >   reported error associated with the Receiving Port (see Section 6.2).
> > 
> > So I agree that we shouldn't enable PASID in an endpoint unless all
> > the switch ports leading to it support End-End prefixes.  But I don't
> > see how a bridge can drop a prefix and cause data corruption -- if it
> > doesn't support End-End prefixes, shouldn't the bridge raise a
> > Malformed TLP error instead of forwarding the TLP?
> 
> It should under normal circumstances. 
> 
> I remember reading that most PCIe switches don't support TLP prefixes.
> I don't know if it is because of buggy behavior or if it is just plain
> unsupported while dropping the request as Malformed TLP.
> 
> I was trying to be proactive and not enable PASID if the entire path
> is incapable.

Absolutely, that makes perfect sense.  Much better to fail to enable
PASID rather than enabling it and seeing Malformed TLP errors or data
corruption later.

I was trying to figure out if you can actually force data corruption
this way.  If you can, I'd say that sounds like a buggy switch that we
might want to be aware of.

Bjorn
