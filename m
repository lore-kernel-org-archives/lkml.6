Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EC8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D113208D6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D113208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbeHQLuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:50:24 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40996 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeHQLuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:50:24 -0400
Received: by mail-qt0-f194.google.com with SMTP id e19-v6so7957885qtp.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 01:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NdDFsX59QAZh7V/473p6Y++g4Zv9dNhNyjnNEKMNUE=;
        b=T3eORUIuZgKElNCPaMdbseP8e3C61giaSC3/5k6+F1qP5nNClMoI7HtB9YUvkV3Yxi
         s7qZ4BJwpJ8LNo/fGLufnLqkBUo8NbBnBr/aoN7H9Or+jbuGWTUZpDwOevvXJ3VRu++d
         5RIDrXCm2u8j/8SQilZyd0Dd4fBmagHiRl1kB0W6NRPmT4NSQcr8sWIcoDwFQGWndRVc
         xpgGjgoge3DkHukEbEZlhgd2cfK6iGohZAuMjBpm+c0uDR51gtHOy7EJMqIqVjTGLIc3
         zx2pclp6i9sHf6huvaadkM9luqdCR7PbmE8zuSKc6k9a959KvdDuIJcgtQIMRvo0Kk8n
         rpEQ==
X-Gm-Message-State: AOUpUlE8q5pZTZrjj2Ftr14RzkifVqUzDR/JysTzOPcGoX8LZA8piG44
        eBLCGJrK/0qiaB29wT5i2P9RlToOObpLux+07YI=
X-Google-Smtp-Source: AA+uWPzolt1M8qWV5U8Vng2DoQST3dYodes1uJUGycTJvV5ix2CUnsa+ryL4L/RbtbtMrxLBVxrbK9aYD5eoJw/M2Ms=
X-Received: by 2002:ac8:2dc6:: with SMTP id q6-v6mr34080772qta.178.1534495670759;
 Fri, 17 Aug 2018 01:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180816204506.GA21144@agluck-desk> <CAK8P3a2vAMzL22ds=kM1WRZgATzOrAz_y8Yk6edqJTVRJJFydw@mail.gmail.com>
 <20180816232639.GA25889@agluck-desk>
In-Reply-To: <20180816232639.GA25889@agluck-desk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Aug 2018 10:47:34 +0200
Message-ID: <CAK8P3a0hFDv2kvVN=QobTVaZxAX-M+YZzkBU_b=vDGLbCLziNg@mail.gmail.com>
Subject: Re: how to fix acpi_pci_root_remap_iospace?
To:     Tony Luck <tony.luck@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jchandra@broadcom.com, Sinan Kaya <okaya@codeaurora.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 1:27 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Thu, Aug 16, 2018 at 11:10:33PM +0200, Arnd Bergmann wrote:
> > Another way would be to add
> >
> >  #include <asm-generic/io.h>
> > +#undef PCI_IOBASE
> >
> > in your asm/io.h. This is about as ugly as the your version, but
> > it would be local to ia64 ;-)
>
> Third way ...
>
>
> Is "0" actually the right value for PCI_IOBASE for some platform?
>
> #ifndef PCI_IOBASE
> #define PCI_IOBASE ((void __iomem *)0)
> #endif
>
> Or is this just here to make sure that:
>
> static inline u8 inb(unsigned long addr)
> {
>         u8 val;
>
>         __io_pbr();
>         val = __raw_readb(PCI_IOBASE + addr);
>         __io_par();
>         return val;
> }
>
> etc. Do not throw errors?

Defining it to zero is the traditional approach on some systems, and it's used
for at least two different reasons, both of which I don't particularly like:

- Some (particularly older) targets that have its I/O space mapped
into its linear
  virtual memory define inb() to be effectively an alias for readb() with the
  same numeric arguments. This kind of works in most cases but breaks in
  many corner cases such as
  * user space using /dev/ioport, which now grants access to all of
kernel memory
  * ISA device drivers using fixed 16-bit addresses on inb/outb, which
now points
    into user space memory
  * drivers that get the correct address from a resource but then truncate it by
    storing it in a 16-bit or 32-bit (on 64-bit machines) local variable.

- Some targets don't have any support for I/O space on their PCI bus and just
   want to get things to compile by setting PCI_IOBASE to zero, this still opens
    up some of the same problems as above, but doesn't really help otherwise.

> Should we really just enclose all of inb, inw, inl, ...
> inside of:
>
> #ifdef PCI_IOBASE
>
> ... all those static functions that use PCI_IOBASE ...

This breaks compilation of a couple of important drivers such as serial-8250
which support either I/O or memory space, so it requires some cleanup
first, or the definition of an alternative nop inb/outb family that does not
try to access the bus.

       Arnd
