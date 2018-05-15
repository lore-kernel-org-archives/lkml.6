Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932106AbeEOQsI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:48:08 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39577 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754149AbeEOQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:48:06 -0400
X-Google-Smtp-Source: AB8JxZoWhq90969Pl+0rO+vAJCnLBCQMe5effaKmvkaRo4K0+R+ltVce79rJsGI0H+Ae4DvUCAA3eORR3Ee5KcN+LMU=
MIME-Version: 1.0
In-Reply-To: <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com> <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 May 2018 19:48:05 +0300
Message-ID: <CAHp75VeUbjobse6uLeM4h_xXRUw+YUQUN+EOye67AJy77a5euQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] PCI: Rework of_pci_get_host_bridge_resources() to devm_of_pci_get_host_bridge_resources()
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 12:07 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> of_pci_get_host_bridge_resources() allocates the resource structures it
> fills dynamically, but none of its callers care to release them so far.
> Rather than requiring everyone to do this explicitly, convert the
> existing function to a managed version.

> -               res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> +               res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
>                 if (!res) {
>                         err = -ENOMEM;
> -                       goto parse_failed;
> +                       goto failed;
>                 }
>
>                 err = of_pci_range_to_resource(&range, dev_node, res);
>                 if (err) {
> -                       kfree(res);
> +                       devm_kfree(dev, res);
>                         continue;
>                 }

Can't you rather make it better, i.e.

struct resource tmp;
...

err = of_pci_range_to_resource(&range, dev_node, &tmp);
if (err)
   continue;

res = devm_kmemdump();
if (!res) {
 ret = -ENOMEM;
 goto failed;
}

?

-- 
With Best Regards,
Andy Shevchenko
