Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379AFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4741213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4741213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeHTOmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:42:05 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37433 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:42:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id j205-v6so25165956oib.4;
        Mon, 20 Aug 2018 04:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+s9BNrXjQaT22ZS4ts+TSEtQ1Lld4DxSmX/GDfTts9A=;
        b=ij0mda53TV88L0H9H/Gw5V/0IoQQgyJJ/t+Qq0hKgWpGL2sz5y0jr3oLI/LecjQAhv
         no80dSBVmIq4XbfXsH1TtjHZtif/9RikDCCs27g3xlCxErsBdRM53ASf3nABQoQKQYEk
         qgIWtrXpvwrWtrJltmoBAwnIdUNLrBhCXhQETHClCyo+xj6F7YtrqoDKfbKVLs11IzXe
         90hsgp/LygzKpckfyYJZHvBFCSFGpz+o0TER18z7LGoDb6N+9rE5MjVsRB1hNXqvU/4m
         OTGgOzB8VngyZqbQq/Cky+GyQcyoEN0EVVHdI1oIqOfej6QhKbjy/qOA9m4CYwbDgAIK
         D/Pg==
X-Gm-Message-State: AOUpUlGLNh0PPL/v67pFeua6KjqUVwQO6Xt9CX2ZYtJiQwwMi4ZYMQc8
        b2OhVpXBwAICx7X1hvNTg+fyBmFp0xVLQ2bSwDM=
X-Google-Smtp-Source: AA+uWPwDQsxbAloZ4AVZJBQzSFVqCrRcxF2AngUhXv3ClWxvKkNtEtwaTm4lYDcIj4W9ChMwC30WvGZOEeiijUCJess=
X-Received: by 2002:aca:fd01:: with SMTP id b1-v6mr14166441oii.307.1534764410989;
 Mon, 20 Aug 2018 04:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180817102645.3839621-1-arnd@arndb.de> <20180817102645.3839621-9-arnd@arndb.de>
 <CAJZ5v0jjZx3xCbPK5vfx-OCRNtMt59WQOxCYkWNj33Js_2Xi=A@mail.gmail.com> <CAK8P3a1KWn0=xwrqZ+sF27O-WE6paDxQPg6PPZFcgCrgXGaX2A@mail.gmail.com>
In-Reply-To: <CAK8P3a1KWn0=xwrqZ+sF27O-WE6paDxQPg6PPZFcgCrgXGaX2A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Aug 2018 13:26:39 +0200
Message-ID: <CAJZ5v0htQ0KZ8M1BpE7H7weRS89jJWPtA0xvgAUmN53jx5DSYg@mail.gmail.com>
Subject: Re: [RFC 08/15] x86: PCI: clean up pcibios_scan_root()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
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

On Mon, Aug 20, 2018 at 1:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Aug 20, 2018 at 10:31 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Fri, Aug 17, 2018 at 12:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > > -static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
> > > -               struct pci_ops *ops, void *sysdata, struct list_head *resources)
> > > +void pcibios_scan_root(int busnum)
> > >  {
> > > +       struct pci_sysdata *sd;
> > >         struct pci_host_bridge *bridge;
> > >         int error;
> > >
> > > -       bridge = pci_alloc_host_bridge(0);
> > > -       if (!bridge)
> > > -               return NULL;
> > > +       bridge = pci_alloc_host_bridge(sizeof(sd));
> > > +       if (!bridge) {
> > > +               printk(KERN_ERR "PCI: OOM, skipping PCI bus %02x\n", busnum);
> > > +               return;
> > > +       }
> > > +       sd = pci_host_bridge_priv(bridge);
> >
> > This looks fishy, as bridge->private is not set at this point AFAICS,
> > unless one of the previous patches changes that.
>
> bridge->private what comes after the bridge structure, and it's allocated
> by pci_alloc_host_bridge() passing the size of the structure we want
> for this private area.

I see, sorry for the noise.
