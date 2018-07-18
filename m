Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4305ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1502075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1502075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeGRIaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:30:06 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36612 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeGRIaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:30:05 -0400
Received: by mail-qt0-f196.google.com with SMTP id t5-v6so3243162qtn.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 00:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGNh6yhTB0/qe+WhI2U7k1ndlZdLYVHKuFLrOA9gnQU=;
        b=QFx7e+L71U+v2m9hEqLQTpNcTi7en7TR0o/2D0frtX3EcstC1C7+xApyMS1xKTfM0K
         K12AJwxCJ6dPwrSbUlQjUf7l5goIoYf7xXqNlKEVx6KDB+Zz+QXHMqqh63K3F9F0yyFs
         tFwKbVDK2Rotx7ZqNz1ZlYzGEUhHJXmUPqv4L50OrsA1TdQti/gMiy7i4DJpmRsywnQe
         Xy1220dmoRNiCWLvTD+0SptBweQtyqK5KUgLXc/oJ58KsvDwJQ7o8ZL1zUTZT1K/eeye
         bgMkkQep1tMASnsk4L57t4/Cr8o2X7P4it5JabEvGCoEjf3bkU6p3+0Pa5/U0J7LYz4/
         ZuDQ==
X-Gm-Message-State: AOUpUlFvP5aPaH86csNDS+xhGxFHkitXZ67DkIaWj7rdquaP/TVMWn7G
        7IHP4NOjCC5LQYsfwtyVmihLLWlNIVc8PPUeqPqzOQ==
X-Google-Smtp-Source: AAOMgpc9EAoqS/2aCPyLM5h3/xdsN8W9cld6k4Oevlv+mORn4rKZXzUi6rtzxnNO+ts1vQyn6y99AWzv4N3dxl7fzGM=
X-Received: by 2002:a0c:d0e3:: with SMTP id b32-v6mr5224095qvh.236.1531900407275;
 Wed, 18 Jul 2018 00:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180717200557.39925-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20180717200557.39925-1-srinivas.pandruvada@linux.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 18 Jul 2018 09:53:15 +0200
Message-ID: <CAO-hwJ+b6aSSC7UGDtdivfh69+ZZaV5uwJH_ramLM0FeAZwRDQ@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-ish-hid: Prevent loading of driver on Mehlow
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:06 PM Srinivas Pandruvada
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
> This is not a change for 4.18-rc.
>
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index a2c53ea3b5ed..d6e7156c36d9 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -95,6 +95,26 @@ static int ish_init(struct ishtp_device *dev)
>         return 0;
>  }
>
> +
> +static bool ish_invalid_firmware(void)
> +{
> +       struct pci_dev *pdev;
> +
> +       pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0xA309, NULL);
> +       if (pdev) {
> +               pci_dev_put(pdev);
> +               return true;
> +       }
> +
> +       pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0xA30A, NULL);
> +       if (pdev) {
> +               pci_dev_put(pdev);
> +               return true;
> +       }

I think this duplicated code should be merged in a for loop on an
array of blacklisted items :)

Cheers,
Benjamin

> +
> +       return false;
> +}
> +
>  /**
>   * ish_probe() - PCI driver probe callback
>   * @pdev:      pci device
> @@ -110,6 +130,9 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>         struct ish_hw *hw;
>         int     ret;
>
> +       if (ish_invalid_firmware())
> +               return -ENODEV;
> +
>         /* enable pci dev */
>         ret = pci_enable_device(pdev);
>         if (ret) {
> --
> 2.17.1
>
