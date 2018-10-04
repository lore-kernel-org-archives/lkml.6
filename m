Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6F1C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D97221477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="oyQBRYvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D97221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeJDOzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:55:23 -0400
Received: from 8bytes.org ([81.169.241.247]:33664 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbeJDOzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:55:23 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D1EBF345; Thu,  4 Oct 2018 10:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1538640201; bh=XPhccCMbtn9iplTQHeIw6KhjAjgA241zOIp2H4Nhr08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oyQBRYvAsjaE5XbSACbXLIWioaFV8Qh0uNFFZc5nldknQAZzam1gjWECJdvvv5icb
         gLKjiAQRGMEodw7FJmm43kl9OZn4GHEONxEcXz2B9dUyigmHOXLh2PwouqcbI4e35E
         nnr8S9LCS8EgxLTHzG6pDcFQozD+eSHznZGUMGTmpXtUqaEbr2pis2wEiYQLg8CH70
         dtm/IHqNDBFbMLc+lAp9egY9HV9z9ovGVHI6upV8sY7npnpnIekwpGKdaYIjVfRGaJ
         VJD6Nh11nUEotndHpCklmvDPnLzyx5ec1ku+TEJMZK7QPOa3wV83cKmx5bK3r/+tyT
         447zPvP4dktEQ==
Date:   Thu, 4 Oct 2018 10:03:21 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>, linux-mm@kvack.org,
        x86@kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: x86/mm: Found insecure W+X mapping at address (ptrval)/0xc00a0000
Message-ID: <20181004080321.GA3630@8bytes.org>
References: <e75fa739-4bcc-dc30-2606-25d2539d2653@molgen.mpg.de>
 <alpine.DEB.2.21.1809191004580.1468@nanos.tec.linutronix.de>
 <0922cc1b-ed51-06e9-df81-57fd5aa8e7de@molgen.mpg.de>
 <alpine.DEB.2.21.1809210045220.1434@nanos.tec.linutronix.de>
 <c8da5778-3957-2fab-69ea-42f872a5e396@molgen.mpg.de>
 <alpine.DEB.2.21.1809281653270.2004@nanos.tec.linutronix.de>
 <20181003212255.GB28361@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003212255.GB28361@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 11:22:55PM +0200, Borislav Petkov wrote:
> On Fri, Sep 28, 2018 at 04:55:19PM +0200, Thomas Gleixner wrote:
> > Sorry for the delay and thanks for the data. A quick diff did not reveal
> > anything obvious. I'll have a closer look and we probably need more (other)
> > information to nail that down.

I also triggered this when working in the PTI-x32 code. It always
happens on a 32-bit PAE kernel for me.

Tracking it down I ended up in (iirc) arch/x86/mm/pageattr.c
	function static_protections():

		/*
		 * The BIOS area between 640k and 1Mb needs to be executable for
		 * PCI BIOS based config access (CONFIG_PCI_GOBIOS) support.
		 */
	#ifdef CONFIG_PCI_BIOS
		if (pcibios_enabled && within(pfn, BIOS_BEGIN >> PAGE_SHIFT, BIOS_END >> PAGE_SHIFT))
			pgprot_val(forbidden) |= _PAGE_NX;
	#endif

I think that is the reason we are seeing this in that configuration.


Regards,

	Joerg
