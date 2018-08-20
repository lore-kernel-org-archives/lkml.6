Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41706C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BF92154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BF92154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeHTLqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 07:46:31 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39506 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeHTLqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 07:46:31 -0400
Received: by mail-oi0-f67.google.com with SMTP id d189-v6so24419308oib.6;
        Mon, 20 Aug 2018 01:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4ivYotING2LikRK6tbQmckQ9q/F60C2I0AptK8CuYE=;
        b=JdI+/EtdoebJm2/UTQxVKAp/0oE+8MQ9i8iuFur5CuyTlAZY91+Vy88mEmrJaA/+Gx
         g8DWv+FjW51ZiyKRdPonOgphtHuwgXFt3Q8cn/Z3mv6gqCa3wFO7DNwVS1oieRy1NBnj
         B9vUOTkCh4lrxTfsLsX7wzfZqbIsCwDo/lIYFpn4npsrA/k+6KXbH1RT/Z9rbXHd41tK
         ToHHvcojENOCvIHU+vdFHaNnwiBmyqvjhzEp14CbUTH+9ThLIaNkEGoUZAaBADmlRCTI
         gsCXczzlLRRsSmD6ojA6fXch+IWC4VbYPBV9dbp8W9Z84Ksu5/ZnbEqm9utImhcmd2nN
         JoIg==
X-Gm-Message-State: AOUpUlEQw504LKkaSgTpSZWxDpgYWPpNzg79E5ennqRkjFLhAX3FODr1
        baUbkBO3xNIvrHfrnEbN0Y4Y0c+cildz9wAwPy0=
X-Google-Smtp-Source: AA+uWPyIv9H8FCTp/j0oB9wMcLf/SIuu/FbS8KDeL66XNmmMtGM9UQHVhTQ4PoKK6oPs5D2xFNDxCCxGTosxdVgX2PE=
X-Received: by 2002:aca:2dd1:: with SMTP id t200-v6mr13632011oit.152.1534753909365;
 Mon, 20 Aug 2018 01:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180817102645.3839621-1-arnd@arndb.de> <20180817102645.3839621-9-arnd@arndb.de>
In-Reply-To: <20180817102645.3839621-9-arnd@arndb.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Aug 2018 10:31:38 +0200
Message-ID: <CAJZ5v0jjZx3xCbPK5vfx-OCRNtMt59WQOxCYkWNj33Js_2Xi=A@mail.gmail.com>
Subject: Re: [RFC 08/15] x86: PCI: clean up pcibios_scan_root()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
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

On Fri, Aug 17, 2018 at 12:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> pcibios_scan_root() is now just a wrapper around pci_scan_root_bus(),
> and merging the two into one makes it shorter and more readable.
>
> We can also take advantage of pci_alloc_host_bridge() doing the
> allocation of the sysdata for us, which helps if we ever want to
> allow hot-unplugging the host bridge itself.
>
> We might be able to simplify it further using pci_host_probe(),
> but I wasn't sure about the resource registration there.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/pci/common.c | 53 ++++++++++++++-----------------------------
>  1 file changed, 17 insertions(+), 36 deletions(-)
>
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index e740d9aa4024..920d0885434c 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -453,54 +453,35 @@ void __init dmi_check_pciprobe(void)
>         dmi_check_system(pciprobe_dmi_table);
>  }
>
> -static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
> -               struct pci_ops *ops, void *sysdata, struct list_head *resources)
> +void pcibios_scan_root(int busnum)
>  {
> +       struct pci_sysdata *sd;
>         struct pci_host_bridge *bridge;
>         int error;
>
> -       bridge = pci_alloc_host_bridge(0);
> -       if (!bridge)
> -               return NULL;
> +       bridge = pci_alloc_host_bridge(sizeof(sd));
> +       if (!bridge) {
> +               printk(KERN_ERR "PCI: OOM, skipping PCI bus %02x\n", busnum);
> +               return;
> +       }
> +       sd = pci_host_bridge_priv(bridge);

This looks fishy, as bridge->private is not set at this point AFAICS,
unless one of the previous patches changes that.

>
> -       list_splice_init(resources, &bridge->windows);
> -       bridge->dev.parent = parent;
> -       bridge->sysdata = sysdata;
> -       bridge->busnr = bus;
> -       bridge->ops = ops;
> +       sd->node = x86_pci_root_bus_node(busnum);
> +       x86_pci_root_bus_resources(busnum, &bridge->windows);
> +       bridge->sysdata = sd;
> +       bridge->busnr = busnum;
> +       bridge->ops = &pci_root_ops;
>
> +       printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busnum);
>         error = pci_scan_root_bus_bridge(bridge);
>         if (error < 0)
>                 goto err_out;
>
> -       return bridge->bus;
> +       pci_bus_add_devices(bridge->bus);
> +       return;
>
>  err_out:
> -       kfree(bridge);
> -       return NULL;
> -}
> -
> -void pcibios_scan_root(int busnum)
> -{
> -       struct pci_bus *bus;
> -       struct pci_sysdata *sd;
> -       LIST_HEAD(resources);
> -
> -       sd = kzalloc(sizeof(*sd), GFP_KERNEL);
> -       if (!sd) {
> -               printk(KERN_ERR "PCI: OOM, skipping PCI bus %02x\n", busnum);
> -               return;
> -       }
> -       sd->node = x86_pci_root_bus_node(busnum);
> -       x86_pci_root_bus_resources(busnum, &resources);
> -       printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busnum);
> -       bus = pci_scan_root_bus(NULL, busnum, &pci_root_ops, sd, &resources);
> -       if (!bus) {
> -               pci_free_resource_list(&resources);
> -               kfree(sd);
> -               return;
> -       }
> -       pci_bus_add_devices(bus);
> +       pci_free_host_bridge(bridge);
>  }
>
>  void __init pcibios_set_cache_line_size(void)
> --
> 2.18.0
>
