Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeCMP6Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:58:24 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33261 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932425AbeCMP6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:58:13 -0400
X-Google-Smtp-Source: AG47ELuJRrJ1lgd8ig8GPetdfFGDFCNpa8ImY0uzOK0kT44IVArry953tmdPJAAKwnbVRJc3sh97BMlGOS3qaxGTzMg=
MIME-Version: 1.0
In-Reply-To: <9efcdfa1-9da3-f4de-749f-0950d20a5758@linux.intel.com>
References: <CS1PR84MB01182561B15688095C4DBF30F6D80@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
 <9efcdfa1-9da3-f4de-749f-0950d20a5758@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 17:58:11 +0200
Message-ID: <CAHp75VdYG+i+m12yotuUa2JwW4ndMMXTV0ZSs_qOS5EAw7=M4w@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/platform/x86: Fix count of CHas on
 multi-pci-segment arches
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: "Kroening, Gary" <gary.kroening@hpe.com>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Travis, Mike" <mike.travis@hpe.com>,
        "Banman, Andrew" <abanman@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 3:42 AM, Liang, Kan <kan.liang@linux.intel.com> wrote:

> +#define SKX_CAPID6             0x9c
> +#define SKX_CHA_BIT_WIDTH      28
> +
>  static int skx_count_chabox(void)
>  {
> +       struct pci_dev *dev = NULL;
> +       u32 val = 0;
>

> +       dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x2083, dev);
> +       if (!dev)
> +               return 0;

Where is pci_dev_put()?

>
> +       pci_read_config_dword(dev, SKX_CAPID6, &val);
> +       return bitmap_weight((unsigned long *)&val, SKX_CHA_BIT_WIDTH);

UB is here.
Fix is simple, use unsigned long and drop this ugly casting.

>  }

-- 
With Best Regards,
Andy Shevchenko
