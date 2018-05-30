Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968554AbeE3A7h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 20:59:37 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:42083 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968409AbeE3A7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 20:59:35 -0400
X-Google-Smtp-Source: ADUXVKIp8fM5TOVW4iRMuchTfvkqmqc/+vLx7RQ9r4/u1S9C9J7faLo29+zShREa/CHjH6ayJRYprxMPfNpuwz6gGcM=
MIME-Version: 1.0
In-Reply-To: <1527631130-20045-3-git-send-email-ray.jui@broadcom.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com> <1527631130-20045-3-git-send-email-ray.jui@broadcom.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 May 2018 03:59:33 +0300
Message-ID: <CAHp75VfwfKbikfat3tTbMzSfNgt4v9nFpExyDvhOdX9ko1Z4Fw@mail.gmail.com>
Subject: Re: [PATCH 2/6] PCI: iproc: Add INTx support with better modeling
To: Ray Jui <ray.jui@broadcom.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 12:58 AM, Ray Jui <ray.jui@broadcom.com> wrote:
> Add PCIe legacy interrupt INTx support to the iProc PCIe driver by
> modeling it with its own IRQ domain. All 4 interrupts INTA, INTB, INTC,
> INTD share the same interrupt line connected to the GIC in the system,
> while the status of each INTx can be obtained through the INTX CSR
> register

> +       while ((status = iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_CSR) &
> +               SYS_RC_INTX_MASK) != 0) {
> +               for_each_set_bit(bit, &status, PCI_NUM_INTX) {
> +                       virq = irq_find_mapping(pcie->irq_domain, bit + 1);
> +                       if (virq)
> +                               generic_handle_irq(virq);
> +                       else
> +                               dev_err(dev, "unexpected INTx%u\n", bit);
> +               }
> +       }

do {
  status = ...;
  for_each_set_bit() {
    ...
  }
} while (status);

would look slightly better for my opinion.

-- 
With Best Regards,
Andy Shevchenko
