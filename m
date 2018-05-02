Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeEBMiO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:38:14 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35827 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbeEBMiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:38:11 -0400
X-Google-Smtp-Source: AB8JxZojlF5dBqBE6U0ONH5+nCExM2GSBKgtJ0hKtqZWELQoqpvE+vcDHH9avce3ErXlewZiPIn2oA==
Message-ID: <1525264687.14025.20.camel@arista.com>
Subject: Re: [PATCHv4 2/2] iommu/vt-d: Limit number of faults to clear in
 irq handler
From: Dmitry Safonov <dima@arista.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
        joro@8bytes.org, "Raj, Ashok" <ashok.raj@intel.com>
Cc: 0x7f454c46@gmail.com, Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        iommu@lists.linux-foundation.org
Date: Wed, 02 May 2018 13:38:07 +0100
In-Reply-To: <5AE95BFF.5040306@linux.intel.com>
References: <20180331003312.6390-1-dima@arista.com>
         <20180331003312.6390-2-dima@arista.com> <5AE95BFF.5040306@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

On Wed, 2018-05-02 at 14:34 +0800, Lu Baolu wrote:
> Hi,
> 
> On 03/31/2018 08:33 AM, Dmitry Safonov wrote:
> > Theoretically, on some machines faults might be generated faster
> > than
> > they're cleared by CPU.
> 
> Is this a real case?

No. 1/2 is a real case and this one was discussed on v3:
lkml.kernel.org/r/<20180215191729.15777-1-dima@arista.com>

It's not possible on my hw as far as I tried, but the discussion result
was to fix this theoretical issue too.

> 
> >  Let's limit the cleaning-loop by number of hw
> > fault registers.
> 
> Will this cause the fault recording registers full of faults, hence
> new faults will be dropped without logging?

If faults come faster then they're being cleared - some of them will be
dropped without logging. Not sure if it's worth to report all faults in
such theoretical(!) situation.
If amount of reported faults for such situation is not enough and it's
worth to keep all the faults, then probably we should introduce a
workqueue here (which I did in v1, but it was rejected by the reason
that it will introduce some latency in fault reporting).

> And even worse, new faults will not generate interrupts?

They will, we clear page fault overflow outside of the loop, so any new
fault will raise interrupt, iiuc.

-- 
Thanks,
             Dmitry
