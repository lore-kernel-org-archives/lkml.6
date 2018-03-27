Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeC0QUC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbeC0QUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:20:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B562C21716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AIpwx4+cqFPKhD4mtYxtLHrPnVCOnaRjo42jIcmkTJO4N5KnJ8ZHNo3f65B7LQJ8jdvl/yDRbIUWBFNpJVoE2VqCP2Y=
MIME-Version: 1.0
In-Reply-To: <20180326122306.546ecb6d@canb.auug.org.au>
References: <20180326122306.546ecb6d@canb.auug.org.au>
From: Rob Herring <robh@kernel.org>
Date: Tue, 27 Mar 2018 11:19:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL5iRdk1tU78ZS9P+hw790XXUhwbSKiuz3N2Ag-DA0FAQ@mail.gmail.com>
Message-ID: <CAL_JsqL5iRdk1tU78ZS9P+hw790XXUhwbSKiuz3N2Ag-DA0FAQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pci tree with Linus' tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 8:23 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Bjorn,
>
> Today's linux-next merge of the pci tree got a conflict in:
>
>   include/linux/of_pci.h
>
> between commit:
>
>   a6f1086e29e9 ("PCI: Move of_irq_parse_and_map_pci() declaration under OF_IRQ")

My series was based on top of this commit because of this conflict.

> from Linus' tree and commit:
>
>   effab67ffe90 ("PCI: Move private DT related functions into private header")
>
> from the pci tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc include/linux/of_pci.h
> index 091033a6b836,41155181ecbd..000000000000
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@@ -13,9 -13,7 +13,6 @@@ struct device_node
>   struct device_node *of_pci_find_child_device(struct device_node *parent,
>                                              unsigned int devfn);
>   int of_pci_get_devfn(struct device_node *np);
> - int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
> - int of_get_pci_domain_nr(struct device_node *node);
> - int of_pci_get_max_link_speed(struct device_node *node);
>  -int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
>   void of_pci_check_probe_only(void);
>   int of_pci_map_rid(struct device_node *np, u32 rid,
>                    const char *map_name, const char *map_mask_name,
> @@@ -32,18 -30,12 +29,6 @@@ static inline int of_pci_get_devfn(stru
>         return -EINVAL;
>   }
>
> - static inline int
> - of_pci_parse_bus_range(struct device_node *node, struct resource *res)
> - {
> -       return -EINVAL;
> - }
> -
> --static inline int
> - of_get_pci_domain_nr(struct device_node *node)
>  -of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
> --{
> -       return -1;
>  -      return 0;
> --}
> --
>   static inline int of_pci_map_rid(struct device_node *np, u32 rid,
>                         const char *map_name, const char *map_mask_name,
>                         struct device_node **target, u32 *id_out)
> @@@ -54,33 -46,4 +39,13 @@@
>   static inline void of_pci_check_probe_only(void) { }
>   #endif
>
>  +#if IS_ENABLED(CONFIG_OF_IRQ)
>  +int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
>  +#else
>  +static inline int
>  +of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
>  +{
>  +      return 0;
>  +}
>  +#endif
> -
> - #if defined(CONFIG_OF_ADDRESS)
> - int of_pci_get_host_bridge_resources(struct device_node *dev,
> -                       unsigned char busno, unsigned char bus_max,
> -                       struct list_head *resources, resource_size_t *io_base);
> - #else
> - static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
> -                       unsigned char busno, unsigned char bus_max,
> -                       struct list_head *resources, resource_size_t *io_base)
> - {
> -       return -EINVAL;
> - }
> - #endif
> -
>   #endif
