Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbeCMRqw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:46:52 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:46112 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeCMRqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:46:50 -0400
X-Google-Smtp-Source: AG47ELuidZBlZktlOSseozoS67no2u1IaM1siaGW4vSkSp3UKNQihmoK4BBZbXoGvNfgzKB5tiyGn3nHKb2pCHKTxBI=
MIME-Version: 1.0
In-Reply-To: <f452e41a-533f-60d5-2e19-9bdbcdc16396@linux.intel.com>
References: <CS1PR84MB01182561B15688095C4DBF30F6D80@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
 <9efcdfa1-9da3-f4de-749f-0950d20a5758@linux.intel.com> <CAHp75VdYG+i+m12yotuUa2JwW4ndMMXTV0ZSs_qOS5EAw7=M4w@mail.gmail.com>
 <55123ef5-3287-d4c9-4499-62140c598474@linux.intel.com> <f452e41a-533f-60d5-2e19-9bdbcdc16396@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 19:46:49 +0200
Message-ID: <CAHp75VcgF11Y5RHFriu+fcuyzRdtGzcVWX5OK5yfOwhoKXS+Eg@mail.gmail.com>
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

>>>> +       pci_read_config_dword(dev, SKX_CAPID6, &val);
>>>> +       return bitmap_weight((unsigned long *)&val, SKX_CHA_BIT_WIDTH);
>>>
>>>
>>> UB is here.
>>> Fix is simple, use unsigned long and drop this ugly casting.
>>>
>
> Just noticed that we have to do casting anyway.

No.

> pci_read_config_dword uses u32.
> bitmap_weight uses unsigned long.

...which would lead to UB.

So,

unsigned long bits;
u32 value;

...(..., &value);
bits = value;
...(&bits, ...);

-- 
With Best Regards,
Andy Shevchenko
