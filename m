Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5526FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C04F20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mjx/EXsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C04F20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbeG3RyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:54:03 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:32844 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeG3RyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:54:02 -0400
Received: by mail-ua0-f196.google.com with SMTP id i4-v6so8221915uak.0;
        Mon, 30 Jul 2018 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XuR6BpGdsi095ZZBxLTUf2gLq1bAbazxjEGOQF+aMKY=;
        b=Mjx/EXsRMLNhisNcUBhXiowoTEwzqC2T8Rw/AAtWU7sugKHY/G2CTZiqzwR8RooF+t
         maVmoNDKdINOHoBpOp+xIkCBAvdbMbhRoXK2+7/03DHmP3PIEgKOkE/dOP4cXDCWJmmk
         SmQWX4QZwpeJrQuzmrQr2Z455RqztG+Vlz/Y+/wQAKh4tX+IIrd203Cr6uYZadAJX9lh
         zc1GW6lEq0qelzcFR3up8ms/CMqSY/lifweBrwa9LbvZulaWDpjV7T90uC2WU9mWico2
         2Gk85WhwO6ttjngnqV0osRbg0yTgI6SPd1hDMZoGZ7wJNoh78YC4MPU62IO9lIBtktrT
         DZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=XuR6BpGdsi095ZZBxLTUf2gLq1bAbazxjEGOQF+aMKY=;
        b=LFIWsBioqbzBCu5kr8QKNvHGRTU0TxgBx+WCzl4NQhToXhusEhzJHUfJbAJKv+8+Gt
         uJBdBaSOFrlNqBNzZ9rRiQ5zpQbQHFzYgC/qfY5s8vLQg762i08CYs7dgndnVGr1O4ry
         W3Jnve0IBDYC19r7pcL0mzS2VSvkO9akj7OG8oVVSSCA0FzhR+4HWEXWG12/CT5Atku7
         NYq4BsaSbYx0x6y4Hj9guwa2QU0BIJ14LEALYIUd45b1DNYxyMzpbymxemsNO+z9h656
         01JHs6bEg+W+pirMGHhe6EOR6bBy89emZYTsaqKi8BUvrGhARrN7yDgi9hpYQ53Stijc
         rq4Q==
X-Gm-Message-State: AOUpUlFQUdDkjnGKrKZE+REkPawz8d433NGDnvR4HilJdHl8LORR2QRS
        CgzOmWZZRgaDDnYcEmmJYeuU+la40p4gdrScPNs=
X-Google-Smtp-Source: AAOMgpeOuZQy9PmZ+I1iTPmw5Lo08C+Dwt3yO8t8p35MWIE/CBYuBptt6KWF+DkqwZR+Z+2jNSmZwLglZFmwSwdkn/Y=
X-Received: by 2002:ab0:1861:: with SMTP id j33-v6mr12555191uag.119.1532967499289;
 Mon, 30 Jul 2018 09:18:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:1e86:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 09:18:18
 -0700 (PDT)
Reply-To: rajatxjain@gmail.com
In-Reply-To: <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
References: <20180508230148.121852-1-rajatja@google.com> <20180510233912.96454-1-rajatja@google.com>
 <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Mon, 30 Jul 2018 09:18:18 -0700
Message-ID: <CAA93t1rqJM1S6M+Prjup_93Z-Y2dbuF3tpKCS5c_SCf9hU9Upg@mail.gmail.com>
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mayurkumar.patel@intel.com, Richard Hughes <rhughes@redhat.com>,
        Carlos Garnacho <cgarnach@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pali Rohar <pali.rohar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andy Whitcroft <apw@canonical.com>,
        Colin Ian King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 1:26 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Rafael, Richard, Carlos, Pali, Takashi, Andy, Colin for question
> about how to expose ASPM power management in sysfs]
>
> On Thu, May 10, 2018 at 04:39:12PM -0700, Rajat Jain wrote:
>> ...
>> And some suggestions from Bjorn here:
>> https://www.spinics.net/lists/linux-pci/msg60541.html
>>
>> This patch picks up one of the suggestion, to remove the
>> CONFIG_PCIEASPM_DEBUG and thus make the code always
>> avilable. This provides control to userspace to control
>> ASPM on a per slot / device basis using sysfs interface.
>
> TL;DR: When CONFIG_PCIEASPM_DEBUG=y, Linux makes ASPM control files
>        visible in sysfs, associated with the upstream end (e.g., Root
>        Port) of a link.  Should these files be associated with the
>        downstream end (e.g., NIC, GPU, etc) instead?
>
> I think we do need to make ASPM control files visible in sysfs, as
> this patch does.  But I have a question about exactly *how* we want to
> do this.  I had planned to merge this patch for v4.19, but I think
> I'll postpone it until we figure this out.


