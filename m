Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56C7C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A1E208D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A1E208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeHTOcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:32:25 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37909 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeHTOcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:32:25 -0400
Received: by mail-qt0-f196.google.com with SMTP id x7-v6so6409553qtk.5;
        Mon, 20 Aug 2018 04:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzVej6cnEk1Sa+NMsNP+/h0Uh5fJedSa1vlz3oD17eo=;
        b=BNlGIC8XZZxpD0uQgJwgvPqqjxZhU3w44IwmdcFwMTLYZtszjgJ1DpJ9p+Wc4lurhB
         8vt/N+0li3CSVeEVRhbo8qjQTOICPDusuUsYfGOza4keHl5bCxhnIi4bofNvIBaeTgHg
         tf6vlvsx+lYX+oOcWoALRy6m7/EBXsg59SZuSgYluwzL7fWvbV1syTF6DHs6ZK9NBdmT
         Vcs0oVPOiqD3wdjOQoTrqG7zKMbUUZas7HOA4GWiFjmD+RIEjKbJeCC6SqGzIf83V39R
         uWQux6hQdq63PdevWtucYYljIy7q3hasoMoHw2c/0P7u/DVh4Pj8tMX64GUV8TcFwMX4
         3DtQ==
X-Gm-Message-State: AOUpUlGeqcA5giTIP3LouYOw/GRyyWZWVf6buMr6Y1DG80cEgfwIFv+5
        p+cceA8WAeLrIgJa92szE4ishynfxZwHVS8MeOY=
X-Google-Smtp-Source: AA+uWPygvHGExUSA2oHzA5WP3OYO0XK4BvsgQCT4CqGuVcQ2LPOuQzeztm4Ew7nbMqDHq6ULT8ZIWYvgTMmq6kj0l6c=
X-Received: by 2002:ac8:1645:: with SMTP id x5-v6mr11215509qtk.389.1534763832046;
 Mon, 20 Aug 2018 04:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180817102645.3839621-1-arnd@arndb.de> <20180817102645.3839621-9-arnd@arndb.de>
 <CAJZ5v0jjZx3xCbPK5vfx-OCRNtMt59WQOxCYkWNj33Js_2Xi=A@mail.gmail.com>
In-Reply-To: <CAJZ5v0jjZx3xCbPK5vfx-OCRNtMt59WQOxCYkWNj33Js_2Xi=A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Aug 2018 13:16:55 +0200
Message-ID: <CAK8P3a1KWn0=xwrqZ+sF27O-WE6paDxQPg6PPZFcgCrgXGaX2A@mail.gmail.com>
Subject: Re: [RFC 08/15] x86: PCI: clean up pcibios_scan_root()
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

On Mon, Aug 20, 2018 at 10:31 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Aug 17, 2018 at 12:32 PM Arnd Bergmann <arnd@arndb.de> wrote:

> > -static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
> > -               struct pci_ops *ops, void *sysdata, struct list_head *resources)
> > +void pcibios_scan_root(int busnum)
> >  {
> > +       struct pci_sysdata *sd;
> >         struct pci_host_bridge *bridge;
> >         int error;
> >
> > -       bridge = pci_alloc_host_bridge(0);
> > -       if (!bridge)
> > -               return NULL;
> > +       bridge = pci_alloc_host_bridge(sizeof(sd));
> > +       if (!bridge) {
> > +               printk(KERN_ERR "PCI: OOM, skipping PCI bus %02x\n", busnum);
> > +               return;
> > +       }
> > +       sd = pci_host_bridge_priv(bridge);
>
> This looks fishy, as bridge->private is not set at this point AFAICS,
> unless one of the previous patches changes that.

bridge->private what comes after the bridge structure, and it's allocated
by pci_alloc_host_bridge() passing the size of the structure we want
for this private area.

         Arnd
