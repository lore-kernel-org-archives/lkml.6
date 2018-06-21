Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1908C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6ED21C16
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sqc0fKPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6ED21C16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754276AbeFUTW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:22:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754129AbeFUTWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EGrbVZB0DlhS1XKIlcWkcwmIHatxL7EHkaNy26JV3JE=; b=sqc0fKPIhb2zWzFOjcr6MHIxH
        zxRLR7oTXppLTAckqaCnuUj7rQuBnXSuQKPh1176RHf2O7OYKs8pEeKc4HnMTbMcathMdqIwGMCIV
        JfKiByajXZw7paOk70vTy+AoaPDFImBYyU7WWgofpkEeMUCQzQYzE0NJXUMyJdbz+OEVP25kpYl2Q
        C5VaT22aQRwE0C8gZjZ1sFjZZQCWHxFbNlq64JtkPa0o4WD/8hBraUoM9ZSSrLJqI0eUvFVTDsQAT
        UV3UB92Fn8u7/soOAhMz9Cm34gVip5KXec/2MmYaKCu7uM4a4wAxSWe7WsfLC8lXdfvhuMnlXXR9b
        cJvqgUcew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW59x-0004Ea-1a; Thu, 21 Jun 2018 19:22:21 +0000
Date:   Thu, 21 Jun 2018 12:22:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v3 2/3] PCI: Allow specifying devices using a base bus
 and path of devfns
Message-ID: <20180621192220.GA6635@bombadil.infradead.org>
References: <20180618193636.16210-1-logang@deltatee.com>
 <20180618193636.16210-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618193636.16210-3-logang@deltatee.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 01:36:35PM -0600, Logan Gunthorpe wrote:
> @@ -3000,14 +3000,18 @@
>  				or a set of devices (<pci_dev>). These are
>  				specified in one of the following formats:
>  
> -				[<domain>:]<bus>:<slot>.<func>
> +				[<domain>:]<bus>:<slot>.<func>[/<slot>.<func>][/ ...]

How about:
+				[<domain>:]<bus>:<slot>.<func>[/<slot>.<func>]*

> -				by other kernel parameters. The second format
> +				by other kernel parameters. Optionally
> +				a path from a device through multiple

I think that's "a path to a device", because you'd start by specifying the
root port, then continuing down the hierarchy, right?

> + * Test if a string (typically from a kernel parameter) formated as a

formatted

> + * path of slot/function addresses matches a PCI device. The string must
> + * be of the form:
> + *
> + *   [<domain>:]<bus>:<slot>.<func>/<slot>.<func>[/ ...]
> + *
> + * A path for a device can be obtained using 'lspci -t'. Using a path
> + * is more robust against renumbering of devices than using only

I'd call it bus renumbering rather than device renumbering.  After all,
if the device got renumbered, this would fail ;-)

>   * pci_dev_str_match - test if a string matches a device
>   * @dev:    the PCI device to test
>   * @p:      string to match the device against
>   * @endptr: pointer to the string after the match
>   *
>   * Test if a string (typically from a kernel parameter) matches a
> - * specified. The string may be of one of two forms formats:
> + * specified. The string may be of one of three formats:

Surely just "The string may be in one of three formats"

>   *
>   *   [<domain>:]<bus>:<slot>.<func>
> + *   path:[<domain>:]<bus>:<slot>.<func>/<slot>.<func>[/ ...]
>   *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]

I think you're dropped the "path:" prefix from your parser?

>   * The first format specifies a PCI bus/slot/function address which
>   * may change if new hardware is inserted, if motherboard firmware changes,
>   * or due to changes caused in kernel parameters.
>   *
> - * The second format matches devices using IDs in the configuration
> + * The second format specifies a PCI bus/slot/function root address and
> + * a path of slot/function addresses to the specific device from the root.
> + * The path for a device can be determined through the use of 'lspci -t'.
> + * This format is more robust against renumbering issues than the first format.
> +
> + * The third format matches devices using IDs in the configuration
>   * space which may match multiple devices in the system. A value of 0
>   * for any field will match all devices.
>   *

So you probably want to reword this too.  Two formats, one with optional
trailing path elements?

