Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9528BC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467BA22CB2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="dW1M7pqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467BA22CB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933311AbeGFPN3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:13:29 -0400
Received: from 8bytes.org ([81.169.241.247]:55518 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932635AbeGFPN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:13:28 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A7BD0372; Fri,  6 Jul 2018 17:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530890006; bh=Xht5kUsCTXeVPR1+3dxTe09fRlXYQNbDPi93DLZoN+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dW1M7pqwlpT0tMb0ZaTbAc4ZBjfXz2gSEffCZpJUaqssx8u0O4NXnpcC3Ns2Emlj4
         Wblj+FuVd2aZ9yCRQCA8IIKeAqXOpY4Zc4mKkxCJMV8m36jpaO/UgsysPQ7Pb7LrI3
         O8B9IWnMn6a4yLdAs+RBpU0RP2l3RDmQtdpNi3KZQ5YnHsSzilvowqPV+rRhlpp1Ug
         h/WeVX9SorI4gMeKR6DcI6SYEv0vGr6KxXES32bDcnhXJMIu9IKL9XeJVsnJzRHAhN
         Tc80Ncs59ADPb5/A6S+luC067kxd6ON+sOp3ek2//+gdOa1HuFEmjNl1qu/HWbVzWx
         UwNRgsIIUErjQ==
Date:   Fri, 6 Jul 2018 17:13:21 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [RFC 0/3] iommu/iova: Unsafe locking in find_iova()
Message-ID: <20180706151321.sq25kc7otgjo3xvn@8bytes.org>
References: <20180621180823.805-1-dima@arista.com>
 <20180706131611.h3w2kdinmjguikgo@8bytes.org>
 <1530886247.3205.53.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530886247.3205.53.camel@arista.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:10:47PM +0100, Dmitry Safonov wrote:
> Yes, as far as I can see, there are code-paths which may try to handle
> it at the same time:
> o memory notifiers for hot-unplug (intel-iommu.c)
> o drivers unloading calls free_iova(), which in the result calls
>   find_iova()
> o I see at least one driver that frees iova during it's normal work
>   too: scif_rma.c:scif_free_window_offset()

Yeah, but the IOVAs freed in the memory notifiers are just the ones for
the direct-mapped RMRR regions requested by firmware, not the IOVAs
allocated by any driver, so I think this shouldn't be a problem.


Regards,

	Joerg

