Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B71C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8340620693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8340620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeGSKWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:22:22 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46938 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeGSKWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:22:22 -0400
Received: by mail-qt0-f195.google.com with SMTP id d4-v6so6583744qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 02:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhIsIdKkP1k30p/ir9RcxBY1puJ714y6M0HqZoDwsoc=;
        b=ae1MtNcYfCXApZfa4SDdpEA6tvoG2uk29/RUZxFGrV/twkxMOmy34u+L8vbPUzfUS0
         TJDh/It5dkNrINBBVPqBfUCWSSKb1Kp7N5ARt+/mcKnP4zcx477aptLVBPFgDgzw+z0q
         SHe/t0FowpXlccSXKKMfM0J4LlWw1qqJkxpzSeKEUooF9tyVM0TG8FLa7tA9nalGeI7u
         HtKXcanDMCUH1huEN2XvsNLwXAM9KaX9U9inRuVjlAUxm+OD2PS3h0pir2MnlZhA1CEd
         GII9USXsjzzotk+VxLioVU4Q9bUDOlej3C/97+e7Q6XWEGfYc5s75MsjyCwMnjM0p06I
         h3bQ==
X-Gm-Message-State: AOUpUlH6/j7e+wZYHCirZ4qgmGwbjJxnFl11srv1L/lhCILl7okZXFtX
        wJei7teRg/WszU0Zl6lmBy08GyF5et392b3TDdF0dw==
X-Google-Smtp-Source: AAOMgpeqbmQU5hecpYcGAZHJM22aZzAZXdZ7hL5t1dgMGHbucXapdFaM7gYyV+ocQbx9+qhbDWWQ/oM3HOtLdugkEF8=
X-Received: by 2002:ac8:34d3:: with SMTP id x19-v6mr8460592qtb.81.1531993203187;
 Thu, 19 Jul 2018 02:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180718193200.17944-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20180718193200.17944-1-srinivas.pandruvada@linux.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 19 Jul 2018 11:39:51 +0200
Message-ID: <CAO-hwJJ=hsdu7AapAaWbB-JQUk9+24Lcx6i31bF5xaVwXdNQpQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: intel-ish-hid: Prevent loading of driver on Mehlow
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 9:32 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mehlow Xeon-E workstation, ISH PCI device is enabled but without ISH
> firmware. Here the ISH device PCI device id was reused for some non Linux
> storage drivers. So this was not done for enabling ISH. But this has a
> undesirable side effect for Linux.
>
> Here the ISH driver will be loaded via PCI enumeration and will try to do
> reset sequence. But reset sequence will wait till timeout as there is no
> real ISH firmware is present to take action. This delay will add to boot
> time of Linux (This platform will still continue to boot after this
> timeout).
>
> To avoid this boot delay we need to prevent loading of ISH drivers on
> this platform. So we need to have hack to avoid treating this device as
> ISH on this platform. To identify this workstation, we need some runtime
> method. Luckily there are special PCI id on this workstation to
> distinguish from the client version of this platform. On client version,
> the ISH is supported using same PCI device id. So this change look for
> the presence of PCI device IDs A309 and A30A and exit.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2
>  Replaced pci_get_device with pci_dev_present to check in a loop as
> suggested by Benjamin.

That's even better than what I suggested :)

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index a2c53ea3b5ed..4a55eab39b88 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -95,6 +95,13 @@ static int ish_init(struct ishtp_device *dev)
>         return 0;
>  }
>
> +static const struct pci_device_id ish_invalid_pci_ids[] = {
> +       /* Mehlow platform special pci ids */
> +       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xA309)},
> +       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xA30A)},
> +       {}
> +};
> +
>  /**
>   * ish_probe() - PCI driver probe callback
>   * @pdev:      pci device
> @@ -110,6 +117,10 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>         struct ish_hw *hw;
>         int     ret;
>
> +       /* Check for invalid platforms for ISH support */
> +       if (pci_dev_present(ish_invalid_pci_ids))
> +               return -ENODEV;
> +
>         /* enable pci dev */
>         ret = pci_enable_device(pdev);
>         if (ret) {
> --
> 2.17.1
>
