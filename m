Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A980C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C424F20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7HqY6d+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C424F20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502232AbeKWR6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:58:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731989AbeKWR6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:58:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8743820820;
        Fri, 23 Nov 2018 07:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542957347;
        bh=jg+b563dNA2UsHKAVAYALYSoHxtG6t/OmWAeaa+0/Ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R7HqY6d+eWK0H5mOnNS6EjqFVMf8t0FDdUC22V6x+RKJjvp70aYw3LaIxSIeh7FRt
         T1lVGD5j0ZankRPLX0jA7/E1+aVQopoShn6LrAVBcpkFY72yNOOn4nAUl26HYt+sNm
         u+0cNouHbu41Vr/RlAPUnef3HmltlAP7BVV3KDS8=
Date:   Fri, 23 Nov 2018 08:15:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org,
        Murilo Fossa Vicentini <muvic@linux.vnet.ibm.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH 4.9 00/59] 4.9.139-stable review
Message-ID: <20181123071545.GB26178@kroah.com>
References: <20181121183508.262873520@linuxfoundation.org>
 <b642656d-4b0d-cb68-f862-9d90bacc88cc@roeck-us.net>
 <bf811213-e1ad-d70e-cf9e-57735e359377@linux.ibm.com>
 <31eca57c-ffb2-f646-6686-df304e6ce76b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31eca57c-ffb2-f646-6686-df304e6ce76b@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 11:49:55AM -0800, Guenter Roeck wrote:
> On 11/22/18 10:07 AM, Murilo Fossa Vicentini wrote:
> > On 22/11/18 14:33, Guenter Roeck wrote:
> > > drivers/net/ethernet/ibm/ibmvnic.c: In function 'ibmvnic_xmit':
> > > drivers/net/ethernet/ibm/ibmvnic.c:789:40: error: implicit declaration of function 'skb_vlan_tag_present'
> > > 
> > > Caused by 5f51bb855fa1 ("ibmvnic: fix accelerated VLAN handling").
> > > Problem is missing include of linux/if_vlan.h, which was added upstream
> > > with commit 6052d5e2a1961b ("ibmvnic: Insert header on VLAN tagged
> > > received frame").
> > > 
> > > I have no idea if the offending patch fixes 6052d5e2a1961b, if both are
> > > independent, if both are needed, or if none is needed.
> > > Copying the authors of both patches.
> > 
> > Both address different parts of the code within the same VLAN functionality, patch 5f51bb855fa1 (or upstream e84b47941e15) is making a change on the transmit side, and the patch I sent upstream (6052d5e2a196) addresses an issue when the system firmware strips the VLAN tag on the receive side.
> > 
> > In the context of having proper VLAN support for the ibmvnic driver I would say both are needed, although potentially there are other patches needed for this functionality to work properly, for example upstream commit da75e3b6a029 (ibmvnic: Account for VLAN tag in L2 Header descriptor) and upstream commit 8dff66cc4195 (ibmvnic: Account for VLAN tag in L2 Header descriptor).
> > 
> 
> Not my call to make, but it seems to me that it might be better to drop
> the patch from 4.9.y and ask people to use a later kernel if they need
> vlan support for the ibmvnic driver.

Thanks all for figuring this out.  I'm just going to drop this patch
from the tree for now.

greg k-h
