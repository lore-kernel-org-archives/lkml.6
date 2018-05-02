Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525249326; cv=none;
        d=google.com; s=arc-20160816;
        b=pC5QJFgIj5OCVLZ+A5FaagzFsdME9dvqMyTEERRrk6ZqaipHeFw+K1yIzsiZIoVL7k
         OHjSXlo95ddgziYawgjk2wKXZePmhBU6O40Nter0AzI3d/673KlllfQ5zUVX0hRPA0pc
         r7Jo8j3pUXmE0n7L6AhW6LTjiFfF9B+S5vpKbB5XZnirpxNZowKLLKJHjYs6ahFBmRJ4
         H4rPRIGDY1pSJ7GcJgZLaofuXHXJKOLaXXLmU0T61ZEGdU50iMy0Nut8Kjp06s3RNBBy
         s3da/xpPHUSivSQgVhgxupME7meeSQGuetxOaAMzLOF72s+bVlKcXBH7lZJMzaWMRMgE
         /06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=alZX/Mw58eCK+oWpp4hBhvv9Pzzkjb8qNPf/HeAj2Qw=;
        b=VWmbto2mdcOcZa7GIMNlSvwM23hcy9wvvPO2X3ieUyE+4wnSY3GBbPnaCnfdvkNj4S
         LgCalmwuQdLzviYBIk7D0QWtSLb5BhtFCh57cyDHtXno6p8qDtr3jmR4JByFtYW3ny3W
         71uLwOC+cgFOmq5cWYY4rNixri/R41+SpS3L1aLpVO2EvMHpzZGEaXhrURwS3fn7G/XE
         WZKMiP+ejhNNGbTKGBfIB2RhaOhVwwW9oKyQYgKqToO7VGSENQcj1UtRJMdneG9DF854
         FgBe4Drt+uXqOjhpv4QgRQv9V3ZunxRVm4FG2WM2FgXVzTlJjUDVOpr8a/cVMaFa9NnS
         3Sfg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=E1x8ZC3M;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=E1x8ZC3M;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZr06IqyUya8rqZQWAcKkfWnB5JHlaWGbzPfqLXOASEfAGBG9/TlUimnPHbY/7ZwwHnW2XQXkarE5mjVdUxEhyI=
MIME-Version: 1.0
In-Reply-To: <20180502080631.sriwquzcky6t24c2@localhost>
References: <20180502080631.sriwquzcky6t24c2@localhost>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 2 May 2018 10:22:05 +0200
Message-ID: <CAKv+Gu_rgLs2CP4Lpx=CwgmCsEm01sbn9vPzZ4z4JqVaFBtC+g@mail.gmail.com>
Subject: Re: Regression due to "Workaround for uPD72020x USB3 chips"
To: Domenico Andreoli <domenico.andreoli@linux.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599339249338945359?=
X-GMAIL-MSGID: =?utf-8?q?1599339837828010009?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2 May 2018 at 10:06, Domenico Andreoli <domenico.andreoli@linux.com> wrote:
> Dear all,
>
>   my home machine stopped to boot starting from kernel version 4.12.7.
>
> The last message I read is about resetting some USB3 bus. It's 100%
> reproducible also with any recent kernel up to 4.17.0-rc3.
>
> I bisected down to the following commit:
>
> commit 0e1f0eaed6c20db41ff61e024b361ee3ec9d686c (tag: my_broken_xhci)
> Author: Marc Zyngier <marc.zyngier@arm.com>
> Date:   Tue Aug 1 20:11:08 2017 -0500
>
>     xhci: Reset Renesas uPD72020x USB controller for 32-bit DMA issue
>

Hello Domenico,

Long time no see :-)

Please refer to the following thread

https://marc.info/?l=linux-usb&m=151872295419486

for some discussion on this topic, and a possible workaround.

Regards,
Ard.



