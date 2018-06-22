Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F5CC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B5C24864
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O8H+WY5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B5C24864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754441AbeFVUGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:06:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55456 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeFVUGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Es9OVvvOeu8O9jtJ4qHwX/JeykzknG3BGuzRszeX4lI=; b=O8H+WY5ZgyMmDfAErFgOTs4hWJ
        oU3fBdbxH2NWdzyCQasS901q1sEVQtTTYg+TBaxEgTOfup/Z1SJAs5eEDsjeif1xd7Q2STNpuFQoM
        ZxfVZQmAnc6qmu5ox11yOT5y//bNpWYmit0kkQ+TVKEhaUN7hEVN6BKEljg/GXn1meFoOd7OCu+aq
        BuciAQ9yg7u0OkjpJ0Eir6gWiAtjMVjWmuKT0BRkF92kIOJWt0mE9FxYO6dhEY85YCoNmAYP52J6D
        nMz+Mc2ENyTMIlYVLSyLaFDM4KuIt+txvsMKZuuQAGOFpNh3YXQCjcSOb57/jOD7rLDHnlPAIAL5u
        Iks/z4Xw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWSJk-0003Ny-Fl; Fri, 22 Jun 2018 20:06:00 +0000
Subject: Re: [PATCH v4 1/3] PCI: Make specifying PCI devices in kernel
 parameters reusable
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
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
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20180622194315.10475-1-logang@deltatee.com>
 <20180622194315.10475-2-logang@deltatee.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1222da4e-864c-5e27-b735-99fc53d1e367@infradead.org>
Date:   Fri, 22 Jun 2018 13:05:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622194315.10475-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/22/2018 12:43 PM, Logan Gunthorpe wrote:

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 97acba712e4e..cb999b2a9530 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -191,6 +191,92 @@ void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar)
>  EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
>  #endif
>  
> +/**
> + * pci_dev_str_match - test if a string matches a device
> + * @dev:    the PCI device to test
> + * @p:      string to match the device against
> + * @endptr: pointer to the string after the match
> + *
> + * Test if a string (typically from a kernel parameter) matches a
> + * specified. The string may be of one of the following formats:

"matches a specified."  eh?

> + *
> + *   [<domain>:]<bus>:<slot>.<func>
> + *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
> + *
> + * The first format specifies a PCI bus/slot/function address which
> + * may change if new hardware is inserted, if motherboard firmware changes,
> + * or due to changes caused in kernel parameters. If the domain is
> + * left unspecified, it is taken to be 0.
> + *
> + * The second format matches devices using IDs in the configuration
> + * space which may match multiple devices in the system. A value of 0
> + * for any field will match all devices. (Note: this differs from
> + * in-kernel code that uses PCI_ANY_ID which is ~0; this is for
> + * legacy reasons and convienence so users don't have to specify

                         convenience

> + * FFFFFFFFs on the command line.)
> + *
> + * Returns 1 if the string matches the device, 0 if it does not and
> + * a negative error code if the string cannot be parsed.
> + */
> +static int pci_dev_str_match(struct pci_dev *dev, const char *p,
> +			     const char **endptr)
> +{

thanks,
-- 
~Randy
