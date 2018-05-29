Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967516AbeE2VVE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:21:04 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45802 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966946AbeE2VU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:20:59 -0400
X-Google-Smtp-Source: ADUXVKIye5USyjX8GB/e7J3t1EEGKURZxSg2F14zcWzbILFLy4g8SN7vVn9D84y+AclPyygiBIBv6DPEG+X3sYf6p6o=
MIME-Version: 1.0
In-Reply-To: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 May 2018 00:20:57 +0300
Message-ID: <CAHp75Vd9kiyOaSbaK6c4b7ucF23kgP0yQxKpUAGrjHgKfJprXA@mail.gmail.com>
Subject: Re: [PATCH] PCI: hv: Do not wait forever on a device that has disappeared
To: Dexuan Cui <decui@microsoft.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 12:12 AM, Dexuan Cui <decui@microsoft.com> wrote:
>
> Before the guest finishes the device initialization, the device can be
> removed anytime by the host, and after that the host won't respond to
> the guest's request, so the guest should be prepared to handle this
> case.

> +       while (true) {
> +               if (hdev->channel->rescind) {
> +                       dev_warn_once(&hdev->device, "The device is gone.\n");
> +                       return -ENODEV;
> +               }
> +
> +               if (wait_for_completion_timeout(comp, HZ / 10))
> +                       break;
> +       }

Infinite loops are usually a red flags.

What's wrong with simple:

do {
  ...
} while (wait_...(...) == 0);

?

> +       if (!ret)
> +               ret = wait_for_response(hdev, &comp);

Better to use well established patterns, i.e.

if (ret)
 return ret;

> +               if (!ret)
> +                       ret = wait_for_response(hdev, &comp_pkt.host_event);

Here it looks okay on the first glance, but better to think about it
again and refactor.

-- 
With Best Regards,
Andy Shevchenko
