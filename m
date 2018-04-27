Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524828749; cv=none;
        d=google.com; s=arc-20160816;
        b=nUknibAu+69ar6ZUdjiI1O2GmUuWWOPMidhiUQc+0A5pKuYsg2kRXN9rWYevcgeZit
         yifYyPeE2Ys5FfirMnoHNAsAYF9GEtVl0Xfn0eEc44t6Mtn6MJYQDStIM/kDxx1umX5G
         rPZ5cNImKFSZbO48TStqFR1STGCD/ue/KzkIof2IR+VqI/aqDfjsn10E20+hb4c4a/1Y
         /uYYKj5KuZQhqPsrje0fiT1ZrLsOMZNYsN23KCbYAuRva7VsslS2fKI33H9DqfYrGMLl
         usHdkS1D5IZBFs2qlifakcjVbh2rGOANAGDk82MRXp5vdDdCviK9XTJKrvjTDkJ/hDfx
         nyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=E7gbuwZB1cGIkXYtt3ndUqInFyC3cFukHrOs1ZXoPV0=;
        b=ezm6d+a/i15lmHDSdSRQwQnXFLHhepDeA3QxzWzfqv4ZzpZuMsBBQ8UEQ5P8XNWDIO
         juVC66zrBSkfGqc7O+VW7iL7tWJBAdNeuxx7zC6iNg3MQCsoa4fGCrso9VShflpbR7W8
         /iXtkCXMLvxU6ZcgOTiKBRzV5TDgZZBB/IaJxrCSU0HnMAeaXb8SwEMCJnJDIsV54yiP
         5FgFCeLuhCTAwkxCJeySQApIloUjGE6P++NBWxIs4A8eIuquN/vM0/MWCkVd0p2+w05O
         eErqqhx50CsDq+OR++cD/oStCKnsTJQNmtL4EhNGEOS/RfH98BZMR5IzYDROurdYunG2
         M4Xw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TGKnl2fN;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TGKnl2fN;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZqGXq6vqYoHOEWetWrj3FAqjh8lilV2/WsIBANLvqgaDuYoXjzmruTt2xhXjBERlHPVkXGNbTqISRcIk/P3nx4=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1524795811-21399-3-git-send-email-sdias@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org> <1524795811-21399-3-git-send-email-sdias@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Apr 2018 13:32:28 +0200
X-Google-Sender-Auth: 64MaS-NsGvXj4Vn5zz7BxmAU5fY
Message-ID: <CAK8P3a3UhuFYDfNeQTba-E50yNyyjj9-1c03YhDVnYQ1DvNd1g@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] mhi_bus: controller: MHI support for QCOM modems
To: Sujeev Dias <sdias@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	Tony Truong <truong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598864307361957466?=
X-GMAIL-MSGID: =?utf-8?q?1598898830705086533?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 4:23 AM, Sujeev Dias <sdias@codeaurora.org> wrote:
> QCOM PCIe based modems uses MHI as the communication protocol.
> MHI control driver is the bus master for such modems. As the bus
> master driver, it oversees power management operations
> such as suspend, resume, powering on and off the device.
>

> +- compatible
> +  Usage: required
> +  Value type: <string>
> +  Definition: "qcom,mhi"
> +
> +- qcom,pci-dev-id
> +  Usage: optional
> +  Value type: <u32>
> +  Definition: PCIe device id of external modem to bind. If not set, any
> +       device is compatible with this node.
> +
> +- qcom,pci-domain
> +  Usage: required
> +  Value type: <u32>
> +  Definition: PCIe root complex external modem connected to
> +
> +- qcom,pci-bus
> +  Usage: required
> +  Value type: <u32>
> +  Definition: PCIe bus external modem connected to
> +
> +- qcom,pci-slot
> +  Usage: required
> +  Value type: <u32>
> +  Definition: PCIe slot as assigned by pci framework to external modem

These don't seem to make any sense: You seem to have access to
a regular pci_device already, so why do you need to duplicate the
information about it in DT?

> +- qcom,smmu-cfg
> +  Usage: required
> +  Value type: <u32>
> +  Definition: Required SMMU configuration bitmask for PCIe bus.
> +       BIT mask:
> +       BIT(0) : Attach address mapping to endpoint device
> +       BIT(1) : Set attribute S1_BYPASS
> +       BIT(2) : Set attribute FAST
> +       BIT(3) : Set attribute ATOMIC
> +       BIT(4) : Set attribute FORCE_COHERENT
> +
> +- qcom,addr-win
> +  Usage: required if SMMU S1 translation is enabled
> +  Value type: Array of <u64>
> +  Definition: Pair of values describing iova start and stop address

Why do you need these? Can't that be handled by the PCI
layer?

> +- qcom,msm-bus,name
> +  Usage: required
> +  Value type: <string>
> +  Definition: string representing the bus scale client name to register

This probably belongs into a separate binding for the bus
scale driver, right?

> +static struct pci_driver mhi_pcie_driver;

Please try to reorder the symbols to avoid forward declarations.

> +static int mhi_platform_probe(struct platform_device *pdev)
> +{
> +       struct mhi_controller *mhi_cntrl;
> +       struct mhi_dev *mhi_dev;
> +       struct device_node *of_node = pdev->dev.of_node;
> +       u64 addr_win[2];
> +       int ret;
> +
> +       if (!of_node)
> +               return -ENODEV;
> +
> +       mhi_cntrl = mhi_alloc_controller(sizeof(*mhi_dev));
> +       if (!mhi_cntrl)
> +               return -ENOMEM;
> +
> +       mhi_dev = mhi_controller_get_devdata(mhi_cntrl);
> +
> +       /* get pci bus topology for this node */
> +       ret = of_property_read_u32(of_node, "qcom,pci-dev-id",
> +                                  &mhi_cntrl->dev_id);
> +       if (ret)
> +               mhi_cntrl->dev_id = PCI_ANY_ID;
> +
> +       ret = of_property_read_u32(of_node, "qcom,pci-domain",
> +                                  &mhi_cntrl->domain);
> +       if (ret)
> +               goto error_probe;
> +
> +       ret = of_property_read_u32(of_node, "qcom,pci-bus", &mhi_cntrl->bus);
> +       if (ret)
> +               goto error_probe;
> +
> +       ret = of_property_read_u32(of_node, "qcom,pci-slot", &mhi_cntrl->slot);
> +       if (ret)
> +               goto error_probe;

Please explain what you are trying to do here, why do you register
two device drivers? It looks like they both refer to the same
hardware, so why isn't it sufficient to have the pci_driver?

       Arnd
