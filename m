Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeFEUoL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751820AbeFEUoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:44:09 -0400
Date: Tue, 5 Jun 2018 15:44:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: Clean up resource allocation in
 devm_of_pci_get_host_bridge_resources()
Message-ID: <20180605204407.GA226399@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
 <CAHp75VeUbjobse6uLeM4h_xXRUw+YUQUN+EOye67AJy77a5euQ@mail.gmail.com>
 <CAHp75VeM7_8+9QJjOypXaiBhpWP4B5KACdUQ-p3frbS3jPh=OQ@mail.gmail.com>
 <f35b2972-aa40-5397-facb-765cafe7c315@siemens.com>
 <CAHp75VdWhCDYt3jvii92g222WeHTvwX5e8Sthr0pknXvCgwHDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdWhCDYt3jvii92g222WeHTvwX5e8Sthr0pknXvCgwHDA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 07:26:57PM +0300, Andy Shevchenko wrote:
> On Wed, May 16, 2018 at 3:31 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > Instead of first allocating and then freeing memory for struct resource
> > in case we cannot parse a PCI resource from the device tree, work
> > against a local struct and kmemdup it when we decide to go with it.
> >
> 
> Bjorn, any comments on this?

I'm trying to finish up the v4.18 changes now, but I'll look at this later.
If it's urgent, let me know and I can look sooner.

> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  drivers/pci/of.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index b06585a1da75..fc0f906c5c25 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -266,7 +266,7 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
> >                         struct list_head *resources, resource_size_t *io_base)
> >  {
> >         struct device_node *dev_node = dev->of_node;
> > -       struct resource *res;
> > +       struct resource *res, tmp_res;
> >         struct resource *bus_range;
> >         struct of_pci_range range;
> >         struct of_pci_range_parser parser;
> > @@ -320,18 +320,16 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
> >                 if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
> >                         continue;
> >
> > -               res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
> > +               err = of_pci_range_to_resource(&range, dev_node, &tmp_res);
> > +               if (err)
> > +                       continue;
> > +
> > +               res = devm_kmemdup(dev, &tmp_res, sizeof(tmp_res), GFP_KERNEL);
> >                 if (!res) {
> >                         err = -ENOMEM;
> >                         goto failed;
> >                 }
> >
> > -               err = of_pci_range_to_resource(&range, dev_node, res);
> > -               if (err) {
> > -                       devm_kfree(dev, res);
> > -                       continue;
> > -               }
> > -
> >                 if (resource_type(res) == IORESOURCE_IO) {
> >                         if (!io_base) {
> >                                 dev_err(dev,
> > --
> > 2.13.6
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