>     commit 8466489ef5ba48272ba4fa4ea9f8f403306de4c7 upstream.
>
>     The Renesas uPD72020x XHCI controller seems to suffer from a really
>     annoying bug, where it may retain some of its DMA programming across a XHCI
>     reset, and despite the driver correctly programming new DMA addresses.
>     This is visible if the device has been using 64-bit DMA addresses, and is
>     then switched to using 32-bit DMA addresses.  The top 32 bits of the
>     address (now zero) are ignored are replaced by the 32 bits from the
>     *previous* programming.  Sticking with 64-bit DMA always works, but doesn't
>     seem very appropriate.
>
>     A PCI reset of the device restores the normal functionality, which is done
>     at probe time.  Unfortunately, this has to be done before any quirk has
>     been discovered, hence the intrusive nature of the fix.
>
>     Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>     Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> diff --git drivers/usb/host/pci-quirks.c drivers/usb/host/pci-quirks.c
> index 5f4ca7890435..c8f38649f749 100644
> --- drivers/usb/host/pci-quirks.c
> +++ drivers/usb/host/pci-quirks.c
> @@ -1157,3 +1157,23 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
>                         PCI_CLASS_SERIAL_USB, 8, quirk_usb_early_handoff);
> +
> +bool usb_xhci_needs_pci_reset(struct pci_dev *pdev)
> +{
> +       /*
> +        * Our dear uPD72020{1,2} friend only partially resets when
> +        * asked to via the XHCI interface, and may end up doing DMA
> +        * at the wrong addresses, as it keeps the top 32bit of some
> +        * addresses from its previous programming under obscure
> +        * circumstances.
> +        * Give it a good wack at probe time. Unfortunately, this
> +        * needs to happen before we've had a chance to discover any
> +        * quirk, or the system will be in a rather bad state.
> +        */
> +       if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
> +           (pdev->device == 0x0014 || pdev->device == 0x0015))
> +               return true;
> +
> +       return false;
> +}
> +EXPORT_SYMBOL_GPL(usb_xhci_needs_pci_reset);
> diff --git drivers/usb/host/pci-quirks.h drivers/usb/host/pci-quirks.h
> index 655994480198..5582cbafecd4 100644
> --- drivers/usb/host/pci-quirks.h
> +++ drivers/usb/host/pci-quirks.h
> @@ -15,6 +15,7 @@ void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev);
>  void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev);
>  void usb_disable_xhci_ports(struct pci_dev *xhci_pdev);
>  void sb800_prefetch(struct device *dev, int on);
> +bool usb_xhci_needs_pci_reset(struct pci_dev *pdev);
>  #else
>  struct pci_dev;
>  static inline void usb_amd_quirk_pll_disable(void) {}
> diff --git drivers/usb/host/xhci-pci.c drivers/usb/host/xhci-pci.c
> index 1ef622ededfd..cefa223f9f08 100644
> --- drivers/usb/host/xhci-pci.c
> +++ drivers/usb/host/xhci-pci.c
> @@ -285,6 +285,13 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>
>         driver = (struct hc_driver *)id->driver_data;
>
> +       /* For some HW implementation, a XHCI reset is just not enough... */
> +       if (usb_xhci_needs_pci_reset(dev)) {
> +               dev_info(&dev->dev, "Resetting\n");
> +               if (pci_reset_function_locked(dev))
> +                       dev_warn(&dev->dev, "Reset failed");
> +       }
> +
>         /* Prevent runtime suspending between USB-2 and USB-3 initialization */
>         pm_runtime_get_noresume(&dev->dev);
>
> ---
>
> Commenting out the call to pci_reset_function_locked() makes 4.17.0-rc3
> boot again so I think this bug qualifies as regression.
>
> I investigated a bit, the culprit is pci_reset_secondary_bus().
>
> pci_reset_function_locked ->
>   __pci_reset_function_locked ->
>     pci_reset_bridge_secondary_bus ->
>       pcibios_reset_secondary_bus ->
>         pci_reset_secondary_bus ->>>>>> here the system dies/hangs/stops
>
> I can read the printk I put right before PCI_BRIDGE_CTL_BUS_RESET is
> written in PCI_BRIDGE_CONTROL. I cannot read the printk I put right
> after.
>
> It seems my system doesn't like that PCI reset at all. I cannot swear
> that it is completely frozen, some disk activity might be happening
> shortly after, but my only option is to power cycle.
>
> I cannot debug easily. I tried to boot with a patched module and just
> attempted to work at it on a live machine but as soon I unload the
> module I'm left without keyboard/mouse (apparently all the accessible
> USB ports are going through the xhci-pci module) and at the moment I
> cannot go via network.
>
> This is the output of lspci -vt:
>
> -[0000:00]-+-00.0  Intel Corporation 4th Gen Core Processor DRAM Controller
>            +-01.0-[01]----00.0  NVIDIA Corporation GM108M [GeForce 840M]
>            +-02.0  Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor Integrated Graphics Controller
>            +-03.0  Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor HD Audio Controller
>            +-14.0  Intel Corporation 8 Series/C220 Series Chipset Family USB xHCI
>            +-16.0  Intel Corporation 8 Series/C220 Series Chipset Family MEI Controller #1
>            +-1a.0  Intel Corporation 8 Series/C220 Series Chipset Family USB EHCI #2
>            +-1b.0  Intel Corporation 8 Series/C220 Series Chipset High Definition Audio Controller
>            +-1c.0-[02]--
>            +-1c.2-[03]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
>            +-1c.3-[04]----00.0  Realtek Semiconductor Co., Ltd. RTS5229 PCI Express Card Reader
>            +-1c.4-[05]----00.0  Realtek Semiconductor Co., Ltd. RTL8821AE 802.11ac PCIe Wireless Network Adapter
>            +-1c.5-[06]----00.0  Renesas Technology Corp. uPD720202 USB 3.0 Host Controller
>            +-1d.0  Intel Corporation 8 Series/C220 Series Chipset Family USB EHCI #1
>            +-1f.0  Intel Corporation C220 Series Chipset Family H81 Express LPC Controller
>            +-1f.2  Intel Corporation 8 Series/C220 Series Chipset Family 6-port SATA Controller 1 [AHCI mode]
>            \-1f.3  Intel Corporation 8 Series/C220 Series Chipset Family SMBus Controller
>
> The call to pci_reset_secondary_bus() is correctly applied to -1c.5-.
>
> I suspect that -1c.5- might benefit from having PCI_DEV_FLAGS_NO_BUS_RESET
> in its dev->dev_flags but I'm not sure that it's the proper fix and how
> exactly it could end up there.
>
> Any suggestion on how to proceed further?
>
> Please ask more info if needed.
>
> Kind regards,
> Domenico
>
> --
> 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
