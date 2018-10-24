Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B18C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149022081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149022081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeJXPlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:41:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36550 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeJXPlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:41:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34-v6so4602567qth.3;
        Wed, 24 Oct 2018 00:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/NrCSoxGwIU7Hzg0GO3vy9/48cI5vnzGL215UcKrLA=;
        b=o4IhhJ4NuX2lOZQeK8+yMrs6meOg2k0LTkp1C6Aolea2wd07Aduq8sxKk61dN2sHOt
         o/4MYPhV9dd0vQoy3aI8Nlipiz4Jg8RMzc/7prHkksvhH+5oKmfeB5XURxTqMgfPc263
         Yxfv+fOca1gndI8oZFVRpTA7MJCd/TuAFS0+b5gZbQTTbW1IpYYqnN0HcRaoRimaDtFq
         WmI6iuF78UgIcOQtS+SgVp3O1n2ylF+/Y6XHJr/Vo5sX/nFt8mdS07/+SmuDnxh6/6vN
         TehEtWLSZDJ+8wH/4vfmFGbltKKjJ02NLMqdaT56afxvacFHbGAS2ulVNQq8N92XI+yL
         D6dw==
X-Gm-Message-State: AGRZ1gJWWY6Z3eVVkevJX0P7QwZfS8kcj+Hgq8cYC/4ugNIusr7d54D/
        s57Oftcp33d7BOv19+2hwYEQ2qUaAUh0zSFD+3M=
X-Google-Smtp-Source: AJdET5c5zP3aHWcu4jPn3lHWXfsWhXadWUU9/iu5SiojTLQKz8SVmw98PKyMemmdSyQQ/o9TcYeXpxSNTHCMlm+DT18=
X-Received: by 2002:aed:2a83:: with SMTP id t3-v6mr1292090qtd.319.1540365297493;
 Wed, 24 Oct 2018 00:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <1539815349-24126-1-git-send-email-alcooperx@gmail.com> <1539815349-24126-6-git-send-email-alcooperx@gmail.com>
In-Reply-To: <1539815349-24126-6-git-send-email-alcooperx@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 24 Oct 2018 08:14:40 +0100
Message-ID: <CAK8P3a2v_6T5pkAUR0erFgCN6C4S2zUqq4EEa5nNo+gYdJ+0qw@mail.gmail.com>
Subject: Re: [PATCH V2 5/6] usb: ehci: Add new EHCI driver for Broadcom STB SoC's
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        David Miller <davem@davemloft.net>,
        DTML <devicetree@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>, sunjianguo1@huawei.com,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        USB list <linux-usb@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rishabhb@codeaurora.org, Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:30 PM Al Cooper <alcooperx@gmail.com> wrote:

> +
> +static int ehci_brcm_probe(struct platform_device *pdev)
> +{
> +       struct usb_hcd *hcd;
> +       struct resource *res_mem;
> +       struct brcm_priv *priv;
> +       int irq;
> +       int err;
> +
> +       if (usb_disabled())
> +               return -ENODEV;
> +
> +       err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +       if (err)
> +               return err;

You should never use "dma_coerce_mask_and_coherent" in new code. Make sure that
the DT is correct and call dma_set_mask_and_coherent() instead.

> +#ifdef CONFIG_OF
> +static const struct of_device_id brcm_ehci_of_match[] = {
> +       { .compatible = "brcm,bcm7445-ehci", },
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(of, brcm_ehci_of_match);
> +#endif /* CONFIG_OF */
> +
> +static struct platform_driver ehci_brcm_driver = {
> +       .probe          = ehci_brcm_probe,
> +       .remove         = ehci_brcm_remove,
> +       .shutdown       = usb_hcd_platform_shutdown,
> +       .driver         = {
> +               .owner  = THIS_MODULE,
> +               .name   = "ehci-brcm",
> +               .pm     = &ehci_brcm_pm_ops,
> +               .of_match_table = of_match_ptr(brcm_ehci_of_match),
> +       }
> +};

You won't ever use this driver without CONFIG_OF, so just remove the #ifdef and
of_match_ptr() wrapper here. It will still build fine without CONFIG_OF.

      Arnd
