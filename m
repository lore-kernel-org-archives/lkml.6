Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77608C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380A020C0B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380A020C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeHTOvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:51:52 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46044 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeHTOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:51:52 -0400
Received: by mail-qk0-f194.google.com with SMTP id c192-v6so10546077qkg.12;
        Mon, 20 Aug 2018 04:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrnLOn8v69lnFmICjGqysrHynU2MjRjNv20L/2S9p9c=;
        b=jMP4fxiCLPrVNBRrGwMSP7FOIFUArTvnBi5Fi2uZxzK+zTxWZ3FLvqDOHKZWJNeSBF
         EtGfZu2Uwkrovf2IvMb6HqK6VRFwyCrHxu3OnYbEX/em1Si2XnxVMOuF7UPf7LDLSxYa
         8xkhRuReY0DdlaWbqCnkhF79LhEmJilomCgtR40sbNvXfPcopJUoWvCIIERjSYxScaXg
         ZOeamEejcP3mz/qy+gt/i5QktJnHhXDYSfCyoBXzXO0J6Nw5gDADYSV/o8DXaUX0qlXG
         K1NfsiXoeRPufVmhvCdW42x3+uiqcj2CL1m8m3apy5ys9LOjBSBqaMWndJqq6SSXSpz7
         frow==
X-Gm-Message-State: AOUpUlF7J9AsDvRPfJY8bv+s63FTiI4o5JDcS0bpCTdYF7CpqVvt16EW
        bNaN8KgQlzz2djcfCNhPwIOsS/lP4anmPzCzz4w=
X-Google-Smtp-Source: AA+uWPw7SZ73vZypnfO8k491nuXygZ+N/no3rKENW0UdkGHsrM6+cmlx2fzRmD8Eh0JLvpqP4Z3RzupzoTxGwUMwy2g=
X-Received: by 2002:a37:7946:: with SMTP id u67-v6mr39746101qkc.283.1534764996023;
 Mon, 20 Aug 2018 04:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180817102645.3839621-1-arnd@arndb.de> <20180817102645.3839621-8-arnd@arndb.de>
 <CAJZ5v0iCgQxxuoCB9B4-Ho3xeLwb4v99Xyw-9e-tT53mRD+YVQ@mail.gmail.com>
 <CAK8P3a31Ds14Ke1qLoMapK1Wq1M4tR6n+nL1VOKzR8+oN0eOBw@mail.gmail.com> <CAJZ5v0gu_agFQBS7UjTMY3FR7woPPN-riJ6frwk1QoetGoVjfA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gu_agFQBS7UjTMY3FR7woPPN-riJ6frwk1QoetGoVjfA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Aug 2018 13:36:19 +0200
Message-ID: <CAK8P3a2nHxGTo9ajAweQpoutLhUns8SK0c6NWf4nV=PZhf0j_A@mail.gmail.com>
Subject: Re: [RFC 07/15] PCI/ACPI: clean up acpi_pci_root_create()
To:     Rafael Wysocki <rafael@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 1:24 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Aug 20, 2018 at 1:20 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Aug 20, 2018 at 10:23 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Fri, Aug 17, 2018 at 12:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > @@ -909,8 +881,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> > > >         int ret, busnum = root->secondary.start;
> > > >         struct acpi_device *device = root->device;
> > > >         int node = acpi_get_node(device->handle);
> > > > -       struct pci_bus *bus;
> > > > -       struct pci_host_bridge *host_bridge;
> > > > +       struct pci_host_bridge *bridge;
> > >
> > > Why "bridge" and not "host" or even something to stand for "root complex"?
> > >
> > > Or maybe it can still be "host_bridge"?
> >
> > I did this for consistency with the naming in drivers/pci/probe.c,
> > which always declares the local variable as 'struct pci_host_bridge *bridge'.
> > It's easy to change here if you feel strongly about it (I don't).
>
> I would leave host_bridge here.  It would make the patch smaller too I think.

Ok, I've changed my local copy as you suggested now.

      Arnd