Hi Bjorn,

Just a side note FYI, it is OK if you want to drop this, because we
anyway have this today as a config option so anyone who wants to use
these files can enable that config anyway.

Thanks,

Rajat

>
> ASPM is a power management feature of a PCIe link, and it affects the
> devices on both ends of that link.  The upstream end (closest to the
> CPU) is typically a Root Port, and the downstream end is typically an
> Endpoint (e.g., a GPU, NIC, or NVMe device).  For example, my laptop
> has these devices:
>
>   00:1c.2 Intel Root Port to [bus 04]
>   04:00.0 Intel 8260 Wireless NIC
>
> There's a PCIe link between these two devices, and if both ends
> support it, ASPM reduces power usage when the NIC is idle.  The
> hardware reduces power usage automatically; the kernel only needs to
> configure ASPM.
>
> ASPM affects performance as well as power, so we have knobs to control
> the tradeoff.  Starting with the big hammers, we currently have:
>
>   - Kernel build-time setting (CONFIG_PCIEASPM_PERFORMANCE, etc).
>     Requires kernel rebuild and reboot.
>
>   - "pcie_aspm=X" kernel boot parameter.  Can only enable/disable and
>     requires a reboot.
>
>   - /sys/module/pcie_aspm/parameters/policy file.  At any time, root
>     can set the system-wide ASPM policy to one of these settings:
>
>       + highest performance, highest power consumption
>       + moderate power saving at cost of some performance
>       + aggressive power saving at cost of more performance
>       + use whatever setting BIOS configured
>
>   - Many /sys/devices/pci0000:00/0000:00:1c.2/power/link_state files.
>     At any time, root can set the ASPM policy to one of the above
>     settings, but for individual devices.  Currently these files are
>     only available when CONFIG_PCIEASPM_DEBUG=y (Red Hat does not
>     enable this, but Ubuntu does).
>
> The patch below changes it so these /sys/devices/.../link_state files
> *always* exist, regardless of CONFIG_PCIEASPM_DEBUG.
>
> The question is where those sysfs files should be.  Currently they are
> associated with the device at the *upstream* end of the link.  In the
> example above, they're associated with the Root Port:
>
>   /sys/devices/pci0000:00/0000:00:1c.2/power/link_state
>
> I don't know if that's the right place, or if they should be
> associated with the device at the *downstream* end of the link, i.e.,
> 04:00.0.  The downstream end might be better because:
>
>   - It's easier to associate the downstream end with a device the user
>     cares about, e.g., a NIC, GPU, etc.  This is mostly a user-
>     interface issue.
>
>   - A link can lead to a multi-function device, and the spec allows
>     those functions to have different ASPM settings (see PCIe r4.0,
>     sec 5.4.1).  With the sysfs files at the upstream end of the link,
>     we have no way to configure those functions individually.
>
> Any thoughts?
>
>> ...
>> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
>> index b12e28b3d8f9..089b9f559d88 100644
>> --- a/drivers/pci/pcie/Kconfig
>> +++ b/drivers/pci/pcie/Kconfig
>> @@ -46,14 +46,6 @@ config PCIEASPM
>>
>>         When in doubt, say Y.
>>
>> -config PCIEASPM_DEBUG
>> -     bool "Debug PCI Express ASPM"
>> -     depends on PCIEASPM
>> -     default n
>> -     help
>> -       This enables PCI Express ASPM debug support. It will add per-device
>> -       interface to control ASPM.
>> -
>>  choice
>>       prompt "Default ASPM policy"
>>       default PCIEASPM_DEFAULT
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index c687c817b47d..8ffc13d42baa 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -1161,7 +1161,6 @@ static int pcie_aspm_get_policy(char *buffer, const struct kernel_param *kp)
>>  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
>>       NULL, 0644);
>>
>> -#ifdef CONFIG_PCIEASPM_DEBUG
>>  static ssize_t link_state_show(struct device *dev,
>>               struct device_attribute *attr,
>>               char *buf)
>> @@ -1264,7 +1263,6 @@ void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
>>               sysfs_remove_file_from_group(&pdev->dev.kobj,
>>                       &dev_attr_clk_ctl.attr, power_group);
>>  }
>> -#endif
>>
>>  static int __init pcie_aspm_disable(char *str)
>>  {
>> --
>> 2.17.0.441.gb46fe60e1d-goog
>>
